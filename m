From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001683]: hda sound card not corectly detected
Date: Tue, 27 Dec 2005 01:29:16 +0100
Message-ID: <d48c52e59384cc41527bac8ac7432be5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DDED6162
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2005 01:29:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1683> 
======================================================================
Reported By:                corwyn_astrafall
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1683
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             gentoo-2.6.14-R6
======================================================================
Date Submitted:             12-26-2005 21:35 CET
Last Modified:              12-27-2005 01:29 CET
======================================================================
Summary:                    hda sound card not corectly detected
Description: 
i've a hda sound card in a notebook with 3 speaker, one mic input, one mic
integrated, one headphone output with an optical output, and a wheel
controler for the volume

lspci -vv output :
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
        Subsystem: Fujitsu Siemens Computer GmbH Unknown device 107c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at febf8000 (64-bit, non-prefetchable)
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
 rlrevell - 12-26-05 21:56 
----------------------------------------------------------------------
What exactly does not work?

----------------------------------------------------------------------
 corwyn_astrafall - 12-27-05 01:29 
----------------------------------------------------------------------
what doesn't work is the detection of the card at the loading of the
modules and the fact that the way to controle the 3 internal speaker (left
right and subwoofer) with alsamixer is the headphone volume.
and if there is a way to know if the integrated wheel can be use to
controle the volume.
thanks

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-05 21:35 corwyn_astrafallNew Issue                                    
12-26-05 21:35 corwyn_astrafallDistribution              => gentoo          
12-26-05 21:35 corwyn_astrafallKernel Version            => gentoo-2.6.14-R6
12-26-05 21:56 rlrevell       Note Added: 0007163                          
12-27-05 01:29 corwyn_astrafallNote Added: 0007165                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
