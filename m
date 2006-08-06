From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002333]: alsa -1.0.12rc2 compilation
	problem on kernel 2.4
Date: Sun, 6 Aug 2006 15:12:10 +0200
Message-ID: <fff50f5ac1a8814eab05cd0da948d83e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E9DA0125
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 15:12:10 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2333> 
======================================================================
Reported By:                Raymond
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2333
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
======================================================================
Date Submitted:             08-04-2006 17:32 CEST
Last Modified:              08-06-2006 15:12 CEST
======================================================================
Summary:                    alsa -1.0.12rc2 compilation problem on kernel 2.4
Description: 
./configure --with-cards=all

make

gcc32 -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/alsa-driver-1.0.12rc2/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -DALSA_BUILD -nostdinc
-iwithprefix include -I/alsa-driver-1.0.12rc2/alsa-kernel/core/oss
-fno-omit-frame-pointer mixer_oss.c pcm_oss.c pcm_plugin.c io.c copy.c
linear.c mulaw.c route.c rate.c > .depend
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from mixer_oss.c:22:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from pcm_oss.c:29:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/pcm_plugin.c:27,
                 from pcm_plugin.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/io.c:22,
                 from io.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/copy.c:22,
                 from copy.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/linear.c:23,
                 from linear.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/mulaw.c:24,
                 from mulaw.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/route.c:22,
                 from route.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
In file included from /alsa-driver-1.0.12rc2/include/sound/driver.h:46,
                 from
/alsa-driver-1.0.12rc2/alsa-kernel/core/oss/rate.c:22,
                 from rate.c:2:
/alsa-driver-1.0.12rc2/include/adriver.h:142:35: macro "might_sleep"
passed 1 arguments, but takes just 0
make[3]: *** [fastdep] Error 1
make[3]: Leaving directory `/alsa-driver-1.0.12rc2/acore/oss'
make[2]: *** [_sfdep_oss] Error 2
make[2]: Leaving directory `/alsa-driver-1.0.12rc2/acore'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/alsa-driver-1.0.12rc2'
make: *** [include/sndversions.h] Error 2

======================================================================

----------------------------------------------------------------------
 Raymond - 08-06-06 15:10 
----------------------------------------------------------------------
gcc32 -D__KERNEL__ -DMODULE=1 -I/alsa-driver-1.0.12rc2/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h 
-DKBUILD_BASENAME=asihpi   -c -o asihpi.o asihpi.c
In file included from hpios.h:36,
                 from hpi.h:49,
                 from asihpi.c:49:
hpios_linux_kernel.h:60:1: warning: "irqs_disabled" redefined
In file included from
/lib/modules/2.4.22-1.2199.nptl/build/include/asm/semaphore.h:39,
                 from
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/fs.h:202,
                 from
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/capability.h:17,
                 from
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/binfmts.h:4,
                 from
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/sched.h:10,
                 from
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/mm.h:4,
                 from
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/slab.h:14,
                 from
/lib/modules/2.4.22-1.2199.nptl/build/include/asm/pci.h:37,
                 from
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/pci.h:658,
                 from asihpi.c:30:
/lib/modules/2.4.22-1.2199.nptl/build/include/asm/system.h:341:1: warning:
this is the location of the previous definition

----------------------------------------------------------------------
 Raymond - 08-06-06 15:12 
----------------------------------------------------------------------
gcc32 -D__KERNEL__ -DMODULE=1 -I/alsa-driver-1.0.12rc2/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h 
-DKBUILD_BASENAME=pcxhr   -c -o pcxhr.o pcxhr.c
In file included from pcxhr.c:1:
../../alsa-kernel/pci/pcxhr/pcxhr.c: In function `pcxhr_trigger':
../../alsa-kernel/pci/pcxhr/pcxhr.c:640: warning: `stream' might be used
uninitialized in this function

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-04-06 17:32 Raymond        New Issue                                    
08-04-06 17:32 Raymond        Distribution              => Fedora Core 1   
08-04-06 17:32 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
08-05-06 13:14 Raymond        Note Added: 0011427                          
08-06-06 13:43 Raymond        Note Added: 0011466                          
08-06-06 14:34 Raymond        Note Added: 0011468                          
08-06-06 15:10 Raymond        Note Added: 0011469                          
08-06-06 15:12 Raymond        Note Added: 0011470                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
