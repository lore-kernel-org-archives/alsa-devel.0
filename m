From: John Stile <john@stilen.com>
Subject: Re: snd-hda-intel support for
	SPDIF-in	wiht	vt1708	card?
Date: Fri, 21 Dec 2007 09:57:22 -0800
Message-ID: <1198259842.1479.6.camel@genx.localdomain>
References: <122020070037.26835.4769B95A000149C6000068D3220702293305029A06039A9D0100@comcast.net>
	<s5hhcidvd0e.wl%tiwai@suse.de>
	<1198174409.8838.2.camel@genx.localdomain>
	<s5hbq8k2z5n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mother.stilen.com (dsl027-182-089.sfo1.dsl.speakeasy.net
	[216.27.182.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 30EA91037F8
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 18:57:50 +0100 (CET)
In-Reply-To: <s5hbq8k2z5n.wl%tiwai@suse.de>
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
Cc: forumjunk@comcast.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-12-21 at 10:08 +0100, Takashi Iwai wrote:
> At Thu, 20 Dec 2007 10:13:29 -0800,
> John Stile wrote:
> > 
> > On Thu, 2007-12-20 at 12:09 +0100, Takashi Iwai wrote: 
> > > At Thu, 20 Dec 2007 00:37:46 +0000,
> > > forumjunk@comcast.net wrote:
> > > > 
> > > > 
> > > > For VIA platforms, to avoid the driver compile error in pci.h, reconfigure your kernel to remove SMP support, and set the architecture type to PC-compatible.
> > > > 
> > > > (you already know this, I'm sure):
> > > > Recompile the kernel (as a paranoid, I always trash /lib/modules/<kernel_version> before making modules_install). Install the kernel, of course, and reconfigure your boot loader and/or initrd and reboot.
> > > > 
> > > > There are still several fixes that need to be made to get all of this to compile cleanly, but I haven't got the permanent fixes nailed down yet. I'm almost positive that these are alsa-driver configure errors or omissions. I can't (yet) find a kernel config that will avoid them. The fixes below are harmless, and they will allow you to get the driver compiled.
> > > 
> > > My guess is that the error of configure script is the only point we
> > > need to fix.
> > > 
> > > > Add this definition to the top section of acore/memory_wrapper.c after the line that reads #include <linux/version.h>
> > > > 
> > > > #define VMALLOC_VMADDR(x)   ((unsigned long)(x))
> > > > 
> > > > Change these lines (45 and 46 or close to that) of acore/memory_wrapper.c from:
> > > > 
> > > >         pmd = pmd_offset(pgd, lpage);
> > > >         pte = pte_offset(pmd, lpage);
> > > > 
> > > > to
> > > > 
> > > >         pmd = pmd_offset((pud_t *)pgd, lpage);
> > > >         pte = pte_offset_kernel(pmd, lpage);
> > > > 
> > > > The driver will then compile cleanly (at least with no errors or warnings relating to any of these changes)
> > > 
> > > Don't do this.  This part shouldn't be compiled at all for recent
> > > kernels.  This is, again, the problem of configure script that
> > > detected the codes wrongly.
> > > 
> > > 
> > > So, could you guys show config.log?  Otherwise it's hard to know
> > > what's really wrong.
> > > 
> > > 
> > > thanks,
> > I recompiled the kernel without SMP support, and as PC-compatible (per
> > forumjunk@comcast.net).  In config.log, vmalloc_to_page shows a warning
> > starting at line 540.  "function cpuid_count causes a warning: pointer
> > targets in passing argument 4 of 'native_cpuid' differ in signedness". 
> > ---------------------------------------
> > The config.log
> 
> Thanks.  Does the patch below fix the probelm?
> Run hgcompile after applying it.
> 
> 
> Takashi
> 
> diff -r 414b1156a8b3 configure.in
> --- a/configure.in	Tue Dec 18 16:09:20 2007 +0100
> +++ b/configure.in	Fri Dec 21 12:10:53 2007 +0100
> @@ -1230,7 +1230,7 @@ esac
>  
>  dnl set ia32 (X86)
>  case "$processor" in
> -  i?86*|k?|crusoe|mcyrixiii|mwinchip|viac3_2|mcore2|geodegx*)
> +  i?86*|k?|crusoe|mcyrixiii|mwinchip|viac3_2|mcore2|geodegx*|x86_32)
>      if $KCC -mpreferred-stack-boundary=2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then
>        c_opts="-mpreferred-stack-boundary=2 $c_opts"
>        CONFIG_X86=y

Thank you!
Now I get a syntax error below.
config.log can be found here: http://pastebin.ca/827290

pico alsa-driver # ./hgcompile
utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel --hiddendir /usr/src/alsa-dri
ver --versiondep /usr/src/alsa-driver/kconfig-vers --makeconf > toplevel.config.in
can't handle word INPUT=y properly, supposing it's OK
can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel --hiddendir /usr/src/alsa-dri
ver --versiondep /usr/src/alsa-driver/kconfig-vers --acinclude > acinclude.m4
can't handle word INPUT=y properly, supposing it's OK
can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel --hiddendir /usr/src/alsa-dri
ver --versiondep /usr/src/alsa-driver/kconfig-vers --include > include/config1.h.in
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
checking for GCC version... Kernel compiler: gcc 4.1.2 (Gentoo 4.1.2 p1.0.2) Used compi
ler: gcc (GCC) 4.1.2 (Gentoo 4.1.2 p1.0.2)
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
checking for kernel module symbol versions... yes
checking for has ioport support... yes
checking for PCI support in kernel... yes
checking for I2C driver in kernel... module
checking for I2C_POWERMAC in kernel... unknown
checking for firmware loader... module
checking for input subsystem in kernel... yes
checking for directory to store kernel modules... /lib/modules/2.6.23-gentoo-r3/kernel/                              sound
checking for verbose procfs... on
checking for verbose printk... on
checking for debug level... full
checking for ISA support in kernel... yes
checking for processor type... x86_32
./configure: line 8001: syntax error near unexpected token `;;'
./configure: line 8001: `    ;;'
