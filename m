From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001380]: Scratchy Intel HDA
Date: Fri, 16 Sep 2005 04:03:10 +0200
Message-ID: <54f0ae568b0aeb3098271c1122deba10@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2857B16C
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2005 04:03:10 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1380> 
======================================================================
Reported By:                Varanger
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1380
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu 5.04 "Hoary Hedgehog"
Kernel Version:             Linux 2.6.11-1-686-smp
======================================================================
Date Submitted:             08-30-2005 20:07 CEST
Last Modified:              09-16-2005 04:03 CEST
======================================================================
Summary:                    Scratchy Intel HDA
Description: 
Hello.

I am getting very scratchy audio in my Intel HDA card besides the sound is
very low.

lspci output is:  

0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
High Definition Audio Controller (rev 03)

Reading every article I could have found on the net regarding this
card, I discovered that i needed snd-azx (ALSA 1.0.8 ) or
snd-hda-intel modules (ALSA 1.0.9rc* or later).

I have downloaded every sources from 1.0.8 up to 1.0.10rc1 (including
1.0.9 release candidates) from http://www.alsa-project.org, then built and
installed them.

In all those versions, I have followed this steps:
alsa-driver : ./configure --with-oss=yes --with-cards=hda-intel && make &&
make install
library / oss-lib / utils : ./configure && make && make install

I've looked every on the net and found that I could use position_fix=1
or position_fix=2 to help me  but no good either.

I've tried in Ubuntu, Kubuntu, Debian, even Mandriva 2005 LE and
Fedora Core 4 (using the modules from the kernel) and it's the same
problem in all of them.

The card came with the mainboard Intel 915G (D915GEV or 915GEV)  

more info about my soundcard:

Running: "lspci -v" 

0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
High Definition Audio Controller (rev 03)
        Subsystem: Intel Corp.: Unknown device e200
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at ff43c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [70] #10 [0091]

/proc/sound/version
Advanced Linux Sound Architecture Driver Version 1.0.9b.
Compiled on Jul  7 2005 for kernel 2.6.10-5-686-smp (SMP).

/proc/asound/devices
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC880 Analog [ALC880 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Thanks for the help,
Varanger
======================================================================

----------------------------------------------------------------------
 chrome - 09-16-05 03:35 
----------------------------------------------------------------------
Hi guys,

Same problem on a Sony Vaio VGN-FS71B (Japanese model - I live in Japan).
Distribution is Fedora Core 4, using the 2.6.12-1.1447_FC4 kernel. The
machine is configured with 2GB RAM.

Am willing to try any random drivers to help with fixing this issue, even
stuff that might make the machine kernel panic if that will help :)

I've tried all combinations of dxs_support=2 and position_fix=3, with
different numbers for those flags for good measure. Nothing seems to
work.

Playing an MP3 using XMMS configured with OSS works. This is what I see
when doing so: 

[root@vaio etc]# cat /proc/asound/card0/pcm0p/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 1024
buffer_size: 16384
tick_time: 1000
OSS format: S16_LE
OSS channels: 2
OSS rate: 44100
OSS period bytes: 4096
OSS periods: 16
OSS period frames: 1024

Playing through Rhythmbox which uses Alsa:

[root@vaio etc]# cat /proc/asound/card0/pcm0p/sub0/hw_params
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 1024
buffer_size: 16384
tick_time: 1000

Something interesting there?

Here is some random info about my system:

[root@vaio etc]# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24
10:33:39 2005 UTC).

[root@vaio etc]# cat /proc/asound/devices
  1:       : sequencer
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer

[root@vaio etc]# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC260 Analog [ALC260 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


Full lspci -v:

[root@vaio etc]# lspci -v
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express
Processor to DRAM Controller (rev 03)
        Subsystem: Sony Corporation: Unknown device 81b7
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express
Root Port (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: 90000000-afffffff
        Prefetchable memory behind bridge: c0000000-cfffffff
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
        Capabilities: [a0] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [140] Unknown (5)

00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
High Definition Audio Controller (rev 03)
        Subsystem: Sony Corporation: Unknown device 81bb
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at 80000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 81b9
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 81b9
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 81b9
        Flags: bus master, medium devsel, latency 0, IRQ 3
        I/O ports at 1840 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 81b9
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1860 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: Sony Corporation: Unknown device 81b9
        Flags: bus master, medium devsel, latency 0, IRQ 5
        Memory at 80004000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3)
(prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=06, subordinate=07, sec-latency=32
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: b0000000-b00fffff
        Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 03)
        Subsystem: Sony Corporation: Unknown device 81b9
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Sony Corporation: Unknown device 81b9
        Flags: bus master, medium devsel, latency 0, IRQ 3
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1880 [size=16]

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus
Controller (rev 03)
        Subsystem: Sony Corporation: Unknown device 81b9
        Flags: medium devsel, IRQ 10
        I/O ports at 18a0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0167
(rev a1) (prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 81c2
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at a0000000 (32-bit, non-prefetchable) [size=16M]
        Memory at c0000000 (64-bit, prefetchable) [size=256M]
        Memory at 90000000 (64-bit, non-prefetchable) [size=16M]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [78] Express Endpoint IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [128] Power Budgeting

06:03.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
        Subsystem: Sony Corporation: Unknown device 818f
        Flags: bus master, medium devsel, latency 168, IRQ 10
        Memory at 80005000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=06, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 80400000-807ff000 (prefetchable)
        Memory window 1: 80800000-80bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

06:03.2 FireWire (IEEE 1394): Texas Instruments PCI7x20 1394a-2000 OHCI
Two-Port PHY/Link-Layer Controller (prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 818f
        Flags: bus master, medium devsel, latency 32, IRQ 3
        Memory at b0004000 (32-bit, non-prefetchable) [size=2K]
        Memory at b0000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

06:03.3 Unknown mass storage controller: Texas Instruments PCI7420/PCI7620
Dual Socket CardBus and Smart Card Cont. w/ 1394a-2000 OHCI Two-Port 
PHY/Link-Layer Cont. an
        Subsystem: Sony Corporation: Unknown device 8190
        Flags: medium devsel, IRQ 4
        Memory at b0005000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

06:04.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev
05)
        Subsystem: Intel Corporation: Unknown device 2752
        Flags: medium devsel, IRQ 10
        Memory at b0006000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

06:08.0 Ethernet controller: Intel Corporation 82562ET/EZ/GT/GZ - PRO/100
VE (LOM) Ethernet Controller Mobile (rev 03)
        Subsystem: Sony Corporation: Unknown device 81d0
        Flags: bus master, medium devsel, latency 66, IRQ 7
        Memory at b0007000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 2000 [size=64]
        Capabilities: [dc] Power Management version 2

----------------------------------------------------------------------
 rlrevell - 09-16-05 04:03 
----------------------------------------------------------------------
I think tiwai was mistaken about the dxs_support parameter.  This only
applies to the via82xx driver, not intel-hda.  So you only need to test
position_fix=x where x is 0, 1, 2, and 3.

First, try ALSA CVS or ALSA 1.0.10-rc1.  There have been many bugs fixed
since 1.0.9-rc2.

Then, if it still doesn't work, to verify that it's not a modutils bug,
explicitly do:

rmmod snd-intel-hda
modprobe snd-intel-hda position_fix=0

Then test the sound and repeat with position_fix=1, 2, and 3.

Also, to narrow down the problem, do all testing with XMMS, and switch
back and forth between the ALSA and OSS driver.  Make sure that XMMS is
using the device "default".

If your test results were using Rhythmbox+ALSA and XMMS+OSS to play the
same MP3, then it looks like Rhythmbox might be using "hw:x,x" which is
wrong, as it's reporting the sample rate as 48000 not 44100.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-30-05 20:07 Varanger       New Issue                                    
08-30-05 20:07 Varanger       Distribution              => Ubuntu 5.04 "Hoary
Hedgehog"
08-30-05 20:07 Varanger       Kernel Version            => Linux
2.6.11-1-686-smp
09-08-05 09:27 cventers       Note Added: 0006070                          
09-12-05 19:02 mico           Note Added: 0006149                          
09-12-05 19:04 mico           Note Edited: 0006149                         
09-13-05 18:26 tiwai          Note Added: 0006154                          
09-15-05 19:19 Varanger       Note Added: 0006218                          
09-16-05 03:35 chrome         Note Added: 0006236                          
09-16-05 04:03 rlrevell       Note Added: 0006237                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
