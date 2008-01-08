From: John Stile <john@stilen.com>
Subject: Re:
	snd-hda-intel	support	for	SPDIF-in	wiht	vt1708	card?
Date: Tue, 08 Jan 2008 09:57:10 -0800
Message-ID: <1199815030.31742.29.camel@genx.localdomain>
References: <010720081840.4095.47827221000A2BAB00000FFF220702455305029A06039A9D0100@comcast.net>
	<1199777722.10421.29.camel@genx.localdomain>
	<s5hejcs931e.wl%tiwai@suse.de>
	<1199780495.10421.32.camel@genx.localdomain>
	<1199810328.10421.55.camel@genx.localdomain>
	<s5h8x302rdc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mother.stilen.com (dsl027-182-089.sfo1.dsl.speakeasy.net
	[216.27.182.89]) by alsa0.perex.cz (Postfix) with ESMTP id 0CD982415D
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 18:57:13 +0100 (CET)
In-Reply-To: <s5h8x302rdc.wl%tiwai@suse.de>
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
Cc: Darryl House <forumjunk@comcast.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2008-01-08 at 17:50 +0100, Takashi Iwai wrote:
> At Tue, 08 Jan 2008 08:38:48 -0800,
> John Stile wrote:
> > 
> > On Tue, 2008-01-08 at 00:21 -0800, John Stile wrote:
> > > On Tue, 2008-01-08 at 08:42 +0100, Takashi Iwai wrote: 
> > > > Do you have any ~/.asoundrc or /etc/asound.conf or whatever?
> > > > Remove this once.
> > > > 
> > > I had a /etc/conf.d/alsasound which I removed, but no ~/.asoundrc
> > > or /etc/asound.conf.
> > Thank you for all this help.
> > 
> > Is the problem with recording digital-in because both digital and analog
> > capture devices have the same identity (i.e. both are hw:0,1)?
> 
> Possible.  But, I suspect rather it's your configuration problem.
> Are you using the latest HG version of alsa-lib, too?  (Don't use
> emerge and some voodoo for gentoo, but do simply install from
> scratch...)

Ok.  I'm trying to get all this right.  

I removed all alsa gentoo packages and verified with 'eix -I alsa'
  No matches found.
No alsa binaries found on the system.

I rebuilt all alsa from HG checkout this morning (alsa-lib, alsa-util,
alsa-driver) with this procedure:
cd /usr/src/
rm -rf alsa-lib
hg clone http://hg-mirror.alsa-project.org/alsa-lib alsa-lib
pushd alsa-lib
./hgcompile && make install
popd
hg clone http://hg-mirror.alsa-project.org/alsa-utils alsa-utils
pushd alsa-utils
aclocal -I m4 && autoconf
./hgcompile && make install
popd
rm -rf alsa-driver
hg clone http://hg-mirror.alsa-project.org/alsa-driver alsa-driver
pushd alsa-driver
hg clone http://hg-mirror.alsa-project.org/alsa-kernel alsa-kernel
./hgcompile


This fails ending in:
gcc utils/mod-deps.c -o utils/mod-deps
utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel
--hiddendir /usr/src/alsa-driver
--versiondep /usr/src/alsa-driver/kconfig-vers --makeconf >
toplevel.config.in
can't handle word INPUT=y properly, supposing it's OK
can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel
--hiddendir /usr/src/alsa-driver
--versiondep /usr/src/alsa-driver/kconfig-vers --acinclude >
acinclude.m4
can't handle word INPUT=y properly, supposing it's OK
can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel
--hiddendir /usr/src/alsa-driver
--versiondep /usr/src/alsa-driver/kconfig-vers --include >
include/config1.h.in
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
checking for directory with kernel
source... /lib/modules/2.6.23-gentoo-r4/source
checking for directory with kernel
build... /lib/modules/2.6.23-gentoo-r4/build
checking for kernel linux/version.h... yes
checking for kernel linux/autoconf.h... yes
checking for kernel version... 2.6.23-gentoo-r4
checking for GCC version... Kernel compiler: gcc 4.1.2 (Gentoo 4.1.2
p1.0.2) Used compiler: gcc (GCC) 4.1.2 (Gentoo 4.1.2 p1.0.2)
checking for built-in ALSA... no
checking for existing ALSA module... no
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
checking for kernel linux/seq_file.h... yes
checking for kernel module symbol versions... yes
checking for has ioport support... yes
checking for PCI support in kernel... yes
checking for I2C driver in kernel... unknown
checking for firmware loader... module
checking for input subsystem in kernel... yes
checking for directory to store kernel
modules... /lib/modules/2.6.23-gentoo-r4/kernel/sound
checking for verbose procfs... on
checking for verbose printk... on
checking for debug level... full
checking for ISA support in kernel... yes
checking for processor type... x86_32
checking for i386 machine type... default
checking for ISA DMA API... yes
checking for SMP... yes
checking for Video device support in kernel... no
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
checking for io_remap_pfn_range... yes
checking for kcalloc... yes
checking for kstrdup... yes
checking for kzalloc... yes
checking for create_workqueue with flags... no
checking for saved_config_space in pci_dev... yes
checking for new pci_save_state... yes
checking for register_sound_special_device... yes
checking for driver version... 1.0.15
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for OSS PCM plugin system inclusion... yes
checking for RTC callback support in kernel... yes
checking for HPET support... no
checking for dynamic minor numbers... no
checking for support of old API... yes
checking for Procfs support... yes
checking for USB support... yes
checking for class_simple... no
checking for old driver suspend/resume callbacks... no
checking for removal of page-reservation for nopage/mmap... yes
checking for nested class_device... yes
checking for new IRQ handler... yes
checking for gfp_t... yes
checking for PnP suspend/resume... yes
checking for new unlocked/compat_ioctl... yes
checking for x86-compatible PC... yes
checking for High-Res timers... no
checking for kernel PCMCIA
checking for PCMCIA support... no
checking for PCMCIA module support... no
checking for PC9800 support in kernel... no
checking for parallel port support... yes
checking for power management... yes
checking for CONFIG_HAS_DMA... yes
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
config.status: creating include/autoconf-extra.h
if [ ! -d include/sound -a ! -L include/sound ]; then \
          ln -sf ../alsa-kernel/include include/sound ; \
        fi
cp -puvf include/version.h include/sound/version.h
`include/version.h' -> `include/sound/version.h'
make[1]: Entering directory `/usr/src/alsa-driver/acore'
copying file alsa-kernel/core/info.c
patching file info.c
Hunk #2 FAILED at 21.
Hunk #3 succeeded at 156 (offset -1 lines).
Hunk #4 succeeded at 168 (offset -1 lines).
Hunk #5 succeeded at 178 (offset -1 lines).
Hunk #6 succeeded at 209 (offset -1 lines).
Hunk #7 succeeded at 494 (offset -1 lines).
Hunk #8 succeeded at 534 with fuzz 2 (offset -1 lines).
Hunk #9 succeeded at 993 (offset -1 lines).
Hunk #10 succeeded at 1022 (offset -1 lines).
1 out of 10 hunks FAILED -- saving rejects to file info.c.rej
make[1]: *** [info.c] Error 1
make[1]: Leaving directory `/usr/src/alsa-driver/acore'
make: *** [dep] Error 1
