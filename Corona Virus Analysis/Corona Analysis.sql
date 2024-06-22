
-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values
SELECT 
    SUM(CASE WHEN Province IS NULL THEN 1 ELSE 0 END) AS Province_nulls,
    SUM(CASE WHEN Country_Region IS NULL THEN 1 ELSE 0 END) AS Country_Region_nulls,
    SUM(CASE WHEN Latitude IS NULL THEN 1 ELSE 0 END) AS Latitude_nulls,
    SUM(CASE WHEN Longitude IS NULL THEN 1 ELSE 0 END) AS Longitude_nulls,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Date_nulls,
    SUM(CASE WHEN Confirmed IS NULL THEN 1 ELSE 0 END) AS Confirmed_nulls,
    SUM(CASE WHEN Deaths IS NULL THEN 1 ELSE 0 END) AS Deaths_nulls,
    SUM(CASE WHEN Recovered IS NULL THEN 1 ELSE 0 END) AS Recovered_nulls
FROM covid_data;

--Q2. If NULL values are present, update them with zeros for all columns. 
No nulls 
-- Q3. check total number of rows
SELECT COUNT(*) AS total_rows FROM covid_data;

-- Q4. Check what is start_date and end_date
SELECT MIN(Date) AS start_date, MAX(Date) AS end_date FROM covid_data;

-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT DATE_TRUNC('month', Date)) AS num_months FROM covid_data;

-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT
    DATE_TRUNC('month', Date) AS month,
    AVG(Confirmed) AS avg_confirmed,
    AVG(Deaths) AS avg_deaths,
    AVG(Recovered) AS avg_recovered
FROM covid_data
GROUP BY month
ORDER BY month;

-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
SELECT
    month,
    mode() WITHIN GROUP (ORDER BY Confirmed) AS most_frequent_confirmed,
    mode() WITHIN GROUP (ORDER BY Deaths) AS most_frequent_deaths,
    mode() WITHIN GROUP (ORDER BY Recovered) AS most_frequent_recovered
FROM (
    SELECT
        DATE_TRUNC('month', Date) AS month,
        Confirmed,
        Deaths,
        Recovered
    FROM covid_data
) AS subquery
GROUP BY month
ORDER BY month;

-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT
    DATE_TRUNC('year', Date) AS year,
    MIN(Confirmed) AS min_confirmed,
    MIN(Deaths) AS min_deaths,
    MIN(Recovered) AS min_recovered
FROM covid_data
GROUP BY year
ORDER BY year;

-- Q9. Find minimum values for confirmed, deaths, recovered per year
SELECT
    DATE_TRUNC('year', Date) AS year,
    MAX(Confirmed) AS max_confirmed,
    MAX(Deaths) AS max_deaths,
    MAX(Recovered) AS max_recovered
FROM covid_data
GROUP BY year
ORDER BY year;


-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT
    DATE_TRUNC('month', Date) AS month,
    SUM(Confirmed) AS total_confirmed,
    SUM(Deaths) AS total_deaths,
    SUM(Recovered) AS total_recovered
FROM covid_data
GROUP BY month
ORDER BY month;

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
    SUM(Confirmed) AS total_confirmed,
    AVG(Confirmed) AS avg_confirmed,
    VARIANCE(Confirmed) AS variance_confirmed,
    STDDEV(Confirmed) AS stdev_confirmed
FROM covid_data;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
    DATE_TRUNC('month', Date) AS month,
    SUM(Deaths) AS total_deaths,
    AVG(Deaths) AS avg_deaths,
    VARIANCE(Deaths) AS variance_deaths,
    STDDEV(Deaths) AS stdev_deaths
FROM covid_data
GROUP BY month
ORDER BY month;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
    SUM(Recovered) AS total_recovered,
    AVG(Recovered) AS avg_recovered,
    VARIANCE(Recovered) AS variance_recovered,
    STDDEV(Recovered) AS stdev_recovered
FROM covid_data;

-- Q14. Find Country having highest number of the Confirmed case
SELECT Country_Region
FROM covid_data
GROUP BY Country_Region
ORDER BY SUM(Confirmed) DESC
LIMIT 1;

-- Q15. Find Country having lowest number of the death case
SELECT Country_Region
FROM covid_data
GROUP BY Country_Region
ORDER BY SUM(Deaths) ASC
LIMIT 1;

-- Q16. Find top 5 countries having highest recovered case
SELECT Country_Region
FROM covid_data
GROUP BY Country_Region
ORDER BY SUM(Recovered) DESC
LIMIT 5;
