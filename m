From: "Michael Bourgeous" <sts.nitrogen@gmail.com>
Subject: Re: Tascam US-428 USB Problems
Date: Thu, 16 Aug 2007 17:35:15 -0600
Message-ID: <8e4fc8270708161635v8c164e7j311439c2e2f7d3bd@mail.gmail.com>
References: <8e4fc8270708152345k450c8460la0eb17e33d50fdd7@mail.gmail.com>
	<200708161154.49018.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 87B9910381B
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Aug 2007 01:35:16 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so339806fka
	for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2007 16:35:15 -0700 (PDT)
In-Reply-To: <200708161154.49018.fzu@wemgehoertderstaat.de>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/16/07, Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:
> Am Donnerstag, 16. August 2007 schrieb Michael Bourgeous:
> >
> > I hope this reaches the Tascam driver developer...  I have a Tascam
> > US-428 which worked great with my Athlon XP, but does not work at all
> > with my new system, an Athlon 64 X2.  I've tried using the regular
>
> Is it also the alsa-driver-1.0.14rc3, that works on the Athlon XP?
> Please try the vesrion on the X2 that works on the XP.

I am using 1.0.14rc3 on both.

> The Athlon 64 X2 is run in 64Bit Mode?

Yes.

> Erm, I only have uniprocessor machines up to now....
> please switch the Athlon 64 X2 to run with one core only and recheck.

I'll have to try this later.

> Please post the lspci of the new machine.

00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a4)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev f1)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a4)
00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Contro
ller (rev a2)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f3)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev f2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev f3)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev f3)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev f3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev f3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTra
nsport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address
Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Con
troller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscella
neous Control
01:06.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 04)
01:07.0 Multimedia controller: Teralogic Inc TL880-based HDTV/ATSC tuner (rev 13
)
01:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
01:08.1 Input device controller: Creative Labs SB Live! Game Port (rev 0a)
05:00.0 VGA compatible controller: nVidia Corporation G70 [GeForce 7300 GT] (rev
 a1)

On 8/16/07, Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:
> Am Donnerstag, 16. August 2007 schrieb Michael Bourgeous:
> >
> > This leads to question one: Is there any reason to bail out instead of
> > trying to recover from errors?
>
> Audio glitches.

I can appreciate the fact of pro audio that glitchy audio is worse
than no audio, but when the driver bails out, it causes jackd to
crash, and all of the running jackd clients abort without letting me
save settings.  So, in this case, I'd rather be able to save my
settings.  However, I think this may be entirely avoidable in code.
I'll explain more below.

> > question two: what kinds of problems, software or hardware, would lead
> > to a buffer overflow error, and can I fix this in the driver code?
>
> The US-428 is the only device connected to that particular usb-port?

Currently, yes.

> What are the other devices that work?
> Do they also fully utilize usb 1.1 capacity?

My mouse works without dropouts, which obviously doesn't use the full
capacity.  Additionally, a USB mass storage device works, which does
use the full USB 1.1 (or maybe it's 2.0, can't remember).

I have some more information.  I found out that Windows users of the
Tascam experience system BSODs when power management is enabled.  So,
I disabled PowerNow and acpid, and I no longer get the USB error
messages in the syslog or jackd crashes.  This leads me to believe
that something, somewhere in the kernel, is relying upon the CPU cycle
count for timing, and when the CPU switches from 1GHz to 1.8GHz or
2.4GHz, it triggers a buffer overrun.  Whether that's in the usx2y
driver or in the host controller code I don't know.

Still, performance is less than I would expect, with occasional xruns
and hundreds of "delay longer than estimated" messages, when running
at 256 samples latency (the setting I typically use in Windows).  To
the credit of the Linux driver, I'm able to get down to 128 samples (2
periods of 64 frames), but I can only play a few notes at a time in
ZynAddSubFX before it xruns.  Performance is slightly better with
jackdmp, which I modified to fully disable its broken usx2y driver,
but its use is very inconvenient.  I also switched from jackd 102.20
to 103, which doesn't crash when the syslog messages happen.

I'm running a 2.6.20 kernel with full preemption, with the IRQ-xx
process for the USB port set to RT priority 90, SCHED_FIFO.  During
all of these tests, the maximum latency reported in
/proc/sys/preempt_max_latency was 33 usecs.

Mike Bourgeous
