From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: add interval timer support
Date: Thu, 04 Nov 2004 14:13:10 -0500
Message-ID: <1099595591.1617.55.camel@krustophenia.net>
References: <1095405566.19045.35.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
	 <1099511035.1617.32.camel@krustophenia.net>
	 <Pine.LNX.4.58.0411041759220.4510@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411041759220.4510@pnote.perex-int.cz>
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

On Thu, 2004-11-04 at 18:05 +0100, Jaroslav Kysela wrote:
> On Wed, 3 Nov 2004, Lee Revell wrote:
> 
> > OK I converted this code to use the ALSA timer API.  This seems to work
> > fine, I can access the timer from userspace.  However there does not
> > seem to be an existing example of a driver that uses the ALSA timer API
> > internally; all the drivers that use the interval timer internally for
> > PCM period interrupts have open coded timer handling.  AFAICT the ALSA
> > timer API should be OK for this purpose as well.  Is this correct?
> 
> Yes, you can use ALSA timers from kernel space as well.
> 

OK.  It looks like the only current example is in the sequencer.  But
this should be good enough.

> > I am going to use the interval timer for multichannel PCM playback.
> > This works by allocating 16 voices, setting loop stop on all of them,
> > then setting the timer.  In the first timer interrupt we clear loop stop
> > on all the voices with one PCI write, then re-arm the timer, and set the
> > PCM running; we now have 16 voices in perfect sync.  Subsequent timer
> > interrupts just call snd_pcm_period_elapsed.
> 
> If timer must be re-armed in the interrupt handler, then you have a 
> problem - time shifting when the timer ack interrupt is delayed. So you 
> must do a time correction.
> 

I was planning to use the emu10k1's wallclock timer for this.

> > The above scheme could also work with an extra voice for timing but
> > would be uglier.  Since the multichannel device does not have to support
> > multiple open, and only 48KHZ playback, the timer seems to be a much
> > cleaner solution.  Regular PCM playback will continue to use the extra
> > voice.
> 
> The only one drawback is the possible delay at stream start (up to one 
> period).

Should not be a problem as this device is intended for use by JACK.

I did notice that alsa-lib/test/timer.c looks like it misses the 
first tick about half the time:

rlrevell@mindpipe:~/cvs$ ~/cvs/alsa-T3/alsa-lib/test/timer class 2, sclass 0, card 0, device 0, subdevice 0
Using timer class 2, slave class 0, card 0, device 0, subdevice 0
Timer info:
  slave = no
  card = 0
  id = 'EMU10K1'
  name = 'EMU10K1 timer'
  average resolution = 20833
Using 960 tick(s)
STATUS:
  resolution = 20833
  lost = 0
  overrun = 0
  queue = 0
TIMER: resolution = 20833ns, ticks = 1920 <--
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960

...

Using 960 tick(s)
STATUS:
  resolution = 20833
  lost = 0
  overrun = 0
  queue = 0
TIMER: resolution = 20833ns, ticks = 960 <--
TIMER: resolution = 20833ns, ticks = 960
TIMER: resolution = 20833ns, ticks = 960

The header file mentions that when the emu10k1's timer rate is changed
you must allow 1024 sample periods before the new rate is accurate.  It
looks like SNDRV_TIMER_HW_FIRST is the answer, but this did not have any
effect.

-- 
Lee Revell <rlrevell@joe-job.com>



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
