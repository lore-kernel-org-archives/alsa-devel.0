From: Marco Canini <m.canini@libero.it>
Subject: Re: Re: [Alsa-user] Problem with dmix plugin
Date: 16 May 2003 18:39:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053103184.428.26.camel@jabawack.canini.org>
References: <Pine.LNX.4.44.0305161041010.9877-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0305161041010.9877-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2003-05-16 at 10:41, Jaroslav Kysela wrote:
> On 16 May 2003, Marco Canini wrote:
> 
> > I'm experiencing a problem with the dmix plugin:
> > I've followed the instructions present on 
> > http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php3
> > and on
> > http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html
> > 
> > After I call aplay -D mymix test.wav I can't hear no sound, and aplay
> > hangs undefinitely.
> > 
> > Is this a known issue? How can I sole the problem?
> 
> No, please, provide more information. Driver and library version, where 
> strace of aplay ends... Hardware...
> 
Ok sorry i didn't write them before:

My sound card uses a cs4624.

I'm using kernel 2.5.68, alsa compiled in (no modules)

marco@enoa:~$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20
13:31:57 2003 UTC).
Compiled on Apr 29 2003 for kernel 2.5.68.

alsa-driver is 0.9.3a
alsa-lib is 0.9.3

the strace is:

marco@enoa:~$ strace aplay test.wav
execve("/usr/bin/aplay", ["aplay", "test.wav"], [/* 28 vars */]) = 0
uname({sys="Linux", node="enoa", ...})  = 0
brk(0)                                  = 0x8052000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=36844, ...}) = 0
old_mmap(NULL, 36844, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40012000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\262"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0644, st_size=546252, ...}) = 0
old_mmap(NULL, 548244, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x4001b000
mprotect(0x4009d000, 15764, PROT_NONE)  = 0
old_mmap(0x4009d000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x81000) = 0x4009d000
close(3)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2605\0"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0644, st_size=130964, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x400a1000
old_mmap(NULL, 133536, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x400a2000
mprotect(0x400c2000, 2464, PROT_NONE)   = 0
old_mmap(0x400c2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x1f000) = 0x400c2000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0S\27\0\000"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0644, st_size=7992, ...}) = 0
old_mmap(NULL, 10924, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x400c3000
mprotect(0x400c5000, 2732, PROT_NONE)   = 0
old_mmap(0x400c5000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x1000) = 0x400c5000
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\224D\0"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0644, st_size=81959, ...}) = 0
old_mmap(NULL, 323104, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x400c6000
mprotect(0x400d2000, 273952, PROT_NONE) = 0
old_mmap(0x400d2000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0xc000) = 0x400d2000
old_mmap(0x400d5000, 261664, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x400d5000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0]Z\1\000"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1102984, ...}) = 0
old_mmap(NULL, 1112740, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x40115000
mprotect(0x4021d000, 31396, PROT_NONE)  = 0
old_mmap(0x4021d000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x107000) = 0x4021d000
old_mmap(0x40223000, 6820, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40223000
close(3)                                = 0
mprotect(0x4001b000, 532480, PROT_READ|PROT_WRITE) = 0
mprotect(0x4001b000, 532480, PROT_READ|PROT_EXEC) = 0
munmap(0x40012000, 36844)               = 0
getrlimit(RLIMIT_STACK, {rlim_cur=RLIM_INFINITY,
rlim_max=RLIM_INFINITY}) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) =
0
getpid()                                = 3062
rt_sigaction(SIGRTMIN, {0x400cdc2a, [], SA_RESTORER, 0x4013b898}, NULL,
8) = 0
rt_sigaction(SIGRT_1, {0x400cdc62, [], SA_RESTORER, 0x4013b898}, NULL,
8) = 0
rt_sigaction(SIGRT_2, {0x400cdd15, [], SA_RESTORER, 0x4013b898}, NULL,
8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff56c, 32, (nil), 0}) = 0
brk(0)                                  = 0x8052000
brk(0x8053000)                          = 0x8053000
brk(0)                                  = 0x8053000
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7329,
...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7329, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40012000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
brk(0)                                  = 0x8053000
brk(0x8054000)                          = 0x8054000
brk(0)                                  = 0x8054000
brk(0x8055000)                          = 0x8055000
brk(0)                                  = 0x8055000
brk(0x8056000)                          = 0x8056000
brk(0)                                  = 0x8056000
brk(0x8057000)                          = 0x8057000
read(3, "urround40\npcm.surround51 cards.p"..., 4096) = 3233
brk(0)                                  = 0x8057000
brk(0x8058000)                          = 0x8058000
brk(0)                                  = 0x8058000
brk(0x8059000)                          = 0x8059000
brk(0)                                  = 0x8059000
brk(0x805a000)                          = 0x805a000
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40012000, 4096)                = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or
directory)
access("/home/marco/.asoundrc", R_OK)   = 0
open("/home/marco/.asoundrc", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=355, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40012000
read(3, "pcm.!default {\n        type plug"..., 4096) = 355
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40012000, 4096)                = 0
getuid32()                              = 1000
semget(5679293, 1, IPC_CREAT|0x1b6|0666) = 524288
semop(524288, 0xbffff520, 2)            = 0
shmget(5679293, 1000, IPC_CREAT|0x1b6|0666) = 7405571
shmat(7405571, 0, 0)                    = 0x40012000
mlock(0x40012000, 0)                    = -1 EPERM (Operation not
permitted)
getuid32()                              = 1000
shmctl(7405571, IPC_64|IPC_STAT, 0xbffff4c0) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbffff20c)  = 0
ioctl(3, 0x40045532, 0xbffff234)        = 0
open("/dev/snd/pcmC0D0p", O_RDWR)       = 4
close(3)                                = 0
ioctl(4, APM_IOC_STANDBY, 0xbffff100)   = 0
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
ioctl(4, AGPIOC_INFO, 0xbffff0f8)       = 0
ioctl(4, APM_IOC_SUSPEND, 0xbffff0f4)   = 0
old_mmap(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000000) = 0x40013000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0x81000000) =
0x40014000
ioctl(4, 0xc25c4110, 0x40012104)        = 0
ioctl(4, 0xc25c4110, 0x40012104)        = 0
ioctl(4, 0xc25c4110, 0x40012104)        = 0
ioctl(4, 0xc25c4110, 0x40012104)        = 0
ioctl(4, 0xc25c4110, 0x40012104)        = 0
ioctl(4, 0xc25c4110, 0x40012104)        = 0
ioctl(4, 0xc25c4110, 0x40012104)        = 0
ioctl(4, 0xc25c4110, 0x40012104)        = 0
ioctl(4, 0xc25c4111, 0x40012104)        = 0
ioctl(4, 0xc0684113, 0xbffff440)        = 0
ioctl(4, 0x80104132, 0xbffff370)        = 0
ioctl(4, 0x80104132, 0xbffff370)        = 0
old_mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) =
0x40015000
ioctl(4, 0x4140, 0x400a094c)            = 0
ioctl(4, 0xc0684113, 0x40012360)        = 0
ioctl(4, 0x4142, 0x400a0478)            = 0
gettimeofday({1053103161, 530600}, NULL) = 0
getpid()                                = 3062
socket(PF_UNIX, SOCK_STREAM, 0)         = 3
unlink("/tmp/alsa-dmix-3062-1053103161-530600") = -1 ENOENT (No such
file or directory)
bind(3, {sa_family=AF_UNIX,
path="/tmp/alsa-dmix-3062-1053103161-530600"}, 39) = 0
listen(3, 4)                            = 0
fork()                                  = 3063
shmget(5679294, 12288, IPC_CREAT|0x1b6|0666) = 7438340
shmat(7438340, 0, 0)                    = 0x40017000
mlock(0x40017000, 0)                    = -1 EPERM (Operation not
permitted)
ioctl(4, APM_IOC_STANDBY, 0xbffff370)   = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7329,
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 5
close(5)                                = 0
open("/dev/snd/timer", O_RDONLY|O_NONBLOCK) = 5
ioctl(5, 0x80045400, 0xbffff05c)        = 0
ioctl(5, TIOCSPGRP, 0xbffff060)         = 0
ioctl(5, TIOCSTI, 0xbffff320)           = 0
open("/proc/cpuinfo", O_RDONLY)         = 6
fstat64(6, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x4001a000
read(6, "processor\t: 0\nvendor_id\t: Authen"..., 1024) = 409
read(6, "", 1024)                       = 0
close(6)                                = 0
munmap(0x4001a000, 4096)                = 0
semop(524288, 0xbffff520, 1)            = 0
brk(0)                                  = 0x805a000
brk(0x805b000)                          = 0x805b000
rt_sigaction(SIGINT, {0x804b784, [INT], SA_RESTORER|SA_RESTART,
0x4013b898}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x804b784, [TERM], SA_RESTORER|SA_RESTART,
0x4013b898}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGABRT, {0x804b784, [ABRT], SA_RESTORER|SA_RESTART,
0x4013b898}, {SIG_DFL}, 8) = 0
open("test.wav", O_RDONLY)              = 6
read(6, "RIFF\244\222\5\0WAVEfmt \20\0\0\0\1\0\1\0", 24) = 24
read(6, "\"V", 2)                       = 2
read(6, "\0\0D\254\0\0\2\0\20\0", 10)   = 10
read(6, "data\200\222\5\0", 8)          = 8
write(2, "Playing WAVE \'test.wav\' : ", 26Playing WAVE 'test.wav' : ) =
26
write(2, "Signed 16 bit Little Endian, ", 29Signed 16 bit Little Endian,
) = 29
write(2, "Rate 22050 Hz, ", 15Rate 22050 Hz, )         = 15
write(2, "Mono", 4Mono)                     = 4
write(2, "\n", 1
)                       = 1
shmget(IPC_PRIVATE, 8192, 0x1b6|0666)   = 7471110
shmat(7471110, 0, 0)                    = 0x40225000
shmget(IPC_PRIVATE, 4096, 0x1b6|0666)   = 7503879
shmat(7503879, 0, 0)                    = 0x4001a000
read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
470) = 470
read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
470) = 470
ioctl(5, TIOCPKT, [1074267700])         = 0
gettimeofday({1053103161, 549482}, NULL) = 0
read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "0\366L\365^\364g\363j\362f\361X\360B\357&\356\374\354\306"...,
470) = 470
read(6, "\340\'P&\277$,#\232!\0 ^\36\272\34\22\33p\31\313\27\"\26"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "~\22\314\22\30\23^\23\240\23\335\23\33\24S\24\204\24\260"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\222\34\357\34G\35\235\35\356\35<\36\204\36\306\36\0\037"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\364#($X$\204$\260$\332$\376$\"%C%`%|%\224%\250%\272%\312"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "l\336\300\336\23\337f\337\270\337\n\340Z\340\254\340\374"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\220\33\34\33\246\0320\32\272\31B\31\312\30P\30\326\27"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\6\373M\373\222\373\327\373\32\374\\\374\236\374\340\374"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\214\tY\t$\t\357\10\272\10\204\10L\10\26\10\336\7\246\7"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\366\23\274\23}\0239\23\360\22\240\22L\22\363\21\223\021"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\37\371G\371n\371\226\371\300\371\352\371\25\372B\372q"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\366\1\364\1\362\1\362\1\365\1\371\1\377\1\7\2\22\2\37"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\202\351T\351)\351\1\351\332\350\271\350\234\350\203\350"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\337\23\222\23D\23\366\22\247\22X\22\t\22\274\21l\21\35"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "l\340\300\340\26\341o\341\312\341&\342\203\342\342\342"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "&\31-\0313\0318\31:\31;\31<\31<\31:\0318\0312\31*\31!\31"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "l\7y\7\207\7\224\7\237\7\253\7\267\7\304\7\317\7\334\7"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\242\370\311\370\361\370\33\371G\371t\371\241\371\317\371"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\347\373\345\373\342\373\340\373\336\373\334\373\333\373"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\313\5\363\5\34\6D\6l\6\226\6\276\6\346\6\r\0074\7]\7\205"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, ";\2\'\2\21\2\370\1\336\1\301\1\243\1\201\1_\0018\1\22\1"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\353\v$\fZ\f\220\f\301\f\357\f\33\rC\ri\r\213\r\251\r\304"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "+\365^\365\221\365\307\365\375\3654\366m\366\245\366\337"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\306\374\312\374\314\374\317\374\320\374\324\374\332\374"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "7\322^\316\240\312\3\307\222\303Q\300E\275x\272\364\267"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\317\25\354\26\347\27\272\30k\31\372\31k\32\301\32\376"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\275\25\261\25\255\25\260\25\267\25\277\25\307\25\313\25"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\275\346\335\347\373\350\30\3520\353E\354U\355a\356g\357"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "\256\v\224\fn\r>\16\2\17\272\17g\20\n\21\243\0214\22\275"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "u\7\375\6\215\6$\6\301\5f\5\21\5\302\4x\0044\4\363\3\266"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "&\374\330\372\217\371N\370\24\367\343\365\273\364\236\363"...,
470) = 470
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) =
1
read(5, "\252\302\242\0\1\0\0\0", 40)   = 8
read(6, "H\362\315\362U\363\340\363i\364\366\364\202\365\16\366"...,
470) = 470
poll( <unfinished ...>
marco@enoa:~$ Aborted by signal Terminated...


> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 
> 
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
> The only event dedicated to issues related to Linux enterprise solutions
> www.enterpriselinuxforum.com
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Marco Canini <m.canini@libero.it>



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
