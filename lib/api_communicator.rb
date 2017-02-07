require 'rest-client'
require 'json'
require 'pry'


#character_data = RestClient.get('http://swapi.co/api/people/1')

#puts character_data

def get_character_movies_from_api(character)
  
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  #parse the data
  character_hash = JSON.parse(all_characters)
  #empty array for our films
  films_hash = []
  #use this for indexing
  array_size = 0
  #full hash loop
  character_hash["results"].each do |person|
    #get our character by name
    person.each do |k,v|
      #if we have a match
      if person[k] == character
        films_array = person["films"]
        films_array.each do |film|
           #API Call each film URL
            full_hash = RestClient.get(film)
            #organize it
            film_data = JSON.parse(full_hash)
            #add it to the array above
            films_hash[array_size] = film_data 
            #increase by 1
            array_size += 1
        end
      end
    end
  end
  #return our array of film hashes
  return films_hash
end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

def parse_character_movies(films_hash)
    i = 0
    empty = []
    films_hash.each do |film|
      film.each do |k,v|
        if k == "title"
          puts "#{i}. #{v}" 
          #empty[i] = v
          i += 1
        end
      end
    end
    return
# some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?