From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Opening dev/dsp takes very long
Date: Sat, 20 Mar 2004 18:12:38 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403201811280.1816@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0403160917290.14608-100000@studcom.urz.uni-halle.de>
 <4056BF90.2060005@gmx.de> <405AE7B8.6080603@gmx.de> <405B6CFD.9070303@gmx.de>
 <405B88B1.3070204@superbug.demon.co.uk> <405BFEB2.9040402@gmx.de>
 <Pine.LNX.4.58.0403201420340.1816@pnote.perex-int.cz>
 <Pine.OSF.4.58.0403201910360.119382@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.OSF.4.58.0403201910360.119382@kosh.hut.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 20 Mar 2004, Tommi Sakari Uimonen wrote:

> > It's related to the snd-ice1712 driver and hardware which has the cs8427
> > transciever. I've added cs8427_timeout module option, so you can
> 
> I have M-Audio Audiophile and suffer from this also, but I'm not sure if
> it has cs8427.

It has this chip, too.

> If I'm not totally wrong, the earlier 0.9 series didn't suffer from this,
> but it's long time ago so can't remember.

Yes, I added the workaround which causes this behaviour for
the transmitter bug in those days.

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
