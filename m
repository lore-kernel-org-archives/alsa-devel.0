From: Nathaniel Gray <n8gray@caltech.edu>
Subject: Problems playing with intel8x0 [long]
Date: Mon, 28 Apr 2003 15:42:54 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304281542.54340.n8gray@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The intel8x0 driver has a bad habit of going into an infinite loop and 
consuming 100% cpu when I try to play certain sound files.  I think it
has trouble with non-standard sample rates.  It will handle 44100,
22050, and 11025, but KDE ships some samples with weird rates
like 7418, 11127 and 22254, and if I try to play these with, for example,
aplay, I get the loop.  

I'm attaching an strace to show you what I mean.  Any ideas on dealing with this?

Thanks,
-n8

[n8gray@golux music]$ strace /usr/bin/aplay /usr/share/sounds/KDE_Beep_Pop.wav
execve("/usr/bin/aplay", ["/usr/bin/aplay", "/usr/share/sounds/KDE_Beep_Pop.wav"], [/* 81 vars */]) = 0
uname({sys="Linux", node="golux", ...}) = 0
brk(0)                                  = 0x8052f8c
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40013000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=66082, ...}) = 0
old_mmap(NULL, 66082, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\230"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=575372, ...}) = 0
old_mmap(NULL, 573200, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40025000
mprotect(0x400ae000, 12048, PROT_NONE)  = 0
old_mmap(0x400ae000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x89000) = 0x400ae000
close(3)                                = 0
open("/lib/i686/libm.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2404\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=136052, ...}) = 0
old_mmap(NULL, 138624, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400b1000
mprotect(0x400d2000, 3456, PROT_NONE)   = 0
old_mmap(0x400d2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x20000) = 0x400d2000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\25"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=9212, ...}) = 0
old_mmap(NULL, 12144, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400d3000
mprotect(0x400d5000, 3952, PROT_NONE)   = 0
old_mmap(0x400d5000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1000) = 0x400d5000
close(3)                                = 0
open("/lib/i686/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20A\0\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=87864, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400d6000
old_mmap(NULL, 327200, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400d7000
mprotect(0x400e4000, 273952, PROT_NONE) = 0
old_mmap(0x400e4000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd000) = 0x400e4000
old_mmap(0x400e7000, 261664, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x400e7000
close(3)                                = 0
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260X\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1246468, ...}) = 0
old_mmap(NULL, 1256516, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40127000
mprotect(0x40254000, 23620, PROT_NONE)  = 0
old_mmap(0x40254000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12c000) = 0x40254000
old_mmap(0x40258000, 7236, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40258000
close(3)                                = 0
munmap(0x40014000, 66082)               = 0
modify_ldt(1, {entry_number:0, base_addr:0x400e40a0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, 16) = 0
getpid()                                = 13903
rt_sigaction(SIGRTMIN, {0x400def80, [], SA_RESTORER, 0x4014f3b8}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x400defd0, [], SA_RESTORER, 0x4014f3b8}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x400df700, [], SA_RESTORER, 0x4014f3b8}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfffeddc, 31, (nil), 0}) = 0
brk(0)                                  = 0x8052f8c
brk(0x8053f8c)                          = 0x8053f8c
brk(0)                                  = 0x8053f8c
brk(0x8054000)                          = 0x8054000
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7034, ...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7034, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
brk(0)                                  = 0x8054000
brk(0x8055000)                          = 0x8055000
brk(0)                                  = 0x8055000
brk(0x8056000)                          = 0x8056000
brk(0)                                  = 0x8056000
brk(0x8057000)                          = 0x8057000
read(3, "efaults.ctl.card\n\t\t\t}\n\t\t}\n\t}\n\tty"..., 4096) = 2938
brk(0)                                  = 0x8057000
brk(0x8058000)                          = 0x8058000
brk(0)                                  = 0x8058000
brk(0x8059000)                          = 0x8059000
brk(0)                                  = 0x8059000
brk(0x805a000)                          = 0x805a000
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
brk(0)                                  = 0x805a000
brk(0x805b000)                          = 0x805b000
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or directory)
access("/home/n8gray/.asoundrc", R_OK)  = 0
open("/home/n8gray/.asoundrc", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=161, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(3, "pcm.intel8x0 {\n   type hw\n   car"..., 4096) = 161
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfffea6c)  = 0
ioctl(3, 0x40045532, 0xbfffea94)        = 0
open("/dev/snd/pcmC0D0p", O_RDWR)       = 4
ioctl(4, AGPIOC_INFO, 0xbfffeae8)       = 0
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000) = 0x40014000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0x81000) = 0x40015000
ioctl(4, APM_IOC_STANDBY, 0xbffff004)   = 0
rt_sigaction(SIGINT, {0x400e2550, [INT], SA_RESTORER|SA_RESTART, 0x4014f3b8}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x400e2550, [TERM], SA_RESTORER|SA_RESTART, 0x4014f3b8}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGABRT, {0x400e2550, [ABRT], SA_RESTORER|SA_RESTART, 0x4014f3b8}, {SIG_DFL}, 8) = 0
open("/usr/share/sounds/KDE_Beep_Pop.wav", O_RDONLY) = 3
read(3, "RIFF\226\1\0\0WAVEfmt \20\0\0\0\1\0\1\0", 24) = 24
read(3, "w+", 2)                        = 2
read(3, "\0\0w+\0\0\1\0\10\0", 10)      = 10
read(3, "datar\1\0\0", 8)               = 8
write(2, "Playing WAVE \'/usr/share/sounds/"..., 52Playing WAVE '/usr/share/sounds/KDE_Beep_Pop.wav' : ) = 52
write(2, "Unsigned 8 bit, ", 16Unsigned 8 bit, )        = 16
write(2, "Rate 11127 Hz, ", 15Rate 11127 Hz, )         = 15
write(2, "Mono", 4Mono)                     = 4
write(2, "\n", 1)                       = 1
ioctl(4, 0xc25c4110, 0xbfffe590)        = 0
ioctl(4, 0xc25c4110, 0xbfffe080)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe590)        = 0
ioctl(4, 0xc25c4110, 0xbfffe590)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe590)        = 0
ioctl(4, 0xc25c4110, 0xbfffe590)        = 0
ioctl(4, 0xc25c4110, 0xbfffe990)        = 0
ioctl(4, 0xc25c4110, 0xbfffe0c0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe990)        = 0
ioctl(4, 0xc25c4110, 0xbfffe590)        = 0
ioctl(4, 0xc25c4110, 0xbfffe590)        = 0
ioctl(4, 0xc25c4110, 0xbfffe990)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffdde0)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe6f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe6f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffdde0)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe6f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe6f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe6f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffdde0)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe6f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe6f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe6f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffddd0)        = 0
ioctl(4, 0xc25c4110, 0xbfffd8c0)        = 0
ioctl(4, 0xc25c4110, 0xbfffddd0)        = 0
ioctl(4, 0xc25c4110, 0xbfffddd0)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffddd0)        = 0
ioctl(4, 0xc25c4110, 0xbfffddd0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe1d0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe1d0)        = 0
ioctl(4, 0xc25c4110, 0xbfffddd0)        = 0
ioctl(4, 0xc25c4110, 0xbfffd8c0)        = 0
ioctl(4, 0xc25c4110, 0xbfffddd0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe1d0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe450)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe450)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe450)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe450)        = -1 EINVAL (Invalid argument)
ioctl(4, 0xc25c4110, 0xbfffe450)        = -1 EINVAL (Invalid argument)
Now we get EINVAL forevermore...

-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
