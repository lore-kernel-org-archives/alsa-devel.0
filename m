From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001351]: The misc.c is reported to have incomplete type with thread_excited.
Date: Mon, 14 Nov 2005 10:21:59 +0100
Message-ID: <31d241773cce41de9121a463e89b2088@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0502119E
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 10:21:59 +0100 (MET)
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
Status:                     resolved
Distribution:               the structure description of thread_excited in
acore/misc.c caused failure during compilation.
Kernel Version:             linux-2.4.7-10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-21-2005 12:32 CEST
Last Modified:              11-14-2005 10:21 CET
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

----------------------------------------------------------------------
 croiset - 09-23-05 12:25 
----------------------------------------------------------------------
I solved the compilation problem by modifying this line in acore/misc.c

Line 207 was :
#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0)
/* wait-for-completion handler emulation */

replaced by :
#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
/* wait-for-completion handler emulation */

----------------------------------------------------------------------
 perex - 11-14-05 10:21 
----------------------------------------------------------------------
Retest with 1.0.10rc3 package, reopen if it's not fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-21-05 12:32 lionhead       New Issue                                    
08-21-05 12:32 lionhead       File Added: misc.c                           
08-21-05 12:32 lionhead       Distribution              => the structure
description of thread_excited in acore/misc.c caused failure during compilation.
08-21-05 12:32 lionhead       Kernel Version            => linux-2.4.7-10  
08-22-05 12:21 perex          Note Added: 0005891                          
08-22-05 12:31 perex          Status                   assigned => feedback
08-22-05 12:31 perex          Steps to Reproduce Updated                    
08-29-05 14:54 lionhead       Issue Monitored: lionhead                    
09-23-05 08:57 croiset        Note Added: 0006362                          
09-23-05 12:25 croiset        Note Added: 0006366                          
09-23-05 13:33 slashlos       Issue Monitored: slashlos                    
09-26-05 17:59 croiset        Issue Monitored: croiset                     
11-14-05 10:21 perex          Status                   feedback => resolved
11-14-05 10:21 perex          Resolution               open => fixed       
11-14-05 10:21 perex          Note Added: 0006703                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
