From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Trying to get alsa-driver to build on a 2.6.x kernel.
Date: Fri, 30 Jan 2004 14:46:44 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <401A6E54.5010605@superbug.demon.co.uk>
References: <401963AC.8080603@superbug.demon.co.uk>	<s5hekthsnlx.wl@alsa2.suse.de>	<401A6488.9060108@superbug.demon.co.uk> <s5h7jz9sewo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000906080907070900050102"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jz9sewo.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000906080907070900050102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Fri, 30 Jan 2004 14:04:56 +0000,
> James Courtier-Dutton wrote:
> 
>>[1  <text/plain; us-ascii (7bit)>]
>>Takashi Iwai wrote:
>>
>>>At Thu, 29 Jan 2004 19:49:00 +0000,
>>>James Courtier-Dutton wrote:
>>>
>>>
>>>>[1  <text/plain; us-ascii (7bit)>]
>>>>I have been told that one should be able to build alsa-driver on a 2.6.x 
>>>>kernel, but it fails here.
>>>>
>>>>I attach config.log for your information.
>>>>I also attach the console output from running
>>>>./configure --with-cards=emu10k1,intel8x0,usb-audio
>>>>
>>>>Can anyone help?
>>>
>>>
>>>how about the patch below?
>>>
>>>
>>>Takashi
>>
>>Much better, configure finishes now, but compile fails.
>>Now I get a PDE error. See attachment.
>>It would be nice if configure could somehow check for and work around 
>>the PDE error.
> 
> 
> please show config.log.  configure didn't detect PDE by some reason.
> 
> 
> Takashi
> 
> 
See attached.


--------------000906080907070900050102
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
configure:1418: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:1453: checking for GCC version
configure:1499: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:1651: checking for built-in ALSA
configure:1673: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure: failed program was:
#line 1660 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#ifndef CONFIG_SND
  exit(1);
#else
  exit(0);
#endif
}

configure:1695: checking for existing ALSA module
configure:1717: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:1738: checking for Red Hat kernel
configure:1761: checking for Red Hat kernel
configure:1783: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure: failed program was:
#line 1770 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(RED_HAT_LINUX_KERNEL) && !defined(RED_HAT_LINUX_KERNEL_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:1803: checking to modify of kernel linux/kmod.h
configure:1822: checking for kernel linux/compiler.h
configure:1848: checking for kernel linux/pm.h
configure:1874: checking for kernel linux/spinlock.h
configure:1900: checking for kernel linux/irq.h
configure:1926: checking for kernel linux/threads.h
configure:1952: checking for kernel linux/rwsem.h
configure:1978: checking for kernel linux/gameport.h
configure:2004: checking for kernel linux/devfs_fs_kernel.h
configure:2030: checking for kernel linux/highmem.h
configure:2056: checking for kernel linux/workqueue.h
configure:2091: checking for kernel asm/hw_irq.h
configure:2117: checking for kernel linux/device.h
configure:2143: checking for kernel linux/jiffies.h
configure:2171: checking for kernel linux/compat.h
configure:2199: checking for kernel linux/adb.h
configure:2227: checking for kernel linux/cuda.h
configure:2255: checking for kernel linux/pmu.h
configure:2286: checking for kernel module symbol versions
configure:2308: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure: failed program was:
#line 2295 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_MODVERSIONS) && !defined(CONFIG_MODVERSIONS_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:2331: checking for PCI support in kernel
configure:2353: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:2371: checking for SGI/MIPS (HAL2) architecture
configure:2385: checking for directory to store kernel modules
configure:2414: checking for verbose printk
configure:2438: checking for debug level
configure:2510: checking for ISA support in kernel
configure:2532: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:2552: checking for processor type
configure:2650: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:2859: checking for i386 machine type
configure:2897: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include   conftest.c  1>&5
configure:2940: checking for SMP
configure:2962: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default   conftest.c  1>&5
configure:2990: checking for Video device support in kernel
configure:3012: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default   conftest.c  1>&5
configure:3030: checking for ISA PnP driver in kernel
configure:3045: checking for PnP driver in kernel
configure:3064: checking for Kernel ISA-PnP support
configure:3086: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default   conftest.c  1>&5
configure: failed program was:
#line 3073 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_ISAPNP) && !defined(CONFIG_ISAPNP_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:3106: checking for Kernel ISA-PnP module support
configure:3128: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default   conftest.c  1>&5
configure: failed program was:
#line 3115 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_ISAPNP_MODULE) && !defined(CONFIG_ISAPNP_MODULE_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:3195: checking for strlcpy
configure:3215: gcc -c -Wall -Werror -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default  conftest.c 1>&5
configure:3235: checking for snprintf
configure:3254: gcc -c -Wall -Werror -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default  conftest.c 1>&5
configure:3274: checking for vmalloc_to_page
configure:3294: gcc -c -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default  conftest.c 1>&5
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mm.h:4,
                 from configure:3284:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mm.h:4,
                 from configure:3284:
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
                 from configure:3284:
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: conflicting types for `mp_irqs'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:22: error: previous declaration of `mp_irqs'
In file included from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/mm.h:4,
                 from configure:3284:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:72:26: mach_apicdef.h: No such file or directory
configure: failed program was:
#line 3279 "configure"
#include "confdefs.h"

#define __KERNEL__
#include "/lib/modules/2.6.2-rc2/build/include/linux/config.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/time.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/mm.h"

int main() {

  struct page * (*func)(void*);
  func = vmalloc_to_page;

; return 0; }
configure:3314: checking for old kmod
configure:3332: gcc -c -g -O2 -Wall -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default  conftest.c 1>&5
configure: In function `main':
configure:3327: warning: too many arguments for format
configure:3352: checking for PDE
configure:3372: gcc -c -g -O2 -Wall -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default  conftest.c 1>&5
In file included from /lib/modules/2.6.2-rc2/build/include/asm/processor.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/prefetch.h:13,
                 from /lib/modules/2.6.2-rc2/build/include/linux/list.h:7,
                 from /lib/modules/2.6.2-rc2/build/include/linux/wait.h:14,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:12,
                 from configure:3361:
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
                 from configure:3361:
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
                 from configure:3361:
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
                 from configure:3361:
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
                 from configure:3361:
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
                 from configure:3361:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h: In function `hard_smp_processor_id':
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:76: warning: implicit declaration of function `GET_APIC_ID'
configure: failed program was:
#line 3357 "configure"
#include "confdefs.h"

#define __KERNEL__
#include "/lib/modules/2.6.2-rc2/build/include/linux/config.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/fs.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/proc_fs.h"

int main() {

	struct proc_dir_entry * (*func)();
	func = PDE;

; return 0; }
configure:3392: checking for pci_set_consistent_dma_mask
configure:3411: gcc -c -g -O2 -Wall -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default  conftest.c 1>&5
In file included from /lib/modules/2.6.2-rc2/build/include/asm/processor.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/prefetch.h:13,
                 from /lib/modules/2.6.2-rc2/build/include/linux/list.h:7,
                 from /lib/modules/2.6.2-rc2/build/include/linux/pci.h:348,
                 from configure:3401:
/lib/modules/2.6.2-rc2/build/include/asm/system.h: In function `__set_64bit_var':
/lib/modules/2.6.2-rc2/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
/lib/modules/2.6.2-rc2/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/module.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/device.h:21,
                 from /lib/modules/2.6.2-rc2/build/include/linux/pci.h:350,
                 from configure:3401:
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
In file included from /lib/modules/2.6.2-rc2/build/include/asm/smp.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/module.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/device.h:21,
                 from /lib/modules/2.6.2-rc2/build/include/linux/pci.h:350,
                 from configure:3401:
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
                 from configure:3401:
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/lib/modules/2.6.2-rc2/build/include/asm/io_apic.h:160: error: conflicting types for `mp_irqs'
/lib/modules/2.6.2-rc2/build/include/asm/mpspec.h:22: error: previous declaration of `mp_irqs'
In file included from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/module.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/device.h:21,
                 from /lib/modules/2.6.2-rc2/build/include/linux/pci.h:350,
                 from configure:3401:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:72:26: mach_apicdef.h: No such file or directory
In file included from /lib/modules/2.6.2-rc2/build/include/linux/smp.h:17,
                 from /lib/modules/2.6.2-rc2/build/include/linux/sched.h:23,
                 from /lib/modules/2.6.2-rc2/build/include/linux/module.h:10,
                 from /lib/modules/2.6.2-rc2/build/include/linux/device.h:21,
                 from /lib/modules/2.6.2-rc2/build/include/linux/pci.h:350,
                 from configure:3401:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h: In function `hard_smp_processor_id':
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:76: warning: implicit declaration of function `GET_APIC_ID'
configure: failed program was:
#line 3397 "configure"
#include "confdefs.h"

#define __KERNEL__
#include "/lib/modules/2.6.2-rc2/build/include/linux/config.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/pci.h"

int main() {

	int (*func)();
	func = pci_set_consistent_dma_mask;

; return 0; }
configure:3431: checking for tty->count is the atomic type
configure:3450: gcc -c -g -O2 -Wall -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default  conftest.c 1>&5
In file included from /lib/modules/2.6.2-rc2/build/include/asm/processor.h:18,
                 from /lib/modules/2.6.2-rc2/build/include/linux/prefetch.h:13,
                 from /lib/modules/2.6.2-rc2/build/include/linux/list.h:7,
                 from /lib/modules/2.6.2-rc2/build/include/linux/wait.h:14,
                 from /lib/modules/2.6.2-rc2/build/include/linux/fs.h:12,
                 from /lib/modules/2.6.2-rc2/build/include/linux/tty.h:20,
                 from configure:3440:
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
                 from configure:3440:
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
                 from configure:3440:
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
                 from configure:3440:
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
                 from configure:3440:
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
                 from configure:3440:
/lib/modules/2.6.2-rc2/build/include/asm/smp.h: In function `hard_smp_processor_id':
/lib/modules/2.6.2-rc2/build/include/asm/smp.h:76: warning: implicit declaration of function `GET_APIC_ID'
configure: In function `main':
configure:3445: error: request for member `counter' in something not a structure or union
configure: failed program was:
#line 3436 "configure"
#include "confdefs.h"

#define __KERNEL__
#include "/lib/modules/2.6.2-rc2/build/include/linux/config.h"
#include "/lib/modules/2.6.2-rc2/build/include/linux/tty.h"

int main() {

	struct tty_struct tty;
	atomic_read(&tty.count);

; return 0; }
configure:3622: checking for driver version
configure:3637: checking for sequencer support
configure:3666: checking for OSS/Free emulation
configure:3705: checking for RTC callback support in kernel
configure:3737: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default   conftest.c  1>&5
configure:3763: checking for USB support
configure:3785: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default   conftest.c  1>&5
configure:3869: checking for PCMCIA support
configure:3891: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default   conftest.c  1>&5
configure: failed program was:
#line 3878 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_PCMCIA) && !defined(CONFIG_PCMCIA_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:3911: checking for PCMCIA module support
configure:3933: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default   conftest.c  1>&5
configure: failed program was:
#line 3920 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_PCMCIA_MODULE) && !defined(CONFIG_PCMCIA_MODULE_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:3969: checking for PC9800 support in kernel
configure:3991: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default   conftest.c  1>&5
configure: failed program was:
#line 3978 "configure"
#include "confdefs.h"

#include "/lib/modules/2.6.2-rc2/build/include/linux/autoconf.h"
int main( void ) {
#if !defined(CONFIG_X86_PC9800) && !defined(CONFIG_X86_PC9800_MODULE)
  exit(1);
#else
  exit(0);
#endif
}

configure:4089: checking for which soundcards to compile driver for

--------------000906080907070900050102--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
