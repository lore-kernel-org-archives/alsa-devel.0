From: noreply@alsa-project.org
Subject: [ALSA - driver 0000002]: 1.0.2: intel8x0.c build problem
Date: Tue, 27 Jan 2004 20:47:23 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040127194723.50B4621003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA13996
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 20:47:25 +0100
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


A BUGNOTE has been added to this bug.
======================================================================
http://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000002
======================================================================
Reporter:                   ZlatkO
Handler:                    
======================================================================
Project:                    ALSA - driver
Bug ID:                     2
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Slackware 8.1
Kernel Version:             2.4.24
======================================================================
Date Submitted:             01-27-2004 20:11 CET
Last Modified:              01-27-2004 20:47 CET
======================================================================
Summary:                    1.0.2: intel8x0.c build problem
Description: 
alsa-driver-1.0.2 doesn't build out of the box with gcc-2.95.3. The
attached patch fixes the problem.
======================================================================

----------------------------------------------------------------------
 perex - 01-27-2004 20:47 CET 
----------------------------------------------------------------------
I have regenerated the alsa-driver package with this fix.
It is dated:

Jan 27 14:15 alsa-driver-1.0.2.tar.bz2

Bug History
Date Modified  Username       Field                    Change              
======================================================================
01-27-04 20:11 ZlatkO         New Bug                                      
01-27-04 20:11 ZlatkO         File Added: alsa-driver-1.0.2.diff                    
01-27-04 20:47 perex          Bugnote Added: 0000002                       
======================================================================


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
