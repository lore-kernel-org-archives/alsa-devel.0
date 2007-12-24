From: John Stile <john@stilen.com>
Subject: Re:
	snd-hda-intel	support	for	SPDIF-in	wiht	vt1708	card?
Date: Mon, 24 Dec 2007 11:22:34 -0800
Message-ID: <1198524154.25200.26.camel@genx.localdomain>
References: <122020070037.26835.4769B95A000149C6000068D3220702293305029A06039A9D0100@comcast.net>
	<s5hhcidvd0e.wl%tiwai@suse.de>
	<1198174409.8838.2.camel@genx.localdomain>
	<s5hbq8k2z5n.wl%tiwai@suse.de>
	<1198259842.1479.6.camel@genx.localdomain>
	<1198267380.8645.10.camel@genx.localdomain>
	<1198348529.9510.36.camel@genx.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mother.stilen.com (dsl027-182-089.sfo1.dsl.speakeasy.net
	[216.27.182.89])
	by alsa0.perex.cz (Postfix) with ESMTP id A8A92103838
	for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2007 20:23:02 +0100 (CET)
In-Reply-To: <1198348529.9510.36.camel@genx.localdomain>
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

On Sat, 2007-12-22 at 10:35 -0800, John Stile wrote:
> On Fri, 2007-12-21 at 12:03 -0800, John Stile wrote:
> > On Fri, 2007-12-21 at 09:57 -0800, John Stile wrote:
> > > On Fri, 2007-12-21 at 10:08 +0100, Takashi Iwai wrote:
> > > > At Thu, 20 Dec 2007 10:13:29 -0800,
> > > > John Stile wrote:
> > > > > 
> > > > > On Thu, 2007-12-20 at 12:09 +0100, Takashi Iwai wrote: 
> > > > > > At Thu, 20 Dec 2007 00:37:46 +0000,
> > > > > > forumjunk@comcast.net wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > For VIA platforms, to avoid the driver compile error in pci.h, reconfigure your kernel to remove SMP support, and set the architecture type to PC-compatible.
> > > > > > > 
> > > > > > > (you already know this, I'm sure):
> > > > > > > Recompile the kernel (as a paranoid, I always trash /lib/modules/<kernel_version> before making modules_install). Install the kernel, of course, and reconfigure your boot loader and/or initrd and reboot.
> > > > > > > 
> > > > > > > There are still several fixes that need to be made to get all of this to compile cleanly, but I haven't got the permanent fixes nailed down yet. I'm almost positive that these are alsa-driver configure errors or omissions. I can't (yet) find a kernel config that will avoid them. The fixes below are harmless, and they will allow you to get the driver compiled.
> > > > > > 
> > > > > > My guess is that the error of configure script is the only point we
> > > > > > need to fix.
> > > > > > 
> > > > > > > Add this definition to the top section of acore/memory_wrapper.c after the line that reads #include <linux/version.h>
> > > > > > > 
> > > > > > > #define VMALLOC_VMADDR(x)   ((unsigned long)(x))
> > > > > > > 
> > > > > > > Change these lines (45 and 46 or close to that) of acore/memory_wrapper.c from:
> > > > > > > 
> > > > > > >         pmd = pmd_offset(pgd, lpage);
> > > > > > >         pte = pte_offset(pmd, lpage);
> > > > > > > 
> > > > > > > to
> > > > > > > 
> > > > > > >         pmd = pmd_offset((pud_t *)pgd, lpage);
> > > > > > >         pte = pte_offset_kernel(pmd, lpage);
> > > > > > > 
> > > > > > > The driver will then compile cleanly (at least with no errors or warnings relating to any of these changes)
> > > > > > 
> > > > > > Don't do this.  This part shouldn't be compiled at all for recent
> > > > > > kernels.  This is, again, the problem of configure script that
> > > > > > detected the codes wrongly.
> > > > > > 
> > > > > > 
> > > > > > So, could you guys show config.log?  Otherwise it's hard to know
> > > > > > what's really wrong.
> > > > > > 
> > > > > > 
> > > > > > thanks,
> > > > > I recompiled the kernel without SMP support, and as PC-compatible (per
> > > > > forumjunk@comcast.net).  In config.log, vmalloc_to_page shows a warning
> > > > > starting at line 540.  "function cpuid_count causes a warning: pointer
> > > > > targets in passing argument 4 of 'native_cpuid' differ in signedness". 
> > > > > ---------------------------------------
> > > > > The config.log
> > > > 
> > > > Thanks.  Does the patch below fix the probelm?
> > > > Run hgcompile after applying it.
> > > > 
> > > > 
> > > > Takashi
> > > > 
> > > > diff -r 414b1156a8b3 configure.in
> > > > --- a/configure.in	Tue Dec 18 16:09:20 2007 +0100
> > > > +++ b/configure.in	Fri Dec 21 12:10:53 2007 +0100
> > > > @@ -1230,7 +1230,7 @@ esac
> > > >  
> > > >  dnl set ia32 (X86)
> > > >  case "$processor" in
> > > > -  i?86*|k?|crusoe|mcyrixiii|mwinchip|viac3_2|mcore2|geodegx*)
> > > > +  i?86*|k?|crusoe|mcyrixiii|mwinchip|viac3_2|mcore2|geodegx*|x86_32)
> > > >      if $KCC -mpreferred-stack-boundary=2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then
> > > >        c_opts="-mpreferred-stack-boundary=2 $c_opts"
> > > >        CONFIG_X86=y
> > > 
> > > Thank you!
> > > Now I get a syntax error below.
> > > config.log can be found here: http://pastebin.ca/827290
> > > 
> > > pico alsa-driver # ./hgcompile
> > > utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel --hiddendir /usr/src/alsa-dri
> > > ver --versiondep /usr/src/alsa-driver/kconfig-vers --makeconf > toplevel.config.in
> > > can't handle word INPUT=y properly, supposing it's OK
> > > can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
> > > utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel --hiddendir /usr/src/alsa-dri
> > > ver --versiondep /usr/src/alsa-driver/kconfig-vers --acinclude > acinclude.m4
> > > can't handle word INPUT=y properly, supposing it's OK
> > > can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
> > > utils/mod-deps --basedir /usr/src/alsa-driver/alsa-kernel --hiddendir /usr/src/alsa-dri
> > > ver --versiondep /usr/src/alsa-driver/kconfig-vers --include > include/config1.h.in
> > > can't handle word INPUT=y properly, supposing it's OK
> > > can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
> > > ./configure --with-debug=full --with-isapnp=yes --with-sequencer=yes
> > > checking for gcc... gcc
> > > checking for C compiler default output file name... a.out
> > > checking whether the C compiler works... yes
> > > checking whether we are cross compiling... no
> > > checking for suffix of executables...
> > > checking for suffix of object files... o
> > > checking whether we are using the GNU C compiler... yes
> > > checking whether gcc accepts -g... yes
> > > checking for gcc option to accept ISO C89... none needed
> > > checking for ranlib... ranlib
> > > checking for a BSD-compatible install... /usr/bin/install -c
> > > checking how to run the C preprocessor... gcc -E
> > > checking for grep that handles long lines and -e... /bin/grep
> > > checking for egrep... /bin/grep -E
> > > checking for ANSI C header files... yes
> > > checking for an ANSI C-conforming const... yes
> > > checking for inline... inline
> > > checking whether time.h and sys/time.h may both be included... yes
> > > checking whether gcc needs -traditional... no
> > > checking for current directory... /usr/src/alsa-driver
> > > checking cross compile...
> > > checking for directory with kernel source... /lib/modules/2.6.23-gentoo-r3/source
> > > checking for directory with kernel build... /lib/modules/2.6.23-gentoo-r3/build
> > > checking for kernel linux/version.h... yes
> > > checking for kernel linux/autoconf.h... yes
> > > checking for kernel version... 2.6.23-gentoo-r3
> > > checking for GCC version... Kernel compiler: gcc 4.1.2 (Gentoo 4.1.2 p1.0.2) Used compi
> > > ler: gcc (GCC) 4.1.2 (Gentoo 4.1.2 p1.0.2)
> > > checking for built-in ALSA... no
> > > checking for existing ALSA module... no
> > > checking for Red Hat kernel... auto
> > > checking for Red Hat kernel... no
> > > checking for SUSE kernel... auto
> > > checking for SUSE kernel... no
> > > checking for CONFIG_EXPERIMENTAL... yes
> > > checking for kernel linux/config.h... no
> > > Creating <linux/config.h>...
> > > checking to modify of kernel linux/kmod.h... no
> > > checking for kernel linux/utsrelease.h... yes
> > > checking for kernel linux/compiler.h... yes
> > > checking for kernel linux/pm.h... yes
> > > checking for kernel linux/spinlock.h... yes
> > > checking for kernel linux/irq.h... yes
> > > checking for kernel linux/threads.h... yes
> > > checking for kernel linux/rwsem.h... yes
> > > checking for kernel linux/gameport.h... yes
> > > checking for kernel media/v4l2-dev.h... yes
> > > checking for kernel linux/devfs_fs_kernel.h... no
> > > Creating a dummy <linux/devfs_fs_kernel.h>...
> > > checking for kernel linux/highmem.h... yes
> > > checking for kernel linux/workqueue.h... yes
> > > checking for kernel linux/dma-mapping.h... yes
> > > checking for kernel asm/hw_irq.h... yes
> > > checking for kernel linux/device.h... yes
> > > checking for kernel linux/platform_device.h... yes
> > > checking for kernel linux/isa.h... yes
> > > checking for kernel linux/jiffies.h... yes
> > > checking for kernel linux/compat.h... yes
> > > checking for kernel linux/log2.h... yes
> > > checking for kernel linux/adb.h... yes
> > > checking for kernel linux/cuda.h... yes
> > > checking for kernel linux/pmu.h... yes
> > > checking for kernel linux/moduleparam.h... yes
> > > checking for kernel linux/syscalls.h... yes
> > > checking for kernel linux/firmware.h... yes
> > > checking for kernel linux/err.h... yes
> > > checking for kernel linux/bitmap.h... yes
> > > checking for kernel linux/mutex.h... yes
> > > checking for kernel linux/latency.h... yes
> > > checking for kernel linux/kthread.h... yes
> > > checking for kernel asm/irq_regs.h... yes
> > > checking for kernel module symbol versions... yes
> > > checking for has ioport support... yes
> > > checking for PCI support in kernel... yes
> > > checking for I2C driver in kernel... module
> > > checking for I2C_POWERMAC in kernel... unknown
> > > checking for firmware loader... module
> > > checking for input subsystem in kernel... yes
> > > checking for directory to store kernel modules... /lib/modules/2.6.23-gentoo-r3/kernel/                              sound
> > > checking for verbose procfs... on
> > > checking for verbose printk... on
> > > checking for debug level... full
> > > checking for ISA support in kernel... yes
> > > checking for processor type... x86_32
> > > ./configure: line 8001: syntax error near unexpected token `;;'
> > > ./configure: line 8001: `    ;;'
> > Whoops!  I tried reapplied the changes to a fresh checkout, and now it
> > builds just fine. I applied the change to:
> >    configure.in 
> >    alsa-kernel/pci/hda/patch_via.c
> > I have to wait until tonight to test.
> > Thank you!
> I have similar results to Darryl House after applying the 2 patches
> Error:
>   ALSA lib pcm_dmix.c:829:(snd_pcm_dmix_open) unable to open slave
>   play soxio: Failed writing `default': cannot open audio device
> ----------------------
> procedure followed:
>  # Download and compile the HG alsa-driver package:
>     hg clone http://hg-mirror.alsa-project.org/alsa-driver alsa-driver
>     cd alsa-driver
>     hg clone http://hg-mirror.alsa-project.org/alsa-kernel alsa-kernel
>  # Apply patches to:
>  #   alsa-driver/configure.in
>  #   AND
>  #   alsa-kernel/pci/hda/patch_via.c
>  # Build kernel component
>     ./hgcompile && make install
>     popd
>  # Load driver
>     modprobe snd-hda-intel
>  # Build HG alsa-libs and alsa-utils
>     hg clone http://hg-mirror.alsa-project.org/alsa-lib alsa-lib
>     pushd alsa-lib
>     ./hgcompile && make install
>  # Run config
>   sh ./alsaconf/alsaconf
>   # Select card:
>   #  VIA Technologies, Inc. VIA High Definition Audio Controller
>  # Turn up the levels
>  ./alsamixer/alsamixer
>  # Try to play
>  ./aplay/aplay /root/Track01.wav
>   ALSA lib pcm_dmix.c:829:(snd_pcm_dmix_open) unable to open slave
>   aplay: main:546: audio open error: Inappropriate ioctl for device
>  # Strace aplay
>   pico alsa-utils # strace -tt ./aplay/aplay /root/Track01.wav
> 10:36:55.550401 execve("./aplay/aplay", ["./aplay/aplay", "/root/Track01.wav"], [/* 41 vars */]) = 0
> 10:36:55.551561 brk(0)                  = 0x8055000
> 10:36:55.551879 access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
> 10:36:55.552129 open("/etc/ld.so.cache", O_RDONLY) = 3
> 10:36:55.552307 fstat64(3, {st_mode=S_IFREG|0644, st_size=114984, ...}) = 0
> 10:36:55.552572 mmap2(NULL, 114984, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f21000
> 10:36:55.552753 close(3)                = 0
> 10:36:55.552928 open("/usr/lib/libasound.so.2", O_RDONLY) = 3
> 10:36:55.553108 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\365\1\0004\0\0\0"..., 512) = 512
> 10:36:55.553329 fstat64(3, {st_mode=S_IFREG|0755, st_size=2762708, ...}) = 0
> 10:36:55.553792 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f20000
> 10:36:55.554008 mmap2(NULL, 789320, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e5f000
> 10:36:55.554186 mmap2(0xb7f1b000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xbb) = 0xb7f1b000
> 10:36:55.554605 close(3)                = 0
> 10:36:55.554843 open("/lib/libm.so.6", O_RDONLY) = 3
> 10:36:55.555031 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p4\0\0004\0\0\0"..., 512) = 512
> 10:36:55.555254 fstat64(3, {st_mode=S_IFREG|0755, st_size=149256, ...}) = 0
> 10:36:55.555490 mmap2(NULL, 151680, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e39000
> 10:36:55.555667 mmap2(0xb7e5d000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x23) = 0xb7e5d000
> 10:36:55.555900 close(3)                = 0
> 10:36:55.556071 open("/lib/libdl.so.2", O_RDONLY) = 3
> 10:36:55.556242 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\n\0\0004\0\0\0"..., 512) = 512
> 10:36:55.556482 fstat64(3, {st_mode=S_IFREG|0755, st_size=9612, ...}) = 0
> 10:36:55.556680 mmap2(NULL, 12412, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e35000
> 10:36:55.556848 mmap2(0xb7e37000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb7e37000
> 10:36:55.557068 close(3)                = 0
> 10:36:55.557240 open("/lib/libpthread.so.0", O_RDONLY) = 3
> 10:36:55.557425 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 H\0\0004\0\0\0"..., 512) = 512
> 10:36:55.557638 fstat64(3, {st_mode=S_IFREG|0755, st_size=84168, ...}) = 0
> 10:36:55.557832 mmap2(NULL, 90592, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e1e000
> 10:36:55.558000 mmap2(0xb7e31000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13) = 0xb7e31000
> 10:36:55.558213 mmap2(0xb7e33000, 4576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7e33000
> 10:36:55.558425 close(3)                = 0
> 10:36:55.558594 open("/lib/libc.so.6", O_RDONLY) = 3
> 10:36:55.558763 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@a\1\0004\0\0\0"..., 512) = 512
> 10:36:55.558973 fstat64(3, {st_mode=S_IFREG|0755, st_size=1237276, ...}) = 0
> 10:36:55.559172 mmap2(NULL, 1242576, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7cee000
> 10:36:55.559339 mmap2(0xb7e18000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12a) = 0xb7e18000
> 10:36:55.559540 mmap2(0xb7e1b000, 9680, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7e1b000
> 10:36:55.560348 close(3)                = 0
> 10:36:55.560635 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7ced000
> 10:36:55.560857 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7cec000
> 10:36:55.561037 set_thread_area({entry_number:-1 -> 6, base_addr:0xb7cec6c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
> 10:36:55.561568 mprotect(0xb7e18000, 8192, PROT_READ) = 0
> 10:36:55.561782 mprotect(0xb7e31000, 4096, PROT_READ) = 0
> 10:36:55.561968 mprotect(0xb7e37000, 4096, PROT_READ) = 0
> 10:36:55.562137 mprotect(0xb7e5d000, 4096, PROT_READ) = 0
> 10:36:55.562592 mprotect(0xb7f1b000, 8192, PROT_READ) = 0
> 10:36:55.562780 mprotect(0x8053000, 4096, PROT_READ) = 0
> 10:36:55.562936 mprotect(0xb7f59000, 4096, PROT_READ) = 0
> 10:36:55.563069 munmap(0xb7f21000, 114984) = 0
> 10:36:55.563221 set_tid_address(0xb7cec708) = 2705
> 10:36:55.563342 set_robust_list(0xb7cec710, 0xc) = 0
> 10:36:55.563550 rt_sigaction(SIGRTMIN, {0xb7e22320, [], SA_SIGINFO}, NULL, 8) = 0
> 10:36:55.563735 rt_sigaction(SIGRT_1, {0xb7e223a0, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
> 10:36:55.563891 rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
> 10:36:55.564049 getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
> 10:36:55.564260 uname({sys="Linux", node="pico", ...}) = 0
> 10:36:55.564849 brk(0)                  = 0x8055000
> 10:36:55.565006 brk(0x8076000)          = 0x8076000
> 10:36:55.565286 stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8612, ...}) = 0
> 10:36:55.565549 open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
> 10:36:55.565747 fstat64(3, {st_mode=S_IFREG|0644, st_size=8612, ...}) = 0
> 10:36:55.565930 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3d000
> 10:36:55.566081 read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
> 10:36:55.568585 read(3, "r\n\t\t\t\tname defaults.pcm.device\n\t"..., 4096) = 4096
> 10:36:55.571159 read(3, " {\n\t\t\t@func refer\n\t\t\tname defaul"..., 4096) = 420
> 10:36:55.571703 read(3, "", 4096)       = 0
> 10:36:55.571862 read(3, "", 4096)       = 0
> 10:36:55.572039 close(3)                = 0
> 10:36:55.572190 munmap(0xb7f3d000, 4096) = 0
> 10:36:55.572831 futex(0xb7e38070, FUTEX_WAKE, 2147483647) = 0
> 10:36:55.573297 access("/etc/asound.conf", R_OK) = -1 ENOENT (No such file or directory)
> 10:36:55.573513 access("/root/.asoundrc", R_OK) = -1 ENOENT (No such file or directory)
> 10:36:55.574099 open("/usr/share/alsa/cards/aliases.conf", O_RDONLY) = 3
> 10:36:55.574351 fstat64(3, {st_mode=S_IFREG|0644, st_size=1293, ...}) = 0
> 10:36:55.574618 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3d000
> 10:36:55.574798 read(3, "#\n#  Define aliases for various "..., 4096) = 1293
> 10:36:55.575567 open("/usr/share/alsa/pcm/default.conf", O_RDONLY) = 4
> 10:36:55.575764 fstat64(4, {st_mode=S_IFREG|0644, st_size=762, ...}) = 0
> 10:36:55.575960 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
> 10:36:55.576127 read(4, "#\n# Default output\n#\n\npcm.!defau"..., 4096) = 762
> 10:36:55.576660 read(4, "", 4096)       = 0
> 10:36:55.576833 close(4)                = 0
> 10:36:55.576982 munmap(0xb7f3c000, 4096) = 0
> 10:36:55.577171 open("/usr/share/alsa/pcm/dmix.conf", O_RDONLY) = 4
> 10:36:55.577359 fstat64(4, {st_mode=S_IFREG|0644, st_size=1520, ...}) = 0
> 10:36:55.577576 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
> 10:36:55.577743 read(4, "#\n# dmix output\n#\n\npcm.!dmix {\n\t"..., 4096) = 1520
> 10:36:55.578570 read(4, "", 4096)       = 0
> 10:36:55.578735 close(4)                = 0
> 10:36:55.578883 munmap(0xb7f3c000, 4096) = 0
> 10:36:55.579063 open("/usr/share/alsa/pcm/dsnoop.conf", O_RDONLY) = 4
> 10:36:55.579251 fstat64(4, {st_mode=S_IFREG|0644, st_size=1532, ...}) = 0
> 10:36:55.579839 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
> 10:36:55.580080 read(4, "#\n# dsnoop\n#\n\npcm.!dsnoop {\n\t@ar"..., 4096) = 1532
> 10:36:55.581221 read(4, "", 4096)       = 0
> 10:36:55.581501 close(4)                = 0
> 10:36:55.581655 munmap(0xb7f3c000, 4096) = 0
> 10:36:55.581828 read(3, "", 4096)       = 0
> 10:36:55.581981 read(3, "", 4096)       = 0
> 10:36:55.582130 close(3)                = 0
> 10:36:55.582273 munmap(0xb7f3d000, 4096) = 0
> 10:36:55.582648 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.582892 close(3)                = 0
> 10:36:55.583108 stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8612, ...}) = 0
> 10:36:55.583890 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.584219 close(3)                = 0
> 10:36:55.584402 open("/dev/snd/controlC0", O_RDWR) = 3
> 10:36:55.584587 ioctl(3, USBDEVFS_CONTROL, 0xbfa50788) = 0
> 10:36:55.584798 ioctl(3, UI_DEV_CREATE, 0xbfa50760) = 0
> 10:36:55.584968 close(3)                = 0
> 10:36:55.585608 access("/usr/share/alsa/cards/HDA-Intel.conf", R_OK) = 0
> 10:36:55.585867 open("/usr/share/alsa/cards/HDA-Intel.conf", O_RDONLY) = 3
> 10:36:55.586057 fstat64(3, {st_mode=S_IFREG|0644, st_size=2148, ...}) = 0
> 10:36:55.586272 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3d000
> 10:36:55.586484 read(3, "#\n# Configuration for the Intel "..., 4096) = 2148
> 10:36:55.586718 open("/usr/share/alsa/pcm/front.conf", O_RDONLY) = 4
> 10:36:55.586903 fstat64(4, {st_mode=S_IFREG|0644, st_size=752, ...}) = 0
> 10:36:55.587098 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
> 10:36:55.587263 read(4, "#\n# Hardware output from front s"..., 4096) = 752
> 10:36:55.587773 read(4, "", 4096)       = 0
> 10:36:55.587936 close(4)                = 0
> 10:36:55.588084 munmap(0xb7f3c000, 4096) = 0
> 10:36:55.588703 open("/usr/share/alsa/pcm/surround40.conf", O_RDONLY) = 4
> 10:36:55.588926 fstat64(4, {st_mode=S_IFREG|0644, st_size=877, ...}) = 0
> 10:36:55.589129 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
> 10:36:55.589299 read(4, "#\n#  Hardware output from 4.0 sp"..., 4096) = 877
> 10:36:55.589857 read(4, "", 4096)       = 0
> 10:36:55.590021 close(4)                = 0
> 10:36:55.590168 munmap(0xb7f3c000, 4096) = 0
> 10:36:55.590348 open("/usr/share/alsa/pcm/surround41.conf", O_RDONLY) = 4
> 10:36:55.590550 fstat64(4, {st_mode=S_IFREG|0644, st_size=992, ...}) = 0
> 10:36:55.590752 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
> 10:36:55.590919 read(4, "#\n#  Hardware output from 4.1 sp"..., 4096) = 992
> 10:36:55.591520 read(4, "", 4096)       = 0
> 10:36:55.591683 close(4)                = 0
> 10:36:55.591829 munmap(0xb7f3c000, 4096) = 0
> 10:36:55.592001 open("/usr/share/alsa/pcm/surround50.conf", O_RDONLY) = 4
> 10:36:55.592187 fstat64(4, {st_mode=S_IFREG|0644, st_size=992, ...}) = 0
> 10:36:55.592383 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
> 10:36:55.592852 read(4, "#\n#  Hardware output from 5.0 sp"..., 4096) = 992
> 10:36:55.593710 read(4, "", 4096)       = 0
> 10:36:55.593946 close(4)                = 0
> 10:36:55.594097 munmap(0xb7f3c000, 4096) = 0
> 10:36:55.594291 open("/usr/share/alsa/pcm/surround51.conf", O_RDONLY) = 4
> 10:36:55.594725 fstat64(4, {st_mode=S_IFREG|0644, st_size=930, ...}) = 0
> 10:36:55.594944 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
> 10:36:55.595115 read(4, "#\n#  Hardware output from 5.1 sp"..., 4096) = 930
> 10:36:55.595678 read(4, "", 4096)       = 0
> 10:36:55.595843 close(4)                = 0
> 10:36:55.595989 munmap(0xb7f3c000, 4096) = 0
> 10:36:55.596172 open("/usr/share/alsa/pcm/surround71.conf", O_RDONLY) = 4
> 10:36:55.596368 fstat64(4, {st_mode=S_IFREG|0644, st_size=978, ...}) = 0
> 10:36:55.596837 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
> 10:36:55.597018 read(4, "#\n#  Hardware output from 7.1 sp"..., 4096) = 978
> 10:36:55.597610 read(4, "", 4096)       = 0
> 10:36:55.597775 close(4)                = 0
> 10:36:55.597922 munmap(0xb7f3c000, 4096) = 0
> 10:36:55.598191 open("/usr/share/alsa/pcm/iec958.conf", O_RDONLY) = 4
> 10:36:55.598387 fstat64(4, {st_mode=S_IFREG|0644, st_size=1213, ...}) = 0
> 10:36:55.598587 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
> 10:36:55.598754 read(4, "#\n#  Hardware output from iec958"..., 4096) = 1213
> 10:36:55.599509 read(4, "", 4096)       = 0
> 10:36:55.599727 close(4)                = 0
> 10:36:55.599874 munmap(0xb7f3c000, 4096) = 0
> 10:36:55.600448 open("/usr/share/alsa/pcm/modem.conf", O_RDONLY) = 4
> 10:36:55.600652 fstat64(4, {st_mode=S_IFREG|0644, st_size=1314, ...}) = 0
> 10:36:55.600855 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3c000
> 10:36:55.601025 read(4, "#\n# \"raw\" modem - phoneline\n#\n\np"..., 4096) = 1314
> 10:36:55.601764 read(4, "", 4096)       = 0
> 10:36:55.601923 close(4)                = 0
> 10:36:55.602068 munmap(0xb7f3c000, 4096) = 0
> 10:36:55.602309 read(3, "", 4096)       = 0
> 10:36:55.602512 read(3, "", 4096)       = 0
> 10:36:55.602662 close(3)                = 0
> 10:36:55.602806 munmap(0xb7f3d000, 4096) = 0
> 10:36:55.602971 open("/dev/snd/controlC1", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.603178 open("/dev/aloadC1", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.603354 open("/dev/snd/controlC2", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.603550 open("/dev/aloadC2", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.603725 open("/dev/snd/controlC3", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.603909 open("/dev/aloadC3", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.604066 open("/dev/snd/controlC4", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.604226 open("/dev/aloadC4", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.604382 open("/dev/snd/controlC5", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.604868 open("/dev/aloadC5", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.605048 open("/dev/snd/controlC6", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.605227 open("/dev/aloadC6", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.605401 open("/dev/snd/controlC7", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.605578 open("/dev/aloadC7", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.605752 open("/dev/snd/controlC8", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.605929 open("/dev/aloadC8", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.606101 open("/dev/snd/controlC9", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.606279 open("/dev/aloadC9", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.606684 open("/dev/snd/controlC10", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.606883 open("/dev/aloadC10", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.607056 open("/dev/snd/controlC11", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.607234 open("/dev/aloadC11", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.607407 open("/dev/snd/controlC12", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.607590 open("/dev/aloadC12", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.607763 open("/dev/snd/controlC13", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.607940 open("/dev/aloadC13", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.608113 open("/dev/snd/controlC14", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.608292 open("/dev/aloadC14", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.608496 open("/dev/snd/controlC15", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.608676 open("/dev/aloadC15", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.608849 open("/dev/snd/controlC16", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.609028 open("/dev/aloadC16", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.609200 open("/dev/snd/controlC17", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.609379 open("/dev/aloadC17", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.612664 open("/dev/snd/controlC18", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.612894 open("/dev/aloadC18", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.613070 open("/dev/snd/controlC19", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.613250 open("/dev/aloadC19", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.613471 open("/dev/snd/controlC20", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.613656 open("/dev/aloadC20", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.613830 open("/dev/snd/controlC21", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.614010 open("/dev/aloadC21", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.614182 open("/dev/snd/controlC22", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.614365 open("/dev/aloadC22", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.614563 open("/dev/snd/controlC23", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.614742 open("/dev/aloadC23", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.614916 open("/dev/snd/controlC24", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.615095 open("/dev/aloadC24", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.615277 open("/dev/snd/controlC25", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.615473 open("/dev/aloadC25", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.615649 open("/dev/snd/controlC26", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.615829 open("/dev/aloadC26", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.616003 open("/dev/snd/controlC27", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.616183 open("/dev/aloadC27", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.616357 open("/dev/snd/controlC28", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.616819 open("/dev/aloadC28", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.617004 open("/dev/snd/controlC29", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.617183 open("/dev/aloadC29", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.617357 open("/dev/snd/controlC30", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.617558 open("/dev/aloadC30", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.617735 open("/dev/snd/controlC31", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.617913 open("/dev/aloadC31", O_RDONLY) = -1 ENOENT (No such file or directory)
> 10:36:55.618848 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.619145 close(3)                = 0
> 10:36:55.619355 stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8612, ...}) = 0
> 10:36:55.619924 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.620198 close(3)                = 0
> 10:36:55.620367 open("/dev/snd/controlC0", O_RDWR) = 3
> 10:36:55.620865 ioctl(3, USBDEVFS_CONTROL, 0xbfa50288) = 0
> 10:36:55.621044 ioctl(3, UI_DEV_CREATE, 0xbfa50260) = 0
> 10:36:55.621200 close(3)                = 0
> 10:36:55.623972 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.624394 close(3)                = 0
> 10:36:55.624650 stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8612, ...}) = 0
> 10:36:55.624985 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.625176 close(3)                = 0
> 10:36:55.625334 open("/dev/snd/controlC0", O_RDWR) = 3
> 10:36:55.625530 ioctl(3, USBDEVFS_CONTROL, 0xbfa4fcf8) = 0
> 10:36:55.625693 ioctl(3, UI_DEV_CREATE, 0xbfa4fcd0) = 0
> 10:36:55.625848 close(3)                = 0
> 10:36:55.626407 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.626666 close(3)                = 0
> 10:36:55.626860 stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8612, ...}) = 0
> 10:36:55.627179 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.627365 close(3)                = 0
> 10:36:55.627539 open("/dev/snd/controlC0", O_RDWR) = 3
> 10:36:55.627707 ioctl(3, USBDEVFS_CONTROL, 0xbfa4fcf8) = 0
> 10:36:55.627868 ioctl(3, UI_DEV_CREATE, 0xbfa4fcd0) = 0
> 10:36:55.628023 close(3)                = 0
> 10:36:55.628561 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.628789 close(3)                = 0
> 10:36:55.628981 stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8612, ...}) = 0
> 10:36:55.629293 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.629978 close(3)                = 0
> 10:36:55.630187 open("/dev/snd/controlC0", O_RDWR) = 3
> 10:36:55.630381 ioctl(3, USBDEVFS_CONTROL, 0xbfa4fcf8) = 0
> 10:36:55.630802 ioctl(3, UI_DEV_CREATE, 0xbfa4fcd0) = 0
> 10:36:55.630967 close(3)                = 0
> 10:36:55.631815 socket(PF_FILE, SOCK_STREAM, 0) = 3
> 10:36:55.632171 fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
> 10:36:55.632348 connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
> 10:36:55.632587 close(3)                = 0
> 10:36:55.632751 socket(PF_FILE, SOCK_STREAM, 0) = 3
> 10:36:55.632906 fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
> 10:36:55.633060 connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
> 10:36:55.633271 close(3)                = 0
> 10:36:55.633481 open("/etc/nsswitch.conf", O_RDONLY) = 3
> 10:36:55.633676 fstat64(3, {st_mode=S_IFREG|0644, st_size=508, ...}) = 0
> 10:36:55.633880 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3d000
> 10:36:55.634059 read(3, "# /etc/nsswitch.conf:\n# $Header:"..., 4096) = 508
> 10:36:55.634305 read(3, "", 4096)       = 0
> 10:36:55.634485 close(3)                = 0
> 10:36:55.634633 munmap(0xb7f3d000, 4096) = 0
> 10:36:55.634833 open("/etc/ld.so.cache", O_RDONLY) = 3
> 10:36:55.635010 fstat64(3, {st_mode=S_IFREG|0644, st_size=114984, ...}) = 0
> 10:36:55.635198 mmap2(NULL, 114984, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f21000
> 10:36:55.635362 close(3)                = 0
> 10:36:55.635535 open("/lib/libnss_compat.so.2", O_RDONLY) = 3
> 10:36:55.635713 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\16\0\0004\0\0\0"..., 512) = 512
> 10:36:55.635912 fstat64(3, {st_mode=S_IFREG|0755, st_size=26260, ...}) = 0
> 10:36:55.636091 mmap2(NULL, 29252, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ce4000
> 10:36:55.636250 mmap2(0xb7cea000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5) = 0xb7cea000
> 10:36:55.636484 close(3)                = 0
> 10:36:55.636645 open("/lib/libnsl.so.1", O_RDONLY) = 3
> 10:36:55.636802 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2001\0\0004\0\0\0"..., 512) = 512
> 10:36:55.636997 fstat64(3, {st_mode=S_IFREG|0755, st_size=79544, ...}) = 0
> 10:36:55.637182 mmap2(NULL, 92136, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ccd000
> 10:36:55.637339 mmap2(0xb7ce0000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12) = 0xb7ce0000
> 10:36:55.637546 mmap2(0xb7ce2000, 6120, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7ce2000
> 10:36:55.637730 close(3)                = 0
> 10:36:55.637978 mprotect(0xb7ce0000, 4096, PROT_READ) = 0
> 10:36:55.638140 mprotect(0xb7cea000, 4096, PROT_READ) = 0
> 10:36:55.638287 munmap(0xb7f21000, 114984) = 0
> 10:36:55.638496 open("/etc/ld.so.cache", O_RDONLY) = 3
> 10:36:55.638661 fstat64(3, {st_mode=S_IFREG|0644, st_size=114984, ...}) = 0
> 10:36:55.638834 mmap2(NULL, 114984, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f21000
> 10:36:55.638981 close(3)                = 0
> 10:36:55.639134 open("/lib/libnss_nis.so.2", O_RDONLY) = 3
> 10:36:55.639287 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\31\0\0004\0\0\0"..., 512) = 512
> 10:36:55.639484 fstat64(3, {st_mode=S_IFREG|0755, st_size=34280, ...}) = 0
> 10:36:55.639806 mmap2(NULL, 37440, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7cc3000
> 10:36:55.639976 mmap2(0xb7ccb000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7) = 0xb7ccb000
> 10:36:55.640192 close(3)                = 0
> 10:36:55.640361 open("/lib/libnss_files.so.2", O_RDONLY) = 3
> 10:36:55.640524 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \31\0\0004\0\0\0"..., 512) = 512
> 10:36:55.640721 fstat64(3, {st_mode=S_IFREG|0755, st_size=34244, ...}) = 0
> 10:36:55.640901 mmap2(NULL, 37528, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7cb9000
> 10:36:55.641055 mmap2(0xb7cc1000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7) = 0xb7cc1000
> 10:36:55.641260 close(3)                = 0
> 10:36:55.641473 mprotect(0xb7cc1000, 4096, PROT_READ) = 0
> 10:36:55.641632 mprotect(0xb7ccb000, 4096, PROT_READ) = 0
> 10:36:55.641777 munmap(0xb7f21000, 114984) = 0
> 10:36:55.641968 open("/etc/group", O_RDONLY) = 3
> 10:36:55.642147 fcntl64(3, F_GETFD)     = 0
> 10:36:55.642279 fcntl64(3, F_SETFD, FD_CLOEXEC) = 0
> 10:36:55.642778 _llseek(3, 0, [0], SEEK_CUR) = 0
> 10:36:55.642984 fstat64(3, {st_mode=S_IFREG|0644, st_size=713, ...}) = 0
> 10:36:55.643171 mmap2(NULL, 713, PROT_READ, MAP_SHARED, 3, 0) = 0xb7f3d000
> 10:36:55.643325 _llseek(3, 713, [713], SEEK_SET) = 0
> 10:36:55.643832 munmap(0xb7f3d000, 713) = 0
> 10:36:55.644019 close(3)                = 0
> 10:36:55.644220 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.644645 close(3)                = 0
> 10:36:55.644923 semget(0x56a4d5, 1, IPC_CREAT|0660) = 851970
> 10:36:55.645113 semctl(851970, 0, IPC_64|IPC_STAT, 0xbfa501f8) = 0
> 10:36:55.645270 semctl(851970, 0, IPC_64|IPC_SET, 0xbfa501f8) = 0
> 10:36:55.645427 semop(851970, 0xbfa503c2, 2) = 0
> 10:36:55.645586 shmget(0x56a4d5, 488, IPC_CREAT|0660) = 1048579
> 10:36:55.645768 shmat(1048579, 0, 0)    = 0xb7f3d000
> 10:36:55.645964 mlock(0xb7f3d000, 488)  = 0
> 10:36:55.646146 shmctl(1048579, IPC_64|IPC_STAT, 0xbfa50218) = 0
> 10:36:55.646300 shmctl(1048579, IPC_64|IPC_SET, 0xbfa50218) = 0
> 10:36:55.646711 open("/dev/snd/controlC0", O_RDONLY) = 3
> 10:36:55.646954 close(3)                = 0
> 10:36:55.647131 open("/dev/snd/controlC0", O_RDWR) = 3
> 10:36:55.647296 ioctl(3, USBDEVFS_CONTROL, 0xbfa4ff68) = 0
> 10:36:55.647494 ioctl(3, 0x40045532, 0xbfa4ff64) = 0
> 10:36:55.647635 open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 4
> 10:36:55.647836 ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbfa4ffb0) = 0
> 10:36:55.647986 close(3)                = 0
> 10:36:55.648126 ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbfa4fdbc) = 0
> 10:36:55.648274 fcntl64(4, F_GETFL)     = 0x802 (flags O_RDWR|O_NONBLOCK)
> 10:36:55.648441 ioctl(4, AGPIOC_INFO, 0xbfa4ff68) = 0
> 10:36:55.648571 ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbfa4ff60) = -1 ENOTTY (Inappropriate ioctl for device)
> 10:36:55.649304 write(2, "ALSA lib pcm_dmix.c:829:(snd_pcm"..., 44ALSA lib pcm_dmix.c:829:(snd_pcm_dmix_open) ) = 44
> 10:36:55.649587 write(2, "unable to open slave", 20unable to open slave) = 20
> 10:36:55.649915 write(2, "\n", 1
> )       = 1
> 10:36:55.650106 shmdt(0)                = -1 EINVAL (Invalid argument)
> 10:36:55.650261 shmdt(0xb7f3d000)       = 0
> 10:36:55.650414 shmctl(1048579, IPC_64|IPC_STAT, 0xbfa5021c) = 0
> 10:36:55.650551 shmctl(1048579, IPC_64|IPC_RMID, 0) = 0
> 10:36:55.650704 semctl(851970, 0, IPC_64|IPC_RMID, 0xbfa50268) = 0
> 10:36:55.650968 write(2, "aplay: main:546: ", 17aplay: main:546: ) = 17
> 10:36:55.651198 write(2, "audio open error: Inappropriate "..., 48audio open error: Inappropriate ioctl for device) = 48
> 10:36:55.651390 write(2, "\n", 1
> )       = 1
> 10:36:55.651690 exit_group(1)           = ?
> 
> pico alsa-utils # cat /proc/asound/card0/codec#0
> Codec: VIA VIA VT1708
> Address: 0
> Vendor Id: 0x11061708
> Subsystem Id: 0x11060300
> Revision Id: 0x100700
> No Modem Function Group found
> Default PCM:
>     rates [0x0]:
>     bits [0x0]:
>     formats [0x0]:
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> Node 0x10 [Audio Output] wcaps 0x411: Stereo
>   PCM:
>     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power: 0x0
> Node 0x11 [Audio Output] wcaps 0x411: Stereo
>   PCM:
>     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power: 0x0
> Node 0x12 [Audio Output] wcaps 0x411: Stereo
>   PCM:
>     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power: 0x0
> Node 0x13 [Audio Output] wcaps 0x411: Stereo
>   PCM:
>     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power: 0x0
> Node 0x14 [Audio Output] wcaps 0x211: Stereo Digital
>   PCM:
>     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
>     bits [0xa]: 16 24
>     formats [0x5]: PCM AC3
> Node 0x15 [Audio Input] wcaps 0x10051b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x14, stepsize=0x06, mute=1
>   Amp-In vals:  [0x14 0x14]
>   PCM:
>     rates [0x440]: 48000 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power: 0x0
>   Connection: 1
>      0x18
> Node 0x16 [Audio Input] wcaps 0x100311: Stereo Digital
>   PCM:
>     rates [0x1f0]: 32000 44100 48000 88200 96000
>     bits [0xa]: 16 24
>     formats [0x5]: PCM AC3
>   Connection: 1
>      0x26
> Node 0x17 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x06, mute=1
>   Amp-In vals:  [0x1f 0x1f] [0x00 0x00] [0x9d 0x9d] [0x1e 0x1e] [0x00 0x00] [0x80 0x80]
>   Connection: 6
>      0x10 0x24 0x1d 0x1e 0x21 0x13
> Node 0x18 [Audio Selector] wcaps 0x300101: Stereo
>   Connection: 5
>      0x17* 0x24 0x1d 0x1e 0x21
> Node 0x19 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 1
>      0x11
> Node 0x1a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 1
>      0x12
> Node 0x1b [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 1
>      0x13
> Node 0x1c [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x081c: OUT HP Detect
>   Pin Default 0x410110f2: [N/A] Line Out at Ext Rear
>     Conn = 1/8, Color = Black
>   EAPD: 0x0
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x19
> Node 0x1d [Pin Complex] wcaps 0x400101: Stereo
>   Pincap 0x08334: IN OUT Detect
>   Pin Default 0x01a19026: [Jack] Mic at Ext Rear
>     Conn = 1/8, Color = Pink
>   EAPD: 0x0
>   Pin-ctls: 0x21: IN
>   Connection: 1
>      0x1a
> Node 0x1e [Pin Complex] wcaps 0x400101: Stereo
>   Pincap 0x08334: IN OUT Detect
>   Pin Default 0x0181302e: [Jack] Line In at Ext Rear
>     Conn = 1/8, Color = Blue
>   EAPD: 0x0
>   Pin-ctls: 0x20: IN
>   Connection: 1
>      0x19
> Node 0x1f [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
>   Amp-Out vals:  [0x18 0x18]
>   Pincap 0x081c: OUT HP Detect
>   Pin Default 0x01014010: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Green
>   EAPD: 0x0
>   Pin-ctls: 0x40: OUT
>   Connection: 1
>      0x17
> Node 0x20 [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x081c: OUT HP Detect
>   Pin Default 0x422140f0: [N/A] HP Out at Ext Front
>     Conn = 1/8, Color = Green
>   EAPD: 0x0
>   Pin-ctls: 0x40: OUT
>   Connection: 1
>      0x17
> Node 0x21 [Pin Complex] wcaps 0x400101: Stereo
>   Pincap 0x08334: IN OUT Detect
>   Pin Default 0x42a190f0: [N/A] Mic at Ext Front
>     Conn = 1/8, Color = Pink
>   EAPD: 0x0
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x1b
> Node 0x22 [Pin Complex] wcaps 0x400101: Stereo
>   Pincap 0x0814: OUT Detect
>   Pin Default 0x410160f1: [N/A] Line Out at Ext Rear
>     Conn = 1/8, Color = Orange
>   EAPD: 0x0
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x1a
> Node 0x23 [Pin Complex] wcaps 0x400101: Stereo
>   Pincap 0x0814: OUT Detect
>   Pin Default 0x410120f4: [N/A] Line Out at Ext Rear
>     Conn = 1/8, Color = Grey
>   EAPD: 0x0
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x1b
> Node 0x24 [Pin Complex] wcaps 0x400001: Stereo
>   Pincap 0x0820: IN
>   Pin Default 0x593301f7: [N/A] CD at Int ATAPI
>     Conn = ATAPI, Color = Unknown
>   EAPD: 0x0
>   Pin-ctls: 0x00:
> Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x074411f0: [Jack] SPDIF Out at Ext Rear Panel
>     Conn = RCA, Color = Black
>   Pin-ctls: 0x40: OUT
>   Connection: 1
>      0x14
> Node 0x26 [Pin Complex] wcaps 0x400201: Stereo Digital
>   Pincap 0x0810030: IN OUT EAPD
>   Pin Default 0x07c421f0: [Jack] SPDIF In at Ext Rear Panel
>     Conn = RCA, Color = Grey
>   Pin-ctls: 0x20: IN
> Node 0x27 [Audio Input] wcaps 0x10051b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x14, stepsize=0x06, mute=1
>   Amp-In vals:  [0x14 0x14]
>   PCM:
>     rates [0x440]: 48000 192000
>     bits [0xa]: 16 24
>     formats [0x1]: PCM
>   Power: 0x0
>   Connection: 1
>      0x21

I'd like to get this card's spdif working.  What else can I do to help?
Although the driver loads, the user space tools can't use the card any
more.  Thank you.
