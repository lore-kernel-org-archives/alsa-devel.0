From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002251]: Speaker sound is fine,
	but headphones not recognized, so no sound
Date: Sun, 2 Jul 2006 06:27:56 +0200
Message-ID: <f09fc08c081d4e7afc676b0e28459c35@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C06A4183
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Jul 2006 06:27:56 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2251> 
======================================================================
Reported By:                moret
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2251
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.17.2
======================================================================
Date Submitted:             07-02-2006 06:27 CEST
Last Modified:              07-02-2006 06:27 CEST
======================================================================
Summary:                    Speaker sound is fine, but headphones not
recognized, so no sound
Description: 
Sound comes through fine on built-in speakers.  Plugging in headphones
silences the built-in speakers, but nothing comes through on the
headphones
jack.
The machine is a Panasonic CF-Y5 (Japanese market) with L2300 Core Duo
processor, 82801G (ICH7) chipset, and the following audio device (from
lspci -vv), with device ID 27d8, identified by ALSA as a SigmaTel STAC
9200:

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
        Subsystem: Matsushita Electric Industrial Co., Ltd. Unknown device
8338
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at d0340000 (64-bit, non-prefetchable)
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
As hinted at by the lspci listing, the alsamixer list only one output
device
(the built-in speakers).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-02-06 06:27 moret          New Issue                                    
07-02-06 06:27 moret          Distribution              => Debian          
07-02-06 06:27 moret          Kernel Version            => 2.6.17.2        
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
