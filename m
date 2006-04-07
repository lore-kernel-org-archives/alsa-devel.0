From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Trying again with cross compile
Date: Fri, 07 Apr 2006 13:33:54 +0100
Message-ID: <1144413234.9653.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've downloaded the cvs alsa-driver.
I've added an sh directory -

adrian@bossclass:~/alsa-driver/sh$ ls -l
total 32
-rw-r--r--  1 adrian adrian  2156 2006-04-07 12:34 aica.h
-rw-r--r--  1 adrian adrian   356 2006-04-07 12:34 Kconfig
-rw-r--r--  1 adrian adrian    65 2006-04-07 12:34 Makefile
-rw-r--r--  1 adrian adrian 18262 2006-04-07 12:34 snd_aica.c

and then I run cvscompile (as configured below) and get this... what do
I do next?

Especially as, when I run make it bombs out:

make[1]: Leaving directory `/home/adrian/alsa-driver'
make -C /lib/modules/2.6.12-10-686/build
SUBDIRS=/home/adrian/alsa-driver  modules
/usr/src/linux-headers-2.6.12-10-686/scripts/gcc-version.sh: line 11:
gcc-3.4: command not found
/usr/src/linux-headers-2.6.12-10-686/scripts/gcc-version.sh: line 12:
gcc-3.4: command not found
make[1]: gcc-3.4: Command not found
make[1]: Entering directory `/usr/src/linux-headers-2.6.12-10-686'
  CC [M]  /home/adrian/alsa-driver/acore/hwdep.o
/bin/sh: gcc-3.4: command not found
make[3]: *** [/home/adrian/alsa-driver/acore/hwdep.o] Error 127
make[2]: *** [/home/adrian/alsa-driver/acore] Error 2
make[1]: *** [_module_/home/adrian/alsa-driver] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.12-10-686'
make: *** [compile] Error 2

I don't know why it is looking for gcc-3.4, and particularly why it's
getting that from something on the build machine when this is meant to
be a cross compile




adrian@bossclass:~/alsa-driver$ ./cvscompile
--with-cross=/home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-
--with-build=/home/adrian/linux-2.6.15.2 --with-cards=snd-aica
--with-kernel=/home/adrian/linux-2.6.15.2
make: Nothing to be done for `all-deps'.
./configure
--with-cross=/home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-
--with-build=/home/adrian/linux-2.6.15.2 --with-cards=snd-aica
--with-kernel=/home/adrian/linux-2.6.15.2
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
checking for current directory... /home/adrian/alsa-driver
checking cross
compile... /home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-
checking for directory with kernel source... /home/adrian/linux-2.6.15.2
checking for directory with kernel build... /home/adrian/linux-2.6.15.2
checking for kernel linux/version.h... yes
checking for kernel linux/autoconf.h... yes
checking for kernel version... 2.6.15-sh
checking for GCC version... Kernel compiler: gcc 3.4.2 Used compiler:
sh4-linux-gcc (GCC) 3.4.2
checking for built-in ALSA... no
checking for existing ALSA module... yes
checking for Red Hat kernel... auto
checking for Red Hat kernel... no
checking for SUSE kernel... auto
checking for SUSE kernel... no
checking to modify of kernel linux/kmod.h... no
checking for kernel linux/compiler.h... yes
checking for kernel linux/pm.h... yes
checking for kernel linux/spinlock.h... yes
checking for kernel linux/irq.h... yes
checking for kernel linux/threads.h... yes
checking for kernel linux/rwsem.h... yes
checking for kernel linux/gameport.h... yes
checking for kernel linux/devfs_fs_kernel.h... yes
checking for kernel linux/highmem.h... yes
checking for kernel linux/workqueue.h... yes
checking for kernel linux/dma-mapping.h... yes
checking for kernel asm/hw_irq.h... yes
checking for kernel linux/device.h... yes
checking for kernel linux/platform_device.h... yes
checking for kernel linux/jiffies.h... yes
checking for kernel linux/compat.h... yes
checking for kernel linux/adb.h... yes
checking for kernel linux/cuda.h... yes
checking for kernel linux/pmu.h... yes
checking for kernel linux/moduleparam.h... yes
checking for kernel linux/syscalls.h... yes
checking for kernel linux/firmware.h... yes
checking for kernel linux/err.h... yes
checking for kernel linux/bitmap.h... yes
checking for kernel linux/mutex.h... no
Creating <linux/mutex.h>...
checking for kernel module symbol versions... no
checking for PCI support in kernel... yes
checking for I2C driver in kernel... unknown
checking for firmware loader... yes
checking for input subsystem in kernel... yes
checking for directory to store kernel
modules... /lib/modules/2.6.15-sh/kernel/sound
checking for verbose procfs... on
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... no
checking for processor type... unknown
checking for ISA DMA API... no
checking for SMP... no
checking for Video device support in kernel... no
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... no
checking for Kernel ISA-PnP module support... no
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
checking for io_remap_pfn_range... yes
checking for kcalloc... yes
checking for kstrdup... yes
checking for kzalloc... yes
checking for create_workqueue with flags... no
checking for saved_config_space in pci_dev... yes
checking for new pci_save_state... yes
checking for register_sound_special_device... yes
checking for driver version... 1.0.11rc4
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for OSS PCM plugin system inclusion... yes
checking for RTC callback support in kernel... yes
checking for HPET support... no
checking for dynamic minor numbers... no
checking for support of old API... yes
checking for Procfs support... yes
checking for USB support... no
checking for USB module support... no
checking for class_simple... no
checking for old driver suspend/resume callbacks... no
checking for removal of page-reservation for nopage/mmap... yes
checking for nested class_device... yes
checking for PnP suspend/resume... no
checking for new unlocked/compat_ioctl... yes
checking for PC-Speaker hook... no
checking for kernel PCMCIA
checking for PCMCIA support... no
checking for PCMCIA module support... no
checking for PC9800 support in kernel... no
checking for parallel port support... no
checking for parallel port module support... no
checking for which soundcards to compile driver for... configure: error:
Unknown soundcard snd-aica
adrian@bossclass:~/alsa-driver$





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
