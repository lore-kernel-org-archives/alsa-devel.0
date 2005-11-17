From: "Robert Lippmann" <rlippmann@hotmail.com>
Subject: snd_pcm_open() invalid argument in 1.0.10
Date: Thu, 17 Nov 2005 02:13:32 -0500
Message-ID: <BAY102-F165E2B737C745E23C55612B45F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

hi all,

i upgraded from 1.0.9 to 1.0.10, and i get and error -22 (invalid argument) 
in my xine logs.  xine works around it, but mythtv refuses to use sound.

once i downgrade to 1.0.9, everything works again (so i'm pretty sure it's 
not a kernel module problem).  i'm not sure if this is a bug or by design.

anyway, here's some (hopefully) relevant info, any help would be 
appreciated:

[root@akko log]# uname -a
Linux akko 2.6.12-1.1381_FC3 #1 Fri Oct 21 03:46:55 EDT 2005 i686 i686 i386 
GNU/Linux

[root@akko log]# lspci -v
00:00.0 Host bridge: Intel Corporation 82845G/GL[Brookdale-G]/GE/PE DRAM 
Controller/Host-Hub Interface (rev 01)
        Subsystem: Dell: Unknown device 0160
        Flags: bus master, fast devsel, latency 0
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation 
82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 01) 
(prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 0160
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Memory at feb80000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1

00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0160
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at ff80 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0160
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at ff60 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0160
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at ff60 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0160
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at ff40 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 
EHCI Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Dell: Unknown device 0160
        Flags: bus master, medium devsel, latency 0, IRQ 5
        Memory at ffa80800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 81) (prog-if 00 
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe900000-feafffff
        Prefetchable memory behind bridge: f8000000-fbffffff

00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC 
Interface Bridge (rev 01)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller (rev 
01) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell: Unknown device 0160
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at ffa0 [size=16]
        Memory at feb7fc00 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus 
Controller (rev 01)
        Subsystem: Dell: Unknown device 0160
        Flags: medium devsel, IRQ 3
        I/O ports at eda0 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
        Subsystem: Dell: Unknown device 0160
        Flags: bus master, medium devsel, latency 0, IRQ 3
        I/O ports at ee00 [size=256]
        I/O ports at edc0 [size=64]
        Memory at feb7fa00 (32-bit, non-prefetchable) [size=512]
        Memory at feb7f900 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:05.0 Modem: Intel Corporation: Unknown device 1080 (rev 04) (prog-if 00 
[Generic])
        Subsystem: Dell: Unknown device 1000
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 3
        Memory at fe9fd000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at de00 [size=256]
        Capabilities: [80] Power Management version 2

01:06.0 Multimedia video controller: Internext Compression Inc iTVC16 
(CX23416) MPEG-2 Encoder (rev 01)
        Subsystem: Hauppauge computer works Inc.: Unknown device 0003
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [44] Power Management version 2

01:09.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
        Subsystem: Dell: Unknown device 8127
        Flags: bus master, fast devsel, latency 64, IRQ 3
        Memory at fe9fe000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at fea00000 [disabled] [size=16K]
        Capabilities: [40] Power Management version 2




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
