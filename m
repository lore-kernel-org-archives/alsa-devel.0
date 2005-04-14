From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000578]:  No soundcard detected on Chaintech 9CJS
Date: Thu, 14 Apr 2005 12:53:44 +0200
Message-ID: <262a918eaf9a4dc3f5e8f6d2dd83a93a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4030D221
	for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2005 12:53:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=578> 
======================================================================
Reported By:                tarsi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   578
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               mandrake linux 10.1
Kernel Version:             2.6.8.1-10mdksmp
======================================================================
Date Submitted:             10-11-2004 12:58 CEST
Last Modified:              04-14-2005 12:53 CEST
======================================================================
Summary:                     No soundcard detected on Chaintech 9CJS
Description: 
 cat /proc/asound/cards don't stop and gives many lines "--no souncards--"

/etc/init.d/alsaconf found ice1724 card, but exiting gives:
.... 

/usr/sbin/alsactl: save_state:1066: No soundcards found...

======================================================================

----------------------------------------------------------------------
 jdthood - 04-09-05 16:09 
----------------------------------------------------------------------
Submitter: Did you find a solution for this problem?

----------------------------------------------------------------------
 tarsi - 04-14-05 12:53 
----------------------------------------------------------------------
using "model=k8x800", soundcard is detected correctly. After some week, my
soundcard have others problems with sound quality (very disturbed) but i
think not related with this bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-11-04 12:58 tarsi          New Issue                                    
10-11-04 12:58 tarsi          File Added: command-outputs.tar.bz2               
    
10-11-04 12:58 tarsi          Distribution              => mandrake linux 10.1
10-11-04 12:58 tarsi          Kernel Version            => 2.6.8.1-10mdksmp
10-11-04 12:58 tarsi          Issue Monitored: tarsi                       
10-11-04 15:59 tiwai          Note Added: 0002081                          
04-09-05 16:09 jdthood        Note Added: 0004407                          
04-14-05 12:53 tarsi          Note Added: 0004491                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
