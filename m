From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: Re: Opening dev/dsp takes very long
Date: Tue, 16 Mar 2004 20:04:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40574FBB.70306@gmx.de>
References: <Pine.HPX.4.33n.0403160917290.14608-100000@studcom.urz.uni-halle.de> <4056BF90.2060005@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4056BF90.2060005@gmx.de>
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

Lars Heineken wrote:

| I'll figure out how the script works and make the trace when I get home.
| (~9 hours).

All set, here we go:

The script calls this line:

sox 01.wav -t ossdsp /dev/dsp

After adding an "strace -r" to the beginning I got the following output:



lars@lars-heineken CD-Recorder]$ strace -r sox 01.wav -t ossdsp /dev/dsp
~     0.000000 execve("/usr//bin/sox", ["sox", "01.wav", "-t", "ossdsp",
"/dev/dsp"], [/* 52 vars */]) = 0
~     0.000836 uname({sys="Linux", node="lars-heineken.lan", ...}) = 0
~     0.000339 brk(0)                    = 0x80a5000
~     0.000234 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
~     0.000336 open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such
file or directory)
~     0.000445 open("/etc/ld.so.cache", O_RDONLY) = 3
~     0.000288 fstat64(3, {st_mode=S_IFREG|0644, st_size=69759, ...}) = 0
~     0.000301 old_mmap(NULL, 69759, PROT_READ, MAP_PRIVATE, 3, 0) =
0x40015000
~     0.000319 close(3)                  = 0
~     0.000227 open("/lib/i686/libm.so.6", O_RDONLY) = 3
~     0.000325 read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0005\0"..., 512) = 512
~     0.000367 fstat64(3, {st_mode=S_IFREG|0755, st_size=139748, ...}) = 0
~     0.000264 old_mmap(NULL, 142224, PROT_READ|PROT_EXEC, MAP_PRIVATE,
3, 0) = 0x40027000
~     0.000275 old_mmap(0x40049000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x21000) = 0x40049000
~     0.000352 close(3)                  = 0
~     0.000229 open("/usr/lib/libogg.so.0", O_RDONLY) = 3
~     0.000324 read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\20\0"..., 512) = 512
~     0.000301 fstat64(3, {st_mode=S_IFREG|0755, st_size=14856, ...}) = 0
~     0.000278 old_mmap(NULL, 13820, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3,
0) = 0x4004a000
~     0.000271 old_mmap(0x4004d000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x3000) = 0x4004d000
~     0.000321 close(3)                  = 0
~     0.000236 open("/usr/lib/libvorbis.so.0", O_RDONLY) = 3
~     0.000323 read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220*\0"..., 512) = 512
~     0.000295 fstat64(3, {st_mode=S_IFREG|0755, st_size=131624, ...}) = 0
~     0.000259 old_mmap(NULL, 134692, PROT_READ|PROT_EXEC, MAP_PRIVATE,
3, 0) = 0x4004e000
~     0.000290 old_mmap(0x40068000, 28672, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x19000) = 0x40068000
~     0.000322 close(3)                  = 0
~     0.000220 open("/usr/lib/libvorbisfile.so.3", O_RDONLY) = 3
~     0.000340 read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\26"..., 512) = 512
~     0.000294 fstat64(3, {st_mode=S_IFREG|0755, st_size=23020, ...}) = 0
~     0.000260 old_mmap(NULL, 26024, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3,
0) = 0x4006f000
~     0.000269 old_mmap(0x40075000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x5000) = 0x40075000
~     0.000337 close(3)                  = 0
~     0.000218 open("/usr/lib/libvorbisenc.so.2", O_RDONLY) = 3
~     0.000313 read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\202\0"..., 512) = 512
~     0.000322 fstat64(3, {st_mode=S_IFREG|0755, st_size=935152, ...}) = 0
~     0.000256 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40076000
~     0.000306 old_mmap(NULL, 949284, PROT_READ|PROT_EXEC, MAP_PRIVATE,
3, 0) = 0x40077000
~     0.000273 old_mmap(0x40082000, 892928, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0xb000) = 0x40082000
~     0.000670 old_mmap(0x4015c000, 11300, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4015c000
~     0.000312 close(3)                  = 0
~     0.000268 open("/usr/lib/libmad.so.0", O_RDONLY) = 3
~     0.000346 read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\24"..., 512) = 512
~     0.000370 fstat64(3, {st_mode=S_IFREG|0755, st_size=88120, ...}) = 0
~     0.000285 old_mmap(NULL, 91180, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3,
0) = 0x4015f000
~     0.000275 old_mmap(0x40175000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x15000) = 0x40175000
~     0.000329 close(3)                  = 0
~     0.000249 open("/lib/i686/libc.so.6", O_RDONLY) = 3
~     0.000300 read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20]\1\000"..., 512) = 512
~     0.000289 fstat64(3, {st_mode=S_IFREG|0755, st_size=1237568, ...}) = 0
~     0.000260 old_mmap(NULL, 1242756, PROT_READ|PROT_EXEC, MAP_PRIVATE,
3, 0) = 0x40176000
~     0.000287 old_mmap(0x402a0000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED, 3, 0x12a000) = 0x402a0000
~     0.000340 old_mmap(0x402a3000, 9860, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x402a3000
~     0.000308 close(3)                  = 0
~     0.001777 munmap(0x40015000, 69759) = 0
~     0.001005 brk(0)                    = 0x80a5000
~     0.000365 brk(0x80c6000)            = 0x80c6000
~     0.000290 brk(0)                    = 0x80c6000
~     0.000384 open("01.wav", O_RDONLY)  = 3
~     0.000466 fstat64(3, {st_mode=S_IFREG|0777, st_size=96, ...}) = 0
~     0.000382 fstat64(3, {st_mode=S_IFREG|0777, st_size=96, ...}) = 0
~     0.000321 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
~     0.000356 read(3, "RIFFX\0\0\0WAVEfmt
\20\0\0\0\1\0\2\0D\254\0\0\20\261\2"..., 4096) = 96
~     0.000395 _llseek(3, 0, [0], SEEK_SET) = 0
~     0.000287 read(3, "RIFFX\0\0\0WAVEfmt
\20\0\0\0\1\0\2\0D\254\0\0\20\261\2"..., 4096) = 96
~     0.000406 _llseek(3, 96, [96], SEEK_SET) = 0
~     0.000302 _llseek(3, 96, [96], SEEK_SET) = 0
~     0.000272 read(3, "", 4096)         = 0
~     0.000329 _llseek(3, 0, [0], SEEK_SET) = 0
~     0.000275 read(3, "RIFFX\0\0\0WAVEfmt
\20\0\0\0\1\0\2\0D\254\0\0\20\261\2"..., 44) = 44
~     0.000339 open("/dev/dsp", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 4
~     0.000624 fstat64(4, {st_mode=S_IFCHR|0600, st_rdev=makedev(14, 3),
...}) = 0
~     0.000347 ioctl(4, SNDCTL_TMR_TIMEBASE, 0xbffff4b0) = -1 EINVAL
(Invalid argument)
~     0.000363 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
~     0.000325 fstat64(4, {st_mode=S_IFCHR|0600, st_rdev=makedev(14, 3),
...}) = 0
~     0.000347 ioctl(4, SNDCTL_DSP_RESET, 0) = 0
~     0.000348 ioctl(4, SNDCTL_DSP_GETFMTS, 0xbffff648) = 0
~     0.516952 ioctl(4, SNDCTL_DSP_SETFMT, 0xbffff648) = 0
~     0.002426 ioctl(4, SNDCTL_DSP_STEREO, 0xbffff648) = 0
~     0.002577 ioctl(4, SOUND_PCM_READ_RATE, 0xbffff648) = 0
~     0.135400 ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x80a5824) = 0
~     0.000339 ioctl(4, SNDCTL_DSP_SYNC, 0) = 0
~     0.000302 munmap(0x40016000, 4096)  = 0
~     0.000325 read(3,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) = 52
~     0.000365 read(3, "", 4096)         = 0
~     0.000323 close(3)                  = 0
~     0.000398 munmap(0x40015000, 4096)  = 0
~     0.000602 write(4,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 52) = 52
~     0.000422 close(4)                  = 0
~     0.148631 exit_group(0)             = ?


It seems SNDCTL_DSP_SETFMT is to blame, but SNDCTL_DSP_GETBLKSIZE takes
rather long, too.
Does anyone have a clue what might have caused these delays to appear in
alsa 1.00 ?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAV0+7rp9JEomxNXERAp1eAKCTMtv/Xvr4IN5apJRwP+JHOOvaSQCffueJ
1MQD3uNnsHE1jQzb/xDjfv4=
=Yb/b
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
