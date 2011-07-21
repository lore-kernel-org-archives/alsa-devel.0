From: Georges Jahchan <gjahchan@compucenter.org>
Subject: Alsa Driver Compilation Problem Report.
Date: Thu, 21 Jul 2011 20:09:09 +0300
Message-ID: <1311268149.621.5.camel@fc13.compucenter.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Lxs/HVdC3nX+gp4v4eMM"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 73D67103823
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jul 2011 19:09:15 +0200 (CEST)
Received: by wyh21 with SMTP id 21so1074029wyh.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2011 10:09:14 -0700 (PDT)
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


--=-Lxs/HVdC3nX+gp4v4eMM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Attached is the ALSA driver compile script log on Fedora Core 13 x86_64
on an HP Pavilion DV7-1223CA with AMD Turion X2 64-bit CPU, ATI HDMI
Audio and Intel PCI Audio.

uname -a
Linux hostname 2.6.34.9-69.fc13.x86_64 #1 SMP Tue May 3 09:23:03 UTC
2011 x86_64 x86_64 x86_64 GNU/Linux

--=-Lxs/HVdC3nX+gp4v4eMM
Content-Disposition: attachment; filename="Compilation Fail Log.txt"
Content-Type: text/plain; name="Compilation Fail Log.txt"; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

$ wg -O alsa-compile.sh http://www.alsa-project.org/alsa-compile.sh
WARNING: timestamping does nothing in combination with -O. See the manual
for details.

--2011-07-21 19:47:52--  http://www.alsa-project.org/alsa-compile.sh
Resolving localhost... 127.0.0.1
Connecting to localhost|127.0.0.1|:8181... connected.
Proxy request sent, awaiting response... 302 Moved Temporarily
Location: http://git.alsa-project.org/?p=3Dalsa-driver.git;a=3Dblob_plain=
;f=3Dutils/alsa-compile.sh [following]
--2011-07-21 19:47:56--  http://git.alsa-project.org/?p=3Dalsa-driver.git=
;a=3Dblob_plain;f=3Dutils/alsa-compile.sh
Connecting to localhost|127.0.0.1|:8181... connected.
Proxy request sent, awaiting response... 200 OK
Length: 31359 (31K) [text/plain]
Saving to: =E2=80=9Calsa-compile.sh=E2=80=9D

100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>] 31,359      36.7K/s   in 0.8s   =20

2011-07-21 19:48:00 (36.7 KB/s) - =E2=80=9Calsa-compile.sh=E2=80=9D saved=
 [31359/31359]

$ chmod 755 alsa-compile.sh
$ sudo ./alsa-compile.sh --driver --kmodules
[sudo] password for xxxxxxxx:=20
Using temporary tree /tmp/alsa-compile-script.
Detected Linux distribution 'Fedora 13'.
File environment.base has been created.
> cd /tmp/alsa-compile-script
Program git found.
Program autoconf found.
Program aclocal found.
Program gcc found.
Program patch found.
Program diff found.
Program make found.
Checking kernel build environment:
  passed
File environment.compile has been created.
Downloading 'http://www.alsa-project.org/snapshot/?package=3Dalsa-driver'=
:
> wget -q -O snapshot.tar.bz2 http://www.alsa-project.org/snapshot/?packa=
ge=3Dalsa-driver
  success (3764272 bytes)
> tar xjf snapshot.tar.bz2
Sources unpacked to alsa-driver-1.0.24.47.gfa552.1132.g89a70
> cd alsa-driver-1.0.24.47.gfa552.1132.g89a70
Running ./gitcompile --with-debug=3Dfull --with-isapnp=3Dyes --with-seque=
ncer=3Dyes --with-moddir=3Dupdates/alsa:
make: Nothing to be done for `all-deps'.
./configure --with-debug=3Dfull --with-isapnp=3Dyes --with-sequencer=3Dye=
s --with-moddir=3Dupdates/alsa
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...=20
checking whether we are cross compiling... no
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
checking for current directory... /tmp/alsa-compile-script/alsa-driver-1.=
0.24.47.gfa552.1132.g89a70
checking cross compile...=20
checking for directory with ALSA kernel sources... /tmp/alsa-compile-scri=
pt/alsa-driver-1.0.24.47.gfa552.1132.g89a70/alsa-kernel
checking for directory with kernel source... /lib/modules/2.6.34.9-69.fc1=
3.x86_64/source
checking for directory with kernel build... /lib/modules/2.6.34.9-69.fc13=
.x86_64/build
checking for kernel linux/version.h ... linux/version.h
checking for kernel linux/autoconf.h generated/autoconf.h... generated/au=
toconf.h
checking for kernel linux/utsrelease.h generated/utsrelease.h... generate=
d/utsrelease.h
checking for kernel version... 2.6.34.9-69.fc13.x86_64
checking for GCC version... Kernel compiler:  Used compiler: gcc (GCC) 4.=
4.5 20101112 (Red Hat 4.4.5-2)

*** NO PREDEFINED KERNEL COMPILER IS DETECTED
*** Assuming the same compiler is used with the current system compiler.

*** Please make sure that the same compiler version was used for building=
 kernel.

checking for built-in ALSA... no
checking for existing ALSA module... yes
checking for Red Hat kernel... auto
checking for Red Hat kernel... no
checking for SUSE kernel... auto
checking for SUSE kernel... no
checking for updating alsa-kernel version.h... yes
checking for CONFIG_EXPERIMENTAL... yes
checking for directory to store kernel modules... /lib/modules/2.6.34.9-6=
9.fc13.x86_64/updates/alsa
checking for verbose procfs... on
checking for verbose printk... on
checking for debug level... full
checking for ISA support in kernel... no
checking for processor type... x86_64
checking for 32bit compat support... yes
checking for kernel linux/config.h... no
Creating <linux/config.h>...
checking for deprecated linux/config.h... checking to modify of kernel li=
nux/kmod.h... no
checking for kernel linux/utsrelease.h... no
Creating a dummy <linux/utsrelease.h>...
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
checking for kernel linux/gfp.h... yes
checking for kernel pcmcia/cs_types.h... yes
checking for kernel pcmcia/cs.h... yes
checking for kernel linux/lzo.h... yes
checking for kernel linux/async.h... yes
checking for kernel linux/bitrev.h... yes
checking for kernel linux/smp_lock.h... yes
Creating a dummy <trace/events/asoc.h>...
checking for kernel module symbol versions... no
checking for has ioport support... yes
checking for PCI support in kernel... yes
checking for I2C driver in kernel... module
checking for I2C_POWERMAC in kernel... unknown
checking for firmware loader... yes
checking for input subsystem in kernel... yes
checking for pc-speaker platform in kernel... yes
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
checking for vzalloc... no
checking for old kmod... no
checking for PDE... yes
checking for pci_set_consistent_dma_mask... yes
checking for pci_dev_present... yes
checking for msleep... yes
checking for msleep_interrupt... yes
checking for msecs_to_jiffies... yes
checking for tty->count is the atomic type... yes
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
checking for driver extra-version...=20
checking for driver version... 1.0.24.47.gfa552.1132.g89a70
checking for dynamic minor numbers... no
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for OSS PCM plugin system inclusion... yes
checking for RTC support... no
checking for HPET support... yes
checking for Procfs support... yes
checking for USB support... yes
checking for kernel linux/usb/audio-v2.h... no
Creating <linux/usb/audio-v2.h>...
checking for kernel linux/usb/audio.h... yes
checking for valid v1 in linux/usb/audio.h... no
Creating <linux/usb/audio.h>...
checking for valid linux/usb/audio-v2.h... no
Creating <linux/usb/audio-v2.h>...
checking for kernel linux/usb/ch9.h... yes
checking usb_alloc_coherent... yes
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
checking for pm_qos_request... no
checking for static pm_qos_request... no
checking for new unlocked/compat_ioctl... yes
checking for builtin _Bool support... yes
checking for x86-compatible PC... no
checking for High-Res timers... yes
checking for kernel PCMCIA
checking for PCMCIA support... yes
checking for PC9800 support in kernel... no
checking for parallel port support... yes
checking for power management... yes
checking for CONFIG_HAS_DMA... yes
checking for FireWire support... yes
checking for cards to compile driver for... all
checking for additonal options to compile driver for... all
configure: creating ./config.status
config.status: creating version
config.status: creating Makefile.conf
config.status: WARNING:  'Makefile.conf.in' seems to ignore the --dataroo=
tdir setting
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
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/include'
make -C sound prepare
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/include/sound'
make .includes.tmp
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/include/sound'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/include/sound'
make prepare2
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/include/sound'
cp ../../alsa-kernel/include/ac97_codec.h .
patch -p0 -i ac97_codec.patch ac97_codec.h
patching file ac97_codec.h
Hunk #1 succeeded at 650 (offset 5 lines).
ln -s ../../alsa-kernel/include/aci.h
ln -s ../../alsa-kernel/include/ad1816a.h
ln -s ../../alsa-kernel/include/ad1843.h
ln -s ../../alsa-kernel/include/ak4113.h
ln -s ../../alsa-kernel/include/ak4114.h
ln -s ../../alsa-kernel/include/ak4117.h
ln -s ../../alsa-kernel/include/ak4531_codec.h
ln -s ../../alsa-kernel/include/ak4641.h
ln -s ../../alsa-kernel/include/ak4xxx-adda.h
ln -s ../../alsa-kernel/include/alc5623.h
ln -s ../../alsa-kernel/include/asequencer.h
ln -s ../../alsa-kernel/include/asound.h
ln -s ../../alsa-kernel/include/asound_fm.h
ln -s ../../alsa-kernel/include/asoundef.h
ln -s ../../alsa-kernel/include/atmel-abdac.h
ln -s ../../alsa-kernel/include/atmel-ac97c.h
cp ../../alsa-kernel/include/control.h .
patch -p0 -i control.patch control.h
patching file control.h
cp ../../alsa-kernel/include/core.h .
patch -p0 -i core.patch core.h
patching file core.h
ln -s ../../alsa-kernel/include/cs4231-regs.h
ln -s ../../alsa-kernel/include/cs4271.h
ln -s ../../alsa-kernel/include/cs46xx.h
ln -s ../../alsa-kernel/include/cs46xx_dsp_scb_types.h
ln -s ../../alsa-kernel/include/cs46xx_dsp_spos.h
ln -s ../../alsa-kernel/include/cs46xx_dsp_task_types.h
ln -s ../../alsa-kernel/include/cs8403.h
ln -s ../../alsa-kernel/include/cs8427.h
ln -s ../../alsa-kernel/include/emu10k1.h
ln -s ../../alsa-kernel/include/emu10k1_synth.h
ln -s ../../alsa-kernel/include/emu8000.h
ln -s ../../alsa-kernel/include/emu8000_reg.h
ln -s ../../alsa-kernel/include/emux_legacy.h
ln -s ../../alsa-kernel/include/emux_synth.h
ln -s ../../alsa-kernel/include/es1688.h
ln -s ../../alsa-kernel/include/gus.h
ln -s ../../alsa-kernel/include/hda_hwdep.h
ln -s ../../alsa-kernel/include/hdsp.h
ln -s ../../alsa-kernel/include/hdspm.h
ln -s ../../alsa-kernel/include/hwdep.h
ln -s ../../alsa-kernel/include/i2c.h
cp ../../alsa-kernel/include/info.h .
patch -p0 -i info.patch info.h
patching file info.h
ln -s ../../alsa-kernel/include/initval.h
ln -s ../../alsa-kernel/include/jack.h
ln -s ../../alsa-kernel/include/l3.h
ln -s ../../alsa-kernel/include/max98088.h
ln -s ../../alsa-kernel/include/max98095.h
ln -s ../../alsa-kernel/include/memalloc.h
ln -s ../../alsa-kernel/include/minors.h
ln -s ../../alsa-kernel/include/mixer_oss.h
ln -s ../../alsa-kernel/include/mpu401.h
ln -s ../../alsa-kernel/include/opl3.h
ln -s ../../alsa-kernel/include/opl4.h
ln -s ../../alsa-kernel/include/pcm-indirect.h
cp ../../alsa-kernel/include/pcm.h .
patch -p0 -i pcm.patch pcm.h
patching file pcm.h
cp ../../alsa-kernel/include/pcm_oss.h .
patch -p0 -i pcm_oss.patch pcm_oss.h
patching file pcm_oss.h
ln -s ../../alsa-kernel/include/pcm_params.h
ln -s ../../alsa-kernel/include/pt2258.h
ln -s ../../alsa-kernel/include/pxa2xx-lib.h
cp ../../alsa-kernel/include/rawmidi.h .
patch -p0 -i rawmidi.patch rawmidi.h
patching file rawmidi.h
Hunk #1 succeeded at 100 (offset 2 lines).
ln -s ../../alsa-kernel/include/s3c24xx_uda134x.h
ln -s ../../alsa-kernel/include/sb.h
ln -s ../../alsa-kernel/include/sb16_csp.h
ln -s ../../alsa-kernel/include/seq_device.h
ln -s ../../alsa-kernel/include/seq_kernel.h
ln -s ../../alsa-kernel/include/seq_midi_emul.h
ln -s ../../alsa-kernel/include/seq_midi_event.h
ln -s ../../alsa-kernel/include/seq_oss.h
ln -s ../../alsa-kernel/include/seq_oss_legacy.h
ln -s ../../alsa-kernel/include/seq_virmidi.h
ln -s ../../alsa-kernel/include/sfnt_info.h
ln -s ../../alsa-kernel/include/sh_dac_audio.h
ln -s ../../alsa-kernel/include/sh_fsi.h
ln -s ../../alsa-kernel/include/snd_wavefront.h
ln -s ../../alsa-kernel/include/soc-dai.h
ln -s ../../alsa-kernel/include/soc-dapm.h
ln -s ../../alsa-kernel/include/soc.h
ln -s ../../alsa-kernel/include/soundfont.h
ln -s ../../alsa-kernel/include/tea575x-tuner.h
ln -s ../../alsa-kernel/include/tea6330t.h
ln -s ../../alsa-kernel/include/timer.h
ln -s ../../alsa-kernel/include/tlv.h
ln -s ../../alsa-kernel/include/tlv320aic32x4.h
ln -s ../../alsa-kernel/include/tlv320aic3x.h
ln -s ../../alsa-kernel/include/tlv320dac33-plat.h
ln -s ../../alsa-kernel/include/tpa6130a2-plat.h
ln -s ../../alsa-kernel/include/trident.h
ln -s ../../alsa-kernel/include/uda134x.h
ln -s ../../alsa-kernel/include/uda1380.h
ln -s ../../alsa-kernel/include/util_mem.h
ln -s ../version.h
ln -s ../../alsa-kernel/include/vx_core.h
ln -s ../../alsa-kernel/include/wavefront.h
ln -s ../../alsa-kernel/include/wm2000.h
ln -s ../../alsa-kernel/include/wm8903.h
ln -s ../../alsa-kernel/include/wm8904.h
ln -s ../../alsa-kernel/include/wm8915.h
ln -s ../../alsa-kernel/include/wm8955.h
ln -s ../../alsa-kernel/include/wm8960.h
ln -s ../../alsa-kernel/include/wm8962.h
ln -s ../../alsa-kernel/include/wm8993.h
ln -s ../../alsa-kernel/include/wm9081.h
ln -s ../../alsa-kernel/include/wm9090.h
ln -s ../../alsa-kernel/include/wss.h
ln -s ../../alsa-kernel/include/ymfpci.h
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/include/sound'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/include/sound'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/include'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/acore'
copying file alsa-kernel/core/info.c
patching file info.c
Hunk #4 succeeded at 495 (offset 12 lines).
Hunk #5 succeeded at 535 (offset 12 lines).
Hunk #6 succeeded at 951 (offset 12 lines).
Hunk #7 succeeded at 991 (offset 12 lines).
Hunk #8 succeeded at 1025 (offset 12 lines).
copying file alsa-kernel/core/pcm.c
patching file pcm.c
Hunk #2 succeeded at 951 (offset 22 lines).
Hunk #3 succeeded at 967 (offset 22 lines).
Hunk #4 succeeded at 979 (offset 22 lines).
Hunk #5 succeeded at 1035 (offset 22 lines).
copying file alsa-kernel/core/pcm_native.c
patching file pcm_native.c
Hunk #7 succeeded at 1599 (offset 7 lines).
Hunk #8 succeeded at 2045 (offset 7 lines).
Hunk #9 succeeded at 2872 (offset 5 lines).
Hunk #10 succeeded at 2925 (offset 5 lines).
Hunk #11 succeeded at 2953 (offset 5 lines).
Hunk #12 succeeded at 2969 (offset 5 lines).
Hunk #13 succeeded at 2995 (offset 5 lines).
Hunk #14 succeeded at 3083 (offset 5 lines).
Hunk #15 succeeded at 3107 (offset 5 lines).
Hunk #16 succeeded at 3121 (offset 5 lines).
Hunk #17 succeeded at 3176 (offset 3 lines).
Hunk #18 succeeded at 3188 (offset 3 lines).
Hunk #19 succeeded at 3202 (offset 3 lines).
Hunk #20 succeeded at 3258 (offset 1 line).
Hunk #21 succeeded at 3303 (offset 1 line).
Hunk #22 succeeded at 3339 (offset 1 line).
Hunk #23 succeeded at 3401 (offset 1 line).
Hunk #24 succeeded at 3456 (offset 1 line).
Hunk #25 succeeded at 3510 (offset 1 line).
Hunk #26 succeeded at 3518 (offset 1 line).
Hunk #27 succeeded at 3545 (offset 1 line).
Hunk #28 succeeded at 3578 (offset 1 line).
Hunk #29 succeeded at 3744 (offset 1 line).
copying file alsa-kernel/core/pcm_memory.c
patching file pcm_memory.c
Hunk #2 succeeded at 452 (offset 1 line).
copying file alsa-kernel/core/control.c
patching file control.c
Hunk #3 succeeded at 847 (offset 112 lines).
Hunk #4 succeeded at 907 (offset 112 lines).
Hunk #5 succeeded at 1499 (offset 112 lines).
copying file alsa-kernel/core/hwdep.c
patching file hwdep.c
Hunk #3 succeeded at 308 (offset 1 line).
copying file alsa-kernel/core/init.c
patching file init.c
Hunk #4 succeeded at 408 (offset -3 lines).
Hunk #5 succeeded at 586 (offset -3 lines).
Hunk #6 succeeded at 648 (offset -3 lines).
Hunk #7 succeeded at 667 (offset -3 lines).
Hunk #8 succeeded at 704 (offset -3 lines).
Hunk #9 succeeded at 713 (offset -3 lines).
Hunk #10 succeeded at 979 (offset 1 line).
copying file alsa-kernel/core/rawmidi.c
patching file rawmidi.c
Hunk #3 succeeded at 1252 (offset -11 lines).
Hunk #4 succeeded at 1307 (offset -11 lines).
Hunk #5 succeeded at 1397 (offset -11 lines).
copying file alsa-kernel/core/sound.c
patching file sound.c
Hunk #2 succeeded at 39 (offset -1 lines).
Hunk #3 succeeded at 50 (offset -1 lines).
Hunk #4 succeeded at 190 (offset -1 lines).
Hunk #5 succeeded at 277 (offset -1 lines).
Hunk #6 succeeded at 289 (offset -1 lines).
Hunk #7 succeeded at 306 (offset -1 lines).
Hunk #8 succeeded at 330 (offset -1 lines).
Hunk #9 succeeded at 385 (offset -1 lines).
Hunk #10 succeeded at 396 (offset -1 lines).
Hunk #11 succeeded at 422 (offset -1 lines).
Hunk #12 succeeded at 529 (offset -1 lines).
copying file alsa-kernel/core/timer.c
patching file timer.c
Hunk #3 succeeded at 998 (offset 1 line).
Hunk #4 succeeded at 1918 (offset 2 lines).
Hunk #5 succeeded at 1964 (offset 2 lines).
copying file alsa-kernel/core/memalloc.c
patching file memalloc.c
Hunk #8 succeeded at 524 (offset 1 line).
Hunk #9 succeeded at 663 (offset 1 line).
Hunk #10 succeeded at 673 (offset 1 line).
Hunk #11 succeeded at 712 (offset 1 line).
copying file alsa-kernel/core/misc.c
patching file misc.c
copying file alsa-kernel/core/hrtimer.c
patching file hrtimer.c
Hunk #2 succeeded at 68 (offset 2 lines).
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/acore/ioctl32'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/acore/ioctl32'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/acore/oss'
copying file alsa-kernel/core/oss/mixer_oss.c
patching file mixer_oss.c
Hunk #3 succeeded at 389 (offset 2 lines).
copying file alsa-kernel/core/oss/pcm_oss.c
patching file pcm_oss.c
Hunk #3 succeeded at 1925 (offset 10 lines).
Hunk #4 succeeded at 2650 (offset 10 lines).
Hunk #5 succeeded at 2702 (offset 10 lines).
Hunk #6 succeeded at 2830 (offset 10 lines).
Hunk #7 succeeded at 3015 (offset 10 lines).
Hunk #8 succeeded at 3143 (offset 10 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/acore/oss'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/acore/seq'
copying file alsa-kernel/core/seq/seq.c
patching file seq.c
Hunk #2 succeeded at 60 (offset 3 lines).
copying file alsa-kernel/core/seq/seq_clientmgr.c
patching file seq_clientmgr.c
Hunk #4 succeeded at 2563 (offset -3 lines).
copying file alsa-kernel/core/seq/seq_memory.c
patching file seq_memory.c
Hunk #3 succeeded at 250 (offset 2 lines).
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/acore/seq/oss'
copying file alsa-kernel/core/seq/oss/seq_oss.c
patching file seq_oss.c
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/acore/seq/oss'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/acore/seq'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/acore'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/i2c'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/i2c/l3'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/i2c/l3'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/i2c/other'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/i2c/other'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/i2c'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers'
copying file alsa-kernel/drivers/mts64.c
patching file mts64.c
Hunk #2 succeeded at 835 (offset 1 line).
Hunk #3 succeeded at 1094 (offset 1 line).
copying file alsa-kernel/drivers/portman2x4.c
patching file portman2x4.c
Hunk #2 succeeded at 612 (offset 1 line).
Hunk #3 succeeded at 883 (offset 1 line).
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers/mpu401'
copying file alsa-kernel/drivers/mpu401/mpu401.c
patching file mpu401.c
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers/mpu401'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers/opl3'
copying file alsa-kernel/drivers/opl3/opl3_lib.c
patching file opl3_lib.c
Hunk #2 succeeded at 438 (offset 2 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers/opl3'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers/opl4'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers/opl4'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers/pcsp'
copying file alsa-kernel/drivers/pcsp/pcsp.c
patching file pcsp.c
copying file alsa-kernel/drivers/pcsp/pcsp_input.c
patching file pcsp_input.c
copying file alsa-kernel/drivers/pcsp/pcsp_lib.c
patching file pcsp_lib.c
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers/pcsp'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers/vx'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers/vx'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/ad1816a'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/ad1816a'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/ad1848'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/ad1848'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/cs423x'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/cs423x'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/es1688'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/es1688'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/galaxy'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/galaxy'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/gus'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/gus'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/msnd'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/msnd'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/opti9xx'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/opti9xx'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/sb'
copying file alsa-kernel/isa/sb/sb16_csp.c
patching file sb16_csp.c
Hunk #2 succeeded at 712 (offset 2 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/sb'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/wavefront'
copying file alsa-kernel/isa/wavefront/wavefront_fx.c
patching file wavefront_fx.c
Hunk #2 succeeded at 251 (offset -3 lines).
copying file alsa-kernel/isa/wavefront/wavefront_synth.c
patching file wavefront_synth.c
Hunk #2 succeeded at 1947 (offset 1 line).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/wavefront'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/wss'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/wss'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/synth'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/synth/emux'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/synth/emux'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/synth'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci'
copying file alsa-kernel/pci/atiixp.c
patching file atiixp.c
Hunk #2 succeeded at 1680 (offset 9 lines).
Hunk #3 succeeded at 1725 (offset 9 lines).
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
Hunk #2 succeeded at 3135 (offset -41 lines).
Hunk #3 succeeded at 3430 (offset -41 lines).
copying file alsa-kernel/pci/ens1370.c
patching file ens1370.c
Hunk #2 succeeded at 2136 (offset 5 lines).
Hunk #3 succeeded at 2512 (offset 5 lines).
copying file alsa-kernel/pci/fm801.c
patching file fm801.c
Hunk #4 succeeded at 1420 (offset 9 lines).
copying file alsa-kernel/pci/intel8x0.c
patching file intel8x0.c
Hunk #3 succeeded at 715 (offset 9 lines).
Hunk #4 succeeded at 725 (offset 9 lines).
Hunk #5 succeeded at 3306 (offset 178 lines).
copying file alsa-kernel/pci/maestro3.c
patching file maestro3.c
Hunk #2 succeeded at 2678 (offset 82 lines).
Hunk #3 succeeded at 2871 (offset 89 lines).
copying file alsa-kernel/pci/via82xx.c
patching file via82xx.c
Hunk #2 succeeded at 2505 (offset 11 lines).
Hunk #3 succeeded at 2515 (offset 11 lines).
Hunk #4 succeeded at 2530 (offset 11 lines).
Hunk #5 succeeded at 2541 (offset 11 lines).
Hunk #6 succeeded at 2552 (offset 11 lines).
Hunk #7 succeeded at 2635 (offset 11 lines).
copying file alsa-kernel/pci/via82xx_modem.c
patching file via82xx_modem.c
Hunk #2 succeeded at 1187 (offset 7 lines).
Hunk #3 succeeded at 1247 (offset 7 lines).
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ac97'
copying file alsa-kernel/pci/ac97/ac97_codec.c
patching file ac97_codec.c
Hunk #3 succeeded at 1943 (offset 16 lines).
Hunk #4 succeeded at 1955 (offset 16 lines).
Hunk #5 succeeded at 1979 (offset 16 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ac97'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ali5451'
copying file alsa-kernel/pci/ali5451/ali5451.c
patching file ali5451.c
Hunk #2 succeeded at 2148 (offset -57 lines).
Hunk #3 succeeded at 2318 (offset -57 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ali5451'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/asihpi'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/asihpi'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/au88x0'
copying file alsa-kernel/pci/au88x0/au88x0.c
patching file au88x0.c
Hunk #2 succeeded at 339 (offset -2 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/au88x0'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/aw2'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/aw2'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ca0106'
copying file alsa-kernel/pci/ca0106/ca0106_main.c
patching file ca0106_main.c
Hunk #3 succeeded at 1686 (offset 123 lines).
Hunk #4 succeeded at 1958 (offset 133 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ca0106'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/cs46xx'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/cs46xx'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/cs5535audio'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/cs5535audio'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ctxfi'
copying file alsa-kernel/pci/ctxfi/ctatc.c
patching file ctatc.c
Hunk #2 succeeded at 1272 (offset 24 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ctxfi'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/echoaudio'
copying file alsa-kernel/pci/echoaudio/echoaudio.c
patching file echoaudio.c
Hunk #1 succeeded at 1945 (offset 2 lines).
Hunk #2 succeeded at 2017 (offset 2 lines).
Hunk #3 succeeded at 2252 (offset 1 line).
Hunk #4 succeeded at 2262 (offset 3 lines).
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
Hunk #2 succeeded at 112 (offset 1 line).
copying file alsa-kernel/pci/echoaudio/indigoiox.c
patching file indigoiox.c
Hunk #2 succeeded at 114 (offset 1 line).
copying file alsa-kernel/pci/echoaudio/layla20.c
patching file layla20.c
copying file alsa-kernel/pci/echoaudio/layla24.c
patching file layla24.c
copying file alsa-kernel/pci/echoaudio/mia.c
patching file mia.c
Hunk #2 succeeded at 125 (offset 1 line).
copying file alsa-kernel/pci/echoaudio/mona.c
patching file mona.c
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/echoaudio'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/emu10k1'
copying file alsa-kernel/pci/emu10k1/emu10k1_main.c
patching file emu10k1_main.c
Hunk #4 succeeded at 1409 (offset -1 lines).
Hunk #5 succeeded at 1460 (offset 7 lines).
Hunk #6 succeeded at 1775 (offset 11 lines).
copying file alsa-kernel/pci/emu10k1/emu10k1x.c
patching file emu10k1x.c
Hunk #2 succeeded at 941 (offset 1 line).
Hunk #3 succeeded at 1634 (offset 6 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/emu10k1'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/hda'
copying file alsa-kernel/pci/hda/hda_intel.c
patching file hda_intel.c
Hunk #2 succeeded at 2464 (offset 6 lines).
Hunk #3 succeeded at 2480 (offset 6 lines).
Hunk #4 succeeded at 2496 (offset 6 lines).
Hunk #5 succeeded at 2509 (offset 6 lines).
Hunk #6 succeeded at 2631 (offset 6 lines).
copying file alsa-kernel/pci/hda/hda_beep.c
patching file hda_beep.c
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/hda'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ice1712'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ice1712'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/korg1212'
copying file alsa-kernel/pci/korg1212/korg1212.c
patching file korg1212.c
Hunk #2 succeeded at 2344 (offset 5 lines).
Hunk #3 succeeded at 2500 (offset 5 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/korg1212'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/lola'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/lola'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/lx6464es'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/lx6464es'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/mixart'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/mixart'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/nm256'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/nm256'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/oxygen'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/oxygen'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/pcxhr'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/pcxhr'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/pdplus'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/pdplus'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/riptide'
copying file alsa-kernel/pci/riptide/riptide.c
patching file riptide.c
Hunk #2 succeeded at 1237 (offset -1 lines).
Hunk #3 succeeded at 2226 (offset 8 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/riptide'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/rme9652'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/rme9652'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/trident'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/trident'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/vx222'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/vx222'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ymfpci'
copying file alsa-kernel/pci/ymfpci/ymfpci_main.c
patching file ymfpci_main.c
Hunk #2 succeeded at 2020 (offset -6 lines).
Hunk #3 succeeded at 2040 (offset -6 lines).
Hunk #4 succeeded at 2380 (offset -6 lines).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ymfpci'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa/codecs'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa/codecs'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa/core'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa/core'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa/fabrics'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa/fabrics'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa/soundbus'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa/soundbus/i2sbus'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa/soundbus/i2sbus'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa/soundbus'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc'
copying file alsa-kernel/soc/soc-core.c
patching file soc-core.c
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/atmel'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/atmel'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/au1x'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/au1x'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/blackfin'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/blackfin'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/codecs'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/codecs'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/davinci'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/davinci'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/ep93xx'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/ep93xx'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/fsl'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/fsl'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/imx'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/imx'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/jz4740'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/jz4740'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/kirkwood'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/kirkwood'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/mid-x86'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/mid-x86'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/nuc900'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/nuc900'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/omap'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/omap'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/pxa'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/pxa'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/s6000'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/s6000'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/samsung'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/samsung'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/sh'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/sh'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/tegra'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/tegra'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/txx9'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/txx9'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/usb'
copying file alsa-kernel/usb/card.c
patching file card.c
Hunk #2 succeeded at 83 (offset 2 lines).
Hunk #3 succeeded at 251 (offset 2 lines).
Hunk #4 succeeded at 356 (offset 11 lines).
Hunk #5 succeeded at 464 (offset 16 lines).
Hunk #6 succeeded at 600 (offset 15 lines).
Hunk #7 succeeded at 704 (offset 15 lines).
Hunk #8 succeeded at 721 (offset 15 lines).
Hunk #9 succeeded at 756 (offset 15 lines).
copying file alsa-kernel/usb/endpoint.c
patching file endpoint.c
Hunk #2 succeeded at 261 (offset 76 lines).
Hunk #3 succeeded at 375 (offset 99 lines).
Hunk #4 succeeded at 395 (offset 88 lines).
copying file alsa-kernel/usb/helper.c
patching file helper.c
Hunk #2 succeeded at 93 (offset 1 line).
copying file alsa-kernel/usb/quirks.c
patching file quirks.c
copying file alsa-kernel/usb/urb.c
patching file urb.c
Hunk #2 succeeded at 72 (offset 1 line).
Hunk #3 succeeded at 87 (offset 1 line).
Hunk #4 succeeded at 171 (offset 1 line).
Hunk #5 succeeded at 198 (offset 1 line).
Hunk #6 succeeded at 351 (offset 2 lines).
copying file alsa-kernel/usb/midi.c
patching file midi.c
Hunk #2 succeeded at 249 (offset 1 line).
Hunk #3 succeeded at 277 (offset 1 line).
Hunk #4 succeeded at 391 (offset 1 line).
Hunk #5 succeeded at 1019 (offset 1 line).
Hunk #6 succeeded at 1118 (offset 8 lines).
Hunk #7 succeeded at 1135 (offset 8 lines).
Hunk #8 succeeded at 1145 (offset 8 lines).
Hunk #9 succeeded at 1870 (offset 10 lines).
Hunk #10 succeeded at 2248 (offset 10 lines).
copying file alsa-kernel/usb/mixer.c
patching file mixer.c
Hunk #2 succeeded at 104 (offset -26 lines).
Hunk #3 succeeded at 2096 (offset 73 lines).
Hunk #4 succeeded at 2191 (offset 94 lines).
copying file alsa-kernel/usb/mixer_quirks.c
patching file mixer_quirks.c
Hunk #2 succeeded at 68 (offset 5 lines).
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/usb/6fire'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/usb/6fire'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/usb/caiaq'
copying file alsa-kernel/usb/caiaq/audio.c
patching file audio.c
Hunk #2 succeeded at 610 (offset 146 lines).
Hunk #3 succeeded at 673 (offset 146 lines).
copying file alsa-kernel/usb/caiaq/device.c
patching file device.c
Hunk #2 succeeded at 151 (offset 19 lines).
Hunk #3 succeeded at 407 (offset 13 lines).
copying file alsa-kernel/usb/caiaq/input.c
patching file input.c
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/usb/caiaq'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/usb/misc'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/usb/misc'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/usb/usx2y'
copying file alsa-kernel/usb/usx2y/usX2Yhwdep.c
patching file usX2Yhwdep.c
Hunk #2 succeeded at 33 (offset 1 line).
Hunk #3 succeeded at 56 (offset 1 line).
Hunk #4 succeeded at 142 (offset 1 line).
Hunk #5 succeeded at 181 (offset 1 line).
Hunk #6 succeeded at 237 (offset 1 line).
Hunk #7 succeeded at 290 (offset 1 line).
copying file alsa-kernel/usb/usx2y/usbusx2y.c
patching file usbusx2y.c
Hunk #2 succeeded at 174 (offset 1 line).
Hunk #3 succeeded at 190 (offset 1 line).
Hunk #4 succeeded at 254 (offset 1 line).
Hunk #5 succeeded at 267 (offset 1 line).
Hunk #6 succeeded at 313 (offset 1 line).
Hunk #7 succeeded at 377 (offset 1 line).
Hunk #8 succeeded at 401 (offset 1 line).
Hunk #9 succeeded at 427 (offset 1 line).
Hunk #10 succeeded at 448 (offset 1 line).
Hunk #11 succeeded at 508 (offset 1 line).
Hunk #12 succeeded at 528 (offset 1 line).
copying file alsa-kernel/usb/usx2y/usbusx2yaudio.c
patching file usbusx2yaudio.c
Hunk #2 succeeded at 69 (offset 1 line).
Hunk #3 succeeded at 317 (offset 1 line).
Hunk #4 succeeded at 350 (offset 1 line).
Hunk #5 succeeded at 366 (offset 1 line).
Hunk #6 succeeded at 392 (offset 1 line).
Hunk #7 succeeded at 408 (offset 1 line).
Hunk #8 succeeded at 525 (offset 1 line).
Hunk #9 succeeded at 548 (offset 1 line).
Hunk #10 succeeded at 697 (offset 1 line).
Hunk #11 succeeded at 1061 (offset 1 line).
copying file alsa-kernel/usb/usx2y/usx2yhwdeppcm.c
patching file usx2yhwdeppcm.c
Hunk #2 succeeded at 153 (offset 1 line).
Hunk #3 succeeded at 233 (offset 1 line).
Hunk #4 succeeded at 267 (offset 1 line).
Hunk #5 succeeded at 307 (offset 1 line).
Hunk #6 succeeded at 328 (offset 1 line).
Hunk #7 succeeded at 454 (offset 1 line).
Hunk #8 succeeded at 482 (offset 1 line).
Hunk #9 succeeded at 715 (offset 1 line).
Hunk #10 succeeded at 728 (offset 1 line).
Hunk #11 succeeded at 803 (offset 1 line).
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/usb/usx2y'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/usb'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pcmcia'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pcmcia/pdaudiocf'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pcmcia/pdaudiocf'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pcmcia/vx'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pcmcia/vx'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pcmcia'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/misc'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/misc'
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/firewire'
copying file alsa-kernel/firewire/cmp.c
patching file cmp.c
copying file alsa-kernel/firewire/iso-resources.c
patching file iso-resources.c
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/firewire'
make dep
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/include'
make -C sound prepare
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/include/sound'
make prepare2
make[4]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/include/sound'
make[4]: Nothing to be done for `prepare2'.
make[4]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/include/sound'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/include/sound'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/include'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/acore'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/acore/ioctl32'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/acore/ioctl32'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/acore/oss'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/acore/oss'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/acore/seq'
make[4]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/acore/seq/oss'
make[4]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/acore/seq/oss'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/acore/seq'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/acore'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/i2c'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/i2c/l3'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/i2c/l3'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/i2c/other'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/i2c/other'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/i2c'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers/mpu401'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers/mpu401'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers/opl3'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers/opl3'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers/opl4'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers/opl4'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers/pcsp'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers/pcsp'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/drivers/vx'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers/vx'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/drivers'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/ad1816a'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/ad1816a'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/ad1848'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/ad1848'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/cs423x'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/cs423x'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/es1688'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/es1688'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/galaxy'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/galaxy'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/gus'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/gus'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/msnd'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/msnd'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/opti9xx'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/opti9xx'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/sb'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/sb'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/wavefront'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/wavefront'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/isa/wss'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa/wss'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/isa'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/synth'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/synth/emux'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/synth/emux'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/synth'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ac97'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ac97'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ali5451'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ali5451'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/asihpi'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/asihpi'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/au88x0'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/au88x0'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/aw2'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/aw2'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ca0106'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ca0106'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/cs46xx'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/cs46xx'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/cs5535audio'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/cs5535audio'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ctxfi'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ctxfi'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/echoaudio'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/echoaudio'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/emu10k1'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/emu10k1'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/hda'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/hda'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ice1712'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ice1712'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/korg1212'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/korg1212'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/lola'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/lola'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/lx6464es'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/lx6464es'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/mixart'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/mixart'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/nm256'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/nm256'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/oxygen'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/oxygen'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/pcxhr'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/pcxhr'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/pdplus'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/pdplus'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/riptide'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/riptide'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/rme9652'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/rme9652'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/trident'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/trident'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/vx222'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/vx222'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pci/ymfpci'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci/ymfpci'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pci'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa/codecs'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa/codecs'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa/core'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa/core'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa/fabrics'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa/fabrics'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa/soundbus'
make[4]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/aoa/soundbus/i2sbus'
make[4]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa/soundbus/i2sbus'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa/soundbus'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/aoa'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/atmel'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/atmel'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/au1x'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/au1x'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/blackfin'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/blackfin'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/codecs'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/codecs'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/davinci'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/davinci'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/ep93xx'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/ep93xx'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/fsl'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/fsl'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/imx'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/imx'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/jz4740'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/jz4740'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/kirkwood'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/kirkwood'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/mid-x86'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/mid-x86'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/nuc900'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/nuc900'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/omap'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/omap'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/pxa'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/pxa'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/s6000'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/s6000'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/samsung'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/samsung'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/sh'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/sh'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/tegra'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/tegra'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/soc/txx9'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc/txx9'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/soc'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/usb'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/usb/6fire'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/usb/6fire'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/usb/caiaq'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/usb/caiaq'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/usb/misc'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/usb/misc'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/usb/usx2y'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/usb/usx2y'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/usb'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pcmcia'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pcmcia/pdaudiocf'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pcmcia/pdaudiocf'
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/pcmcia/vx'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pcmcia/vx'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/pcmcia'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/misc'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/misc'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.=
47.gfa552.1132.g89a70/firewire'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70/firewire'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.24.4=
7.gfa552.1132.g89a70'
make -C /lib/modules/2.6.34.9-69.fc13.x86_64/build SUBDIRS=3D/tmp/alsa-co=
mpile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a70  CPP=3D"gcc -E" CC=3D=
"gcc" modules
make[1]: Entering directory `/usr/src/kernels/2.6.34.9-69.fc13.x86_64'
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/hrtimer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/hwdep.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/memory_wrapper.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/memalloc.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/sgbuf.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/pcm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/pcm_native.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/pcm_lib.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/pcm_timer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/pcm_misc.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/pcm_memory.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/rawmidi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/timer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/wrappers.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/misc_driver.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/memory_debug.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/sound.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/init.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/memory.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/info.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/control.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/misc.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/device.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/sound_oss.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/info_oss.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/vmaster.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/jack.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/snd.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/snd-hwdep.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/snd-timer.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/snd-hrtimer.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/snd-pcm.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/snd-page-alloc.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/snd-rawmidi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/oss/mixer_oss.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/oss/pcm_oss.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/oss/pcm_plugin.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/oss/io.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/oss/copy.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/oss/linear.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/oss/mulaw.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/oss/route.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/oss/rate.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/oss/snd-mixer-oss.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/oss/snd-pcm-oss.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_device.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_dummy.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_midi_emul.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_midi_event.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_midi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_virmidi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_lock.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_clientmgr.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_memory.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_queue.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_fifo.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_prioq.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_timer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_system.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_ports.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/seq_info.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/snd-seq.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/snd-seq-device.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/snd-seq-midi-event.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/snd-seq-dummy.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/snd-seq-virmidi.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/snd-seq-midi.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/snd-seq-midi-emul.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/oss/seq_oss.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/oss/seq_oss_init.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/oss/seq_oss_timer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/oss/seq_oss_ioctl.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/oss/seq_oss_event.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/oss/seq_oss_rw.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/oss/seq_oss_synth.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/oss/seq_oss_midi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/oss/seq_oss_readq.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/oss/seq_oss_writeq.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/acore/seq/oss/snd-seq-oss.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/aloop.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/dummy.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/mtpav.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/mts64.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/portman2x4.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/serial-u16550.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/virmidi.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/snd-dummy.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/snd-aloop.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/snd-virmidi.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/snd-serial-u16550.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/snd-mtpav.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/snd-mts64.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/snd-portman2x4.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/mpu401/mpu401_uart.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/mpu401/mpu401.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/mpu401/snd-mpu401-uart.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/mpu401/snd-mpu401.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/opl3/opl3_lib.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/opl3/opl3_synth.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/opl3/opl3_seq.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/opl3/opl3_midi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/opl3/opl3_drums.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/opl3/opl3_oss.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/opl3/snd-opl3-lib.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/opl3/snd-opl3-synth.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/pcsp/pcsp.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/pcsp/pcsp_lib.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/pcsp/pcsp_mixer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/pcsp/pcsp_input.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/pcsp/snd-pcsp.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/vx/vx_core.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/vx/vx_hwdep.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/vx/vx_pcm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/vx/vx_mixer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/vx/vx_cmd.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/vx/vx_uer.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/drivers/vx/snd-vx-lib.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/cs8427.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/i2c.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/snd-cs8427.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/snd-i2c.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/ak4113.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/ak4114.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/ak4117.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/ak4xxx-adda.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/pt2258.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/tea575x-tuner.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/snd-ak4117.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/snd-ak4xxx-adda.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/snd-ak4114.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/snd-ak4113.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/snd-pt2258.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/i2c/other/snd-tea575x-tuner.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/misc/ac97_bus.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ad1889.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/als300.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/atiixp_modem.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/atiixp.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/azt3328.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/bt87x.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/cmipci.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/cs4281.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ens1370.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ak4531_codec.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ens1371.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/es1938.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/es1968.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/fm801.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/intel8x0.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/intel8x0m.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/maestro3.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/rme32.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/rme96.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/sonicvibes.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/via82xx_modem.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/via82xx.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-ad1889.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-als300.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-atiixp.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-atiixp-modem.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-azt3328.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-bt87x.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-cmipci.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-cs4281.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-ens1370.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-ens1371.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-es1938.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-es1968.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-fm801.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-intel8x0.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-intel8x0m.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-maestro3.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-rme32.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-rme96.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-sonicvibes.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-via82xx.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/snd-via82xx-modem.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ac97/ac97_codec.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ac97/ac97_pcm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ac97/ac97_proc.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ac97/snd-ac97-codec.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ali5451/ali5451.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ali5451/snd-ali5451.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/asihpi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/hpioctl.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/hpimsginit.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/hpicmn.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/hpifunc.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/hpidebug.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/hpidspcd.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/hpios.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/hpi6000.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/hpi6205.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/hpimsgx.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/asihpi/snd-asihpi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/au88x0/au8810.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/au88x0/au8820.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/au88x0/au8830.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/au88x0/snd-au8810.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/au88x0/snd-au8820.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/au88x0/snd-au8830.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/aw2/aw2-alsa.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/aw2/aw2-saa7146.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/aw2/snd-aw2.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ca0106/ca0106_main.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ca0106/ca0106_proc.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ca0106/ca0106_mixer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ca0106/ca_midi.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ca0106/snd-ca0106.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/cs46xx/cs46xx.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/cs46xx/cs46xx_lib.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/cs46xx/dsp_spos.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/cs46xx/dsp_spos_scb_lib.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/cs46xx/snd-cs46xx.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/cs5535audio/cs5535audio.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/cs5535audio/cs5535audio_pcm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/cs5535audio/cs5535audio_pm.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/cs5535audio/snd-cs5535audio.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/xfi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/ctatc.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/ctvmem.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/ctpcm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/ctmixer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/ctresource.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/ctsrc.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/ctamixer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/ctdaio.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/ctimap.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/cthardware.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/cttimer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/cthw20k2.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/cthw20k1.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ctxfi/snd-ctxfi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/darla20.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/darla24.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/echo3g.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/gina20.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/gina24.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/indigo.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/indigodj.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/indigodjx.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/indigoio.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/indigoiox.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/layla20.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/layla24.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/mia.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/mona.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-darla20.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-gina20.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-layla20.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-darla24.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-gina24.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-layla24.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-mona.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-mia.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-echo3g.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-indigo.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-indigoio.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-indigodj.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-indigoiox.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/echoaudio/snd-indigodjx.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/emu10k1_synth.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/emu10k1_callback.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/emu10k1_patch.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/emu10k1.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/emu10k1_main.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/irq.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/memory.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/voice.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/emumpu401.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/emupcm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/io.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/emuproc.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/emumixer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/emufx.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/timer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/p16v.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/emu10k1x.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/snd-emu10k1.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/snd-emu10k1-synth.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/emu10k1/snd-emu10k1x.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/patch_analog.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/dummy.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/patch_ca0110.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/patch_ca0132.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/patch_cirrus.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/patch_cmedia.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/patch_conexant.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/patch_hdmi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/hda_eld.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/patch_sigmatel.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/patch_realtek.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/patch_si3054.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/patch_via.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/hda_codec.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/hda_generic.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/hda_proc.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/hda_hwdep.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/hda_beep.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/hda_intel.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-realtek.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-cmedia.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-analog.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-idt.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-si3054.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-cirrus.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-ca0110.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-ca0132.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-conexant.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-via.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-hdmi.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-intel.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-atihdmi.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-intelhdmi.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/hda/snd-hda-codec-nvhdmi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/ice1712.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/delta.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/hoontech.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/ews.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/ice1724.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/amp.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/revo.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/aureon.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/vt1720_mobo.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/pontis.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/prodigy192.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/prodigy_hifi.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/juli.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/phase.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/wtm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/se.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/maya44.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/quartet.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/ak4xxx.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/snd-ice1712.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/snd-ice17xx-ak4xxx.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ice1712/snd-ice1724.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/korg1212/korg1212.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/korg1212/snd-korg1212.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/lola/lola.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/lola/lola_pcm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/lola/lola_clock.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/lola/lola_mixer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/lola/lola_proc.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/lola/snd-lola.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/lx6464es/lx6464es.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/lx6464es/lx_core.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/lx6464es/snd-lx6464es.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/mixart/mixart.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/mixart/mixart_core.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/mixart/mixart_hwdep.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/mixart/mixart_mixer.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/mixart/snd-mixart.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/nm256/nm256.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/nm256/snd-nm256.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/oxygen_io.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/oxygen_lib.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/oxygen_mixer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/oxygen_pcm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/oxygen.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/xonar_dg.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/virtuoso.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/xonar_lib.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/xonar_pcm179x.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/xonar_cs43xx.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/xonar_wm87x6.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/xonar_hdmi.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/snd-oxygen-lib.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/snd-oxygen.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/oxygen/snd-virtuoso.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/pcxhr/pcxhr.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/pcxhr/pcxhr_hwdep.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/pcxhr/pcxhr_mixer.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/pcxhr/pcxhr_core.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/pcxhr/pcxhr_mix22.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/pcxhr/snd-pcxhr.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/pdplus/pdplus.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/pdplus/snd-pdplus.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/riptide/riptide.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/riptide/snd-riptide.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/rme9652/hdsp.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/rme9652/hdspm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/rme9652/rme9652.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/rme9652/snd-rme9652.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/rme9652/snd-hdsp.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/rme9652/snd-hdspm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/trident/trident.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/trident/trident_main.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/trident/trident_memory.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/trident/snd-trident.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/vx222/vx222.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/vx222/vx222_ops.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/vx222/snd-vx222.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ymfpci/ymfpci.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ymfpci/ymfpci_main.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pci/ymfpci/snd-ymfpci.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pcmcia/pdaudiocf/pdaudiocf.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pcmcia/pdaudiocf/pdaudiocf_core.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pcmcia/pdaudiocf/pdaudiocf_irq.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pcmcia/pdaudiocf/pdaudiocf_pcm.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pcmcia/pdaudiocf/snd-pdaudiocf.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pcmcia/vx/vxpocket.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pcmcia/vx/vxp_ops.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pcmcia/vx/vxp_mixer.o
  LD [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/pcmcia/vx/snd-vxpocket.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/soc/soc-core.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/soc/soc-dapm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/soc/soc-jack.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/soc/soc-cache.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/soc/soc-utils.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/soc/soc-pcm.o
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a=
70/soc/soc-io.o
In file included from /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa5=
52.1132.g89a70/soc/soc-io.c:2:
/tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a70/soc/../=
alsa-kernel/soc/soc-io.c: In function =E2=80=98snd_soc_codec_set_cache_io=
=E2=80=99:
/tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a70/soc/../=
alsa-kernel/soc/soc-io.c:370: error: =E2=80=98SND_SOC_CUSTOM=E2=80=99 und=
eclared (first use in this function)
/tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a70/soc/../=
alsa-kernel/soc/soc-io.c:370: error: (Each undeclared identifier is repor=
ted only once
/tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.g89a70/soc/../=
alsa-kernel/soc/soc-io.c:370: error: for each function it appears in.)
make[3]: *** [/tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.=
g89a70/soc/soc-io.o] Error 1
make[2]: *** [/tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1132.=
g89a70/soc] Error 2
make[1]: *** [_module_/tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa5=
52.1132.g89a70] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.34.9-69.fc13.x86_64'
make: *** [compile] Error 2
Working directory /tmp/alsa-compile-script/alsa-driver-1.0.24.47.gfa552.1=
132.g89a70.
Compilation of alsa-driver failed.
Report this problem to the <alsa-devel@alsa-project.org> mailing list.


--=-Lxs/HVdC3nX+gp4v4eMM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-Lxs/HVdC3nX+gp4v4eMM--
