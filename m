From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000743]: msleep is now defined in linux/include/linux/delay.h causing conflict with macro defined in alsa-driver/include/adriver.h
Date: Thu, 23 Dec 2004 22:10:46 +0100
Message-ID: <19d9f89080b79fbd3ffdcb041efc282b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 432732B8
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2004 22:10:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=743> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   743
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-23-2004 22:10 CET
Last Modified:              12-23-2004 22:10 CET
======================================================================
Summary:                    msleep is now defined in linux/include/linux/delay.h
causing conflict with macro defined in alsa-driver/include/adriver.h
Description: 
Recent 2.4.29-pre3 patch moves msleep() from include/linux/libata-compat.h
to include/linux/delay.h.  As a result, alsa-driver 1.0.7 does not
compile
on 2.4.29-pre3 because it defines its own msleep macro in
include/adriver.h.
Currently the macro is defined inside
    #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 6) ... #endif.
The code seems to be the same in CVS.  I guess this version dependency
needs to be updated.


gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/modules/alsa-driver/include 
-I/usr/src/linux-2.4.29/include -I/usr/src/linux-2.4.29/include2
-I/usr/src/linux-2.4.29/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include   -DEXPORT_SYMTAB -c timer.c
In file included from timer.c:23:
/usr/src/linux-2.4.29/include/linux/delay.h:57: error: parse error before
"do"
/usr/src/linux-2.4.29/include/linux/delay.h:57: error: parse error before
'(' token
/usr/src/linux-2.4.29/include/linux/delay.h:60: error: parse error before
'(' token
make[4]: *** [timer.o] Error 1

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-23-04 22:10 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
