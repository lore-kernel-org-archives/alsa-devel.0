From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Tue, 8 Nov 2005 11:34:27 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0511081121060.9285@tm8103.perex-int.cz>
References: <s5h8xw66pj9.wl%tiwai@suse.de> <20051105204439.41052.qmail@web52902.mail.yahoo.com>
 <s5h1x1srbbh.wl%tiwai@suse.de> <1131394955.8383.96.camel@mindpipe>
 <s5hr79ro32v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr79ro32v.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Chris Rankin <rankincj@yahoo.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 8 Nov 2005, Takashi Iwai wrote:

> At Mon, 07 Nov 2005 15:22:34 -0500,
> Lee Revell wrote:
> > 
> > On Mon, 2005-11-07 at 11:39 +0100, Takashi Iwai wrote:
> > > At Sat, 5 Nov 2005 20:44:39 +0000 (GMT),
> > > Chris Rankin wrote:
> > > > 
> > > > --- Takashi Iwai <tiwai@suse.de> wrote:
> > > > > I want to know whether this happens _without_ snd-rtctimer, but with
> > > > > the very same system.
> > > > 
> > > > My "unalsa" alias works fine if seq_default_timer_device = 0. My machine has also locked up once
> > > > with the new patch and aplaymidi when aplaymidi forced the snd-rtctimer module to autoload.
> > > > However, this time, the machine actually played the MIDI file before locking up.
> > > 
> > > Then, we have to fix rtc.c itself.  The patch is below.  I'll submit
> > > it to stable tree, too, if it works.
> > > BTW, in the latest cvs, rtctimer is disabled because of this bug.
> > 
> > This may not be accepted by the -stable maintainers, it's too big
> > complex.  I've sent them much simpler patches for emu10k1 regressions
> > that got rejected.
> 
> Right.  But this bug is more serious, so let's hope it'll get merged.

I think that it's already merged in Linus's git tree:

commit c3348760aaffd268f7e91b2185999025fdc5607f
tree dc4fd97943a8547189bb025c71321fb67c5fc3c6
parent 1d4ae4a119e5ba711f12b05cdf27f794460add4b
author Takashi Iwai <tiwai@suse.de> Mon, 07 Nov 2005 11:14:57 +0100
committer Jaroslav Kysela <perex@suse.cz> Mon, 07 Nov 2005 11:14:57 +0100

    [PATCH] Fix wrong irq enable via rtc_control()

    rtc_control() may be called in the interrupt context in ALSA rtc-timer
    driver.  The patch fixes the wrong irq enable in rtc.c, and also fixes
    the possible race of bit flags.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
