From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: Tascam US-428 USB Problems
Date: Fri, 17 Aug 2007 09:19:37 +0200
Message-ID: <200708170919.37627.fzu@wemgehoertderstaat.de>
References: <8e4fc8270708152345k450c8460la0eb17e33d50fdd7@mail.gmail.com>
	<200708161154.49018.fzu@wemgehoertderstaat.de>
	<8e4fc8270708161635v8c164e7j311439c2e2f7d3bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout2.freenet.de (mout2.freenet.de [195.4.92.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C425103846
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Aug 2007 09:19:03 +0200 (CEST)
In-Reply-To: <8e4fc8270708161635v8c164e7j311439c2e2f7d3bd@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Bourgeous <sts.nitrogen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Freitag, 17. August 2007 schrieb Michael Bourgeous:
> 
> I have some more information.  I found out that Windows users of the
> Tascam experience system BSODs when power management is enabled.  So,
> I disabled PowerNow and acpid, and I no longer get the USB error
> messages in the syslog or jackd crashes.  This leads me to believe
> that something, somewhere in the kernel, is relying upon the CPU cycle
> count for timing, and when the CPU switches from 1GHz to 1.8GHz or
> 2.4GHz, it triggers a buffer overrun.  Whether that's in the usx2y
> driver or in the host controller code I don't know.

Try to only disable cpu speed changes.
You can "preselect" fixed speed by doing i.e.:
	$ echo 1800000>/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	$ echo 1800000>/sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	$ echo 1800000>/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	$ echo 1800000>/sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
Is that enough to stabilize things?

I think the buffer overrun is caused by the cpu not "cooperating" with the
OHCI's DMA during the frequency transitions.

> 
> Still, performance is less than I would expect, with occasional xruns
> and hundreds of "delay longer than estimated" messages, when running
> at 256 samples latency (the setting I typically use in Windows).  To
> the credit of the Linux driver, I'm able to get down to 128 samples (2
> periods of 64 frames), but I can only play a few notes at a time in
> ZynAddSubFX before it xruns.  Performance is slightly better with

USB 1.1 transfers happen at 1ms bounderies. Setting 64Frames/period period
interrupts will happen within 1ms or 2ms distances.
This jitter alone limits the cpu's usability for the sound app to less 
than 50%.
128Frames/period causes interrupts every 2 or 3 ms, so you can use <66%
of the cpu's cycles.
Above is for 2 periods.
I set 128Frames/period, 3periods here.

      Karsten

> jackdmp, which I modified to fully disable its broken usx2y driver,
> but its use is very inconvenient.  I also switched from jackd 102.20
> to 103, which doesn't crash when the syslog messages happen.
> 
> I'm running a 2.6.20 kernel with full preemption, with the IRQ-xx
> process for the USB port set to RT priority 90, SCHED_FIFO.  During
> all of these tests, the maximum latency reported in
> /proc/sys/preempt_max_latency was 33 usecs.
> 
> Mike Bourgeous
> 
> 
