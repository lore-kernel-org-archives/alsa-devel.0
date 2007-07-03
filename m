From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Errors in application building
Date: Tue, 3 Jul 2007 14:40:49 -0500
Message-ID: <61c0054e0707031240y6d60fed3yea2317b8ad888110@mail.gmail.com>
References: <61c0054e0707031129t28cc1421sde4d3b4ac4b6428b@mail.gmail.com>
	<75b66ecd0707031137i4c302270oa307df11e0a6ad3@mail.gmail.com>
	<61c0054e0707031151n6d90fc97v4493f41c1ab0cd1@mail.gmail.com>
	<61c0054e0707031206i1717e36dy8e69c872b4f33a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by alsa0.perex.cz (Postfix) with ESMTP id C45A3103841
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 21:40:50 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so2405979mue
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2007 12:40:50 -0700 (PDT)
In-Reply-To: <61c0054e0707031206i1717e36dy8e69c872b4f33a@mail.gmail.com>
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
Cc: Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

Hello all:

Just tried to run with the warnings:

grhuser@pcL7:$ arm-linux-gcc -lasound -Wall -o grh_audio grh_audio.c
> grh_audio.c: In function 'grh_capture':
> grh_audio.c:112: warning: pointer targets in passing argument 3 of
> 'snd_pcm_hw_params_set_rate_near' differ in signedness
> grh_audio.c: In function 'grh_playback':
> grh_audio.c:207: warning: pointer targets in passing argument 3 of
> 'snd_pcm_hw_params_set_rate_near' differ in signedness
>
> Which comes from the code:
>
> 112:   if ((err = snd_pcm_hw_params_set_rate_near (capture_handle,
> hw_params, &sample_rate, 0)) < 0)
>
>
> 207:   if ((err = snd_pcm_hw_params_set_rate_near (playback_handle,
> hw_params, &sample_rate, 0)) < 0)
>

However,  I get a seg fault when I ran it. The strace of this is:

/usr/sbin $ strace grh_audio
execve("/usr/sbin/grh_audio", ["grh_audio"], [/* 7 vars */]) = 0
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
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=44167, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0X\25\0\000"..., 4096)
= 4096
mmap2(NULL, 65536, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400d0000
mmap2(0x400d0000, 28800, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x400d0000
mmap2(0x400df000, 548, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x7)
= 0x400df000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libc.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=309840, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0000\253\0"..., 4096) =
4096
mmap2(NULL, 360448, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x400e0000
mmap2(0x400e0000, 302380, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0)
= 0x400e0000
mmap2(0x40132000, 5172, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x4a) = 0x40132000
mmap2(0x40134000, 16020, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40130
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libm.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=45812, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0t\22\0\000"..., 4096)
= 4096
mmap2(NULL, 81920, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40138000
mmap2(0x40138000, 41428, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x40138000
mmap2(0x4014a000, 4100, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xa)
= 0x4014a000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libdl.so.0", O_RDONLY)       = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=8900, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0(\10\0\000"..., 4096)
= 4096
mmap2(NULL, 40960, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4014c000
mmap2(0x4014c000, 5760, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x4014c000
mmap2(0x40155000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1)
= 0x40155000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=63852, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0D<\0\0004"..., 4096) =
4096
mmap2(NULL, 106496, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40156000
mmap2(0x40156000, 40952, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x40156000
mmap2(0x40168000, 21732, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0xa) = 0x40168000
mmap2(0x4016e000, 5788, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4016e0
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
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
mprotect(0x40132000, 4096, PROT_READ)   = 0
mprotect(0x4014a000, 4096, PROT_READ)   = 0
mprotect(0x40155000, 4096, PROT_READ)   = 0
mprotect(0x40168000, 4096, PROT_READ)   = 0
mprotect(0x4000c000, 4096, PROT_READ)   = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost isig icanon echo
...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost isig icanon echo
...}) = 0
getpid()                                = 756
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2040*1024, rlim_max=RLIM_INFINITY}) = 0
rt_sigaction(SIGRTMIN, {0x4015fd70, [], 0x4000000 /* SA_??? */}, NULL, 8) =
0
rt_sigaction(SIGRT_1, {0x4015fc98, [RTMIN], 0x4000000 /* SA_??? */}, NULL,
8) = 0
rt_sigaction(SIGRT_2, {0x4015f2d0, [], 0x4000000 /* SA_??? */}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
Process 756 detached


I am still trying to locate why those warnings are popping up, but as that
part of the code is not called immediately, I am wondering why the seg fault
is occurring. Any clues?

Paul


***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
