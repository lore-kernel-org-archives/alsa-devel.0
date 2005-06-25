From: Karsten Jeppesen <karsten@jeppesens.com>
Subject: Re: SOT: xine using Alsa
Date: Fri, 24 Jun 2005 17:50:29 -0700
Message-ID: <42BCAA55.1040605@jeppesens.com>
References: <42BB5AD0.7050009@jeppesens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42BB5AD0.7050009@jeppesens.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OK - I think I found this one out, but I would still like to have some 
from the development team to comment if possible.

Xine opens "default" to play the 2.0 sound of the menu.
When  Xine tries to open "plug:surround51" to play the movie in surround 
sound, then snd_pcm_open returns a device unavailable or resource busy.

I formed the hypothesis that not enough time had passed from closing the 
2.0 stream to opening the 5.1 stream.
First I inserted snd_pcm_drop just before every snd_pcm_close.
That made no difference.
Then I replaced the snd_pcm_open with a
for ( err=-1; err < 0;) {
  err = snd_pcm_open(...)
  if ( err < 0 ) sleep(1);
done
Crude - I know - but it fixes the problem.
Now - my question is:  How would this be done the *correct* way???

Karsten



Karsten Jeppesen wrote:

> Slightly Off Topic.....
>
> The traffic on the xine list is a bit slow, so I am going to see if I 
> can fix this problem myself, but I need a little Alsa assistance:
>
> My question is how you handle this situation:
> The menu system of a DVD is in 2.0 sound
> The movie itself is in 5.1 sound.
> Target is to be using 5.1 sound.
> I assume (not knowing) that 2.0 sound must be played as 2.0 sound.
>
> xine plays the 2.0 sound correctly but once the movie is about to 
> start xine croaks on the 5.1 sound. The error is that snd_pcm_open 
> fails with a "resource busy".
> If I remaster the DVD and remove the soundtrack from the menu, then 
> the 5.1 sound plays fine and correct.
> This smells of that the 2.0 sound is either not done playing, or the 
> 2.0 stream was not closed before the 5.1 is attempted to be opened.
> I simply don't know enough about the Alsa API.
>
> Enlightenment please :-)
>
> Karsten
>



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
