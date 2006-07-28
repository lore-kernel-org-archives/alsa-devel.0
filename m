From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000997]: no sound at all
Date: Fri, 28 Jul 2006 03:47:04 +0200
Message-ID: <7b990da22906d5f058d5a7d3b5857e0d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D907F171
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 03:47:04 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=997> 
======================================================================
Reported By:                HawkHunter
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   997
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Linux S0106002078b04ca8 2.6.9-5.0.3.ELsmp #1 SMP Sat
Feb 19 19:38:02 CST 2005 i686 i686 i386 GNU/Linux
Kernel Version:             kernel-2.6.9-5.0.3.EL
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             03-17-2005 05:17 CET
Last Modified:              07-28-2006 03:47 CEST
======================================================================
Summary:                    no sound at all
Description: 
I cant get any sound - someone suggested that this would help you:

[root@S0106002078b04ca8 ~]# lspci -vv
00:01.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY
[Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon 7000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at b8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 4000 [size=256]
        Region 2: Memory at c6ef0000 (32-bit, non-prefetchable)
[size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 4
        Region 0: I/O ports at 4400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 Ethernet controller: Macronix, Inc. [MXIC] MX987x5 (rev 20)
        Subsystem: Unknown device 2078:0540
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at 4800 [size=256]
        Region 1: Memory at c6ee0000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [44] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1+,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 System peripheral: Compaq Computer Corporation System Management
Controller (rev 01)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: I/O ports at 4c00 [size=256]
        Region 1: Memory at c6ed0000 (32-bit, non-prefetchable)
[size=256]

00:0e.0 VGA compatible controller: Cirrus Logic GD 5430/40 [Alpine] (rev
22) (prog-if 00 [VGA])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at b7000000 (32-bit, prefetchable) [disabled]
[size=16M]

00:0f.0 EISA bridge: Intel Corp. 82375EB/SB PCI to EISA Bridge (rev 15)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248

00:14.0 RAM memory: Intel Corp. 450KX/GX [Orion] - 82453KX/GX Memory
controller (rev 05)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:19.0 Host bridge: Intel Corp. 450KX/GX [Orion] - 82454KX/GX PCI bridge
(rev 06)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 32, Cache Line Size 08

00:1a.0 Host bridge: Intel Corp. 450KX/GX [Orion] - 82454KX/GX PCI bridge
(rev 06)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32, Cache Line Size 08

01:08.0 Class ff00: Compaq Computer Corporation PCI Hotplug Controller
(rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device a2f7
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at c6ff0000 (32-bit, non-prefetchable)
[size=256]

01:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev
03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (4250ns min, 16000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 5000 [size=256]
        Region 1: Memory at c6fe0000 (32-bit, non-prefetchable)
[size=256]
        Region 2: Memory at c6fd0000 (32-bit, non-prefetchable) [size=4K]

01:0b.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev
03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (4250ns min, 16000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 5400 [size=256]
        Region 1: Memory at c6fc0000 (32-bit, non-prefetchable)
[size=256]
        Region 2: Memory at c6fb0000 (32-bit, non-prefetchable) [size=4K]

[root@S0106002078b04ca8 ~]#

Cheers, and thanks in advance for the help
Trev
======================================================================

----------------------------------------------------------------------
 perex - 06-06-05 10:25 
----------------------------------------------------------------------
Could you be more specific? Do you have installed and configured the
snd-cmipci driver?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-05 05:17 HawkHunter     New Issue                                    
03-17-05 05:17 HawkHunter     Distribution              => Linux
S0106002078b04ca8 2.6.9-5.0.3.ELsmp #1 SMP Sat Feb 19 19:38:02 CST 2005 i686
i686 i386 GNU/Linux
03-17-05 05:17 HawkHunter     Kernel Version            => kernel-2.6.9-5.0.3.EL
06-06-05 10:25 perex          Note Added: 0004892                          
06-06-05 10:25 perex          Assigned To              perex =>            
06-06-05 10:25 perex          Category                 0_compilation problem_!!!
=> PCI - cmipci
07-28-06 03:47 Adrian Bunk    Status                   assigned => closed  
07-28-06 03:47 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
