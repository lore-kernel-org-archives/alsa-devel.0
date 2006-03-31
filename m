From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001982]: Compilation problem in misc_driver.c
Date: Fri, 31 Mar 2006 14:17:50 +0200
Message-ID: <81102a63f1589414ebf0e5ff01e08be5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 09D8D15E
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 14:17:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1982> 
======================================================================
Reported By:                croiset
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1982
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Linux Redhat 7.2
Kernel Version:             2.4.7-10
======================================================================
Date Submitted:             03-31-2006 14:17 CEST
Last Modified:              03-31-2006 14:17 CEST
======================================================================
Summary:                    Compilation problem in misc_driver.c
Description: 
 -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.7-10/build/includ
e/linux/modversions.h  -DKBUILD_BASENAME=misc_driver   -c -o misc_driver.o
misc
_driver.c
misc_driver.c:451: field `thread_exited' has incomplete type
misc_driver.c: In function `snd_compat_destroy_workqueue':
misc_driver.c:502: warning: implicit declaration of function
`wait_for_completi
on_R02032293'
misc_driver.c: In function `snd_compat_create_workqueue':
misc_driver.c:550: warning: implicit declaration of function
`init_completion'
make[1]: *** [misc_driver.o] Erreur 1
make[1]: Quitte le répertoire
`/home/redhat/BUILD/alsa-driver-1.0.11rc4/acore'
make: *** [compile] Erreur 1


To solve this problem we must modify the file acore/misc_driver.c

by adding this include in the list :
#include <linux/completion.h>


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 14:17 croiset        New Issue                                    
03-31-06 14:17 croiset        Distribution              => Linux Redhat 7.2
03-31-06 14:17 croiset        Kernel Version            => 2.4.7-10        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
