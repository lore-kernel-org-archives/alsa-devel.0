From: Georgi Georgiev <chutz@gg3.net>
Subject: Re: snd-ioctl32 is failing on x86_64 (no crashes, just errors)
Date: Sat, 8 Jan 2005 16:40:27 +0900
Message-ID: <20050108074026.GA8595@lion.gg3.net>
References: <20050106130649.GA253131@lion.gg3.net> <s5h1xcxy0tj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tiger.gg3.net (142.13.111.219.st.bbexcite.jp [219.111.13.142])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CDAD72DB
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2005 08:40:30 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5h1xcxy0tj.wl@alsa2.suse.de>
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

maillog: 07/01/2005-11:45:44(+0100): Takashi Iwai types
> At Thu, 6 Jan 2005 22:06:50 +0900,
> Georgi Georgiev wrote:
> > 
> > Running a 32-bit version of any application fails with:
> > 
> > amixer: Mixer hw:0 load error: Invalid argument
> > 
> > for example. I have snd-ioctl32 loaded properly (lsmod shows it).
> 
> Try strace amixer and see which ioctl failed.  Maybe it's the size
> mismatching of argument, or an unimplemented ioctl.

Here is the relevant part of a diff between the output of stracing 32
and 64-bit versions of amixer on 2.6.10:

--- amixer.2.6.10-y2.32.log     2005-01-08 16:07:48.000000000 +0900
+++ amixer.2.6.10-y2.64.log     2005-01-08 16:07:27.000000000 +0900
-ioctl(3, USBDEVFS_CONTROL, 0xffffcd4c)  = 0
-fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
-fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
-ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xffffcf90) = 0
-ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xffffcf90) = 0
-ioctl(3, USBDEVFS_CONNECTINFO, 0xffffcc80) = 0
-ioctl(3, USBDEVFS_IOCTL, 0xffffc510)    = -1 EINVAL (Invalid argument)
-write(2, "amixer: ", 8)                 = 8
-write(2, "Mixer default load error: Invali"..., 42) = 42
-write(2, "\n", 1)                       = 1
+ioctl(3, USBDEVFS_CONTROL, 0x7fbfffeb7c) = 0
+fcntl(3, F_GETFL)                       = 0x8002 (flags O_RDWR|O_LARGEFILE|0x8000)
+fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK|0x8000) = 0
+ioctl(3, USBDEVFS_RELEASEINTERFACE, 0x7fbfffed90) = 0
+ioctl(3, USBDEVFS_RELEASEINTERFACE, 0x7fbfffed90) = 0
+open("/etc/mtab", O_RDONLY)             = 4
+fstat(4, {st_mode=S_IFREG|0644, st_size=1041, ...}) = 0
+mmap(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a9556c000
+read(4, "/dev/hdc3 / reiserfs rw,noatime,"..., 131072) = 1041
+close(4)                                = 0
+munmap(0x2a9556c000, 131072)            = 0
+open("/proc/meminfo", O_RDONLY)         = 4
+fstat(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
+mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a9556c000
+read(4, "MemTotal:       768156 kB\nMemFre"..., 1024) = 600
+close(4)                                = 0
+munmap(0x2a9556c000, 4096)              = 0
+ioctl(3, USBDEVFS_CONNECTINFO, 0x7fbfffeac0) = 0
+ioctl(3, USBDEVFS_IOCTL, 0x7fbfffd980)  = 0
+ioctl(3, USBDEVFS_CONNECTINFO, 0x7fbfffeac0) = 0
+ioctl(3, USBDEVFS_IOCTL, 0x7fbfffd980)  = 0
+ioctl(3, USBDEVFS_IOCTL, 0x7fbfffd980)  = 0

Except for minor differences (like 0x7fbfffda40 instead of 0x7fbfffeac0,
etc.), the log from 2.6.7 was identical to the one from 2.6.10.

> > Kernel is vanilla 2.6.10 and I just tried it with version 1.0.8rc2 of
> > alsa-driver. Also, alsa-lib and alsa-utils version 1.0.8rc2 are
> > installed in my 64-bit environment, and also in the 32-bit chroot env
> > where I am trying to run amixer from. The distro is Gentoo, and I also
> > have their alsa-headers-1.0.8_rc2 installed in the 32-bit chroot.
> 
> ALSA ioctl32 in 2.6.10 or older is buggy.  Try to avoid it.

Avoid using ioctl32? I don't have much of a choice since it doesn't work
anyway. It would be nice to get some sound on flash pages and wine,
though.

2.6.10 or older pretty much covers every kernel out there. What kernel
version is it OK to test this with?

-- 
*)   Georgi Georgiev   *) What hath Bob wrought?                       *)
(*    chutz@gg3.net    (*                                              (*
*)  +81(90)6266-1163   *)                                              *)


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
