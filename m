From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/core/oss
 mixer_oss.c,1.38,1.39
Date: Thu, 10 Mar 2005 10:42:04 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503101036190.20935-100000@studcom.urz.uni-halle.de>
References: <1110399750.10129.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1110399750.10129.1.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> > Clemens Ladisch wrote:
> > > Summary: fix forgotten release of semaphore in error path
> > >
> > > In snd_mixer_oss_get_volume1_vol and snd_mixer_oss_put_volume1_vol,
> > > card->controls_rwsem wouldn't be released if the boolean type
> > > check fails.
>
> Clemens, should this patch fix OSDL bug 4282?  You mentioned that was
> related to a forgotten semaphore release in the same code.

Neither this fix nor my earlier one in snd_mixer_oss_build_input looks
like it could be related to that bug.  A semaphore that wasn't
released would result in a deadlock, not in a crash.

I would guess that the bug is caused by using something that hasn't
been initialized yet.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
