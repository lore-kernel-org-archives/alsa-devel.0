From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000379]: necessary file backed out in update 3 months ago
Date: Tue, 9 Nov 2004 16:15:40 +0100
Message-ID: <50ce251bccf88041c3586b8cbeb4cd8c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CB8B7244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:15:40 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=379> 
======================================================================
Reported By:                ndbusek
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   379
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-13-2004 03:38 CEST
Last Modified:              11-09-2004 16:15 CET
======================================================================
Summary:                    necessary file backed out in update 3 months ago
Description: 
compiling vxp440.c fails with 
vxpocket.c: File not found
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000368 vxpocket.c missing from 1.0.5 releases
======================================================================

----------------------------------------------------------------------
 perex - 09-07-04 16:35 
----------------------------------------------------------------------
This patch will solve your problem.

Index: Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pcmcia/vx/Makefile,v
retrieving revision 1.10
retrieving revision 1.11
diff -u -r1.10 -r1.11
--- Makefile    7 Apr 2004 17:53:41 -0000       1.10
+++ Makefile    7 Sep 2004 14:33:48 -0000       1.11
@@ -14,4 +14,5 @@
 include $(SND_TOPDIR)/Rules.make
 
 vxpocket.c: vxpocket.patch
$(SND_TOPDIR)/alsa-kernel/pcmcia/vx/vxpocket.c
+vxp440.c: vxpocket.c
 vx_entry.c: vx_entry.patch vx_entry.inc vx_entry.inc1
$(SND_TOPDIR)/alsa-kernel/pcmcia/vx/vx_entry.c

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 03:38 ndbusek        New Issue                                    
09-07-04 16:35 perex          Status                   assigned => resolved
09-07-04 16:35 perex          Resolution               open => fixed       
09-07-04 16:35 perex          Note Added: 0001709                          
09-07-04 16:40 perex          Relationship added       has duplicate 0000368
11-09-04 16:15 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
