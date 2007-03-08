From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RFC: Add support for monotonic clock for 2.6
Date: Thu, 8 Mar 2007 07:57:01 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0703080752490.7542@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0702271533590.9439@tm8103-a.perex-int.cz>
	<s5hirdcbsty.wl%tiwai@suse.de> <45EF3DB5.3090008@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [212.20.107.50])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ECF5727E
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2007 07:57:02 +0100 (MET)
In-Reply-To: <45EF3DB5.3090008@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 7 Mar 2007, James Courtier-Dutton wrote:

> Takashi Iwai wrote:
> > At Tue, 27 Feb 2007 15:52:41 +0100 (CET),
> > Jaroslav Kysela wrote:
> > > Hi,
> > > 
> > > 	in 2.6 kernels, we can use ktime_get_ts() function to get
> > > monotonic time which can be used for PCM timestamps. I would propose
> > > to reuse the SNDRV_PCM_IOCTL_TSTAMP ioctl to enable using of
> > > monotonic clock.
> > > The "enable" (int) argument might mean:
> > > 
> > > 0: standard clock - getnstimeofday()
> > > 1: standard clock - getnstimeofday() - for "compatibility"
> > > 2: monotonic clock - ktime_get_ts()
> > 
> > Good to add a new feature...  but is there any user of this PCM
> > timestamp so far?  I see some good purposes but rarely seen in the
> > reality, unfortunately...
> > 
> > 
> > Takashi
> > 
> 
> There are some good applications for it, but I have not got round to writing
> them yet!

I'd like to use these timestamps to do jitter (sample rate) corrections 
among multiple soundcards. Unfortunately, because gettimeofday is not 
monotonic, the timestamps are not accurate enough. Also, direct plugins 
might use these timestamps to do more accurate stream start.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
