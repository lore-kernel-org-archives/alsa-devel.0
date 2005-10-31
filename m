From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001512]: snd-usb-audio is not compatible with Midiman Midisport 1x1
Date: Mon, 31 Oct 2005 16:30:43 +0100
Message-ID: <4491ef11c409e6c20d4cd1606fd89a7c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F067416B
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2005 16:30:43 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1512> 
======================================================================
Reported By:                negrolder
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1512
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             10-29-2005 21:36 CEST
Last Modified:              10-31-2005 16:30 CET
======================================================================
Summary:                    snd-usb-audio is not compatible with Midiman
Midisport 1x1
Description: 
When I tryed debian and ubuntu I did all an everythig said by als-project
to
install Midiman midisport 1x1 on my PC.

Now I try Open Suse 10.0 and can't make it work.

First I thought the problem was udev but I study it and made the rule for
udev
to load firmware as before. But couldn't make it work.

So searchig for the solution I figured out snd-usb-audio alsa module
cannot be
loaded, as never before. Yast could not instal the generic usb audio
device. 

When system is recently start up I did this

linux:/home/negrolder # lsmod | grep snd
snd_pcm_oss            59168  0
snd_mixer_oss          18944  1 snd_pcm_oss
snd_seq                51984  0
snd_seq_device          8588  1 snd_seq
snd_intel8x0           33408  0
snd_ac97_codec         90876  1 snd_intel8x0
snd_ac97_bus            2432  1 snd_ac97_codec
snd_pcm                93064  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              24452  2 snd_seq,snd_pcm
snd                    60420  8
snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore               9184  1 snd
snd_page_alloc         10632  2 snd_intel8x0,snd_pcm

I figured it out this is a modules problem so:

linux:/home/negrolder # modinfo snd-usb-audio
filename:      
/lib/modules/2.6.13-15-default/kernel/sound/usb/snd-usb-audio.ko
author:         Takashi Iwai <tiwai@suse.de>
description:    USB Audio
license:        GPL
vermagic:       2.6.13-15-default 586 REGPARM gcc-4.0
supported:      yes
depends:        usbcore,snd-usb-lib,snd-pcm,snd,snd-hwdep
alias:          usb:v0499p1000d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1001d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1003d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1004d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0499p1005d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1006d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1007d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1008d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1009d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p100Ad*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0499p100Cd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p100Dd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p100Ed*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p100Fd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1010d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1011d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1012d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1013d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1014d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1015d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1017d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1018d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1019d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p101Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p101Bd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p101Cd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p101Dd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p101Ed*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1020d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1021d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1022d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1023d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1024d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1025d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1026d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1027d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1028d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1029d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p102Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p102Bd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p102Ed*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1030d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1031d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1032d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1033d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1034d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1035d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1036d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1037d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1038d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p1039d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p103Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p103Bd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p103Cd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p103Dd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p2000d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p2001d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p2002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p5000d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p5001d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p5002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p5003d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p5004d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p5005d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p5006d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p5007d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p5008d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p5009d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p500Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p500Bd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p500Cd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p500Dd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p500Ed*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p7000d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0499p7010d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0000d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0003d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0004d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0005d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0007d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0008d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0009d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p000Bd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p000Cd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0010d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0012d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0014d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0016d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p001Bd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p001Dd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0023d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0025d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0027d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0029d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p002Bd*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0582p002Dd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p002Fd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0033d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0037d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p003Bd*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0582p0040d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0042d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0044d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0048d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p004Dd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0050d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0052d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0065d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p006Ad*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0582p006Dd*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0582p0074d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0582p0075d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0763p1002d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0763p1011d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0763p1015d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0763p1021d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0763p1031d010dc*dsc*dp*ic*isc*ip*
alias:          usb:v0763p1033d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0763p1041d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0763p2001d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0763p2003d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0763p2008d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v0763p200Dd*dc*dsc*dp*icFFisc*ip*
alias:          usb:v07FDp0001d*dc*dsc02dp*ic*isc*ip*
alias:          usb:v041Ep3010d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v086Ap0001d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v086Ap0002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v086Ap0003d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0CCDp0013d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v1235p0001d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v1235p0002d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v1235p4661d*dc*dsc*dp*icFFisc*ip*
alias:          usb:v4752p0011d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v7104p2202d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dc*dsc*dp*ic01isc03ip*
alias:          usb:v*p*d*dc*dsc*dp*ic01isc01ip*
srcversion:     FEE16F0661551F72912AAD4
parm:           async_unlink:Use async unlink mode. (bool)
parm:           nrpacks:Max. number of packets per URB. (int)
parm:           pid:Product ID for the USB audio device. (array of int)
parm:           vid:Vendor ID for the USB audio device. (array of int)
parm:           enable:Enable USB audio adapter. (array of bool)
parm:           id:ID string for the USB audio adapter. (array of charp)
parm:           index:Index value for the USB audio adapter. (array of
int)

Midiman Midisport 1x1 has vid=0763 and pid=1010. If I'm not worng (or if
I
understood good) in the alias list above is not pid=1010, and that would
be the
reason why snd-usb-audio cannot be loaded.

Then &iquest;Why is not supported in that module? &iquest;is an alsa
problem or Open Suse 10.0 problem?

I'm using alsa-1.0.9 from distro/mirrors.kernel.org

Thanx

======================================================================

----------------------------------------------------------------------
 negrolder - 10-31-05 16:30 
----------------------------------------------------------------------
Here is something strange:

I compiled my own kernel. This did not solve the problem. I downloaded
alsa-driver-1.0.9rc4. Passed this options to confgure:

./configure --with-cards=usb-audio --with-sequencer=yes --with-suse=yes
--with-moddir=/lib/modules/2.6.13-15-negrolder/

the output was:
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
checking for current directory... /home/negrolder/alsa-driver-1.0.9rc4
checking cross compile...
checking for directory with kernel source...
/lib/modules/2.6.13-15-negrolder/source
checking for directory with kernel build...
/lib/modules/2.6.13-15-negrolder/build
checking for kernel version... 2.6.13-15-negrolder
checking for GCC version... Kernel compiler: gcc 4.0.2 20050901
(prerelease) (SUSE Linux) Used compiler: gcc (GCC) 4.0.2 20050901
(prerelease) (SUSE Linux)
checking for built-in ALSA... "no"
checking for existing ALSA module... "yes"
checking for Red Hat kernel... "auto"
checking for Red Hat kernel... "no"
checking for SUSE kernel... "yes"
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
checking for kernel linux/dma-mapping.h... "yes"
checking for kernel asm/hw_irq.h... "yes"
checking for kernel linux/device.h... "yes"
checking for kernel linux/jiffies.h... "yes"
checking for kernel linux/compat.h... "yes"
checking for kernel linux/adb.h... "yes"
checking for kernel linux/cuda.h... "yes"
checking for kernel linux/pmu.h... "yes"
checking for kernel linux/moduleparam.h... "yes"
checking for kernel linux/syscalls.h... "yes"
checking for kernel linux/firmware.h... "yes"
checking for kernel module symbol versions... "yes"
checking for PCI support in kernel... "yes"
checking for I2C driver in kernel... module
checking for firmware loader... module
checking for input subsystem in kernel... yes
checking for directory to store kernel modules...
/lib/modules/2.6.13-15-negrolder/
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... "yes"
checking for processor type... k7
checking for i386 machine type... default
checking for SMP... "no"
checking for Video device support in kernel... "yes"
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... "yes"
checking for strlcpy... "yes"
checking for snprintf... "yes"
checking for vsnprintf... "yes"
checking for scnprintf... "yes"
checking for sscanf... "yes"
checking for vmalloc_to_page... "yes"
checking for old kmod... "no"
checking for PDE... "yes"
checking for pci_set_consistent_dma_mask... "yes"
checking for pci_dev_present... "yes"
checking for msleep... "yes"
checking for msleep_interrupt... "yes"
checking for tty->count is the atomic type... "no"
checking for video_get_drvdata... "yes"
checking for io_remap_pfn_range... "yes"
checking for kcalloc... "yes"
checking for saved_config_space in pci_dev... "yes"
checking for new pci_save_state... "yes"
checking for driver version... 1.0.9rc4
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... "yes"
checking for HPET support... "yes"
checking for Procfs support... "yes"
checking for USB support... "yes"
checking for new unlocked/compat_ioctl... "no"
checking for PC-Speaker hook... "no"
checking for kernel PCMCIA
checking for PCMCIA support... "yes"
checking for PC9800 support in kernel... "no"
checking for parallel port support... "yes"
checking for which soundcards to compile driver for... usb-audio
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
config.status: include/config.h is unchanged
config.status: creating include/config1.h
config.status: include/config1.h is unchanged
config.status: creating include/version.h
config.status: include/version.h is unchanged
config.status: creating include/autoconf-extra.h
config.status: include/autoconf-extra.h is unchanged
Hacking autoconf.h...

Then Typed make and I got:


[...quoted...]
/home/negrolder/alsa-driver-1.0.9rc4/acore/sound.c: In function
&#8216;snd_register_device&#8217;:
/home/negrolder/alsa-driver-1.0.9rc4/acore/sound.c:240: error: implicit
declaration of function &#8216;class_simple_device_add&#8217;
/home/negrolder/alsa-driver-1.0.9rc4/acore/sound.c: In function
&#8216;snd_unregister_device&#8217;:
/home/negrolder/alsa-driver-1.0.9rc4/acore/sound.c:272: error: implicit
declaration of function &#8216;class_simple_device_remove&#8217;
make[4]: *** [/home/negrolder/alsa-driver-1.0.9rc4/acore/sound.o] Error 1
make[3]: *** [/home/negrolder/alsa-driver-1.0.9rc4/acore] Error 2
make[2]: *** [_module_/home/negrolder/alsa-driver-1.0.9rc4] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.13-15'
make: *** [compile] Error 2

&#191;What's this?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-29-05 21:36 negrolder      New Issue                                    
10-31-05 16:24 negrolder      Issue Monitored: negrolder                    
10-31-05 16:30 negrolder      Note Added: 0006586                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
