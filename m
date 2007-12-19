From: John Stile <john@stilen.com>
Subject: Re: snd-hda-intel support for SPDIF-in
	wiht	vt1708	card?
Date: Tue, 18 Dec 2007 20:49:28 -0800
Message-ID: <1198039768.7926.15.camel@genx.localdomain>
References: <1197916048.14752.132.camel@genx.localdomain>
	<s5hir2wxig4.wl%tiwai@suse.de>
	<1197995286.9405.23.camel@genx.localdomain>
	<s5hy7bsvyab.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mother.stilen.com (dsl027-182-089.sfo1.dsl.speakeasy.net
	[216.27.182.89]) by alsa0.perex.cz (Postfix) with ESMTP id E5B512435D
	for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2007 05:49:56 +0100 (CET)
In-Reply-To: <s5hy7bsvyab.wl%tiwai@suse.de>
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

On Tue, 2007-12-18 at 16:05 +0100, Takashi Iwai wrote:
> At Tue, 18 Dec 2007 08:28:06 -0800,
> John Stile wrote:
> > 
> > On Tue, 2007-12-18 at 14:04 +0100, Takashi Iwai wrote:
> > > At Mon, 17 Dec 2007 10:27:27 -0800,
> > > John Stile wrote:
> > > > 
> > > > I am trying to use a Via VT1708 audio card ( uses the snd-hda-intel.ko
> > > > driver) to record from SPDIF-in.
> > > > 
> > > > An off-list reply to my posting to alsa-users list suggested that
> > > > snd-hda-intel.ko might not support SPDIF-in with the VT1708 card, which
> > > > brought me here.
> > > > 
> > > > Can someone who works on the Intel HDA driver tell me if it supports
> > > > SPDIF-in on the VT1708 audio card?
> > > 
> > > It should be, but not tested well, I guess.
> > > 
> > > The driver enables the SPDIF-in capability when BIOS sets the pin
> > > information properly.  Check /proc/asound/card0/codec#* file whether
> > > you have any (activated) input pin node that supports SPDIF-in.
> > > 
> > > 
> > > Takashi
> > Thank you for your reply!
> > The output of your command is below.
> >   spdif-out=Node 0x25
> >   spdif-in=Node 0x26
> > Neither labeled inactive,
> > but spdif-in doesn't list a "Connection" line.
> 
> Just because it's only for input (thus it has no "source").
> 
> > I have the latest bios: 1.03 (2007/08/23) (a beta bios is available).
> > Do I try the beta bios?
> 
> I don't think so.  Likely a driver bug.
> How about the patch below (against the latest HG version)?
> 
> 
> Takashi
> 
> diff -r 2d3893cf030c pci/hda/patch_via.c
> --- a/pci/hda/patch_via.c	Tue Dec 18 15:42:53 2007 +0100
> +++ b/pci/hda/patch_via.c	Tue Dec 18 17:48:00 2007 +0100
> @@ -568,25 +568,27 @@ static int via_init(struct hda_codec *co
>  		if (IS_VT1708_VENDORID(codec->vendor_id)) {
>  			snd_hda_codec_write(codec, VT1708_DIGIN_PIN, 0,
>  					    AC_VERB_SET_PIN_WIDGET_CONTROL,
> -					    0x40);
> +					    PIN_OUT);
>  			snd_hda_codec_write(codec, VT1708_DIGIN_PIN, 0,
>  					    AC_VERB_SET_EAPD_BTLENABLE, 0x02);
>  		} else if (IS_VT1709_10CH_VENDORID(codec->vendor_id) ||
>  			   IS_VT1709_6CH_VENDORID(codec->vendor_id)) {
>  			snd_hda_codec_write(codec, VT1709_DIGIN_PIN, 0,
>  					    AC_VERB_SET_PIN_WIDGET_CONTROL,
> -					    0x40);
> +					    PIN_OUT);
>  			snd_hda_codec_write(codec, VT1709_DIGIN_PIN, 0,
>  					    AC_VERB_SET_EAPD_BTLENABLE, 0x02);
>  		} else if (IS_VT1708B_8CH_VENDORID(codec->vendor_id) ||
>  			   IS_VT1708B_4CH_VENDORID(codec->vendor_id)) {
>  			snd_hda_codec_write(codec, VT1708B_DIGIN_PIN, 0,
>  					    AC_VERB_SET_PIN_WIDGET_CONTROL,
> -					    0x40);
> +					    PIN_OUT);
>  			snd_hda_codec_write(codec, VT1708B_DIGIN_PIN, 0,
>  					    AC_VERB_SET_EAPD_BTLENABLE, 0x02);
>  		}
> -	}
> +	} else /* enable SPDIF-input pin */
> +		snd_hda_codec_write(codec, spec->autocfg.dig_in_pin, 0,
> +				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN);
>  
>   	return 0;
>  }

After making the changes by hand the compile failed. 
This is the output:
gcc utils/mod-deps.c -o utils/mod-deps
utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel --hiddendir /usr/src/alsa-driver --versiondep /usr/src/alsa-driver/kconfig-vers --makeconf > toplevel.config.in
can't handle word INPUT=y properly, supposing it's OK
can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel --hiddendir /usr/src/alsa-driver --versiondep /usr/src/alsa-driver/kconfig-vers --acinclude > acinclude.m4
can't handle word INPUT=y properly, supposing it's OK
can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel --hiddendir /usr/src/alsa-driver --versiondep /usr/src/alsa-driver/kconfig-vers --include > include/config1.h.in
can't handle word INPUT=y properly, supposing it's OK
can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
./configure --with-debug=full --with-isapnp=yes --with-sequencer=yes
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
checking for current directory... /usr/src/alsa-driver
checking cross compile...
checking for directory with kernel source... /lib/modules/2.6.23-gentoo-r3/source
checking for directory with kernel build... /lib/modules/2.6.23-gentoo-r3/build
checking for kernel linux/version.h... yes
checking for kernel linux/autoconf.h... yes
checking for kernel version... 2.6.23-gentoo-r3
checking for GCC version... Kernel compiler: gcc 4.1.2 (Gentoo 4.1.2 p1.0.2) Used compiler: gcc (GCC) 4.1.2 (Gentoo 4.1.2 p1.0.2)
checking for built-in ALSA... no
checking for existing ALSA module... yes
checking for Red Hat kernel... auto
checking for Red Hat kernel... no
checking for SUSE kernel... auto
checking for SUSE kernel... no
checking for CONFIG_EXPERIMENTAL... yes
checking for kernel linux/config.h... no
Creating <linux/config.h>...
checking to modify of kernel linux/kmod.h... no
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
checking for kernel linux/moduleparam.h... yes
checking for kernel linux/syscalls.h... yes
checking for kernel linux/firmware.h... yes
checking for kernel linux/err.h... yes
checking for kernel linux/bitmap.h... yes
checking for kernel linux/mutex.h... yes
checking for kernel linux/latency.h... yes
checking for kernel linux/kthread.h... yes
checking for kernel asm/irq_regs.h... yes
checking for kernel module symbol versions... yes
checking for has ioport support... yes
checking for PCI support in kernel... yes
checking for I2C driver in kernel... module
checking for I2C_POWERMAC in kernel... unknown
checking for firmware loader... module
checking for input subsystem in kernel... yes
checking for directory to store kernel modules... /lib/modules/2.6.23-gentoo-r3/kernel/sound
checking for verbose procfs... on
checking for verbose printk... on
checking for debug level... full
checking for ISA support in kernel... yes
checking for processor type... x86_32
checking for ISA DMA API... yes
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
checking for vmalloc_to_page... no
checking for old kmod... no
checking for PDE... no
checking for pci_set_consistent_dma_mask... no
checking for pci_dev_present... no
checking for msleep... yes
checking for msleep_interrupt... yes
checking for msecs_to_jiffies... yes
checking for tty->count is the atomic type... no
checking for video_get_drvdata... no
checking for V4L1 layer... yes
checking for io_remap_pfn_range... no
checking for new io_remap_page_range... no
checking for kcalloc... no
checking for kstrdup... yes
checking for kzalloc... no
checking for create_workqueue with flags... no
checking for saved_config_space in pci_dev... no
checking for register_sound_special_device... no
checking for driver version... 1.0.15
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for OSS PCM plugin system inclusion... yes
checking for RTC callback support in kernel... no
checking for HPET support... no
checking for dynamic minor numbers... no
checking for support of old API... yes
checking for Procfs support... yes
checking for USB support... yes
checking for class_simple... no
checking for old driver suspend/resume callbacks... no
checking for removal of page-reservation for nopage/mmap... no
checking for nested class_device... no
checking for new IRQ handler... no
checking for gfp_t... no
checking for PnP suspend/resume... no
checking for new unlocked/compat_ioctl... no
checking for x86-compatible PC... yes
checking for High-Res timers... no
checking for kernel PCMCIA
checking for PCMCIA support... yes
checking for PC9800 support in kernel... no
checking for parallel port support... yes
checking for power management... yes
checking for CONFIG_HAS_DMA... yes
checking for which soundcards to compile driver for... all
configure: creating ./config.status
config.status: creating version
config.status: creating Makefile.conf
config.status: WARNING:  Makefile.conf.in seems to ignore the --datarootdir setting
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
make[1]: Entering directory `/usr/src/alsa-driver/acore'
copying file alsa-kernel/core/info.c
patching file info.c
Hunk #8 succeeded at 535 with fuzz 2.
copying file alsa-kernel/core/pcm.c
patching file pcm.c
copying file alsa-kernel/core/pcm_native.c
patching file pcm_native.c
Hunk #4 succeeded at 1602 (offset 2 lines).
Hunk #5 succeeded at 2857 (offset 17 lines).
Hunk #6 succeeded at 2877 (offset 17 lines).
Hunk #7 succeeded at 2907 (offset 17 lines).
Hunk #8 succeeded at 2934 (offset 17 lines).
Hunk #9 succeeded at 2950 (offset 17 lines).
Hunk #10 succeeded at 2980 (offset 17 lines).
Hunk #11 succeeded at 3066 (offset 17 lines).
Hunk #12 succeeded at 3085 (offset 17 lines).
Hunk #13 succeeded at 3099 (offset 17 lines).
Hunk #14 succeeded at 3157 (offset 17 lines).
Hunk #15 succeeded at 3185 (offset 17 lines).
Hunk #16 succeeded at 3243 (offset 17 lines).
Hunk #17 succeeded at 3272 (offset 17 lines).
Hunk #18 succeeded at 3302 (offset 17 lines).
Hunk #19 succeeded at 3379 (offset 17 lines).
Hunk #20 succeeded at 3411 (offset 17 lines).
Hunk #21 succeeded at 3477 (offset 17 lines).
Hunk #22 succeeded at 3506 (offset 17 lines).
Hunk #23 succeeded at 3547 (offset 17 lines).
Hunk #24 succeeded at 3697 (offset 17 lines).
copying file alsa-kernel/core/control.c
patching file control.c
Hunk #3 succeeded at 719 (offset 1 line).
Hunk #4 succeeded at 786 (offset 1 line).
Hunk #5 succeeded at 1394 (offset 1 line).
copying file alsa-kernel/core/hwdep.c
patching file hwdep.c
copying file alsa-kernel/core/init.c
patching file init.c
Hunk #2 succeeded at 264 (offset 41 lines).
Hunk #3 succeeded at 290 with fuzz 2 (offset 41 lines).
copying file alsa-kernel/core/rawmidi.c
patching file rawmidi.c
Hunk #2 succeeded at 1289 (offset -1 lines).
Hunk #3 succeeded at 1373 (offset -1 lines).
copying file alsa-kernel/core/sound.c
patching file sound.c
copying file alsa-kernel/core/timer.c
patching file timer.c
Hunk #2 succeeded at 992 (offset 6 lines).
Hunk #3 succeeded at 1914 (offset 19 lines).
Hunk #4 succeeded at 1959 (offset 19 lines).
copying file alsa-kernel/core/memalloc.c
patching file memalloc.c
copying file alsa-kernel/core/misc.c
patching file misc.c
Hunk #2 succeeded at 30 (offset -1 lines).
Hunk #3 succeeded at 96 (offset -1 lines).
make[2]: Entering directory `/usr/src/alsa-driver/acore/ioctl32'
make[2]: Leaving directory `/usr/src/alsa-driver/acore/ioctl32'
make[2]: Entering directory `/usr/src/alsa-driver/acore/oss'
copying file alsa-kernel/core/oss/mixer_oss.c
patching file mixer_oss.c
copying file alsa-kernel/core/oss/pcm_oss.c
patching file pcm_oss.c
Hunk #2 succeeded at 2590 (offset 33 lines).
Hunk #3 succeeded at 2641 (offset 33 lines).
Hunk #4 succeeded at 2764 (offset 33 lines).
Hunk #5 succeeded at 2947 (offset 33 lines).
Hunk #6 succeeded at 3074 (offset 33 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/acore/oss'
make[2]: Entering directory `/usr/src/alsa-driver/acore/seq'
copying file alsa-kernel/core/seq/seq.c
patching file seq.c
Hunk #1 succeeded at 57 (offset 6 lines).
copying file alsa-kernel/core/seq/seq_clientmgr.c
patching file seq_clientmgr.c
Hunk #3 succeeded at 2205 (offset -1 lines).
Hunk #4 succeeded at 2553 (offset -1 lines).
copying file alsa-kernel/core/seq/seq_memory.c
patching file seq_memory.c
Hunk #3 succeeded at 248 (offset 3 lines).
make[3]: Entering directory `/usr/src/alsa-driver/acore/seq/oss'
copying file alsa-kernel/core/seq/oss/seq_oss.c
patching file seq_oss.c
make[3]: Leaving directory `/usr/src/alsa-driver/acore/seq/oss'
make[2]: Leaving directory `/usr/src/alsa-driver/acore/seq'
make[1]: Leaving directory `/usr/src/alsa-driver/acore'
make[1]: Entering directory `/usr/src/alsa-driver/i2c'
make[2]: Entering directory `/usr/src/alsa-driver/i2c/l3'
make[2]: Leaving directory `/usr/src/alsa-driver/i2c/l3'
make[2]: Entering directory `/usr/src/alsa-driver/i2c/other'
copying file alsa-kernel/i2c/other/tea575x-tuner.c
patching file tea575x-tuner.c
make[2]: Leaving directory `/usr/src/alsa-driver/i2c/other'
make[1]: Leaving directory `/usr/src/alsa-driver/i2c'
make[1]: Entering directory `/usr/src/alsa-driver/drivers'
copying file alsa-kernel/drivers/mts64.c
patching file mts64.c
Hunk #1 succeeded at 834 (offset 4 lines).
Hunk #2 succeeded at 1093 (offset 6 lines).
copying file alsa-kernel/drivers/portman2x4.c
patching file portman2x4.c
Hunk #2 succeeded at 882 (offset 2 lines).
make[2]: Entering directory `/usr/src/alsa-driver/drivers/mpu401'
copying file alsa-kernel/drivers/mpu401/mpu401.c
patching file mpu401.c
make[2]: Leaving directory `/usr/src/alsa-driver/drivers/mpu401'
make[2]: Entering directory `/usr/src/alsa-driver/drivers/opl3'
copying file alsa-kernel/drivers/opl3/opl3_lib.c
patching file opl3_lib.c
Hunk #1 succeeded at 435 (offset 2 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/drivers/opl3'
make[2]: Entering directory `/usr/src/alsa-driver/drivers/opl4'
make[2]: Leaving directory `/usr/src/alsa-driver/drivers/opl4'
make[2]: Entering directory `/usr/src/alsa-driver/drivers/pcsp'
make[2]: Leaving directory `/usr/src/alsa-driver/drivers/pcsp'
make[2]: Entering directory `/usr/src/alsa-driver/drivers/vx'
make[2]: Leaving directory `/usr/src/alsa-driver/drivers/vx'
make[1]: Leaving directory `/usr/src/alsa-driver/drivers'
make[1]: Entering directory `/usr/src/alsa-driver/isa'
make[2]: Entering directory `/usr/src/alsa-driver/isa/ad1816a'
make[2]: Leaving directory `/usr/src/alsa-driver/isa/ad1816a'
make[2]: Entering directory `/usr/src/alsa-driver/isa/ad1848'
make[2]: Leaving directory `/usr/src/alsa-driver/isa/ad1848'
make[2]: Entering directory `/usr/src/alsa-driver/isa/cs423x'
make[2]: Leaving directory `/usr/src/alsa-driver/isa/cs423x'
make[2]: Entering directory `/usr/src/alsa-driver/isa/es1688'
make[2]: Leaving directory `/usr/src/alsa-driver/isa/es1688'
make[2]: Entering directory `/usr/src/alsa-driver/isa/gus'
make[2]: Leaving directory `/usr/src/alsa-driver/isa/gus'
make[2]: Entering directory `/usr/src/alsa-driver/isa/msnd'
make[2]: Leaving directory `/usr/src/alsa-driver/isa/msnd'
make[2]: Entering directory `/usr/src/alsa-driver/isa/opti9xx'
make[2]: Leaving directory `/usr/src/alsa-driver/isa/opti9xx'
make[2]: Entering directory `/usr/src/alsa-driver/isa/sb'
copying file alsa-kernel/isa/sb/sb16_csp.c
patching file sb16_csp.c
Hunk #1 succeeded at 730 (offset 7 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/isa/sb'
make[2]: Entering directory `/usr/src/alsa-driver/isa/wavefront'
copying file alsa-kernel/isa/wavefront/wavefront_fx.c
patching file wavefront_fx.c
copying file alsa-kernel/isa/wavefront/wavefront_synth.c
patching file wavefront_synth.c
make[2]: Leaving directory `/usr/src/alsa-driver/isa/wavefront'
make[1]: Leaving directory `/usr/src/alsa-driver/isa'
make[1]: Entering directory `/usr/src/alsa-driver/synth'
make[2]: Entering directory `/usr/src/alsa-driver/synth/emux'
make[2]: Leaving directory `/usr/src/alsa-driver/synth/emux'
make[1]: Leaving directory `/usr/src/alsa-driver/synth'
make[1]: Entering directory `/usr/src/alsa-driver/pci'
copying file alsa-kernel/pci/ad1889.c
patching file ad1889.c
Hunk #1 succeeded at 53 with fuzz 2 (offset 1 line).
copying file alsa-kernel/pci/atiixp.c
patching file atiixp.c
copying file alsa-kernel/pci/atiixp_modem.c
patching file atiixp_modem.c
copying file alsa-kernel/pci/bt87x.c
patching file bt87x.c
copying file alsa-kernel/pci/cmipci.c
patching file cmipci.c
Hunk #1 succeeded at 3132 (offset 197 lines).
Hunk #2 succeeded at 3427 (offset 209 lines).
copying file alsa-kernel/pci/ens1370.c
patching file ens1370.c
Hunk #1 succeeded at 2118 (offset -32 lines).
Hunk #2 succeeded at 2494 (offset -32 lines).
copying file alsa-kernel/pci/fm801.c
patching file fm801.c
copying file alsa-kernel/pci/intel8x0.c
patching file intel8x0.c
Hunk #2 succeeded at 704 (offset 3 lines).
Hunk #3 succeeded at 715 (offset 3 lines).
Hunk #4 succeeded at 3093 (offset 82 lines).
copying file alsa-kernel/pci/maestro3.c
patching file maestro3.c
Hunk #1 succeeded at 2747 (offset 1 line).
Hunk #2 succeeded at 2933 (offset 1 line).
copying file alsa-kernel/pci/via82xx.c
patching file via82xx.c
Hunk #1 succeeded at 2433 (offset -1 lines).
Hunk #2 succeeded at 2443 (offset -1 lines).
Hunk #3 succeeded at 2458 (offset -1 lines).
Hunk #4 succeeded at 2469 (offset -1 lines).
Hunk #5 succeeded at 2480 (offset -1 lines).
Hunk #6 succeeded at 2563 (offset -1 lines).
copying file alsa-kernel/pci/via82xx_modem.c
patching file via82xx_modem.c
make[2]: Entering directory `/usr/src/alsa-driver/pci/ac97'
copying file alsa-kernel/pci/ac97/ac97_codec.c
patching file ac97_codec.c
Hunk #2 succeeded at 1911 (offset 7 lines).
Hunk #3 succeeded at 1923 (offset 7 lines).
Hunk #4 succeeded at 1947 (offset 7 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/pci/ac97'
make[2]: Entering directory `/usr/src/alsa-driver/pci/ali5451'
copying file alsa-kernel/pci/ali5451/ali5451.c
patching file ali5451.c
Hunk #1 succeeded at 2209 (offset -8 lines).
Hunk #2 succeeded at 2379 (offset -8 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/pci/ali5451'
make[2]: Entering directory `/usr/src/alsa-driver/pci/asihpi'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/asihpi'
make[2]: Entering directory `/usr/src/alsa-driver/pci/au88x0'
copying file alsa-kernel/pci/au88x0/au88x0.c
patching file au88x0.c
Hunk #2 succeeded at 342 (offset 1 line).
make[2]: Leaving directory `/usr/src/alsa-driver/pci/au88x0'
make[2]: Entering directory `/usr/src/alsa-driver/pci/ca0106'
copying file alsa-kernel/pci/ca0106/ca0106_main.c
patching file ca0106_main.c
Hunk #1 succeeded at 169 (offset 4 lines).
Hunk #2 succeeded at 1361 (offset 44 lines).
Hunk #3 succeeded at 1730 (offset 49 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/pci/ca0106'
make[2]: Entering directory `/usr/src/alsa-driver/pci/cs46xx'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/cs46xx'
make[2]: Entering directory `/usr/src/alsa-driver/pci/cs5535audio'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/cs5535audio'
make[2]: Entering directory `/usr/src/alsa-driver/pci/echoaudio'
copying file alsa-kernel/pci/echoaudio/echoaudio.c
patching file echoaudio.c
Hunk #1 succeeded at 1897 (offset -29 lines).
Hunk #2 succeeded at 1960 (offset -29 lines).
copying file alsa-kernel/pci/echoaudio/darla20.c
patching file darla20.c
Hunk #2 succeeded at 107 (offset 2 lines).
copying file alsa-kernel/pci/echoaudio/darla24.c
patching file darla24.c
Hunk #2 succeeded at 114 (offset 2 lines).
copying file alsa-kernel/pci/echoaudio/echo3g.c
patching file echo3g.c
Hunk #2 succeeded at 128 (offset 4 lines).
copying file alsa-kernel/pci/echoaudio/gina20.c
patching file gina20.c
Hunk #2 succeeded at 111 (offset 2 lines).
copying file alsa-kernel/pci/echoaudio/gina24.c
patching file gina24.c
Hunk #2 succeeded at 135 (offset 6 lines).
copying file alsa-kernel/pci/echoaudio/indigo.c
patching file indigo.c
Hunk #2 succeeded at 113 (offset 3 lines).
copying file alsa-kernel/pci/echoaudio/indigodj.c
patching file indigodj.c
Hunk #2 succeeded at 113 (offset 3 lines).
copying file alsa-kernel/pci/echoaudio/indigoio.c
patching file indigoio.c
Hunk #2 succeeded at 114 (offset 3 lines).
copying file alsa-kernel/pci/echoaudio/layla20.c
patching file layla20.c
Hunk #2 succeeded at 121 (offset 3 lines).
copying file alsa-kernel/pci/echoaudio/layla24.c
patching file layla24.c
Hunk #2 succeeded at 133 (offset 6 lines).
copying file alsa-kernel/pci/echoaudio/mia.c
patching file mia.c
Hunk #2 succeeded at 126 (offset 3 lines).
copying file alsa-kernel/pci/echoaudio/mona.c
patching file mona.c
Hunk #2 succeeded at 144 (offset 9 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/pci/echoaudio'
make[2]: Entering directory `/usr/src/alsa-driver/pci/emu10k1'
copying file alsa-kernel/pci/emu10k1/emu10k1_main.c
patching file emu10k1_main.c
Hunk #4 succeeded at 1399 (offset 35 lines).
Hunk #5 succeeded at 1432 (offset 35 lines).
Hunk #6 succeeded at 1740 (offset 37 lines).
copying file alsa-kernel/pci/emu10k1/emu10k1x.c
patching file emu10k1x.c
Hunk #2 succeeded at 1630 (offset -5 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/pci/emu10k1'
make[2]: Entering directory `/usr/src/alsa-driver/pci/hda'
copying file alsa-kernel/pci/hda/hda_codec.c
patching file hda_codec.c
Hunk #2 succeeded at 279 (offset 22 lines).
Hunk #3 succeeded at 317 (offset 22 lines).
Hunk #4 succeeded at 332 (offset 22 lines).
Hunk #5 succeeded at 348 (offset 22 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/pci/hda'
make[2]: Entering directory `/usr/src/alsa-driver/pci/ice1712'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/ice1712'
make[2]: Entering directory `/usr/src/alsa-driver/pci/korg1212'
copying file alsa-kernel/pci/korg1212/korg1212.c
patching file korg1212.c
Hunk #1 succeeded at 2353 (offset 10 lines).
Hunk #2 succeeded at 2514 (offset 10 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/pci/korg1212'
make[2]: Entering directory `/usr/src/alsa-driver/pci/mixart'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/mixart'
make[2]: Entering directory `/usr/src/alsa-driver/pci/nm256'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/nm256'
make[2]: Entering directory `/usr/src/alsa-driver/pci/oxygen'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/oxygen'
make[2]: Entering directory `/usr/src/alsa-driver/pci/pcxhr'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/pcxhr'
make[2]: Entering directory `/usr/src/alsa-driver/pci/pdplus'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/pdplus'
make[2]: Entering directory `/usr/src/alsa-driver/pci/riptide'
copying file alsa-kernel/pci/riptide/riptide.c
patching file riptide.c
Hunk #1 succeeded at 1279 (offset 10 lines).
Hunk #2 succeeded at 2236 (offset 10 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/pci/riptide'
make[2]: Entering directory `/usr/src/alsa-driver/pci/rme9652'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/rme9652'
make[2]: Entering directory `/usr/src/alsa-driver/pci/trident'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/trident'
make[2]: Entering directory `/usr/src/alsa-driver/pci/vx222'
make[2]: Leaving directory `/usr/src/alsa-driver/pci/vx222'
make[2]: Entering directory `/usr/src/alsa-driver/pci/ymfpci'
copying file alsa-kernel/pci/ymfpci/ymfpci_main.c
patching file ymfpci_main.c
Hunk #2 succeeded at 2049 (offset -4 lines).
Hunk #3 succeeded at 2071 (offset -4 lines).
Hunk #4 succeeded at 2411 (offset -4 lines).
make[2]: Leaving directory `/usr/src/alsa-driver/pci/ymfpci'
make[1]: Leaving directory `/usr/src/alsa-driver/pci'
make[1]: Entering directory `/usr/src/alsa-driver/aoa'
make[2]: Entering directory `/usr/src/alsa-driver/aoa/codecs'
make[2]: Leaving directory `/usr/src/alsa-driver/aoa/codecs'
make[2]: Entering directory `/usr/src/alsa-driver/aoa/core'
make[2]: Leaving directory `/usr/src/alsa-driver/aoa/core'
make[2]: Entering directory `/usr/src/alsa-driver/aoa/fabrics'
make[2]: Leaving directory `/usr/src/alsa-driver/aoa/fabrics'
make[2]: Entering directory `/usr/src/alsa-driver/aoa/soundbus'
make[3]: Entering directory `/usr/src/alsa-driver/aoa/soundbus/i2sbus'
make[3]: Leaving directory `/usr/src/alsa-driver/aoa/soundbus/i2sbus'
make[2]: Leaving directory `/usr/src/alsa-driver/aoa/soundbus'
make[1]: Leaving directory `/usr/src/alsa-driver/aoa'
make[1]: Entering directory `/usr/src/alsa-driver/soc'
make[2]: Entering directory `/usr/src/alsa-driver/soc/at91'
make[2]: Leaving directory `/usr/src/alsa-driver/soc/at91'
make[2]: Entering directory `/usr/src/alsa-driver/soc/codecs'
make[2]: Leaving directory `/usr/src/alsa-driver/soc/codecs'
make[2]: Entering directory `/usr/src/alsa-driver/soc/pxa'
make[2]: Leaving directory `/usr/src/alsa-driver/soc/pxa'
make[2]: Entering directory `/usr/src/alsa-driver/soc/s3c24xx'
make[2]: Leaving directory `/usr/src/alsa-driver/soc/s3c24xx'
make[2]: Entering directory `/usr/src/alsa-driver/soc/sh'
make[2]: Leaving directory `/usr/src/alsa-driver/soc/sh'
make[1]: Leaving directory `/usr/src/alsa-driver/soc'
make[1]: Entering directory `/usr/src/alsa-driver/usb'
copying file alsa-kernel/usb/usbaudio.c
patching file usbaudio.c
Hunk #3 succeeded at 659 with fuzz 2 (offset -10 lines).
Hunk #4 succeeded at 686 with fuzz 2 (offset -10 lines).
Hunk #5 succeeded at 767 (offset -10 lines).
Hunk #6 succeeded at 782 (offset -10 lines).
Hunk #7 succeeded at 1160 (offset -10 lines).
Hunk #8 succeeded at 2082 (offset 3 lines).
Hunk #9 succeeded at 2101 (offset 3 lines).
Hunk #10 succeeded at 2118 (offset 3 lines).
Hunk #11 succeeded at 2675 (offset 13 lines).
Hunk #12 succeeded at 2747 (offset 13 lines).
Hunk #13 succeeded at 3035 (offset 17 lines).
Hunk #14 succeeded at 3106 (offset 17 lines).
Hunk #15 succeeded at 3227 (offset 69 lines).
Hunk #16 succeeded at 3245 (offset 69 lines).
Hunk #17 succeeded at 3259 (offset 69 lines).
Hunk #18 succeeded at 3272 (offset 69 lines).
Hunk #19 succeeded at 3476 (offset 77 lines).
Hunk #20 succeeded at 3569 (offset 79 lines).
Hunk #21 succeeded at 3706 (offset 78 lines).
Hunk #22 succeeded at 3727 (offset 78 lines).
Hunk #23 succeeded at 3748 (offset 78 lines).
copying file alsa-kernel/usb/usbmidi.c
patching file usbmidi.c
Hunk #2 succeeded at 226 (offset 1 line).
Hunk #3 succeeded at 250 (offset 1 line).
Hunk #4 succeeded at 343 (offset 1 line).
Hunk #5 succeeded at 1450 (offset 88 lines).
Hunk #6 succeeded at 1798 (offset 92 lines).
copying file alsa-kernel/usb/usbmixer.c
patching file usbmixer.c
Hunk #3 succeeded at 1730 (offset 4 lines).
Hunk #4 succeeded at 1779 (offset 4 lines).
Hunk #5 succeeded at 1800 (offset 4 lines).
make[2]: Entering directory `/usr/src/alsa-driver/usb/caiaq'
copying file alsa-kernel/usb/caiaq/caiaq-audio.c
patching file caiaq-audio.c
Hunk #1 succeeded at 462 (offset -2 lines).
Hunk #2 succeeded at 520 (offset -2 lines).
copying file alsa-kernel/usb/caiaq/caiaq-device.c
patching file caiaq-device.c
Hunk #1 succeeded at 114 (offset 14 lines).
Hunk #2 succeeded at 364 (offset 65 lines).
copying file alsa-kernel/usb/caiaq/caiaq-input.c
patching file caiaq-input.c
make[2]: Leaving directory `/usr/src/alsa-driver/usb/caiaq'
make[2]: Entering directory `/usr/src/alsa-driver/usb/usx2y'
copying file alsa-kernel/usb/usx2y/usX2Yhwdep.c
patching file usX2Yhwdep.c
copying file alsa-kernel/usb/usx2y/usbusx2y.c
patching file usbusx2y.c
copying file alsa-kernel/usb/usx2y/usbusx2yaudio.c
patching file usbusx2yaudio.c
Hunk #10 succeeded at 1057 (offset -1 lines).
copying file alsa-kernel/usb/usx2y/usx2yhwdeppcm.c
patching file usx2yhwdeppcm.c
make[2]: Leaving directory `/usr/src/alsa-driver/usb/usx2y'
make[1]: Leaving directory `/usr/src/alsa-driver/usb'
make[1]: Entering directory `/usr/src/alsa-driver/pcmcia'
make[2]: Entering directory `/usr/src/alsa-driver/pcmcia/pdaudiocf'
make[2]: Leaving directory `/usr/src/alsa-driver/pcmcia/pdaudiocf'
make[2]: Entering directory `/usr/src/alsa-driver/pcmcia/vx'
make[2]: Leaving directory `/usr/src/alsa-driver/pcmcia/vx'
make[1]: Leaving directory `/usr/src/alsa-driver/pcmcia'
make[1]: Entering directory `/usr/src/alsa-driver/misc'
make[1]: Leaving directory `/usr/src/alsa-driver/misc'
make dep
make[1]: Entering directory `/usr/src/alsa-driver'
make[2]: Entering directory `/usr/src/alsa-driver/acore'
make[3]: Entering directory `/usr/src/alsa-driver/acore/ioctl32'
make[3]: Leaving directory `/usr/src/alsa-driver/acore/ioctl32'
make[3]: Entering directory `/usr/src/alsa-driver/acore/oss'
make[3]: Leaving directory `/usr/src/alsa-driver/acore/oss'
make[3]: Entering directory `/usr/src/alsa-driver/acore/seq'
make[4]: Entering directory `/usr/src/alsa-driver/acore/seq/oss'
make[4]: Leaving directory `/usr/src/alsa-driver/acore/seq/oss'
make[3]: Leaving directory `/usr/src/alsa-driver/acore/seq'
make[2]: Leaving directory `/usr/src/alsa-driver/acore'
make[2]: Entering directory `/usr/src/alsa-driver/i2c'
make[3]: Entering directory `/usr/src/alsa-driver/i2c/l3'
make[3]: Leaving directory `/usr/src/alsa-driver/i2c/l3'
make[3]: Entering directory `/usr/src/alsa-driver/i2c/other'
make[3]: Leaving directory `/usr/src/alsa-driver/i2c/other'
make[2]: Leaving directory `/usr/src/alsa-driver/i2c'
make[2]: Entering directory `/usr/src/alsa-driver/drivers'
make[3]: Entering directory `/usr/src/alsa-driver/drivers/mpu401'
make[3]: Leaving directory `/usr/src/alsa-driver/drivers/mpu401'
make[3]: Entering directory `/usr/src/alsa-driver/drivers/opl3'
make[3]: Leaving directory `/usr/src/alsa-driver/drivers/opl3'
make[3]: Entering directory `/usr/src/alsa-driver/drivers/opl4'
make[3]: Leaving directory `/usr/src/alsa-driver/drivers/opl4'
make[3]: Entering directory `/usr/src/alsa-driver/drivers/pcsp'
make[3]: Leaving directory `/usr/src/alsa-driver/drivers/pcsp'
make[3]: Entering directory `/usr/src/alsa-driver/drivers/vx'
make[3]: Leaving directory `/usr/src/alsa-driver/drivers/vx'
make[2]: Leaving directory `/usr/src/alsa-driver/drivers'
make[2]: Entering directory `/usr/src/alsa-driver/isa'
make[3]: Entering directory `/usr/src/alsa-driver/isa/ad1816a'
make[3]: Leaving directory `/usr/src/alsa-driver/isa/ad1816a'
make[3]: Entering directory `/usr/src/alsa-driver/isa/ad1848'
make[3]: Leaving directory `/usr/src/alsa-driver/isa/ad1848'
make[3]: Entering directory `/usr/src/alsa-driver/isa/cs423x'
make[3]: Leaving directory `/usr/src/alsa-driver/isa/cs423x'
make[3]: Entering directory `/usr/src/alsa-driver/isa/es1688'
make[3]: Leaving directory `/usr/src/alsa-driver/isa/es1688'
make[3]: Entering directory `/usr/src/alsa-driver/isa/gus'
make[3]: Leaving directory `/usr/src/alsa-driver/isa/gus'
make[3]: Entering directory `/usr/src/alsa-driver/isa/msnd'
make[3]: Leaving directory `/usr/src/alsa-driver/isa/msnd'
make[3]: Entering directory `/usr/src/alsa-driver/isa/opti9xx'
make[3]: Leaving directory `/usr/src/alsa-driver/isa/opti9xx'
make[3]: Entering directory `/usr/src/alsa-driver/isa/sb'
make[3]: Leaving directory `/usr/src/alsa-driver/isa/sb'
make[3]: Entering directory `/usr/src/alsa-driver/isa/wavefront'
make[3]: Leaving directory `/usr/src/alsa-driver/isa/wavefront'
make[2]: Leaving directory `/usr/src/alsa-driver/isa'
make[2]: Entering directory `/usr/src/alsa-driver/synth'
make[3]: Entering directory `/usr/src/alsa-driver/synth/emux'
make[3]: Leaving directory `/usr/src/alsa-driver/synth/emux'
make[2]: Leaving directory `/usr/src/alsa-driver/synth'
make[2]: Entering directory `/usr/src/alsa-driver/pci'
make[3]: Entering directory `/usr/src/alsa-driver/pci/ac97'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/ac97'
make[3]: Entering directory `/usr/src/alsa-driver/pci/ali5451'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/ali5451'
make[3]: Entering directory `/usr/src/alsa-driver/pci/asihpi'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/asihpi'
make[3]: Entering directory `/usr/src/alsa-driver/pci/au88x0'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/au88x0'
make[3]: Entering directory `/usr/src/alsa-driver/pci/ca0106'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/ca0106'
make[3]: Entering directory `/usr/src/alsa-driver/pci/cs46xx'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/cs46xx'
make[3]: Entering directory `/usr/src/alsa-driver/pci/cs5535audio'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/cs5535audio'
make[3]: Entering directory `/usr/src/alsa-driver/pci/echoaudio'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/echoaudio'
make[3]: Entering directory `/usr/src/alsa-driver/pci/emu10k1'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/emu10k1'
make[3]: Entering directory `/usr/src/alsa-driver/pci/hda'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/hda'
make[3]: Entering directory `/usr/src/alsa-driver/pci/ice1712'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/ice1712'
make[3]: Entering directory `/usr/src/alsa-driver/pci/korg1212'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/korg1212'
make[3]: Entering directory `/usr/src/alsa-driver/pci/mixart'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/mixart'
make[3]: Entering directory `/usr/src/alsa-driver/pci/nm256'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/nm256'
make[3]: Entering directory `/usr/src/alsa-driver/pci/oxygen'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/oxygen'
make[3]: Entering directory `/usr/src/alsa-driver/pci/pcxhr'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/pcxhr'
make[3]: Entering directory `/usr/src/alsa-driver/pci/pdplus'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/pdplus'
make[3]: Entering directory `/usr/src/alsa-driver/pci/riptide'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/riptide'
make[3]: Entering directory `/usr/src/alsa-driver/pci/rme9652'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/rme9652'
make[3]: Entering directory `/usr/src/alsa-driver/pci/trident'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/trident'
make[3]: Entering directory `/usr/src/alsa-driver/pci/vx222'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/vx222'
make[3]: Entering directory `/usr/src/alsa-driver/pci/ymfpci'
make[3]: Leaving directory `/usr/src/alsa-driver/pci/ymfpci'
make[2]: Leaving directory `/usr/src/alsa-driver/pci'
make[2]: Entering directory `/usr/src/alsa-driver/aoa'
make[3]: Entering directory `/usr/src/alsa-driver/aoa/codecs'
make[3]: Leaving directory `/usr/src/alsa-driver/aoa/codecs'
make[3]: Entering directory `/usr/src/alsa-driver/aoa/core'
make[3]: Leaving directory `/usr/src/alsa-driver/aoa/core'
make[3]: Entering directory `/usr/src/alsa-driver/aoa/fabrics'
make[3]: Leaving directory `/usr/src/alsa-driver/aoa/fabrics'
make[3]: Entering directory `/usr/src/alsa-driver/aoa/soundbus'
make[4]: Entering directory `/usr/src/alsa-driver/aoa/soundbus/i2sbus'
make[4]: Leaving directory `/usr/src/alsa-driver/aoa/soundbus/i2sbus'
make[3]: Leaving directory `/usr/src/alsa-driver/aoa/soundbus'
make[2]: Leaving directory `/usr/src/alsa-driver/aoa'
make[2]: Entering directory `/usr/src/alsa-driver/soc'
make[3]: Entering directory `/usr/src/alsa-driver/soc/at91'
make[3]: Leaving directory `/usr/src/alsa-driver/soc/at91'
make[3]: Entering directory `/usr/src/alsa-driver/soc/codecs'
make[3]: Leaving directory `/usr/src/alsa-driver/soc/codecs'
make[3]: Entering directory `/usr/src/alsa-driver/soc/pxa'
make[3]: Leaving directory `/usr/src/alsa-driver/soc/pxa'
make[3]: Entering directory `/usr/src/alsa-driver/soc/s3c24xx'
make[3]: Leaving directory `/usr/src/alsa-driver/soc/s3c24xx'
make[3]: Entering directory `/usr/src/alsa-driver/soc/sh'
make[3]: Leaving directory `/usr/src/alsa-driver/soc/sh'
make[2]: Leaving directory `/usr/src/alsa-driver/soc'
make[2]: Entering directory `/usr/src/alsa-driver/usb'
make[3]: Entering directory `/usr/src/alsa-driver/usb/caiaq'
make[3]: Leaving directory `/usr/src/alsa-driver/usb/caiaq'
make[3]: Entering directory `/usr/src/alsa-driver/usb/usx2y'
make[3]: Leaving directory `/usr/src/alsa-driver/usb/usx2y'
make[2]: Leaving directory `/usr/src/alsa-driver/usb'
make[2]: Entering directory `/usr/src/alsa-driver/pcmcia'
make[3]: Entering directory `/usr/src/alsa-driver/pcmcia/pdaudiocf'
make[3]: Leaving directory `/usr/src/alsa-driver/pcmcia/pdaudiocf'
make[3]: Entering directory `/usr/src/alsa-driver/pcmcia/vx'
make[3]: Leaving directory `/usr/src/alsa-driver/pcmcia/vx'
make[2]: Leaving directory `/usr/src/alsa-driver/pcmcia'
make[2]: Entering directory `/usr/src/alsa-driver/misc'
make[2]: Leaving directory `/usr/src/alsa-driver/misc'
make[1]: Leaving directory `/usr/src/alsa-driver'
make -C /lib/modules/2.6.23-gentoo-r3/source SUBDIRS=/usr/src/alsa-driver  CPP="gcc -E" CC="gcc" modules
make[1]: Entering directory `/usr/src/linux-2.6.23-gentoo-r3'
  CC [M]  /usr/src/alsa-driver/acore/hwdep.o
In file included from /usr/src/alsa-driver/include/adriver.h:930,
                 from /usr/src/alsa-driver/include/sound/driver.h:42,
                 from /usr/src/alsa-driver/acore/hwdep.c:22:
include/linux/pci.h:556: error: expected identifier or '(' before numeric constant
In file included from /usr/src/alsa-driver/include/sound/driver.h:42,
                 from /usr/src/alsa-driver/acore/hwdep.c:22:
/usr/src/alsa-driver/include/adriver.h: In function 'snd_pci_orig_save_state':
/usr/src/alsa-driver/include/adriver.h:1172: error: too many arguments to function 'pci_save_state'
/usr/src/alsa-driver/include/adriver.h: In function 'snd_pci_orig_restore_state':
/usr/src/alsa-driver/include/adriver.h:1176: error: too many arguments to function 'pci_restore_state'
make[3]: *** [/usr/src/alsa-driver/acore/hwdep.o] Error 1
make[2]: *** [/usr/src/alsa-driver/acore] Error 2
make[1]: *** [_module_/usr/src/alsa-driver] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.23-gentoo-r3'
make: *** [compile] Error 2
