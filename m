From: Fredrik Smedberg <smedberg@swipnet.se>
Subject: Problems with the intel8x0 driver
Date: Thu, 18 Mar 2004 18:41:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040318184100.5ddfd605@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi!

I got a Fujitsu-Siemens 8830 laptop. It's equipped with a 3,06 Ghz Pentium 4 with hyper-threading and 1024 MB RAM.
The soundcard is a:
Intel Corp. 82801DB AC'97 Audio (rev 02)

Here is my lspci:
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 03)
        Subsystem: Unknown device 1734:102a
        Flags: bus master, fast devsel, latency 0
        Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [e4] #09 [6105]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge (rev 03) 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: dfd00000-dfdfffff
        Prefetchable memory behind bridge: afc00000-bfbfffff

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:102a
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at df20 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:102a
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at df40 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:102a
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at df80 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02) (prog-if 20 
[EHCI])
        Subsystem: Unknown device 1734:102a
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at dffffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82) (prog-if 00 [Normal 
decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: dfe00000-dfefffff

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02) (prog-if 8a [Master SecP 
PriP])
        Subsystem: Unknown device 1734:102a
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at ffa0 [size=16]
        Memory at 3ffd0000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)
        Subsystem: Unknown device 1734:102a
        Flags: medium devsel, IRQ 17
        I/O ports at 0540 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 02)
        Subsystem: Unknown device 1734:102a
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at e000 [size=256]
        I/O ports at e100 [size=64]
        Memory at 3ffd0400 (32-bit, non-prefetchable) [disabled] [size=512]
        Memory at 3ffd0600 (32-bit, non-prefetchable) [disabled] [size=256]
        Capabilities: [50] Power Management version 2

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 02) (prog-if 00 [Generic])
        Subsystem: Unknown device 1734:102a
        Flags: medium devsel, IRQ 17
        I/O ports at e200 [size=256]
        I/O ports at e300 [size=128]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon 
Mobility 9000] (rev 01) (prog-if 00 [VGA])
        Subsystem: Unknown device 1734:102a
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 16
        Memory at b0000000 (32-bit, prefetchable) [size=128M]
        I/O ports at b000 [size=256]
        Memory at dfdf0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at dfdc0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

02:03.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
        Subsystem: Unknown device 1734:102a
        Flags: bus master, stepping, slow devsel, latency 168, IRQ 17
        Memory at 3ffd1000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 40000000-403ff000 (prefetchable)
        Memory window 1: 40400000-407ff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

02:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 
80) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1734:102a
        Flags: bus master, medium devsel, latency 64, IRQ 18
        Memory at dfeff800 (32-bit, non-prefetchable) [size=2K]
        I/O ports at cc00 [size=128]
        Capabilities: [50] Power Management version 2

02:0c.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) 
Ethernet Controller
        Subsystem: Unknown device 1734:102a
        Flags: bus master, medium devsel, latency 64, IRQ 17
        I/O ports at c800 [size=256]
        Memory at dfefe000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at dfee0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2

Previous versions of the kernel with older versions of ALSA always gave me this error:
Intel 810 + AC97 Audio, version 0.24, 01:22:57 Dec 27 2003
PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH4 found at IO 0xe100 and 0xe000, MEM 0x3ffd0400 and
0x3ffd0600, IRQ 17
i810: Intel ICH4 mmio at 0xfcd80400 and 0xfcd82600
i810_audio: Primary codec has ID 1
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 1
ac97_codec: AC97  codec, id: LM
78 (Unknown)
i810_audio: timed out waiting for codec 1 analog ready.


I got this error with kernel 2.6.5-rc1 using ALSA + the intel8x0-driver (the system ended up in a kernel panic):

Stack:
00000042 c192e000 c192e000 c1be9400 c1be9437 c032071d 00000000 00000002
fffffffb c035ad73 c1be9000 00000001 c1be92f0 c1be9424 c1be9000 c1be9424
c1be9424 fffffffb c1be9437 c1be9400 c035b0e6 c1be9400 c19bf000 00000001

Call Trace:
[<c032071d>] snd_card_free+0x128/0x2da
[<c035ad73>] snd_intel8x0_create+0x398/0x542
[<c035b0e6>] snd_intel8x0_probe+0x1c8/0x278
[<c01738d5>] dput+0x22/0x25b
[<c0229536>] pci_device_probe_static+0x52/0x61
[<c0229580>] __pci_device_probe+0x3b/0x4e
[<c02295bf>] pci_device_probe+0x2c/0x4a
[<c02871de>] bus_match+0x3f/0x6a
[<c02872f0>] driver_attach+0x56/0x80
[<c02875cb>] bus_add_driver+0xa0/0xb3
[<c022978b>] pci_register_driver+0x6c/0x94
[<c05140c7>] alsa_card_intel8x0_init+0x15/0x43
[<c04fa8a3>] do_initcalls+0x27/0xb3
[<c0132b56>] init_workqueues+0xf/0x26
[<c01030f1>] init+0x59/0x158
[<c0103098>] init+0x0/0x158
[<c0105271>] kernel_thread_helper+0x5/0xb

Code: 8b 46 20 85 c0 74 63 8b 78 34 bb f0 7c 4a c0 c7 44 24 04 77
(0)Kernel panic: Attempted to kill init!


Someone who knows what is wrong? Perhaps a serious bug in the intel8x0 driver? I've never gotten the sound-card to working under Linux using ALSA or OSS. The sound-card has so far only worked in Windows.

Thanks for all the help,
Fredrik Smedberg


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
