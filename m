From: noreply@alsa-project.org
Subject: [ALSA - lib 0000003]: alsa-lib-1.0.2: 'make check' fails
Date: Tue, 27 Jan 2004 20:52:19 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040127195219.B3AE621003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA14105
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 20:52:21 +0100
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


The following bug has been CLOSED
======================================================================
http://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000003
======================================================================
Reporter:                   ZlatkO
Handler:                    perex
======================================================================
Project:                    ALSA - lib
Bug ID:                     3
Category:                   general
Reproducibility:            always
Severity:                   trivial
Priority:                   low
Status:                     closed
======================================================================
Date Submitted:             01-27-2004 20:39 CET
Last Modified:              01-27-2004 20:52 CET
======================================================================
Summary:                    alsa-lib-1.0.2: 'make check' fails
Description: 
'make check' fails on a Slackware 8.1 system with gcc-2.95.3 due to three
minor problems (one missing #define/#include statement, two misplaced
variable delarations) in test/code.c and test/queue_timer.c. The attached
patch fixes these problems.
======================================================================

----------------------------------------------------------------------
 perex - 01-27-2004 20:52 CET 
----------------------------------------------------------------------
The patch was applied to CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
01-27-04 20:39 ZlatkO         New Bug                                      
01-27-04 20:39 ZlatkO         File Added: alsa-lib-1.0.2.diff                    
01-27-04 20:51 perex          Assigned To               => perex           
01-27-04 20:51 perex          Priority                 normal => low       
01-27-04 20:51 perex          Status                   new => assigned     
01-27-04 20:52 perex          Bugnote Added: 0000004                       
01-27-04 20:52 perex          Status                   assigned => closed  
======================================================================


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
