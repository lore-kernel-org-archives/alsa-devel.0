From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000118]: Soundcard doesn't produce any output
Date: Mon, 28 Mar 2005 04:13:07 +0200
Message-ID: <0cc01b389b0d1910699b25ebc7be2e5d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A14DE152
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2005 04:13:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=118> 
======================================================================
Reported By:                jordi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   118
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-05-2004 11:53 CET
Last Modified:              03-28-2005 04:13 CEST
======================================================================
Summary:                    Soundcard doesn't produce any output
Description: 
This card had been working ok until 0.9.6 or 0.9.7. When I upgraded to
0.9.8 and until now, the card hasn't been able to produce any output,
although the driver gets loaded correctly.
The OSS driver works correctly. It's not, I believe, a muted mixer
problem.
======================================================================

----------------------------------------------------------------------
 pawlik - 05-31-04 18:33 
----------------------------------------------------------------------
I have exactly the same problem. I own a Soltek 75DRV motherboard with VIA
8233A chip and I'm forced to use ALSA 0.9.6 because every version above
doesn't produce any sound...

Output of lspci -vv:
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 40)
        Subsystem: VIA Technologies, Inc.: Unknown device 4161
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

----------------------------------------------------------------------
 jdthood - 03-28-05 04:13 
----------------------------------------------------------------------
Submitter: Has this problem been fixed in later versions of ALSA?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-05-04 11:53 jordi          New Issue                                    
03-06-04 16:06 mhdyousif      Note Added: 0000519                          
03-08-04 11:48 tiwai          Note Added: 0000529                          
03-08-04 15:18 mhdyousif      File Added: asound.state                     
03-08-04 15:22 mhdyousif      Note Added: 0000533                          
03-08-04 15:27 tiwai          Note Added: 0000534                          
03-08-04 18:12 mhdyousif      Note Added: 0000536                          
03-08-04 19:30 jordi          Note Added: 0000537                          
03-08-04 19:30 jordi          File Added: asound.state                     
03-10-04 12:26 jordi          Note Added: 0000560                          
03-10-04 17:44 tiwai          Note Added: 0000562                          
03-12-04 12:58 bacsa81        File Added: ac97#0-0                         
03-12-04 12:58 bacsa81        Issue Monitored: bacsa81                     
03-12-04 12:58 bacsa81        File Added: ac97#0-0+regs                    
03-12-04 13:00 bacsa81        Note Added: 0000574                          
03-25-04 18:45 jordi          Note Added: 0000706                          
05-31-04 18:33 pawlik         Note Added: 0001284                          
05-31-04 18:34 pawlik         Note Added: 0001285                          
05-31-04 18:35 pawlik         Note Deleted: 0001285                        
03-28-05 04:13 jdthood        Note Added: 0004232                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
