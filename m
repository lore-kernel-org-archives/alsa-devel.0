From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000687]: Cannot build gentoo-ebuild for 1.0.7
Date: Mon, 29 Nov 2004 17:20:32 +0100
Message-ID: <9ce66454653fb34321eac92c833449d6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1FD872A1
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 17:20:33 +0100 (MET)
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
Last Modified:              11-29-2004 17:20 CET
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
 m_wright - 11-29-04 16:41 
----------------------------------------------------------------------
This is the output of configure from the ebuild, any help??

Matt

./configure --prefix=/usr --host=i686-pc-linux-gnu --mandir=/usr/share/man
--inf odir=/usr/share/info --datadir=/usr/share --sysconfdir=/etc
--localstatedir=/var /lib --with-oss --with-kernel=/usr/src/linux
--with-build= --with-isapnp=yes --w ith-sequencer=yes
--with-cards=emu10k1
configure: WARNING: If you wanted to set the --build type, don't use
--host.
    If a cross compiler is detected then cross compile mode will be used.
checking for i686-pc-linux-gnu-gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking for i686-pc-linux-gnu-ranlib... no
checking for ranlib... ranlib
checking for a BSD-compatible install... /bin/install -c
checking how to run the C preprocessor... gcc -E
checking for egrep... grep -E
checking for ANSI C header files... yes
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking whether time.h and sys/time.h may both be included... yes
checking whether gcc needs -traditional... no
checking for current directory...
/var/tmp/portage/alsa-driver-1.0.7-r1/work/alsa-driver-1.0.7
checking cross compile...
checking for directory with kernel source... /usr/src/linux
checking for directory with kernel build...
checking for kernel version... 2.6.9-ck2
checking for GCC version... Kernel compiler: gcc 3.3.3 20040412 (Gentoo
Linux 3.3.3-r6, ssp-3.3.2-2, pi e-8.7.6) Used compiler: gcc (GCC) 3.3.3
20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)
checking for built-in ALSA... "no"
checking for existing ALSA module... "no"
checking for Red Hat kernel... "auto"
checking for Red Hat kernel... "no"
checking for SUSE kernel... "auto"
checking for SUSE kernel... "no"
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
checking for kernel linux/workqueue.h... "yes"
Removing a dummy linux/workqueue.h.
checking for kernel linux/dma-mapping.h... "yes"
Removing a dummy linux/dma-mapping.h.
checking for kernel asm/hw_irq.h... "yes"
checking for kernel linux/device.h... "yes"
Removing a dummy linux/device.h.
checking for kernel linux/jiffies.h... "yes"
Removing a dummy linux/jiffies.h.
checking for kernel linux/compat.h... "yes"
Removing a dummy linux/compat.h.
checking for kernel linux/adb.h... "yes"
checking for kernel linux/cuda.h... "yes"
checking for kernel linux/pmu.h... "yes"
checking for kernel linux/moduleparam.h... "yes"
Removing a dummy linux/moduleparam.h.
checking for kernel linux/syscalls.h... "yes"
Removing a dummy linux/syscalls.h.
checking for kernel module symbol versions... "no"
checking for PCI support in kernel... "yes"
checking for I2C driver in kernel... module
checking for input subsystem in kernel... yes
checking for SGI/MIPS (HAL2) architecture... "no"
checking for directory to store kernel modules...
/lib/modules/2.6.9-ck2/kernel/sound
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... "yes"
checking for SMP... "yes"
checking for Video device support in kernel... "no"
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... "no"
checking for Kernel ISA-PnP module support... "no"
checking for strlcpy... "yes"
checking for snprintf... "yes"
checking for scnprintf... "yes"
checking for sscanf... "yes"
checking for vmalloc_to_page... "no"
checking for old kmod... "no"
checking for PDE... "no"
checking for pci_set_consistent_dma_mask... "no"
checking for tty->count is the atomic type... "no"
checking for remap_pfn_range... "no"
checking for new remap_page_range... "no"
checking for kcalloc... "no"
checking for saved_config_space in pci_dev... "no"
checking for acpi_register_gsi... "no"
Removing local linux/pnp.h.
checking for driver version... 1.0.7
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... "yes"
checking for Procfs support... "yes"
checking for USB support... "yes"
checking for kernel PCMCIA
checking for PCMCIA support... "no"
checking for PCMCIA module support... "no"
checking for PC9800 support in kernel... "no"
checking for parallel port support... "no"
checking for parallel port module support... "no"
checking for processor type... i686
checking for i386 machine type... default
checking for which soundcards to compile driver for... emu10k1
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
config.status: creating include/config1.h
config.status: creating include/version.h
config.status: include/version.h is unchanged
config.status: creating include/autoconf-extra.h

----------------------------------------------------------------------
 tiwai - 11-29-04 17:20 
----------------------------------------------------------------------
Apparently the configure couldn't detect vmalloc_to_page().
Do you have config.log for this check?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 19:06 m_wright       New Issue                                    
11-28-04 19:06 m_wright       Distribution              => Gentoo Linux    
11-28-04 19:06 m_wright       Kernel Version            => 2.6.9-ck2       
11-29-04 15:27 tiwai          Note Added: 0002638                          
11-29-04 16:41 m_wright       Note Added: 0002653                          
11-29-04 17:20 tiwai          Note Added: 0002655                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
