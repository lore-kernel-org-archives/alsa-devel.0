From: "sbuonann@libero.it" <sbuonann@libero.it>
Subject: problem with snd_hda_intel for toshiba nb200 (no audio
 in ubuntu remix)
Date: Tue, 2 Jun 2009 22:20:11 +0200 (CEST)
Message-ID: <32142045.2551581243974011012.JavaMail.defaultUser@defaultHost>
Reply-To: "sbuonann@libero.it" <sbuonann@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cp-out3.libero.it (cp-out3.libero.it [212.52.84.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C6AA243C6
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 22:20:12 +0200 (CEST)
Received: from wmail44 (172.31.0.234) by cp-out3.libero.it (8.5.107)
	id 4A2413DA0008B466 for alsa-devel@alsa-project.org;
	Tue, 2 Jun 2009 22:20:11 +0200
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

the output of lspci -nv is the fellow:

00:00.0 0600: 8086:27ac (rev 03)
	
Subsystem: 1179:ff60
	Flags: bus master, fast devsel, latency 0
	Capabilities: 
[e0] Vendor Specific Information <?>
	Kernel driver in use: agpgart-intel
	
Kernel modules: intel-agp

00:02.0 0300: 8086:27ae (rev 03)
	Subsystem: 1179:
ff60
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at f0000000 (32-
bit, non-prefetchable) [size=512K]
	I/O ports at 1800 [size=8]
	Memory at 
d0000000 (32-bit, prefetchable) [size=256M]
	Memory at f0200000 (32-bit, non-
prefetchable) [size=256K]
	Capabilities: [90] Message Signalled Interrupts: 
Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [d0] Power Management version 2
	
Kernel modules: intelfb

00:02.1 0380: 8086:27a6 (rev 03)
	Subsystem: 1179:ff60

	Flags: bus master, fast devsel, latency 0
	Memory at f0080000 (32-bit, non-
prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 2

00:1b.
0 0403: 8086:27d8 (rev 02)
	Subsystem: 1179:ff6e
	Flags: bus master, fast 
devsel, latency 0, IRQ 22
	Memory at f0440000 (64-bit, non-prefetchable) 
[size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] 
Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: 
[70] Express Root Complex Integrated Endpoint, MSI 00
	Capabilities: [100] 
Virtual Channel <?>
	Capabilities: [130] Root Complex Link <?>
	Kernel driver 
in use: HDA Intel
	Kernel modules: snd-hda-intel

00:1c.0 0604: 8086:27d0 (rev 
02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, 
subordinate=02, sec-latency=0
	Capabilities: [40] Express Root Port (Slot+), 
MSI 00
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 
Enable+
	Capabilities: [90] Subsystem: 1179:ff60
	Capabilities: [a0] Power 
Management version 2
	Capabilities: [100] Virtual Channel <?>
	Capabilities: 
[180] Root Complex Link <?>
	Kernel driver in use: pcieport-driver
	Kernel 
modules: shpchp

00:1c.1 0604: 8086:27d2 (rev 02)
	Flags: bus master, fast 
devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0

	Memory behind bridge: f0100000-f01fffff
	Capabilities: [40] Express Root Port 
(Slot+), MSI 00
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- 
Queue=0/0 Enable+
	Capabilities: [90] Subsystem: 1179:ff60
	Capabilities: [a0] 
Power Management version 2
	Capabilities: [100] Virtual Channel <?>
	
Capabilities: [180] Root Complex Link <?>
	Kernel driver in use: pcieport-
driver
	Kernel modules: shpchp

00:1c.2 0604: 8086:27d4 (rev 02)
	Flags: bus 
master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, 
sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 
50000000-500fffff
	Prefetchable memory behind bridge: 00000000f0500000-
00000000f05fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	
Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+

	Capabilities: [90] Subsystem: 1179:ff60
	Capabilities: [a0] Power Management 
version 2
	Capabilities: [100] Virtual Channel <?>
	Capabilities: [180] Root 
Complex Link <?>
	Kernel driver in use: pcieport-driver
	Kernel modules: shpchp


00:1c.3 0604: 8086:27d6 (rev 02)
	Flags: bus master, fast devsel, latency 0
	
Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	Capabilities: 
[40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] Message Signalled 
Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [90] Subsystem: 1179:
ff60
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] 
Virtual Channel <?>
	Capabilities: [180] Root Complex Link <?>
	Kernel driver 
in use: pcieport-driver
	Kernel modules: shpchp

00:1d.0 0c03: 8086:27c8 (rev 
02)
	Subsystem: 1179:ff60
	Flags: bus master, medium devsel, latency 0, IRQ 23
	
I/O ports at 1820 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.1 0c03: 8086:
27c9 (rev 02)
	Subsystem: 1179:ff60
	Flags: bus master, medium devsel, latency 
0, IRQ 19
	I/O ports at 1840 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.2 
0c03: 8086:27ca (rev 02)
	Subsystem: 1179:ff60
	Flags: bus master, medium 
devsel, latency 0, IRQ 18
	I/O ports at 1860 [size=32]
	Kernel driver in use: 
uhci_hcd

00:1d.3 0c03: 8086:27cb (rev 02)
	Subsystem: 1179:ff60
	Flags: bus 
master, medium devsel, latency 0, IRQ 16
	I/O ports at 1880 [size=32]
	Kernel 
driver in use: uhci_hcd

00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20)
	
Subsystem: 1179:ff60
	Flags: bus master, medium devsel, latency 0, IRQ 23
	
Memory at f0444000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] 
Power Management version 2
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	
Kernel driver in use: ehci_hcd

00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01)
	
Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, 
subordinate=06, sec-latency=0
	Capabilities: [50] Subsystem: 1179:ff60

00:1f.0 
0601: 8086:27b9 (rev 02)
	Subsystem: 1179:ff60
	Flags: bus master, medium 
devsel, latency 0
	Capabilities: [e0] Vendor Specific Information <?>
	Kernel 
modules: iTCO_wdt, intel-rng

00:1f.1 0101: 8086:27df (rev 02) (prog-if 8a 
[Master SecP PriP])
	Subsystem: 1179:ff60
	Flags: bus master, medium devsel, 
latency 0, IRQ 19
	I/O ports at 01f0 [size=8]
	I/O ports at 03f4 [size=1]
	I/O 
ports at 0170 [size=8]
	I/O ports at 0374 [size=1]
	I/O ports at 1810 [size=16]

	Kernel driver in use: ata_piix

00:1f.2 0106: 8086:27c5 (rev 02) (prog-if 01)
	
Subsystem: 1179:ff60
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 
2299
	I/O ports at 18c8 [size=8]
	I/O ports at 18c0 [size=4]
	I/O ports at 18a8 
[size=8]
	I/O ports at 180c [size=4]
	I/O ports at 18b0 [size=16]
	Memory at 
f0444400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [80] Message 
Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [70] Power 
Management version 2
	Kernel driver in use: ahci

00:1f.3 0c05: 8086:27da (rev 
02)
	Subsystem: 1179:ff60
	Flags: medium devsel, IRQ 10
	I/O ports at 18e0 
[size=32]
	Kernel modules: i2c-i801

03:00.0 0280: 168c:002b (rev 01)
	
Subsystem: 1113:e811
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Memory 
at f0100000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] Power 
Management version 3
	Capabilities: [50] Message Signalled Interrupts: Mask- 
64bit- Queue=0/0 Enable-
	Capabilities: [60] Express Legacy Endpoint, MSI 00
	
Capabilities: [100] Advanced Error Reporting <?>
	Capabilities: [140] Virtual 
Channel <?>
	Capabilities: [160] Device Serial Number 12-14-24-ff-ff-17-15-00
	
Capabilities: [170] Power Budgeting <?>
	Kernel driver in use: ath9k
	Kernel 
modules: ath9k

04:00.0 0200: 10ec:8136 (rev 02)
	Subsystem: 1179:ff60
	Flags: 
bus master, fast devsel, latency 0, IRQ 2298
	I/O ports at 2000 [size=256]
	
Memory at f0510000 (64-bit, prefetchable) [size=4K]
	Memory at f0500000 (64-
bit, prefetchable) [size=64K]
	[virtual] Expansion ROM at f0520000 [disabled] 
[size=128K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] 
Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable+
	Capabilities: 
[70] Express Endpoint, MSI 01
	Capabilities: [ac] MSI-X: Enable- Mask- 
TabSize=2
	Capabilities: [cc] Vital Product Data <?>
	Capabilities: [100] 
Advanced Error Reporting <?>
	Capabilities: [140] Virtual Channel <?>
	
Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-01
	Kernel driver 
in use: r8169
	Kernel modules: r8169
