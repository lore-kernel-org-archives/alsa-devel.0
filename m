From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001997]: No sound when using second pcm device
Date: Mon, 3 Apr 2006 11:59:33 +0200
Message-ID: <77ce7b5ceaff44ccb31db57556568e59@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7F211A2
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2006 11:59:33 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1997> 
======================================================================
Reported By:                prymitive
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1997
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.16-gentoo-r1
======================================================================
Date Submitted:             04-03-2006 11:59 CEST
Last Modified:              04-03-2006 11:59 CEST
======================================================================
Summary:                    No sound when using second pcm device
Description: 
Hi there

I own an Acer 5024 notebook (AMD Turion / ATI chip based):

cer sub0 # lspci -v
00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 01)
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, 66MHz, medium devsel, latency 64

00:02.0 PCI bridge: ATI Technologies Inc RS480 PCI-X Root Port (prog-if 00
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: c0100000-c01fffff
        Prefetchable memory behind bridge: c8000000-cfffffff
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot-) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
        Capabilities: [b0] #0d [0000]
        Capabilities: [b8] HyperTransport: MSI Mapping
        Capabilities: [100] Advanced Error Reporting

00:06.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge (prog-if 00
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot-) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
        Capabilities: [b0] #0d [0000]
        Capabilities: [b8] HyperTransport: MSI Mapping
        Capabilities: [100] Advanced Error Reporting

00:07.0 PCI bridge: ATI Technologies Inc Unknown device 5a39 (prog-if 00
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot-) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
        Capabilities: [b0] #0d [0000]
        Capabilities: [b8] HyperTransport: MSI Mapping
        Capabilities: [100] Advanced Error Reporting

00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
(prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at c0000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-

00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
(prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at c0001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-

00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host
Controller (prog-if 20 [EHCI])
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at c0002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-

00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 11)
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: 66MHz, medium devsel
        I/O ports at 8400 [size=16]
        Memory at c0003000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [b0] HyperTransport: MSI Mapping

00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE
Controller ATI (prog-if 8a [Master SecP PriP])
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 10
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 8410 [size=16]
        Capabilities: [70] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-

00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, 66MHz, medium devsel, latency 0

00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge (prog-if
01 [Subtractive decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=00, secondary=06, subordinate=06, sec-latency=64
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: c0200000-c02fffff
        Prefetchable memory behind bridge: 30000000-32ffffff

00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97
Audio Controller (rev 02)
        Subsystem: Acer Incorporated [ALI] Unknown device 0079
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 11
        Memory at c0003400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-

00:14.6 Modem: ATI Technologies Inc ATI SB400 - AC'97 Modem Controller
(rev 02) (prog-if 00 [Generic])
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 11
        Memory at c0003800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
        Flags: fast devsel

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
X700 (PCIE) (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at c8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 9000 [size=256]
        Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at c0120000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Express Endpoint IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [100] Advanced Error Reporting

06:05.0 Network controller: Broadcom Corporation BCM4318 [AirForce One
54g] 802.11g Wireless LAN Controller (rev 02)
        Subsystem: AMBIT Microsystem Corp. Aspire 3022WLMi
        Flags: bus master, fast devsel, latency 64, IRQ 10
        Memory at c0204000 (32-bit, non-prefetchable) [size=8K]

06:06.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at c020a000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=06, secondary=07, subordinate=08, sec-latency=176
        Memory window 0: 30000000-31fff000 (prefetchable)
        Memory window 1: 34000000-35fff000 (prefetchable)
        I/O window 0: 0000a400-0000a4ff
        I/O window 1: 0000a800-0000a8ff
        16-bit legacy interface ports at 0001

06:06.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394
Host Controller (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at c0208000 (32-bit, non-prefetchable) [size=2K]
        Memory at c0200000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

06:06.3 Mass storage controller: Texas Instruments PCIxx21 Integrated
FlashMedia Controller
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at c0206000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [44] Power Management version 2

06:06.4 Class 0805: Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621,
PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller
        Subsystem: Acer Incorporated [ALI] Unknown device 0080
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at c0209000 (32-bit, non-prefetchable) [size=256]
        Memory at c0208c00 (32-bit, non-prefetchable) [size=256]
        Memory at c0208800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

06:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
Gigabit Ethernet (rev 10)
        Subsystem: Acer Incorporated [ALI] Unknown device 0079
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        I/O ports at a000 [size=256]
        Memory at c0209400 (32-bit, non-prefetchable) [size=256]
        [virtual] Expansion ROM at 32000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

I'm running x86 Gentoo system and while using /dev/dsp under oss and
hw=0,0 under alsa everything is ok. But when I try to use second pcm
(/dev/dsp1 under oss emulation or hw=0,1 under alsa) I got no sound. 
Running mplayer -ao oss:device=/dev/dsp1 gives me error "No souch device",
running 
Running mplayer -ao alsa:device=hw=0.1 gives me:
[...]
AUDIO: 44100 Hz, 2 ch, s16le, 128.0 kbit/9.07% (ratio: 16000->176400)
Selected audio codec: [mp3] afm: mp3lib (mp3lib MPEG layer-2, layer-3)
==========================================================================
alsa-init: 1 soundcard found, using: hw:0,1
alsa: 48000 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little
Endian
AO: [alsa] 48000Hz 2ch s16le (2 bytes per sample)
[...]
device is opened but it freezes after that, no sound
I tried whith snd_atiixp ac97_clock=44100 but after inserting module with
this parameter mplayer opens hw=0.0 device with 44100 rate but hw=0.1
device is opened with 48000 rate
Is the second device any good for playing stuff? Maybe I shoud pass some
other parameters to the snd_atiixp module?

prymitive@acer ~/stuff/music $ lsmod
Module                  Size  Used by
snd_atiixp             19212  3
fglrx                 455084  7
snd_atiixp_modem       15944  0
snd_ac97_codec         90464  2 snd_atiixp,snd_atiixp_modem
snd_ac97_bus            2176  1 snd_ac97_codec
nsc_ircc               17980  0
irda                  119352  1 nsc_ircc
crc_ccitt               2048  1 irda

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-06 11:59 prymitive      New Issue                                    
04-03-06 11:59 prymitive      Kernel Version            => 2.6.16-gentoo-r1
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
