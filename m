From: noreply@alsa-project.org
Subject: [ALSA - lib 0000003]: alsa-lib-1.0.2: 'make check' fails
Date: Tue, 27 Jan 2004 20:39:16 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040127193916.B6D6121002@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA13785
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 20:39:18 +0100
Received: from server.perex-int.cz (server-a.perex-int.cz [192.168.100.3])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id C7793EF
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 20:39:16 +0100 (MET)
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


The following NEW bug has been ADDED.
======================================================================
http://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003
======================================================================
Reporter:                   ZlatkO
Handler:                    
======================================================================
Project:                    ALSA - lib
Bug ID:                     3
Category:                   general
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-27-2004 20:39 CET
Last Modified:              01-27-2004 20:39 CET
======================================================================
Summary:                    alsa-lib-1.0.2: 'make check' fails
Description: 
'make check' fails on a Slackware 8.1 system with gcc-2.95.3 due to three
minor problems (one missing #define/#include statement, two misplaced
variable delarations) in test/code.c and test/queue_timer.c. The attached
patch fixes these problems.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
01-27-04 20:39 ZlatkO         New Bug                                      
01-27-04 20:39 ZlatkO         File Added: alsa-lib-1.0.2.diff                    
======================================================================


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
