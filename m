From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: add interval timer support
Date: Wed, 03 Nov 2004 14:43:54 -0500
Message-ID: <1099511035.1617.32.camel@krustophenia.net>
References: <1095405566.19045.35.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, tiwai@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-17 at 10:59 +0200, Jaroslav Kysela wrote:
> On Fri, 17 Sep 2004, Lee Revell wrote:
> 
> > This patch adds the necessary functions to support the emu10k1's
> > interval timer.  The interval timer is the mechanism used by every other
> > known emu10k1 driver to generate the period interrupts for playback. 
> > These are ported from the OSS driver.
> 
> 1) please, make snd_emu10k1_timer_set() function inlined
> 2) use atomic bitops for timer->state and make also enable/disable
>    functions inlined
> 3) I don't like so much proposed scheduling as I stated in my previous 
>    e-mails; you cannot guarantee the right period boundary acknowledge
>    at all - there will be always some additional delay when more than one
>    stream is activated
> 4) the more appropriate place for the card's timer is timer API
> 5) multichannel PCM should be created rather trying to do ugly things with
>    timer

OK I converted this code to use the ALSA timer API.  This seems to work
fine, I can access the timer from userspace.  However there does not
seem to be an existing example of a driver that uses the ALSA timer API
internally; all the drivers that use the interval timer internally for
PCM period interrupts have open coded timer handling.  AFAICT the ALSA
timer API should be OK for this purpose as well.  Is this correct?

I am going to use the interval timer for multichannel PCM playback.
This works by allocating 16 voices, setting loop stop on all of them,
then setting the timer.  In the first timer interrupt we clear loop stop
on all the voices with one PCI write, then re-arm the timer, and set the
PCM running; we now have 16 voices in perfect sync.  Subsequent timer
interrupts just call snd_pcm_period_elapsed.

The above scheme could also work with an extra voice for timing but
would be uglier.  Since the multichannel device does not have to support
multiple open, and only 48KHZ playback, the timer seems to be a much
cleaner solution.  Regular PCM playback will continue to use the extra
voice.

-- 
Lee Revell <rlrevell@joe-job.com>



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
