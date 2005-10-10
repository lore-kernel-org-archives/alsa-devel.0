From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001453]: 2.6.14-rc2 "Unknown model for ALC880"
Date: Mon, 10 Oct 2005 18:35:42 +0200
Message-ID: <adb255c711206769bf1a84f9bf1ee354@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D9A5516F
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2005 18:35:42 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1453> 
======================================================================
Reported By:                honschu
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1453
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian sarge
Kernel Version:             2.6.14-rc2
======================================================================
Date Submitted:             09-24-2005 17:22 CEST
Last Modified:              10-10-2005 18:35 CEST
======================================================================
Summary:                    2.6.14-rc2 "Unknown model for ALC880"
Description: 
I have a Aopen i915Gm-HFS Motherboard with intel-hda chipset.
Sound output (input not) works in kernel 2.6.12.

For Kernel 2.6.14-rc2 I get error on boottime (see below)

If you want me to do tests, feel free to ask.

[...]
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
hda_codec: num_steps = 0 for NID=0x8
hda_codec: num_steps = 0 for NID=0x8
hda_codec: num_steps = 0 for NID=0x8
[...]
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
[...]
hda_codec: num_steps = 0 for NID=0x8
hda_codec: num_steps = 0 for NID=0x8
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0xb
hda_codec: num_steps = 0 for NID=0x8
hda_codec: num_steps = 0 for NID=0x8
[...]

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001429 hda_codec: Unknown model for ALC880
======================================================================

----------------------------------------------------------------------
 tiwai - 10-05-05 18:34 
----------------------------------------------------------------------
Try to pass "model=3stack" module option.

But the warning messages are weird.  They correspond to an ADC and the CD
volume.

----------------------------------------------------------------------
 honschu - 10-10-05 18:35 
----------------------------------------------------------------------
With "model=3stack" the module loads and I can play sound. But sometimes I
think that it doesn't play sound as a accurate stream: It seems to me that
songs sometimes jump forward or reward for some microsecounds.


***************************************
***************************************

$ cat /etc/modprobe.d/sound 
alias snd-card-0 snd-hda-intel
options snd-hda-intel index=0 model=3stack

***************************************
***************************************

$ cat /proc/asound/timers 
G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-0-3: PCM capture 0-0-3 : SLAVE

***************************************
***************************************

$ cat /proc/asound/cards 
0 [Intel          ]: HDA-Intel - HDA Intel
                     HDA Intel at 0xd0540000 irq 18

***************************************
***************************************

$ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).

***************************************
***************************************
$ lspci 
0000:00:00.0 Host bridge: Intel Corp. Mobile Memory Controller Hub (rev 
03)
0000:00:02.0 VGA compatible controller: Intel Corp. Mobile Graphics 
Controller (rev 03)
0000:00:02.1 Display controller: Intel Corp. Mobile Graphics Controller 
(rev 03)
0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High 
Definition Audio Controller (rev 04)
0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
PCI Express Port 1 (rev 04)
0000:00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
PCI Express Port 2 (rev 04)
0000:00:1c.2 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
PCI Express Port 3 (rev 04)
0000:00:1c.3 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
PCI Express Port 4 (rev 04)
0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #1 (rev 04)
0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #2 (rev 04)
0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #3 (rev 04)
0000:00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #4 (rev 04)
0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB2 EHCI Controller (rev 04)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d4)
0000:00:1f.0 ISA bridge: Intel Corp. 82801FBM (ICH6M) LPC Interface 
Bridge (rev 04)
0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) IDE Controller (rev 04)
0000:00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
SMBus Controller (rev 04)
0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd.: Unknown 
device 4362 (rev 19)
0000:03:00.0 Ethernet controller: Marvell Technology Group Ltd.: Unknown 
device 4362 (rev 19)
0000:05:03.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 
61)
0000:05:04.0 Multimedia video controller: Brooktree Corporation Bt878 
Video Capture (rev 11)
0000:05:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio 
Capture (rev 11)

***************************************
***************************************

$lspci -nv

0000:00:00.0 0600: 8086:2590 (rev 03)
        Subsystem: a0a0:2580
        Flags: bus master, fast devsel, latency 0
        Capabilities: <available only to root>

0000:00:02.0 0300: 8086:2592 (rev 03)
        Subsystem: a0a0:0554
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at d0400000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at e000 [size=8]
        Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Memory at d0500000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: <available only to root>

0000:00:02.1 0380: 8086:2792 (rev 03)
        Subsystem: a0a0:0554
        Flags: bus master, fast devsel, latency 0
        Memory at d0480000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: <available only to root>

0000:00:1b.0 0403: 8086:2668 (rev 04)
        Subsystem: a0a0:0560
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at d0540000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <available only to root>

0000:00:1c.0 0604: 8086:2660 (rev 04)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: 00000000-000fffff
        Prefetchable memory behind bridge:
0000000000000000-0000000000000000
        Capabilities: <available only to root>

0000:00:1c.1 0604: 8086:2662 (rev 04)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d0000000-d00fffff
        Capabilities: <available only to root>

0000:00:1c.2 0604: 8086:2664 (rev 04)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: d0100000-d01fffff
        Capabilities: <available only to root>

0000:00:1c.3 0604: 8086:2666 (rev 04)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        Memory behind bridge: 00000000-000fffff
        Prefetchable memory behind bridge:
0000000000000000-0000000000000000
        Capabilities: <available only to root>

0000:00:1d.0 0c03: 8086:2658 (rev 04)
        Subsystem: a0a0:2658
        Flags: bus master, medium devsel, latency 0, IRQ 23
        I/O ports at e100 [size=32]

0000:00:1d.1 0c03: 8086:2659 (rev 04)
        Subsystem: a0a0:2659
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at e200 [size=32]

0000:00:1d.2 0c03: 8086:265a (rev 04)
        Subsystem: a0a0:265a
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at e300 [size=32]

0000:00:1d.3 0c03: 8086:265b (rev 04)
        Subsystem: a0a0:265b
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at e400 [size=32]

0000:00:1d.7 0c03: 8086:265c (rev 04) (prog-if 20)
        Subsystem: a0a0:0553
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at d0544000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>

0000:00:1e.0 0604: 8086:2448 (rev d4) (prog-if 01)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
        Memory behind bridge: d0200000-d02fffff
        Prefetchable memory behind bridge:
00000000d0300000-00000000d0300000
        Capabilities: <available only to root>

0000:00:1f.0 0601: 8086:2641 (rev 04)
        Subsystem: 8086:2641
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 0101: 8086:266f (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: a0a0:266f
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at f000 [size=16]

0000:00:1f.3 0c05: 8086:266a (rev 04)
        Subsystem: a0a0:266a
        Flags: medium devsel, IRQ 5
        I/O ports at 5000 [size=32]

0000:02:00.0 0200: 11ab:4362 (rev 19)
        Subsystem: a0a0:0506
        Flags: bus master, fast devsel, latency 0, IRQ 17
        Memory at d0020000 (64-bit, non-prefetchable) [size=16K]
        I/O ports at c000 [size=256]
        Capabilities: <available only to root>

0000:03:00.0 0200: 11ab:4362 (rev 19)
        Subsystem: a0a0:0506
        Flags: bus master, fast devsel, latency 0, IRQ 18
        Memory at d0120000 (64-bit, non-prefetchable) [size=16K]
        I/O ports at d000 [size=256]
        Capabilities: <available only to root>

0000:05:03.0 0c00: 11c1:5811 (rev 61) (prog-if 10)
        Subsystem: a0a0:030a
        Flags: bus master, medium devsel, latency 32, IRQ 20
        Memory at d0200000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:05:04.0 0400: 109e:036e (rev 11)
        Subsystem: 0070:13eb
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at d0300000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:05:04.1 0480: 109e:0878 (rev 11)
        Subsystem: 0070:13eb
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at d0301000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>


***************************************
***************************************

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-05 17:22 honschu        New Issue                                    
09-24-05 17:22 honschu        Distribution              => Debian sarge    
09-24-05 17:22 honschu        Kernel Version            => 2.6.14-rc2      
09-24-05 22:06 rlrevell       Relationship added       duplicate of 0001429
10-05-05 18:34 tiwai          Note Added: 0006430                          
10-10-05 18:35 honschu        Note Added: 0006449                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
