From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000453]: it is impossible to select spdif as capture source
Date: Fri, 12 Nov 2004 12:25:22 +0100
Message-ID: <dd5c109bd7876894bdaf1cb8b5fab392@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 628D4280
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2004 12:25:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=453> 
======================================================================
Reported By:                Andrew
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   453
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-18-2004 13:16 CEST
Last Modified:              11-12-2004 12:25 CET
======================================================================
Summary:                    it is impossible to select spdif as capture source
Description: 
There are no anything spdif-input-related among
capture source enumeration.
======================================================================

----------------------------------------------------------------------
 ungod - 09-29-04 05:28 
----------------------------------------------------------------------
I've looked a bit closer on the Aureon card. Apparently RXP0 is the digital
CD input and RXP1 is optical on the Space model. On the universe it seems
that RXP1 is used for both optical and coax and some additional chip (on
the 5.25" bay) does the the Optical/Coax choice.

I personally only have the Space card, but if you have the Universe model,
this is most likely the reason why you will get no sound.

I've been working on adding S/PDIF input settings (So far a mute and a
Optical/CD in selection), but I don't really want to publish anything
until I know how it works on the Universe model.

----------------------------------------------------------------------
 tiwai - 10-12-04 14:54 
----------------------------------------------------------------------
I assume it's fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 13:16 Andrew         New Issue                                    
08-25-04 19:55 tiwai          Note Added: 0001625                          
08-25-04 23:47 Andrew         Note Added: 0001628                          
08-27-04 19:39 tiwai          Note Added: 0001648                          
09-07-04 10:33 Andrew         Note Added: 0001706                          
09-08-04 17:16 tiwai          Note Added: 0001734                          
09-08-04 17:55 Andrew         Note Added: 0001737                          
09-23-04 18:48 tiwai          Note Added: 0001832                          
09-23-04 20:34 ungod          Note Added: 0001847                          
09-23-04 20:35 ungod          Note Edited: 0001847                         
09-23-04 20:38 ungod          Note Edited: 0001847                         
09-23-04 20:39 ungod          Note Edited: 0001847                         
09-23-04 20:40 ungod          Note Edited: 0001847                         
09-24-04 04:10 ungod          File Added: ice1724-spdif.diff                    
09-24-04 04:14 ungod          Note Added: 0001854                          
09-24-04 10:11 Andrew         Note Added: 0001859                          
09-24-04 11:10 tiwai          Note Added: 0001860                          
09-24-04 13:44 ungod          Note Added: 0001883                          
09-24-04 13:51 ungod          Note Added: 0001884                          
09-24-04 14:32 tiwai          Note Added: 0001885                          
09-24-04 14:36 ungod          Note Added: 0001887                          
09-24-04 14:36 ungod          File Added: ice1724-spdif2.diff                   

09-24-04 14:42 tiwai          Note Added: 0001888                          
09-24-04 15:02 ungod          Note Edited: 0001887                         
09-25-04 01:13 ungod          Note Added: 0001907                          
09-29-04 05:28 ungod          Note Added: 0001966                          
10-12-04 14:54 tiwai          Status                   new => resolved     
10-12-04 14:54 tiwai          Resolution               open => fixed       
10-12-04 14:54 tiwai          Assigned To               => tiwai           
10-12-04 14:54 tiwai          Note Added: 0002100                          
11-12-04 12:25 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
