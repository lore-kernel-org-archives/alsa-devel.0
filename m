From: Susan Cragin <susancragin@earthlink.net>
Subject: 07-Apr snapshot does not compile
Date: Tue, 7 Apr 2009 06:59:20 -0400 (GMT-04:00)
Message-ID: <25350116.1239101961069.JavaMail.root@elwamui-little.atl.sa.earthlink.net>
Reply-To: Susan Cragin <susancragin@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-curtail.atl.sa.earthlink.net
	(elasmtp-curtail.atl.sa.earthlink.net [209.86.89.64])
	by alsa0.perex.cz (Postfix) with ESMTP id ABAF02450B
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 12:59:22 +0200 (CEST)
Received: from [209.86.224.39] (helo=elwamui-little.atl.sa.earthlink.net)
	by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <susancragin@earthlink.net>) id 1Lr91V-0008E8-3N
	for alsa-devel@alsa-project.org; Tue, 07 Apr 2009 06:59:21 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is FYI only. I assume the problem is either (1) already known or (2) my fault.
Susan


susan@ubuntu:~/Desktop/alsa-driver-unstable$ ./configure && make
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables... 
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking for ranlib... ranlib
checking for a BSD-compatible install... /usr/bin/install -c
checking how to run the C preprocessor... gcc -E
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for ANSI C header files... yes
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking whether time.h and sys/time.h may both be included... yes
checking whether gcc needs -traditional... no
checking for current directory... /home/susan/Desktop/alsa-driver-unstable
checking cross compile... 
checking for directory with kernel source... /lib/modules/2.6.28-11-generic/build
checking for directory with kernel build... 
checking for kernel linux/version.h... yes
checking for kernel linux/autoconf.h... yes
checking for kernel version... 2.6.28-11-generic
checking for GCC version... ./configure: eval: line 5216: syntax error near unexpected token `)'
./configure: eval: line 5216: `my_compiler_version=4.3.3-5ubuntu4)'
Kernel compiler:  Used compiler: gcc (Ubuntu 4.3.3-5ubuntu4) 4.3.3

*** NO PREDEFINED KERNEL COMPILER IS DETECTED
*** Assuming the same compiler is used with the current system compiler.

*** Please make sure that the same compiler version was used for building kernel.

checking for built-in ALSA... no
checking for existing ALSA module... yes
checking for Red Hat kernel... auto
checking for Red Hat kernel... no
checking for SUSE kernel... auto
checking for SUSE kernel... no
checking for updating alsa-kernel version.h... yes
checking for CONFIG_EXPERIMENTAL... yes
checking for directory to store kernel modules... /lib/modules/2.6.28-11-generic/kernel/sound
checking for verbose procfs... on
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... yes
checking for processor type... i586
checking for i386 machine type... default
checking for ISA DMA API... yes
checking for kernel linux/config.h... no
Creating <linux/config.h>...
checking for deprecated linux/config.h... checking to modify of kernel linux/kmod.h... no
checking for kernel linux/utsrelease.h... yes
checking for kernel linux/compiler.h... yes
checking for kernel linux/pm.h... yes
checking for kernel linux/spinlock.h... yes
checking for kernel linux/irq.h... yes
checking for kernel linux/threads.h... yes
checking for kernel linux/rwsem.h... yes
checking for kernel linux/gameport.h... yes
checking for kernel media/v4l2-dev.h... yes
checking for kernel linux/devfs_fs_kernel.h... no
Creating a dummy <linux/devfs_fs_kernel.h>...
checking for kernel linux/highmem.h... yes
checking for kernel linux/workqueue.h... yes
checking for kernel linux/dma-mapping.h... yes
checking for kernel asm/hw_irq.h... yes
checking for kernel linux/device.h... yes
checking for kernel linux/platform_device.h... yes
checking for kernel linux/isa.h... yes
checking for kernel linux/jiffies.h... yes
checking for kernel linux/compat.h... yes
checking for kernel linux/log2.h... yes
checking for kernel linux/adb.h... yes
checking for kernel linux/cuda.h... yes
checking for kernel linux/pmu.h... yes
checking for kernel linux/io.h... yes
checking for kernel linux/moduleparam.h... yes
checking for kernel linux/syscalls.h... yes
checking for kernel linux/firmware.h... yes
checking for kernel linux/err.h... yes
checking for kernel linux/bitmap.h... yes
checking for kernel linux/mutex.h... yes
checking for kernel linux/pm_qos_params.h... yes
checking for kernel linux/kthread.h... yes
checking for kernel asm/irq_regs.h... yes
checking for kernel linux/seq_file.h... yes
checking for kernel linux/debugfs.h... yes
checking for kernel linux/gpio.h... yes
checking for kernel module symbol versions... yes
checking for has ioport support... yes
checking for PCI support in kernel... yes
checking for I2C driver in kernel... yes
checking for I2C_POWERMAC in kernel... unknown
checking for firmware loader... yes
checking for input subsystem in kernel... yes
checking for pc-speaker platform in kernel... yes
checking for SMP... yes
checking for Video device support in kernel... yes
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... yes
checking for strlcpy... yes
checking for snprintf... yes
checking for vsnprintf... yes
checking for scnprintf... yes
checking for sscanf... yes
checking for vmalloc_to_page... yes
checking for old kmod... no
checking for PDE... yes
checking for pci_set_consistent_dma_mask... yes
checking for pci_dev_present... yes
checking for msleep... yes
checking for msleep_interrupt... yes
checking for msecs_to_jiffies... yes
checking for tty->count is the atomic type... no
checking for video_get_drvdata... yes
checking for video_drvdata... yes
checking for V4L1 layer... yes
checking for io_remap_pfn_range... yes
checking for kcalloc... yes
checking for kstrdup... yes
checking for kstrndup... yes
checking for kzalloc... yes
checking for create_workqueue with flags... no
checking for pci_ioremap_bar... yes
checking for saved_config_space in pci_dev... yes
checking for new pci_save_state... yes
checking for register_sound_special_device... yes
checking for driver extra-version... 
checking for driver version... 1.0.19
checking for dynamic minor numbers... no
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for OSS PCM plugin system inclusion... yes
checking for RTC support... no
checking for HPET support... yes
checking for Procfs support... yes
checking for USB support... yes
checking for class_simple... no
checking for old driver suspend/resume callbacks... no
checking for removal of page-reservation for nopage/mmap... no
checking for nested class_device... no
checking for new IRQ handler... yes
checking for gfp_t... yes
checking for GFP_DMA32... yes
checking for page_to_pfn... yes
checking for PnP suspend/resume... yes
checking for device_create_drvdata... no
checking for new unlocked/compat_ioctl... yes
checking for builtin _Bool support... yes
checking for x86-compatible PC... yes
checking for High-Res timers... yes
checking for kernel PCMCIA
checking for PCMCIA support... yes
checking for PC9800 support in kernel... no
checking for parallel port support... yes
checking for power management... yes
checking for CONFIG_HAS_DMA... yes
checking for cards to compile driver for... all
checking for additonal options to compile driver for... all
configure: creating ./config.status
config.status: creating version
config.status: creating Makefile.conf
config.status: WARNING:  'Makefile.conf.in' seems to ignore the --datarootdir setting
config.status: creating snddevices
config.status: creating utils/alsa-driver.spec
config.status: creating utils/buildrpm
config.status: creating toplevel.config
config.status: creating utils/alsasound
config.status: creating utils/alsasound.posix
config.status: creating include/pci_ids_compat.h
config.status: creating include/i2c-id_compat.h
config.status: creating include/config.h
config.status: include/config.h is unchanged
config.status: creating include/config1.h
config.status: include/config1.h is unchanged
config.status: creating include/version.h
config.status: include/version.h is unchanged
config.status: creating include/autoconf-extra.h
config.status: include/autoconf-extra.h is unchanged
Hacking autoconf.h...
make dep
make[1]: Entering directory `/home/susan/Desktop/alsa-driver-unstable'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver-unstable/acore'
copying file alsa-kernel/core/info.c
patching file info.c
Hunk #2 FAILED at 155.
Hunk #3 succeeded at 162 (offset -5 lines).
Hunk #4 succeeded at 172 (offset -5 lines).
Hunk #5 succeeded at 203 (offset -5 lines).
Hunk #6 succeeded at 490 (offset -5 lines).
Hunk #7 FAILED at 530.
Hunk #8 FAILED at 994.
Hunk #9 succeeded at 1018 (offset -10 lines).
3 out of 9 hunks FAILED -- saving rejects to file info.c.rej
make[2]: *** [info.c] Error 1
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver-unstable/acore'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/home/susan/Desktop/alsa-driver-unstable'
make: *** [include/sndversions.h] Error 2
