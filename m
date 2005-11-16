From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001457]: Lagged sound
Date: Wed, 16 Nov 2005 13:05:36 +0100
Message-ID: <d9fa20023a6ee0ee4d6ab991b7461e8d@85.132.177.35>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from 85.132.177.35 (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0421F1B6
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2005 13:05:36 +0100 (MET)
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
<https://85.132.177.35/alsa-bug/view.php?id=1457> 
======================================================================
Reported By:                mouse
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1457
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               ALT Linux
Kernel Version:             from 2.6.10 to 2.6.12
======================================================================
Date Submitted:             09-25-2005 12:56 CEST
Last Modified:              11-16-2005 13:05 CET
======================================================================
Summary:                    Lagged sound
Description: 
Played music a bit lagged and in dmesg I see:
vortex: IRQ fifo error
======================================================================

----------------------------------------------------------------------
 mouse - 09-25-05 13:00 
----------------------------------------------------------------------
lspci -vvn:

0000:00:0e.0 Class 0401: 12eb:0002 (rev fe)
        Subsystem: 1092:3003
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 3000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at df000000 (32-bit, non-prefetchable)
        Region 1: I/O ports at b800 [size=8]
        Region 2: I/O ports at bc00 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

----------------------------------------------------------------------
 Raymond - 11-16-05 13:05 
----------------------------------------------------------------------
What is the southbridge chipset on your motherboard ?

Do your MX300 sharing IRQ with other cards ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-05 12:56 mouse          New Issue                                    
09-25-05 12:56 mouse          Distribution              => ALT Linux       
09-25-05 12:56 mouse          Kernel Version            => from 2.6.10 to 2.6.12
09-25-05 13:00 mouse          Note Added: 0006386                          
09-25-05 13:00 mouse          File Added: au8830                           
11-16-05 13:05 Raymond        Note Added: 0006739                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
