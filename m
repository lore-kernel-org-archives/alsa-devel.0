From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000379]: necessary file backed out in update 3 months ago
Date: Tue,  7 Sep 2004 16:35:33 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907143533.24EF8E01F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7F70328E
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 16:35:33 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000379
======================================================================
Reported By:                ndbusek
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     379
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
======================================================================
Date Submitted:             07-13-2004 03:38 CEST
Last Modified:              09-07-2004 16:35 CEST
======================================================================
Summary:                    necessary file backed out in update 3 months ago
Description: 
compiling vxp440.c fails with 
vxpocket.c: File not found
======================================================================

----------------------------------------------------------------------
 perex - 09-07-2004 16:35 CEST 
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 03:38 ndbusek        New Bug                                      
09-07-04 16:35 perex          Bugnote Added: 0001709                       
09-07-04 16:35 perex          Resolution               open => fixed       
09-07-04 16:35 perex          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
