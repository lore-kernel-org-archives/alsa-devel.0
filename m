From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000676]: Unsupported soundcard au8820
Date: Thu, 25 Nov 2004 15:53:56 +0100
Message-ID: <4fe04a9d878428fb7f34e4469452eb65@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B45E12A3
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2004 15:53:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=676> 
======================================================================
Reported By:                coldspringc
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   676
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Red Hat?
Kernel Version:             2.4.21-20.EL
======================================================================
Date Submitted:             11-24-2004 19:32 CET
Last Modified:              11-25-2004 15:53 CET
======================================================================
Summary:                    Unsupported soundcard au8820
Description: 
Sirs

I'm am trying to install your driver to support my Au8820 sound card. I am
a newbie at this so I have enclosed a complete copy of the  process.  I
have just reinstalled the operating system to insure I did not have any
latent files screwing things up.  Using the procdures listed under the
quick install for the Aureal 8820 I get the error.  "checking for which
soundcards to compile driver for... configure: error: Unsupported
soundcard au8820"

Before I stated the process I did a modinfo soundcore to check if I need
to recomplite the kernel.  Based on the feed back from modinfo (see below)
and your install instuctions I believe I do not have to recompile.  

Can you please help!  I have been at this for over a week!


[root@localhost root]# modinfo soundcore
filename:    /lib/modules/2.4.21-20.EL/kernel/drivers/sound/soundcore.o
description: "Core sound module"
author:      "Alan Cox"
license:     "GPL"
[root@localhost root]# cd /usr/src
[root@localhost src]# mkdir alsa
[root@localhost src]# cd alsa
[root@localhost alsa]# wget
ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.7.tar.bz2
--13:09:42-- 
ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.7.tar.bz2
           => `alsa-driver-1.0.7.tar.bz2'
Resolving ftp.alsa-project.org... done.
Connecting to ftp.alsa-project.org[160.217.9.25]:21... connected.
Logging in as anonymous ... Logged in!
==> SYST ... done.    ==> PWD ... done.
==> TYPE I ... done.  ==> CWD /pub/driver ... done.
==> PASV ... done.    ==> RETR alsa-driver-1.0.7.tar.bz2 ... done.
Length: 1,829,053 (unauthoritative)
 
100%[====================================>] 1,829,053     50.07K/s    ETA
00:00
 
13:10:20 (50.07 KB/s) - `alsa-driver-1.0.7.tar.bz2' saved [1829053]
 
[root@localhost alsa]# dir
alsa-driver-1.0.7.tar.bz2
[root@localhost alsa]# bunzip2 alsa-driver-1.0.7.tar.bz2
[root@localhost alsa]# dir
alsa-driver-1.0.7.tar
[root@localhost alsa]# tar -xf alsa-driver-1.0.7.tar
[root@localhost alsa]# cd alsa-driver-1.0.7
[root@localhost alsa-driver-1.0.7]# ./configure --with-cards=au8820
--with-sequencer=yes;make;make install
checking for gcc... gcc
checking for C compiler default output... a.out
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
checking for current directory... /usr/src/alsa/alsa-driver-1.0.7
checking cross compile...
checking for directory with kernel source...
/lib/modules/2.4.21-20.EL/build
checking for directory with kernel build...
checking for kernel version... 0.0.0
checking for GCC version... Kernel compiler:  Used compiler: gcc (GCC)
3.2.3 20030502 (Red Hat Linux 3.2.3-42)
 
*** NO PREDEFINED KERNEL COMPILER IS DETECTED
*** Assuming the same compiler is used with the current system compiler.
 
*** Please make sure that the same compiler version was used for building
kernel.
 
checking for built-in ALSA... "no"
checking for existing ALSA module... "no"
checking for Red Hat kernel... "auto"
checking for Red Hat kernel... "no"
checking for SUSE kernel... "auto"
checking for SUSE kernel... "no"
checking to modify of kernel linux/kmod.h... "yes"
cat: /lib/modules/2.4.21-20.EL/build/include/linux/kmod.h: No such file or
directory
checking for kernel linux/compiler.h... "no"
Creating a dummy <linux/compiler.h>...
checking for kernel linux/pm.h... "no"
Creating a dummy <linux/pm.h>...
checking for kernel linux/spinlock.h... "no"
Creating a dummy <linux/spinlock.h>...
checking for kernel linux/irq.h... "no"
Creating a dummy <linux/irq.h>...
checking for kernel linux/threads.h... "no"
Creating a dummy <linux/threads.h>...
checking for kernel linux/rwsem.h... "no"
Creating a dummy <linux/rwsem.h>...
checking for kernel linux/gameport.h... "no"
Creating a dummy <linux/gameport.h>...
checking for kernel linux/devfs_fs_kernel.h... "no"
Creating a dummy <linux/devfs_fs_kernel.h>...
checking for kernel linux/highmem.h... "no"
Creating a dummy <linux/highmem.h>...
checking for kernel linux/workqueue.h... "no"
checking for kernel linux/dma-mapping.h... "no"
checking for kernel asm/hw_irq.h... "no"
Creating a dummy <asm/hw_irq.h>...
checking for kernel linux/device.h... "no"
checking for kernel linux/jiffies.h... "no"
checking for kernel linux/compat.h... "no"
checking for kernel linux/adb.h... "no"
Creating <linux/adb.h>...
checking for kernel linux/cuda.h... "no"
Creating <linux/cuda.h>...
checking for kernel linux/pmu.h... "no"
Creating <linux/pmu.h>...
checking for kernel linux/moduleparam.h... "no"
checking for kernel linux/syscalls.h... "no"
checking for exported symbol dump_stack... grep:
/lib/modules/2.4.21-20.EL/build/kernel/ksyms.c: No such file or directory
"no"
checking for kernel module symbol versions... "no"
checking for PCI support in kernel... "no"
checking for I2C driver in kernel... unknown
checking for SGI/MIPS (HAL2) architecture... "no"
checking for directory to store kernel modules... /lib/modules/0.0.0/misc
checking for verbose printk... on
checking for debug level... none
checking for processor type... "unknown"
checking for SMP... "no"
checking for ISA PnP driver in kernel... no
checking for PnP driver in kernel... no
checking for ISA PnP support... yes
checking for strlcpy... "no"
checking for snprintf... "no"
checking for scnprintf... "no"
checking for sscanf... "no"
checking for vmalloc_to_page... "no"
checking for old kmod... "yes"
checking for PDE... "no"
checking for pci_set_consistent_dma_mask... "no"
checking for tty->count is the atomic type... "no"
checking for remap_pfn_range... "no"
checking for new remap_page_range... "no"
checking for kcalloc... "no"
checking for saved_config_space in pci_dev... "no"
checking for acpi_register_gsi... "no"
checking for old kill_fasync... "no"
checking for dma_addr_t... "no"
checking for MUTEX macros... "no"
Symlinking <linux/isapnp.h>...
checking for driver version... 1.0.7
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... "no"
checking for Procfs support... "no"
checking for USB support... "no"
checking for USB module support... "no"
checking for kernel PCMCIA
checking for PCMCIA support... "no"
checking for PCMCIA module support... "no"
checking for PC9800 support in kernel... "no"
checking for parallel port support... "no"
checking for parallel port module support... "no"
checking for which soundcards to compile driver for... configure: error:
Unsupported soundcard au8820
make all-deps
make[1]: Entering directory `/usr/src/alsa/alsa-driver-1.0.7'
make[1]: Nothing to be done for `all-deps'.
make[1]: Leaving directory `/usr/src/alsa/alsa-driver-1.0.7'
 
Please, run the configure script as first...
 
rm -f /snd*.*o /persist.o /isapnp.o
make[1]: Entering directory `/usr/src/alsa/alsa-driver-1.0.7/acore'
Makefile:6: /usr/src/alsa/alsa-driver-1.0.7/Makefile.conf: No such file or
directory
make[1]: *** No rule to make target
`/usr/src/alsa/alsa-driver-1.0.7/Makefile.conf'.  Stop.
make[1]: Leaving directory `/usr/src/alsa/alsa-driver-1.0.7/acore'
make: *** [install-modules] Error 1
[root@localhost alsa-driver-1.0.7]#


======================================================================

----------------------------------------------------------------------
 tiwai - 11-25-04 15:53 
----------------------------------------------------------------------
It looks like that you don't have a proper kernel source tree.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 19:32 coldspringc    New Issue                                    
11-24-04 19:32 coldspringc    Distribution              => Red Hat?        
11-24-04 19:32 coldspringc    Kernel Version            => 2.4.21-20.EL    
11-25-04 15:53 tiwai          Note Added: 0002592                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
