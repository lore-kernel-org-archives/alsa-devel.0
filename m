From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_wait()  More details required.
Date: Mon, 22 Mar 2004 11:09:22 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403221107490.1808@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0403221047040.4794-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA31387
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2004 11:14:46 +0100
In-Reply-To: <Pine.HPX.4.33n.0403221047040.4794-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 22 Mar 2004, Clemens Ladisch wrote:

> > I have discovered a problem with xine when using it. I have done a work
> > around in xine so that dmix now works in xine. I think that my
> > assumptions regarding snd_pcm_wait() might have been wrong, so I want to
> > get accurate details from yourselves.
> 
> I think the implementation of dmix is broken in this regard.  If I
> read the code correctly, snd_pcm_direct_poll_revents() returns
> POLLIN/OUT even if the pcm is empty.
> 
> Jaroslav, shouldn't this function reset the events variable when empty
> is set?

No, in case when no timer events are available, the revents should be 
zero from the kernel space, so we don't need to explicitly clear this 
variable.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
