From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] emu10k1: add interval timer support
Date: Thu, 4 Nov 2004 18:05:13 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411041759220.4510@pnote.perex-int.cz>
References: <1095405566.19045.35.camel@krustophenia.net>
 <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
 <1099511035.1617.32.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1099511035.1617.32.camel@krustophenia.net>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, tiwai@suse.cz
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Nov 2004, Lee Revell wrote:

> OK I converted this code to use the ALSA timer API.  This seems to work
> fine, I can access the timer from userspace.  However there does not
> seem to be an existing example of a driver that uses the ALSA timer API
> internally; all the drivers that use the interval timer internally for
> PCM period interrupts have open coded timer handling.  AFAICT the ALSA
> timer API should be OK for this purpose as well.  Is this correct?

Yes, you can use ALSA timers from kernel space as well.

> I am going to use the interval timer for multichannel PCM playback.
> This works by allocating 16 voices, setting loop stop on all of them,
> then setting the timer.  In the first timer interrupt we clear loop stop
> on all the voices with one PCI write, then re-arm the timer, and set the
> PCM running; we now have 16 voices in perfect sync.  Subsequent timer
> interrupts just call snd_pcm_period_elapsed.

If timer must be re-armed in the interrupt handler, then you have a 
problem - time shifting when the timer ack interrupt is delayed. So you 
must do a time correction.

> The above scheme could also work with an extra voice for timing but
> would be uglier.  Since the multichannel device does not have to support
> multiple open, and only 48KHZ playback, the timer seems to be a much
> cleaner solution.  Regular PCM playback will continue to use the extra
> voice.

The only one drawback is the possible delay at stream start (up to one 
period).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
