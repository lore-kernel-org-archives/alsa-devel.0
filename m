From: noreply@alsa-project.org
Subject: [ALSA - driver 0000050]: I cannot compile the driver
Date: Fri, 16 Jul 2004 13:07:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110720.816C426008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D8426255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:07:20 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000050
======================================================================
Reported By:                alo
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     50
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-11-2004 10:46 CET
Last Modified:              07-16-2004 13:07 CEST
======================================================================
Summary:                    I cannot compile the driver
Description: 
This is the output for the following command: "./configure
--with-cards=ice1712 --with-sequencer=yes --with-kernel=/usr;make;make
install"

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
checking for current directory... /home/alo/sw/alsa/alsa-driver-1.0.2c
checking cross compile... 
checking for directory with kernel source... /usr
checking for kernel version... 2.4.22
checking for GCC version... Kernel compiler:  Used compiler: gcc (GCC)
3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)

*** NO PREDEFINED KERNEL COMPILER IS DETECTED
*** Assuming the same compiler is used with the current system compiler.

*** Please make sure that the same compiler version was used for building
kernel.

checking for built-in ALSA... "no"
checking for existing ALSA module... "no"
checking for Red Hat kernel... "auto"
checking for Red Hat kernel... "no"
checking to modify of kernel linux/kmod.h... "no"
checking for kernel linux/compiler.h... "yes"
checking for kernel linux/pm.h... "yes"
checking for kernel linux/spinlock.h... "yes"
checking for kernel linux/irq.h... "yes"
checking for kernel linux/threads.h... "yes"
checking for kernel linux/rwsem.h... "yes"
checking for kernel linux/gameport.h... "yes"
checking for kernel linux/devfs_fs_kernel.h... "yes"
checking for kernel linux/highmem.h... "yes"
checking for kernel linux/workqueue.h... "no"
checking for kernel asm/hw_irq.h... "yes"
checking for kernel linux/device.h... "no"
checking for kernel linux/jiffies.h... "no"
checking for kernel linux/compat.h... "no"
checking for kernel linux/adb.h... "yes"
checking for kernel linux/cuda.h... "yes"
checking for kernel linux/pmu.h... "yes"
checking for exported symbol dump_stack... grep: /usr/kernel/ksyms.c: No
such file or directory
"no"
checking for kernel module symbol versions... "no"
checking for PCI support in kernel... "yes"
checking for SGI/MIPS (HAL2) architecture... "no"
checking for directory to store kernel modules...
/lib/modules/2.4.22/misc
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... "no"
checking for processor type... x86_64
checking for SMP... "no"
checking for Video device support in kernel... "no"
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... "no"
checking for Kernel ISA-PnP module support... "no"
checking for strlcpy... "no"
checking for snprintf... "yes"
checking for vmalloc_to_page... "no"
checking for old kmod... "yes"
checking for PDE... "no"
checking for pci_set_consistent_dma_mask... "no"
checking for tty->count is the atomic type... "no"
checking for driver version... 1.0.2c
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... "no"
checking for USB support... "yes"
checking for kernel PCMCIA
checking for PCMCIA support... "yes"
checking for PC9800 support in kernel... "no"
checking for which soundcards to compile driver for... ice1712
configure: creating ./config.status
config.status: creating version
config.status: creating Makefile.conf
config.status: creating snddevices
config.status: creating utils/alsa-driver.spec
config.status: creating utils/buildrpm
config.status: creating toplevel.config
config.status: creating utils/alsasound
config.status: creating utils/alsasound.posix
config.status: creating include/config.h
config.status: include/config.h is unchanged
config.status: creating include/config1.h
config.status: include/config1.h is unchanged
config.status: creating include/version.h
config.status: include/version.h is unchanged
config.status: creating include/autoconf-extra.h
config.status: include/autoconf-extra.h is unchanged
make[1]: Entering directory `/home/alo/sw/alsa/alsa-driver-1.0.2c/acore'
gcc -D__KERNEL__ -DMODULE=1 -I/home/alo/sw/alsa/alsa-driver-1.0.2c/include
 -I/usr/include -O2 -mno-red-zone -mcmodel=kernel -fno-reorder-blocks
-fno-strength-reduce -finline-limit=2000 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include   -DEXPORT_SYMTAB -c
memalloc.c
cc1: error: code model `kernel' not supported in the 32 bit mode
make[1]: *** [memalloc.o] Error 1
make[1]: Leaving directory `/home/alo/sw/alsa/alsa-driver-1.0.2c/acore'
make: *** [compile] Error 1
rm -f /lib/modules/2.4.22/misc/snd*.*o /lib/modules/2.4.22/misc/persist.o
/lib/modules/2.4.22/misc/isapnp.o
make[1]: Entering directory `/home/alo/sw/alsa/alsa-driver-1.0.2c/acore'
mkdir -p /lib/modules/2.4.22/misc
cp snd-page-alloc.o snd-pcm.o snd-rawmidi.o snd-timer.o snd.o
/lib/modules/2.4.22/misc
cp: no se puede efectuar `stat' sobre `snd-page-alloc.o': No such file or
directory
cp: no se puede efectuar `stat' sobre `snd-pcm.o': No such file or
directory
cp: no se puede efectuar `stat' sobre `snd-rawmidi.o': No such file or
directory
cp: no se puede efectuar `stat' sobre `snd-timer.o': No such file or
directory
cp: no se puede efectuar `stat' sobre `snd.o': No such file or directory
make[1]: *** [_modinst__] Error 1
make[1]: Leaving directory `/home/alo/sw/alsa/alsa-driver-1.0.2c/acore'
make: *** [install-modules] Error 1

======================================================================

----------------------------------------------------------------------
 tiwai - 02-12-2004 14:11 CET 
----------------------------------------------------------------------
looks like you're using the kernel tree for 32bit mode with
64bit system.

----------------------------------------------------------------------
 tiwai - 02-12-2004 14:13 CET 
----------------------------------------------------------------------
sorry, not kernel tree but gcc.

----------------------------------------------------------------------
 alo - 02-12-2004 19:14 CET 
----------------------------------------------------------------------
Could you please explain a little bit more?I don't understand your
comments, I installed standard Mandrake 9.2, didn't compile the kernel or
anything like that

I would appreciatte a lot if you could give me some directions to fix the
issue and compile the driver

Thanks in advance

----------------------------------------------------------------------
 tiwai - 02-13-2004 11:04 CET 
----------------------------------------------------------------------
see the error message

  cc1: error: code model `kernel' not supported in the 32 bit mode

so, it looks like you're calling the wrong gcc.

first check whether you can build the kernel with your system.
if it's ok, the bug stays in alsa-driver's Makefile or configure
script.

----------------------------------------------------------------------
 perex - 03-09-2004 18:46 CET 
----------------------------------------------------------------------
No response from user.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-11-04 10:46 alo            New Bug                                      
02-12-04 14:11 tiwai          Bugnote Added: 0000223                       
02-12-04 14:13 tiwai          Bugnote Added: 0000224                       
02-12-04 19:14 alo            Bugnote Added: 0000231                       
02-12-04 19:57 perex          Assigned To              perex => tiwai      
02-13-04 11:04 tiwai          Bugnote Added: 0000236                       
03-09-04 18:46 perex          Bugnote Added: 0000554                       
03-09-04 18:46 perex          Assigned To              tiwai => perex      
03-09-04 18:46 perex          Resolution               open => suspended   
03-09-04 18:46 perex          Status                   assigned => resolved
07-16-04 13:07 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
