From: Carlo Wood <carlo@alinoe.com>
Subject: Re: ALSA (CVS) doesn't compile on recent linux (alsa-driver)
Date: Fri, 18 Jul 2003 16:55:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030718145558.GC9756@alinoe.com>
References: <20030718123133.GB9756@alinoe.com> <s5hhe5jkiwx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hhe5jkiwx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 18, 2003 at 04:29:18PM +0200, Takashi Iwai wrote:
> known bug.
> 
> for compiling on 2.5/2.6 kernels, try to copy the files in alsa-kernel
> into the kernel tree.

That didn't change a thing.

I copied the files of alsa-kernel to the kernel tree:

/usr/src/alsa/alsa-kernel>tar cf - --exclude CVS --exclude Documentation . | tar -C /usr/src/linux-2.5.74-debug/sound -xvf -
./
./Makefile
./Kconfig
./sound_core.c
./last.c
[...etc etc...]

and then

/usr/src/alsa/alsa-kernel>cd ..
/usr/src/alsa>make
rm -rf /usr/doc/packages/alsa
mkdir -p /usr/doc/packages/alsa
for i in driver utils; do                               \
        cp alsa-$i*/README /usr/doc/packages/alsa/README.$i;    \
done
for i in FAQ INSTALL doc/SOUNDCARDS; do                 \
        cp alsa-driver*/$i /usr/doc/packages/alsa;                      \
done
cp alsa-utils*/alsamixer/README                 /usr/doc/packages/alsa.alsamixer
cp alsa-utils*/seq/aconnect/README.aconnect     /usr/doc/packages/alsa
cp alsa-utils*/seq/aseqnet/README.aseqnet       /usr/doc/packages/alsa
find /usr/doc/packages/alsa
/usr/doc/packages/alsa
/usr/doc/packages/alsa/README.driver
/usr/doc/packages/alsa/README.utils
/usr/doc/packages/alsa/FAQ
/usr/doc/packages/alsa/INSTALL
/usr/doc/packages/alsa/SOUNDCARDS
/usr/doc/packages/alsa/README.aconnect
/usr/doc/packages/alsa/README.aseqnet
cd alsa-driver*;                                        \
CFLAGS="" ./cvscompile --with-smp=no --with-processor="i686" --with-isapnp=yes --with-sequencer=yes --with-oss=yes --mandir=/usr/share/man --infodir=/usr/share/info;        \
install -m 755 utils/alsasound /sbin/init.d/alsasound;  \
make install
make[1]: Entering directory `/usr/src/alsa/alsa-driver'
make[1]: Nothing to be done for `all-deps'.
make[1]: Leaving directory `/usr/src/alsa/alsa-driver'
./configure --with-smp=no --with-processor=i686 --with-isapnp=yes --with-sequencer=yes --with-oss=yes --mandir=/usr/share/man --infodir=/usr/share/info
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
checking for current directory... /usr/src/alsa/alsa-driver
checking cross compile...
checking for directory with kernel source... /lib/modules/2.5.74-debug/build
checking for kernel version... 2.5.74-debug
checking for GCC version... Kernel compiler: gcc 3.2.3 20030422 (Red Hat Linux 3.2.3-4) Used compiler: gcc (GCC) 3.2.3 20030422 (Red Hat Linux 3.2.3-4)
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
checking for kernel asm/hw_irq.h... "yes"
checking for kernel linux/jiffies.h... "yes"
checking for kernel linux/compat.h... "yes"
checking for kernel linux/adb.h... "yes"
checking for kernel linux/cuda.h... "yes"
checking for kernel linux/pmu.h... "yes"
checking for kernel module symbol versions... "no"
checking for PCI support in kernel... "yes"
checking for SGI/MIPS (HAL2) architecture... "no"
checking for directory to store kernel modules... /lib/modules/2.5.74-debug/kernel/sound
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... "yes"
checking for processor type... k7
checking for i386 machine type... default
checking for SMP... "no"
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... "no"
checking for Kernel ISA-PnP module support... "no"
checking for strlcpy... "no"
checking for snprintf... "yes"
checking for vmalloc_to_page... "no"
checking for old kmod... "yes"
checking for driver version... 0.9.5
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... "yes"
checking for USB support... "yes"
checking for kernel PCMCIA
checking for PCMCIA support... "no"
checking for PCMCIA module support... "no"
checking for PC9800 support in kernel... "no"
checking for which soundcards to compile driver for... all
configure: creating ./config.status
config.status: creating version
config.status: creating Makefile.conf
config.status: creating snddevices
config.status: creating utils/alsa-driver.spec
config.status: creating utils/buildrpm
config.status: creating toplevel.config
config.status: creating include/config.h
config.status: include/config.h is unchanged
config.status: creating include/config1.h
config.status: include/config1.h is unchanged
config.status: creating include/version.h
config.status: include/version.h is unchanged
make[1]: Entering directory `/usr/src/alsa/alsa-driver'
make[2]: Entering directory `/usr/src/alsa/alsa-driver/support'
make[2]: Leaving directory `/usr/src/alsa/alsa-driver/support'
make[2]: Entering directory `/usr/src/alsa/alsa-driver/acore'
make  -C ioctl32 fastdep
make[3]: Entering directory `/usr/src/alsa/alsa-driver/acore/ioctl32'
make[3]: Leaving directory `/usr/src/alsa/alsa-driver/acore/ioctl32'
make  -C oss fastdep
make[3]: Entering directory `/usr/src/alsa/alsa-driver/acore/oss'
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1 -I/usr/src/alsa/alsa-driver/include  -I/lib/modules/2.5.74-debug/build/include -O2 -mpreferred-stack-boundary=2 -march=athlon -I/lib/modules/2.5.74-debug/build/include/asm-i386/mach-default -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -I/usr/src/alsa/alsa-driver/alsa-kernel/core/oss mixer_oss.c pcm_oss.c pcm_plugin.c io.c copy.c linear.c mulaw.c route.c rate.c > .depend
make[3]: Leaving directory `/usr/src/alsa/alsa-driver/acore/oss'
make  -C seq fastdep
make[3]: Entering directory `/usr/src/alsa/alsa-driver/acore/seq'
make  -C instr fastdep
make[4]: Entering directory `/usr/src/alsa/alsa-driver/acore/seq/instr'
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1 -I/usr/src/alsa/alsa-driver/include  -I/lib/modules/2.5.74-debug/build/include -O2 -mpreferred-stack-boundary=2 -march=athlon -I/lib/modules/2.5.74-debug/build/include/asm-i386/mach-default -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  ainstr_fm.c ainstr_gf1.c ainstr_iw.c ainstr_simple.c > .depend
make[4]: Leaving directory `/usr/src/alsa/alsa-driver/acore/seq/instr'
make  -C oss fastdep
make[4]: Entering directory `/usr/src/alsa/alsa-driver/acore/seq/oss'
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1 -I/usr/src/alsa/alsa-driver/include  -I/lib/modules/2.5.74-debug/build/include -O2 -mpreferred-stack-boundary=2 -march=athlon -I/lib/modules/2.5.74-debug/build/include/asm-i386/mach-default -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -I/usr/src/alsa/alsa-driver/alsa-kernel/core/seq/oss seq_oss.c seq_oss_init.c seq_oss_timer.c seq_oss_ioctl.c seq_oss_event.c seq_oss_rw.c seq_oss_synth.c seq_oss_midi.c seq_oss_readq.c seq_oss_writeq.c > .depend
make[4]: Leaving directory `/usr/src/alsa/alsa-driver/acore/seq/oss'
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1 -I/usr/src/alsa/alsa-driver/include  -I/lib/modules/2.5.74-debug/build/include -O2 -mpreferred-stack-boundary=2 -march=athlon -I/lib/modules/2.5.74-debug/build/include/asm-i386/mach-default -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -I/usr/src/alsa/alsa-driver/alsa-kernel/core/seq seq_device.c seq_dummy.c seq_instr.c seq_midi_emul.c seq_midi_event.c seq_midi.c seq_virmidi.c seq.c seq_lock.c seq_clientmgr.c seq_memory.c seq_queue.c seq_fifo.c seq_prioq.c seq_timer.c seq_system.c seq_ports.c seq_info.c > .depend

[...cut...]

make[2]: Entering directory `/usr/src/alsa/alsa-driver/drivers'
gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa/alsa-driver/include  -I/lib/modules/2.5.74-debug/build/include -O2 -mpreferred-stack-boundary=2 -march=athlon -I/lib/modules/2.5.74-debug/build/include/asm-i386/mach-default -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  -DKBUILD_BASENAME=serialmidi   -c -o serialmidi.o serialmidi.c
serialmidi.c:46: warning: type defaults to `int' in declaration of `EXPORT_NO_SYMBOLS'
serialmidi.c:46: warning: data definition has no type or storage class
serialmidi.c: In function `open_tty':
serialmidi.c:139: warning: passing arg 2 of `set_bit' from incompatible pointer type
serialmidi.c:153: request for member `set_termios' in something not a structure or union
serialmidi.c:218: request for member `set_termios' in something not a structure or union
serialmidi.c:234: warning: passing arg 2 of `set_bit' from incompatible pointer type
serialmidi.c: In function `close_tty':
serialmidi.c:255: warning: passing arg 2 of `clear_bit' from incompatible pointer type
serialmidi.c:256: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
serialmidi.c:256: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
serialmidi.c: In function `ldisc_receive_buf':
serialmidi.c:283: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
serialmidi.c:283: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
serialmidi.c: In function `tx_loop':
serialmidi.c:298: request for member `write_room' in something not a structure or union
serialmidi.c:306: request for member `write' in something not a structure or union
serialmidi.c: In function `snd_serialmidi_output_trigger':
serialmidi.c:328: warning: passing arg 2 of `set_bit' from incompatible pointer type
serialmidi.c:333: warning: passing arg 2 of `clear_bit' from incompatible pointer type
serialmidi.c: In function `snd_serialmidi_input_trigger':
serialmidi.c:342: warning: passing arg 2 of `set_bit' from incompatible pointer type
serialmidi.c:344: warning: passing arg 2 of `clear_bit' from incompatible pointer type
make[2]: *** [serialmidi.o] Error 1


How does copying alsa-kernel help compiling alsa-driver?

Note that correctly

>ls -l /lib/modules/2.5.74-debug/build
lrwxr-xr-x    1 root     root           27 Jul 13 15:52 /lib/modules/2.5.74-debug/build -> /usr/src/linux-2.5.74-debug

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
