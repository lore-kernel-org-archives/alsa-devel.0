From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: valgrind and alsa
Date: Fri, 25 Feb 2005 09:16:47 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502250914540.19356-100000@studcom.urz.uni-halle.de>
References: <421D9482.3090807@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <421D9482.3090807@cs.ubc.ca>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Charles \"Buck\" Krasic" <krasic@cs.ubc.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Charles "Buck" Krasic wrote:
> When checking my application with valgrind,  valgrin generates numerous
> alsa related warnings.   They all seem to originate from a single
> problem in my initial call to snd_pcm_writei.  Basically valgrind
> doesn't like that alsa is making an ioctl with unitialized data.

valgrind's heuristic is wrong in this case (the result field is
initialized by the ioctl).  Use the --weird-hacks=lax-ioctls option.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
