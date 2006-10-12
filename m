From: "Jaap Struyk" <japie@deserver.nl>
Subject: Re: problems with via82xx alsa part
Date: Thu, 12 Oct 2006 16:46:13 +0000 (UTC)
Message-ID: <eglrgk$vpi$1@sea.gmane.org>
References: <ef3pll$kng$1@sea.gmane.org> <efos3e$g63$1@sea.gmane.org>
	<s5hwt7ghsxd.wl%tiwai@suse.de>
	<1160121885.1790.2.camel@japie.deserver.nl>
	<s5hd595u1t3.wl%tiwai@suse.de>
	<1160325289.2558.2.camel@japie.deserver.nl>
	<s5hzmc5pb7c.wl%tiwai@suse.de>
	<1160499844.2449.5.camel@japie.deserver.nl>
	<s5hbqokm65g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Op Tue, 10 Oct 2006 19:28:59 +0200, schreef Takashi Iwai:

> And which version of alsa-lib?  You can use safely the newer version
> of alsa-lib, e.g. 1.0.13.  I won't debug any old versions now.

I installed 1.0.13 now, and installed with debug and removed the -s
option from my CFLAGS.
First the gdb trace:

Starting program: /usr/bin/aplay 
Failed to read a valid object file image from memory.
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
[Thread debugging using libthread_db enabled]
[New Thread -1210538320 (LWP 3767)]
(no debugging symbols found)
(no debugging symbols found)
ALSA lib pcm_direct.c:985:(snd_pcm_direct_initialize_slave) unable to install hw params
ALSA lib pcm_dmix.c:876:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:550: (no debugging symbols found)
audio open error: Ongepaste ioctl voor apparaat
Program exited with code 01.

I don't see why there are no debugging symbols found, yes my whole system
is stripped, but not aplay, so letts try strace again:

execve("/usr/bin/aplay", ["aplay"], [/* 31 vars */]) = 0
brk(0)                                  = 0x8054000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=111674, ...}) = 0
mmap2(NULL, 111674, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f6e000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\371\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1062616, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f6d000
mmap2(NULL, 874804, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e97000
mmap2(0xb7f68000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd0) = 0xb7f68000
close(3)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\3203\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=176787, ...}) = 0
mmap2(NULL, 147584, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e72000
mmap2(0xb7e95000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22) = 0xb7e95000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\f\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=13446, ...}) = 0
mmap2(NULL, 12412, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e6e000
mmap2(0xb7e70000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb7e70000
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000K\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=93769, ...}) = 0
mmap2(NULL, 74204, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e5b000
mmap2(0xb7e6a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe) = 0xb7e6a000
mmap2(0xb7e6c000, 4572, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7e6c000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0PY\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1384330, ...}) = 0
mmap2(NULL, 1172860, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d3c000
mmap2(0xb7e54000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x117) = 0xb7e54000
mmap2(0xb7e58000, 9596, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7e58000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7d3b000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7d3a000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7d3a6b0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0xb7e54000, 8192, PROT_READ)   = 0
munmap(0xb7f6e000, 111674)              = 0
set_tid_address(0xb7d3a6f8)             = 3311
rt_sigaction(SIGRTMIN, {0xb7e5f720, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xb7e5f640, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfa4e810, 40, (nil), 0}) = 0
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=53816992, ...}) = 0
mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7b3a000
mmap2(NULL, 204800, PROT_READ, MAP_PRIVATE, 3, 0xc22) = 0xb7b08000
brk(0)                                  = 0x8054000
brk(0x8075000)                          = 0x8075000
mmap2(NULL, 4096, PROT_READ, MAP_PRIVATE, 3, 0x1c34) = 0xb7f89000
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7701, ...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7701, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f88000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
read(3, "cards.pcm.surround40\npcm.surroun"..., 4096) = 3605
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f88000, 4096)                = 0
futex(0xb7e71070, FUTEX_WAKE, 2147483647) = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or directory)
open("/usr/share/alsa/cards/aliases.conf", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1273, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f88000
read(3, "#\n#  Define aliases for various "..., 4096) = 1273
open("/usr/share/alsa/pcm/default.conf", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=507, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f87000
read(4, "#\n# Default output\n#\n\npcm.!defau"..., 4096) = 507
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f87000, 4096)                = 0
open("/usr/share/alsa/pcm/dmix.conf", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1285, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f87000
read(4, "#\n# dmix output\n#\n\npcm.!dmix {\n\t"..., 4096) = 1285
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f87000, 4096)                = 0
open("/usr/share/alsa/pcm/dsnoop.conf", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1290, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f87000
read(4, "#\n# dsnoop\n#\n\npcm.!dsnoop {\n\t@ar"..., 4096) = 1290
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f87000, 4096)                = 0
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f88000, 4096)                = 0
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7701, ...}) = 0
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR|O_LARGEFILE) = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfa4e5e8)  = 0
ioctl(3, UI_DEV_CREATE, 0xbfa4e590)     = 0
close(3)                                = 0
access("/usr/share/alsa/cards/VIA8233A.conf", R_OK) = 0
open("/usr/share/alsa/cards/VIA8233A.conf", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2892, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f88000
read(3, "#\n# Configuration for the VIA823"..., 4096) = 2892
open("/usr/share/alsa/pcm/front.conf", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=596, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f87000
read(4, "#\n# Hardware output from front s"..., 4096) = 596
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f87000, 4096)                = 0
open("/usr/share/alsa/pcm/surround40.conf", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=749, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f87000
read(4, "#\n#  Hardware output from 4.0 sp"..., 4096) = 749
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f87000, 4096)                = 0
open("/usr/share/alsa/pcm/surround41.conf", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=893, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f87000
read(4, "#\n#  Hardware output from 4.1 sp"..., 4096) = 893
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f87000, 4096)                = 0
open("/usr/share/alsa/pcm/surround50.conf", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=896, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f87000
read(4, "#\n#  Hardware output from 5.0 sp"..., 4096) = 896
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f87000, 4096)                = 0
open("/usr/share/alsa/pcm/surround51.conf", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=783, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f87000
read(4, "#\n#  Hardware output from 5.1 sp"..., 4096) = 783
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f87000, 4096)                = 0
open("/usr/share/alsa/pcm/iec958.conf", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1030, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f87000
read(4, "#\n#  Hardware output from iec958"..., 4096) = 1030
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7f87000, 4096)                = 0
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f88000, 4096)                = 0
open("/dev/snd/controlC1", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC1", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC2", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC2", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC3", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC3", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC4", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC4", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC5", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC5", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC6", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC6", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC7", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC7", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC8", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC8", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC9", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC9", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC10", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC10", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC11", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC11", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC12", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC12", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC13", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC13", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC14", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC14", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC15", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC15", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC16", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC16", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC17", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC17", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC18", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC18", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC19", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC19", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC20", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC20", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC21", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC21", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC22", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC22", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC23", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC23", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC24", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC24", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC25", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC25", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC26", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC26", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC27", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC27", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC28", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC28", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC29", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC29", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC30", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC30", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC31", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/aloadC31", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7701, ...}) = 0
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR|O_LARGEFILE) = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfa4e1f8)  = 0
ioctl(3, UI_DEV_CREATE, 0xbfa4e1a0)     = 0
close(3)                                = 0
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7701, ...}) = 0
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR|O_LARGEFILE) = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfa4dea8)  = 0
ioctl(3, UI_DEV_CREATE, 0xbfa4de50)     = 0
close(3)                                = 0
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7701, ...}) = 0
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR|O_LARGEFILE) = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfa4dea8)  = 0
ioctl(3, UI_DEV_CREATE, 0xbfa4de50)     = 0
close(3)                                = 0
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7701, ...}) = 0
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR|O_LARGEFILE) = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfa4dea8)  = 0
ioctl(3, UI_DEV_CREATE, 0xbfa4de50)     = 0
close(3)                                = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(3)                                = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(3)                                = 0
open("/etc/nsswitch.conf", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=134, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f88000
read(3, "passwd: files\ngroup: files\nshado"..., 4096) = 134
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f88000, 4096)                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=111674, ...}) = 0
mmap2(NULL, 111674, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7aec000
close(3)                                = 0
open("/lib/libnss_files.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\33"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=41717, ...}) = 0
mmap2(NULL, 37528, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ae2000
mmap2(0xb7aea000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7) = 0xb7aea000
close(3)                                = 0
munmap(0xb7aec000, 111674)              = 0
open("/etc/group", O_RDONLY)            = 3
fcntl64(3, F_GETFD)                     = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=598, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7b07000
read(3, "root:x:0:\nbin:x:1:\nsys:x:2:\nkmem"..., 4096) = 598
close(3)                                = 0
munmap(0xb7b07000, 4096)                = 0
semget(5678293, 1, IPC_CREAT|0660)      = 327681
semctl(327681, 0, IPC_64|IPC_STAT, 0xbfa4e318) = 0
semctl(327681, 0, IPC_64|IPC_SET, 0xbfa4e318) = 0
semop(327681, 0xbfa4e4d2, 2)            = 0
shmget(5678293, 488, IPC_CREAT|0660)    = 22249474
shmat(22249474, 0, 0)                   = 0xb7b07000
mlock(0xb7b07000, 488)                  = 0
shmctl(22249474, IPC_64|IPC_STAT, 0xbfa4e328) = 0
shmctl(22249474, IPC_64|IPC_SET, 0xbfa4e328) = 0
open("/dev/snd/controlC0", O_RDONLY|O_LARGEFILE) = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR|O_LARGEFILE) = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfa4e0b8)  = 0
ioctl(3, 0x40045532, 0xbfa4e0b4)        = 0
open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK|O_LARGEFILE) = 4
close(3)                                = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbfa4df0c) = 0
fcntl64(4, F_GETFL)                     = 0x8802 (flags O_RDWR|O_NONBLOCK|O_LARGEFILE)
ioctl(4, AGPIOC_INFO, 0xbfa4e0b8)       = 0
ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbfa4e0b0) = 0
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000) = 0xb7b06000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0x81000) = 0xb7b05000
ioctl(4, 0xc25c4110, 0xbfa4e0e0)        = 0
ioctl(4, 0xc25c4110, 0xbfa4e0e0)        = 0
ioctl(4, 0xc25c4110, 0xbfa4e0e0)        = 0
ioctl(4, 0xc25c4110, 0xbfa4e0e0)        = 0
ioctl(4, 0xc25c4110, 0xbfa4e0e0)        = 0
ioctl(4, 0xc25c4110, 0xbfa4e0e0)        = 0
ioctl(4, 0xc25c4110, 0xbfa4e0e0)        = 0
ioctl(4, 0xc25c4110, 0xbfa4e0e0)        = 0
ioctl(4, 0xc25c4111, 0xbfa4e0e0)        = 0
ioctl(4, 0xc0684113, 0xbfa4dfa8)        = 0
ioctl(4, 0x80144132, 0xbfa4ded8)        = -1 ENOTTY (Inappropriate ioctl for device)
write(2, "ALSA lib pcm_direct.c:985:(snd_p"..., 60ALSA lib pcm_direct.c:985:(snd_pcm_direct_initialize_slave) ) = 60
write(2, "unable to install hw params", 27unable to install hw params) = 27
write(2, "\n", 1
)                       = 1
write(2, "ALSA lib pcm_dmix.c:876:(snd_pcm"..., 44ALSA lib pcm_dmix.c:876:(snd_pcm_dmix_open) ) = 44
write(2, "unable to initialize slave", 26unable to initialize slave) = 26
write(2, "\n", 1
)                       = 1
ioctl(4, 0x4143, 0xb7e97000)            = 0
ioctl(4, 0x4112, 0xb7ef6049)            = 0
close(4)                                = 0
munmap(0xb7b06000, 4096)                = 0
munmap(0xb7b05000, 4096)                = 0
shmdt(0)                                = -1 EINVAL (Invalid argument)
shmdt(0xb7b07000)                       = 0
shmctl(22249474, IPC_64|IPC_STAT, 0xbfa4e330) = 0
shmctl(22249474, IPC_64|IPC_RMID, 0)    = 0
semctl(327681, 0, IPC_64|IPC_RMID, 0xbfa4e378) = 0
write(2, "aplay: main:550: ", 17aplay: main:550: )       = 17
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2586, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7b07000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2586
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7b07000, 4096)                = 0
open("/usr/share/locale/nl_NL/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/nl/LC_MESSAGES/libc.mo", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=114192, ...}) = 0
mmap2(NULL, 114192, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7aec000
close(3)                                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/gconv/gconv-modules", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=54543, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f88000
read(3, "# GNU libc iconv configuration.\n"..., 4096) = 4096
read(3, "as\tJS//\t\t\tJUS_I.B1.002//\nalias\tY"..., 4096) = 4096
read(3, "e\tINTERNAL\t\tISO-8859-3//\t\tISO885"..., 4096) = 4096
read(3, "as\tISO-IR-199//\t\tISO-8859-14//\na"..., 4096) = 4096
read(3, "to\t\t\tmodule\t\tcost\nalias\tCSEBCDIC"..., 4096) = 4096
read(3, "e\t\tcost\nalias\tCP284//\t\t\tIBM284//"..., 4096) = 4096
read(3, "as\tCP864//\t\t\tIBM864//\nalias\t864/"..., 4096) = 4096
read(3, "dule\tIBM937//\t\tINTERNAL\t\tIBM937\t"..., 4096) = 4096
brk(0x8096000)                          = 0x8096000
read(3, "UC-JP//\nalias\tUJIS//\t\t\tEUC-JP//\n"..., 4096) = 4096
read(3, "dule\t\tcost\nalias\tISO-IR-143//\t\tI"..., 4096) = 4096
read(3, "OX//\nmodule\tISO_10367-BOX//\t\tINT"..., 4096) = 4096
read(3, "dule\tINTERNAL\t\tEUC-JISX0213//\t\tE"..., 4096) = 4096
read(3, "odule\tIBM1130//\t\tINTERNAL\t\tIBM11"..., 4096) = 4096
read(3, "804//\t\tIBM16804//\nalias\tCP16804/"..., 4096) = 1295
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f88000, 4096)                = 0
futex(0xb7e57a4c, FUTEX_WAKE, 2147483647) = 0
open("/usr/lib/gconv/ISO8859-1.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\4\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=10986, ...}) = 0
mmap2(NULL, 8220, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7f86000
mmap2(0xb7f87000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb7f87000
close(3)                                = 0
open("/usr/share/locale/nl_NL/LC_MESSAGES/alsa-utils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/nl/LC_MESSAGES/alsa-utils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "audio open error: Ongepaste ioct"..., 47audio open error: Ongepaste ioctl voor apparaat) = 47
write(2, "\n", 1
)                       = 1
exit_group(1)                           = ?
Process 3311 detached

Sorry for all the data...
Driver is kernel based, no modules:

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_AC97_BUS=y
CONFIG_SND_VIA82XX=y

Is there more info I can provide you with?
I recompiled my kernel with alsa-debug and verbose proc info but in my
bootlog nothing odd is showing up.
-- 
Greetings Japie


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
