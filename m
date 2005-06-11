From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000943]: cmipci freezes the whole system
Date: Sat, 11 Jun 2005 23:48:26 +0200
Message-ID: <505d1eb5dd73edbf55c4311d33b49532@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 876541D1
	for <alsa-devel@alsa-project.org>; Sat, 11 Jun 2005 23:48:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=943> 
======================================================================
Reported By:                aisotton
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   943
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian Sid (Unstable)
Kernel Version:             2.6.10
======================================================================
Date Submitted:             02-25-2005 16:06 CET
Last Modified:              06-11-2005 23:48 CEST
======================================================================
Summary:                    cmipci freezes the whole system
Description: 
Hi,

I have a Terratec Aureon 5.1 PCI sound card, and an on-board 3Com 3c940
gigabit ethernet controller (the board is an Asus A7V600). The sound
card uses the cmipci module, and the ethernet card the sk98lin module.

Playing sound and using the network at the same time freezes the sytem
after a short time (generally 15-30 seconds); nothing is logged or
displayed (I checked syslog, kern.log and /var/log/messages), it just
freezes everything, forcing a reset of the machine (and after the
subsequent reboot my mouse isn't recognized any more, but I don't think
that matters).

I am using that network card since more than a year, and it never gave a
problem; thus I think the bug is in the cmipci driver (the system never
froze before I installed the sound card).

I did a memtest, but my memory seems to be ok.

This happens with all kernels I tested, specifically:

Debian kernel-image-2.6.10-1-k7-4
Debian kernel-image-2.6.9-2-k7-5
Debian kernel-image-2.6.8-2-k7-13
Debian kernel-image-2.6.10-1-k7-4 with PREEMPT deactivated
Vanilla kernel 2.6.10, compiled with the same options as Debian
kernel-image-2.6.10-1-k7-4.


======================================================================

----------------------------------------------------------------------
 sbambach - 06-11-05 23:46 
----------------------------------------------------------------------
Same soundcard. Same problem. Some seconds sound, then system freeze. 

settopbox with optical spdif out that doesn't play sound :-( Have to
switch to analog output or buy another card ? which ?

Some information missing ? Ask about it. I'll try to help of course.

Interesting bug about that problem found:
http://bugme.osdl.org/show_bug.cgi?id=1421

My system:
- Athlon XP
- kernel 2.6.11
- Distribution gentoo

/proc/version
Linux version 2.6.11-gentoo-r9 (root@mythtv) (gcc version 3.3.5-20050130
(Gentoo Linux 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1))
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
Sat May 21 22:46:32 CEST 2005

/proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13
09:39:32 2005 UTC).

/proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1700+
stepping        : 2
cpu MHz         : 1466.575
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse pni syscall mp mmxext 3dnowext 3dnow
bogomips        : 2899.96

/proc/interrupts (Plug and Play OS enabled):

           CPU0


  0:    7245938          XT-PIC  timer
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  uhci_hcd, uhci_hcd, uhci_hcd
  8:          2          XT-PIC  rtc
  9:          2          XT-PIC  acpi
 10:          0          XT-PIC  ohci_hcd
 11:     366481          XT-PIC  ohci_hcd, eth0, nvidia
 12:          3          XT-PIC  ehci_hcd, CMI8738-MC6
 14:      39396          XT-PIC  ide0
 15:      64630          XT-PIC  ide1
NMI:          0
LOC:    7239853
ERR:      43277

lspci -vvv:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW-
Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dde00000-dfefffff
        Prefetchable memory behind bridge: d1c00000-d5cfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:05.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit
Ethernet Controller
        Subsystem: Intel Corporation: Unknown device 1113
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dffa0000 (32-bit, non-prefetchable)
[size=dff60000]
        Region 1: Memory at dff80000 (32-bit, non-prefetchable)
[size=128K]
        Region 2: I/O ports at ec00 [size=64]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0]
Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

0000:00:06.0 Multimedia video controller: Internext Compression Inc iTVC15
MPEG-2 Encoder (rev 01)
        Subsystem: Hauppauge computer works Inc. WinTV PVR-350
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (32000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d8000000 (32-bit, prefetchable)
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 Multimedia audio controller: C-Media Electronics Inc CM8738
(rev 10)
        Subsystem: TERRATEC Electronic GmbH: Unknown device 1144
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at e800
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 Multimedia controller: Philips Semiconductors SAA7146 (rev
01)
        Subsystem: Technotrend Systemtechnik GmbH Technotrend-Budget /
Hauppauge WinTV-NOVA-T DVB card
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (3750ns min, 9500ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dffffe00 (32-bit, non-prefetchable)

0000:00:0b.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10
[OHCI])
        Subsystem: NEC Corporation USB
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dfffd000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10
[OHCI])
        Subsystem: NEC Corporation USB
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at dfffe000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20
[EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
3504
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8500ns max), cache line size 10
        Interrupt: pin C routed to IRQ 12
        Region 0: Memory at dffffd00 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if
8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA
TNT2 Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
        Subsystem: Elsa AG Erazor III LT
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de000000 (32-bit, non-prefetchable)
[size=dfef0000]
        Region 1: Memory at d2000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at 00010000 [disabled]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW-
Rate=x4

----------------------------------------------------------------------
 sbambach - 06-11-05 23:48 
----------------------------------------------------------------------
Sorry. Mantis corrupted this link. Trying another syntax ...

bugme.osdl.org/show_bug.cgi ? id=1421

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-25-05 16:06 aisotton       New Issue                                    
02-25-05 16:06 aisotton       Distribution              => Debian Sid (Unstable)
02-25-05 16:06 aisotton       Kernel Version            => 2.6.10          
02-25-05 16:07 aisotton       Note Added: 0003734                          
02-25-05 21:57 runderwo       Note Added: 0003736                          
02-26-05 02:33 aisotton       Note Added: 0003737                          
06-11-05 23:46 sbambach       Note Added: 0004996                          
06-11-05 23:48 sbambach       Note Added: 0004997                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
