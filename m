From: "Teodor Robas" <teodor.robas@gmail.com>
Subject: patch for MSI L720 laptop
Date: Sun, 11 Mar 2007 09:32:02 +0200
Message-ID: <291232630703102332h2e4120ealb067f29b3b99a00d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1006904132=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1006904132==
Content-Type: multipart/alternative;
	boundary="----=_Part_6532_11417951.1173598322467"

------=_Part_6532_11417951.1173598322467
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I hope somebody else will have a headache less with this:

diff ac97_patch.c.original ac97_patch.c
2725a2726
>                    ac97->subsystem_device == 0x0471 || /* MSI L720 laptop
*/

aplied to alsa-driver-1.0.14rc3.tar.bz2

And if anyone want to see:

# lspci
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express
Processor to DRAM Controller (rev 04)
00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML
Express Graphics Controller (rev 04)
00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
Express Graphics Controller (rev 04)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 1 (rev 04)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) AC'97 Audio Controller (rev 04)
00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97
Modem Controller (rev 04)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge
(rev 04)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
IDE Controller (rev 04)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus
Controller (rev 04)
03:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
03:05.0 CardBus bridge: O2 Micro, Inc. OZ711MP1/MS1 MemoryCardBus Controller
(rev 21)
03:05.2 Class 0805: O2 Micro, Inc. Integrated MMC/SD Controller (rev 01)
03:05.3 Bridge: O2 Micro, Inc. Integrated MS/xD Controller (rev 01)
03:05.4 FireWire (IEEE 1394): O2 Micro, Inc. Firewire (IEEE 1394) (rev 02)
03:09.0 Network controller: RaLink RT2561/RT61 rev B 802.11g

# lspci -nv
00:00.0 0600: 8086:2590 (rev 04)
        Subsystem: 1462:0161
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:02.0 0300: 8086:2592 (rev 04)
        Subsystem: 1462:0161
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at 22000000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 14a0 [size=8]
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Memory at 22080000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [d0] Power Management version 2

00:02.1 0380: 8086:2792 (rev 04)
        Subsystem: 1462:0161
        Flags: bus master, fast devsel, latency 0
        Memory at fbd80000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 2

00:1c.0 0604: 8086:2660 (rev 04)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fbe00000-fbefffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1d.0 0c03: 8086:2658 (rev 04)
        Subsystem: 1462:0161
        Flags: bus master, medium devsel, latency 0, IRQ 217
        I/O ports at 1440 [size=32]

00:1d.1 0c03: 8086:2659 (rev 04)
        Subsystem: 1462:0161
        Flags: bus master, medium devsel, latency 0, IRQ 177
        I/O ports at 1460 [size=32]

00:1d.2 0c03: 8086:265a (rev 04)
        Subsystem: 1462:0161
        Flags: bus master, medium devsel, latency 0, IRQ 209
        I/O ports at 1480 [size=32]

00:1d.7 0c03: 8086:265c (rev 04) (prog-if 20)
        Subsystem: 1462:0161
        Flags: bus master, medium devsel, latency 0, IRQ 217
        Memory at 220c0000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 0604: 8086:2448 (rev d4) (prog-if 01)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=05, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fbf00000-fbffffff
        Prefetchable memory behind bridge: 0000000020000000-0000000021f00000
        Capabilities: [50] #0d [0000]

00:1e.2 0401: 8086:266e (rev 04)
        Subsystem: 1462:0471
        Flags: bus master, medium devsel, latency 0, IRQ 233
        I/O ports at 1000 [size=256]
        I/O ports at 1400 [size=64]
        Memory at 220c0400 (32-bit, non-prefetchable) [size=512]
        Memory at 220c0600 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:1e.3 0703: 8086:266d (rev 04)
        Subsystem: 1462:0121
        Flags: medium devsel, IRQ 201
        I/O ports at c800 [size=256]
        I/O ports at cc00 [size=128]
        Capabilities: [50] Power Management version 2

00:1f.0 0601: 8086:2641 (rev 04)
        Subsystem: 1462:0161
        Flags: bus master, medium devsel, latency 0

00:1f.1 0101: 8086:266f (rev 04) (prog-if 8a)
        Subsystem: 1462:0161
        Flags: bus master, medium devsel, latency 0, IRQ 209
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at ffa0 [size=16]

00:1f.3 0c05: 8086:266a (rev 04)
        Subsystem: 1462:0161
        Flags: medium devsel, IRQ 7
        I/O ports at c480 [size=32]

03:03.0 0200: 10ec:8139 (rev 10)
        Subsystem: 1462:0161
        Flags: bus master, medium devsel, latency 64, IRQ 225
        I/O ports at e800 [size=256]
        Memory at fbfffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

03:05.0 0607: 1217:7134 (rev 21)
        Subsystem: 1462:0161
        Flags: bus master, slow devsel, latency 64, IRQ 177
        Memory at fbf00000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=03, secondary=04, subordinate=04, sec-latency=176
        Memory window 0: 20000000-21fff000 (prefetchable)
        Memory window 1: 24000000-25fff000
        I/O window 0: 0000e000-0000e0ff
        I/O window 1: 0000e400-0000e4ff
        16-bit legacy interface ports at 0001

03:05.2 0805: 1217:7120 (rev 01)
        Subsystem: 1462:0161
        Flags: slow devsel, IRQ 5
        Memory at fbfff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [a0] Power Management version 2

03:05.3 0680: 1217:7130 (rev 01)
        Subsystem: 1462:0161
        Flags: slow devsel, IRQ 5
        Memory at fbffe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [a0] Power Management version 2

03:05.4 0c00: 1217:00f7 (rev 02) (prog-if 10)
        Subsystem: 1217:00f7
        Flags: bus master, medium devsel, latency 64, IRQ 177
        Memory at fbffd000 (32-bit, non-prefetchable) [size=4K]
        Memory at fbfff000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [60] Power Management version 2

03:09.0 0280: 1814:0302
        Subsystem: 1462:b833
        Flags: bus master, slow devsel, latency 64, IRQ 7
        Memory at fbff0000 (32-bit, non-prefetchable) [size=32K]
        Capabilities: [40] Power Management version 2

------=_Part_6532_11417951.1173598322467
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I hope somebody else will have a headache less with this:<br><br>diff ac97_patch.c.original ac97_patch.c<br>2725a2726<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ac97-&gt;subsystem_device == 0x0471 || /* MSI L720 laptop */<br>
<br>aplied to alsa-driver-1.0.14rc3.tar.bz2<br><br>And if anyone want to see: <br><br># lspci<br>00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 04)<br>00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 04)
<br>00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 04)<br>00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04)<br>00:
1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04)<br>00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04)<br>00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04)
<br>00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04)<br>00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)<br>00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC&#39;97 Audio Controller (rev 04)
<br>00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC&#39;97 Modem Controller (rev 04)<br>00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 04)<br>00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04)
<br>00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)<br>03:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)<br>03:05.0 CardBus bridge: O2 Micro, Inc. OZ711MP1/MS1 MemoryCardBus Controller (rev 21)
<br>03:05.2 Class 0805: O2 Micro, Inc. Integrated MMC/SD Controller (rev 01)<br>03:05.3 Bridge: O2 Micro, Inc. Integrated MS/xD Controller (rev 01)<br>03:05.4 FireWire (IEEE 1394): O2 Micro, Inc. Firewire (IEEE 1394) (rev 02)
<br>03:09.0 Network controller: RaLink RT2561/RT61 rev B 802.11g<br><br># lspci -nv<br>00:00.0 0600: 8086:2590 (rev 04)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, fast devsel, latency 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [e0] Vendor Specific Information
<br><br>00:02.0 0300: 8086:2592 (rev 04)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, fast devsel, latency 0, IRQ 169<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 22000000 (32-bit, non-prefetchable) [size=512K]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at 14a0 [size=8]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at d0000000 (32-bit, prefetchable) [size=256M]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 22080000 (32-bit, non-prefetchable) [size=256K]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [d0] Power Management version 2<br><br>00:02.1 0380: 8086:2792 (rev 04)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, fast devsel, latency 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at fbd80000 (32-bit, non-prefetchable) [size=512K]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [d0] Power Management version 2<br><br>00:
1c.0 0604: 8086:2660 (rev 04)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, fast devsel, latency 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus: primary=00, secondary=01, subordinate=02, sec-latency=0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O behind bridge: 0000d000-0000dfff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory behind bridge: fbe00000-fbefffff
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [40] Express Root Port (Slot+) IRQ 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [90] #0d [0000]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [a0] Power Management version 2
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [100] Virtual Channel<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [180] Unknown (5)<br><br>00:1d.0 0c03: 8086:2658 (rev 04)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, medium devsel, latency 0, IRQ 217
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at 1440 [size=32]<br><br>00:1d.1 0c03: 8086:2659 (rev 04)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, medium devsel, latency 0, IRQ 177<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at 1460 [size=32]<br><br>
00:1d.2 0c03: 8086:265a (rev 04)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, medium devsel, latency 0, IRQ 209<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at 1480 [size=32]<br><br>00:1d.7 0c03: 8086:265c (rev 04) (prog-if 20)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, medium devsel, latency 0, IRQ 217<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 220c0000 (32-bit, non-prefetchable) [size=1K]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [50] Power Management version 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [58] Debug port
<br><br>00:1e.0 0604: 8086:2448 (rev d4) (prog-if 01)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, fast devsel, latency 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus: primary=00, secondary=03, subordinate=05, sec-latency=32<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O behind bridge: 0000e000-0000efff
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory behind bridge: fbf00000-fbffffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Prefetchable memory behind bridge: 0000000020000000-0000000021f00000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [50] #0d [0000]<br><br>00:1e.2 0401: 8086:266e (rev 04)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0471
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, medium devsel, latency 0, IRQ 233<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at 1000 [size=256]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at 1400 [size=64]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 220c0400 (32-bit, non-prefetchable) [size=512]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 220c0600 (32-bit, non-prefetchable) [size=256]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [50] Power Management version 2<br><br>00:1e.3 0703: 8086:266d (rev 04)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0121<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: medium devsel, IRQ 201<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at c800 [size=256]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at cc00 [size=128]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [50] Power Management version 2<br><br>00:1f.0 0601: 8086:2641 (rev 04)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, medium devsel, latency 0<br><br>00:1f.1 0101: 8086:266f (rev 04) (prog-if 8a)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, medium devsel, latency 0, IRQ 209<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at &lt;unassigned&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at &lt;unassigned&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at &lt;unassigned&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at &lt;unassigned&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at ffa0 [size=16]<br><br>00:1f.3 0c05: 8086:266a (rev 04)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: medium devsel, IRQ 7<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at c480 [size=32]
<br><br>03:03.0 0200: 10ec:8139 (rev 10)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, medium devsel, latency 64, IRQ 225<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O ports at e800 [size=256]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at fbfffc00 (32-bit, non-prefetchable) [size=256]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [50] Power Management version 2<br><br>03:05.0 0607: 1217:7134 (rev 21)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, slow devsel, latency 64, IRQ 177<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at fbf00000 (32-bit, non-prefetchable) [size=4K]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus: primary=03, secondary=04, subordinate=04, sec-latency=176<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory window 0: 20000000-21fff000 (prefetchable)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory window 1: 24000000-25fff000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O window 0: 0000e000-0000e0ff
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O window 1: 0000e400-0000e4ff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16-bit legacy interface ports at 0001<br><br>03:05.2 0805: 1217:7120 (rev 01)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: slow devsel, IRQ 5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at fbfff800 (32-bit, non-prefetchable) [size=256]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [a0] Power Management version 2<br><br>03:05.3 0680: 1217:7130 (rev 01)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:0161<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: slow devsel, IRQ 5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at fbffe000 (32-bit, non-prefetchable) [size=4K]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [a0] Power Management version 2<br><br>03:05.4 0c00: 1217:00f7 (rev 02) (prog-if 10)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1217:00f7<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, medium devsel, latency 64, IRQ 177<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at fbffd000 (32-bit, non-prefetchable) [size=4K]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at fbfff000 (32-bit, non-prefetchable) [size=2K]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [60] Power Management version 2<br><br>03:09.0 0280: 1814:0302<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 1462:b833<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, slow devsel, latency 64, IRQ 7
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at fbff0000 (32-bit, non-prefetchable) [size=32K]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [40] Power Management version 2<br><br>

------=_Part_6532_11417951.1173598322467--


--===============1006904132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1006904132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1006904132==--
