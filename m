From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000194]: Prodigy 192 -  Eprom incorrect size?
Date: Tue, 9 Nov 2004 16:19:26 +0100
Message-ID: <023acefe925bb019d9d9ec78d2075c07@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4ACF4247
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:19:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=194> 
======================================================================
Reported By:                jvlake
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   194
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               RedHat 9 _ 2.4.20.8
Kernel Version:             RedHat9 _ 2.4.20.8
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-07-2004 06:06 CEST
Last Modified:              11-09-2004 16:19 CET
======================================================================
Summary:                    Prodigy 192 -  Eprom incorrect size?
Description: 
after compiling the driver and rebooting i get a message that the eprom is
the wrong size for my card (on startup) needless to say, I also get no
sound. I am assuming this is because this card is not a 'prodigy 7.1' but
a 'prodigy 192' even though both cards are made by Audiotrak are 24/192khz
& 7.1. to look at the cards they are almost identical. is there anyway I
can get the driver to work?
======================================================================

----------------------------------------------------------------------
 co2b - 09-07-04 16:37 
----------------------------------------------------------------------
Prodigy192 uses Sigmatel STAC9460 audio codec, so Prodigy7.1 driver does
not work.
STAC9460 data sheet is here:
http://www.sigmatel.com/products/technical_docs.htm#9460

I wrote a patch for this card (it is against Linux-2.6.8-rc2).

----------------------------------------------------------------------
 perex - 09-07-04 17:03 
----------------------------------------------------------------------
The patch was applied to CVS. Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-07-04 06:06 jvlake         New Issue                                    
04-07-04 06:06 jvlake         Distribution              => RedHat 9 _ 2.4.20.8
04-07-04 06:06 jvlake         Kernel Version            => RedHat9 _ 2.4.20.8
04-07-04 06:09 jvlake         Note Added: 0000760                          
04-07-04 06:10 jvlake         Issue Monitored: jvlake                      
04-07-04 19:47 perex          Category                 PCI - ice1712 => PCI -
ice1724
04-07-04 19:53 perex          Severity                 major => feature    
04-07-04 19:53 perex          Status                   new => confirmed    
04-07-04 19:54 perex          Note Added: 0000763                          
04-16-04 16:00 tiwai          Note Added: 0000838                          
06-18-04 17:45 Apostolos DimitromanolakisNote Added: 0001319                    
     
06-18-04 18:01 Apostolos DimitromanolakisIssue Monitored: Apostolos
Dimitromanolakis                    
09-07-04 16:37 co2b           Note Added: 0001711                          
09-07-04 16:38 co2b           File Added: linux-2.6.8-rc2-prodigy192.patch      
             
09-07-04 17:03 perex          Status                   confirmed => resolved
09-07-04 17:03 perex          Resolution               open => fixed       
09-07-04 17:03 perex          Assigned To               => perex           
09-07-04 17:03 perex          Note Added: 0001719                          
11-09-04 16:19 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
