From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] emu10k1: add interval timer support
Date: Fri, 17 Sep 2004 10:59:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
References: <1095405566.19045.35.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1095405566.19045.35.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, tiwai@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, 17 Sep 2004, Lee Revell wrote:

> This patch adds the necessary functions to support the emu10k1's
> interval timer.  The interval timer is the mechanism used by every other
> known emu10k1 driver to generate the period interrupts for playback. 
> These are ported from the OSS driver.

1) please, make snd_emu10k1_timer_set() function inlined
2) use atomic bitops for timer->state and make also enable/disable
   functions inlined
3) I don't like so much proposed scheduling as I stated in my previous 
   e-mails; you cannot guarantee the right period boundary acknowledge
   at all - there will be always some additional delay when more than one
   stream is activated
4) the more appropriate place for the card's timer is timer API
5) multichannel PCM should be created rather trying to do ugly things with
   timer

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
