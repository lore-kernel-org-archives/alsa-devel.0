From: James Pearson <james-p@moving-picture.com>
Subject: Re: Problems with 32 bit apps on 64 bit OS using dmix
 and snd-ioctl32
Date: Wed, 05 Sep 2007 16:36:10 +0100
Message-ID: <46DECCEA.4060306@moving-picture.com>
References: <46DE8EB0.90208@moving-picture.com>
	<s5hd4wx8ec0.wl%tiwai@suse.de>	<46DEBF69.6070307@moving-picture.com>
	<s5hodgh6sqf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A6E7103907
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 17:36:13 +0200 (CEST)
In-Reply-To: <s5hodgh6sqf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 05 Sep 2007 15:38:33 +0100,
> James Pearson wrote:
> 
>>Takashi Iwai wrote:
>>
>>>>So, what is the danger of using these 'disabled' ioctls?
>>>>
>>>>I can't find any reference to 'TCOC* definitions' - what are these ???
>>>
>>>
>>>A typo of TIOC* or TC*.  They are defined in asm-*/ioctls.h.
>>>
>>>These are used for syscalls like fcntl().  Thus, it's indeed dangerous
>>>to define these.
>>>
>>>Can't you build the new alsa-driver with old kernel?  Then, together
>>>with the new alsa-lib, the problem should go away.
>>
>>I can't build either alsa-driver 1.0.14 or 1.0.15rc1 - they bomb out with:
>>
>>   CC [M]  /tmp/alsa-driver-1.0.15rc1/misc/ac97_bus.o
>>In file included from /tmp/alsa-driver-1.0.15rc1/misc/ac97_bus.c:1:
>>/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:30: error: 
>>syntax error before "pm_message_t"
>>/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:31: warning: 
>>function declaration isn't a prototype
>>/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c: In function 
>>`ac97_bus_suspend':
>>/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:34: error: 
>>`dev' undeclared (first use in this function)
>>/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:34: error: 
>>(Each undeclared identifier is reported only once
>>/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:34: error: for 
>>each function it appears in.)
>>/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:35: error: 
>>`state' undeclared (first use in this function)
>>/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c: In function 
>>`ac97_bus_resume':
>>/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:45: error: too 
>>few arguments to function
>>make[4]: *** [/tmp/alsa-driver-1.0.15rc1/misc/ac97_bus.o] Error 1
>>
>>However, even if I could build 1.0.14/15rc1, I'm not sure if they would 
>>help - as I think the important output from the configure script 
>>(alsa-driver 1.0.13 and above) is:
>>
>>checking for new unlocked/compat_ioctl... no
>>
>>and in include/config.h:
>>
>>/* #undef CONFIG_SND_HAVE_NEW_IOCTL */
>>
>>So, as far as I can tell, means that I have to use the snd-ioctl32 
>>module, which has the problems I originally described.
>>
>>Is this correct?
> 
> 
> No, this is perfectly OK.  The problem isn't that you use snd-ioctl32
> module but that the driver is still old and it doesn't accept the new
> defined ioctls.  The later version of alsa-driver uses the newer
> ioctls so that they don't conflict even on snd-ioctl32 module.
> 
> The right solution is to get the latest alsa-driver working on your
> system.  I guess the build problem above is very specific to RedHat.
> Unfortunately, I can't help much because I have little clue about
> funny RedHat modifications.  The error implies, however, some
> configure mismatch.  Maybe showing the configure output would help a
> little bit to know what's happening there...

OK, I'll do a bit more poking about to see if I can get 1.0.15rc1 to 
build ...

Thanks

James Pearson

Configure output:

# ./configure --with-redhat=yes
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
checking for current directory... /tmp/alsa-driver-1.0.15rc1
checking cross compile...
checking for directory with kernel source... 
/lib/modules/2.6.9-42.0.3.mpc23smp/source
checking for directory with kernel build... 
/lib/modules/2.6.9-42.0.3.mpc23smp/build
checking for kernel linux/version.h... yes
checking for kernel linux/autoconf.h... yes
checking for kernel version... 2.6.9-42.0.3.mpc23smp
checking for GCC version... Kernel compiler: gcc 3.4.6 20060404 (Red Hat 
3.4.6-3) Used compiler: gcc (GCC) 3.4.6 20060404 (Red Hat 3.4.6-3)
checking for built-in ALSA... no
checking for existing ALSA module... yes
checking for Red Hat kernel... yes
checking for SUSE kernel... auto
checking for SUSE kernel... no
checking for CONFIG_EXPERIMENTAL... yes
checking for kernel linux/config.h... yes
checking to modify of kernel linux/kmod.h... no
checking for kernel linux/utsrelease.h... no
Creating a dummy <linux/utsrelease.h>...
checking for kernel linux/compiler.h... yes
checking for kernel linux/pm.h... yes
checking for kernel linux/spinlock.h... yes
checking for kernel linux/irq.h... yes
checking for kernel linux/threads.h... yes
checking for kernel linux/rwsem.h... yes
checking for kernel linux/gameport.h... yes
checking for kernel media/v4l2-dev.h... no
Creating a dummy <media/v4l2-dev.h>...
checking for kernel linux/devfs_fs_kernel.h... yes
checking for kernel linux/highmem.h... yes
checking for kernel linux/workqueue.h... yes
checking for kernel linux/dma-mapping.h... yes
checking for kernel asm/hw_irq.h... yes
checking for kernel linux/device.h... yes
checking for kernel linux/platform_device.h... no
Creating <linux/platform_device.h>...
checking for kernel linux/isa.h... no
Creating <linux/isa.h>...
checking for kernel linux/jiffies.h... yes
checking for kernel linux/compat.h... yes
checking for kernel linux/log2.h... no
Creating a dummy <linux/log2.h>...
checking for kernel linux/adb.h... yes
checking for kernel linux/cuda.h... yes
checking for kernel linux/pmu.h... yes
checking for kernel linux/moduleparam.h... yes
checking for kernel linux/syscalls.h... yes
checking for kernel linux/firmware.h... yes
checking for kernel linux/err.h... yes
checking for kernel linux/bitmap.h... yes
checking for kernel linux/mutex.h... yes
checking for kernel linux/latency.h... no
Creating <linux/latency.h>...
checking for kernel asm/irq_regs.h... no
Creating a dummy <asm/irq_regs.h>...
checking for kernel module symbol versions... yes
checking for PCI support in kernel... yes
checking for I2C driver in kernel... module
checking for I2C_POWERMAC in kernel... unknown
checking for firmware loader... yes
checking for input subsystem in kernel... yes
checking for directory to store kernel modules... 
/lib/modules/2.6.9-42.0.3.mpc23smp/kernel/sound
checking for verbose procfs... on
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... no
checking for processor type... x86_64
checking for 32bit compat support... yes
checking for SMP... yes
checking for Video device support in kernel... yes
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
checking for pci_dev_present... no
checking for msleep... yes
checking for msleep_interrupt... yes
checking for msecs_to_jiffies... yes
checking for tty->count is the atomic type... no
checking for video_get_drvdata... yes
checking for io_remap_pfn_range... no
checking for new io_remap_page_range... yes
checking for kcalloc... yes
checking for kstrdup... yes
checking for kzalloc... yes
checking for create_workqueue with flags... no
checking for saved_config_space in pci_dev... yes
checking for new pci_save_state... no
checking for register_sound_special_device... no
checking for driver version... 1.0.15rc1
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for OSS PCM plugin system inclusion... yes
checking for RTC callback support in kernel... may be buggy, skipped
checking for HPET support... no
checking for dynamic minor numbers... no
checking for support of old API... yes
checking for Procfs support... yes
checking for USB support... yes
checking for class_simple... yes
checking for old driver suspend/resume callbacks... yes
checking for removal of page-reservation for nopage/mmap... no
checking for nested class_device... no
checking for new IRQ handler... no
checking for gfp_t... yes
checking for PnP suspend/resume... no
checking for new unlocked/compat_ioctl... no
checking for x86-compatible PC... no
checking for High-Res timers... no
checking for kernel PCMCIA
checking for PCMCIA support... yes
checking for PC9800 support in kernel... no
checking for parallel port support... yes
checking for power management... yes
checking for which soundcards to compile driver for... all
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
Hacking autoconf.h...
