From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002039]: Compilation breaks on serialmidi.c
Date: Wed, 19 Apr 2006 21:26:25 +0200
Message-ID: <d4a15716ef4ed4643047fe81788aeff6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF93018A
	for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2006 21:26:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2039> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2039
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.17-rc2
======================================================================
Date Submitted:             04-19-2006 21:17 CEST
Last Modified:              04-19-2006 21:26 CEST
======================================================================
Summary:                    Compilation breaks on serialmidi.c
Description: 
Hello,

today I upgraded to kernel-2.6.17-rc2 and wanted to try out the new
alsa-driver.

drivers/serialmidi.c:317: error: &#8216;struct tty_struct&#8217; has no
member named &#8216;atomic_write      &#8217;
drivers/serialmidi.c:322: error: &#8216;struct tty_struct&#8217; has no
member named &#8216;atomic_write      &#8217;
drivers/serialmidi.c:339: error: &#8216;struct tty_struct&#8217; has no
member named &#8216;atomic_write      &#8217;


======================================================================

----------------------------------------------------------------------
 Henne - 04-19-06 21:26 
----------------------------------------------------------------------
This affects only 2.6.17-rc[12] kernels. the semaphores were changed to
mutexes.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-06 21:17 Henne          New Issue                                    
04-19-06 21:17 Henne          Kernel Version            => 2.6.17-rc2      
04-19-06 21:26 Henne          Note Added: 0009355                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
