From: Lee Revell <rlrevell@joe-job.com>
Subject: "Unexpected hw_pointer value - wrong interrupt acknowledge?" with
 emu10k1
Date: Mon, 12 Jul 2004 20:38:05 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1089679085.10777.83.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> On Sun, 2004-07-11 at 01:25, Andrew Morton wrote:
> > What we need to do is to encourage audio testers to use ALSA drivers, to
> > enable CONFIG_SND_DEBUG in the kernel build and to set
> > /proc/asound/*/*/xrun_debug and to send us the traces which result from
> > underruns.
> > 
> 
> OK, here goes.  The following traces result from running JACK overnight
> like so, on an otherwise idle system.  Hardware is a VIA EPIA 6000, with
> a 600Mhz C3 processor.  Kernel is 2.6.7 + volunatary_preempt patch. 
> voluntary_preempt and kernel_preemption are both on.
> 
> jackd -v --realtime -d alsa --outchannels 2 --rate 48000 --shorts
> --playback --period 32  --nperiods 2
> 
> These settings require less than 666 microseconds scheduler latency. 
> The average performance is quite good - 5-20 *microseconds*!
> 

While running the above test, I also noticed these messages from the
ALSA driver.  These messages did not occur during the overnight test;
they began when I sat down at the console to check the results.

Jul 12 17:31:43 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -16, max jitter = 32): wrong interrupt acknowledge?
Jul 12 17:31:43 mindpipe kernel:  [__crc_totalram_pages+1386981/5353478] snd_pcm_period_elapsed+0x1af/0x410 [snd_pcm]
Jul 12 17:31:43 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:31:43 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:31:43 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:31:43 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:31:43 mindpipe kernel:  [__do_softirq+48/144] __do_softirq+0x30/0x90
Jul 12 17:31:43 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 17:31:43 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 17:31:43 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:31:43 mindpipe kernel:
Jul 12 17:31:43 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -31, max jitter = 32): wrong interrupt acknowledge?
Jul 12 17:31:43 mindpipe kernel:  [__crc_totalram_pages+1386981/5353478] snd_pcm_period_elapsed+0x1af/0x410 [snd_pcm]
Jul 12 17:31:43 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:31:43 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:31:43 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:31:43 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:31:43 mindpipe kernel:
Jul 12 17:31:43 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199: Unexpected hw_pointer value [1] (stream = 0, delta: -25, max jitter = 32): wrong interrupt acknowledge?
Jul 12 17:31:43 mindpipe kernel:  [__crc_totalram_pages+1386981/5353478] snd_pcm_period_elapsed+0x1af/0x410 [snd_pcm]
Jul 12 17:31:43 mindpipe kernel:  [do_timer+254/272] do_timer+0xfe/0x110
Jul 12 17:31:43 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 12 17:31:43 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 12 17:31:43 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 12 17:31:43 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:31:43 mindpipe kernel:  [__crc_totalram_pages+696339/5353478] rhine_timer+0x8d/0x130 [via_rhine]
Jul 12 17:31:43 mindpipe kernel:  [__crc_totalram_pages+696198/5353478] rhine_timer+0x0/0x130 [via_rhine]
Jul 12 17:31:43 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 12 17:31:43 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 12 17:31:43 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 12 17:31:43 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 12 17:31:43 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 12 17:31:43 mindpipe kernel:

Lee




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
