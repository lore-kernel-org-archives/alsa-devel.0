From: noreply@alsa-project.org
Subject: [ALSA - driver 0000210]: Can not compile
Date: Fri, 16 Jul 2004 14:31:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123144.33E1B2C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7DE42244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:31:44 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000210
======================================================================
Reported By:                pshou
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     210
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.2-05
======================================================================
Date Submitted:             04-15-2004 11:17 CEST
Last Modified:              07-16-2004 14:31 CEST
======================================================================
Summary:                    Can not compile
Description: 
I try many motherboard (ati, ICH4, 5, Sis) all the same, can't compile in
the turbolinux 10. But I use the Redhat7.3 update to Kernel 2.6.2, every
is OK.




======================================================================

----------------------------------------------------------------------
 tiwai - 04-16-2004 11:49 CEST 
----------------------------------------------------------------------
more detailed information please.
what do you mean exactly 'can't compile' ?

----------------------------------------------------------------------
 pshou - 04-19-2004 05:21 CEST 
----------------------------------------------------------------------
I install the alsa-driver-1.0.4 in the TurboLinux 10 (fully install), then


::./configure
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
checking for current directory... /usr/src/linux-2.6.2/alsa-driver-1.0.4
checking cross compile... 
checking for directory with kernel source... /lib/modules/2.6.2-0.5/build
checking for kernel version... 2.6.2-0.5
checking for GCC version... Kernel compiler:  Used compiler: gcc (GCC)
3.3.1

*** NO PREDEFINED KERNEL COMPILER IS DETECTED
*** Assuming the same compiler is used with the current system compiler.

*** Please make sure that the same compiler version was used for building
kernel.

checking for built-in ALSA... "no"
checking for existing ALSA module... "yes"
checking for Red Hat kernel... "auto"
checking for Red Hat kernel... "no"
checking to modify of kernel linux/kmod.h... "no"
Removing a dummy linux/kmod.h.
checking for kernel linux/compiler.h... "yes"
Removing a dummy linux/compiler.h.
checking for kernel linux/pm.h... "yes"
checking for kernel linux/spinlock.h... "yes"
checking for kernel linux/irq.h... "yes"
Removing a dummy linux/irq.h.
checking for kernel linux/threads.h... "yes"
Removing a dummy linux/threads.h.
checking for kernel linux/rwsem.h... "yes"
Removing a dummy linux/rwsem.h.
checking for kernel linux/gameport.h... "yes"
Removing a dummy linux/gameport.h.
checking for kernel linux/devfs_fs_kernel.h... "yes"
checking for kernel linux/highmem.h... "yes"
Removing a dummy linux/highmem.h.
checking for kernel linux/workqueue.h... "yes"
Removing a dummy linux/workqueue.h.
checking for kernel linux/dma-mapping.h... "yes"
Removing a dummy linux/dma-mapping.h.
checking for kernel asm/hw_irq.h... "yes"
Removing a dummy asm/hw_irq.h.
checking for kernel linux/device.h... "yes"
Removing a dummy linux/device.h.
checking for kernel linux/jiffies.h... "yes"
Removing a dummy linux/jiffies.h.
checking for kernel linux/compat.h... "yes"
Removing a dummy linux/compat.h.
checking for kernel linux/adb.h... "yes"
Removing a dummy linux/adb.h.
checking for kernel linux/cuda.h... "yes"
Removing a dummy linux/cuda.h.
checking for kernel linux/pmu.h... "yes"
Removing a dummy linux/pmu.h.
checking for kernel module symbol versions... "no"
checking for PCI support in kernel... "yes"
checking for Experimental drivers in kernel... "yes"
checking for SGI/MIPS (HAL2) architecture... "no"
checking for directory to store kernel modules...
/lib/modules/2.6.2-0.5/kernel/sound
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... "yes"
checking for processor type... i586mmx
checking for i386 machine type... default
checking for SMP... "no"
checking for Video device support in kernel... "yes"
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... "no"
checking for Kernel ISA-PnP module support... "no"
checking for strlcpy... "yes"
checking for snprintf... "yes"
checking for scnprintf... "no"
checking for vmalloc_to_page... "yes"
checking for old kmod... "no"
checking for PDE... "yes"
checking for pci_set_consistent_dma_mask... "yes"
checking for tty->count is the atomic type... "no"
checking for video_get_drvdata... "yes"
Removing local linux/isapnp.h.
Removing local linux/pnp.h.
checking for driver version... 1.0.4
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... "yes"
checking for USB support... "yes"
checking for kernel PCMCIA
checking for PCMCIA support... "yes"
checking for PC9800 support in kernel... "no"
checking for which soundcards to compile driver for... all
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
Hacking autoconf.h...


::make

if [ ! -d include/sound -a ! -L include/sound ]; then \
  ln -sf ../alsa-kernel/include include/sound ; \
fi
cp -auvf include/version.h include/sound/version.h
‘include/version.h’ -> ‘include/sound/version.h’
make dep
make[1]: Entering directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4'
make[2]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/acore'
copying file alsa-kernel/core/info.c
patching file info.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000006 succeeded at 486 (offset -8 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000008 succeeded at 914 (offset -8 lines).
copying file alsa-kernel/core/pcm_native.c
patching file pcm_native.c
copying file alsa-kernel/core/control.c
patching file control.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 succeeded at 1198 (offset 270 lines).
copying file alsa-kernel/core/hwdep.c
patching file hwdep.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 308 (offset 16 lines).
copying file alsa-kernel/core/init.c
patching file init.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 succeeded at 196 (offset 2 lines).
copying file alsa-kernel/core/rawmidi.c
patching file rawmidi.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 1324 (offset 8 lines).
copying file alsa-kernel/core/sound.c
patching file sound.c
copying file alsa-kernel/core/timer.c
patching file timer.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 995 (offset 26 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 succeeded at 1754 (offset 21 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003 succeeded at 1787 (offset 6 lines).
copying file alsa-kernel/core/memalloc.c
patching file memalloc.c
oss
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/acore/oss'
copying file alsa-kernel/core/oss/mixer_oss.c
patching file mixer_oss.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 381 (offset 5 lines).
copying file alsa-kernel/core/oss/pcm_oss.c
patching file pcm_oss.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 2211 (offset 130 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 succeeded at 2259 (offset 8 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003 succeeded at 2529 (offset 130 lines).
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/acore/oss'
seq
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/acore/seq'
copying file alsa-kernel/core/seq/seq_clientmgr.c
patching file seq_clientmgr.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 succeeded at 2494 (offset 39 lines).
copying file alsa-kernel/core/seq/seq_memory.c
patching file seq_memory.c
instr
make[4]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/acore/seq/instr'
DUMMY
make[4]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/acore/seq/instr'
oss
make[4]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/acore/seq/oss'
copying file alsa-kernel/core/seq/oss/seq_oss.c
patching file seq_oss.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 197 (offset 3 lines).
DUMMY
make[4]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/acore/seq/oss'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/acore/seq'
DUMMY
make[2]: Leaving directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4/acore'
make[2]: Entering directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4/i2c'
other
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/i2c/other'
copying file alsa-kernel/i2c/other/tea575x-tuner.c
patching file tea575x-tuner.c
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/i2c/other'
DUMMY
make[2]: Leaving directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4/i2c'
make[2]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/drivers'
opl3
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/drivers/opl3'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/drivers/opl3'
opl4
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/drivers/opl4'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/drivers/opl4'
mpu401
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/drivers/mpu401'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/drivers/mpu401'
vx
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/drivers/vx'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/drivers/vx'
DUMMY
make[2]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/drivers'
make[2]: Entering directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa'
ad1816a
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/ad1816a'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/ad1816a'
ad1848
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/ad1848'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/ad1848'
cs423x
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/cs423x'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/cs423x'
es1688
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/es1688'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/es1688'
gus
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/gus'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/gus'
opti9xx
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/opti9xx'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/opti9xx'
sb
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/sb'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/sb'
wavefront
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/wavefront'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa/wavefront'
DUMMY
make[2]: Leaving directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4/isa'
make[2]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/synth'
emux
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/synth/emux'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/synth/emux'
DUMMY
make[2]: Leaving directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4/synth'
make[2]: Entering directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci'
copying file alsa-kernel/pci/cs4281.c
patching file cs4281.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 2116 (offset -3 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003 succeeded at 2216 (offset -3 lines).
copying file alsa-kernel/pci/es1968.c
patching file es1968.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 2462 (offset -6 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003 succeeded at 2862 (offset -19 lines).
copying file alsa-kernel/pci/intel8x0.c
patching file intel8x0.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 succeeded at 751 (offset 24 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000004 succeeded at 2223 (offset 80 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000006 succeeded at 2894 (offset 88 lines).
copying file alsa-kernel/pci/maestro3.c
patching file maestro3.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 2483 (offset 25 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003 succeeded at 2818 (offset 36 lines).
pdplus
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/pdplus'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/pdplus'
ac97
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/ac97'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/ac97'
ali5451
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/ali5451'
copying file alsa-kernel/pci/ali5451/ali5451.c
patching file ali5451.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 1978 (offset 15 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003 succeeded at 2342 (offset 15 lines).
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/ali5451'
au88x0
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/au88x0'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/au88x0'
cs46xx
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/cs46xx'
copying file alsa-kernel/pci/cs46xx/cs46xx.c
patching file cs46xx.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003 succeeded at 253 (offset 3 lines).
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/cs46xx'
emu10k1
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/emu10k1'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/emu10k1'
ice1712
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/ice1712'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/ice1712'
korg1212
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/korg1212'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/korg1212'
mixart
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/mixart'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/mixart'
nm256
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/nm256'
copying file alsa-kernel/pci/nm256/nm256.c
patching file nm256.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 1312 (offset 5 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003 succeeded at 1727 (offset 7 lines).
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/nm256'
rme9652
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/rme9652'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/rme9652'
trident
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/trident'
copying file alsa-kernel/pci/trident/trident.c
patching file trident.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 183 (offset 1 line).
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/trident'
ymfpci
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/ymfpci'
copying file alsa-kernel/pci/ymfpci/ymfpci.c
patching file ymfpci.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 317 (offset 68 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003 succeeded at 407 (offset 68 lines).
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/ymfpci'
vx222
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/vx222'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci/vx222'
DUMMY
make[2]: Leaving directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4/pci'
make[2]: Entering directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4/usb'
copying file alsa-kernel/usb/usbaudio.c
patching file usbaudio.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003 succeeded at 1895 (offset 128 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000005 succeeded at 3097 (offset 166 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000007 succeeded at 3163 (offset 166 lines).
usx2y
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/usb/usx2y'
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/usb/usx2y'
DUMMY
make[2]: Leaving directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4/usb'
make[2]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pcmcia'
vx
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pcmcia/vx'
copying file alsa-kernel/pcmcia/vx/vx_entry.c
patching file vx_entry.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 succeeded at 151 (offset 4 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000004 succeeded at 333 (offset 4 lines).
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pcmcia/vx'
pdaudiocf
make[3]: Entering directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pcmcia/pdaudiocf'
copying file alsa-kernel/pcmcia/pdaudiocf/pdaudiocf.c
patching file pdaudiocf.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 18 with fuzz 2.
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 succeeded at 78 (offset -1 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000004 succeeded at 280 (offset -1 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000006 succeeded at 449 (offset -1 lines).
DUMMY
make[3]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pcmcia/pdaudiocf'
DUMMY
make[2]: Leaving directory
`/usr/src/linux-2.6.2/alsa-driver-1.0.4/pcmcia'
make[1]: Leaving directory `/usr/src/linux-2.6.2/alsa-driver-1.0.4'
make -C /lib/modules/2.6.2-0.5/build
SUBDIRS=/usr/src/linux-2.6.2/alsa-driver-1.0.4/kbuild modules
make[1]: Entering directory `/usr/src/linux-2.6.2'

The present kernel configuration has modules disabled.
Type 'make config' and enable loadable module support.
Then build a kernel with module support enabled.

make[1]: Leaving directory `/usr/src/linux-2.6.2'

----------------------------------------------------------------------
 tiwai - 04-23-2004 17:41 CEST 
----------------------------------------------------------------------
your kernel doesn't support the module.
rebuild whole your kernel is the only way.

----------------------------------------------------------------------
 pshou - 04-27-2004 09:23 CEST 
----------------------------------------------------------------------
Thanks very much, I can compile the ALSA driver in the TurboLinux 10.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-15-04 11:17 pshou          New Bug                                      
04-15-04 11:17 pshou          Kernel Version            => 2.6.2-05        
04-16-04 11:49 tiwai          Bugnote Added: 0000830                       
04-19-04 05:21 pshou          Bugnote Added: 0000852                       
04-19-04 15:34 perex          Assigned To              perex =>            
04-19-04 15:35 perex          Status                   assigned => new     
04-23-04 17:41 tiwai          Bugnote Added: 0000912                       
04-27-04 09:23 pshou          Bugnote Added: 0000958                       
04-27-04 09:23 pshou          Bug Monitored: pshou                         
04-27-04 09:24 pshou          Bug End Monitor: pshou                       
04-27-04 12:23 tiwai          Assigned To               => tiwai           
04-27-04 12:23 tiwai          Resolution               open => fixed       
04-27-04 12:23 tiwai          Status                   new => resolved     
07-16-04 14:31 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
