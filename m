From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RFC: Add support for monotonic clock for 2.6
Date: Thu, 8 Mar 2007 08:01:03 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0703080758570.7542@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0702271533590.9439@tm8103-a.perex-int.cz>
	<s5hirdcbsty.wl%tiwai@suse.de> <45EF3DB5.3090008@superbug.co.uk>
	<s5hejo0brg8.wl%tiwai@suse.de> <45EF44B4.9080200@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [212.20.107.50])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 51DE727A
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2007 08:01:05 +0100 (MET)
In-Reply-To: <45EF44B4.9080200@superbug.co.uk>
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
> > At Wed, 07 Mar 2007 22:33:25 +0000,
> > James Courtier-Dutton wrote:
> > > Takashi Iwai wrote:
> > > > At Tue, 27 Feb 2007 15:52:41 +0100 (CET),
> > > > Jaroslav Kysela wrote:
> > > > > Hi,
> > > > > 
> > > > > 	in 2.6 kernels, we can use ktime_get_ts() function to
> > > > > get monotonic time which can be used for PCM timestamps. I
> > > > > would propose to reuse the SNDRV_PCM_IOCTL_TSTAMP ioctl to
> > > > > enable using of monotonic clock.
> > > > > The "enable" (int) argument might mean:
> > > > > 
> > > > > 0: standard clock - getnstimeofday()
> > > > > 1: standard clock - getnstimeofday() - for "compatibility"
> > > > > 2: monotonic clock - ktime_get_ts()
> > > > Good to add a new feature...  but is there any user of this PCM
> > > > timestamp so far?  I see some good purposes but rarely seen in
> > > > the
> > > > reality, unfortunately...
> > > > 
> > > > 
> > > > Takashi
> > > > 
> > > There are some good applications for it, but I have not got round to
> > > writing them yet!
> > 
> > Me too ;)  But, I remember some difficulties regarding the
> > timestamping at the last time I tried (quite ago).  The timestamp is
> > somewhat hard to use because it's updated at each pointer or status
> > update although I wanted to get the exact time only at the period
> > boundary.  Maybe these usability issues should be sorted out all
> > together.
> > 
> > 
> > Takashi
> 
> Yes, timestamp at period boundary would be more useful. I had not looked at
> the current timestamp in enough details. A timestamp generated in the IRQ
> routine would probably be the best. Could the timestamp be attached to a
> particular PCM sample in the buffer. I.e. The app would retrieve the
> timestamp, and be told that that timestamp applies to the sample X samples
> from now, if using the snd_pcm_read() function.

If SNDRV_PCM_TSTAMP_MMAP is set 
(snd_pcm_sw_params_set_tstamp_mode(SND_PCM_TSTAMP_MMAP)) , the timestamp 
is updated at each change of hw_ptr in driver (thus also in the interrupt 
handler).

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
