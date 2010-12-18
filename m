From: =?koi8-r?Q?=E2=CF=CC=C7=C1=D2_=F7=C1=D3=C9=CC=C9=CA?=
	<reanimator-zon@mail.ru>
Subject: ALSA HDA-Intel on HP Mini 110-3100er
Date: Sat, 18 Dec 2010 21:03:55 +0300
Message-ID: <E1PU18N-0004mb-00.reanimator-zon-mail-ru@f189.mail.ru>
Reply-To: =?koi8-r?Q?=E2=CF=CC=C7=C1=D2_=F7=C1=D3=C9=CC=C9=CA?=
	<reanimator-zon@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f189.mail.ru (f189.mail.ru [217.69.128.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B12924554
	for <alsa-devel@alsa-project.org>; Sat, 18 Dec 2010 19:03:57 +0100 (CET)
Received: from mail by f189.mail.ru with local id 1PU18N-0004mb-00
	for alsa-devel@alsa-project.org; Sat, 18 Dec 2010 21:03:55 +0300
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

I have netbook HP Mini Laptop

There is some information:

reanimator-debian:/etc/modprobe.d# lspci -nv

00:00.0 0600: 8086:a010
    Flags: bus master, fast devsel, latency 0
    Capabilities: [e0] Vendor Specific Information <?>

00:02.0 0300: 8086:a011 (prog-if 00 [VGA controller])
    Subsystem: 103c:148a
    Flags: bus master, fast devsel, latency 0, IRQ 11
    Memory at 94180000 (32-bit, non-prefetchable) [size=512K]
    I/O ports at 30c0 [size=8]
    Memory at 80000000 (32-bit, prefetchable) [size=256M]
    Memory at 94000000 (32-bit, non-prefetchable) [size=1M]
    Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 
Enable-
    Capabilities: [d0] Power Management version 2

00:02.1 0380: 8086:a012
    Subsystem: 103c:148a
    Flags: bus master, fast devsel, latency 0
    Memory at 94100000 (32-bit, non-prefetchable) [size=512K]
    Capabilities: [d0] Power Management version 2

00:1b.0 0403: 8086:27d8 (rev 02)
    Subsystem: 103c:148a
    Flags: bus master, fast devsel, latency 0, IRQ 16
    Memory at 94200000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
    Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 
Enable-
    Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
    Capabilities: [100] Virtual Channel <?>
    Capabilities: [130] Root Complex Link <?>
    Kernel driver in use: HDA Intel
    Kernel modules: snd-hda-intel

00:1c.0 0604: 8086:27d0 (rev 02) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: 93000000-93ffffff
    Prefetchable memory behind bridge: 0000000090000000-0000000090ffffff
    Capabilities: [40] Express Root Port (Slot+), MSI 00
    Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 
Enable+
    Capabilities: [90] Subsystem: 103c:148a
    Capabilities: [a0] Power Management version 2
    Capabilities: [100] Virtual Channel <?>
    Capabilities: [180] Root Complex Link <?>
    Kernel driver in use: pcieport-driver
    Kernel modules: shpchp

00:1c.1 0604: 8086:27d2 (rev 02) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 00001000-00001fff
    Memory behind bridge: 92000000-92ffffff
    Prefetchable memory behind bridge: 0000000091000000-0000000091ffffff
    Capabilities: [40] Express Root Port (Slot+), MSI 00
    Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 
Enable+
    Capabilities: [90] Subsystem: 103c:148a
    Capabilities: [a0] Power Management version 2
    Capabilities: [100] Virtual Channel <?>
    Capabilities: [180] Root Complex Link <?>
    Kernel driver in use: pcieport-driver
    Kernel modules: shpchp

00:1d.0 0c03: 8086:27c8 (rev 02) (prog-if 00 [UHCI])
    Subsystem: 103c:148a
    Flags: bus master, medium devsel, latency 0, IRQ 16
    I/O ports at 3080 [size=32]
    Kernel driver in use: uhci_hcd
    Kernel modules: uhci-hcd

00:1d.1 0c03: 8086:27c9 (rev 02) (prog-if 00 [UHCI])
    Subsystem: 103c:148a
    Flags: bus master, medium devsel, latency 0, IRQ 18
    I/O ports at 3060 [size=32]
    Kernel driver in use: uhci_hcd
    Kernel modules: uhci-hcd

00:1d.2 0c03: 8086:27ca (rev 02) (prog-if 00 [UHCI])
    Subsystem: 103c:148a
    Flags: bus master, medium devsel, latency 0, IRQ 17
    I/O ports at 3040 [size=32]
    Kernel driver in use: uhci_hcd
    Kernel modules: uhci-hcd

00:1d.3 0c03: 8086:27cb (rev 02) (prog-if 00 [UHCI])
    Subsystem: 103c:148a
    Flags: bus master, medium devsel, latency 0, IRQ 19
    I/O ports at 3020 [size=32]
    Kernel driver in use: uhci_hcd
    Kernel modules: uhci-hcd

00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20 [EHCI])
    Subsystem: 103c:148a
    Flags: bus master, medium devsel, latency 0, IRQ 16
    Memory at 94204400 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 2
    Capabilities: [58] Debug port: BAR=1 offset=00a0
    Kernel driver in use: ehci_hcd
    Kernel modules: ehci-hcd

00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01 [Subtractive decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
    Capabilities: [50] Subsystem: 103c:148a

00:1f.0 0601: 8086:27bc (rev 02)
    Subsystem: 103c:148a
    Flags: bus master, medium devsel, latency 0
    Capabilities: [e0] Vendor Specific Information <?>

00:1f.2 0106: 8086:27c1 (rev 02) (prog-if 01 [AHCI 1.0])
    Subsystem: 103c:148a
    Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 1276
    I/O ports at 30b8 [size=8]
    I/O ports at 30cc [size=4]
    I/O ports at 30b0 [size=8]
    I/O ports at 30c8 [size=4]
    I/O ports at 30a0 [size=16]
    Memory at 94204000 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 
Enable+
    Capabilities: [70] Power Management version 2
    Kernel driver in use: ahci
    Kernel modules: ahci

00:1f.3 0c05: 8086:27da (rev 02)
    Subsystem: 103c:148a
    Flags: medium devsel, IRQ 17
    I/O ports at 3000 [size=32]
    Kernel driver in use: i801_smbus
    Kernel modules: i2c-i801

01:00.0 0200: 10ec:8136 (rev 04)
    Subsystem: 103c:148a
    Flags: bus master, fast devsel, latency 0, IRQ 1277
    I/O ports at 2000 [size=256]
    Memory at 90004000 (64-bit, prefetchable) [size=4K]
    Memory at 90000000 (64-bit, prefetchable) [size=16K]
    Capabilities: [40] Power Management version 3
    Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 
Enable+
    Capabilities: [70] Express Endpoint, MSI 01
    Capabilities: [b0] MSI-X: Enable- Mask- TabSize=4
    Capabilities: [d0] Vital Product Data <?>
    Capabilities: [100] Advanced Error Reporting <?>
    Capabilities: [140] Virtual Channel <?>
    Capabilities: [160] Device Serial Number 00-e0-4c-ff-00-00-00-01
    Kernel driver in use: r8169
    Kernel modules: r8169

01:00.1 ff00: 10ec:5288 (rev 01)
    Subsystem: 103c:148a
    Flags: bus master, fast devsel, latency 0, IRQ 10
    Memory at 93000000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: [40] Power Management version 3
    Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 
Enable-
    Capabilities: [70] Express Endpoint, MSI 00
    Capabilities: [b0] MSI-X: Enable- Mask- TabSize=1
    Capabilities: [d0] Vital Product Data <?>
    Capabilities: [100] Advanced Error Reporting <?>

02:00.0 0280: 1814:3090
    Subsystem: 103c:1453
    Flags: bus master, fast devsel, latency 0, IRQ 17
    Memory at 92000000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: [40] Power Management version 3
    Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/5 
Enable-
    Capabilities: [70] Express Endpoint, MSI 00
    Capabilities: [100] Advanced Error Reporting <?>
    Capabilities: [140] Device Serial Number e0-2a-82-17-c6-b6-00-00
    Kernel driver in use: rt2860
    Kernel modules: rt3090sta

reanimator-debian:/home/reanimator# lspci | grep -i Audio

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)

I tried "options snd_hda_intel=%X" where X in (laptop, hp, laptop-hp, auto) etc.

Can you help me?
