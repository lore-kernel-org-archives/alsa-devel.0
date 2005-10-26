From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001490]: unresolved symbol copy_to_user_fromio_R602c96f0 ; unresolved symbol copy_from_user_toio_Rce3ca308
Date: Wed, 26 Oct 2005 18:01:23 +0200
Message-ID: <62d508fea12893754e7ec1d134df0ad4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B3D018D
	for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2005 18:01:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1490> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1490
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
======================================================================
Date Submitted:             10-21-2005 15:06 CEST
Last Modified:              10-26-2005 18:01 CEST
======================================================================
Summary:                    unresolved symbol copy_to_user_fromio_R602c96f0 ;
unresolved symbol copy_from_user_toio_Rce3ca308
Description: 
Starting from alsa-1.0.10rc2 and CVS on kernel 2.4.22-1.2199.nptl

/etc/init.d/alsasound start

unresolved symbol copy_to_user_fromio_R602c96f0 

unresolved symbol copy_from_user_toio_Rce3ca308
======================================================================

----------------------------------------------------------------------
 Raymond - 10-24-05 17:14 
----------------------------------------------------------------------
This case can be closed, it looks like I installed the wrong version of
Intel536ep-4.71 modem driver which cause the unresolved symbol on FC1.



gcc32 -D__KERNEL__ -DMODULE=1 -I/cvs/alsa-driver/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h  
-DEXPORT_SYMTAB -c sound.c
sound.c:42: warning: `device_mode' defined but not used

gcc32 -D__KERNEL__ -DMODULE=1 -I/cvs/alsa-driver/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h 
-DKBUILD_BASENAME=intel8x0   -c -o intel8x0.o intel8x0.c
intel8x0.c:93: warning: `enable' defined but not used
intel8x0.c:95: warning: `joystick' defined but not used

----------------------------------------------------------------------
 nickh - 10-26-05 18:01 
----------------------------------------------------------------------
I see the same error after building on a CentOS 3.5 system.  The kernel RPM
version is 2.4.21-32.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-05 15:06 Raymond        New Issue                                    
10-21-05 15:06 Raymond        Distribution              => Fedora Core 1   
10-21-05 15:06 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
10-24-05 17:14 Raymond        Note Added: 0006522                          
10-25-05 18:42 nickh          Issue Monitored: nickh                       
10-26-05 18:01 nickh          Note Added: 0006559                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
