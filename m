From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001915]: Module snd-intel8x0 for ALI 5455 card needs special option to work
Date: Sat, 11 Mar 2006 23:06:28 +0100
Message-ID: <54c20e2331d50f127994de4090d443d4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B0AE81BB
	for <alsa-devel@alsa-project.org>; Sat, 11 Mar 2006 23:06:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1915> 
======================================================================
Reported By:                ekalin
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1915
Category:                   alsaconf
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-11-2006 23:06 CET
Last Modified:              03-11-2006 23:06 CET
======================================================================
Summary:                    Module snd-intel8x0 for ALI 5455 card needs special
option to work
Description: 
The ALI 5455 card, at least the model whose lspci -vv output is shown
below, needs the "buggy_semaphore=1" to work. If this option is not
passed, the module does load, but no sound cards are identified. So
alsaconf should add this option to the modules configuration file when the
card is detected.

Here's the output of lspci -vv:
0000:00:04.0 Multimedia audio controller: ALi Corporation M5455 PCI
AC-Link Controller Audio Device (rev 20)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at c800 [size=256]
        Region 1: Memory at fbdff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 23:06 ekalin         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
