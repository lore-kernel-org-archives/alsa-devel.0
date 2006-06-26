From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002233]: No sound on speakers,
	low volume on the headphones, Samsung X60 Chane
Date: Mon, 26 Jun 2006 16:00:18 +0200
Message-ID: <3cbe506ab6c0b44da3c7818e2d5508b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 97BEB177
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 16:00:18 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2233> 
======================================================================
Reported By:                max
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2233
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               suse 10.1
Kernel Version:             2.6.16.13-4
======================================================================
Date Submitted:             06-26-2006 12:17 CEST
Last Modified:              06-26-2006 16:00 CEST
======================================================================
Summary:                    No sound on speakers, low volume on the headphones,
Samsung X60 Chane
Description: 
installation ok. (82801G)
but
no sound on speakers 
low volume on the headphones and sometimes a verry high frequenz...

thanks for help

======================================================================

----------------------------------------------------------------------
 max - 06-26-06 12:24 
----------------------------------------------------------------------
lspci -v
00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
945GT Express Memory Controller Hub (rev 03)
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation Mobile
945GM/GMS/940GML Express Integrated Graphics Controller (rev 03) (prog-if
00 [VGA])
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, fast devsel, latency 0, IRQ 177
        Memory at d4900000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 4800 [size=8]
        Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Memory at d4a00000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
        Capabilities: [d0] Power Management version 2

00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML
Express Integrated Graphics Controller (rev 03)
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: fast devsel
        Memory at d4980000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 2

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, fast devsel, latency 0, IRQ 74
        Memory at d4a40000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00005000-00005fff
        Memory behind bridge: d2000000-d2ffffff
        Prefetchable memory behind bridge:
00000000d0000000-00000000d0700000
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
        I/O behind bridge: 00006000-00006fff
        Memory behind bridge: d3000000-d37fffff
        Prefetchable memory behind bridge:
00000000d0800000-00000000d0f00000
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=06, sec-latency=0
        I/O behind bridge: 00007000-00007fff
        Prefetchable memory behind bridge:
00000000d1000000-00000000d1700000
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=07, subordinate=08, sec-latency=0
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: d4000000-d47fffff
        Prefetchable memory behind bridge:
00000000d1800000-00000000d1f00000
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, medium devsel, latency 0, IRQ 66
        I/O ports at 4820 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, medium devsel, latency 0, IRQ 193
        I/O ports at 4840 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, medium devsel, latency 0, IRQ 185
        I/O ports at 4860 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, medium devsel, latency 0, IRQ 177
        I/O ports at 4880 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, medium devsel, latency 0, IRQ 66
        Memory at d4c44000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
(prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=09, subordinate=09, sec-latency=32
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: d4800000-d48fffff
        Prefetchable memory behind bridge:
0000000050000000-0000000051f00000
        Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, medium devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial
ATA Storage Controller IDE (rev 02) (prog-if 80 [Master])
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 193
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 48b0 [size=16]
        Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 02)
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: medium devsel, IRQ 5
        I/O ports at 48c0 [size=32]

02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet
Controller (rev 01)
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, fast devsel, latency 0, IRQ 82
        Memory at d2800000 (32-bit, non-prefetchable) [size=128K]
        Memory at d2000000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 5000 [size=32]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable+
        Capabilities: [e0] Express Endpoint IRQ 0

03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Network
Connection (rev 02)
        Subsystem: Intel Corporation Unknown device 1001
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at d3000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [e0] Express Legacy Endpoint IRQ 0

09:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b4)
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, medium devsel, latency 168, IRQ 201
        Memory at d4802000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=09, secondary=0a, subordinate=0d, sec-latency=176
        Memory window 0: 50000000-51fff000 (prefetchable)
        Memory window 1: 52000000-53fff000
        I/O window 0: 00002000-000020ff
        I/O window 1: 00002400-000024ff
        16-bit legacy interface ports at 0001

09:09.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
(rev 09) (prog-if 10 [OHCI])
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, medium devsel, latency 64, IRQ 58
        Memory at d4800000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2

09:09.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter
(rev 18)
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, medium devsel, latency 32, IRQ 255
        Memory at d4800800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

09:09.3 System peripheral: Ricoh Co Ltd Unknown device 0843
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: bus master, medium devsel, latency 0, IRQ 255
        Memory at d4800c00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

09:09.4 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host
Adapter (rev 09)
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: medium devsel, IRQ 255
        Memory at d4801000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

09:09.5 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev
04)
        Subsystem: Samsung Electronics Co Ltd Unknown device c023
        Flags: medium devsel, IRQ 255
        Memory at d4801400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

----------------------------------------------------------------------
 tiwai - 06-26-06 16:00 
----------------------------------------------------------------------
The helpful information is: /proc/asound/card0/codec#* files and a file
generated via "alsactl -f somefile store".

Try different model options described in ALSA-Configuration.txt.  For
example, if the codec is AD1986A, try model=laptop-eapd.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-06 12:17 max            New Issue                                    
06-26-06 12:17 max            Distribution              => suse 10.1       
06-26-06 12:17 max            Kernel Version            => 2.6.16.13-4     
06-26-06 12:20 max            Note Added: 0010527                          
06-26-06 12:21 max            Note Added: 0010528                          
06-26-06 12:23 max            Note Added: 0010529                          
06-26-06 12:24 max            Note Added: 0010530                          
06-26-06 16:00 tiwai          Note Added: 0010538                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
