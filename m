From: "Arun KS" <getarunks@gmail.com>
Subject: Re: amixer error
Date: Tue, 11 Nov 2008 17:15:15 +0530
Message-ID: <dfeb90390811110345t4bee5c67l28fe807ad9de7667@mail.gmail.com>
References: <dfeb90390811110225m8e77523pd9cccccbae7ea1ec@mail.gmail.com>
	<s5hk5bar1if.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.153])
	by alsa0.perex.cz (Postfix) with ESMTP id EFA281037FA
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 12:45:17 +0100 (CET)
Received: by po-out-1718.google.com with SMTP id b23so5899378poe.2
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 03:45:16 -0800 (PST)
In-Reply-To: <s5hk5bar1if.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 11, 2008 at 4:08 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 11 Nov 2008 15:55:38 +0530,
> Arun KS wrote:
>>
>> Hi,
>>
>> I am getting an error for amixer, but my amixer controls works fine.
>>
>> Here is the log:
>>
>> [root@OMAP2530EVM ~]#
>> [root@OMAP2530EVM ~]#
>> [root@OMAP2530EVM ~]#
>> [root@OMAP2530EVM ~]# amixer
>> amixer: Mixer default load error: Operation not permitted
>
> How about checking via strace?

Below is the strace output:

execve("/bin/amixer", ["amixer"], [/* 18 vars */]) = 0
brk(0)                                  = 0x1b000
uname({sys="Linux", node="OMAP2530EVM", ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001c000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/usr/local/lib/tls/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/tls/v7l/fast-mult/half", 0xbea491c8) = -1
ENOENT (No such file or directory)
open("/usr/local/lib/tls/v7l/fast-mult/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/tls/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/tls/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/tls/v7l/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/tls/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/tls/v7l", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/local/lib/tls/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/tls/fast-mult/half", 0xbea491c8) = -1 ENOENT
(No such file or directory)
open("/usr/local/lib/tls/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/tls/fast-mult", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/tls/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/tls/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/tls/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/lib/tls", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/local/lib/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT
(No such file or directory)
open("/usr/local/lib/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/v7l/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/lib/v7l", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/local/lib/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/fast-mult/half", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/fast-mult", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/lib/half", 0xbea491c8) = -1 ENOENT (No such file or
directory)
open("/usr/local/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file
or directory)
stat64("/usr/local/lib", 0xbea491c8)    = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/lib/tls/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/lib/tls/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/tls/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/tls/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/tls/v7l/half", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/lib/tls/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such file
or directory)
stat64("/usr/lib/tls/v7l", 0xbea491c8)  = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/lib/tls/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/tls/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/tls/fast-mult", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/lib/tls/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/tls/half", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/tls", 0xbea491c8)      = -1 ENOENT (No such file or directory)
open("/usr/lib/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/lib/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/lib/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/v7l/half", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/lib/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/v7l", 0xbea491c8)      = -1 ENOENT (No such file or directory)
open("/usr/lib/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/fast-mult", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/lib/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/usr/lib/half", 0xbea491c8)     = -1 ENOENT (No such file or directory)
open("/usr/lib/libm.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
stat64("/usr/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/lib/tls/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/lib/tls/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/lib/tls/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/lib/tls/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/lib/tls/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/tls/v7l/half", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/lib/tls/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/tls/v7l", 0xbea491c8)      = -1 ENOENT (No such file or directory)
open("/lib/tls/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/lib/tls/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/lib/tls/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/tls/fast-mult", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/lib/tls/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/lib/tls/half", 0xbea491c8)     = -1 ENOENT (No such file or directory)
open("/lib/tls/libm.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
stat64("/lib/tls", 0xbea491c8)          = -1 ENOENT (No such file or directory)
open("/lib/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/lib/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/lib/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/lib/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/lib/v7l/half", 0xbea491c8)     = -1 ENOENT (No such file or directory)
open("/lib/v7l/libm.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
stat64("/lib/v7l", 0xbea491c8)          = -1 ENOENT (No such file or directory)
open("/lib/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such file or
directory)
open("/lib/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such file
or directory)
stat64("/lib/fast-mult", 0xbea491c8)    = -1 ENOENT (No such file or directory)
open("/lib/half/libm.so.6", O_RDONLY)   = -1 ENOENT (No such file or directory)
stat64("/lib/half", 0xbea491c8)         = -1 ENOENT (No such file or directory)
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\00002\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=736490, ...}) = 0
mmap2(NULL, 696480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40025000
mprotect(0x400c7000, 28672, PROT_NONE)  = 0
mmap2(0x400ce000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa1) = 0x400ce000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = -1 ENOENT (No such file or
directory)
open("/lib/libasound.so.2", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0008\344\1\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=2638619, ...}) = 0
mmap2(NULL, 756232, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x400d0000
mprotect(0x4017d000, 32768, PROT_NONE)  = 0
mmap2(0x40185000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xad) = 0x40185000
close(3)                                = 0
open("/usr/lib/libdl.so.2", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0p\t\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=15433, ...}) = 0
mmap2(NULL, 41124, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40189000
mprotect(0x4018b000, 28672, PROT_NONE)  = 0
mmap2(0x40192000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0x40192000
close(3)                                = 0
open("/usr/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file
or directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\230B\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=131823, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001d000
mmap2(NULL, 123384, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40194000
mprotect(0x401a8000, 28672, PROT_NONE)  = 0
mmap2(0x401af000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13) = 0x401af000
mmap2(0x401b1000, 4600, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401b1000
close(3)                                = 0
open("/usr/lib/libc.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\260J\1\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1517741, ...}) = 0
mmap2(NULL, 1184156, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0x401b3000
mprotect(0x402c7000, 32768, PROT_NONE)  = 0
mmap2(0x402cf000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x114) = 0x402cf000
mmap2(0x402d2000, 8604, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x402d2000
close(3)                                = 0
open("/usr/lib/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\330\"\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=65586, ...}) = 0
mmap2(NULL, 75916, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x402d5000
mprotect(0x402e0000, 28672, PROT_NONE)  = 0
mmap2(0x402e7000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa) = 0x402e7000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001e000
syscall_983045(0x4001e2c0, 0x4001f000, 0x4001ea18, 0x4001e998,
0x40024050, 0x40024000, 0, 0xf0005, 0x50, 0xffff5310, 0x50,
0xbea49a74, 0, 0xbea49778, 0x40010cd0, 0x4000208c, 0x20000010,
0x4001e2c0, 0, 0, 0xdb38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = 0
mprotect(0x402cf000, 8192, PROT_READ)   = 0
mprotect(0x401af000, 4096, PROT_READ)   = 0
mprotect(0x40192000, 4096, PROT_READ)   = 0
mprotect(0x400ce000, 4096, PROT_READ)   = 0
set_tid_address(0x4001de68)             = 326
SYS_338(0x4001de70, 0xc, 0x4001de88, 0xffffffec, 0x4001ced8) = 0
rt_sigaction(SIGRTMIN, {0x40197ea4, [], SA_SIGINFO|0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x40197d78, [],
SA_RESTART|SA_SIGINFO|0x4000000}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
brk(0)                                  = 0x1b000
brk(0x3c000)                            = 0x3c000
stat64("/share/alsa/alsa.conf", {st_mode=S_IFREG|0755, st_size=8611, ...}) = 0
open("/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0755, st_size=8611, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001f000
read(3, "#\n#  ALSA library configuration "..., 1024) = 1024
read(3, "aults.pcm.dmix.rate 48000\ndefaul"..., 1024) = 1024
read(3, "m.card\ndefaults.pcm.surround71.d"..., 1024) = 1024
read(3, "cm.phoneline cards.pcm.phoneline"..., 1024) = 1024
read(3, "r\n\t\t\t\tname defaults.pcm.device\n\t"..., 1024) = 1024
read(3, "\t\tname defaults.namehint.basic\n\t"..., 1024) = 1024
read(3, " {\n\t\ttype string\n\t\tdefault {\n\t\t\t"..., 1024) = 1024
read(3, "RD DEV ]\n\t@args.CARD {\n\t\ttype st"..., 1024) = 1024
read(3, "{\n\t\t\t@func refer\n\t\t\tname default"..., 1024) = 419
read(3, "", 1024)                       = 0
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0x4001f000, 4096)                = 0
futex(0x40193094, FUTEX_WAKE, 2147483647) = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbea498fc)  = 0
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbea49980) = 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbea49980) = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492d8)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = -1 EPERM (Operation not permitted)
write(2, "amixer: ", 8amixer: )                 = 8
write(2, "Mixer default load error: Operat"..., 49Mixer default load
error: Operation not permitted) = 49
write(2, "\n", 1
)                       = 1
close(3)                                = 0
exit_group(1)                           = ?execve("/bin/amixer",
["amixer"], [/* 18 vars */]) = 0
brk(0)                                  = 0x1b000
uname({sys="Linux", node="OMAP2530EVM", ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001c000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/usr/local/lib/tls/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/tls/v7l/fast-mult/half", 0xbea491c8) = -1
ENOENT (No such file or directory)
open("/usr/local/lib/tls/v7l/fast-mult/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/tls/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/tls/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/tls/v7l/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/tls/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/tls/v7l", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/local/lib/tls/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/tls/fast-mult/half", 0xbea491c8) = -1 ENOENT
(No such file or directory)
open("/usr/local/lib/tls/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/tls/fast-mult", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/tls/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/tls/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/tls/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/lib/tls", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/local/lib/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT
(No such file or directory)
open("/usr/local/lib/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/v7l/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/lib/v7l", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/local/lib/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/fast-mult/half", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/fast-mult", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/lib/half", 0xbea491c8) = -1 ENOENT (No such file or
directory)
open("/usr/local/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file
or directory)
stat64("/usr/local/lib", 0xbea491c8)    = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/lib/tls/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/lib/tls/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/tls/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/tls/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/tls/v7l/half", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/lib/tls/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such file
or directory)
stat64("/usr/lib/tls/v7l", 0xbea491c8)  = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/lib/tls/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/tls/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/tls/fast-mult", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/lib/tls/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/tls/half", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/tls", 0xbea491c8)      = -1 ENOENT (No such file or directory)
open("/usr/lib/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/lib/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/lib/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/v7l/half", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/lib/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/v7l", 0xbea491c8)      = -1 ENOENT (No such file or directory)
open("/usr/lib/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/fast-mult", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/lib/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/usr/lib/half", 0xbea491c8)     = -1 ENOENT (No such file or directory)
open("/usr/lib/libm.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
stat64("/usr/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/lib/tls/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/lib/tls/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/lib/tls/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/lib/tls/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/lib/tls/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/tls/v7l/half", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/lib/tls/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/tls/v7l", 0xbea491c8)      = -1 ENOENT (No such file or directory)
open("/lib/tls/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/lib/tls/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/lib/tls/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/tls/fast-mult", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/lib/tls/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/lib/tls/half", 0xbea491c8)     = -1 ENOENT (No such file or directory)
open("/lib/tls/libm.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
stat64("/lib/tls", 0xbea491c8)          = -1 ENOENT (No such file or directory)
open("/lib/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/lib/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/lib/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/lib/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/lib/v7l/half", 0xbea491c8)     = -1 ENOENT (No such file or directory)
open("/lib/v7l/libm.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
stat64("/lib/v7l", 0xbea491c8)          = -1 ENOENT (No such file or directory)
open("/lib/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such file or
directory)
open("/lib/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such file
or directory)
stat64("/lib/fast-mult", 0xbea491c8)    = -1 ENOENT (No such file or directory)
open("/lib/half/libm.so.6", O_RDONLY)   = -1 ENOENT (No such file or directory)
stat64("/lib/half", 0xbea491c8)         = -1 ENOENT (No such file or directory)
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\00002\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=736490, ...}) = 0
mmap2(NULL, 696480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40025000
mprotect(0x400c7000, 28672, PROT_NONE)  = 0
mmap2(0x400ce000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa1) = 0x400ce000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = -1 ENOENT (No such file or
directory)
open("/lib/libasound.so.2", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0008\344\1\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=2638619, ...}) = 0
mmap2(NULL, 756232, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x400d0000
mprotect(0x4017d000, 32768, PROT_NONE)  = 0
mmap2(0x40185000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xad) = 0x40185000
close(3)                                = 0
open("/usr/lib/libdl.so.2", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0p\t\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=15433, ...}) = 0
mmap2(NULL, 41124, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40189000
mprotect(0x4018b000, 28672, PROT_NONE)  = 0
mmap2(0x40192000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0x40192000
close(3)                                = 0
open("/usr/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file
or directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\230B\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=131823, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001d000
mmap2(NULL, 123384, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40194000
mprotect(0x401a8000, 28672, PROT_NONE)  = 0
mmap2(0x401af000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13) = 0x401af000
mmap2(0x401b1000, 4600, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401b1000
close(3)                                = 0
open("/usr/lib/libc.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\260J\1\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1517741, ...}) = 0
mmap2(NULL, 1184156, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0x401b3000
mprotect(0x402c7000, 32768, PROT_NONE)  = 0
mmap2(0x402cf000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x114) = 0x402cf000
mmap2(0x402d2000, 8604, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x402d2000
close(3)                                = 0
open("/usr/lib/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\330\"\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=65586, ...}) = 0
mmap2(NULL, 75916, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x402d5000
mprotect(0x402e0000, 28672, PROT_NONE)  = 0
mmap2(0x402e7000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa) = 0x402e7000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001e000
syscall_983045(0x4001e2c0, 0x4001f000, 0x4001ea18, 0x4001e998,
0x40024050, 0x40024000, 0, 0xf0005, 0x50, 0xffff5310, 0x50,
0xbea49a74, 0, 0xbea49778, 0x40010cd0, 0x4000208c, 0x20000010,
0x4001e2c0, 0, 0, 0xdb38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = 0
mprotect(0x402cf000, 8192, PROT_READ)   = 0
mprotect(0x401af000, 4096, PROT_READ)   = 0
mprotect(0x40192000, 4096, PROT_READ)   = 0
mprotect(0x400ce000, 4096, PROT_READ)   = 0
set_tid_address(0x4001de68)             = 326
SYS_338(0x4001de70, 0xc, 0x4001de88, 0xffffffec, 0x4001ced8) = 0
rt_sigaction(SIGRTMIN, {0x40197ea4, [], SA_SIGINFO|0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x40197d78, [],
SA_RESTART|SA_SIGINFO|0x4000000}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
brk(0)                                  = 0x1b000
brk(0x3c000)                            = 0x3c000
stat64("/share/alsa/alsa.conf", {st_mode=S_IFREG|0755, st_size=8611, ...}) = 0
open("/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0755, st_size=8611, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001f000
read(3, "#\n#  ALSA library configuration "..., 1024) = 1024
read(3, "aults.pcm.dmix.rate 48000\ndefaul"..., 1024) = 1024
read(3, "m.card\ndefaults.pcm.surround71.d"..., 1024) = 1024
read(3, "cm.phoneline cards.pcm.phoneline"..., 1024) = 1024
read(3, "r\n\t\t\t\tname defaults.pcm.device\n\t"..., 1024) = 1024
read(3, "\t\tname defaults.namehint.basic\n\t"..., 1024) = 1024
read(3, " {\n\t\ttype string\n\t\tdefault {\n\t\t\t"..., 1024) = 1024
read(3, "RD DEV ]\n\t@args.CARD {\n\t\ttype st"..., 1024) = 1024
read(3, "{\n\t\t\t@func refer\n\t\t\tname default"..., 1024) = 419
read(3, "", 1024)                       = 0
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0x4001f000, 4096)                = 0
futex(0x40193094, FUTEX_WAKE, 2147483647) = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbea498fc)  = 0
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbea49980) = 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbea49980) = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492d8)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = -1 EPERM (Operation not permitted)
write(2, "amixer: ", 8amixer: )                 = 8
write(2, "Mixer default load error: Operat"..., 49Mixer default load
error: Operation not permitted) = 49
write(2, "\n", 1
)                       = 1
close(3)                                = 0
exit_group(1)                           = ?execve("/bin/amixer",
["amixer"], [/* 18 vars */]) = 0
brk(0)                                  = 0x1b000
uname({sys="Linux", node="OMAP2530EVM", ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001c000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/usr/local/lib/tls/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/tls/v7l/fast-mult/half", 0xbea491c8) = -1
ENOENT (No such file or directory)
open("/usr/local/lib/tls/v7l/fast-mult/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/tls/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/tls/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/tls/v7l/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/tls/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/tls/v7l", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/local/lib/tls/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/tls/fast-mult/half", 0xbea491c8) = -1 ENOENT
(No such file or directory)
open("/usr/local/lib/tls/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/tls/fast-mult", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/tls/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/tls/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/tls/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/lib/tls", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/local/lib/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/local/lib/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT
(No such file or directory)
open("/usr/local/lib/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/v7l/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/lib/v7l", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/local/lib/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/fast-mult/half", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/local/lib/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/fast-mult", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/local/lib/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/local/lib/half", 0xbea491c8) = -1 ENOENT (No such file or
directory)
open("/usr/local/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file
or directory)
stat64("/usr/local/lib", 0xbea491c8)    = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1
ENOENT (No such file or directory)
stat64("/usr/lib/tls/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No
such file or directory)
open("/usr/lib/tls/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/tls/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/tls/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/tls/v7l/half", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/lib/tls/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such file
or directory)
stat64("/usr/lib/tls/v7l", 0xbea491c8)  = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/lib/tls/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/tls/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/tls/fast-mult", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/lib/tls/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/tls/half", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/lib/tls/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/tls", 0xbea491c8)      = -1 ENOENT (No such file or directory)
open("/usr/lib/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/usr/lib/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/usr/lib/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/v7l/half", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/lib/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/lib/v7l", 0xbea491c8)      = -1 ENOENT (No such file or directory)
open("/usr/lib/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/usr/lib/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/usr/lib/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/usr/lib/fast-mult", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/usr/lib/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/usr/lib/half", 0xbea491c8)     = -1 ENOENT (No such file or directory)
open("/usr/lib/libm.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
stat64("/usr/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/lib/tls/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT
(No such file or directory)
stat64("/lib/tls/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/lib/tls/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/lib/tls/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such file
or directory)
open("/lib/tls/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/tls/v7l/half", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/lib/tls/v7l/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/lib/tls/v7l", 0xbea491c8)      = -1 ENOENT (No such file or directory)
open("/lib/tls/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/lib/tls/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/lib/tls/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/tls/fast-mult", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/lib/tls/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/lib/tls/half", 0xbea491c8)     = -1 ENOENT (No such file or directory)
open("/lib/tls/libm.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
stat64("/lib/tls", 0xbea491c8)          = -1 ENOENT (No such file or directory)
open("/lib/v7l/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No
such file or directory)
stat64("/lib/v7l/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such
file or directory)
open("/lib/v7l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/v7l/fast-mult", 0xbea491c8) = -1 ENOENT (No such file or directory)
open("/lib/v7l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64("/lib/v7l/half", 0xbea491c8)     = -1 ENOENT (No such file or directory)
open("/lib/v7l/libm.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
stat64("/lib/v7l", 0xbea491c8)          = -1 ENOENT (No such file or directory)
open("/lib/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such
file or directory)
stat64("/lib/fast-mult/half", 0xbea491c8) = -1 ENOENT (No such file or
directory)
open("/lib/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such file
or directory)
stat64("/lib/fast-mult", 0xbea491c8)    = -1 ENOENT (No such file or directory)
open("/lib/half/libm.so.6", O_RDONLY)   = -1 ENOENT (No such file or directory)
stat64("/lib/half", 0xbea491c8)         = -1 ENOENT (No such file or directory)
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\00002\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=736490, ...}) = 0
mmap2(NULL, 696480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40025000
mprotect(0x400c7000, 28672, PROT_NONE)  = 0
mmap2(0x400ce000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa1) = 0x400ce000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = -1 ENOENT (No such file or
directory)
open("/lib/libasound.so.2", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0008\344\1\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=2638619, ...}) = 0
mmap2(NULL, 756232, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x400d0000
mprotect(0x4017d000, 32768, PROT_NONE)  = 0
mmap2(0x40185000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xad) = 0x40185000
close(3)                                = 0
open("/usr/lib/libdl.so.2", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0p\t\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=15433, ...}) = 0
mmap2(NULL, 41124, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40189000
mprotect(0x4018b000, 28672, PROT_NONE)  = 0
mmap2(0x40192000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0x40192000
close(3)                                = 0
open("/usr/lib/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file
or directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\230B\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=131823, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001d000
mmap2(NULL, 123384, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x40194000
mprotect(0x401a8000, 28672, PROT_NONE)  = 0
mmap2(0x401af000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13) = 0x401af000
mmap2(0x401b1000, 4600, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401b1000
close(3)                                = 0
open("/usr/lib/libc.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\260J\1\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1517741, ...}) = 0
mmap2(NULL, 1184156, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0x401b3000
mprotect(0x402c7000, 32768, PROT_NONE)  = 0
mmap2(0x402cf000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x114) = 0x402cf000
mmap2(0x402d2000, 8604, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x402d2000
close(3)                                = 0
open("/usr/lib/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\330\"\0\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=65586, ...}) = 0
mmap2(NULL, 75916, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x402d5000
mprotect(0x402e0000, 28672, PROT_NONE)  = 0
mmap2(0x402e7000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa) = 0x402e7000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001e000
syscall_983045(0x4001e2c0, 0x4001f000, 0x4001ea18, 0x4001e998,
0x40024050, 0x40024000, 0, 0xf0005, 0x50, 0xffff5310, 0x50,
0xbea49a74, 0, 0xbea49778, 0x40010cd0, 0x4000208c, 0x20000010,
0x4001e2c0, 0, 0, 0xdb38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = 0
mprotect(0x402cf000, 8192, PROT_READ)   = 0
mprotect(0x401af000, 4096, PROT_READ)   = 0
mprotect(0x40192000, 4096, PROT_READ)   = 0
mprotect(0x400ce000, 4096, PROT_READ)   = 0
set_tid_address(0x4001de68)             = 326
SYS_338(0x4001de70, 0xc, 0x4001de88, 0xffffffec, 0x4001ced8) = 0
rt_sigaction(SIGRTMIN, {0x40197ea4, [], SA_SIGINFO|0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x40197d78, [],
SA_RESTART|SA_SIGINFO|0x4000000}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
brk(0)                                  = 0x1b000
brk(0x3c000)                            = 0x3c000
stat64("/share/alsa/alsa.conf", {st_mode=S_IFREG|0755, st_size=8611, ...}) = 0
open("/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0755, st_size=8611, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x4001f000
read(3, "#\n#  ALSA library configuration "..., 1024) = 1024
read(3, "aults.pcm.dmix.rate 48000\ndefaul"..., 1024) = 1024
read(3, "m.card\ndefaults.pcm.surround71.d"..., 1024) = 1024
read(3, "cm.phoneline cards.pcm.phoneline"..., 1024) = 1024
read(3, "r\n\t\t\t\tname defaults.pcm.device\n\t"..., 1024) = 1024
read(3, "\t\tname defaults.namehint.basic\n\t"..., 1024) = 1024
read(3, " {\n\t\ttype string\n\t\tdefault {\n\t\t\t"..., 1024) = 1024
read(3, "RD DEV ]\n\t@args.CARD {\n\t\ttype st"..., 1024) = 1024
read(3, "{\n\t\t\t@func refer\n\t\t\tname default"..., 1024) = 419
read(3, "", 1024)                       = 0
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0x4001f000, 4096)                = 0
futex(0x40193094, FUTEX_WAKE, 2147483647) = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbea498fc)  = 0
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbea49980) = 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbea49980) = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492d8)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = -1 EPERM (Operation not permitted)
write(2, "amixer: ", 8amixer: )                 = 8
write(2, "Mixer default load error: Operat"..., 49Mixer default load
error: Operation not permitted) = 49
write(2, "\n", 1
)                       = 1
close(3)                                = 0
exit_group(1)                           = ?


Regards,
Arun
>
>
> Takashi
>
