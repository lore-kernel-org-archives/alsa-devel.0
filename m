From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002060]: Intel HDA Soft modem
Date: Sun, 23 Apr 2006 01:29:49 +0200
Message-ID: <686d644a28eceb63428129eedeb99148@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 65BA112E
	for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2006 01:29:49 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2060> 
======================================================================
Reported By:                fdoffizi01
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2060
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.15
======================================================================
Date Submitted:             04-23-2006 01:29 CEST
Last Modified:              04-23-2006 01:29 CEST
======================================================================
Summary:                    Intel HDA Soft modem
Description: 
I'd like to use my hda softmodem but it's not even recognised from system.

Here lspci output:
 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
         Subsystem: Sony Corporation Unknown device 81ef
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 10
         Interrupt: pin A routed to IRQ 66
         Region 0: Memory at d2300000 (64-bit, non-prefetchable)
[size=16K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                 Address: 0000000000000000 Data: 0000
         Capabilities: [70] Express Unknown type IRQ 0
                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: Errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed unknown, Width x0, ASPM unknown,
Port 0
                 Link: Latency L0s <64ns, L1 <1us
                 Link: ASPM Disabled CommClk- ExtSynch-
                 Link: Speed unknown, Width x0
         Capabilities: [100] Virtual Channel
         Capabilities: [130] Unknown (5)
 
 And as you can see current hda modules can't see modem functions:
 
 aplay -l
 **** List of PLAYBACK Hardware Devices ****
 card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
   Subdevices: 0/1
   Subdevice #0: subdevice #0
 
 Hardware is a Sony Vaio FE11x series notebook.
It doesn't even work with linuxant driver (that now should support hda
softmodems)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-23-06 01:29 fdoffizi01     New Issue                                    
04-23-06 01:29 fdoffizi01     Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
