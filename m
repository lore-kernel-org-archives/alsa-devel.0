From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001444]: sb16: unable to compile driver and wrong build order
Date: Mon, 14 Nov 2005 10:20:28 +0100
Message-ID: <9b35e4d02496a82d8469cfdc2d706f02@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E74A119E
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 10:20:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1444> 
======================================================================
Reported By:                slashlos
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1444
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.4.20-31smp
======================================================================
Date Submitted:             09-23-2005 13:31 CEST
Last Modified:              11-14-2005 10:20 CET
======================================================================
Summary:                    sb16: unable to compile driver and wrong build order
Description: 
this this might be a noob issue, but the order suggested for build should
be lib, util then driver; it seems driver needs some utils?

Anyhow, when trying to build driver, I get this:

gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa/alsa-driver-1.0.10rc1/include 
-I/lib/modules/2.4.20-31.9smp/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -D__SMP__ -DCONFIG_SMP -DLINUX
-Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix
include -DMODVERSIONS -include
/lib/modules/2.4.20-31.9smp/build/include/linux/modversions.h
-I/usr/src/alsa/alsa-driver-1.0.10rc1/alsa-kernel/core/oss
-fno-omit-frame-pointer  -DEXPORT_SYMTAB -c mixer_oss.c
mixer_oss.c:397: unknown field `unlocked_ioctl' specified in initializer
mixer_oss.c:397: warning: initialization from incompatible pointer type
mixer_oss.c:398: unknown field `compat_ioctl' specified in initializer
make[2]: *** [mixer_oss.o] Error 1
make[2]: Leaving directory
`/usr/src/alsa/alsa-driver-1.0.10rc1/acore/oss'
make[1]: *** [_modsubdir_oss] Error 2
make[1]: Leaving directory `/usr/src/alsa/alsa-driver-1.0.10rc1/acore'
make: *** [compile] Error 1

======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 10:20 
----------------------------------------------------------------------
Could you try 1.0.10rc3 packages?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-05 13:31 slashlos       New Issue                                    
09-23-05 13:31 slashlos       Kernel Version            => 2.4.20-31smp    
10-14-05 03:50 slashlos       Issue Monitored: slashlos                    
11-14-05 10:20 perex          Note Added: 0006702                          
11-14-05 10:20 perex          Status                   assigned => feedback
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
