From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000486]: Sony Vaio vgn-a115z require ac97_quirk=-1
Date: Mon, 14 Feb 2005 19:36:27 +0100
Message-ID: <84220044fbd25736b111b112e51ebb0f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0BCDA248
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:36:27 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=486> 
======================================================================
Reported By:                sandro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   486
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian Sid
Kernel Version:             2.6.9-rc1-bk14
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             09-07-2004 22:15 CEST
Last Modified:              02-14-2005 19:36 CET
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

----------------------------------------------------------------------
 tiwai - 09-08-04 17:10 
----------------------------------------------------------------------
Seems to be a false positive.

Your device isn't listed on the quirk list, so ac97_quirk=-1 has
no influence on the behavior.  Or, is it a typo of 1?

----------------------------------------------------------------------
 tiwai - 01-13-05 17:25 
----------------------------------------------------------------------
No reponse.  Closing now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-07-04 22:15 sandro         New Issue                                    
09-07-04 22:15 sandro         Distribution              => Debian Sid      
09-07-04 22:15 sandro         Kernel Version            => 2.6.9-rc1-bk14  
09-08-04 17:10 tiwai          Note Added: 0001733                          
01-13-05 17:25 tiwai          Status                   new => resolved     
01-13-05 17:25 tiwai          Resolution               open => unable to
duplicate
01-13-05 17:25 tiwai          Assigned To               => tiwai           
01-13-05 17:25 tiwai          Note Added: 0003193                          
01-13-05 17:25 tiwai          Assigned To              tiwai =>            
02-14-05 19:36 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
