From: Raymond <rayau@netvigator.com>
Subject: Re: Re: Re: aplay - How to use device 3 of card 0 ?
Date: Tue, 08 Mar 2005 15:52:04 +0800
Message-ID: <422D59A4.4020702@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

>> # aplay --verbose -d hw:0,3 piano.wav
>> Playing WAVE 'piano.wav' : Signed 16 bit Little Endian, Rate 44100 
Hz, Mono
>> Plug PCM: Hardware PCM card 0 'au8830' device 0 subdevice 0
   ^^^^^^^^^
> It's already wrong.  Instead of hw:0,3, plug layer is used.

> Do you have any definition in ~/.asoundrc or /etc/asound.state?
> Is /usr/share/alsa/alsa.conf is properly updated from the latest
> alsa-lib, too?


ALSA   : alsa-driver-1.0.8, alsa-lib-1.0.8 and alsa-utils-1.0.8

with au88x0_iec958.patch ( replace SPDIF SR control by IEC958 control )

store/restore /etc/asound.state by alsactl /etc/modules.conf

post-install snd-au8830 /usr/sbin/alsactl restore 0
pre-remove snd-au8830 /usr/sbin/alsactl store 0


# strace aplay -d hw:0,3 piano.wav
execve("/usr/bin/aplay", ["aplay", "-d", "hw:0,3", "piano.wav"], [/* 35
vars */]) = 0
uname({sys="Linux", node="localhost.localdomain", ...}) = 0
brk(0)                                  = 0x93ec000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=82204, ...}) = 0
old_mmap(NULL, 82204, PROT_READ, MAP_PRIVATE, 3, 0) = 0xbf50f000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\337"...,
512) = 512fstat64(3, {st_mode=S_IFREG|0755, st_size=1845586, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xbf50e000
old_mmap(NULL, 646688, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x136000
old_mmap(0x1d0000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x9a000) = 0x1d0000
close(3)                                = 0
mprotect(0xbfef8000, 4096,
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN) = -1 EINVAL (Invalid
argument)
mprotect(0xbfef1000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC) = -1 ENOMEM
(Cannot allocate memory)
mprotect(0xbfef5000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC) = -1 ENOMEM
(Cannot allocate memory)
mprotect(0xbfef7000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC) = -1 ENOMEM
(Cannot allocate memory)
mprotect(0xbfef8000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
mprotect(0xbfef7000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC) = -1 ENOMEM
(Cannot allocate memory)
open("/lib/tls/libm.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\365\202"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=213244, ...}) = 0
old_mmap(0x82c000, 138000, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x82c000
old_mmap(0x84d000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x20000) = 0x84d000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\32\205"...,
512) = 512fstat64(3, {st_mode=S_IFREG|0755, st_size=16312, ...}) = 0
old_mmap(0x850000, 12148, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x850000
old_mmap(0x852000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x1000) = 0x852000
close(3)                                = 0
open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\367"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=101264, ...}) = 0
old_mmap(0x97b000, 62436, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x97b000
old_mmap(0x988000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0xd000) = 0x988000
old_mmap(0x989000, 5092, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x989000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`hp\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1578228, ...}) = 0
old_mmap(0x6f1000, 1281996, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x6f1000
old_mmap(0x824000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x132000) = 0x824000
old_mmap(0x828000, 8140, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x828000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xbf50d000
set_thread_area({entry_number:-1 -> 6, base_addr:0xbf50d640,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xbf50f000, 82204)               = 0
set_tid_address(0xbf50d688)             = 4321
rt_sigaction(SIGRTMIN, {0x97f680, [], SA_RESTORER|SA_SIGINFO, 0x9860b0},
NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=10240*1024, rlim_max=RLIM_INFINITY}) = 0
brk(0)                                  = 0x93ec000
brk(0x940d000)                          = 0x940d000
brk(0)                                  = 0x940d000
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8010,
...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8010, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf523000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
read(3, " FORMAT ]\n\t@args.FILE {\n\t\ttype s"..., 4096) = 3914
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xbf523000, 4096)                = 0
futex(0x852f70, FUTEX_WAKE, 2147483647) = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or
directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or
directory)
open("/usr/share/alsa/cards/aliases.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1060, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf523000
read(3, "#\n#  Define aliases for various "..., 4096) = 1060
open("/usr/share/alsa/pcm/default.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=479, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf522000
read(4, "#\n# Default output\n#\n\npcm.!defau"..., 4096) = 479
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xbf522000, 4096)                = 0
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xbf523000, 4096)                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8010,
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfef861c)  = 0
ioctl(3, UI_DEV_CREATE, 0xbfef8750)     = 0
close(3)                                = 0
access("/usr/share/alsa/cards/AU8830.conf", R_OK) = 0
open("/usr/share/alsa/cards/AU8830.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=561, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf523000
read(3, "#\n# Configuration for the AU8830"..., 4096) = 561
open("/usr/share/alsa/pcm/front.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=596, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf522000
read(4, "#\n# Hardware output from front s"..., 4096) = 596
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xbf522000, 4096)                = 0
open("/usr/share/alsa/pcm/surround40.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=749, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf522000
read(4, "#\n#  Hardware output from 4.0 sp"..., 4096) = 749
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xbf522000, 4096)                = 0
open("/usr/share/alsa/pcm/iec958.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1030, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf522000
read(4, "#\n#  Hardware output from iec958"..., 4096) = 1030
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xbf522000, 4096)                = 0
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xbf523000, 4096)                = 0
open("/dev/snd/controlC1", O_RDONLY)    = -1 ENODEV (No such device)
open("/dev/aloadC1", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC2", O_RDONLY)    = -1 ENODEV (No such device)
open("/dev/aloadC2", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC3", O_RDONLY)    = -1 ENODEV (No such device)
open("/dev/aloadC3", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC4", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC4", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC5", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC5", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC6", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC6", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC7", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC7", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC8", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC8", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC9", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC9", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC10", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC10", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC11", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC11", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC12", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC12", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC13", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC13", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC14", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC14", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC15", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC15", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC16", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC16", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC17", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC17", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC18", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC18", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC19", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC19", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC20", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC20", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC21", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC21", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC22", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC22", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC23", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC23", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC24", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC24", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC25", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC25", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC26", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC26", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC27", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC27", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC28", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC28", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC29", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC29", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC30", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC30", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC31", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC31", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8010,
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfef837c)  = 0
ioctl(3, UI_DEV_CREATE, 0xbfef84b0)     = 0
close(3)                                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfef861c)  = 0
ioctl(3, 0x40045532, 0xbfef8644)        = 0
open("/dev/snd/pcmC0D0p", O_RDWR)       = 4
close(3)                                = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbfef8510) = 0
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
ioctl(4, AGPIOC_INFO, 0xbfef850c)       = 0
ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbfef8508) = 0
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000) = 0xbf523000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0x81000) = 0xbf522000
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbfef8ae0) = 0
rt_sigaction(SIGINT, {0x804abf8, [INT], SA_RESTORER|SA_RESTART,
0x718a58}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x804abf8, [TERM], SA_RESTORER|SA_RESTART,
0x718a58}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGABRT, {0x804abf8, [ABRT], SA_RESTORER|SA_RESTART,
0x718a58}, {SIG_DFL}, 8) = 0
open("piano.wav", O_RDONLY|O_LARGEFILE) = 3
read(3, "RIFF\260O\7\0WAVEfmt \20\0\0\0\1\0\1\0", 24) = 24
read(3, "D\254", 2)                     = 2
read(3, "\0\0\210X\1\0\2\0\20\0", 10)   = 10
read(3, "data\214O\7\0", 8)             = 8
write(2, "Playing WAVE \'piano.wav\' : ", 27Playing WAVE 'piano.wav' : )
= 27
write(2, "Signed 16 bit Little Endian, ", 29Signed 16 bit Little Endian,
) = 29
write(2, "Rate 44100 Hz, ", 15Rate 44100 Hz, )         = 15
write(2, "Mono", 4Mono)                     = 4
write(2, "\n", 1
)                       = 1



Only test the alsa-driver-1.0.8, have error when using cvs version.

#./cvscompile --with-cards=au8830 --with-sequencer=yes
...
make  -C mpu401 modules
make[2]: Entering directory `/root/alsa/cvs/alsa-driver/drivers/mpu401'
gcc -D__KERNEL__ -DMODULE=1 -I/root/alsa/cvs/alsa-driver/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2 
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall 
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc 
-iwithprefix include   -DEXPORT_SYMTAB -c mpu401_uart.c
In file included from mpu401_uart.c:1:
../../alsa-kernel/drivers/mpu401/mpu401_uart.c: In function 
`snd_mpu401_uart_input_trigger':
../../alsa-kernel/drivers/mpu401/mpu401_uart.c:313: warning: implicit 
declaration of function `spin_trylock_irqsave'
In file included from mpu401_uart.c:1:
../../alsa-kernel/drivers/mpu401/mpu401_uart.c:298: warning: `flags' 
might be used uninitialized in this function
rm -f snd-mpu401-uart.o
ld  -r -o snd-mpu401-uart.o mpu401_uart.o
make[2]: Leaving directory `/root/alsa/cvs/alsa-driver/drivers/mpu401'
...

#make install
..
/sbin/depmod -a 2.4.22-1.2199.nptl
depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/drivers/mpu401/snd-mpu401-uart.o
...


#/etc/init.d/alsasound start
Starting sound driver: snd-au8830 
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/drivers/mpu401/snd-mpu401-uart.o: 
unresolved symbol spin_trylock_irqsave
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/drivers/mpu401/snd-mpu401-uart.o: 
insmod 
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/drivers/mpu401/snd-mpu401-uart.o 
failed
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/drivers/mpu401/snd-mpu401-uart.o: 
insmod snd-au8830 failed
done








-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
