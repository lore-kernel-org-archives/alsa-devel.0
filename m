From: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: Re: hdsp I/O-error
Date: Mon, 14 Apr 2003 12:20:22 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304141220.22099.Jaakko.Prattala@Helsinki.FI>
References: <200304112048.38744.Jaakko.Prattala@Helsinki.FI> <200304121240.17736.Jaakko.Prattala@Helsinki.FI> <1050176702.1427.681.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_YXTB8UBM1TYFH3V5H0BB"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1050176702.1427.681.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--------------Boundary-00=_YXTB8UBM1TYFH3V5H0BB
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi. Here's an strace of hdsploader. Anything there?
You asked about alsactl. After running hdsploader
alsactl store causes a segfault and
alsactl restore just hangs.

--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI

--------------Boundary-00=_YXTB8UBM1TYFH3V5H0BB
Content-Type: text/plain;
  charset="iso-8859-15";
  name="hdsploader.strace"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="hdsploader.strace"

execve("/usr/local/bin/hdsploader", ["hdsploader"], [/* 23 vars */]) = 0
uname({sys="Linux", node="kiertotahti", ...}) = 0
brk(0)                                  = 0x80a876c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=81506, ...}) = 0
old_mmap(NULL, 81506, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40013000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\263"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=3097033, ...}) = 0
old_mmap(NULL, 548564, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40027000
mprotect(0x400a9000, 16084, PROT_NONE)  = 0
old_mmap(0x400a9000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x81000) = 0x400a9000
close(3)                                = 0
open("/lib/i686/libm.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0007\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=170910, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400ad000
old_mmap(NULL, 135680, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400ae000
mprotect(0x400cf000, 512, PROT_NONE)    = 0
old_mmap(0x400cf000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x21000) = 0x400cf000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\30"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=11314, ...}) = 0
old_mmap(NULL, 11304, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400d0000
mprotect(0x400d2000, 3112, PROT_NONE)   = 0
old_mmap(0x400d2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1000) = 0x400d2000
close(3)                                = 0
open("/lib/i686/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240E\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=85498, ...}) = 0
old_mmap(NULL, 196128, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400d3000
mprotect(0x400e0000, 142880, PROT_NONE) = 0
old_mmap(0x400e0000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd000) = 0x400e0000
old_mmap(0x400e3000, 130592, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x400e3000
close(3)                                = 0
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220Y\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1395734, ...}) = 0
old_mmap(0x42000000, 1239844, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x42000000
mprotect(0x42126000, 35620, PROT_NONE)  = 0
old_mmap(0x42126000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x126000) = 0x42126000
old_mmap(0x4212b000, 15140, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4212b000
close(3)                                = 0
mprotect(0x40027000, 532480, PROT_READ|PROT_WRITE) = 0
mprotect(0x40027000, 532480, PROT_READ|PROT_EXEC) = 0
munmap(0x40013000, 81506)               = 0
modify_ldt(1, {entry_number:0, base_addr:0x400e0080, limit:1056, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:0, seg_not_present:0, useable:1}, 16) = 0
getpid()                                = 631
rt_sigaction(SIGRTMIN, {0x400dad90, [], SA_RESTORER, 0x42028c48}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x400dade0, [], SA_RESTORER, 0x42028c48}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x400db930, [], SA_RESTORER, 0x42028c48}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff77c, 30, (nil), 0}) = 0
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(4, 1), ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40013000
write(1, "hdsploader - firmware loader for"..., 58) = 58
write(1, "Looking for HDSP + Multiface or "..., 49) = 49
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbffff60c)  = 0
brk(0)                                  = 0x80a876c
brk(0x80a976c)                          = 0x80a976c
brk(0x80aa000)                          = 0x80aa000
ioctl(3, 0x81785501, 0xbffff670)        = 0
close(3)                                = 0
write(1, "Card 0 : RME Hammerfall DSP at 0"..., 50) = 50
write(1, "Upload firmware for card hw:0\n", 30) = 30
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7629, ...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7629, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
brk(0x80ab000)                          = 0x80ab000
brk(0x80ac000)                          = 0x80ac000
brk(0x80ad000)                          = 0x80ad000
read(3, "m.device\n\t\t\t}\n\t\t}\n\t\tsubdevice {\n"..., 4096) = 3533
brk(0x80ae000)                          = 0x80ae000
brk(0x80af000)                          = 0x80af000
brk(0x80b0000)                          = 0x80b0000
brk(0x80b1000)                          = 0x80b1000
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or directory)
access("/root/.asoundrc", R_OK)         = 0
open("/root/.asoundrc", O_RDONLY)       = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=65, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(3, "pcm.hdsp{\n  type hw\n  card 0\n}\n\n"..., 4096) = 65
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/hwC0D0", O_RDWR)         = 3
ioctl(3, 0x80044800, 0xbffe76cc)        = 0
ioctl(3, 0x80084843, 0xbffe7a40)        = 0
ioctl(3, 0x7d744842, 0xbffe7a70)        = -1 EIO (Input/output error)
write(2, "Hwdep ioctl error on card hw:0 :"..., 53Hwdep ioctl error on card hw:0 : Input/output error.
) = 53
close(3)                                = 0
open("/dev/snd/controlC1", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC1", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC1", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC1", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC2", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC2", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC2", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC2", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC3", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC3", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC3", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC3", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC4", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC4", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC5", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC5", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC6", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC6", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC7", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC7", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC8", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC8", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC9", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC9", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC10", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC10", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC11", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC11", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC12", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC12", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC13", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC13", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC14", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC14", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC15", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC15", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC16", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC16", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC17", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC17", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC18", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC18", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC19", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC19", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC20", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC20", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC21", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC21", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC22", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC22", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC23", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC23", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC24", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC24", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC25", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC25", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC26", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC26", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC27", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC27", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC28", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC28", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC29", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC29", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC30", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC30", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC31", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC31", O_RDONLY)         = -1 ENOENT (No such file or directory)
munmap(0x40013000, 4096)                = 0
_exit(0)                                = ?

--------------Boundary-00=_YXTB8UBM1TYFH3V5H0BB--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
