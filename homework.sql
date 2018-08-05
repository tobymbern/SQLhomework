/* ------------------------1a-----------------------------------*/

SELECT *
FROM actor;

/* ------------------------1b-----------------------------------*/

SELECT CONCAT_WS(' ', first_name, last_name) AS Actor_Names
FROM actor;

/* --------------------------2a---------------------------------*/

SELECT *
FROM actor
WHERE first_name = 'JOE';

/* --------------------------2b---------------------------------*/
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

/* --------------------------2c---------------------------------*/
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE '%LI%';

/* --------------------------2d---------------------------------*/
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');



/* --------------------------3a---------------------------------*/

ALTER TABLE actor
  ADD middle_name VARCHAR(50); /* all the forums said specifically positioning columns was impossible without
  creating a new table, so I skipped that part */

/* --------------------------3b---------------------------------*/

ALTER TABLE actor
DROP COLUMN middle_name;

ALTER TABLE actor
  ADD middle_name BLOB;
  
/* --------------------------3c---------------------------------*/

ALTER TABLE actor
DROP COLUMN middle_name;

/* --------------------------4a------------------------------*/                                                       

SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

/* --------------------------4b------------------------------*/                                                       


SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

/* --------------------------4c------------------------------*/                                                       


SELECT *
FROM actor; /* Manually looking up GROUCHO WILLIAMS actor_id */

UPDATE actor
SET  first_name = 'HARPO' 
WHERE actor_id = 172;

/* --------------------------4d------------------------------*/                                                       


UPDATE actor
SET  first_name = 'GROUCHO' 
WHERE first_name = 'HARPO'; 

/* --------------------------Q5a------------------------------*/  

SHOW CREATE TABLE address;

/* --------------------------6a------------------------------*/  

SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address
	ON staff.address_id = address.address_id;

/* --------------------------6b------------------------------*/

SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS 'Total Sold'
FROM staff 
JOIN payment  
	ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '2005-08%'
GROUP BY 1, 2;

/* --------------------------6c------------------------------*/

SELECT film.title AS 'Film Title', COUNT(film_actor.actor_id) AS 'Number of Films'
FROM film
INNER JOIN film_actor 
	ON film.film_id = film_actor.film_id
GROUP BY film.title;

/* --------------------------6d------------------------------*/

SELECT film.film_id
FROM film
WHERE film.title = 'HUNCHBACK IMPOSSIBLE'; /* get HUNCHBACK IMPOSSIBLE film_id, answer 439*/


SELECT COUNT(inventory.film_id)
FROM inventory
WHERE inventory.film_id = 439; /* answer: 6 HUNBACK IMPOSSIBLE in inventory*/


/* --------------------------6e------------------------------*/

SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS 'Total Paid'
FROM customer
JOIN payment 
	ON customer.customer_id = payment.customer_id
GROUP BY customer.first_name, customer.last_name
ORDER BY customer.last_name;


/* --------------------------7a------------------------------*/

SELECT title
FROM film
WHERE title LIKE 'K%' 
	OR title LIKE 'Q%'
AND language_id = (SELECT language_id 
				   FROM language 
                   WHERE name='English');

/* --------------------------7b------------------------------*/ 


SELECT first_name, last_name
FROM actor
WHERE actor_id
	IN (SELECT actor_id 
		FROM film_actor 
        WHERE film_id 
		IN (SELECT film_id 
			FROM film 
            WHERE title= 'ALONE TRIP'));


/* --------------------------7c------------------------------*/

SELECT first_name, last_name, email, country
FROM customer
JOIN address 
	ON (customer.address_id = address.address_id)
JOIN city 
	ON (address.city_id = city.city_id)
JOIN country 
	ON (city.country_id = country.country_id)
WHERE country = 'Canada';


/* --------------------------7d------------------------------*/

SELECT title AS 'Family Films'
FROM film
JOIN film_category 
	ON (film.film_id = film_category.film_id)
JOIN category 
	ON (film_category.category_id = category.category_id)
WHERE category.name = 'Family';


/* --------------------------7e------------------------------*/


SELECT title, COUNT(film.film_id) AS 'Times Rented'
FROM  film
JOIN inventory 
	ON (film.film_id = inventory.film_id)
JOIN rental 
	ON (inventory.inventory_id = rental.inventory_id)
GROUP BY title 
ORDER BY 2 DESC;


/* --------------------------7f------------------------------*/

SELECT store.store_id, SUM(payment.amount) AS 'Total Store Sales'
FROM payment
JOIN staff 
	ON (payment.staff_id = staff.staff_id)
JOIN store
	ON (staff.store_id = store.store_id)
GROUP BY store_id;


/* --------------------------7g------------------------------*/


SELECT store_id, city, country 
FROM store
JOIN address 
	ON (store.address_id = address.address_id)
JOIN city 
	ON (address.city_id = city.city_id)
JOIN country 
	ON (city.country_id = country.country_id);

/* --------------------------7h------------------------------*/

SELECT category.name AS 'Top Five Genres', SUM(payment.amount) AS 'Gross' 
FROM category 
JOIN film_category 
	ON (category.category_id = film_category.category_id)
JOIN inventory 
	ON (film_category.film_id = inventory.film_id)
JOIN rental 
	ON (inventory.inventory_id = rental.inventory_id)
JOIN payment 
	ON (rental.rental_id = payment.rental_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


/* --------------------------8a------------------------------*/


CREATE VIEW sakila.vTopGenres
AS 
SELECT category.name AS 'Top Five Genres', SUM(payment.amount) AS 'Gross' 
FROM category 
JOIN film_category 
	ON (category.category_id = film_category.category_id)
JOIN inventory 
	ON (film_category.film_id = inventory.film_id)
JOIN rental 
	ON (inventory.inventory_id = rental.inventory_id)
JOIN payment 
	ON (rental.rental_id = payment.rental_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
 

/* --------------------------8b------------------------------*/


SELECT * 
FROM vTopGenres;

/* --------------------------8c------------------------------*/


DROP VIEW vTopGenres;












