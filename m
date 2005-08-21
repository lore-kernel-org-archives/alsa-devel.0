From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001351]: The misc.c is reported to have incomplete type with thread_excited.
Date: Sun, 21 Aug 2005 12:32:52 +0200
Message-ID: <825e53662e536e82682f8cc2b5b1d755@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9C7CC1EE
	for <alsa-devel@alsa-project.org>; Sun, 21 Aug 2005 12:32:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1351> 
======================================================================
Reported By:                lionhead
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1351
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               the structure description of thread_excited in
acore/misc.c caused failure during compilation.
Kernel Version:             linux-2.4.7-10
======================================================================
Date Submitted:             08-21-2005 12:32 CEST
Last Modified:              08-21-2005 12:32 CEST
======================================================================
Summary:                    The misc.c is reported to have incomplete type with
thread_excited.
Description: 
kernel :linux-2.4.7-10. 
When I compile the alsa drive on my redhat7.2, it always failed with
result as below.

results:
------------------------------------------------------------------------------
[/home/ws/sound/alsa-driver-1.0.9rc4a]$ make
make[1]: Entering directory `/home/ws/sound/alsa-driver-1.0.9rc4a/acore'
gcc -D__KERNEL__ -DMODULE=1 -I/home/ws/sound/alsa-driver-1.0.9rc4a/include
 -I/lib/modules/2.4.7-1
0/build/include -O2 -mpreferred-stack-boundary=2 -march=athlon -DLINUX
-Wall -Wstrict-prototypes -
fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdi
nc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.7-10/build/include/linux/modversio
ns.h  -DKBUILD_BASENAME=misc   -c -o misc.o misc.c
misc.c:289: field `thread_exited' has incomplete type <--------- 
misc.c: In function `snd_compat_destroy_workqueue_Raba0304c':
misc.c:340: warning: implicit declaration of function
`wait_for_completion_R02032293'
misc.c: In function `snd_compat_create_workqueue_R6659e20e':
misc.c:388: warning: implicit declaration of function `init_completion'
-------------------------------------------------------------------------------
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-21-05 12:32 lionhead       New Issue                                    
08-21-05 12:32 lionhead       File Added: misc.c                           
08-21-05 12:32 lionhead       Distribution              => the structure
description of thread_excited in acore/misc.c caused failure during compilation.
08-21-05 12:32 lionhead       Kernel Version            => linux-2.4.7-10  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
