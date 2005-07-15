From: Brian Black <BlackBsd@Mountain.net>
Subject: Re: snd_pcm_writei()  help!
Date: Fri, 15 Jul 2005 14:17:16 -0400
Message-ID: <42D7FDAC.702@Mountain.net>
References: <Pine.HPX.4.33n.0507121023160.11996-100000@studcom.urz.uni-halle.de>
Reply-To: BlackBsd@Mountain.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507121023160.11996-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Clemens Ladisch wrote:
> Brian Black wrote:
> 
>>Sometimes i pass in a size to write and i am getting an error -22
>>(Invalid argument) and sometimes the data writes out correctly.
>>
>>  while ((AlsaCallReturnCode = snd_pcm_writei(PCM_Handle,
>>          ptrCurrentDataPosition, NumberOfSamplesToWrite)) < 0)
> 
> 
> The size is in frames, not samples.
> 
> 
> HTH
> Clemens

Thanks for the reply Clemens,
i had made the changes above to samples (I dont know what i was
thinking. :-) ),  anyways the issue i was having with the -22 had
something to do with setting some software parameters.  by commenting
out all software parameter stuff. it worked well.

Do you have any idea on how i can target certain channels. for example
have a sound play out only the left or right channel?  i cannot find any
documentation on the int he alsa docs.

and if any alsa list admin is reading,
i still have not recieved my digest of the list for over a week, is
their an issue with the alsa daily digest?



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFC1/2sI9Y/1VIS+jgRAni2AJ9iDWk1kYPZsIT+vKMwunW0m6m8PwCg0e5Q
MgZn1zFvj+H2k69rLmQl1+Q=
=Gh/F
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
