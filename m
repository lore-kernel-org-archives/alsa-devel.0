From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000486]: Sony Vaio vgn-a115z require ac97_quirk=-1
Date: Tue,  7 Sep 2004 22:15:54 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907201554.EDAF8E001@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1334324F
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 22:16:01 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id E317C2090E
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 22:15:56 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000486
======================================================================
Reported By:                sandro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     486
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian Sid
Kernel Version:             2.6.9-rc1-bk14
======================================================================
Date Submitted:             09-07-2004 22:15 CEST
Last Modified:              09-07-2004 22:15 CEST
======================================================================
Summary:                    Sony Vaio vgn-a115z require ac97_quirk=-1
Description: 
Sony Vaio vgn-a115z require ac97_quirk=-1

i'm not sure if this problem is related with bug 0000467 but ac97_quirk=-1
solve the  problem for me

0000:00:1f.5 0401: 8086:24c5 (rev 03)
        Subsystem: 104d:818b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at ee00 [size=256]
        Region 1: I/O ports at e000 [size=64]
        Region 2: Memory at ff7ff800 (32-bit, non-prefetchable)
[size=512]
        Region 3: Memory at ff7ff400 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-07-04 22:15 sandro         New Bug                                      
09-07-04 22:15 sandro         Distribution              => Debian Sid      
09-07-04 22:15 sandro         Kernel Version            => 2.6.9-rc1-bk14  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
