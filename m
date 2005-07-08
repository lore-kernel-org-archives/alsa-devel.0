From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000750]: no sound since 2.6.8.1
Date: Fri, 8 Jul 2005 10:37:36 +0200
Message-ID: <beb0c95a0fdcb935a109cf1bb5a93c64@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0D03518A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:37:37 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=750> 
======================================================================
Reported By:                aquarichy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   750
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware 10
Kernel Version:             2.6.9+
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-28-2004 02:20 CET
Last Modified:              07-08-2005 10:37 CEST
======================================================================
Summary:                    no sound since 2.6.8.1
Description: 
Sound using a kernel.org 2.6.8.1 kernel with ALSA built-in worked.  When I
compile  any newer stable kernel, there is no sound.  Compilation executes
without complaints.  No Sound related options change.  I have even tried
saying No to all the new options 2.6.9 and .10 provided in fear that one
of those might be interfering, but nada.  
======================================================================

----------------------------------------------------------------------
 FrankS - 02-05-05 20:42 
----------------------------------------------------------------------
tiwai,
I finally got a chance to try the patch today. I applied it to the current
CVS files, and I did get sound without needing to set the ac97_quirk to 0.
 On my system, the patch works.

Thanks,
Frank

----------------------------------------------------------------------
 jdthood - 04-13-05 17:15 
----------------------------------------------------------------------
Good work, all.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 02:20 aquarichy      New Issue                                    
12-28-04 02:20 aquarichy      Distribution              => Slackware 10    
12-28-04 02:20 aquarichy      Kernel Version            => 2.6.9+          
12-29-04 08:23 aquarichy      Note Added: 0002993                          
12-29-04 14:12 tiwai          Note Added: 0002996                          
12-29-04 19:02 aquarichy      Note Added: 0003007                          
12-29-04 19:17 aquarichy      Note Added: 0003008                          
12-29-04 19:37 aquarichy      Note Added: 0003009                          
12-29-04 20:39 aquarichy      Note Added: 0003011                          
12-29-04 20:46 rlrevell       Note Added: 0003012                          
12-30-04 00:07 aquarichy      Note Added: 0003015                          
12-30-04 06:05 aquarichy      Note Edited: 0003015                         
12-30-04 06:36 aquarichy      Note Added: 0003017                          
12-30-04 13:02 tiwai          Note Added: 0003018                          
12-31-04 06:30 aquarichy      Note Added: 0003024                          
01-03-05 12:07 tiwai          Note Added: 0003053                          
01-03-05 20:30 aquarichy      Note Added: 0003074                          
01-24-05 04:10 FrankS         Note Added: 0003389                          
01-25-05 15:22 tiwai          Note Added: 0003403                          
01-31-05 19:10 tiwai          Note Added: 0003457                          
02-01-05 16:33 FrankS         File Added: ac97info.tar.gz                    
02-01-05 16:37 FrankS         Note Added: 0003462                          
02-02-05 11:14 tiwai          Note Added: 0003482                          
02-02-05 11:14 tiwai          File Added: ac97-bind-hp2.diff                    
02-05-05 20:42 FrankS         Note Added: 0003524                          
04-13-05 17:15 jdthood        Note Added: 0004471                          
04-13-05 17:15 jdthood        Status                   new => resolved     
04-13-05 17:15 jdthood        Resolution               open => fixed       
07-08-05 10:37 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
