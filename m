From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000687]: Cannot build gentoo-ebuild for 1.0.7
Date: Wed, 1 Dec 2004 16:35:11 +0100
Message-ID: <04541051234f68579bd7741eaee66eb3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BD2002E3
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2004 16:35:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=687> 
======================================================================
Reported By:                m_wright
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   687
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.9-ck2
======================================================================
Date Submitted:             11-28-2004 19:06 CET
Last Modified:              12-01-2004 16:35 CET
======================================================================
Summary:                    Cannot build gentoo-ebuild for 1.0.7
Description: 
The gentoo ebuild for 1.0.7-r1 (basically 1.0.7) fails on linux kernel
2.6.9-ck2 with the following errors:

/var/tmp/portage/alsa-driver-1.0.7-r1/work/alsa-driver-1.0.7/acore/memory_wrapper.c:
In function `snd_compat_vmalloc_to_page':
/var/tmp/portage/alsa-driver-1.0.7-r1/work/alsa-driver-1.0.7/acore/memory_wrapper.c:41:
warning: implicit declaration of function `VMALLOC_VMADDR'
/var/tmp/portage/alsa-driver-1.0.7-r1/work/alsa-driver-1.0.7/acore/memory_wrapper.c:47:
warning: implicit declaration of function `pte_offset'
/var/tmp/portage/alsa-driver-1.0.7-r1/work/alsa-driver-1.0.7/acore/memory_wrapper.c:47:
warning: assignment makes pointer from integer without a cast
======================================================================

----------------------------------------------------------------------
 ebichu - 12-01-04 16:01 
----------------------------------------------------------------------
I'm using a later Gentoo ebuild (alsa-driver-1.0.7-r1) and a vanilla kernel
(2.6.9) but it fails in the same place.  The config.log entry for
vmalloc_to_page is as follows:

configure:5965: checking for vmalloc_to_page
configure:5994: i686-pc-linux-gnu-gcc -c -march=athlon -O3 -pipe
-fomit-frame-pointer -I/usr/src/linux/include  -nostdinc -iwithprefix
include  conftest.c >&5
In file included from /usr/src/linux/include/asm/smp.h:18,
                 from /usr/src/linux/include/linux/smp.h:17,
                 from /usr/src/linux/include/linux/sched.h:23,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from conftest.c:25:
/usr/src/linux/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or
directory
In file included from /usr/src/linux/include/asm/smp.h:18,
                 from /usr/src/linux/include/linux/smp.h:17,
                 from /usr/src/linux/include/linux/sched.h:23,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from conftest.c:25:
/usr/src/linux/include/asm/mpspec.h:8: error: `MAX_MP_BUSSES' undeclared
here (not in a function)
/usr/src/linux/include/asm/mpspec.h:22: error: `MAX_IRQ_SOURCES'
undeclared here (not in a function)
In file included from /usr/src/linux/include/linux/smp.h:17,
                 from /usr/src/linux/include/linux/sched.h:23,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from conftest.c:25:
/usr/src/linux/include/asm/smp.h:72:26: mach_apicdef.h: No such file or
directory
configure:6000: $? = 1
configure: failed program was:
| /* confdefs.h.  */
| 
| #define PACKAGE_NAME ""
| #define PACKAGE_TARNAME ""
| #define PACKAGE_VERSION ""
| #define PACKAGE_STRING ""
| #define PACKAGE_BUGREPORT ""
| #define STDC_HEADERS 1
| #define TIME_WITH_SYS_TIME 1
| #define CONFIG_SND_KERNELDIR "/usr/src/linux"
| #define CONFIG_HAVE_DUMP_STACK 1
| #define CONFIG_SND_VERBOSE_PRINTK 1
| #define CONFIG_SND_ISA 1
| #define CONFIG_ISAPNP_KERNEL 1
| #define CONFIG_PNP_KERNEL 1
| #define CONFIG_HAVE_STRLCPY 1
| #define CONFIG_HAVE_SNPRINTF 1
| #define CONFIG_HAVE_SCNPRINTF 1
| #define CONFIG_HAVE_SSCANF 1
| /* end confdefs.h.  */
| 
| #define __KERNEL__
| #include <linux/config.h>
| #include <linux/time.h>
| #include <linux/mm.h>
| 
| int
| main ()
| {
| 
|   struct page * (*func)(void*);
|   func = vmalloc_to_page;
| 
|   ;
|   return 0;
| }
configure:6021: result: "no"

----------------------------------------------------------------------
 tiwai - 12-01-04 16:35 
----------------------------------------------------------------------
Check whether /usr/src/linux/include/asm-i386/mach-default/mach_mpspec.h
exists.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 19:06 m_wright       New Issue                                    
11-28-04 19:06 m_wright       Distribution              => Gentoo Linux    
11-28-04 19:06 m_wright       Kernel Version            => 2.6.9-ck2       
11-29-04 15:27 tiwai          Note Added: 0002638                          
11-29-04 16:41 m_wright       Note Added: 0002653                          
11-29-04 17:20 tiwai          Note Added: 0002655                          
12-01-04 16:01 ebichu         Note Added: 0002665                          
12-01-04 16:01 ebichu         Issue Monitored: ebichu                      
12-01-04 16:35 tiwai          Note Added: 0002666                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
