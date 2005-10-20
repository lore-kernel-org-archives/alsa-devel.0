From: "Guillaume GOURAT" <guillaume.forum@free.fr>
Subject: Problem compiling alsa-driver-1.0.10rc2 for arm.
Date: Thu, 20 Oct 2005 16:06:30 +0200
Message-ID: <200510201606656.SM01852@STATIONXP>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
Cc: linux-arm@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Hi,

I have a problem when compiling alsa-driver-1.0.10rc2 (or
alsa-driver-1.0.9b) with linux kernel 2.6.14-rc4 (or linux 2.6.11.4) :
(alsa-driver-1.0.9rc2 compile fine with linux 2.6.11.4 but not with linux
2.6.14-rc4 because class_simple_device_add symbol was removed)

With alsa-driver-1.0.10rc2 :

/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.i
nc:49: error: `snd_pci_dev_present' undeclared here (not in a function)
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.i
nc:49: error: initializer element is not constant
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.i
nc:49: error: (near initialization for
`__ksymtab_snd_pci_dev_present.value')
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.i
nc:49: error: __ksymtab_snd_pci_dev_present causes a section type conflict

With alsa-driver-1.0.9b :

  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/.s
ound.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/include -Wall
-Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-ffreestanding -Os -fno-omit-frame-pointer -fno-optimize-sibling-calls
-fno-omit-frame-pointer -mapcs -mno-sched-prolog -mapcs-32
-mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4 -mtune=arm9tdmi
-malignment-traps -msoft-float -Uarm -Wdeclaration-after-statement
-DALSA_BUILD -DMODULE -DKBUILD_BASENAME=sound -DKBUILD_MODNAME=snd -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c
In file included from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:51
6:
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.inc:
39: error: `snd_pci_dev_present' undeclared here (not in a function)
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.inc:
39: error: initializer element is not constant
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.inc:
39: error: (near initialization for `__ksymtab_snd_pci_dev_present.value')
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:51
3: error: __ksymtab_snd_wrapper_vfree causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:51
2: error: __ksymtab_snd_wrapper_vmalloc causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:51
1: error: __ksymtab_snd_wrapper_kfree causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:51
0: error: __ksymtab_snd_wrapper_kmalloc causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:50
6: error: __ksymtab_snd_verbose_printd causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:50
3: error: __ksymtab_snd_verbose_printk causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:50
1: error: __ksymtab_snd_task_name causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:49
9: error: __ksymtab_snd_ctl_elem_write causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:49
8: error: __ksymtab_snd_ctl_elem_read causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:49
3: error: __ksymtab_snd_ctl_unregister_ioctl causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:49
2: error: __ksymtab_snd_ctl_register_ioctl causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:49
1: error: __ksymtab_snd_ctl_notify causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:49
0: error: __ksymtab_snd_ctl_find_id causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:48
9: error: __ksymtab_snd_ctl_find_numid causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:48
8: error: __ksymtab_snd_ctl_rename_id causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:48
7: error: __ksymtab_snd_ctl_remove_id causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:48
6: error: __ksymtab_snd_ctl_remove causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:48
5: error: __ksymtab_snd_ctl_add causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:48
4: error: __ksymtab_snd_ctl_free_one causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:48
3: error: __ksymtab_snd_ctl_new1 causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:48
2: error: __ksymtab_snd_ctl_new causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:47
9: error: __ksymtab_snd_oss_info_register causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:47
5: error: __ksymtab_snd_card_proc_new causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:47
4: error: __ksymtab_snd_info_unregister causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:47
3: error: __ksymtab_snd_info_register causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:47
2: error: __ksymtab_snd_info_free_entry causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:47
1: error: __ksymtab_snd_info_create_card_entry causes a section type
conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:47
0: error: __ksymtab_snd_info_create_module_entry causes a section type
conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:46
9: error: __ksymtab_snd_info_get_str causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:46
8: error: __ksymtab_snd_info_get_line causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:46
7: error: __ksymtab_snd_iprintf causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:46
6: error: __ksymtab_snd_seq_root causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:45
7: error: __ksymtab_snd_device_free causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:45
6: error: __ksymtab_snd_device_register causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:45
5: error: __ksymtab_snd_device_new causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:44
2: error: __ksymtab_snd_card_file_remove causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:44
1: error: __ksymtab_snd_card_file_add causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:44
0: error: __ksymtab_snd_component_add causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:43
9: error: __ksymtab_snd_card_register causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:43
8: error: __ksymtab_snd_card_free_in_thread causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:43
7: error: __ksymtab_snd_card_free causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:43
6: error: __ksymtab_snd_card_disconnect causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:43
5: error: __ksymtab_snd_card_new causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:43
3: error: __ksymtab_snd_mixer_oss_notify_callback causes a section type
conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:43
1: error: __ksymtab_snd_cards causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:42
9: error: __ksymtab_copy_from_user_toio causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:42
8: error: __ksymtab_copy_to_user_fromio causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:42
7: error: __ksymtab_snd_kmalloc_strdup causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:42
5: error: __ksymtab_snd_hidden_vfree causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:42
4: error: __ksymtab_snd_hidden_vmalloc causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:42
3: error: __ksymtab_snd_hidden_kfree causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:42
2: error: __ksymtab_snd_hidden_kcalloc causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:42
1: error: __ksymtab_snd_hidden_kmalloc causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:41
7: error: __ksymtab_snd_unregister_oss_device causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:41
6: error: __ksymtab_snd_register_oss_device causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:41
4: error: __ksymtab_snd_unregister_device causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:41
3: error: __ksymtab_snd_register_device causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:40
9: error: __ksymtab_snd_ecards_limit causes a section type conflict
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.c:40
8: error: __ksymtab_snd_major causes a section type conflict
make[5]: ***
[/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.9b/acore/sound.o]
Error 1




Do you have any idea of this problem cause ?

Regards,

Guillaume GOURAT.




Full build output :

cd /public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2 &&
./configure  --prefix= --with-cross=arm-unknown-linux-gnu-
--with-kernel="/public/src/linux-2.6.14-rc4-nx1"
--with-build="/public/src/linux-2.6.14-rc4-nx1"
--with-moddir=/lib/modules/2.6.14-rc4-nx1/kernel/drivers/sound
--with-debug=full --with-isapnp=no --with-sequencer=no --with-oss=yes
--with-cards=s3c2410
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
checking for current directory...
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2
checking cross compile... arm-unknown-linux-gnu-
checking for directory with kernel source...
/public/src/linux-2.6.14-rc4-nx1
checking for directory with kernel build... /public/src/linux-2.6.14-rc4-nx1
checking for kernel linux/version.h... yes
checking for kernel linux/autoconf.h... yes
checking for kernel version... 2.6.14-rc4-nx1
checking for GCC version... Kernel compiler: gcc 3.4.2 Used compiler:
arm-unknown-linux-gnu-gcc (GCC) 3.4.2
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
checking for kernel asm/hw_irq.h... "no"
Creating a dummy <asm/hw_irq.h>...
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
checking for kernel linux/firmware.h... "yes"
checking for kernel module symbol versions... "no"
checking for PCI support in kernel... "no"
checking for I2C driver in kernel... yes
checking for firmware loader... unknown
checking for input subsystem in kernel... yes
checking for directory to store kernel modules...
/lib/modules/2.6.14-rc4-nx1/kernel/drivers/sound
checking for verbose printk... on
checking for debug level... full
checking for ISA support in kernel... "no"
checking for processor type... s3c2410
checking for ISA DMA API... "yes"
checking for SMP... "no"
checking for Video device support in kernel... "yes"
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... "no"
checking for Kernel ISA-PnP module support... "no"
checking for strlcpy... "yes"
checking for snprintf... "yes"
checking for vsnprintf... "yes"
checking for scnprintf... "yes"
checking for sscanf... "yes"
checking for vmalloc_to_page... "yes"
checking for old kmod... "no"
checking for PDE... "yes"
checking for pci_set_consistent_dma_mask... "no"
checking for pci_dev_present... "no"
checking for msleep... "yes"
checking for msleep_interrupt... "yes"
checking for msecs_to_jiffies... "yes"
checking for tty->count is the atomic type... "no"
checking for video_get_drvdata... "yes"
checking for io_remap_pfn_range... "yes"
checking for kcalloc... "yes"
checking for kstrdup... "yes"
checking for kzalloc... "yes"
checking for create_workqueue with flags... "no"
checking for saved_config_space in pci_dev... "yes"
checking for new pci_save_state... "yes"
checking for register_sound_special_device... "yes"
Removing local linux/pnp.h.
checking for driver version... 1.0.10rc2
checking for sequencer support... no
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... "no"
checking for HPET support... "no"
checking for Procfs support... "yes"
checking for USB support... "yes"
checking for class_simple... "no"
checking for new unlocked/compat_ioctl... "yes"
checking for PC-Speaker hook... "no"
checking for kernel PCMCIA
checking for PCMCIA support... "no"
checking for PCMCIA module support... "no"
checking for PC9800 support in kernel... "no"
checking for parallel port support... "no"
checking for parallel port module support... "no"
checking for which soundcards to compile driver for... s3c2410
configure: creating ./config.status
config.status: creating version
config.status: creating Makefile.conf
config.status: creating snddevices
config.status: creating utils/alsa-driver.spec
config.status: creating utils/buildrpm
config.status: creating toplevel.config
config.status: creating utils/alsasound
config.status: creating utils/alsasound.posix
config.status: creating include/linux/pci_ids.h
config.status: creating include/config.h
config.status: creating include/config1.h
config.status: creating include/version.h
config.status: include/version.h is unchanged
config.status: creating include/autoconf-extra.h

cd /public/projects/mkembsys/build/nexcoder/alsa-driver-"1.0.10rc2" && make
make[1]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2'
if [ ! -d include/sound -a ! -L include/sound ]; then \
  ln -sf ../alsa-kernel/include include/sound ; \
fi
cp -auvf include/version.h include/sound/version.h
`include/version.h' -> `include/sound/version.h'
make dep
make[2]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2'
make[3]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore'
copying file alsa-kernel/core/info.c
patching file info.c
Hunk #9 succeeded at 932 (offset -3 lines).
Hunk #10 succeeded at 983 (offset 1 line).
copying file alsa-kernel/core/pcm_native.c
patching file pcm_native.c
Hunk #2 succeeded at 340 (offset 2 lines).
Hunk #3 succeeded at 2754 (offset 1 line).
Hunk #4 succeeded at 2775 (offset 2 lines).
Hunk #5 succeeded at 2827 (offset 1 line).
Hunk #6 succeeded at 2855 (offset 2 lines).
Hunk #7 succeeded at 2945 (offset 1 line).
Hunk #8 succeeded at 2965 (offset 2 lines).
Hunk #9 succeeded at 2982 (offset 1 line).
Hunk #10 succeeded at 3012 (offset 2 lines).
Hunk #11 succeeded at 3043 (offset 1 line).
Hunk #12 succeeded at 3073 (offset 2 lines).
Hunk #13 succeeded at 3101 (offset 1 line).
Hunk #14 succeeded at 3120 (offset 2 lines).
Hunk #15 succeeded at 3139 (offset 1 line).
Hunk #16 succeeded at 3156 (offset 2 lines).
Hunk #17 succeeded at 3166 (offset 1 line).
Hunk #18 succeeded at 3198 (offset 2 lines).
Hunk #19 succeeded at 3261 (offset 1 line).
Hunk #20 succeeded at 3289 (offset 2 lines).
Hunk #21 succeeded at 3329 (offset 1 line).
Hunk #22 succeeded at 3473 (offset 2 lines).
copying file alsa-kernel/core/control.c
patching file control.c
Hunk #2 succeeded at 1259 (offset 3 lines).
copying file alsa-kernel/core/hwdep.c
patching file hwdep.c
copying file alsa-kernel/core/init.c
patching file init.c
Hunk #3 succeeded at 666 (offset 1 line).
Hunk #5 succeeded at 839 (offset 1 line).
Hunk #7 succeeded at 978 (offset 1 line).
copying file alsa-kernel/core/rawmidi.c
patching file rawmidi.c
Hunk #1 succeeded at 1278 (offset 11 lines).
copying file alsa-kernel/core/sound.c
patching file sound.c
copying file alsa-kernel/core/timer.c
patching file timer.c
Hunk #1 succeeded at 997 (offset 2 lines).
Hunk #2 succeeded at 1844 (offset 53 lines).
Hunk #3 succeeded at 1847 (offset 2 lines).
copying file alsa-kernel/core/memalloc.c
patching file memalloc.c
Hunk #6 succeeded at 704 (offset 1 line).
copying file alsa-kernel/core/misc.c
patching file misc.c
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/ioctl3
2'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/ioctl3
2'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/oss'
copying file alsa-kernel/core/oss/mixer_oss.c
patching file mixer_oss.c
Hunk #1 succeeded at 378 (offset 1 line).
copying file alsa-kernel/core/oss/pcm_oss.c
patching file pcm_oss.c
Hunk #1 succeeded at 2104 (offset 32 lines).
Hunk #3 succeeded at 2450 (offset 34 lines).
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/oss'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/seq'
copying file alsa-kernel/core/seq/seq.c
patching file seq.c
Hunk #1 succeeded at 57 (offset 6 lines).
copying file alsa-kernel/core/seq/seq_clientmgr.c
patching file seq_clientmgr.c
Hunk #2 succeeded at 2144 (offset 3 lines).
copying file alsa-kernel/core/seq/seq_memory.c
patching file seq_memory.c
make[5]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/seq/in
str'
make[5]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/seq/in
str'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/seq'
make[3]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore'
make[3]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/i2c'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/i2c/other'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/i2c/other'
make[3]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/i2c'
make[3]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers/mpu4
01'
copying file alsa-kernel/drivers/mpu401/mpu401.c
patching file mpu401.c
Hunk #3 succeeded at 62 with fuzz 1.
Hunk #4 succeeded at 89 with fuzz 2 (offset -58 lines).
Hunk #5 succeeded at 305 (offset 58 lines).
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers/mpu4
01'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers/opl3
'
copying file alsa-kernel/drivers/opl3/opl3_lib.c
patching file opl3_lib.c
Hunk #1 succeeded at 427 (offset -6 lines).
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers/opl3
'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers/opl4
'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers/opl4
'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers/pcsp
'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers/pcsp
'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers/vx'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers/vx'
make[3]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/drivers'
make[3]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/ad1816a'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/ad1816a'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/ad1848'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/ad1848'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/cs423x'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/cs423x'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/es1688'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/es1688'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/gus'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/gus'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/msnd'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/msnd'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/opti9xx'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/opti9xx'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/sb'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/sb'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/wavefron
t'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa/wavefron
t'
make[3]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/isa'
make[3]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/synth'
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/synth/emux'
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/synth/emux'
make[3]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/synth'
make[3]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/arm'
make[3]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/arm'
make[3]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/usb'
copying file alsa-kernel/usb/usbaudio.c
patching file usbaudio.c
copying file alsa-kernel/usb/usbmidi.c
patching file usbmidi.c
copying file alsa-kernel/usb/usbmixer.c
patching file usbmixer.c
Hunk #2 succeeded at 1648 (offset -1 lines).
Hunk #4 succeeded at 1718 (offset -1 lines).
make[4]: Entering directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/usb/usx2y'
copying file alsa-kernel/usb/usx2y/usX2Yhwdep.c
patching file usX2Yhwdep.c
copying file alsa-kernel/usb/usx2y/usbusx2y.c
patching file usbusx2y.c
copying file alsa-kernel/usb/usx2y/usbusx2yaudio.c
patching file usbusx2yaudio.c
Hunk #5 succeeded at 665 (offset -2 lines).
copying file alsa-kernel/usb/usx2y/usx2yhwdeppcm.c
patching file usx2yhwdeppcm.c
Hunk #2 succeeded at 159 (offset 1 line).
Hunk #4 succeeded at 311 (offset 1 line).
Hunk #6 succeeded at 707 (offset -2 lines).
make[4]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/usb/usx2y'
make[3]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/usb'
make[2]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2'
make -C /public/src/linux-2.6.14-rc4-nx1
SUBDIRS=/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2
O=/public/src/linux-2.6.14-rc4-nx1 modules
make[2]: Entering directory `/public/src/linux-2.6.14-rc4-nx1'
make -C /public/src/linux-2.6.14-rc4-nx1 \
KBUILD_SRC=/public/src/linux-2.6.14-rc4-nx1 \
KBUILD_EXTMOD="/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc
2" -f /public/src/linux-2.6.14-rc4-nx1/Makefile modules
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = (unset),
        LC_ALL = (unset),
        LANG = "fr"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
mkdir -p
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/.tmp_versions
make -f /public/src/linux-2.6.14-rc4-nx1/scripts/Makefile.build
obj=/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2
make -f /public/src/linux-2.6.14-rc4-nx1/scripts/Makefile.build
obj=/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
/.memalloc.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-omit-frame-pointer -mapcs -mno-sched-prolog
-mapcs-32 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4
-mtune=arm9tdmi -malignment-traps -msoft-float -Uarm
-Wdeclaration-after-statement -DALSA_BUILD -DMODULE
-DKBUILD_BASENAME=memalloc -DKBUILD_MODNAME=snd_page_alloc -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/memallo
c.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/memallo
c.c
  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
/.sgbuf.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-omit-frame-pointer -mapcs -mno-sched-prolog
-mapcs-32 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4
-mtune=arm9tdmi -malignment-traps -msoft-float -Uarm
-Wdeclaration-after-statement -DALSA_BUILD -DMODULE -DKBUILD_BASENAME=sgbuf
-DKBUILD_MODNAME=snd_page_alloc -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sgbuf.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sgbuf.c
  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
/.memory_wrapper.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-omit-frame-pointer -mapcs -mno-sched-prolog
-mapcs-32 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4
-mtune=arm9tdmi -malignment-traps -msoft-float -Uarm
-Wdeclaration-after-statement -DALSA_BUILD -DMODULE
-DKBUILD_BASENAME=memory_wrapper -DKBUILD_MODNAME=snd_page_alloc -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/memory_
wrapper.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/memory_
wrapper.c
  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
/.pcm.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-omit-frame-pointer -mapcs -mno-sched-prolog
-mapcs-32 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4
-mtune=arm9tdmi -malignment-traps -msoft-float -Uarm
-Wdeclaration-after-statement -DALSA_BUILD -DMODULE -DKBUILD_BASENAME=pcm
-DKBUILD_MODNAME=snd_pcm -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm.c
In file included from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/../alsa
-kernel/core/pcm.c:26,
                 from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm.c:1
:
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: "struct resource" declared inside parameter list
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: its scope is only this definition or declaration,
which is probably not what you want
  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
/.pcm_native.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-omit-frame-pointer -mapcs -mno-sched-prolog
-mapcs-32 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4
-mtune=arm9tdmi -malignment-traps -msoft-float -Uarm
-Wdeclaration-after-statement -DALSA_BUILD -DMODULE
-DKBUILD_BASENAME=pcm_native -DKBUILD_MODNAME=snd_pcm -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_nat
ive.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_nat
ive.c
In file included from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_nat
ive.c:30:
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: "struct resource" declared inside parameter list
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: its scope is only this definition or declaration,
which is probably not what you want
  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
/.pcm_lib.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-omit-frame-pointer -mapcs -mno-sched-prolog
-mapcs-32 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4
-mtune=arm9tdmi -malignment-traps -msoft-float -Uarm
-Wdeclaration-after-statement -DALSA_BUILD -DMODULE
-DKBUILD_BASENAME=pcm_lib -DKBUILD_MODNAME=snd_pcm -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_lib
.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_lib
.c
In file included from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/../alsa
-kernel/core/pcm_lib.c:26,
                 from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_lib
.c:4:
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: "struct resource" declared inside parameter list
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: its scope is only this definition or declaration,
which is probably not what you want
  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
/.pcm_timer.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-omit-frame-pointer -mapcs -mno-sched-prolog
-mapcs-32 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4
-mtune=arm9tdmi -malignment-traps -msoft-float -Uarm
-Wdeclaration-after-statement -DALSA_BUILD -DMODULE
-DKBUILD_BASENAME=pcm_timer -DKBUILD_MODNAME=snd_pcm -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_tim
er.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_tim
er.c
In file included from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/../alsa
-kernel/core/pcm_timer.c:24,
                 from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_tim
er.c:2:
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: "struct resource" declared inside parameter list
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: its scope is only this definition or declaration,
which is probably not what you want
  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
/.pcm_misc.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-omit-frame-pointer -mapcs -mno-sched-prolog
-mapcs-32 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4
-mtune=arm9tdmi -malignment-traps -msoft-float -Uarm
-Wdeclaration-after-statement -DALSA_BUILD -DMODULE
-DKBUILD_BASENAME=pcm_misc -DKBUILD_MODNAME=snd_pcm -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_mis
c.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_mis
c.c
In file included from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/../alsa
-kernel/core/pcm_misc.c:24,
                 from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_mis
c.c:2:
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: "struct resource" declared inside parameter list
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: its scope is only this definition or declaration,
which is probably not what you want
  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
/.pcm_memory.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-omit-frame-pointer -mapcs -mno-sched-prolog
-mapcs-32 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4
-mtune=arm9tdmi -malignment-traps -msoft-float -Uarm
-Wdeclaration-after-statement -DALSA_BUILD -DMODULE
-DKBUILD_BASENAME=pcm_memory -DKBUILD_MODNAME=snd_pcm -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_mem
ory.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_mem
ory.c
In file included from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/../alsa
-kernel/core/pcm_memory.c:27,
                 from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/pcm_mem
ory.c:2:
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: "struct resource" declared inside parameter list
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: its scope is only this definition or declaration,
which is probably not what you want
  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
/.timer.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-omit-frame-pointer -mapcs -mno-sched-prolog
-mapcs-32 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4
-mtune=arm9tdmi -malignment-traps -msoft-float -Uarm
-Wdeclaration-after-statement -DALSA_BUILD -DMODULE -DKBUILD_BASENAME=timer
-DKBUILD_MODNAME=snd_timer -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/timer.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/timer.c
In file included from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/timer.c
:30:
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: "struct resource" declared inside parameter list
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: its scope is only this definition or declaration,
which is probably not what you want
  arm-unknown-linux-gnu-gcc
-Wp,-MD,/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
/.sound.o.d  -nostdinc -isystem
/public/cross/arm-unknown-linux-gnu/gcc-3.4.2-glibc-2.2.5/lib/gcc/arm-unknow
n-linux-gnu/3.4.2/include
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/public/src/linux-2.6.14-rc4-nx1/include
-mlittle-endian
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore
-I/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os -fno-omit-frame-pointer
-fno-optimize-sibling-calls -fno-omit-frame-pointer -mapcs -mno-sched-prolog
-mapcs-32 -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4
-mtune=arm9tdmi -malignment-traps -msoft-float -Uarm
-Wdeclaration-after-statement -DALSA_BUILD -DMODULE -DKBUILD_BASENAME=sound
-DKBUILD_MODNAME=snd -c -o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.o
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.c
In file included from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.c
:27:
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: "struct resource" declared inside parameter list
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/include/sound
/core.h:342: warning: its scope is only this definition or declaration,
which is probably not what you want
In file included from
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.c
:532:
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.i
nc:49: error: `snd_pci_dev_present' undeclared here (not in a function)
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.i
nc:49: error: initializer element is not constant
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.i
nc:49: error: (near initialization for
`__ksymtab_snd_pci_dev_present.value')
/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.i
nc:49: error: __ksymtab_snd_pci_dev_present causes a section type conflict
make[5]: ***
[/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/sound.
o] Error 1
make[4]: ***
[/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore] Error
2
make[3]: ***
[_module_/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2]
Error 2
make[2]: *** [modules] Error 2
make[2]: Leaving directory `/public/src/linux-2.6.14-rc4-nx1'
make[1]: *** [compile] Error 2
make[1]: Leaving directory
`/public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2'
make: *** [/public/projects/mkembsys/state/nexcoder/alsadriver.compile]
Error 2




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
