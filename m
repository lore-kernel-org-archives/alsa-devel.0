From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: Re: Opening dev/dsp takes very long
Date: Mon, 15 Mar 2004 21:22:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4056108F.20503@gmx.de>
References: <40536881.4030903@gmx.de> <s5hr7vuiej6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7vuiej6.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai wrote:

| try strace with -r option and check which call takes too long time.

I have tried to run the application with the longest delay (~5 seconds)
using 'strace -r' wich is an X-application. Unfortunately, it spills out
a lot of text (~2.8 MB). I guess you are not interested in that one.

When I use the application 'play' the delay is only around one second,
the strace output is attached below.

Greetings,

Lars.

PS: The file I played is a wav-file containing _only a single sample_ to
make sure playing of the file does not interfer with the time measurement.


PPS: The longest time period is this line (~10 lines from the bottom up):
1.687172 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
When I monitor the sound while watching the strace output, I can see
that line beeing written half way, than the delay, than the click of the
soundcard, then the rest of the strace output.


Attached strace output:

[lars@lars-heineken CD-Recorder]$ strace -r play 01.wav
~     0.000000 execve("/usr//bin/play", ["play", "01.wav"], [/* 52 vars
*/]) = 0
~     0.000676 uname({sys="Linux", node="lars-heineken.lan", ...}) = 0
~     0.000357 brk(0)                    = 0x80ea000
~     0.000233 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
~     0.000335 open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such
file or directory)
~     0.000444 open("/etc/ld.so.cache", O_RDONLY) = 3
~     0.000295 fstat64(3, {st_mode=S_IFREG|0644, st_size=69759, ...}) = 0
~     0.000303 old_mmap(NULL, 69759, PROT_READ, MAP_PRIVATE, 3, 0) =
0x40015000
~     0.000279 close(3)                  = 0
~     0.000225 open("/lib/libtermcap.so.2", O_RDONLY) = 3
~     0.000338 read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\r\0"..., 512) = 512
~     0.000353 fstat64(3, {st_mode=S_IFREG|0755, st_size=12112, ...}) = 0
~     0.000263 old_mmap(NULL, 15272, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3,
0) = 0x40027000
~     0.000275 old_mmap(0x4002a000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x2000) = 0x4002a000
~     0.000334 close(3)                  = 0
~     0.000245 open("/lib/libdl.so.2", O_RDONLY) = 3
~     0.000315 read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\31"..., 512) = 512
~     0.000297 fstat64(3, {st_mode=S_IFREG|0755, st_size=9160, ...}) = 0
~     0.000275 old_mmap(NULL, 12008, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3,
0) = 0x4002b000
~     0.000272 old_mmap(0x4002d000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x1000) = 0x4002d000
~     0.000321 close(3)                  = 0
~     0.000220 open("/lib/i686/libc.so.6", O_RDONLY) = 3
~     0.000315 read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20]\1\000"..., 512) = 512
~     0.000291 fstat64(3, {st_mode=S_IFREG|0755, st_size=1237568, ...}) = 0
~     0.000263 old_mmap(NULL, 1242756, PROT_READ|PROT_EXEC, MAP_PRIVATE,
3, 0) = 0x4002e000
~     0.000274 old_mmap(0x40158000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x12a000) = 0x40158000
~     0.000352 old_mmap(0x4015b000, 9860, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4015b000
~     0.000310 close(3)                  = 0
~     0.000254 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4015e000
~     0.001188 munmap(0x40015000, 69759) = 0
~     0.000772 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000913 open("/dev/tty", O_RDWR|O_NONBLOCK|O_LARGEFILE) = 3
~     0.000488 close(3)                  = 0
~     0.000410 open("/usr/share/locale/locale-archive",
O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
~     0.000526 brk(0)                    = 0x80ea000
~     0.000303 brk(0)                    = 0x80ea000
~     0.000269 brk(0x80eb000)            = 0x80eb000
~     0.000317 brk(0)                    = 0x80eb000
~     0.000354 brk(0x80ec000)            = 0x80ec000
~     0.000332 open("/usr/share/locale/locale.alias", O_RDONLY) = 3
~     0.000469 fstat64(3, {st_mode=S_IFREG|0644, st_size=2601, ...}) = 0
~     0.000341 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
~     0.000334 read(3, "# Locale name alias data base.\n#"..., 4096) = 2601
~     0.000437 brk(0)                    = 0x80ec000
~     0.000274 brk(0x80ed000)            = 0x80ed000
~     0.000324 brk(0)                    = 0x80ed000
~     0.000363 brk(0x80ee000)            = 0x80ee000
~     0.000374 read(3, "", 4096)         = 0
~     0.000294 close(3)                  = 0
~     0.000365 munmap(0x40015000, 4096)  = 0
~     0.000362 open("/usr/share/locale/de_DE/LC_IDENTIFICATION",
O_RDONLY) = 3
~     0.000456 fstat64(3, {st_mode=S_IFREG|0644, st_size=373, ...}) = 0
~     0.000330 mmap2(NULL, 373, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
~     0.000327 close(3)                  = 0
~     0.000323 open("/usr/share/locale/de_DE/LC_MEASUREMENT", O_RDONLY) = 3
~     0.000407 fstat64(3, {st_mode=S_IFREG|0644, st_size=29, ...}) = 0
~     0.000376 mmap2(NULL, 29, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
~     0.000343 close(3)                  = 0
~     0.000299 open("/usr/share/locale/de_DE/LC_TELEPHONE", O_RDONLY) = 3
~     0.000411 fstat64(3, {st_mode=S_IFREG|0644, st_size=62, ...}) = 0
~     0.000341 mmap2(NULL, 62, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
~     0.000308 close(3)                  = 0
~     0.000290 open("/usr/share/locale/de_DE/LC_ADDRESS", O_RDONLY) = 3
~     0.000418 fstat64(3, {st_mode=S_IFREG|0644, st_size=165, ...}) = 0
~     0.000321 mmap2(NULL, 165, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
~     0.000452 close(3)                  = 0
~     0.000313 open("/usr/share/locale/de_DE/LC_NAME", O_RDONLY) = 3
~     0.000424 fstat64(3, {st_mode=S_IFREG|0644, st_size=88, ...}) = 0
~     0.000346 mmap2(NULL, 88, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40019000
~     0.000313 close(3)                  = 0
~     0.000292 open("/usr/share/locale/de_DE/LC_PAPER", O_RDONLY) = 3
~     0.000416 fstat64(3, {st_mode=S_IFREG|0644, st_size=40, ...}) = 0
~     0.000322 mmap2(NULL, 40, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001a000
~     0.000323 close(3)                  = 0
~     0.000310 open("/usr/share/locale/de_DE/LC_MESSAGES", O_RDONLY) = 3
~     0.000404 fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
~     0.000319 close(3)                  = 0
~     0.000400
open("/usr/share/locale/de_DE/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 3
~     0.000418 fstat64(3, {st_mode=S_IFREG|0644, st_size=60, ...}) = 0
~     0.000338 mmap2(NULL, 60, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001b000
~     0.000314 close(3)                  = 0
~     0.000299 open("/usr/share/locale/de_DE/LC_MONETARY", O_RDONLY) = 3
~     0.000421 fstat64(3, {st_mode=S_IFREG|0644, st_size=292, ...}) = 0
~     0.000320 mmap2(NULL, 292, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001c000
~     0.000309 close(3)                  = 0
~     0.000309 open("/usr/share/locale/de_DE/LC_COLLATE", O_RDONLY) = 3
~     0.000437 fstat64(3, {st_mode=S_IFREG|0644, st_size=22592, ...}) = 0
~     0.000325 mmap2(NULL, 22592, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001d000
~     0.000402 close(3)                  = 0
~     0.000313 open("/usr/share/locale/de_DE/LC_TIME", O_RDONLY) = 3
~     0.000407 fstat64(3, {st_mode=S_IFREG|0644, st_size=2349, ...}) = 0
~     0.000343 mmap2(NULL, 2349, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40023000
~     0.000314 close(3)                  = 0
~     0.000348 open("/usr/share/locale/de_DE/LC_NUMERIC", O_RDONLY) = 3
~     0.053354 fstat64(3, {st_mode=S_IFREG|0644, st_size=60, ...}) = 0
~     0.000619 mmap2(NULL, 60, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40024000
~     0.000352 close(3)                  = 0
~     0.000329 open("/usr/share/locale/de_DE/LC_CTYPE", O_RDONLY) = 3
~     0.000485 fstat64(3, {st_mode=S_IFREG|0644, st_size=207996, ...}) = 0
~     0.000395 mmap2(NULL, 207996, PROT_READ, MAP_PRIVATE, 3, 0) =
0x4015f000
~     0.000329 close(3)                  = 0
~     0.000372 getuid32()                = 501
~     0.000377 getgid32()                = 501
~     0.000277 geteuid32()               = 501
~     0.000281 getegid32()               = 501
~     0.000285 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000336 time(NULL)                = 1079381623
~     0.000354 brk(0)                    = 0x80ee000
~     0.000284 brk(0x80ef000)            = 0x80ef000
~     0.000399 open("/etc/mtab", O_RDONLY) = 3
~     0.000473 fstat64(3, {st_mode=S_IFREG|0644, st_size=1054, ...}) = 0
~     0.000334 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40192000
~     0.000336 read(3, "/dev/ide/host0/bus1/target0/lun0"..., 4096) = 1054
~     0.000447 close(3)                  = 0
~     0.000343 munmap(0x40192000, 4096)  = 0
~     0.000295 open("/proc/meminfo", O_RDONLY) = 3
~     0.000477 fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
~     0.000320 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40192000
~     0.000352 read(3, "MemTotal:       579664 kB\nMemFre"..., 1024) = 572
~     0.000423 close(3)                  = 0
~     0.000485 munmap(0x40192000, 4096)  = 0
~     0.000301 brk(0)                    = 0x80ef000
~     0.000266 brk(0x80f0000)            = 0x80f0000
~     0.000770 rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
~     0.000416 rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
~     0.000318 rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 8) = 0
~     0.000295 rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 8) = 0
~     0.000290 rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_DFL}, 8) = 0
~     0.000310 rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_DFL}, 8) = 0
~     0.000315 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000382 rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_DFL}, 8) = 0
~     0.000491 uname({sys="Linux", node="lars-heineken.lan", ...}) = 0
~     0.000509 brk(0)                    = 0x80f0000
~     0.000304 brk(0x80f1000)            = 0x80f1000
~     0.000314 brk(0)                    = 0x80f1000
~     0.000275 brk(0x80f2000)            = 0x80f2000
~     0.000316 brk(0)                    = 0x80f2000
~     0.000291 brk(0x80f3000)            = 0x80f3000
~     0.000316 stat64("/home/lars/win_e/CD-Recorder",
{st_mode=S_IFDIR|0777, st_size=4096, ...}) = 0
~     0.000661 stat64(".", {st_mode=S_IFDIR|0777, st_size=4096, ...}) = 0
~     0.000452 getpid()                  = 7538
~     0.000339 getppid()                 = 7537
~     0.000398 brk(0)                    = 0x80f3000
~     0.000363 brk(0x80f4000)            = 0x80f4000
~     0.000334 getpgrp()                 = 7537
~     0.000291 rt_sigaction(SIGCHLD, {0x80776a0, [], SA_RESTORER,
0x40056ca8}, {SIG_DFL}, 8) = 0
~     0.000389 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000352 open("/usr//bin/play", O_RDONLY|O_LARGEFILE) = 3
~     0.000443 ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbffff4d0) = -1 ENOTTY
(Inappropriate ioctl for device)
~     0.000394 _llseek(3, 0, [0], SEEK_CUR) = 0
~     0.000306 read(3, "#!/bin/sh\n# Shell script to play"..., 80) = 80
~     0.000329 _llseek(3, 0, [0], SEEK_SET) = 0
~     0.000281 getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
~     0.000339 dup2(3, 255)              = 255
~     0.000278 close(3)                  = 0
~     0.000360 fcntl64(255, F_SETFD, FD_CLOEXEC) = 0
~     0.000302 fcntl64(255, F_GETFL)     = 0x8000 (flags
O_RDONLY|O_LARGEFILE)
~     0.000311 fstat64(255, {st_mode=S_IFREG|0755, st_size=5253, ...}) = 0
~     0.000326 _llseek(255, 0, [0], SEEK_CUR) = 0
~     0.000294 brk(0)                    = 0x80f4000
~     0.000266 brk(0x80f6000)            = 0x80f6000
~     0.000310 brk(0)                    = 0x80f6000
~     0.000271 brk(0x80f7000)            = 0x80f7000
~     0.000332 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000334 read(255, "#!/bin/sh\n# Shell script to play"..., 5253) =
5253
~     0.000382 open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
~     0.000537 fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
~     0.000328 close(3)                  = 0
~     0.000362 open("/usr/lib/gconv/gconv-modules", O_RDONLY) = 3
~     0.000395 fstat64(3, {st_mode=S_IFREG|0644, st_size=46058, ...}) = 0
~     0.000320 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40192000
~     0.000358 read(3, "# GNU libc iconv configuration.\n"..., 4096) = 4096
~     0.000501 brk(0)                    = 0x80f7000
~     0.000298 brk(0x80f8000)            = 0x80f8000
~     0.000373 read(3, ".B1.002//\nalias\tJS//\t\t\tJUS_I.B1."..., 4096)
= 4096
~     0.000356 brk(0)                    = 0x80f8000
~     0.000354 brk(0x80f9000)            = 0x80f9000
~     0.000494 brk(0)                    = 0x80f9000
~     0.000285 brk(0x80fa000)            = 0x80fa000
~     0.000406 brk(0)                    = 0x80fa000
~     0.000275 brk(0x80fb000)            = 0x80fb000
~     0.000378 read(3, "859-3\t1\nmodule\tINTERNAL\t\tISO-885"..., 4096)
= 4096
~     0.000401 brk(0)                    = 0x80fb000
~     0.000272 brk(0x80fc000)            = 0x80fc000
~     0.000410 brk(0)                    = 0x80fc000
~     0.000280 brk(0x80fd000)            = 0x80fd000
~     0.000394 brk(0)                    = 0x80fd000
~     0.000294 brk(0x80fe000)            = 0x80fe000
~     0.000361 read(3, "9-14//\nalias\tLATIN8//\t\tISO-8859-"..., 4096) =
4096
~     0.000458 brk(0)                    = 0x80fe000
~     0.000301 brk(0x80ff000)            = 0x80ff000
~     0.000412 brk(0)                    = 0x80ff000
~     0.000281 brk(0x8100000)            = 0x8100000
~     0.000427 brk(0)                    = 0x8100000
~     0.000278 brk(0x8101000)            = 0x8101000
~     0.000318 read(3, "ICESA//\t\tEBCDIC-ES-A//\nmodule\tEB"..., 4096) =
4096
~     0.000487 brk(0)                    = 0x8101000
~     0.000272 brk(0x8102000)            = 0x8102000
~     0.000432 brk(0)                    = 0x8102000
~     0.000280 brk(0x8103000)            = 0x8103000
~     0.000476 read(3, "dule\t\tcost\nalias\tCP285//\t\t\tIBM28"...,
4096) = 4096
~     0.000407 brk(0)                    = 0x8103000
~     0.000273 brk(0x8104000)            = 0x8104000
~     0.000421 brk(0)                    = 0x8104000
~     0.000295 brk(0x8105000)            = 0x8105000
~     0.040093 brk(0)                    = 0x8105000
~     0.000583 brk(0x8106000)            = 0x8106000
~     0.000473 read(3, "5//\t\t\tIBM865//\nalias\tCSIBM865//\t"..., 4096)
= 4096
~     0.000385 brk(0)                    = 0x8106000
~     0.000287 brk(0x8107000)            = 0x8107000
~     0.000452 brk(0)                    = 0x8107000
~     0.000357 brk(0x8108000)            = 0x8108000
~     0.000932 brk(0)                    = 0x8108000
~     0.000332 brk(0x8109000)            = 0x8109000
~     0.000449 read(3, "IBM939\t\t1\nmodule\tINTERNAL\t\tIBM93"..., 4096)
= 4096
~     0.000414 brk(0)                    = 0x8109000
~     0.000306 brk(0x810a000)            = 0x810a000
~     0.000450 brk(0)                    = 0x810a000
~     0.000294 brk(0x810b000)            = 0x810b000
~     0.000472 brk(0)                    = 0x810b000
~     0.000287 brk(0x810c000)            = 0x810c000
~     0.000430 read(3, "s\tGB13000//\t\tGBK//\nalias\tCP936//"..., 4096)
= 4096
~     0.000403 brk(0)                    = 0x810c000
~     0.000279 brk(0x810d000)            = 0x810d000
~     0.000560 brk(0)                    = 0x810d000
~     0.000287 brk(0x810e000)            = 0x810e000
~     0.000517 brk(0)                    = 0x810e000
~     0.000291 brk(0x810f000)            = 0x810f000
~     0.000389 read(3, "//\tANSI_X3.110//\nalias\tISO-IR-99"..., 4096) =
4096
~     0.000492 brk(0)                    = 0x810f000
~     0.000275 brk(0x8110000)            = 0x8110000
~     0.000502 brk(0)                    = 0x8110000
~     0.000286 brk(0x8111000)            = 0x8111000
~     0.000533 read(3, "\t\tcost\nalias\tMS-MAC-CYRILLIC//\tC"..., 4096)
= 4096
~     0.000377 brk(0)                    = 0x8111000
~     0.000267 brk(0x8112000)            = 0x8112000
~     0.000595 brk(0)                    = 0x8112000
~     0.000300 brk(0x8113000)            = 0x8113000
~     0.000536 brk(0)                    = 0x8113000
~     0.000285 brk(0x8114000)            = 0x8114000
~     0.000455 read(3, "\tto\t\t\tmodule\t\tcost\nalias\tPT-CP15"...,
4096) = 1002
~     0.000487 brk(0)                    = 0x8114000
~     0.000280 brk(0x8115000)            = 0x8115000
~     0.000353 read(3, "", 4096)         = 0
~     0.000306 close(3)                  = 0
~     0.000350 munmap(0x40192000, 4096)  = 0
~     0.000727 open("/usr/lib/gconv/ISO8859-15.so", O_RDONLY) = 3
~     0.000486 read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\6\0"..., 512) = 512
~     0.000482 fstat64(3, {st_mode=S_IFREG|0755, st_size=6932, ...}) = 0
~     0.000339 brk(0)                    = 0x8115000
~     0.000268 brk(0x8116000)            = 0x8116000
~     0.000319 old_mmap(NULL, 9868, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3,
0) = 0x40192000
~     0.000346 old_mmap(0x40194000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x1000) = 0x40194000
~     0.000388 close(3)                  = 0
~     0.000531 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000401 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000343 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000301 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000319 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000315 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000325 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000385 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.002773 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000345 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000302 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000321 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000303 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000316 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000321 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000303 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000458 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000368 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000367 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000394 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000336 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000398 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000407 brk(0)                    = 0x8116000
~     0.000295 brk(0x8117000)            = 0x8117000
~     0.000380 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000325 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000472 brk(0)                    = 0x8117000
~     0.000316 brk(0x8118000)            = 0x8118000
~     0.000314 pipe([3, 4])              = 0
~     0.000406 rt_sigprocmask(SIG_BLOCK, [INT CHLD], [RTMIN], 8) = 0
~     0.000445 _llseek(255, -4555, [698], SEEK_CUR) = 0
~     0.000311 fork()                    = 7539
~     0.048333 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000438 --- SIGCHLD (Child exited) @ 0 (0) ---
~     0.000288 waitpid(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0],
WNOHANG) = 7539
~     0.000644 waitpid(-1, 0xbfffef1c, WNOHANG) = -1 ECHILD (No child
processes)
~     0.000321 sigreturn()               = ? (mask now [RTMIN])
~     0.000337 rt_sigaction(SIGCHLD, {0x80776a0, [], SA_RESTORER,
0x40056ca8}, {0x80776a0, [], SA_RESTORER, 0x40056ca8}, 8) = 0
~     0.000382 close(4)                  = 0
~     0.000332 read(3, "play\n", 128)    = 5
~     0.000305 read(3, "", 128)          = 0
~     0.000337 close(3)                  = 0
~     0.000766 rt_sigprocmask(SIG_BLOCK, [CHLD], [RTMIN], 8) = 0
~     0.000347 rt_sigaction(SIGINT, {0x8076710, [], SA_RESTORER,
0x40056ca8}, {SIG_DFL}, 8) = 0
~     0.000364 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000293 rt_sigaction(SIGINT, {SIG_DFL}, {0x8076710, [],
SA_RESTORER, 0x40056ca8}, 8) = 0
~     0.000414 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000332 read(255, "program_version=\"2.0\"\n\nif [ -z \""...,
5253) = 4555
~     0.000453 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000322 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000505 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000356 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000606 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000324 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000420 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000324 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000419 brk(0)                    = 0x8118000
~     0.000300 brk(0x8119000)            = 0x8119000
~     0.000606 brk(0)                    = 0x8119000
~     0.000287 brk(0x811a000)            = 0x811a000
~     0.000473 brk(0)                    = 0x811a000
~     0.000286 brk(0x811b000)            = 0x811b000
~     0.000321 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000314 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000366 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000332 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000962 brk(0)                    = 0x811b000
~     0.000286 brk(0x811c000)            = 0x811c000
~     0.000768 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000388 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000497 brk(0)                    = 0x811c000
~     0.000295 brk(0x811d000)            = 0x811d000
~     0.000311 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000306 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000388 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000384 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000394 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000395 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000353 pipe([3, 4])              = 0
~     0.000366 rt_sigprocmask(SIG_BLOCK, [INT CHLD], [RTMIN], 8) = 0
~     0.000316 _llseek(255, -1305, [3948], SEEK_CUR) = 0
~     0.000286 fork()                    = 7540
~     0.007544 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000426 --- SIGCHLD (Child exited) @ 0 (0) ---
~     0.000320 waitpid(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0],
WNOHANG) = 7540
~     0.000609 waitpid(-1, 0xbfffef1c, WNOHANG) = -1 ECHILD (No child
processes)
~     0.000344 sigreturn()               = ? (mask now [RTMIN])
~     0.000318 rt_sigaction(SIGCHLD, {0x80776a0, [], SA_RESTORER,
0x40056ca8}, {0x80776a0, [], SA_RESTORER, 0x40056ca8}, 8) = 0
~     0.000381 close(4)                  = 0
~     0.000351 read(3, "Linux\n", 128)   = 6
~     0.000290 read(3, "", 128)          = 0
~     0.000262 close(3)                  = 0
~     0.000454 rt_sigprocmask(SIG_BLOCK, [CHLD], [RTMIN], 8) = 0
~     0.000310 rt_sigaction(SIGINT, {0x8076710, [], SA_RESTORER,
0x40056ca8}, {SIG_DFL}, 8) = 0
~     0.000338 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000351 rt_sigaction(SIGINT, {SIG_DFL}, {0x8076710, [],
SA_RESTORER, 0x40056ca8}, 8) = 0
~     0.000423 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000380 read(255, "case $arch in\n  SunOS)\n    case "..., 5253) =
1305
~     0.000864 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000387 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000346 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000378 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000448 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000323 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000418 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000323 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000312 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000323 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000326 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000371 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000621 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000326 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000436 stat64(".", {st_mode=S_IFDIR|0777, st_size=4096, ...}) = 0
~     0.000505 stat64("/usr/bin/sox", {st_mode=S_IFREG|0755,
st_size=253368, ...}) = 0
~     0.035709 getgroups32(0x20, 0x811c188) = 2
~     0.000567 stat64("/usr/bin/sox", {st_mode=S_IFREG|0755,
st_size=253368, ...}) = 0
~     0.000536 brk(0)                    = 0x811d000
~     0.000278 brk(0x811e000)            = 0x811e000
~     0.000334 rt_sigprocmask(SIG_BLOCK, [INT CHLD], [RTMIN], 8) = 0
~     0.000334 fork()                    = 7541
~     0.003752 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000464 rt_sigprocmask(SIG_BLOCK, [CHLD], [RTMIN], 8) = 0
~     0.000332 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000316 rt_sigprocmask(SIG_BLOCK, [CHLD], [RTMIN], 8) = 0
~     0.000507 rt_sigaction(SIGINT, {0x8076710, [], SA_RESTORER,
0x40056ca8}, {SIG_DFL}, 8) = 0
~     0.000702 waitpid(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], 0) = 7541
~     1.687172 rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
~     0.000440 --- SIGCHLD (Child exited) @ 0 (0) ---
~     0.000234 waitpid(-1, 0xbffff11c, WNOHANG) = -1 ECHILD (No child
processes)
~     0.000334 sigreturn()               = ? (mask now [RTMIN])
~     0.000386 rt_sigaction(SIGINT, {SIG_DFL}, {0x8076710, [],
SA_RESTORER, 0x40056ca8}, 8) = 0
~     0.000386 rt_sigprocmask(SIG_BLOCK, NULL, [RTMIN], 8) = 0
~     0.000332 read(255, "", 5253)       = 0
~     0.000400 exit_group(0)             = ?
[lars@lars-heineken CD-Recorder]$
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAVhCPrp9JEomxNXERAk1lAJ48JO5HUnAkdxNYXsTGDEcoFkj9IwCeNmXr
v82UOI+TpB5Armu6bqFZgAs=
=N37X
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
