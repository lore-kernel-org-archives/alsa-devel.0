From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001691]: Fails to build on LInux 2.4
Date: Wed, 4 Jan 2006 14:43:02 +0100
Message-ID: <1495dd358880aa606b048339d8782532@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C36F2184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 14:43:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1691> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1691
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-28-2005 22:43 CET
Last Modified:              01-04-2006 14:43 CET
======================================================================
Summary:                    Fails to build on LInux 2.4
Description: 
make[3]: Leaving directory `/usr/src/modules/alsa-driver/drivers'
make[3]: Entering directory `/usr/src/modules/alsa-driver/isa'
rm -f als100.isapnp
touch als100.isapnp
rm -f azt2320.isapnp
touch azt2320.isapnp
rm -f dt019x.isapnp
touch dt019x.isapnp
rm -f opl3sa2.isapnp
touch opl3sa2.isapnp
rm -f cmi8330.isapnp
touch cmi8330.isapnp
rm -f es18xx.isapnp
touch es18xx.isapnp
rm -f sscape.isapnp
touch sscape.isapnp
gcc-3.3 -D__KERNEL__ -DMODULE=1 -I/usr/src/modules/alsa-driver/include 
-I/usr/src/linux/include -I/usr/src/linux/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include
/usr/src/linux/include/linux/modversions.h  -DKBUILD_BASENAME=cmi8330   -c
-o cmi8330.o cmi8330.c
In file included from cmi8330.c:1:
../alsa-kernel/isa/cmi8330.c: In function `snd_cmi8330_unregister_all':
../alsa-kernel/isa/cmi8330.c:676: error: `cmi8330_pnpc_driver' undeclared
(first use in this function)
../alsa-kernel/isa/cmi8330.c:676: error: (Each undeclared identifier is
reported only once
../alsa-kernel/isa/cmi8330.c:676: error: for each function it appears
in.)
../alsa-kernel/isa/cmi8330.c: In function `alsa_card_cmi8330_init':
../alsa-kernel/isa/cmi8330.c:703: error: `cmi8330_pnpc_driver' undeclared
(first use in this function)
make[3]: *** [cmi8330.o] Error 1
make[3]: Leaving directory `/usr/src/modules/alsa-driver/isa'
make[2]: *** [compile] Error 1
make[2]: Leaving directory `/usr/src/modules/alsa-driver'
make[1]: *** [build-stamp] Error 2
make[1]: Leaving directory `/usr/src/modules/alsa-driver'
make: *** [kdist_image] Error 2

======================================================================

----------------------------------------------------------------------
 jdthood - 12-28-05 23:10 
----------------------------------------------------------------------
The build failed with "--with-isapnp=no".  The build succeeded when I
changed this to "--with-isapnp=yes".

----------------------------------------------------------------------
 jdthood - 01-04-06 14:43 
----------------------------------------------------------------------
I just tried to build 1.0.11rc2 against Linux 2.4.27 with
"--with-isapnp=yes" and the build failed.

make[4]: Entering directory `/usr/src/modules/alsa-driver/acore'
gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/modules/alsa-driver/include 
-I/usr/src/kernel-source-2.4.27/include
-I/usr/src/kernel-source-2.4.27/include -O2 -mpreferred-stack-boundary=2
-march=i686 -Wdeclaration-after-statement -Wno-pointer-sign -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix
include -DMODVERSIONS -include
/usr/src/kernel-source-2.4.27/include/linux/modversions.h  
-DEXPORT_SYMTAB -c hwdep.c
In file included from
/usr/src/kernel-source-2.4.27/include/linux/kernel.h:15,
                 from
/usr/src/kernel-source-2.4.27/include/asm/system.h:5,
                 from
/usr/src/kernel-source-2.4.27/include/linux/spinlock.h:6,
                 from
/usr/src/kernel-source-2.4.27/include/linux/module.h:12,
                 from /usr/src/modules/alsa-driver/include/adriver.h:45,
                 from
/usr/src/modules/alsa-driver/include/sound/driver.h:47,
                 from hwdep.c:22:
/usr/src/kernel-source-2.4.27/include/asm/byteorder.h:14: warning: type
qualifiers ignored on function return type
/usr/src/kernel-source-2.4.27/include/asm/byteorder.h:30: warning: type
qualifiers ignored on function return type
In file included from
/usr/src/kernel-source-2.4.27/include/linux/byteorder/little_endian.h:11,
                 from
/usr/src/kernel-source-2.4.27/include/asm/byteorder.h:65,
                 from
/usr/src/kernel-source-2.4.27/include/linux/kernel.h:15,
                 from
/usr/src/kernel-source-2.4.27/include/asm/system.h:5,
                 from
/usr/src/kernel-source-2.4.27/include/linux/spinlock.h:6,
                 from
/usr/src/kernel-source-2.4.27/include/linux/module.h:12,
                 from /usr/src/modules/alsa-driver/include/adriver.h:45,
                 from
/usr/src/modules/alsa-driver/include/sound/driver.h:47,
                 from hwdep.c:22:
/usr/src/kernel-source-2.4.27/include/linux/byteorder/swab.h:160: warning:
type qualifiers ignored on function return type
/usr/src/kernel-source-2.4.27/include/linux/byteorder/swab.h:173: warning:
type qualifiers ignored on function return type
/usr/src/kernel-source-2.4.27/include/linux/byteorder/swab.h:186: warning:
type qualifiers ignored on function return type
/usr/src/kernel-source-2.4.27/include/linux/byteorder/swab.h:200: warning:
type qualifiers ignored on function return type
In file included from
/usr/src/kernel-source-2.4.27/include/linux/prefetch.h:13,
                 from
/usr/src/kernel-source-2.4.27/include/linux/list.h:6,
                 from
/usr/src/kernel-source-2.4.27/include/linux/module.h:13,
                 from /usr/src/modules/alsa-driver/include/adriver.h:45,
                 from
/usr/src/modules/alsa-driver/include/sound/driver.h:47,
                 from hwdep.c:22:
/usr/src/kernel-source-2.4.27/include/asm/processor.h:75: error: array
type has incomplete element type
In file included from
/usr/src/modules/alsa-driver/include/sound/driver.h:47,
                 from hwdep.c:22:
/usr/src/modules/alsa-driver/include/adriver.h:160: error: redefinition of
'PDE'
/usr/src/kernel-source-2.4.27/include/linux/proc_fs.h:214: error: previous
definition of 'PDE' was here
In file included from
/usr/src/modules/alsa-driver/include/sound/driver.h:47,
                 from hwdep.c:22:
/usr/src/modules/alsa-driver/include/adriver.h:325:1: warning: "snprintf"
redefined
In file included from
/usr/src/kernel-source-2.4.27/include/linux/modversions.h:188,
                 from <command line>:1:
/usr/src/kernel-source-2.4.27/include/linux/modules/ksyms.ver:684:1:
warning: this is the location of the previous definition
In file included from
/usr/src/modules/alsa-driver/include/sound/driver.h:47,
                 from hwdep.c:22:
/usr/src/modules/alsa-driver/include/adriver.h:330:1: warning: "vsnprintf"
redefined
In file included from
/usr/src/kernel-source-2.4.27/include/linux/modversions.h:188,
                 from <command line>:1:
/usr/src/kernel-source-2.4.27/include/linux/modules/ksyms.ver:690:1:
warning: this is the location of the previous definition
In file included from
/usr/src/modules/alsa-driver/include/sound/driver.h:47,
                 from hwdep.c:22:
/usr/src/modules/alsa-driver/include/adriver.h:342:1: warning: "sscanf"
redefined
In file included from
/usr/src/kernel-source-2.4.27/include/linux/modversions.h:188,
                 from <command line>:1:
/usr/src/kernel-source-2.4.27/include/linux/modules/ksyms.ver:686:1:
warning: this is the location of the previous definition
In file included from
/usr/src/modules/alsa-driver/include/sound/driver.h:47,
                 from hwdep.c:22:
/usr/src/modules/alsa-driver/include/adriver.h:343:1: warning: "vsscanf"
redefined
In file included from
/usr/src/kernel-source-2.4.27/include/linux/modversions.h:188,
                 from <command line>:1:
/usr/src/kernel-source-2.4.27/include/linux/modules/ksyms.ver:692:1:
warning: this is the location of the previous definition
In file included from
/usr/src/modules/alsa-driver/include/sound/driver.h:47,
                 from hwdep.c:22:
/usr/src/modules/alsa-driver/include/adriver.h:620:1: warning:
"vmalloc_to_page" redefined
In file included from
/usr/src/kernel-source-2.4.27/include/linux/modversions.h:188,
                 from <command line>:1:
/usr/src/kernel-source-2.4.27/include/linux/modules/ksyms.ver:70:1:
warning: this is the location of the previous definition
make[4]: *** [hwdep.o] Error 1
make[4]: Leaving directory `/usr/src/modules/alsa-driver/acore'
make[3]: *** [compile] Error 1
make[3]: Leaving directory `/usr/src/modules/alsa-driver'
make[2]: *** [build-stamp] Error 2
make[2]: Leaving directory `/usr/src/modules/alsa-driver'
make[1]: *** [kdist_image] Error 2
make[1]: Leaving directory `/usr/src/modules/alsa-driver'
Module /usr/src/modules/alsa-driver failed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-05 22:43 jdthood        New Issue                                    
12-28-05 23:10 jdthood        Note Added: 0007186                          
01-04-06 14:43 jdthood        Note Added: 0007422                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
