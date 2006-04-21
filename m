From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002046]: Driver build fails due to bug in kernel include/asm/dma-mapping.h file.
Date: Fri, 21 Apr 2006 12:42:03 +0200
Message-ID: <e1f8f4bafee235418a0afc39bed46f3c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CB07116C
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2006 12:42:03 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2046> 
======================================================================
Reported By:                GrueMaster
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2046
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Novell Linux Desktop 9 Service pack 3
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-20-2006 23:53 CEST
Last Modified:              04-21-2006 12:42 CEST
======================================================================
Summary:                    Driver build fails due to bug in kernel
include/asm/dma-mapping.h file.
Description: 
Compile fails at acore/sgbuf.c.  Multiple define errors in
include/asm/dma-mapping.h file.  This has also been reproduced againast a
clean 2.6.5 kernel from kernel.org.


======================================================================

----------------------------------------------------------------------
 tiwai - 04-21-06 12:42 
----------------------------------------------------------------------
Fixed on Hg repo.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-20-06 23:53 GrueMaster     New Issue                                    
04-20-06 23:53 GrueMaster     Distribution              => Novell Linux Desktop
9 Service pack 3
04-21-06 12:42 tiwai          Status                   assigned => resolved
04-21-06 12:42 tiwai          Resolution               open => fixed       
04-21-06 12:42 tiwai          Note Added: 0009409                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
