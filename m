From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000458]: Alsa-driver doesn't compile on x86_64
Date: Sat, 21 Aug 2004 12:17:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040821101725.85BCC1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 045A3229
	for <alsa-devel@alsa-project.org>; Sat, 21 Aug 2004 12:17:25 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 9872019D19
	for <alsa-devel@alsa-project.org>; Sat, 21 Aug 2004 12:17:25 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000458
======================================================================
Reported By:                aldg
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     458
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake
Kernel Version:             2.4.27
======================================================================
Date Submitted:             08-21-2004 12:17 CEST
Last Modified:              08-21-2004 12:17 CEST
======================================================================
Summary:                    Alsa-driver doesn't compile on x86_64
Description: 
make  -C ioctl32 modules
make[2]: Entering directory
`/mnt/data/packages/alsa/alsa-driver-1.0.6a/acore/ioctl32'
gcc -D__KERNEL__ -DMODULE=1
-I/mnt/data/packages/alsa/alsa-driver-1.0.6a/include 
-I/lib/modules/2.4.27/build/include -O2 -mno-red-zone -mcmodel=kernel
-fno-reorder-blocks -fno-strength-reduce -finline-limit=2000 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix
include  -DKBUILD_BASENAME=ioctl32   -c -o ioctl32.o ioctl32.c
In file included from ioctl32.c:2:
../../alsa-kernel/core/ioctl32/ioctl32.c: In function
`_snd_ioctl32_ctl_elem_list':
../../alsa-kernel/core/ioctl32/ioctl32.c:119: warning: implicit
declaration of function `compat_ptr'
../../alsa-kernel/core/ioctl32/ioctl32.c:119: warning: assignment makes
pointer from integer without a cast
In file included from ioctl32.c:2:
../../alsa-kernel/core/ioctl32/ioctl32.c: In function
`_snd_ioctl32_ctl_elem_value':
../../alsa-kernel/core/ioctl32/ioctl32.c:302: warning: assignment makes
pointer from integer without a cast
gcc -D__KERNEL__ -DMODULE=1
-I/mnt/data/packages/alsa/alsa-driver-1.0.6a/include 
-I/lib/modules/2.4.27/build/include -O2 -mno-red-zone -mcmodel=kernel
-fno-reorder-blocks -fno-strength-reduce -finline-limit=2000 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix
include  -DKBUILD_BASENAME=pcm32   -c -o pcm32.o pcm32.c
In file included from
/mnt/data/packages/alsa/alsa-driver-1.0.6a/include/linux/compat.h:1,
                 from ../../alsa-kernel/core/ioctl32/ioctl32.h:29,
                 from ../../alsa-kernel/core/ioctl32/pcm32.c:27,
                 from pcm32.c:2:
/mnt/data/packages/alsa/alsa-driver-1.0.6a/include/compat_64.h:5: error:
redefinition of `compat_time_t'
/mnt/data/packages/alsa/alsa-driver-1.0.6a/include/compat_64.h:5: error:
`compat_time_t' previously declared here
/mnt/data/packages/alsa/alsa-driver-1.0.6a/include/compat_64.h:7: error:
redefinition of `struct compat_timespec'
/mnt/data/packages/alsa/alsa-driver-1.0.6a/include/compat_64.h:12: error:
redefinition of `struct compat_timeval'
In file included from pcm32.c:2:
../../alsa-kernel/core/ioctl32/pcm32.c: In function `_snd_ioctl32_xferi':
../../alsa-kernel/core/ioctl32/pcm32.c:196: warning: implicit declaration
of function `compat_ptr'
../../alsa-kernel/core/ioctl32/pcm32.c:196: warning: assignment makes
pointer from integer without a cast
In file included from pcm32.c:2:
../../alsa-kernel/core/ioctl32/pcm32.c: In function `_snd_ioctl32_xfern':
../../alsa-kernel/core/ioctl32/pcm32.c:260: warning: assignment makes
pointer from integer without a cast
../../alsa-kernel/core/ioctl32/pcm32.c:268: warning: assignment makes
pointer from integer without a cast
make[2]: *** [pcm32.o] Error 1
make[2]: Leaving directory
`/mnt/data/packages/alsa/alsa-driver-1.0.6a/acore/ioctl32'
make[1]: *** [_modsubdir_ioctl32] Error 2
make[1]: Leaving directory
`/mnt/data/packages/alsa/alsa-driver-1.0.6a/acore'
make: *** [compile] Error 1

======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-21-04 12:17 aldg           New Bug                                      
08-21-04 12:17 aldg           Distribution              => Mandrake        
08-21-04 12:17 aldg           Kernel Version            => 2.4.27          
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
