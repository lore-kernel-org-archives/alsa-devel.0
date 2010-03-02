From: VDR User <user.vdr@gmail.com>
Subject: alsa needs updating for stable kernel 2.6.33+,
	and compile error
Date: Tue, 2 Mar 2010 11:32:41 -0800
Message-ID: <a3ef07921003021132x3f7e0f19p4524cea24fdd7dee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8973110380F
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 20:32:42 +0100 (CET)
Received: by pwj10 with SMTP id 10so318802pwj.38
	for <alsa-devel@alsa-project.org>; Tue, 02 Mar 2010 11:32:41 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

First, linux/utsrelease.h was moved to generated/utsrelease.h so that
needs to be fixed.

Also, when will hdmi audio support for GT220 cards be included?

And any ideas why this compile is failing?:

test:/usrc/alsa/alsa-driver-1.0.22.1$ ./configure
--with-cards=3Dhda-intel
--with-card-options=3Dhda-hwdep,hda-reconfig,hda-codec-realtek,hda-codec-nv=
hdmi
--with-isapnp=3Dno --with-sequencer=3Dno --with-oss=3Dno
--with-pcm-oss-plugins=3Dno
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
checking for current directory... /usr/local/src/alsa/alsa-driver-1.0.22.1
checking cross compile...
checking for directory with ALSA kernel sources... ./configure: line
5107: cd: ../alsa-kmirror: No such file or directory
../alsa-kmirror
checking for directory with kernel source...
/lib/modules/2.6.33.amd64-x2.030210.1/source
checking for directory with kernel build...
/lib/modules/2.6.33.amd64-x2.030210.1/build
checking for kernel linux/version.h... yes
checking for kernel linux/autoconf.h... yes
checking for kernel version... 2.6.33.amd64-x2.030210.1
checking for GCC version... ./configure: eval: line 5495: syntax error
near unexpected token `)'
./configure: eval: line 5495: `my_compiler_version=3D4.4.2-9)'
./configure: line 5495: warning: syntax errors in . or eval will cause
future versions of the shell to abort as Posix requires
Kernel compiler:  Used compiler: gcc (Debian 4.4.2-9) 4.4.3 20100108
(prerelease)

*** NO PREDEFINED KERNEL COMPILER IS DETECTED
*** Assuming the same compiler is used with the current system compiler.

*** Please make sure that the same compiler version was used for
building kernel.

checking for built-in ALSA... no
checking for existing ALSA module... yes
checking for Red Hat kernel... auto
checking for Red Hat kernel... no
checking for SUSE kernel... auto
checking for SUSE kernel... no
checking for updating alsa-kernel version.h... yes
checking for CONFIG_EXPERIMENTAL... yes
checking for directory to store kernel modules...
/lib/modules/2.6.33.amd64-x2.030210.1/kernel/sound
checking for verbose procfs... on
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... no
checking for processor type... k8
checking for ISA DMA API... yes
checking for kernel linux/config.h... no
Creating <linux/config.h>...
checking for deprecated linux/config.h... checking to modify of kernel
linux/kmod.h... no
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
checking for kernel linux/bug.h... yes
checking for kernel linux/math64.h... yes
checking for kernel linux/regulator/consumer.h... yes
checking for kernel linux/dmi.h... yes
checking for kernel linux/bitrev.h... yes
checking for kernel linux/hrtimer.h... yes
checking for kernel linux/gcd.h... yes
checking for kernel module symbol versions... no
checking for has ioport support... yes
checking for PCI support in kernel... yes
checking for I2C driver in kernel... yes
checking for I2C_POWERMAC in kernel... unknown
checking for firmware loader... yes
checking for input subsystem in kernel... yes
checking for pc-speaker platform in kernel... yes
checking for SMP... yes
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
checking for tty->count is the atomic type... yes
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
checking for driver version... 1.0.22.1
checking for dynamic minor numbers... no
checking for sequencer support... no
checking for OSS/Free emulation... no
checking for RTC support... yes
checking for HPET support... no
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
checking for x86-compatible PC... no
checking for High-Res timers... yes
checking for kernel PCMCIA
checking for PCMCIA support... no
checking for PCMCIA module support... no
checking for PC9800 support in kernel... no
checking for parallel port support... no
checking for parallel port module support... no
checking for power management... yes
checking for CONFIG_HAS_DMA... yes
checking for cards to compile driver for... hda-intel
checking for additonal options to compile driver for... hda-hwdep
hda-reconfig hda-codec-realtek hda-codec-nvhdmi
configure: creating ./config.status
config.status: creating version
config.status: creating Makefile.conf
config.status: WARNING:  Makefile.conf.in seems to ignore the
--datarootdir setting
config.status: creating snddevices
config.status: creating utils/alsa-driver.spec
config.status: creating utils/buildrpm
config.status: creating toplevel.config
config.status: creating utils/alsasound
config.status: creating utils/alsasound.posix
config.status: creating include/pci_ids_compat.h
config.status: creating include/i2c-id_compat.h
config.status: creating include/config.h
config.status: creating include/config1.h
config.status: creating include/version.h
config.status: include/version.h is unchanged
config.status: creating include/autoconf-extra.h
config.status: include/autoconf-extra.h is unchanged
Hacking autoconf.h...
test:/usrc/alsa/alsa-driver-1.0.22.1$ make
make -C /lib/modules/2.6.33.amd64-x2.030210.1/source
SUBDIRS=3D/usr/local/src/alsa/alsa-driver-1.0.22.1  CPP=3D"gcc -E"
CC=3D"gcc" modules
make[1]: Entering directory `/usr/src/linux-2.6.33'
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/hwdep.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/memory_wrapper.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/memalloc.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/sgbuf.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/pcm.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/pcm_native.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/pcm_lib.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/pcm_timer.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/pcm_misc.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/pcm_memory.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/timer.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/wrappers.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/misc_driver.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/sound.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/init.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/memory.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/info.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/control.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/misc.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/device.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/isadma.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/vmaster.o
  LD [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/snd.o
  LD [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/snd-hwdep.o
  LD [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/snd-timer.o
  LD [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/snd-pcm.o
  LD [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/acore/snd-page-alloc.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/patch_nvhdmi.o
In file included from
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/patch_nvhdmi.c:3:
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:219:1:
warning: "AC_VERB_GET_CVT_CHAN_COUNT" redefined
In file included from
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:29,
                 from
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/patch_nvhdmi.c:3:
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
hda_codec.h:93:1:
warning: this is the location of the previous definition
In file included from
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/patch_nvhdmi.c:3:
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:220:1:
warning: "AC_VERB_GET_HDMI_DIP_DATA" redefined
In file included from
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:29,
                 from
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/patch_nvhdmi.c:3:
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
hda_codec.h:97:1:
warning: this is the location of the previous definition
In file included from
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/patch_nvhdmi.c:3:
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:221:1:
warning: "AC_VERB_GET_HDMI_DIP_XMIT" redefined
In file included from
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:29,
                 from
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/patch_nvhdmi.c:3:
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
hda_codec.h:98:1:
warning: this is the location of the previous definition
In file included from
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/patch_nvhdmi.c:3:
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:
In function =E2hdmi_checksum_audio_infoframe=E2:
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:334:
warning: unused variable =E2bytes=E2
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:
In function =E2hdmi_setup_channel_allocation=E2:
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:397:
warning: unused variable =E2spk_mask=E2
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:396:
warning: unused variable =E2i=E2
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:395:
warning: unused variable =E2eld=E2
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:394:
warning: unused variable =E2spec=E2
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:
In function =E2hdmi_setup_audio_infoframe=E2:
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:545:
warning: unused variable =E2i=E2
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:543:
warning: unused variable =E2spec=E2
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/patch_nvhdmi.c: At top lev=
el:
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:89:
warning: =E2eld_speaker_allocation_bits=E2 defined but not used
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:285:
warning: =E2hdmi_enable_output=E2 defined but not used
/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/../../alsa-kernel/pci/hda/=
patch_nvhdmi.c:366:
warning: =E2init_channel_allocations=E2 defined but not used
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/patch_realtek.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/hda_codec.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/hda_proc.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/hda_hwdep.o
make[4]: *** No rule to make target
`/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/hda_intel.o', needed
by `/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda/snd-hda-codec.o'.
 Stop.
make[3]: *** [/usr/local/src/alsa/alsa-driver-1.0.22.1/pci/hda] Error 2
make[2]: *** [/usr/local/src/alsa/alsa-driver-1.0.22.1/pci] Error 2
make[1]: *** [_module_/usr/local/src/alsa/alsa-driver-1.0.22.1] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.33'
make: *** [compile] Error 2
test:/usrc/alsa/alsa-driver-1.0.22.1$
