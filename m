From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001127]: kernel panic while accessing midi
Date: Tue, 9 Aug 2005 13:46:27 +0200
Message-ID: <762d061f75dbd202296aa3233dddaa01@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DEE8E21C
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:46:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1127> 
======================================================================
Reported By:                ulrichmoehrke
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1127
Category:                   PCI - als4000
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               debian sarge (kernel from sid)
Kernel Version:             2.6.11 (2.6.11-1-k7)
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-26-2005 09:48 CEST
Last Modified:              08-09-2005 13:46 CEST
======================================================================
Summary:                    kernel panic while accessing midi
Description: 
When I try to play a midi file the system freezes/kernel panic.
======================================================================

----------------------------------------------------------------------
 ulrichmoehrke - 05-30-05 22:31 
----------------------------------------------------------------------
The patch helps. Thank you.

----------------------------------------------------------------------
 tiwai - 05-31-05 12:51 
----------------------------------------------------------------------
The patch is already on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-26-05 09:48 ulrichmoehrke  New Issue                                    
05-26-05 09:48 ulrichmoehrke  File Added: aadebug.out                      
05-26-05 09:48 ulrichmoehrke  Distribution              => debian sarge (kernel
from sid)
05-26-05 09:48 ulrichmoehrke  Kernel Version            => 2.6.11 (2.6.11-1-k7)
05-27-05 12:32 tiwai          Note Added: 0004749                          
05-27-05 12:32 tiwai          File Added: als4000-mpu401-fix.diff               
    
05-30-05 22:31 ulrichmoehrke  Note Added: 0004821                          
05-31-05 12:51 tiwai          Status                   new => resolved     
05-31-05 12:51 tiwai          Resolution               open => fixed       
05-31-05 12:51 tiwai          Assigned To               => tiwai           
05-31-05 12:51 tiwai          Note Added: 0004822                          
08-09-05 13:46 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
