From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000265]: Error building [hwdep.o] for alsa-driver
Date: Tue, 9 Nov 2004 16:18:08 +0100
Message-ID: <75f21ed36391825a0d3b414bf0455cf1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 06C15244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:18:08 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=265> 
======================================================================
Reported By:                umka27
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   265
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.4.26-vanilla
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-09-2004 02:28 CEST
Last Modified:              11-09-2004 16:18 CET
======================================================================
Summary:                    Error building [hwdep.o] for alsa-driver
Description: 

When compiling alsa-driver I get an error while trying to
build [hwdep.o]. I have trouble figuring out what the error is. Below is
the output that I get. This problem occurs when
I try to compile any of these:

 - alsa-driver-1.0.2c.ebuild  
 - alsa-driver-1.0.3.ebuild      
 - alsa-driver-1.0.4.ebuild
 - alsa-driver-1.0.4-r1.ebuild




gcc -D__KERNEL__ -DMODULE=1
-I/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include 
-I/usr/src/linux/include -O2 -mpreferred-stack-boundary=2 -march=i686
-DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix
include  -E -D__GENKSYMS__ vx_entry.c
| /sbin/genksyms -k 2.4.26  >
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/modules/pcmcia-vx__vx_entry.ver.tmp
mv
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/modules/pcmcia-vx__vx_entry.ver.tmp
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/modules/pcmcia-vx__vx_entry.ver
make[3]: Leaving directory
`/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/pcmcia/vx'
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/sndversions.h
was updated
make[2]: Leaving directory
`/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/pcmcia'
make[1]: Leaving directory
`/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c'
make[1]: Entering directory
`/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/acore'
gcc -D__KERNEL__ -DMODULE=1
-I/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include 
-I/usr/src/linux/include -O2 -mpreferred-stack-boundary=2 -march=i686
-DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix
include   -DEXPORT_SYMTAB -c hwdep.c
In file included from
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/sound/driver.h:42,
                 from hwdep.c:22:
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/adriver.h:134:
redefinition of `PDE'
/usr/src/linux/include/linux/proc_fs.h:213: `PDE' previously defined here
In file included from
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/sound/driver.h:42,
                 from hwdep.c:22:
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/adriver.h:189:1:
warning: "snprintf" redefined
In file included from /usr/src/linux/include/linux/modversions.h:176,
                 from
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/adriver.h:42,
                 from
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/sound/driver.h:42,
                 from hwdep.c:22:
/usr/src/linux/include/linux/modules/ksyms.ver:676:1: warning: this is the
location of the previous definition
In file included from
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/sound/driver.h:42,
                 from hwdep.c:22:
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/adriver.h:190:1:
warning: "vsnprintf" redefined
In file included from /usr/src/linux/include/linux/modversions.h:176,
                 from
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/adriver.h:42,
                 from
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/sound/driver.h:42,
                 from hwdep.c:22:
/usr/src/linux/include/linux/modules/ksyms.ver:682:1: warning: this is the
location of the previous definition
In file included from
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/sound/driver.h:42,
                 from hwdep.c:22:
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/adriver.h:395:1:
warning: "vmalloc_to_page" redefined
In file included from /usr/src/linux/include/linux/modversions.h:176,
                 from
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/adriver.h:42,
                 from
/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/include/sound/driver.h:42,
                 from hwdep.c:22:
/usr/src/linux/include/linux/modules/ksyms.ver:68:1: warning: this is the
location of the previous definition
make[1]: *** [hwdep.o] Error 1
make[1]: Leaving directory
`/var/tmp/portage/alsa-driver-1.0.2c/work/alsa-driver-1.0.2c/acore'
make: *** [compile] Error 1


======================================================================

----------------------------------------------------------------------
 umka27 - 05-25-04 19:53 
----------------------------------------------------------------------
So, I went to the directory
/var/tmp/portage/alsa-driver-1.0.3/work/alsa-driver-1.0.3/acore

Then use make file to compile stuff within the directory:

Iceberg acore # make
gcc -D__KERNEL__ -DMODULE=1 -I/tmp/alsa-driver-1.0.4/include
-I/lib/modules/2.4.26/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include -DEXPORT_SYMTAB -c hwdep.c
In file included from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/tmp/alsa-driver-1.0.4/include/adriver.h:134: redefinition of `PDE'
/lib/modules/2.4.26/build/include/linux/proc_fs.h:213: `PDE' previously
defined here
In file included from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/tmp/alsa-driver-1.0.4/include/adriver.h:191:1: warning: "snprintf"
redefined
In file included from
/lib/modules/2.4.26/build/include/linux/modversions.h:176,
from /tmp/alsa-driver-1.0.4/include/adriver.h:42,
from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/lib/modules/2.4.26/build/include/linux/modules/ksyms.ver:676:1: warning:
this is the location of the previous definition
In file included from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/tmp/alsa-driver-1.0.4/include/adriver.h:192:1: warning: "vsnprintf"
redefined
In file included from
/lib/modules/2.4.26/build/include/linux/modversions.h:176,
from /tmp/alsa-driver-1.0.4/include/adriver.h:42,
from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/lib/modules/2.4.26/build/include/linux/modules/ksyms.ver:682:1: warning:
this is the location of the previous definition
In file included from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/tmp/alsa-driver-1.0.4/include/adriver.h:434:1: warning: "vmalloc_to_page"
redefined
In file included from
/lib/modules/2.4.26/build/include/linux/modversions.h:176,
from /tmp/alsa-driver-1.0.4/include/adriver.h:42,
from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/lib/modules/2.4.26/build/include/linux/modules/ksyms.ver:68:1: warning:
this is the location of the previous definition
make: *** [hwdep.o] Error 1
Iceberg acore #




Then I tried to run gcc command separately and I didn't get any errors
but no .o files were created.




Iceberg acore # gcc -D__KERNEL__ -DMODULE=1
-I/tmp/alsa-driver-1.0.4/include -I/lib/modules/2.4.26/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DEXPORT_SYMTAB -c
hwdep.c
In file included from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/tmp/alsa-driver-1.0.4/include/adriver.h:134: redefinition of `PDE'
/lib/modules/2.4.26/build/include/linux/proc_fs.h:213: `PDE' previously
defined here
In file included from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/tmp/alsa-driver-1.0.4/include/adriver.h:191:1: warning: "snprintf"
redefined
In file included from
/lib/modules/2.4.26/build/include/linux/modversions.h:176,
from /tmp/alsa-driver-1.0.4/include/adriver.h:42,
from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/lib/modules/2.4.26/build/include/linux/modules/ksyms.ver:676:1: warning:
this is the location of the previous definition
In file included from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/tmp/alsa-driver-1.0.4/include/adriver.h:192:1: warning: "vsnprintf"
redefined
In file included from
/lib/modules/2.4.26/build/include/linux/modversions.h:176,
from /tmp/alsa-driver-1.0.4/include/adriver.h:42,
from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/lib/modules/2.4.26/build/include/linux/modules/ksyms.ver:682:1: warning:
this is the location of the previous definition
In file included from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/tmp/alsa-driver-1.0.4/include/adriver.h:434:1: warning: "vmalloc_to_page"
redefined
In file included from
/lib/modules/2.4.26/build/include/linux/modversions.h:176,
from /tmp/alsa-driver-1.0.4/include/adriver.h:42,
from /tmp/alsa-driver-1.0.4/include/sound/driver.h:42,
from hwdep.c:22:
/lib/modules/2.4.26/build/include/linux/modules/ksyms.ver:68:1: warning:
this is the location of the previous definition
Iceberg acore # ls *.o
ls: *.o: No such file or directory
Iceberg acore #



I also tried using the tarball directrly from alsa-project.org, but I get
the
same exact problems.

----------------------------------------------------------------------
 perex - 09-07-04 16:43 
----------------------------------------------------------------------
The problem is fixed in recent ALSA releases.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-09-04 02:28 umka27         New Issue                                    
05-09-04 02:28 umka27         Distribution              => Gentoo          
05-09-04 02:28 umka27         Kernel Version            => 2.4.26-vanilla  
05-25-04 19:53 umka27         Note Added: 0001236                          
09-07-04 16:43 perex          Status                   assigned => resolved
09-07-04 16:43 perex          Resolution               open => fixed       
09-07-04 16:43 perex          Note Added: 0001714                          
11-09-04 16:18 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
