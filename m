From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001480]: alsa-driver 1.0.10rc2 fails to compile with kernel suse-2.4.21
Date: Tue, 18 Oct 2005 17:25:23 +0200
Message-ID: <4604e56911aad759bb0363ae47cba2cc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 86C5D1A2
	for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2005 17:25:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1480> 
======================================================================
Reported By:                roadrunner
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1480
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               SuSE Linux
Kernel Version:             Linux version 2.4.21-297-default (root@i386.suse.de)
(gcc version 3.3.1 (SuSE Linux)) #1 Sat Jul 23 07:47:39 UTC 2005
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-18-2005 00:20 CEST
Last Modified:              10-18-2005 17:25 CEST
======================================================================
Summary:                    alsa-driver 1.0.10rc2 fails to compile with kernel
suse-2.4.21
Description: 
Compiling fails:

command:
./cvscompile --with-cards=ca0106 --with-debug=basic

result:
[...]
make[1]: Entering directory
`/home/erik/archiv/alsa-driver-1.0.10rc2/acore'
gcc -D__KERNEL__ -DMODULE=1
-I/home/erik/archiv/alsa-driver-1.0.10rc2/include 
-I/lib/modules/2.4.21-297-default/build/include -O2  -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix
include -DMODVERSIONS -include
/lib/modules/2.4.21-297-default/build/include/linux/modversions.h  
-DEXPORT_SYMTAB -c memalloc.c
In file included from memalloc.inc:13,
                 from memalloc.c:1:
/home/erik/archiv/alsa-driver-1.0.10rc2/include/adriver.h:667:5: missing
binary operator before token "("
/home/erik/archiv/alsa-driver-1.0.10rc2/include/adriver.h:688:5: missing
binary operator before token "("
make[1]: *** [memalloc.o] Error 1
make[1]: Leaving directory
`/home/erik/archiv/alsa-driver-1.0.10rc2/acore'
make: *** [compile] Error 1

compiler: gcc-3.3.6

======================================================================

----------------------------------------------------------------------
 tiwai - 10-18-05 17:25 
----------------------------------------------------------------------
A known problem.  Already fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-18-05 00:20 roadrunner     New Issue                                    
10-18-05 00:20 roadrunner     Distribution              => SuSE Linux      
10-18-05 00:20 roadrunner     Kernel Version            => Linux version
2.4.21-297-default (root@i386.suse.de) (gcc version 3.3.1 (SuSE Linux)) #1 Sat
Jul 23 07:47:39 UTC 2005
10-18-05 17:25 tiwai          Status                   assigned => resolved
10-18-05 17:25 tiwai          Resolution               open => fixed       
10-18-05 17:25 tiwai          Note Added: 0006490                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
