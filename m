From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Tue, 19 Jun 2007 15:28:13 -0500
Message-ID: <61c0054e0706191328y76f64570ne6a28108abafc2d5@mail.gmail.com>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
	<75b66ecd0706191307m2a93ae4mdf9b1b6dd4ee425a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 7637D24418
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 22:28:14 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so198593uge
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2007 13:28:14 -0700 (PDT)
In-Reply-To: <75b66ecd0706191307m2a93ae4mdf9b1b6dd4ee425a@mail.gmail.com>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/19/07, Lee Revell <rlrevell@joe-job.com> wrote:
>
> On 6/19/07, Paul Kavan <pkavan@gmail.com> wrote:
> > I have managed to get the alsa-libs and aplay, arecord, and speaker-test
> on
> > my board, but I am unsure how to get them to play. I have tried making
> the
> > device nodes and am using a simple alsa.conf, but still no joy. I am
> sure
> > there is something simple I am missing.
>
> What does "strace aplay file.wav" output?
>
> Lee
>

Here is the output of strace aplay Noise.wav:


/usr/lib/share/sounds/alsa $ strace aplay Noise.wav
execve("/usr/sbin/aplay", ["aplay", "Noise.wav"], [/* 7 vars */]) = 0
mmap2(NULL, 20, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40005000
stat("/etc/ld.so.cache", {st_mode=S_IFREG|0644, st_size=1150, ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
mmap2(NULL, 1150, PROT_READ, MAP_SHARED, 3, 0) = 0x40006000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=770500, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\24\373\1"..., 4096) =
4096
mmap2(NULL, 770048, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x4000e000
mmap2(0x4000e000, 752456, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0)
= 0x4000e000
mmap2(0x400c6000, 15744, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0xb8) = 0x400c6000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libm.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=45812, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0t\22\0\000"..., 4096)
= 4096
mmap2(NULL, 81920, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400ca000
mmap2(0x400ca000, 41428, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x400ca000
mmap2(0x400dc000, 4100, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xa)
= 0x400dc000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libdl.so.0", O_RDONLY)       = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=8900, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0(\10\0\000"..., 4096)
= 4096
mmap2(NULL, 40960, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400de000
mmap2(0x400de000, 5760, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x400de000
mmap2(0x400e7000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1)
= 0x400e7000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=63852, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0D<\0\0004"..., 4096) =
4096
mmap2(NULL, 106496, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x400e8000
mmap2(0x400e8000, 40952, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x400e8000
mmap2(0x400fa000, 21732, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0xa) = 0x400fa000
mmap2(0x40100000, 5788, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=44167, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0X\25\0\000"..., 4096)
= 4096
mmap2(NULL, 65536, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40102000
mmap2(0x40102000, 28800, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) =
0x40102000
mmap2(0x40111000, 548, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x7)
= 0x40111000
close(3)                                = 0
munmap(0x40007000, 4096)                = 0
open("/lib/libc.so.0", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=309840, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40007000
read(3, "\177ELF\1\1\1a\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0000\253\0"..., 4096) =
4096
mmap2(NULL, 360448, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x40112000
mmap2(0x40112000, 302380, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0)
= 0x40112000
mmap2(0x40164000, 5172, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x4a) = 0x40164000
mmap2(0x40166000, 16020, PROT_READ|PROT_WRITE,
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
mprotect(0x400dc000, 4096, PROT_READ)   = 0
mprotect(0x400e7000, 4096, PROT_READ)   = 0
mprotect(0x400fa000, 4096, PROT_READ)   = 0
mprotect(0x40164000, 4096, PROT_READ)   = 0
mprotect(0x4000c000, 4096, PROT_READ)   = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost isig icanon echo
...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost isig icanon echo
...}) = 0
getpid()                                = 764
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2040*1024, rlim_max=RLIM_INFINITY}) = 0
rt_sigaction(SIGRTMIN, {0x400f1d70, [], 0x4000000 /* SA_??? */}, NULL, 8) =
0
rt_sigaction(SIGRT_1, {0x400f1c98, [RTMIN], 0x4000000 /* SA_??? */}, NULL,
8) = 0
rt_sigaction(SIGRT_2, {0x400f12d0, [], 0x4000000 /* SA_??? */}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
brk(0)                                  = 0x1c000
brk(0x1d000)                            = 0x1d000
stat("/home/grhuser/buildroot/build_arm/root/usr/share/alsa/alsa.conf",
0xbebe4b70) = -1 ENOENT (No)
write(2, "ALSA lib ", 9ALSA lib )                = 9
write(2, "pcm.c", 5pcm.c)                    = 5
write(2, ":", 1:)                        = 1
write(2, "2144", 42144)                     = 4
write(2, ":(", 2:()                       = 2
write(2, "snd_pcm_open_noupdate", 21snd_pcm_open_noupdate)   = 21
write(2, ") ", 2) )                       = 2
write(2, "Unknown PCM ", 12Unknown PCM )            = 12
write(2, "default", 7default)                  = 7
write(2, "\n", 1
)                       = 1
write(2, "aplay", 5aplay)                    = 5
write(2, ": ", 2: )                       = 2
write(2, "main", 4main)                     = 4
write(2, ":", 1:)                        = 1
write(2, "545", 3545)                      = 3
write(2, ": ", 2: )                       = 2
write(2, "audio open error: ", 18audio open error: )      = 18
write(2, "No such file or directory", 25No such file or directory) = 25
write(2, "\n", 1
)                       = 1
exit(1)                                 = ?
Process 764 detached


Something here sticks out as a problem. There is a line:

stat("/home/grhuser/buildroot/build_arm/root/usr/share/alsa/alsa.conf",
0xbebe4b70) = -1

it should not be looking in this directory, but rather in
"usr/share/alsa/alsa.conf". Might be why it cannot find the alsa.conf

How do I change that?

Paul
-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
