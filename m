From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_wait()  More details required.
Date: Wed, 24 Mar 2004 09:59:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403240959270.1860@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0403240854480.20041-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA17606
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2004 10:01:07 +0100
In-Reply-To: <Pine.HPX.4.33n.0403240854480.20041-100000@studcom.urz.uni-halle.de>
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

On Wed, 24 Mar 2004, Clemens Ladisch wrote:

> Jaroslav Kysela wrote:
> > On Tue, 23 Mar 2004, Clemens Ladisch wrote:
> > > The following test program shows strange behaviour:
> >
> > Thanks. It's fixed in CVS now.
> 
> The second problem persists, i.e., snd_pcm_wait() returns although the
> pcm isn't actually ready:
> 
> $ ./waittest dmix:hw:0
> 12000 frames written
> pcm is not ready!
> 6000 frames written

Fixed again. I was not able reproduce this problem with some hardware.

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
