From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001288]: Current alsa-driver/alsa-kernel CVS 29-7-2005 fails to build.
Date: Mon, 14 Nov 2005 10:23:08 +0100
Message-ID: <097a41401d2140f44598590418b7f946@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 987FB19E
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 10:23:08 +0100 (MET)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1288> 
======================================================================
Reported By:                jcdutton
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1288
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             Linux new 2.6.13-rc3-mm1 #2 SMP PREEMPT Thu Jul 28
23:46:58 BST 2005 i686 Intel(R) Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
======================================================================
Date Submitted:             07-29-2005 01:09 CEST
Last Modified:              11-14-2005 10:23 CET
======================================================================
Summary:                    Current alsa-driver/alsa-kernel CVS 29-7-2005 fails
to build.
Description: 
./cvscompile --with-cards=ca0106 --with-debug=basic
make -C /lib/modules/2.6.13-rc3-mm1/source SUBDIRS=/u/alsacvs/alsa-driver
O=/lib/modules/2.6.13-rc3-mm1/build modules
make[1]: Entering directory `/usr/src/linux-2.6.13-rc3-mm1'
  CC [M]  /u/alsacvs/alsa-driver/acore/memalloc.o
In file included from /u/alsacvs/alsa-driver/acore/memalloc.c:24:
/u/alsacvs/alsa-driver/acore/memalloc.inc:4:40: missing binary operator
before token "("
make[4]: *** [/u/alsacvs/alsa-driver/acore/memalloc.o] Error 1
make[3]: *** [/u/alsacvs/alsa-driver/acore] Error 2
make[2]: *** [_module_/u/alsacvs/alsa-driver] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.13-rc3-mm1'
make: *** [compile] Error 2

======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 10:23 
----------------------------------------------------------------------
Is this bug also in 1.0.10rc3?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-05 01:09 jcdutton       New Issue                                    
07-29-05 01:09 jcdutton       Kernel Version            => Linux new
2.6.13-rc3-mm1 #2 SMP PREEMPT Thu Jul 28 23:46:58 BST 2005 i686 Intel(R)
Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Lin
10-17-05 23:12 roadrunner     Issue Monitored: roadrunner                    
11-14-05 10:23 perex          Note Added: 0006704                          
11-14-05 10:23 perex          Status                   assigned => feedback
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
