From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002267]: correct config for x86_64,
Date: Fri, 14 Jul 2006 05:02:17 +0200
Message-ID: <4d68c3a39e8dd78e2e722292e1e3adc2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 28630183
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Jul 2006 05:02:17 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2267> 
======================================================================
Reported By:                eliot
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2267
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-10-2006 03:30 CEST
Last Modified:              07-14-2006 05:02 CEST
======================================================================
Summary:                    correct config for x86_64,
Description: 
Drivers that depended on (! x86_64) were not being disabled.
asihpi driver attempts build even though it is supposed to be disabled,
then compilation fails.
CS5535 also supposed to be disabled may be built anyway?

======================================================================

----------------------------------------------------------------------
 eliot - 07-14-06 05:02 
----------------------------------------------------------------------
For some reason this issue never resulted in email to alsa-devel. There was
some smtp error at the time I submitted it. Maybe this note will do it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-10-06 03:30 eliot          New Issue                                    
07-11-06 02:00 eliot          Issue Monitored: eliot                       
07-14-06 05:02 eliot          Note Added: 0010998                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
