From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001258]: it doesn't work
Date: Wed, 24 Aug 2005 16:25:54 +0200
Message-ID: <e42f038cfc48667abfb807f463d0e999@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 498C418E
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 16:25:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1258> 
======================================================================
Reported By:                huxark
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1258
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               fedora
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-15-2005 09:29 CEST
Last Modified:              08-24-2005 16:25 CEST
======================================================================
Summary:                    it doesn't work
Description: 
[root@localhost alsa-driver-1.0.5]# ./configure --with-cards=ca0106
--with-sequencer=yes;make;make install
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking for ranlib... ranlib
checking for a BSD-compatible install... /usr/bin/install -c
checking how to run the C preprocessor... gcc -E
checking for egrep... grep -E
checking for ANSI C header files... yes
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking whether time.h and sys/time.h may both be included... yes
checking whether gcc needs -traditional... no
checking for current directory... /usr/src/alsa-driver-1.0.5
checking cross compile...
checking for directory with kernel source...
/lib/modules/2.6.11-1.1369_FC4/build
checking for kernel version... 2.6.11-1.1369_FC4
checking for GCC version... Kernel compiler: gcc 4.0.0 20050525 (Red Hat
4.0.0-9) Used compiler: gcc (GCC) 4.0.0 20050519 (Red Hat 4.0.0-8)
checking for built-in ALSA... "no"
checking for existing ALSA module... "yes"
checking for Red Hat kernel... "auto"
checking for Red Hat kernel... "no"
checking to modify of kernel linux/kmod.h... "no"
Removing a dummy linux/kmod.h.
checking for kernel linux/compiler.h... "yes"
Removing a dummy linux/compiler.h.
checking for kernel linux/pm.h... "yes"
checking for kernel linux/spinlock.h... "yes"
checking for kernel linux/irq.h... "yes"
Removing a dummy linux/irq.h.
checking for kernel linux/threads.h... "yes"
Removing a dummy linux/threads.h.
checking for kernel linux/rwsem.h... "yes"
Removing a dummy linux/rwsem.h.
checking for kernel linux/gameport.h... "yes"
Removing a dummy linux/gameport.h.
checking for kernel linux/devfs_fs_kernel.h... "yes"
checking for kernel linux/highmem.h... "yes"
Removing a dummy linux/highmem.h.
checking for kernel linux/workqueue.h... "yes"
Removing a dummy linux/workqueue.h.
checking for kernel linux/dma-mapping.h... "yes"
Removing a dummy linux/dma-mapping.h.
checking for kernel asm/hw_irq.h... "yes"
Removing a dummy asm/hw_irq.h.
checking for kernel linux/device.h... "yes"
Removing a dummy linux/device.h.
checking for kernel linux/jiffies.h... "yes"
Removing a dummy linux/jiffies.h.
checking for kernel linux/compat.h... "yes"
Removing a dummy linux/compat.h.
checking for kernel linux/adb.h... "yes"
Removing a dummy linux/adb.h.
checking for kernel linux/cuda.h... "yes"
Removing a dummy linux/cuda.h.
checking for kernel linux/pmu.h... "yes"
Removing a dummy linux/pmu.h.
checking for kernel linux/moduleparam.h... "yes"
Removing a dummy linux/moduleparam.h.
checking for kernel linux/syscalls.h... "yes"
Removing a dummy linux/syscalls.h.
checking for kernel module symbol versions... "yes"
checking for PCI support in kernel... "yes"
checking for Experimental drivers in kernel... "yes"
checking for SGI/MIPS (HAL2) architecture... "no"
checking for directory to store kernel modules...
/lib/modules/2.6.11-1.1369_FC4/kernel/sound
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... "yes"
checking for processor type... i686
checking for i386 machine type... default
checking for SMP... "no"
checking for Video device support in kernel... "yes"
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... "yes"
checking for strlcpy... "yes"
checking for snprintf... "yes"
checking for scnprintf... "yes"
checking for vmalloc_to_page... "yes"
checking for old kmod... "no"
checking for PDE... "yes"
checking for pci_set_consistent_dma_mask... "yes"
checking for tty->count is the atomic type... "no"
checking for video_get_drvdata... "yes"
Removing local linux/isapnp.h.
Removing local linux/pnp.h.
checking for driver version... 1.0.5
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... "yes"
checking for USB support... "yes"
checking for kernel PCMCIA
checking for PCMCIA support... "yes"
checking for PC9800 support in kernel... "no"
checking for which soundcards to compile driver for... Unknown soundcard
ca0106, exiting!

======================================================================

----------------------------------------------------------------------
 jcdutton - 07-15-05 10:36 
----------------------------------------------------------------------
Use alsa-driver 1.0.9 and not alsa-driver 1.0.5

----------------------------------------------------------------------
 perex - 08-24-05 16:25 
----------------------------------------------------------------------
No response.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-15-05 09:29 huxark         New Issue                                    
07-15-05 09:29 huxark         Distribution              => fedora          
07-15-05 10:36 jcdutton       Note Added: 0005480                          
08-24-05 16:25 perex          Status                   assigned => resolved
08-24-05 16:25 perex          Resolution               open => fixed       
08-24-05 16:25 perex          Note Added: 0005930                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
