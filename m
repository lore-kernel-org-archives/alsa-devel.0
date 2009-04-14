From: Susan Cragin <susancragin@earthlink.net>
Subject: Re: alsa-driver-unstable not updated since Mar 24th?
Date: Tue, 14 Apr 2009 11:10:17 -0400 (GMT-04:00)
Message-ID: <18643348.1239721817582.JavaMail.root@elwamui-ovcar.atl.sa.earthlink.net>
Reply-To: Susan Cragin <susancragin@earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary=---------------------------1160100043128273428738214877
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-scoter.atl.sa.earthlink.net
	(elasmtp-scoter.atl.sa.earthlink.net [209.86.89.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 4928724397
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 17:10:19 +0200 (CEST)
Received: from [209.86.224.44] (helo=elwamui-ovcar.atl.sa.earthlink.net)
	by elasmtp-scoter.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <susancragin@earthlink.net>) id 1LtkHB-00051L-U5
	for alsa-devel@alsa-project.org; Tue, 14 Apr 2009 11:10:17 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----------------------------1160100043128273428738214877
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>At Tue, 14 Apr 2009 09:52:42 -0400 (GMT-04:00),
>Susan Cragin wrote:
>> 
>> [1  <text/plain; UTF-8 (7bit)>]
>> >> I know there were problems on the 25th or 26th, either with the
>> >> drivers or between the drivers and changes made to the kernel.
>> >
>> >It's been broken during my vacation.
>> >Now it should be fixed.  Let me know if it's still broken.
>> >
>> >
>> >thanks,
>> >
>> >Takashi
>> 
>> I just downloaded and installed the unstable snapshot 14-April 11:48. Install worked on my Asus G1S running Ubuntu Jaunty with all updates (most recent kernel is only 2.6.28-11-Generic). 
>> 
>> But sound is not working correctly on my machine. Neither sound card works. 
>> Sound cards present:
>> hda-intel / Realtek ALC660-VD
>> hda-audio-generic / Creative CA0110-IBG (Creative X-fi)
>
>Is it a regression from older version?
>
>How about alsa-driver snapshot (stable one)?
>It won't work with CA0110, though.
>
>
>Takashi

Today's stable snapshot did not compile for me. I have attached the terminal output. 
My current problems with unstable are indeed a regression. CA0110 (my Creative X-fi) used to work very well with alsa-driver-unstable, as did my hda-intel. I last installed unstable perhaps two weeks ago? and used it at that time to run Audacity and sound programs in wine. I was getting very good sound. 
Susan


-----------------------------1160100043128273428738214877
Content-Disposition: attachment; filename="alsa_bad_compile.txt"
Content-Type: text/plain; name=alsa_bad_compile.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit

susan@ubuntu:~/Desktop/alsa-driver$ ./configure && make
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
checking for current directory... /home/susan/Desktop/alsa-driver
checking cross compile... 
checking for directory with kernel source... /lib/modules/2.6.28-11-generic/build
checking for directory with kernel build... 
checking for kernel linux/version.h... yes
checking for kernel linux/autoconf.h... yes
checking for kernel version... 2.6.28-11-generic
checking for GCC version... ./configure: eval: line 5218: syntax error near unexpected token `)'
./configure: eval: line 5218: `my_compiler_version=4.3.3-5ubuntu4)'
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
checking for V4L2 layer... yes
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
config.status: creating include/config1.h
config.status: creating include/version.h
config.status: creating include/autoconf-extra.h
Hacking autoconf.h...
if [ ! -d include/sound -a ! -L include/sound ]; then \
	  ln -sf ../alsa-kernel/include include/sound ; \
	fi
cp -puvf include/version.h include/sound/version.h
`include/version.h' -> `include/sound/version.h'
make dep
make[1]: Entering directory `/home/susan/Desktop/alsa-driver'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/acore'
copying file alsa-kernel/core/info.c
patching file info.c
copying file alsa-kernel/core/pcm.c
patching file pcm.c
Hunk #2 succeeded at 923 (offset 13 lines).
Hunk #3 succeeded at 939 (offset 13 lines).
Hunk #4 succeeded at 951 (offset 13 lines).
Hunk #5 succeeded at 1006 (offset 14 lines).
copying file alsa-kernel/core/pcm_native.c
patching file pcm_native.c
Hunk #3 succeeded at 358 (offset -5 lines).
Hunk #4 succeeded at 1554 (offset -25 lines).
Hunk #5 succeeded at 2798 (offset -30 lines).
Hunk #6 succeeded at 2851 (offset -30 lines).
Hunk #7 succeeded at 2879 (offset -30 lines).
Hunk #8 succeeded at 2895 (offset -30 lines).
Hunk #9 succeeded at 2921 (offset -30 lines).
Hunk #10 succeeded at 3009 (offset -30 lines).
Hunk #11 succeeded at 3028 (offset -30 lines).
Hunk #12 succeeded at 3042 (offset -30 lines).
Hunk #13 succeeded at 3099 (offset -30 lines).
Hunk #14 succeeded at 3127 (offset -30 lines).
Hunk #15 succeeded at 3184 (offset -30 lines).
Hunk #16 succeeded at 3213 (offset -30 lines).
Hunk #17 succeeded at 3243 (offset -30 lines).
Hunk #18 succeeded at 3321 (offset -30 lines).
Hunk #19 succeeded at 3353 (offset -30 lines).
Hunk #20 succeeded at 3418 (offset -30 lines).
Hunk #21 succeeded at 3448 (offset -30 lines).
Hunk #22 succeeded at 3490 (offset -32 lines).
Hunk #23 succeeded at 3642 (offset -41 lines).
copying file alsa-kernel/core/control.c
patching file control.c
Hunk #3 succeeded at 721 (offset 4 lines).
Hunk #4 succeeded at 781 (offset 1 line).
Hunk #5 succeeded at 1383 (offset -8 lines).
copying file alsa-kernel/core/hwdep.c
patching file hwdep.c
Hunk #3 succeeded at 308 (offset 1 line).
copying file alsa-kernel/core/init.c
patching file init.c
Hunk #2 succeeded at 297 (offset 17 lines).
Hunk #3 succeeded at 323 (offset 17 lines).
Hunk #4 succeeded at 641 (offset 15 lines).
copying file alsa-kernel/core/rawmidi.c
patching file rawmidi.c
Hunk #3 succeeded at 1312 (offset 23 lines).
Hunk #4 succeeded at 1396 (offset 23 lines).
copying file alsa-kernel/core/sound.c
patching file sound.c
Hunk #4 succeeded at 188 (offset 4 lines).
Hunk #5 succeeded at 266 (offset 4 lines).
Hunk #6 succeeded at 278 (offset 4 lines).
Hunk #7 succeeded at 295 (offset 4 lines).
Hunk #8 succeeded at 319 (offset 4 lines).
Hunk #9 succeeded at 374 (offset 4 lines).
Hunk #10 succeeded at 385 (offset 4 lines).
Hunk #11 succeeded at 411 (offset 4 lines).
Hunk #12 succeeded at 518 (offset 4 lines).
copying file alsa-kernel/core/timer.c
patching file timer.c
Hunk #3 succeeded at 997 (offset 5 lines).
Hunk #4 succeeded at 1911 (offset -3 lines).
Hunk #5 succeeded at 1956 (offset -3 lines).
copying file alsa-kernel/core/memalloc.c
patching file memalloc.c
Hunk #2 succeeded at 58 (offset -11 lines).
Hunk #3 succeeded at 207 (offset -11 lines).
Hunk #4 succeeded at 245 (offset -11 lines).
Hunk #5 succeeded at 267 (offset -11 lines).
Hunk #6 succeeded at 293 (offset -11 lines).
Hunk #7 succeeded at 311 (offset -11 lines).
Hunk #8 succeeded at 519 (offset -49 lines).
Hunk #9 succeeded at 658 (offset -49 lines).
Hunk #10 succeeded at 668 (offset -49 lines).
Hunk #11 succeeded at 707 (offset -49 lines).
copying file alsa-kernel/core/misc.c
patching file misc.c
copying file alsa-kernel/core/hrtimer.c
patching file hrtimer.c
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/acore/ioctl32'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/acore/ioctl32'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/acore/oss'
copying file alsa-kernel/core/oss/mixer_oss.c
patching file mixer_oss.c
Hunk #3 succeeded at 383 (offset 4 lines).
copying file alsa-kernel/core/oss/pcm_oss.c
patching file pcm_oss.c
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/acore/oss'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/acore/seq'
copying file alsa-kernel/core/seq/seq.c
patching file seq.c
Hunk #2 succeeded at 59 (offset 2 lines).
copying file alsa-kernel/core/seq/seq_clientmgr.c
patching file seq_clientmgr.c
Hunk #3 succeeded at 2209 (offset 6 lines).
Hunk #4 succeeded at 2561 (offset 10 lines).
copying file alsa-kernel/core/seq/seq_memory.c
patching file seq_memory.c
Hunk #3 succeeded at 250 (offset 2 lines).
make[4]: Entering directory `/home/susan/Desktop/alsa-driver/acore/seq/oss'
copying file alsa-kernel/core/seq/oss/seq_oss.c
patching file seq_oss.c
Hunk #3 succeeded at 192 (offset 3 lines).
Hunk #4 succeeded at 227 (offset 4 lines).
Hunk #5 succeeded at 330 (offset 4 lines).
make[4]: Leaving directory `/home/susan/Desktop/alsa-driver/acore/seq/oss'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/acore/seq'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/acore'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/i2c'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/i2c/l3'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/i2c/l3'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/i2c/other'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/i2c/other'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/i2c'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/drivers'
copying file alsa-kernel/drivers/mts64.c
patching file mts64.c
copying file alsa-kernel/drivers/portman2x4.c
patching file portman2x4.c
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/drivers/mpu401'
copying file alsa-kernel/drivers/mpu401/mpu401.c
patching file mpu401.c
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers/mpu401'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/drivers/opl3'
copying file alsa-kernel/drivers/opl3/opl3_lib.c
patching file opl3_lib.c
Hunk #2 succeeded at 438 (offset 2 lines).
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers/opl3'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/drivers/opl4'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers/opl4'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/drivers/pcsp'
copying file alsa-kernel/drivers/pcsp/pcsp.c
patching file pcsp.c
Hunk #2 succeeded at 97 with fuzz 1.
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers/pcsp'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/drivers/vx'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers/vx'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/isa'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/ad1816a'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/ad1816a'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/ad1848'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/ad1848'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/cs423x'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/cs423x'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/es1688'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/es1688'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/gus'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/gus'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/msnd'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/msnd'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/opti9xx'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/opti9xx'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/sb'
copying file alsa-kernel/isa/sb/sb16_csp.c
patching file sb16_csp.c
Hunk #2 succeeded at 712 (offset 2 lines).
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/sb'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/wavefront'
copying file alsa-kernel/isa/wavefront/wavefront_fx.c
patching file wavefront_fx.c
Hunk #2 succeeded at 250 (offset -4 lines).
copying file alsa-kernel/isa/wavefront/wavefront_synth.c
patching file wavefront_synth.c
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/wavefront'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/wss'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/wss'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/isa'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/synth'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/synth/emux'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/synth/emux'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/synth'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/pci'
copying file alsa-kernel/pci/ad1889.c
patching file ad1889.c
copying file alsa-kernel/pci/atiixp.c
patching file atiixp.c
Hunk #2 succeeded at 1673 (offset 2 lines).
Hunk #3 succeeded at 1718 (offset 2 lines).
copying file alsa-kernel/pci/atiixp_modem.c
patching file atiixp_modem.c
Hunk #2 succeeded at 1313 (offset 6 lines).
Hunk #3 succeeded at 1356 (offset 6 lines).
copying file alsa-kernel/pci/bt87x.c
patching file bt87x.c
Hunk #2 succeeded at 844 (offset -2 lines).
Hunk #3 succeeded at 998 (offset -2 lines).
copying file alsa-kernel/pci/cmipci.c
patching file cmipci.c
Hunk #2 succeeded at 3134 (offset -42 lines).
Hunk #3 succeeded at 3429 (offset -42 lines).
copying file alsa-kernel/pci/ens1370.c
patching file ens1370.c
Hunk #2 succeeded at 2121 (offset -10 lines).
Hunk #3 succeeded at 2497 (offset -10 lines).
copying file alsa-kernel/pci/fm801.c
patching file fm801.c
copying file alsa-kernel/pci/intel8x0.c
patching file intel8x0.c
Hunk #3 succeeded at 717 (offset 11 lines).
Hunk #4 succeeded at 727 (offset 11 lines).
Hunk #5 succeeded at 3255 (offset 127 lines).
copying file alsa-kernel/pci/maestro3.c
patching file maestro3.c
copying file alsa-kernel/pci/via82xx.c
patching file via82xx.c
Hunk #2 succeeded at 2436 with fuzz 2.
copying file alsa-kernel/pci/via82xx_modem.c
patching file via82xx_modem.c
Hunk #2 succeeded at 1187 (offset 7 lines).
Hunk #3 succeeded at 1247 (offset 7 lines).
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/ac97'
copying file alsa-kernel/pci/ac97/ac97_codec.c
patching file ac97_codec.c
Hunk #3 succeeded at 1918 (offset 7 lines).
Hunk #4 succeeded at 1930 with fuzz 1 (offset 7 lines).
Hunk #5 succeeded at 1954 (offset 7 lines).
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/ac97'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/ali5451'
copying file alsa-kernel/pci/ali5451/ali5451.c
patching file ali5451.c
Hunk #2 succeeded at 2207 (offset 2 lines).
Hunk #3 succeeded at 2377 (offset 2 lines).
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/ali5451'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/asihpi'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/asihpi'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/au88x0'
copying file alsa-kernel/pci/au88x0/au88x0.c
patching file au88x0.c
Hunk #2 succeeded at 339 (offset -2 lines).
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/au88x0'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/aw2'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/aw2'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/ca0106'
copying file alsa-kernel/pci/ca0106/ca0106_main.c
patching file ca0106_main.c
Hunk #3 succeeded at 1637 (offset 74 lines).
Hunk #4 succeeded at 1909 (offset 84 lines).
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/ca0106'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/cs46xx'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/cs46xx'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/cs5535audio'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/cs5535audio'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/echoaudio'
copying file alsa-kernel/pci/echoaudio/echoaudio.c
patching file echoaudio.c
Hunk #1 succeeded at 1885 (offset -41 lines).
Hunk #2 succeeded at 1948 (offset -41 lines).
copying file alsa-kernel/pci/echoaudio/darla20.c
patching file darla20.c
copying file alsa-kernel/pci/echoaudio/darla24.c
patching file darla24.c
copying file alsa-kernel/pci/echoaudio/echo3g.c
patching file echo3g.c
copying file alsa-kernel/pci/echoaudio/gina20.c
patching file gina20.c
copying file alsa-kernel/pci/echoaudio/gina24.c
patching file gina24.c
copying file alsa-kernel/pci/echoaudio/indigo.c
patching file indigo.c
copying file alsa-kernel/pci/echoaudio/indigodj.c
patching file indigodj.c
copying file alsa-kernel/pci/echoaudio/indigoio.c
patching file indigoio.c
copying file alsa-kernel/pci/echoaudio/indigodjx.c
patching file indigodjx.c
copying file alsa-kernel/pci/echoaudio/indigoiox.c
patching file indigoiox.c
copying file alsa-kernel/pci/echoaudio/layla20.c
patching file layla20.c
copying file alsa-kernel/pci/echoaudio/layla24.c
patching file layla24.c
copying file alsa-kernel/pci/echoaudio/mia.c
patching file mia.c
copying file alsa-kernel/pci/echoaudio/mona.c
patching file mona.c
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/echoaudio'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/emu10k1'
copying file alsa-kernel/pci/emu10k1/emu10k1_main.c
patching file emu10k1_main.c
Hunk #4 succeeded at 1409 (offset -1 lines).
Hunk #5 succeeded at 1452 (offset -1 lines).
Hunk #6 succeeded at 1767 (offset 3 lines).
copying file alsa-kernel/pci/emu10k1/emu10k1x.c
patching file emu10k1x.c
Hunk #2 succeeded at 942 (offset 2 lines).
Hunk #3 succeeded at 1636 (offset 8 lines).
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/emu10k1'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/hda'
copying file alsa-kernel/pci/hda/hda_beep.c
patching file hda_beep.c
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/hda'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/ice1712'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/ice1712'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/korg1212'
copying file alsa-kernel/pci/korg1212/korg1212.c
patching file korg1212.c
Hunk #2 succeeded at 2342 (offset 3 lines).
Hunk #3 succeeded at 2498 (offset 3 lines).
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/korg1212'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/lx6464es'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/lx6464es'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/mixart'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/mixart'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/nm256'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/nm256'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/oxygen'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/oxygen'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/pcxhr'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/pcxhr'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/pdplus'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/pdplus'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/riptide'
copying file alsa-kernel/pci/riptide/riptide.c
patching file riptide.c
Hunk #2 succeeded at 1280 (offset 1 line).
Hunk #3 succeeded at 2243 (offset 9 lines).
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/riptide'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/rme9652'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/rme9652'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/trident'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/trident'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/vx222'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/vx222'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/ymfpci'
copying file alsa-kernel/pci/ymfpci/ymfpci_main.c
patching file ymfpci_main.c
Hunk #2 succeeded at 2016 with fuzz 2 (offset -28 lines).
Hunk #3 succeeded at 2036 with fuzz 2 (offset -30 lines).
Hunk #4 succeeded at 2376 (offset -30 lines).
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/ymfpci'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/pci'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/aoa'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/aoa/codecs'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa/codecs'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/aoa/core'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa/core'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/aoa/fabrics'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa/fabrics'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/aoa/soundbus'
make[4]: Entering directory `/home/susan/Desktop/alsa-driver/aoa/soundbus/i2sbus'
make[4]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa/soundbus/i2sbus'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa/soundbus'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/soc'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/atmel'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/atmel'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/au1x'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/au1x'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/blackfin'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/blackfin'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/codecs'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/codecs'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/davinci'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/davinci'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/fsl'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/fsl'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/omap'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/omap'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/pxa'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/pxa'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/s3c24xx'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/s3c24xx'
make: Entering an unknown directory
make: *** s6000: No such file or directory.  Stop.
make: Leaving an unknown directory
make[2]: *** [prepare] Error 1
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/soc'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/home/susan/Desktop/alsa-driver'
make: *** [include/sndversions.h] Error 2
susan@ubuntu:~/Desktop/alsa-driver$ ./configure && make
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
checking for current directory... /home/susan/Desktop/alsa-driver
checking cross compile... 
checking for directory with kernel source... /lib/modules/2.6.28-11-generic/build
checking for directory with kernel build... 
checking for kernel linux/version.h... yes
checking for kernel linux/autoconf.h... yes
checking for kernel version... 2.6.28-11-generic
checking for GCC version... ./configure: eval: line 5218: syntax error near unexpected token `)'
./configure: eval: line 5218: `my_compiler_version=4.3.3-5ubuntu4)'
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
checking for V4L2 layer... yes
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
make[1]: Entering directory `/home/susan/Desktop/alsa-driver'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/acore'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/acore/ioctl32'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/acore/ioctl32'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/acore/oss'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/acore/oss'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/acore/seq'
make[4]: Entering directory `/home/susan/Desktop/alsa-driver/acore/seq/oss'
make[4]: Leaving directory `/home/susan/Desktop/alsa-driver/acore/seq/oss'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/acore/seq'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/acore'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/i2c'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/i2c/l3'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/i2c/l3'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/i2c/other'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/i2c/other'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/i2c'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/drivers'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/drivers/mpu401'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers/mpu401'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/drivers/opl3'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers/opl3'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/drivers/opl4'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers/opl4'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/drivers/pcsp'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers/pcsp'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/drivers/vx'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers/vx'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/drivers'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/isa'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/ad1816a'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/ad1816a'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/ad1848'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/ad1848'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/cs423x'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/cs423x'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/es1688'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/es1688'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/gus'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/gus'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/msnd'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/msnd'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/opti9xx'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/opti9xx'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/sb'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/sb'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/wavefront'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/wavefront'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/isa/wss'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/isa/wss'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/isa'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/synth'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/synth/emux'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/synth/emux'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/synth'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/pci'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/ac97'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/ac97'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/ali5451'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/ali5451'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/asihpi'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/asihpi'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/au88x0'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/au88x0'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/aw2'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/aw2'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/ca0106'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/ca0106'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/cs46xx'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/cs46xx'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/cs5535audio'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/cs5535audio'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/echoaudio'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/echoaudio'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/emu10k1'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/emu10k1'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/hda'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/hda'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/ice1712'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/ice1712'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/korg1212'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/korg1212'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/lx6464es'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/lx6464es'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/mixart'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/mixart'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/nm256'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/nm256'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/oxygen'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/oxygen'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/pcxhr'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/pcxhr'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/pdplus'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/pdplus'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/riptide'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/riptide'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/rme9652'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/rme9652'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/trident'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/trident'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/vx222'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/vx222'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/pci/ymfpci'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/pci/ymfpci'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/pci'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/aoa'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/aoa/codecs'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa/codecs'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/aoa/core'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa/core'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/aoa/fabrics'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa/fabrics'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/aoa/soundbus'
make[4]: Entering directory `/home/susan/Desktop/alsa-driver/aoa/soundbus/i2sbus'
make[4]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa/soundbus/i2sbus'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa/soundbus'
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/aoa'
make[2]: Entering directory `/home/susan/Desktop/alsa-driver/soc'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/atmel'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/atmel'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/au1x'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/au1x'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/blackfin'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/blackfin'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/codecs'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/codecs'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/davinci'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/davinci'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/fsl'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/fsl'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/omap'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/omap'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/pxa'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/pxa'
make[3]: Entering directory `/home/susan/Desktop/alsa-driver/soc/s3c24xx'
make[3]: Leaving directory `/home/susan/Desktop/alsa-driver/soc/s3c24xx'
make: Entering an unknown directory
make: *** s6000: No such file or directory.  Stop.
make: Leaving an unknown directory
make[2]: *** [prepare] Error 1
make[2]: Leaving directory `/home/susan/Desktop/alsa-driver/soc'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/home/susan/Desktop/alsa-driver'
make: *** [include/sndversions.h] Error 2
susan@ubuntu:~/Desktop/alsa-driver$ 


-----------------------------1160100043128273428738214877
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-----------------------------1160100043128273428738214877--
