From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000078]: intr not received after h/w un-reset.
Date: Fri, 1 Apr 2005 22:54:44 +0200
Message-ID: <ef341e3cc7073a5153c10cc49c473a04@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D2BDD235
	for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2005 22:54:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=78> 
======================================================================
Reported By:                sman
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   78
Category:                   ISA - wavefront
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             Tried with 2.4.*
======================================================================
Date Submitted:             02-22-2004 12:48 CET
Last Modified:              04-01-2005 22:54 CEST
======================================================================
Summary:                    intr not received after h/w un-reset.
Description: 
The last version of alsa-driver with which the wavefront driver worked was
0.9.0_rc2 - all later versions give the following error (with identical
configurations as the last working version, taking into account the
changes in the configuration file format):
isapnp: Scanning for Pnp cards... 
isapnp: Card 'Tropez Plus' 
isapnp: 1 Plug & Play card detected total 
ALSA card-wavefront.c:227: isapnp CS4232: port=0x530, fm port=0x388, wss
port=0x534 
ALSA card-wavefront.c:229: isapnp CS4232: dma1=1, dma2=0, irq=5 
ALSA card-wavefront.c:288: isapnp SYNTH: port=0x200, irq=15 
ALSA wavefront.c:2280: no response to firmware probe, assume raw. 
ALSA wavefront.c:1765: invalid IRQ 0 
ALSA wavefront.c:1925: intr not received after h/w un-reset. 
ALSA wavefront.c:2108: hw reset failed. 
ALSA card-wavefront.c:592: can't allocate WaveFront synth device 
ALSA card-wavefront.c:334: deactivating PnP devices 
ALSA card-wavefront.c:773: No cards found or devices busy 
======================================================================

----------------------------------------------------------------------
 tiwai - 04-14-04 15:10 
----------------------------------------------------------------------
sorry but it's really hard to debug.
the driver is old and unmaintained, and no ALSA developers have this
board.  (also i have no technical info about this.)
my changes are after the break of 0.9.0rc2, so most likely irrelevant.

you might be able to contact with Paul Davis, who is the original
author and has more clue about what this error message means.

----------------------------------------------------------------------
 jdthood - 04-01-05 22:54 
----------------------------------------------------------------------
Submitter: Any progress on this issue?  Did you contact Paul Davis?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-04 12:48 sman           New Issue                                    
02-22-04 17:52 sman           Note Added: 0000289                          
02-22-04 17:53 sman           Issue Monitored: sman                        
02-22-04 17:58 sman           Issue End Monitor: sman                      
03-15-04 23:52 sman           Note Added: 0000624                          
03-30-04 00:40 sman           Note Added: 0000716                          
04-07-04 22:25 sman           Issue Monitored: sman                        
04-11-04 01:38 sman           Issue Monitored: tiwai                       
04-11-04 01:38 sman           Note Added: 0000779                          
04-14-04 15:10 tiwai          Note Added: 0000803                          
04-01-05 22:54 jdthood        Note Added: 0004294                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
