From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001288]: Current alsa-driver/alsa-kernel CVS 29-7-2005 fails to build.
Date: Fri, 29 Jul 2005 01:09:23 +0200
Message-ID: <1c4605a0ff3fabf3fc1352360ed84be4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A80D616E
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2005 01:09:22 +0200 (MEST)
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
Status:                     assigned
Distribution:               
Kernel Version:             Linux new 2.6.13-rc3-mm1
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 SMP PREEMPT Thu Jul 28
23:46:58 BST 2005 i686 Intel(R) Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
======================================================================
Date Submitted:             07-29-2005 01:09 CEST
Last Modified:              07-29-2005 01:09 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-05 01:09 jcdutton       New Issue                                    
07-29-05 01:09 jcdutton       Kernel Version            => Linux new
2.6.13-rc3-mm1 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 SMP
PREEMPT Thu Jul 28 23:46:58 BST 2005 i686 Intel(R) Pentium(R) 4 CPU 2.80GHz
GenuineIntel GNU/Lin
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
