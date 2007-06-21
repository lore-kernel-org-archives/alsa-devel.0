From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Help with SoC alsa.conf
Date: Thu, 21 Jun 2007 10:36:47 -0500
Message-ID: <61c0054e0706210836r131c3335o9af39df5b6638eae@mail.gmail.com>
References: <61c0054e0706210820g17f90888qed3d9548d46ec1f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 51CBB103843
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 17:36:48 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so593875uge
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2007 08:36:47 -0700 (PDT)
In-Reply-To: <61c0054e0706210820g17f90888qed3d9548d46ec1f6@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have some additional information that may help. As before, when I have:

pcm.!default {
   type hw
   card 0
}
pcm.hw {
   type hw
   card 0
   device 0
   subdevice 0
}
ctl.!default {
   type hw
   card 0
}
ctl.hw {
   type hw
   card 0
}

....as my alsa.conf, I get:

/usr/share/alsa $ aplay -l
**** List of PLAYBACK Hardware Devices ****
ALSA lib conf.c:3949:(snd_config_expand) Unknown parameters 0
ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL hw:0
aplay: device_list:213: control open (0): Invalid argument

However, it will allow me to use speaker-test, aplay, and arecord....sort
of.

Whenever I try to record in the format my codec allows, I get:

/usr/share/alsa $ arecord -D default -traw -fS8 -d2 test.raw
Recording raw data 'test.raw' : Signed 8 bit, Rate 8000 Hz, Mono
arecord: pcm_read:1346: read error: Input/output error


If it will help, here is the strace of that:

/usr/share/alsa $ strace arecord -D default -traw -fS8 -d2 test.raw
execve("/usr/bin/arecord", ["arecord", "-D", "default", "-traw", "-fS8",
"-d2", "test.raw"], [/* 7 0
mmap2(NULL, 20, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40005000
stat("/etc/ld.so.cache", {st_mode=S_IFREG|0644, st_size=1150, ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
mmap2(NULL, 1150, PROT_READ, MAP_SHARED, 3, 0) = 0x40006000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=762072, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0x\367\1\000"..., 4096)
= 4096
mmap2(NULL, 794624, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x4000e000
mmap2(0x4000e000, 745564, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0)
= 0x4000e000
mmap2(0x400cc000, 15508, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0xb6) = 0x400cc000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libm.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=45812, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0t\22\0\000"..., 4096)
= 4096
mmap2(NULL, 81920, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400d0000
mmap2(0x400d0000, 41428, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x400d0000
mmap2(0x400e2000, 4100, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xa)
= 0x400e2000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libdl.so.0", O_RDONLY)       = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=8900, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0(\10\0\000"..., 4096)
= 4096
mmap2(NULL, 40960, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400e4000
mmap2(0x400e4000, 5760, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x400e4000
mmap2(0x400ed000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1)
= 0x400ed000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=63852, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0D<\0\0004"..., 4096) =
4096
mmap2(NULL, 106496, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x400ee000
mmap2(0x400ee000, 40952, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x400ee000
mmap2(0x40100000, 21732, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0xa) = 0x40100000
mmap2(0x40106000, 5788, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401060
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=44167, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0X\25\0\000"..., 4096)
= 4096
mmap2(NULL, 65536, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40108000
mmap2(0x40108000, 28800, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x40108000
mmap2(0x40117000, 548, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x7)
= 0x40117000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libc.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=309840, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0000\253\0"..., 4096) =
4096
mmap2(NULL, 360448, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40118000
mmap2(0x40118000, 302380, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0)
= 0x40118000
mmap2(0x4016a000, 5172, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x4a) = 0x4016a000
mmap2(0x4016c000, 16020, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40160
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libm.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=45812, ...}) = 0
close(3)                                = 0
open("/lib/libdl.so.0", O_RDONLY)       = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=8900, ...}) = 0
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=63852, ...}) = 0
close(3)                                = 0
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=44167, ...}) = 0
close(3)                                = 0
open("/lib/libc.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=309840, ...}) = 0
close(3)                                = 0
open("/lib/libc.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=309840, ...}) = 0
close(3)                                = 0
open("/lib/libc.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=309840, ...}) = 0
close(3)                                = 0
open("/lib/libc.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=309840, ...}) = 0
close(3)                                = 0
open("/lib/libc.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=309840, ...}) = 0
close(3)                                = 0
munmap(0x40006000, 1150)                = 0
stat("/lib/ld-uClibc.so.0", {st_mode=S_IFREG|0755, st_size=21096, ...}) = 0
mprotect(0x400e2000, 4096, PROT_READ)   = 0
mprotect(0x400ed000, 4096, PROT_READ)   = 0
mprotect(0x40100000, 4096, PROT_READ)   = 0
mprotect(0x4016a000, 4096, PROT_READ)   = 0
mprotect(0x4000c000, 4096, PROT_READ)   = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost isig icanon echo
...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost isig icanon echo
...}) = 0
getpid()                                = 893
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2040*1024, rlim_max=RLIM_INFINITY}) = 0
rt_sigaction(SIGRTMIN, {0x400f7d70, [], 0x4000000 /* SA_??? */}, NULL, 8) =
0
rt_sigaction(SIGRT_1, {0x400f7c98, [RTMIN], 0x4000000 /* SA_??? */}, NULL,
8) = 0
rt_sigaction(SIGRT_2, {0x400f72d0, [], 0x4000000 /* SA_??? */}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
brk(0)                                  = 0x1c000
brk(0x1d000)                            = 0x1d000
stat("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=166, ...})
= 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbeea6ae4) = -1 ENOTTY
(Inappropriate ioctl for device)
brk(0x1e000)                            = 0x1e000
read(3, "pcm.!default {\n   type hw\n   car"..., 4096) = 166
read(3, "", 4096)                       = 0
close(3)                                = 0
stat("/etc/ld.so.cache", {st_mode=S_IFREG|0644, st_size=1150, ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
mmap2(NULL, 1150, PROT_READ, MAP_SHARED, 3, 0) = 0x40006000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=762072, ...}) = 0
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbeea69b8)  = 0
ioctl(3, 0x40045532, 0xbeea69c4)        = 0
open("/dev/snd/pcmC0D0c", O_RDWR|O_NONBLOCK) = 4
close(3)                                = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbeea6808) = 0
fcntl(4, F_GETFL)                       = 0x802 (flags O_RDWR|O_NONBLOCK)
ioctl(4, AGPIOC_INFO, 0xbeea69b4)       = 0
ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbeea69ac) = 0
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0xfff80000) = -1 ENXIO (No such
device or address)
ioctl(4, 0xc0844123, 0xbeea6928)        = 0
fcntl(4, F_GETFL)                       = 0x802 (flags O_RDWR|O_NONBLOCK)
fcntl(4, F_SETFL, O_RDWR)               = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbeea6c9c) = 0
rt_sigaction(SIGINT, {0x11530, [INT], SA_RESTART|0x4000000}, {SIG_DFL}, 8) =
0
rt_sigaction(SIGTERM, {0x11530, [TERM], SA_RESTART|0x4000000}, {SIG_DFL}, 8)
= 0
rt_sigaction(SIGABRT, {0x11530, [ABRT], SA_RESTART|0x4000000}, {SIG_DFL}, 8)
= 0
write(2, "Recording", 9Recording)                = 9
write(2, " ", 1 )                        = 1
write(2, "raw data", 8raw data)                 = 8
write(2, " \'", 2 ')                      = 2
write(2, "test.raw", 8test.raw)                 = 8
write(2, "\' : ", 4' : )                    = 4
write(2, "Signed 8 bit", 12Signed 8 bit)            = 12
write(2, ", ", 2, )                       = 2
write(2, "Rate ", 5Rate )                    = 5
write(2, "8000", 48000)                     = 4
write(2, " Hz, ", 5 Hz, )                    = 5
write(2, "Mono", 4Mono)                     = 4
write(2, "\n", 1
)                       = 1
ioctl(4, 0xc25c4110, 0xbeea496c)        = 0
ioctl(4, 0xc25c4110, 0xbeea496c)        = 0
ioctl(4, 0xc25c4110, 0xbeea496c)        = 0
ioctl(4, 0xc25c4110, 0xbeea496c)        = 0
ioctl(4, 0xc25c4110, 0xbeea496c)        = 0
ioctl(4, 0xc25c4110, 0xbeea496c)        = 0
ioctl(4, 0xc25c4110, 0xbeea496c)        = 0
ioctl(4, 0xc25c4111, 0xbeea496c)        = 0
ioctl(4, 0xc0844123, 0x1c448)           = 0
ioctl(4, 0xc0684113, 0xbeea4870)        = 0
ioctl(4, 0x4140, 0x400ba1a8)            = 0
ioctl(4, 0xc0844123, 0x1c448)           = 0
ioctl(4, 0xc0844123, 0x1c448)           = 0
rmdir("test.raw")                       = -1 ENOTDIR (Not a directory)
unlink("test.raw")                      = 0
open("test.raw", O_WRONLY|O_CREAT|O_LARGEFILE, 0644) = 3
ioctl(4, 0x800c4151, 0xbeea4c14)        = -1 EIO (Input/output error)
write(2, "arecord", 7arecord)                  = 7
write(2, ": ", 2: )                       = 2
write(2, "pcm_read", 8pcm_read)                 = 8
write(2, ":", 1:)                        = 1
write(2, "1346", 41346)                     = 4
write(2, ": ", 2: )                       = 2
write(2, "read error: ", 12read error: )            = 12
write(2, "Input/output error", 18Input/output error)      = 18
write(2, "\n", 1
)                       = 1
exit(1)                                 = ?
Process 893 detached

As my codec expects u-law, I am going to create a test file in u-law format
and see if that gives me better results with speaker-test.

Paul

-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
