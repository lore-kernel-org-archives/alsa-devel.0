From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000440]: Gateway Solo 250 nma2 - no soundcard detected
Date: Fri, 20 Aug 2004 15:03:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040820130303.B364B1102E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 08B171F5
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2004 15:03:04 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000440
======================================================================
Reported By:                thelight
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     440
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 2
Kernel Version:             2.6.6-1.435.2.3
======================================================================
Date Submitted:             08-14-2004 19:38 CEST
Last Modified:              08-20-2004 15:03 CEST
======================================================================
Summary:                    Gateway Solo 250 nma2 - no soundcard detected
Description: 
The laptops specs say it has a 'neomagic nma 2' sound card onboard. From
what I can tell this is some sort of NeoMagic nm256 equivalent.

My main problem is that I simply get no sound. The fedora core 2 program
system-config-soundcard doesnt actually detect a soundcard at all. Im
using the 1.0.3 rpms of alsa which came with fedora. 
======================================================================

----------------------------------------------------------------------
 tiwai - 08-18-2004 11:59 CEST 
----------------------------------------------------------------------
2.6 kernel can load the unused modules.
I guess the PCI id of your device isn't listed on the supported
id table in nm256 driver.

Check it via lspci and try to add it to the pci_id table.
(Note that this may likely cause hang-up :)

----------------------------------------------------------------------
 thelight - 08-18-2004 15:37 CEST 
----------------------------------------------------------------------
Ive looked through the output of lspci -vv and no sound device is actually
listed there. The only output relating to neomagic is this which appears
to be for video:

00:02.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph
128XD] (rev 01) (prog-if 00 [VGA])
        Subsystem: Neomagic Corporation MagicGraph 128XD
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fd000000 (32-bit, prefetchable)
        Region 1: Memory at fea00000 (32-bit, non-prefetchable) [size=2M]
        Region 2: Memory at fed00000 (32-bit, non-prefetchable) [size=1M]

----------------------------------------------------------------------
 tiwai - 08-18-2004 15:45 CEST 
----------------------------------------------------------------------
Could you show the output of lspci -vv and lspci -nv?
Also, to be sure, check ISA PnP devices (see /sys/bus/pnp/devices/*),
too (an Acer laptop has the opl3sax compatible chip connected with
nm256).

----------------------------------------------------------------------
 thelight - 08-20-2004 15:03 CEST 
----------------------------------------------------------------------
After some research ive found the situation is similar with this Gateway
2500 laptop. It has an opl3sax chip connected with the nma2, however, it
is a non-pnp version so does not show up in lspci or /sys/bus/pnp/devices

For reference here is the requested output:

lspci -vv:

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(AGP disabled) (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR+
	Latency: 64
	Region 0: Memory at <unassigned> (32-bit, prefetchable)

00:02.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph
128XD] (rev 01) (prog-if 00 [VGA])
	Subsystem: Neomagic Corporation MagicGraph 128XD
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 128 (4000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fd000000 (32-bit, prefetchable)
	Region 1: Memory at fea00000 (32-bit, non-prefetchable) [size=2M]
	Region 2: Memory at fed00000 (32-bit, non-prefetchable) [size=1M]

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fcd0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at fce0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0a.0 CardBus bridge: Texas Instruments PCI1220 (rev 02)
	Subsystem: Unknown device 0099:0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 20
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1220 (rev 02)
	Subsystem: Unknown device 0099:0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 20
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 10001000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8180L
802.11b MAC (rev 20)
	Subsystem: Realtek Semiconductor Co., Ltd. RTL8180L 802.11b MAC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 4800
	Region 1: Memory at 11000000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

lspci -nv:

00:00.0 Class 0600: 8086:7192 (rev 02)
	Flags: bus master, medium devsel, latency 64
	Memory at <unassigned> (32-bit, prefetchable)

00:02.0 Class 0300: 10c8:0004 (rev 01)
	Subsystem: 10c8:0004
	Flags: bus master, medium devsel, latency 128, IRQ 10
	Memory at fd000000 (32-bit, prefetchable)
	Memory at fea00000 (32-bit, non-prefetchable) [size=2M]
	Memory at fed00000 (32-bit, non-prefetchable) [size=1M]

00:07.0 Class 0680: 8086:7110 (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 Class 0101: 8086:7111 (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at fcd0 [size=16]

00:07.2 Class 0c03: 8086:7112 (rev 01)
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at fce0 [size=32]

00:07.3 Class 0680: 8086:7113 (rev 02)
	Flags: medium devsel, IRQ 9

00:0a.0 Class 0607: 104c:ac17 (rev 02)
	Subsystem: 0099:0000
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 10000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:0a.1 Class 0607: 104c:ac17 (rev 02)
	Subsystem: 0099:0000
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 10001000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

05:00.0 Class 0200: 10ec:8180 (rev 20)
	Subsystem: 10ec:8180
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at 4800
	Memory at 11000000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [50] Power Management version 2

[root@citrus /]# ls -a /sys/bus/pnp/devices
.  ..

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-14-04 19:38 thelight       New Bug                                      
08-14-04 19:38 thelight       Distribution              => Fedora Core 2   
08-14-04 19:38 thelight       Kernel Version            => 2.6.6-1.435.2.3 
08-18-04 11:59 tiwai          Bugnote Added: 0001577                       
08-18-04 15:37 thelight       Bugnote Added: 0001582                       
08-18-04 15:45 tiwai          Bugnote Added: 0001584                       
08-20-04 15:03 thelight       Bugnote Added: 0001599                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
