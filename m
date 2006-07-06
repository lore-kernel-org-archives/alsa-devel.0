From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002259]: `IRQF_DISABLED' `IRQF_SHARED'
	- undeclared (first use in this function)
Date: Thu, 6 Jul 2006 06:51:09 +0200
Message-ID: <d341a8ef4ab832038d27e13a0181f66b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9440924D
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 06:51:09 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2259> 
======================================================================
Reported By:                Raymond
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2259
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-06-2006 06:51 CEST
Last Modified:              07-06-2006 06:51 CEST
======================================================================
Summary:                    `IRQF_DISABLED' `IRQF_SHARED'  - undeclared (first
use in this function)
Description: 
Is there any backward compatiable patch for kernel 2.4 ?

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=467cbbd896c410fe24d908f940bf588f6baa7441;style=gitweb

gcc32 -D__KERNEL__ -DMODULE=1 -I/root/alsa/alsa-driver/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h 
-DKBUILD_BASENAME=intel8x0   -c -o intel8x0.o intel8x0.c
intel8x0.c: In function `intel8x0_resume':
intel8x0.c:2499: `IRQF_DISABLED' undeclared (first use in this function)
intel8x0.c:2499: (Each undeclared identifier is reported only once
intel8x0.c:2499: for each function it appears in.)
intel8x0.c:2499: `IRQF_SHARED' undeclared (first use in this function)
intel8x0.c: In function `intel8x0_measure_ac97_clock':
intel8x0.c:2633: warning: implicit declaration of function
`snd_ac97_update_power'
intel8x0.c: In function `snd_intel8x0_create':
intel8x0.c:2873: `IRQF_DISABLED' undeclared (first use in this function)
intel8x0.c:2873: `IRQF_SHARED' undeclared (first use in this function)
intel8x0.c: At top level:
intel8x0.c:93: warning: `enable' defined but not used
intel8x0.c:95: warning: `joystick' defined but not used
make[1]: *** [intel8x0.o] Error 1
make[1]: Leaving directory `/root/alsa/alsa-driver/pci'
make: *** [compile] Error 1

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-06-06 06:51 Raymond        New Issue                                    
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
