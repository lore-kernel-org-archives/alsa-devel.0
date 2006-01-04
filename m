From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001675]: Shuttle SD11G5 (pentium M) CA0106 sound card
Date: Wed, 4 Jan 2006 14:37:51 +0100
Message-ID: <c2ab410f7944e04cbd3de5035d34451a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DB9BA184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 14:37:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1675> 
======================================================================
Reported By:                vava
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1675
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             kernel 2.6.14.4
======================================================================
Date Submitted:             12-23-2005 09:45 CET
Last Modified:              01-04-2006 14:37 CET
======================================================================
Summary:                    Shuttle SD11G5 (pentium M) CA0106 sound card
Description: 
 Recently buy a Shuttle SD11G5 (pentium M)

Sound card reports as :
0000:02:09.0 Multimedia audio controller: Creative Labs SB Audigy LS

0000:02:09.0 0401: 1102:0007
        Subsystem: 1297:3041
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at c000 [size=32]
        Capabilities: [dc] Power Management version 2

0 [CA0106 ]: CA0106 - CA0106
                     AudigyLS [Unknown] at 0xc000 irq 19

recompiling my kernel Linux 2.6.14.4

and I got the same behaviour discribe in this bug report.
sound card seem to works fine, xmms and others players looks like
playing sound.

but after moving every switch on alsamixer, still no sound.


************
Trying to find out a solution with Bug 1636
After checking out cvs tree and installing latest version
still no sound




======================================================================

----------------------------------------------------------------------
 vava - 12-27-05 10:49 
----------------------------------------------------------------------
0000:02:09.0 Multimedia audio controller: Creative Labs SB Audigy LS
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device 3041
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at c000 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

----------------------------------------------------------------------
 vava - 01-04-06 14:37 
----------------------------------------------------------------------
Problem connected to :

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1600

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-23-05 09:45 vava           New Issue                                    
12-23-05 09:45 vava           Distribution              => Debian          
12-23-05 09:45 vava           Kernel Version            => kernel 2.6.14.4 
12-27-05 10:49 vava           Note Added: 0007168                          
12-28-05 22:23 sjenkins       Issue Monitored: sjenkins                    
01-04-06 14:37 vava           Note Added: 0007419                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
