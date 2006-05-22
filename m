From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002143]: Error running configure
Date: Mon, 22 May 2006 17:24:34 +0200
Message-ID: <2c4e0639a776ba1cac0faa682bbd1190@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2E85A13B
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2006 17:24:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2143> 
======================================================================
Reported By:                friser
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2143
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               fedora core 5
Kernel Version:             2.6.16-1.2080_FC5
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             05-22-2006 15:07 CEST
Last Modified:              05-22-2006 17:24 CEST
======================================================================
Summary:                    Error running configure
Description: 
Running configure I obtain the error:

The file /lib/modules/2.6.16-1.2080_FC5/source/include/linux/version.h
does not exist. Please install the package with full kernel sources for
your distribution
or use --with-kernel=dir option to specify another directory with kernel
sources (default is /lib/modules/2.6.16-1.2080_FC5/source).

======================================================================

----------------------------------------------------------------------
 Heineken - 05-22-06 16:22 
----------------------------------------------------------------------
Hi friser,

You need to install the Linux kernel source package before you can build
the ALSA sources. Search your package manager with words like "kernel" and
"source". He should have the required package listed (it's rather big, a
few 100MB).

Regards,

Lars.

----------------------------------------------------------------------
 rlrevell - 05-22-06 17:24 
----------------------------------------------------------------------
Kernel source must be installed to compile ALSA drivers

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-06 15:07 friser         New Issue                                    
05-22-06 15:07 friser         Distribution              => fedora core 5   
05-22-06 15:07 friser         Kernel Version            => 2.6.16-1.2080_FC5
05-22-06 15:38 friser         Note Added: 0009911                          
05-22-06 16:22 Heineken       Note Added: 0009913                          
05-22-06 17:24 rlrevell       Status                   assigned => closed  
05-22-06 17:24 rlrevell       Note Added: 0009916                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
