From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000368]: vxpocket.c missing from 1.0.5 releases
Date: Tue, 9 Nov 2004 16:17:30 +0100
Message-ID: <cb9dc2b79b9e5cdc661501e7ca1ee072@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 93824244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:17:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=368> 
======================================================================
Reported By:                benjif
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   368
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 duplicate
Duplicate:                  379
Fixed in Version:           
======================================================================
Date Submitted:             07-06-2004 18:40 CEST
Last Modified:              11-09-2004 16:17 CET
======================================================================
Summary:                    vxpocket.c missing from 1.0.5 releases
Description: 
The file pcmcia/vx/vxpocket.c is missing from 1.0.5rc1, 1.0.5, and 1.0.5a. 
This causes make to fail when attempting to build the vxp440 driver. 
1.0.4 builds just fine with the same ./configure line.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000379 necessary file backed out in update 3 m...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-06-04 18:40 benjif         New Issue                                    
09-07-04 16:40 perex          Status                   assigned => resolved
09-07-04 16:40 perex          Resolution               open => duplicate   
09-07-04 16:40 perex          Relationship added       duplicate of 0000379
11-09-04 16:17 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
