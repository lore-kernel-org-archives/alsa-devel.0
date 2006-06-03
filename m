From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002131]: Sound works with distortion
	on laptop Asus A6J series A6JC model (HDA Intel/Realtek ALC880)
Date: Sat, 3 Jun 2006 19:47:29 +0200
Message-ID: <7f2edb59fc4995abaa2735d98dc8b70a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 096FF169
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Jun 2006 19:47:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2131> 
======================================================================
Reported By:                paulomatos
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2131
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               RHEL4/CentOS4
Kernel Version:             2.6.9-34.EL
======================================================================
Date Submitted:             05-17-2006 17:36 CEST
Last Modified:              06-03-2006 19:47 CEST
======================================================================
Summary:                    Sound works with distortion on laptop Asus A6J
series A6JC model (HDA Intel/Realtek ALC880)
Description: 
Only thing I can play perfectly is wav format.
All other things get distortion when volume reaches half way.

Here goes some information:
[root@localhost ~]# lspci -vv  | grep -A24 ^00:1b.0
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 1123
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 08
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at febfc000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
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

[root@localhost ~]# lspci -nvv  | grep -A24 ^00:1b.0
00:1b.0 Class 0403: 8086:27d8 (rev 02)
        Subsystem: 1043:1123
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 08
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at febfc000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
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

======================================================================

----------------------------------------------------------------------
 paulomatos - 06-03-06 19:47 
----------------------------------------------------------------------
Any news on this?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-17-06 17:36 paulomatos     New Issue                                    
05-17-06 17:36 paulomatos     File Added: asound.state                     
05-17-06 17:36 paulomatos     Distribution              => RHEL4/CentOS4   
05-17-06 17:36 paulomatos     Kernel Version            => 2.6.9-34.EL     
05-17-06 17:37 paulomatos     File Added: codec0.txt                       
05-17-06 17:37 paulomatos     File Added: codec1.txt                       
05-17-06 17:38 paulomatos     File Added: oss_mixer.txt                    
05-17-06 17:38 paulomatos     File Added: pcm0c.info.txt                    
05-17-06 17:39 paulomatos     File Added: pcm0p.info.txt                    
05-17-06 17:39 paulomatos     File Added: pcm1c.info.txt                    
05-17-06 17:39 paulomatos     File Added: pcm2p.info.txt                    
05-17-06 17:41 paulomatos     Issue Monitored: paulomatos                    
05-24-06 13:59 fuman          Issue Monitored: fuman                       
06-03-06 19:47 paulomatos     Note Added: 0010064                          
======================================================================
