From: Srinath M <msrinath80@yahoo.com>
Subject: cvscompile fails on pcm_native.c
Date: Sat, 3 Jul 2004 22:16:06 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040704051606.44136.qmail@web51402.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

I've been getting this error while doing a ./cvscompile
--with-cards=emu10k1x

Any Suggestions?

-pUl|

PS: Here is the full transcript of cvscompile.

----------------------------------------------
[srinath@F106-6 alsacvs]$ cd alsa-driver/
[srinath@F106-6 alsa-driver]$ ./cvscompile --with-cards=emu10k1x find:
/home/srinath/alsacvs/alsa-driver/alsa-kernel/: No such file or
directory
find: /home/srinath/alsacvs/alsa-driver/alsa-kernel/: No such file or
directory
find: /home/srinath/alsacvs/alsa-driver/alsa-kernel/: No such file or
directory
ln -sf ../alsa-kernel alsa-kernel
ln -sf alsa-kernel sound
ln -sf alsa-kernel/scripts scripts
gcc utils/mod-deps.c -o utils/mod-deps
utils/mod-deps --basedir /home/srinath/alsacvs/alsa-driver/alsa-kernel
--hiddendir /home/srinath/alsacvs/alsa-driver --makeconf >
toplevel.config.in
utils/mod-deps --basedir /home/srinath/alsacvs/alsa-driver/alsa-kernel
--hiddendir /home/srinath/alsacvs/alsa-driver --acinclude >
acinclude.m4
utils/mod-deps --basedir /home/srinath/alsacvs/alsa-driver/alsa-kernel
--hiddendir /home/srinath/alsacvs/alsa-driver --include >
include/config1.h.in
/usr/local/share/aclocal/audiofile.m4:12: warning: underquoted
definition of AM_PATH_AUDIOFILE
  run info '(automake)Extending aclocal'
  or see
http://sources.redhat.com/automake/automake.html#Extending%20aclocal
/usr/local/share/aclocal/ao.m4:9: warning: underquoted definition of
XIPH_PATH_AO
./configure --with-cards=emu10k1x
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
checking for current directory... /home/srinath/alsacvs/alsa-driver
checking cross compile...
checking for directory with kernel source...
/lib/modules/2.4.20-8/build
checking for kernel version... 2.4.20-8
checking for GCC version... Kernel compiler: gcc 3.2.2 20030222 (Red
Hat Linux 3.2.2-5) Used compiler: gcc (GCC) 3.2.2 20030222 (Red Hat
Linux 3.2.2-5)
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
checking for kernel linux/dma-mapping.h... "no"
Creating a dummy <linux/dma-mapping.h>...
checking for kernel asm/hw_irq.h... "yes"
checking for kernel linux/device.h... "no"
Creating a dummy <linux/device.h>...
checking for kernel linux/jiffies.h... "no"
Creating <linux/jiffies.h>...
checking for kernel linux/compat.h... "no"
Creating <linux/compat.h>...
checking for kernel linux/adb.h... "yes"
checking for kernel linux/cuda.h... "yes"
checking for kernel linux/pmu.h... "yes"
checking for kernel linux/moduleparam.h... "no"
Creating a dummy <linux/moduleparam.h>...
checking for kernel linux/syscalls.h... "no"
Creating <linux/syscalls.h>...
checking for exported symbol dump_stack... "yes"
checking for kernel module symbol versions... "no"
checking for PCI support in kernel... "yes"
checking for Experimental drivers in kernel... "yes"
checking for SGI/MIPS (HAL2) architecture... "no"
checking for directory to store kernel modules...
/lib/modules/2.4.20-8/kernel/sound
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... "yes"
checking for processor type... i686
checking for SMP... "no"
checking for Video device support in kernel... "yes"
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... no
checking for Kernel ISA-PnP support... "yes"
checking for ISA PnP support... yes
checking for strlcpy... "no"
checking for snprintf... "yes"
checking for scnprintf... "no"
checking for vmalloc_to_page... "yes"
checking for old kmod... "yes"
checking for PDE... "no"
checking for pci_set_consistent_dma_mask... "no"
checking for tty->count is the atomic type... "no"
checking for video_get_drvdata... "no"
checking for kcalloc... "no"
Symlinking <linux/pnp.h>...
checking for driver version... 1.0.5a
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... "no"
checking for USB support... "yes"
checking for kernel PCMCIA
checking for PCMCIA support... "yes"
checking for PC9800 support in kernel... "no"
checking for which soundcards to compile driver for... emu10k1x
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
config.status: creating include/autoconf-extra.h
if [ ! -d include/sound -a ! -L include/sound ]; then \
  ln -sf ../alsa-kernel/include include/sound ; \
fi
cp -auvf include/version.h include/sound/version.h
`include/version.h' -> `include/sound/version.h'
make[1]: Entering directory `/home/srinath/alsacvs/alsa-driver/acore'
make  -C ioctl32 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/acore/ioctl32'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/acore/ioctl32'
make  -C oss fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/acore/oss'
copying file alsa-kernel/core/oss/mixer_oss.c
patching file mixer_oss.c
Hunk #1 succeeded at 383 (offset 7 lines).
copying file alsa-kernel/core/oss/pcm_oss.c
patching file pcm_oss.c
Hunk #1 succeeded at 2216 (offset 3 lines).
Hunk #3 succeeded at 2521 (offset 3 lines).
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/home/srinath/alsacvs/alsa-driver/include 
-I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include
-I/home/srinath/alsacvs/alsa-driver/alsa-kernel/core/oss
-fno-omit-frame-pointer mixer_oss.c pcm_oss.c pcm_plugin.c io.c copy.c
linear.c mulaw.c route.c rate.c > .depend
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/acore/oss'
make  -C seq fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/acore/seq'
make  -C instr fastdep
make[3]: Entering directory
`/home/srinath/alsacvs/alsa-driver/acore/seq/instr'
make[3]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/acore/seq/instr'
make  -C oss fastdep
make[3]: Entering directory
`/home/srinath/alsacvs/alsa-driver/acore/seq/oss'
copying file alsa-kernel/core/seq/oss/seq_oss.c
patching file seq_oss.c
Hunk #1 succeeded at 197 (offset 3 lines).
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/home/srinath/alsacvs/alsa-driver/include 
-I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include
-I/home/srinath/alsacvs/alsa-driver/alsa-kernel/core/seq/oss seq_oss.c
seq_oss_init.c seq_oss_timer.c seq_oss_ioctl.c seq_oss_event.c
seq_oss_rw.c seq_oss_synth.c seq_oss_midi.c seq_oss_readq.c
seq_oss_writeq.c > .depend
make[3]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/acore/seq/oss'
copying file alsa-kernel/core/seq/seq.c
patching file seq.c
Hunk #1 succeeded at 51 with fuzz 2 (offset 2 lines).
copying file alsa-kernel/core/seq/seq_clientmgr.c
patching file seq_clientmgr.c
Hunk #2 succeeded at 2494 (offset 39 lines).
copying file alsa-kernel/core/seq/seq_memory.c
patching file seq_memory.c
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/home/srinath/alsacvs/alsa-driver/include 
-I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include
-I/home/srinath/alsacvs/alsa-driver/alsa-kernel/core/seq seq.c
seq_lock.c seq_clientmgr.c seq_memory.c seq_queue.c seq_fifo.c
seq_prioq.c seq_timer.c seq_system.c seq_ports.c seq_info.c
seq_device.c seq_midi_event.c > .depend
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/acore/seq'
copying file alsa-kernel/core/sound.c
patching file sound.c
Hunk #1 succeeded at 65 (offset -4 lines).
Hunk #3 succeeded at 380 (offset -4 lines).
Hunk #5 succeeded at 535 (offset -1 lines).
copying file alsa-kernel/core/init.c
patching file init.c
Hunk #3 succeeded at 785 with fuzz 1 (offset 23 lines).
copying file alsa-kernel/core/info.c
patching file info.c
Hunk #4 succeeded at 144 with fuzz 2.
Hunk #6 succeeded at 484 (offset -10 lines).
Hunk #8 succeeded at 912 (offset -10 lines).
copying file alsa-kernel/core/control.c
patching file control.c
Hunk #2 succeeded at 1224 (offset 296 lines).
copying file alsa-kernel/core/timer.c
patching file timer.c
Hunk #1 succeeded at 995 (offset 26 lines).
Hunk #2 succeeded at 1771 (offset 38 lines).
Hunk #3 succeeded at 1787 (offset 6 lines).
copying file alsa-kernel/core/pcm_native.c
patching file pcm_native.c
copying file alsa-kernel/core/memalloc.c
patching file memalloc.c
Hunk #2 succeeded at 96 (offset 4 lines).
Hunk #4 succeeded at 212 (offset 4 lines).
Hunk #6 succeeded at 922 (offset 4 lines).
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/home/srinath/alsacvs/alsa-driver/include 
-I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include  sound.c init.c memory.c info.c
control.c misc.c device.c wrappers.c isadma.c sound_oss.c info_oss.c
timer.c pcm.c pcm_native.c pcm_lib.c pcm_timer.c pcm_misc.c
pcm_memory.c memalloc.c sgbuf.c memory_wrapper.c > .depend
make[1]: Leaving directory `/home/srinath/alsacvs/alsa-driver/acore'
make[1]: Entering directory `/home/srinath/alsacvs/alsa-driver/i2c'
make  -C other fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/i2c/other'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/i2c/other'
make[1]: Leaving directory `/home/srinath/alsacvs/alsa-driver/i2c'
make[1]: Entering directory `/home/srinath/alsacvs/alsa-driver/drivers'
make  -C mpu401 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/drivers/mpu401'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/drivers/mpu401'
make  -C opl3 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/drivers/opl3'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/drivers/opl3'
make  -C opl4 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/drivers/opl4'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/drivers/opl4'
make  -C vx fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/drivers/vx'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/drivers/vx'
make[1]: Leaving directory `/home/srinath/alsacvs/alsa-driver/drivers'
make[1]: Entering directory `/home/srinath/alsacvs/alsa-driver/isa'
make  -C ad1816a fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/isa/ad1816a'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/isa/ad1816a'
make  -C ad1848 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/isa/ad1848'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/isa/ad1848'
make  -C cs423x fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/isa/cs423x'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/isa/cs423x'
make  -C es1688 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/isa/es1688'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/isa/es1688'
make  -C gus fastdep
make[2]: Entering directory `/home/srinath/alsacvs/alsa-driver/isa/gus'
make[2]: Leaving directory `/home/srinath/alsacvs/alsa-driver/isa/gus'
make  -C msnd fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/isa/msnd'
make[2]: Leaving directory `/home/srinath/alsacvs/alsa-driver/isa/msnd'
make  -C opti9xx fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/isa/opti9xx'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/isa/opti9xx'
make  -C sb fastdep
make[2]: Entering directory `/home/srinath/alsacvs/alsa-driver/isa/sb'
make[2]: Leaving directory `/home/srinath/alsacvs/alsa-driver/isa/sb'
make  -C wavefront fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/isa/wavefront'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/isa/wavefront'
make[1]: Leaving directory `/home/srinath/alsacvs/alsa-driver/isa'
make[1]: Entering directory `/home/srinath/alsacvs/alsa-driver/synth'
make  -C emux fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/synth/emux'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/synth/emux'
make[1]: Leaving directory `/home/srinath/alsacvs/alsa-driver/synth'
make[1]: Entering directory `/home/srinath/alsacvs/alsa-driver/support'
make  -C pnp fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/support/pnp'
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/home/srinath/alsacvs/alsa-driver/include 
-I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include  pnp.c > .depend
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/support/pnp'
make[1]: Leaving directory `/home/srinath/alsacvs/alsa-driver/support'
make[1]: Entering directory `/home/srinath/alsacvs/alsa-driver/pci'
make  -C ac97 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/ac97'
copying file alsa-kernel/pci/ac97/ac97_proc.c
patching file ac97_proc.c
Hunk #3 succeeded at 322 with fuzz 1.
Hunk #4 succeeded at 341 with fuzz 1 (offset 2 lines).
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/home/srinath/alsacvs/alsa-driver/include 
-I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include  ac97_codec.c ac97_pcm.c ac97_proc.c
ac97_patch.c > .depend
make[2]: Leaving directory `/home/srinath/alsacvs/alsa-driver/pci/ac97'
make  -C ali5451 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/ali5451'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/ali5451'
make  -C au88x0 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/au88x0'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/au88x0'
make  -C cs46xx fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/cs46xx'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/cs46xx'
make  -C emu10k1 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/emu10k1'
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/home/srinath/alsacvs/alsa-driver/include 
-I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include  emu10k1x.c > .depend
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/emu10k1'
make  -C ice1712 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/ice1712'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/ice1712'
make  -C korg1212 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/korg1212'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/korg1212'
make  -C mixart fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/mixart'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/mixart'
make  -C nm256 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/nm256'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/nm256'
make  -C pdplus fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/pdplus'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/pdplus'
make  -C rme9652 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/rme9652'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/rme9652'
make  -C trident fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/trident'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/trident'
make  -C vx222 fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/vx222'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/vx222'
make  -C ymfpci fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pci/ymfpci'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pci/ymfpci'
make[1]: Leaving directory `/home/srinath/alsacvs/alsa-driver/pci'
make[1]: Entering directory `/home/srinath/alsacvs/alsa-driver/usb'
make  -C usx2y fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/usb/usx2y'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/usb/usx2y'
make[1]: Leaving directory `/home/srinath/alsacvs/alsa-driver/usb'
make[1]: Entering directory `/home/srinath/alsacvs/alsa-driver/pcmcia'
make  -C pdaudiocf fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pcmcia/pdaudiocf'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pcmcia/pdaudiocf'
make  -C vx fastdep
make[2]: Entering directory
`/home/srinath/alsacvs/alsa-driver/pcmcia/vx'
make[2]: Leaving directory
`/home/srinath/alsacvs/alsa-driver/pcmcia/vx'
make[1]: Leaving directory `/home/srinath/alsacvs/alsa-driver/pcmcia'
make[1]: Entering directory `/home/srinath/alsacvs/alsa-driver/acore'
copying file alsa-kernel/core/rawmidi.c
patching file rawmidi.c
Hunk #1 succeeded at 1326 (offset 10 lines).
copying file alsa-kernel/core/hwdep.c
patching file hwdep.c
Hunk #1 succeeded at 309 (offset 17 lines).
gcc -D__KERNEL__ -DMODULE=1 -I/home/srinath/alsacvs/alsa-driver/include
 -I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include   -DEXPORT_SYMTAB -c memalloc.c
memalloc.c:53: warning: `boot_devs' defined but not used
gcc -D__KERNEL__ -DMODULE=1 -I/home/srinath/alsacvs/alsa-driver/include
 -I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include  -DKBUILD_BASENAME=sgbuf   -c -o sgbuf.o
sgbuf.c
gcc -D__KERNEL__ -DMODULE=1 -I/home/srinath/alsacvs/alsa-driver/include
 -I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include  -DKBUILD_BASENAME=memory_wrapper   -c
-o memory_wrapper.o memory_wrapper.c
gcc -D__KERNEL__ -DMODULE=1 -I/home/srinath/alsacvs/alsa-driver/include
 -I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include   -DEXPORT_SYMTAB -c pcm.c
gcc -D__KERNEL__ -DMODULE=1 -I/home/srinath/alsacvs/alsa-driver/include
 -I/lib/modules/2.4.20-8/build/include -O2 -mpreferred-stack-boundary=2
-march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include  -DKBUILD_BASENAME=pcm_native   -c -o
pcm_native.o pcm_native.c
pcm_native.c: In function `snd_pcm_mmap_data':
pcm_native.c:3176: warning: passing arg 1 of `remap_page_range' makes
pointer from integer without a cast
pcm_native.c:3176: incompatible type for argument 4 of
`remap_page_range'
pcm_native.c:3176: too few arguments to function `remap_page_range'
make[1]: *** [pcm_native.o] Error 1
make[1]: Leaving directory `/home/srinath/alsacvs/alsa-driver/acore'
make: *** [compile] Error 1
[srinath@F106-6 alsa-driver]$
----------------------------------------------


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
