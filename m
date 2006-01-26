From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001768]: ALi5451 AC'97 mixer error on boot
Date: Thu, 26 Jan 2006 23:50:53 +0100
Message-ID: <f1bfa9b0fd02ddcb036126037277c99c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 134AF188
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 23:50:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1768> 
======================================================================
Reported By:                liontooth
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1768
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-22-2006 12:53 CET
Last Modified:              01-26-2006 23:50 CET
======================================================================
Summary:                    ALi5451 AC'97 mixer error on boot
Description: 
On a Debian 2.6.15 kernel and the ALi5451 chipset, I get this in dmesg:

AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
ali mixer 1 creating error.


======================================================================

----------------------------------------------------------------------
 sashak - 01-26-06 00:50 
----------------------------------------------------------------------
I think there is crazy configuration - this modem is actually not ali5451,
but ali5457, and since everything is integrated in same chip (south
bridge) secondary codec is indicated in al5451 registers. Hmm, probably
should be some difference against "convensional" two codecs ali5451 setup.
Could you upload your '/proc/asound/card0/ali5451' file and lspci -vv
output?

And yes, the oops is irrelevant for ALSA.

----------------------------------------------------------------------
 liontooth - 01-26-06 23:50 
----------------------------------------------------------------------
'/proc/asound/card0/ali5451' file and lspci -vv output as requested below.

Let me add that the manual volume-control wheel on the side of the laptop
works on the built-in speaker but fails to regulate the volume of the
headphone channel. To turn on the headphone channel I have to do this:

# Turn IEC958 on
# Set IEC958 Playback AC97-SPSA to 0 
# Set IEC958 Playback Source to Analog/Digital conversion
# Turn Headphone Jack Sensor off 

I get mono sound only through the headphones. Anyway, here is the /proc
and lspci:

# cat /proc/asound/card0/ali5451
00: 00000000
04: 00000000
08: 00000000
0c: 00000000
10: 00000000
14: 00000000
18: 00000000
1c: 00000000
20: a71080a7
24: a71080a7
28: a71080a7
2c: a71080a7
30: 00003000
34: ffffffff
38: ffffffff
3c: ffffffff
40: 0405012a
44: 00000000
48: 03114200
4c: 00000004
50: 00008000
54: 00f5ac44
58: 00000000
5c: 0204004a
60: 00000000
64: 00000000
68: 00000000
6c: 00000000
70: 02000000
74: 09050000
78: 00000000
7c: 00000000
80: 00000000
84: 00000000
88: 00000000
8c: 00000000
90: 00000000
94: 00000000
98: 00000000
9c: 00000000
a0: 00003000
a4: 00000000
a8: 00000000
ac: 00000000
b0: 00008000
b4: 00008000
b8: 00008000
bc: 00008000
c0: 00000000
c4: 00000000
c8: 00ab6834
cc: 00000000
d0: 00000000
d4: 80000001
d8: 80000001
dc: 80000001
e0: 5f074381
e4: 2f12d07c
e8: c0eaa011
ec: fe376eff
f0: 9beb3919
f4: eca8f51f
f8: 57ce3415
fc: d3955ff8

# lspci -vv
0000:00:00.0 Host bridge: ALi Corporation M1671 Super P4 Northbridge
[AGP4X,PCI and SDR/DDR] (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [b0] AGP version 2.0
                Status: RQ=9 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
        Capabilities: [a4] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e9000000-e9ffffff
        Prefetchable memory behind bridge: ea000000-efffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 02)
        Subsystem: QUANTA Computer Inc: Unknown device 2201
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1000 [size=256]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin
IV]
        Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller (prog-if
00 [Generic])
        Subsystem: QUANTA Computer Inc: Unknown device 2201
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8001000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 1400 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Network controller: Intersil Corporation Prism 2.5 Wavelan
chipset (rev 01)
        Subsystem: AMBIT Microsystem Corp.: Unknown device 0200
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 255
        Region 0: Memory at e8008000 (32-bit, prefetchable) [disabled]
[size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 02)
        Subsystem: QUANTA Computer Inc: Unknown device 2201
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 34010000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 30000000-31fff000 (prefetchable)
        Memory window 1: 32000000-33fff000 (prefetchable)
        I/O window 0: 00002000-000020ff
        I/O window 1: 00002400-000024ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt-
PostWrite-
        16-bit legacy interface ports at 0001

0000:00:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 50) (prog-if 00 [UHCI])
        Subsystem: QUANTA Computer Inc: Unknown device 2201
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at 1800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 50) (prog-if 00 [UHCI])
        Subsystem: QUANTA Computer Inc: Unknown device 2201
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1820 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
(prog-if 20 [EHCI])
        Subsystem: QUANTA Computer Inc: Unknown device 2201
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x20 (128 bytes)
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at e8002000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: QUANTA Computer Inc: Unknown device 2201
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 255
        Region 0: Memory at e8002800 (32-bit, non-prefetchable) [disabled]
[size=2K]
        Region 1: Memory at e8004000 (32-bit, non-prefetchable) [disabled]
[size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if
fa)
        Subsystem: QUANTA Computer Inc: Unknown device 2201
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at 1840 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 Bridge: ALi Corporation M7101 Power Management Controller
[PMU]
        Subsystem: QUANTA Computer Inc: Unknown device 2201
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:12.0 Ethernet controller: National Semiconductor Corporation
DP83815 (MacPhyter) Ethernet Controller
        Subsystem: QUANTA Computer Inc: Unknown device 2201
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 90 (2750ns min, 13000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: Memory at e8003000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 34000000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4
420 Go 32M] (rev a3) (prog-if 00 [VGA])
        Subsystem: QUANTA Computer Inc: Unknown device 2201
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e9000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Region 2: Memory at ea000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at ea080000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

Dave

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-22-06 12:53 liontooth      New Issue                                    
01-22-06 12:53 liontooth      File Added: alsa-sigillo-2.6.15                   

01-22-06 12:53 liontooth      Distribution              => Debian sid      
01-22-06 12:53 liontooth      Kernel Version            => 2.6.15          
01-22-06 12:56 liontooth      Issue Monitored: liontooth                    
01-22-06 13:00 liontooth      Note Added: 0007745                          
01-26-06 00:50 sashak         Note Added: 0007782                          
01-26-06 23:50 liontooth      Note Added: 0007796                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
