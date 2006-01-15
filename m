From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001751]: I can't "make" it
Date: Sun, 15 Jan 2006 15:40:24 +0100
Message-ID: <f1e88f788a81ab85dd95b5261a9253a1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 828A812B
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2006 15:40:24 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1751> 
======================================================================
Reported By:                DavidJ
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1751
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-15-2006 15:37 CET
Last Modified:              01-15-2006 15:40 CET
======================================================================
Summary:                    I can't "make" it
Description: 
I'd downloaded the newest version
/alsa-driver-1.0.9rc4a.tar.bz2 and alsa-driver-1.0.9rc4.tar.bz2/ but shell
shows me that this driver don't support this hardware - sic!
so I've used 0.9.4 which is described on the site
http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Creative+Labs&card=Sound+Blaster+Audigy2+NX.&chip=CA0186%2C+EP7309&module=usb-audio

so when I execute:
./configure --with-cards=usb-audio --with-sequencer=yes
--with-kernel=/usr/

looks fine but after that I execute: "make" it shows me:
/*
make[1]: Entering directory `/usr/src/alsa/alsa-driver-0.9.4/support'
make[1]: Nothing to be done for `first_rule'.
make[1]: Leaving directory `/usr/src/alsa/alsa-driver-0.9.4/support'
make[1]: Entering directory `/usr/src/alsa/alsa-driver-0.9.4/acore'
coping file alsa-kernel/core/sound.c
patching file sound.c
coping file alsa-kernel/core/rawmidi.c
patching file rawmidi.c
coping file alsa-kernel/core/timer.c
patching file timer.c
coping file alsa-kernel/core/hwdep.c
patching file hwdep.c
coping file alsa-kernel/core/memalloc.c
patching file memalloc.c
gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa/alsa-driver-0.9.4/include
-I/usr//include -O2 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-DEXPORT_SYMTAB -c memalloc.c
In file included from memalloc.inc:2,
from memalloc.c:1:
/usr/include/linux/version.h:2:2: error: #error
"======================================================="
/usr/include/linux/version.h:3:2: error: #error "You should not include
/usr/include/{linux,asm}/ header"
/usr/include/linux/version.h:4:2: error: #error "files directly for the
compilation of kernel modules."
/usr/include/linux/version.h:5:2: error: #error ""
/usr/include/linux/version.h:6:2: error: #error "glibc now uses kernel
header files from a well-defined"
/usr/include/linux/version.h:7:2: error: #error "working kernel version
(as recommended by Linus Torvalds)"
/usr/include/linux/version.h:8:2: error: #error "These files are glibc
internal and may not match the"
/usr/include/linux/version.h:9:2: error: #error "currently running kernel.
They should only be"
/usr/include/linux/version.h:10:2: error: #error "included via other
system header files - user space"
/usr/include/linux/version.h:11:2: error: #error "programs should not
directly include <linux/*.h> or"
/usr/include/linux/version.h:12:2: error: #error "<asm/*.h> as well."
/usr/include/linux/version.h:13:2: error: #error ""
/usr/include/linux/version.h:14:2: error: #error "To build kernel modules
please do the following:"
/usr/include/linux/version.h:15:2: error: #error ""
/usr/include/linux/version.h:16:2: error: #error " o Have the kernel
sources installed"
/usr/include/linux/version.h:17:2: error: #error ""
/usr/include/linux/version.h:18:2: error: #error " o Make sure that the
symbolic link"
/usr/include/linux/version.h:19:2: error: #error " /lib/modules/`uname
-r`/build exists and points to"
/usr/include/linux/version.h:20:2: error: #error " the matching kernel
source directory"
/usr/include/linux/version.h:21:2: error: #error ""
/usr/include/linux/version.h:22:2: error: #error " o Configure kernel
sources:"
/usr/include/linux/version.h:23:2: error: #error " - cd /usr/src/linux"
/usr/include/linux/version.h:24:2: error: #error " - make mrproper"
/usr/include/linux/version.h:25:2: error: #error " - make cloneconfig"
/usr/include/linux/version.h:26:2: error: #error " - make dep"
/usr/include/linux/version.h:27:2: error: #error ""
/usr/include/linux/version.h:28:2: error: #error " o When compiling, make
sure to use the following"
/usr/include/linux/version.h:29:2: error: #error " compiler option to use
the correct include files:"
/usr/include/linux/version.h:30:2: error: #error ""
/usr/include/linux/version.h:31:2: error: #error " -I/lib/modules/`uname
-r`/build/include"
/usr/include/linux/version.h:32:2: error: #error ""
/usr/include/linux/version.h:33:2: error: #error " instead of"
/usr/include/linux/version.h:34:2: error: #error ""
/usr/include/linux/version.h:35:2: error: #error " -I/usr/include/linux"
/usr/include/linux/version.h:36:2: error: #error ""
/usr/include/linux/version.h:37:2: error: #error " Please adjust the
Makefile accordingly."
/usr/include/linux/version.h:38:2: error: #error
"======================================================="
In file included from
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:25,
from memalloc.inc:11,
from memalloc.c:1:
/usr/include/linux/version.h:2:2: error: #error
"======================================================="
/usr/include/linux/version.h:3:2: error: #error "You should not include
/usr/include/{linux,asm}/ header"
/usr/include/linux/version.h:4:2: error: #error "files directly for the
compilation of kernel modules."
/usr/include/linux/version.h:5:2: error: #error ""
/usr/include/linux/version.h:6:2: error: #error "glibc now uses kernel
header files from a well-defined"
/usr/include/linux/version.h:7:2: error: #error "working kernel version
(as recommended by Linus Torvalds)"
/usr/include/linux/version.h:8:2: error: #error "These files are glibc
internal and may not match the"
/usr/include/linux/version.h:9:2: error: #error "currently running kernel.
They should only be"
/usr/include/linux/version.h:10:2: error: #error "included via other
system header files - user space"
/usr/include/linux/version.h:11:2: error: #error "programs should not
directly include <linux/*.h> or"
/usr/include/linux/version.h:12:2: error: #error "<asm/*.h> as well."
/usr/include/linux/version.h:13:2: error: #error ""
/usr/include/linux/version.h:14:2: error: #error "To build kernel modules
please do the following:"
/usr/include/linux/version.h:15:2: error: #error ""
/usr/include/linux/version.h:16:2: error: #error " o Have the kernel
sources installed"
/usr/include/linux/version.h:17:2: error: #error ""
/usr/include/linux/version.h:18:2: error: #error " o Make sure that the
symbolic link"
/usr/include/linux/version.h:19:2: error: #error " /lib/modules/`uname
-r`/build exists and points to"
/usr/include/linux/version.h:20:2: error: #error " the matching kernel
source directory"
/usr/include/linux/version.h:21:2: error: #error ""
/usr/include/linux/version.h:22:2: error: #error " o Configure kernel
sources:"
/usr/include/linux/version.h:23:2: error: #error " - cd /usr/src/linux"
/usr/include/linux/version.h:24:2: error: #error " - make mrproper"
/usr/include/linux/version.h:25:2: error: #error " - make cloneconfig"
/usr/include/linux/version.h:26:2: error: #error " - make dep"
/usr/include/linux/version.h:27:2: error: #error ""
/usr/include/linux/version.h:28:2: error: #error " o When compiling, make
sure to use the following"
/usr/include/linux/version.h:29:2: error: #error " compiler option to use
the correct include files:"
/usr/include/linux/version.h:30:2: error: #error ""
/usr/include/linux/version.h:31:2: error: #error " -I/lib/modules/`uname
-r`/build/include"
/usr/include/linux/version.h:32:2: error: #error ""
/usr/include/linux/version.h:33:2: error: #error " instead of"
/usr/include/linux/version.h:34:2: error: #error ""
/usr/include/linux/version.h:35:2: error: #error " -I/usr/include/linux"
/usr/include/linux/version.h:36:2: error: #error ""
/usr/include/linux/version.h:37:2: error: #error " Please adjust the
Makefile accordingly."
/usr/include/linux/version.h:38:2: error: #error
"======================================================="
In file included from memalloc.inc:11,
from memalloc.c:1:
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:27:40: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:30:41: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:35:43: error: missing
binary operator before token "("
In file included from /usr/include/linux/sched.h:12,
from /usr/include/linux/module.h:9,
from /usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:51,
from memalloc.inc:11,
from memalloc.c:1:
/usr/include/linux/jiffies.h:42:3: error: #error You lose.
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:213:31: error: division by zero in #if
/usr/include/linux/jiffies.h:257:30: error: division by zero in #if
In file included from /usr/include/linux/sched.h:12,
from /usr/include/linux/module.h:9,
from /usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:51,
from memalloc.inc:11,
from memalloc.c:1:
/usr/include/linux/jiffies.h: In function ‘jiffies_to_msecs’:
/usr/include/linux/jiffies.h:262: error: ‘CONFIG_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h:262: error: (Each undeclared identifier is
reported only once
/usr/include/linux/jiffies.h:262: error: for each function it appears
in.)
/usr/include/linux/jiffies.h:268:36: error: division by zero in #if
/usr/include/linux/jiffies.h: In function ‘jiffies_to_usecs’:
/usr/include/linux/jiffies.h:273: error: ‘CONFIG_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h:281:30: error: division by zero in #if
/usr/include/linux/jiffies.h: In function ‘msecs_to_jiffies’:
/usr/include/linux/jiffies.h:286: error: ‘CONFIG_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h:294:36: error: division by zero in #if
/usr/include/linux/jiffies.h: In function ‘usecs_to_jiffies’:
/usr/include/linux/jiffies.h:299: error: ‘CONFIG_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h: In function ‘timespec_to_jiffies’:
/usr/include/linux/jiffies.h:318: error: ‘CONFIG_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h:324: error: ‘SHIFT_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h: In function ‘jiffies_to_timespec’:
/usr/include/linux/jiffies.h:337: error: ‘CONFIG_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h: In function ‘timeval_to_jiffies’:
/usr/include/linux/jiffies.h:359: error: ‘CONFIG_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h:363: error: ‘SHIFT_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h: In function ‘jiffies_to_timeval’:
/usr/include/linux/jiffies.h:375: error: ‘CONFIG_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h:385:6: error: division by zero in #if
/usr/include/linux/jiffies.h: In function ‘jiffies_to_clock_t’:
/usr/include/linux/jiffies.h:386: error: ‘CONFIG_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h: In function ‘clock_t_to_jiffies’:
/usr/include/linux/jiffies.h:397: error: ‘CONFIG_HZ’ undeclared (first
use in this function)
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h:416:6: error: division by zero in #if
/usr/include/linux/jiffies.h: In function ‘jiffies_64_to_clock_t’:
/usr/include/linux/jiffies.h:417: error: ‘CONFIG_HZ’ undeclared (first
use in this function)
In file included from /usr/include/linux/list.h:7,
from /usr/include/linux/wait.h:23,
from /usr/include/asm/semaphore.h:41,
from /usr/include/linux/sched.h:20,
from /usr/include/linux/module.h:9,
from /usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:51,
from memalloc.inc:11,
from memalloc.c:1:
/usr/include/linux/prefetch.h: In function ‘prefetch_range’:
/usr/include/linux/prefetch.h:64: error: ‘CONFIG_X86_L1_CACHE_SHIFT’
undeclared (first use in this function)
In file included from /usr/include/linux/module.h:22,
from /usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:51,
from memalloc.inc:11,
from memalloc.c:1:
/usr/include/asm/module.h:60:2: error: #error unknown processor family
In file included from memalloc.inc:11,
from memalloc.c:1:
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:121:40: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:124:40: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:150:40: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:178:62: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:190:40: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:196:40: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:264:40: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:331:40: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:352:40: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:362:40: error: missing
binary operator before token "("
/usr/src/alsa/alsa-driver-0.9.4/include/adriver.h:377:41: error: missing
binary operator before token "("
In file included from memalloc.c:1:
memalloc.inc:13:40: error: missing binary operator before token "("
In file included from memalloc.c:26:
/usr/include/linux/version.h:2:2: error: #error
"======================================================="
/usr/include/linux/version.h:3:2: error: #error "You should not include
/usr/include/{linux,asm}/ header"
/usr/include/linux/version.h:4:2: error: #error "files directly for the
compilation of kernel modules."
/usr/include/linux/version.h:5:2: error: #error ""
/usr/include/linux/version.h:6:2: error: #error "glibc now uses kernel
header files from a well-defined"
/usr/include/linux/version.h:7:2: error: #error "working kernel version
(as recommended by Linus Torvalds)"
/usr/include/linux/version.h:8:2: error: #error "These files are glibc
internal and may not match the"
/usr/include/linux/version.h:9:2: error: #error "currently running kernel.
They should only be"
/usr/include/linux/version.h:10:2: error: #error "included via other
system header files - user space"
/usr/include/linux/version.h:11:2: error: #error "programs should not
directly include <linux/*.h> or"
/usr/include/linux/version.h:12:2: error: #error "<asm/*.h> as well."
/usr/include/linux/version.h:13:2: error: #error ""
/usr/include/linux/version.h:14:2: error: #error "To build kernel modules
please do the following:"
/usr/include/linux/version.h:15:2: error: #error ""
/usr/include/linux/version.h:16:2: error: #error " o Have the kernel
sources installed"
/usr/include/linux/version.h:17:2: error: #error ""
/usr/include/linux/version.h:18:2: error: #error " o Make sure that the
symbolic link"
/usr/include/linux/version.h:19:2: error: #error " /lib/modules/`uname
-r`/build exists and points to"
/usr/include/linux/version.h:20:2: error: #error " the matching kernel
source directory"
/usr/include/linux/version.h:21:2: error: #error ""
/usr/include/linux/version.h:22:2: error: #error " o Configure kernel
sources:"
/usr/include/linux/version.h:23:2: error: #error " - cd /usr/src/linux"
/usr/include/linux/version.h:24:2: error: #error " - make mrproper"
/usr/include/linux/version.h:25:2: error: #error " - make cloneconfig"
/usr/include/linux/version.h:26:2: error: #error " - make dep"
/usr/include/linux/version.h:27:2: error: #error ""
/usr/include/linux/version.h:28:2: error: #error " o When compiling, make
sure to use the following"
/usr/include/linux/version.h:29:2: error: #error " compiler option to use
the correct include files:"
/usr/include/linux/version.h:30:2: error: #error ""
/usr/include/linux/version.h:31:2: error: #error " -I/lib/modules/`uname
-r`/build/include"
/usr/include/linux/version.h:32:2: error: #error ""
/usr/include/linux/version.h:33:2: error: #error " instead of"
/usr/include/linux/version.h:34:2: error: #error ""
/usr/include/linux/version.h:35:2: error: #error " -I/usr/include/linux"
/usr/include/linux/version.h:36:2: error: #error ""
/usr/include/linux/version.h:37:2: error: #error " Please adjust the
Makefile accordingly."
/usr/include/linux/version.h:38:2: error: #error
"======================================================="
In file included from /usr/include/asm/fixmap.h:27,
from /usr/include/asm/pgtable.h:17,
from /usr/include/linux/mm.h:36,
from memalloc.c:31:
/usr/include/asm/acpi.h:31:28: error: acpi/pdc_intel.h: No such file or
directory
memalloc.c:84:41: error: missing binary operator before token "("
memalloc.c: In function ‘mark_pages’:
memalloc.c:412: warning: initialization makes pointer from integer without
a cast
memalloc.c: In function ‘unmark_pages’:
memalloc.c:421: warning: initialization makes pointer from integer without
a cast
memalloc.c: In function ‘snd_mem_init’:
memalloc.c:892: error: ‘snd_mem_proc_read’ undeclared (first use in
this function)
In file included from memalloc.c:942:
memalloc.inc1:2:40: error: missing binary operator before token "("
make[1]: *** [memalloc.o] Error 1
make[1]: Leaving directory `/usr/src/alsa/alsa-driver-0.9.4/acore'
make: *** [compile] Error 1

*/
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-15-06 15:40 
----------------------------------------------------------------------
1.0.9-rc4 is not the latest version, and 0.9.4 is ancient.  Try 1.0.10 or
1.0.11-rc2.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-15-06 15:37 DavidJ         New Issue                                    
01-15-06 15:40 rlrevell       Note Added: 0007665                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
