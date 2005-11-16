From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001566]: The misc.c is reported to have incomplete type with thread_excited.
Date: Wed, 16 Nov 2005 17:22:01 +0100
Message-ID: <73db50bf384b05ed8bff3e6721d7e9c0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0370A1CC
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2005 17:22:01 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1566> 
======================================================================
Reported By:                croiset
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1566
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-16-2005 17:22 CET
Last Modified:              11-16-2005 17:22 CET
======================================================================
Summary:                    The misc.c is reported to have incomplete type with
thread_excited.
Description: 
 kernel :linux-2.4.7-10.
When I compile the alsa drive on my redhat7.2, it always failed with
result as below.

results:
------------------------------------------------------------------------------
i386-redhat-linux-gcc -D__KERNEL__ -DMODULE=1
-I/home/redhat/BUILD/alsa-driver-
1.0.10rc3/include  -I/lib/modules/2.4.7-10/build/include -O2
-mpreferred-stack-
boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -
Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc
 -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.7-10/build/include/linux/modversions.h 
-DKBUILD_BASENAME=misc   -c -o misc.o misc.c
In file included from misc.c:77:
misc.inc:288: field `thread_exited' has incomplete type
misc.inc: In function `snd_compat_destroy_workqueue_Raba0304c':
misc.inc:339: warning: implicit declaration of function
`wait_for_completion_R02032293'
misc.inc: In function `snd_compat_create_workqueue_R6659e20e':
misc.inc:387: warning: implicit declaration of function `init_completion'
make[1]: *** [misc.o] Erreur 1
make[1]: Quitte le répertoire
`/home/redhat/BUILD/alsa-driver-1.0.10rc3/acore'
make: *** [compile] Erreur 1

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-16-05 17:22 croiset        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
