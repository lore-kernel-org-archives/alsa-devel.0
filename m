From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Trying to get alsa-driver to build on a 2.6.x kernel.
Date: Thu, 29 Jan 2004 19:49:00 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <401963AC.8080603@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060006010705000309050309"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060006010705000309050309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have been told that one should be able to build alsa-driver on a 2.6.x 
kernel, but it fails here.

I attach config.log for your information.
I also attach the console output from running
./configure --with-cards=emu10k1,intel8x0,usb-audio

Can anyone help?

Cheers
James

--------------060006010705000309050309
Content-Type: text/plain;
 name="console-out.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="console-out.txt"

loading cache ./config.cache
checking for gcc... (cached) gcc
checking whether the C compiler (gcc  ) works... yes
checking whether the C compiler (gcc  ) is a cross-compiler... no
checking whether we are using GNU C... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for ranlib... (cached) ranlib
checking for a BSD compatible install... (cached) /usr/bin/install -c
checking how to run the C preprocessor... (cached) gcc -E
checking for ANSI C header files... (cached) yes
checking for working const... (cached) yes
checking for inline... (cached) inline
checking whether time.h and sys/time.h may both be included... (cached) yes
checking whether gcc needs -traditional... (cached) no
checking for current directory... /usr/local/alsacvs/alsa-driver
checking cross compile... 
checking for directory with kernel source... /lib/modules/2.6.2-rc2/build
checking for kernel version... 2.6.2-rc2
checking for GCC version... Kernel compiler: gcc 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7) Used compiler: gcc (GCC) 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)
checking for built-in ALSA... no
checking for existing ALSA module... yes
checking for Red Hat kernel... auto
checking for Red Hat kernel... no
checking to modify of kernel linux/kmod.h... no
checking for kernel linux/compiler.h... yes
checking for kernel linux/pm.h... yes
checking for kernel linux/spinlock.h... yes
checking for kernel linux/irq.h... yes
checking for kernel linux/threads.h... yes
checking for kernel linux/rwsem.h... yes
checking for kernel linux/gameport.h... yes
checking for kernel linux/devfs_fs_kernel.h... yes
checking for kernel linux/highmem.h... yes
checking for kernel linux/workqueue.h... yes
checking for kernel asm/hw_irq.h... yes
checking for kernel linux/device.h... yes
checking for kernel linux/jiffies.h... yes
checking for kernel linux/compat.h... yes
checking for kernel linux/adb.h... yes
checking for kernel linux/cuda.h... yes
checking for kernel linux/pmu.h... yes
checking for kernel module symbol versions... no
checking for PCI support in kernel... yes
checking for SGI/MIPS (HAL2) architecture... no
checking for directory to store kernel modules... /lib/modules/2.6.2-rc2/kernel/sound
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... yes
checking for processor type... i686
checking for i386 machine type... default
checking for SMP... yes
checking for Video device support in kernel... yes
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... no
checking for Kernel ISA-PnP module support... no
checking for strlcpy... yes
checking for snprintf... yes
checking for vmalloc_to_page... no
checking for old kmod... no
checking for PDE... no
checking for pci_set_consistent_dma_mask... no
checking for tty->count is the atomic type... no
checking for driver version... 1.0.2
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... yes
checking for USB support... yes
checking for kernel PCMCIA
checking for PCMCIA support... no
checking for PCMCIA module support... no
checking for PC9800 support in kernel... no
checking for which soundcards to compile driver for... emu10k1 intel8x0 usb-audio
creating ./config.status
creating version
creating Makefile.conf
creating snddevices
creating utils/alsa-driver.spec
creating utils/buildrpm
creating toplevel.config
creating utils/alsasound
creating utils/alsasound.posix
creating include/config.h
include/config.h is unchanged
creating include/config1.h
include/config1.h is unchanged
creating include/version.h
include/version.h is unchanged
creating include/autoconf-extra.h
include/autoconf-extra.h is unchanged
Hacking autoconf.h...
./configure: line 5755: include/linux/autoconf.h: No such file or directory
./configure: line 5756: include/linux/autoconf.h: No such file or directory
./configure: line 5757: include/linux/autoconf.h: No such file or directory

--------------060006010705000309050309
Content-Type: text/plain;
 name="config.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config.log"

This file contains any messages produced by compilers while
running configure, to aid debugging if configure makes a mistake.

configure:577: checking for gcc
configure:690: checking whether the C compiler (gcc  ) works
configure:706: gcc -o conftest    conftest.c  1>&5
configure:732: checking whether the C compiler (gcc  ) is a cross-compiler
configure:737: checking whether we are using GNU C
configure:765: checking whether gcc accepts -g
configure:799: checking for ranlib
configure:857: checking for a BSD compatible install
configure:916: checking how to run the C preprocessor
configure:996: checking for ANSI C header files
configure:1102: checking for working const
configure:1177: checking for inline
configure:1217: checking whether time.h and sys/time.h may both be included
configure:1254: checking whether gcc needs -traditional
configure:1301: checking for current directory
configure:1307: checking cross compile
configure:1333: checking for directory with kernel source
configure:1356: checking for kernel version
configure:1417: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:1452: checking for GCC version
configure:1498: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:1650: checking for built-in ALSA
configure:1672: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure: failed program was:
#line 1659 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#ifndef CONFIG_SND
  exit(1);
#else
  exit(0);
#endif
}

configure:1694: checking for existing ALSA module
configure:1716: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:1737: checking for Red Hat kernel
configure:1760: checking for Red Hat kernel
configure:1782: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure: failed program was:
#line 1769 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(RED_HAT_LINUX_KERNEL) && !defined(RED_HAT_LINUX_KERNEL_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:1802: checking to modify of kernel linux/kmod.h
configure:1821: checking for kernel linux/compiler.h
configure:1847: checking for kernel linux/pm.h
configure:1873: checking for kernel linux/spinlock.h
configure:1899: checking for kernel linux/irq.h
configure:1925: checking for kernel linux/threads.h
configure:1951: checking for kernel linux/rwsem.h
configure:1977: checking for kernel linux/gameport.h
configure:2003: checking for kernel linux/devfs_fs_kernel.h
configure:2029: checking for kernel linux/highmem.h
configure:2055: checking for kernel linux/workqueue.h
configure:2090: checking for kernel asm/hw_irq.h
configure:2116: checking for kernel linux/device.h
configure:2142: checking for kernel linux/jiffies.h
configure:2170: checking for kernel linux/compat.h
configure:2198: checking for kernel linux/adb.h
configure:2226: checking for kernel linux/cuda.h
configure:2254: checking for kernel linux/pmu.h
configure:2285: checking for kernel module symbol versions
configure:2307: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure: failed program was:
#line 2294 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_MODVERSIONS) && !defined(CONFIG_MODVERSIONS_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:2330: checking for PCI support in kernel
configure:2352: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:2370: checking for SGI/MIPS (HAL2) architecture
configure:2384: checking for directory to store kernel modules
configure:2413: checking for verbose printk
configure:2437: checking for debug level
configure:2509: checking for ISA support in kernel
configure:2531: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:2551: checking for processor type
configure:2649: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:2858: checking for i386 machine type
configure:2896: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:2939: checking for SMP
configure:2961: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:2989: checking for Video device support in kernel
configure:3011: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:3029: checking for ISA PnP driver in kernel
configure:3044: checking for PnP driver in kernel
configure:3063: checking for Kernel ISA-PnP support
configure:3085: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure: failed program was:
#line 3072 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_ISAPNP) && !defined(CONFIG_ISAPNP_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:3105: checking for Kernel ISA-PnP module support
configure:3127: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure: failed program was:
#line 3114 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_ISAPNP_MODULE) && !defined(CONFIG_ISAPNP_MODULE_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:3194: checking for strlcpy
configure:3214: gcc -c -Wall -Werror -g -O2 -I/lib/modules/2.6.2-rc2/build/include  conftest.c 1>&5
configure:3234: checking for snprintf
configure:3253: gcc -c -Wall -Werror -g -O2 -I/lib/modules/2.6.2-rc2/build/include  conftest.c 1>&5
configure:3273: checking for vmalloc_to_page
configure:3293: gcc -c -g -O2 -I/lib/modules/2.6.2-rc2/build/include  conftest.c 1>&5
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mm.h:4,
                 from configure:3283:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mm.h:4,
                 from configure:3283:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:8: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:9: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:10: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:12: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:19: error: `MAX_APICS' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:20: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:20: error: conflicting types for `mp_bus_id_to_type'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:8: error: previous declaration of `mp_bus_id_to_type'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:22: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:24: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:24: error: conflicting types for `mp_bus_id_to_pci_bus'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:12: error: previous declaration of `mp_bus_id_to_pci_bus'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:50: error: `MAX_APICS' undeclared here (not in a function)
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:20,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mm.h:4,
                 from configure:3283:
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: conflicting types for `mp_irqs'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:22: error: previous declaration of `mp_irqs'
In file included from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mm.h:4,
                 from configure:3283:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:72:26: mach_apicdef.h: No such file or directory
configure: failed program was:
#line 3278 "configure"
#include "confdefs.h"

#define __KERNEL__
#include "/lib/modules/2.6.2-rc2/build/include/linux/config.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/time.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/mm.h"

int main() {

  struct page * (*func)(void*);
  func = vmalloc_to_page;

; return 0; }
configure:3313: checking for old kmod
configure:3331: gcc -c -g -O2 -Wall -I/lib/modules/2.6.2-rc2/build/include  conftest.c 1>&5
configure: In function `main':
configure:3326: warning: too many arguments for format
configure:3351: checking for PDE
configure:3371: gcc -c -g -O2 -Wall -I/lib/modules/2.6.2-rc2/build/include  conftest.c 1>&5
In file included from /lib/modules/2.6.2-rc2/build/include/asm/processor.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/prefetch.h:13,
                 from /lib/modules/2.6.2-rc2/build/include/linux/list.h:7,
                 from /lib/modules/2.6.2-rc2/build/include/linux/wait.h:14,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:12,
                 from configure:3360:
/lib/modules/2.6.2-rc2/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.6.2-rc2/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.6.2-rc2/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/topology.h:33,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mmzone.h:304,
                 from /lib/modules/2.6.2-rc2/build/include/linux/gfp.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/slab.h:15,
                 from /lib/modules/2.6.2-rc2/build/include/linux/percpu.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/rcupdate.h:42,
                 from /lib/modules/2.6.2-rc2/build/include/linux/dcache.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:17,
                 from configure:3360:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/topology.h:33,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mmzone.h:304,
                 from /lib/modules/2.6.2-rc2/build/include/linux/gfp.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/slab.h:15,
                 from /lib/modules/2.6.2-rc2/build/include/linux/percpu.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/rcupdate.h:42,
                 from /lib/modules/2.6.2-rc2/build/include/linux/dcache.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:17,
                 from configure:3360:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h: At top level:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:8: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:9: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:10: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:12: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:19: error: `MAX_APICS' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:20: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:20: error: conflicting types for `mp_bus_id_to_type'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:8: error: previous declaration of `mp_bus_id_to_type'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:22: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:24: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:24: error: conflicting types for `mp_bus_id_to_pci_bus'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:12: error: previous declaration of `mp_bus_id_to_pci_bus'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:50: error: `MAX_APICS' undeclared here (not in a function)
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:20,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/topology.h:33,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mmzone.h:304,
                 from /lib/modules/2.6.2-rc2/build/include/linux/gfp.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/slab.h:15,
                 from /lib/modules/2.6.2-rc2/build/include/linux/percpu.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/rcupdate.h:42,
                 from /lib/modules/2.6.2-rc2/build/include/linux/dcache.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:17,
                 from configure:3360:
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: conflicting types for `mp_irqs'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:22: error: previous declaration of `mp_irqs'
In file included from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/topology.h:33,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mmzone.h:304,
                 from /lib/modules/2.6.2-rc2/build/include/linux/gfp.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/slab.h:15,
                 from /lib/modules/2.6.2-rc2/build/include/linux/percpu.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/rcupdate.h:42,
                 from /lib/modules/2.6.2-rc2/build/include/linux/dcache.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:17,
                 from configure:3360:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:72:26: mach_apicdef.h: No such file or directory
In file included from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/topology.h:33,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mmzone.h:304,
                 from /lib/modules/2.6.2-rc2/build/include/linux/gfp.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/slab.h:15,
                 from /lib/modules/2.6.2-rc2/build/include/linux/percpu.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/rcupdate.h:42,
                 from /lib/modules/2.6.2-rc2/build/include/linux/dcache.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:17,
                 from configure:3360:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h: In function `hard_smp_processor_id':
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:76: warning: implicit declaration of function `GET_APIC_ID'
configure: failed program was:
#line 3356 "configure"
#include "confdefs.h"

#define __KERNEL__
#include "/lib/modules/2.6.2-rc2/build/include/linux/config.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/fs.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/proc_fs.h"

int main() {

	struct proc_dir_entry * (*func)();
	func = PDE;

; return 0; }
configure:3391: checking for pci_set_consistent_dma_mask
configure:3410: gcc -c -g -O2 -Wall -I/lib/modules/2.6.2-rc2/build/include  conftest.c 1>&5
In file included from /lib/modules/2.6.2-rc2/build/include/asm/processor.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/prefetch.h:13,
                 from /lib/modules/2.6.2-rc2/build/include/linux/list.h:7,
                 from /lib/modules/2.6.2-rc2/build/include/linux/pci.h:348,
                 from configure:3400:
/lib/modules/2.6.2-rc2/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.6.2-rc2/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.6.2-rc2/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/module.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/device.h:21,
                 from /lib/modules/2.6.2-rc2/build/include/linux/pci.h:350,
                 from configure:3400:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/module.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/device.h:21,
                 from /lib/modules/2.6.2-rc2/build/include/linux/pci.h:350,
                 from configure:3400:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h: At top level:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:8: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:9: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:10: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:12: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:19: error: `MAX_APICS' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:20: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:20: error: conflicting types for `mp_bus_id_to_type'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:8: error: previous declaration of `mp_bus_id_to_type'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:22: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:24: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:24: error: conflicting types for `mp_bus_id_to_pci_bus'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:12: error: previous declaration of `mp_bus_id_to_pci_bus'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:50: error: `MAX_APICS' undeclared here (not in a function)
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:20,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/module.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/device.h:21,
                 from /lib/modules/2.6.2-rc2/build/include/linux/pci.h:350,
                 from configure:3400:
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: conflicting types for `mp_irqs'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:22: error: previous declaration of `mp_irqs'
In file included from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/module.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/device.h:21,
                 from /lib/modules/2.6.2-rc2/build/include/linux/pci.h:350,
                 from configure:3400:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:72:26: mach_apicdef.h: No such file or directory
In file included from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/module.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/device.h:21,
                 from /lib/modules/2.6.2-rc2/build/include/linux/pci.h:350,
                 from configure:3400:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h: In function `hard_smp_processor_id':
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:76: warning: implicit declaration of function `GET_APIC_ID'
configure: failed program was:
#line 3396 "configure"
#include "confdefs.h"

#define __KERNEL__
#include "/lib/modules/2.6.2-rc2/build/include/linux/config.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/pci.h"

int main() {

	int (*func)();
	func = pci_set_consistent_dma_mask;

; return 0; }
configure:3430: checking for tty->count is the atomic type
configure:3449: gcc -c -g -O2 -Wall -I/lib/modules/2.6.2-rc2/build/include  conftest.c 1>&5
In file included from /lib/modules/2.6.2-rc2/build/include/asm/processor.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/prefetch.h:13,
                 from /lib/modules/2.6.2-rc2/build/include/linux/list.h:7,
                 from /lib/modules/2.6.2-rc2/build/include/linux/wait.h:14,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:12,
                 from /lib/modules/2.6.2-rc2/build/include/linux/tty.h:20,
                 from configure:3439:
/lib/modules/2.6.2-rc2/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.6.2-rc2/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.6.2-rc2/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/topology.h:33,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mmzone.h:304,
                 from /lib/modules/2.6.2-rc2/build/include/linux/gfp.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/slab.h:15,
                 from /lib/modules/2.6.2-rc2/build/include/linux/percpu.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/rcupdate.h:42,
                 from /lib/modules/2.6.2-rc2/build/include/linux/dcache.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/tty.h:20,
                 from configure:3439:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/topology.h:33,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mmzone.h:304,
                 from /lib/modules/2.6.2-rc2/build/include/linux/gfp.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/slab.h:15,
                 from /lib/modules/2.6.2-rc2/build/include/linux/percpu.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/rcupdate.h:42,
                 from /lib/modules/2.6.2-rc2/build/include/linux/dcache.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/tty.h:20,
                 from configure:3439:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h: At top level:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:8: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:9: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:10: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:12: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:19: error: `MAX_APICS' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:20: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:20: error: conflicting types for `mp_bus_id_to_type'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:8: error: previous declaration of `mp_bus_id_to_type'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:22: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:24: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:24: error: conflicting types for `mp_bus_id_to_pci_bus'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:12: error: previous declaration of `mp_bus_id_to_pci_bus'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:50: error: `MAX_APICS' undeclared here (not in a function)
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:20,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/topology.h:33,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mmzone.h:304,
                 from /lib/modules/2.6.2-rc2/build/include/linux/gfp.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/slab.h:15,
                 from /lib/modules/2.6.2-rc2/build/include/linux/percpu.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/rcupdate.h:42,
                 from /lib/modules/2.6.2-rc2/build/include/linux/dcache.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/tty.h:20,
                 from configure:3439:
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: conflicting types for `mp_irqs'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:22: error: previous declaration of `mp_irqs'
In file included from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/topology.h:33,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mmzone.h:304,
                 from /lib/modules/2.6.2-rc2/build/include/linux/gfp.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/slab.h:15,
                 from /lib/modules/2.6.2-rc2/build/include/linux/percpu.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/rcupdate.h:42,
                 from /lib/modules/2.6.2-rc2/build/include/linux/dcache.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/tty.h:20,
                 from configure:3439:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:72:26: mach_apicdef.h: No such file or directory
In file included from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/topology.h:33,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mmzone.h:304,
                 from /lib/modules/2.6.2-rc2/build/include/linux/gfp.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/slab.h:15,
                 from /lib/modules/2.6.2-rc2/build/include/linux/percpu.h:4,
                 from /lib/modules/2.6.2-rc2/build/include/linux/rcupdate.h:42,
                 from /lib/modules/2.6.2-rc2/build/include/linux/dcache.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/tty.h:20,
                 from configure:3439:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h: In function `hard_smp_processor_id':
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:76: warning: implicit declaration of function `GET_APIC_ID'
configure: In function `main':
configure:3444: error: request for member `counter' in something not a structure or union
configure: failed program was:
#line 3435 "configure"
#include "confdefs.h"

#define __KERNEL__
#include "/lib/modules/2.6.2-rc2/build/include/linux/config.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/tty.h"

int main() {

	struct tty_struct tty;
	atomic_read(&tty.count);

; return 0; }
configure:3621: checking for driver version
configure:3636: checking for sequencer support
configure:3665: checking for OSS/Free emulation
configure:3704: checking for RTC callback support in kernel
configure:3736: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:3762: checking for USB support
configure:3784: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:3868: checking for PCMCIA support
configure:3890: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure: failed program was:
#line 3877 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_PCMCIA) && !defined(CONFIG_PCMCIA_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:3910: checking for PCMCIA module support
configure:3932: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure: failed program was:
#line 3919 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_PCMCIA_MODULE) && !defined(CONFIG_PCMCIA_MODULE_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:3968: checking for PC9800 support in kernel
configure:3990: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure: failed program was:
#line 3977 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_X86_PC9800) && !defined(CONFIG_X86_PC9800_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:4088: checking for which soundcards to compile driver for

--------------060006010705000309050309--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
