From: Raymond <rayau@netvigator.com>
Subject: au8830 - front / rear channels swapped after first play and Surround40
Date: Fri, 11 Mar 2005 13:31:43 +0800
Message-ID: <42312D3F.2010201@netvigator.com>
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

When watching movie using gxine(xine-lib) downmix DVD sound to 
Surround40, the human voice (Center) come out from rear speakers instead 
of front on the second movie.

Turn off the Sigmatel STAC9708 stereo to 4 speakers and Sigmatel
Surround Mix, Sigmatel 3D Surround using alsamixer.


<confdir:pcm/front.conf>

AU8830.pcm.front.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hw
	card $CARD
	device 0
}	

<confdir:pcm/surround40.conf>

AU8830.pcm.surround40.0 "cards.AU8830.pcm.front.0"

<confdir:pcm/iec958.conf>

AU8830.pcm.iec958.0 {
	@args [ CARD AES0 AES1 AES2 AES3 ]
	@args.CARD {
		type string
	}
	@args.AES0 {
		type integer
	}
	@args.AES1 {
		type integer
	}
	@args.AES2 {
		type integer
	}
	@args.AES3 {
		type integer
	}
	type hw
	card $CARD
	device 1
}


1) Is this related to no cards.AU8830.pcm.rear in
/usr/share/alsa/cards/AU8830.conf ?

I repeat the "aplay test" with out1lq.wav, out1rq.wav, out2lq.wav
and out2rq.wav.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=59

Although there is a route left after snd_vortex_pcm_hw_free() when
playing stereo sound (e.g. outls.wav and outrs.wav )

There is no swap of left/right channels on au8830.

The swapping of front/rear also occur when using speaker-test -c 4


2) Why "snd_vortex_pcm_hw_free()" is called twice by "aplay" ?

3) Is the bug related to "vortex: IRQ fifo error" ?

4) Why some routes such as "ADBDMA(00) -> SRCIN(01)",
"ADBDMA(00) -> SRCIN(02)", "ADBDMA(00) -> SRCIN(03)" are still exist
after snd_vortex_pcm_hw_free ?

5) What is the usage of Pre 3D/Post 3D setting in 'PCM Out Path & Mute' ?

Need to understand the routes and mixin mixout setting before complete
the au88x0_ac3_passthrough_spdif.patch.

6) How to fill up the remain symbols in au8830_src[256] and
au8830_dest[256] from OFFSET_???? from au8830.h ?

#define		OFFSET_ADBDMA	0x00
#define		OFFSET_ADBDMAB	0x20
#define		OFFSET_SRCIN	0x40
#define		OFFSET_SRCOUT	0x20	/* ch 0x11 */
#define		OFFSET_MIXIN	0x50	/* ch 0x11 */
#define		OFFSET_MIXOUT	0x30	/* ch 0x11 */
#define		OFFSET_CODECIN	0x70 /* ch 0x11 */	/* adb source */
#define		OFFSET_CODECOUT	0x88 /* ch 0x11 */	/* adb target */
#define		OFFSET_SPORTIN	0x78	/* ch 0x13 ADB source. 2 routes. */
#define		OFFSET_SPORTOUT	0x90	/* ch 0x13 ADB sink. 2 routes. */
#define		OFFSET_SPDIFIN	0x7A	/* ch 0x14 ADB source. */
#define		OFFSET_SPDIFOUT	0x92	/* ch 0x14 ADB sink. */
#define		OFFSET_AC98IN	0x7c	/* ch 0x14 ADB source. */
#define		OFFSET_AC98OUT	0x94	/* ch 0x14 ADB sink. */
#define		OFFSET_EQIN		0xa0	/* ch 0x11 */
#define		OFFSET_EQOUT	0x7e /* ch 0x11 */	/* 2 routes on ch 0x11 */
#define		OFFSET_A3DIN	0x70	/* ADB sink. */
#define		OFFSET_A3DOUT	0xA6	/* ADB source. 2 routes per slice = 8 */
#define		OFFSET_WT0		0x40	/* WT bank 0 output. 0x40 - 0x65 */
#define		OFFSET_WT1		0x80	/* WT bank 1 output. 0x80 - 0xA5 */
/* WT sources offset : 0x00-0x1f Direct stream. */
/* WT sources offset : 0x20-0x25 Mixed Output. */
#define		OFFSET_XTALKOUT	0x66	/* crosstalk canceller (source) 2 routes */
#define		OFFSET_XTALKIN	0x96	/* crosstalk canceller (sink). 10 routes */
#define		OFFSET_EFXOUT	0x68	/* ADB source. 8 routes. */
#define		OFFSET_EFXIN	0x80	/* ADB sink. 8 routes. */

7) Can anyone explain how the adddress of audio data pass to DMA
registers in the current alsa driver code ?

I try to log the hwread() and hwwrite(), but dmesg cannot show all entries.

8) How to to obtain a full log ?


Please note that I have disabled some default routes in
vortex_connect_default()

//	vortex_wt_connect(vortex, en);
//	vortex_Vort3D_connect(vortex, en);


This following is the result of "aplay out1lq.wav".

# /etc/init.d/alsasound stop
# /etc/init.d/alsasound start
# dmesg

Vortex: init.... <6>done.
input0: Analog 4-axis 4-button joystick at gameport0.0 [ADC port]
Routes After vortex_connect_default()-----------
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
----------------------------------------

# strace aplay out1lq.wav execve("/usr/bin/aplay", ["aplay",
"out1lq.wav"], [/* 35 vars */]) = 0
uname({sys="Linux", node="localhost.localdomain", ...}) = 0
brk(0)                                  = 0x829a000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=82204, ...}) = 0
old_mmap(NULL, 82204, PROT_READ, MAP_PRIVATE, 3, 0) = 0xbf5ab000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20;\207"...,
512) = 512fstat64(3, {st_mode=S_IFREG|0755, st_size=3637838, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xbf5aa000
old_mmap(0x855000, 655200, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x855000
old_mmap(0x8f1000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x9c000) = 0x8f1000
close(3)                                = 0
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
-1, 0) = 0xbf5a9000
set_thread_area({entry_number:-1 -> 6, base_addr:0xbf5a9640,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xbf5ab000, 82204)               = 0
set_tid_address(0xbf5a9688)             = 20300
rt_sigaction(SIGRTMIN, {0x97f680, [], SA_RESTORER|SA_SIGINFO, 0x9860b0},
NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=10240*1024, rlim_max=RLIM_INFINITY}) = 0
brk(0)                                  = 0x829a000
brk(0x82bb000)                          = 0x82bb000
brk(0)                                  = 0x82bb000
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7467,
...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7467, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf5bf000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
read(3, "if cards.pcm.iec958\npcm.modem ca"..., 4096) = 3371
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xbf5bf000, 4096)                = 0
futex(0x852f70, FUTEX_WAKE, 2147483647) = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or
directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or
directory)
open("/usr/share/alsa/cards/aliases.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1110, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf5bf000
read(3, "#\n#  Define aliases for various "..., 4096) = 1110
open("/usr/share/alsa/pcm/default.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=479, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf5be000
read(4, "#\n# Default output\n#\n\npcm.!defau"..., 4096) = 479
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xbf5be000, 4096)                = 0
open("/usr/share/alsa/pcm/dmix.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1060, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf5be000
read(4, "#\n# dmix output\n#\n\npcm.!dmix {\n\t"..., 4096) = 1060
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xbf5be000, 4096)                = 0
open("/usr/share/alsa/pcm/dsnoop.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1065, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf5be000
read(4, "#\n# dsnoop\n#\n\npcm.!dsnoop {\n\t@ar"..., 4096) = 1065
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xbf5be000, 4096)                = 0
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xbf5bf000, 4096)                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7467,
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbff7f4dc)  = 0
ioctl(3, UI_DEV_CREATE, 0xbff7f600)     = 0
close(3)                                = 0
access("/usr/share/alsa/cards/AU8830.conf", R_OK) = 0
open("/usr/share/alsa/cards/AU8830.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=530, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf5bf000
read(3, "#\n# Configuration for the AU8830"..., 4096) = 530
open("/usr/share/alsa/pcm/front.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=596, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf5be000
read(4, "#\n# Hardware output from front s"..., 4096) = 596
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xbf5be000, 4096)                = 0
open("/usr/share/alsa/pcm/surround40.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=749, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf5be000
read(4, "#\n#  Hardware output from 4.0 sp"..., 4096) = 749
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xbf5be000, 4096)                = 0
open("/usr/share/alsa/pcm/iec958.conf", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1030, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xbf5be000
read(4, "#\n#  Hardware output from iec958"..., 4096) = 1030
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xbf5be000, 4096)                = 0
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xbf5bf000, 4096)                = 0
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
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7467,
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbff7f23c)  = 0
ioctl(3, UI_DEV_CREATE, 0xbff7f360)     = 0
close(3)                                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbff7f4ec)  = 0
ioctl(3, 0x40045532, 0xbff7f514)        = 0
open("/dev/snd/pcmC0D0p", O_RDWR)       = 4
close(3)                                = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbff7f3e0) = 0
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
ioctl(4, AGPIOC_INFO, 0xbff7f3dc)       = 0
ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbff7f3d8) = 0
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000) = 0xbf5bf000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0x81000) = 0xbf5be000
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbff7f990) = 0
rt_sigaction(SIGINT, {0x804abf8, [INT], SA_RESTORER|SA_RESTART,
0x718a58}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x804abf8, [TERM], SA_RESTORER|SA_RESTART,
0x718a58}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGABRT, {0x804abf8, [ABRT], SA_RESTORER|SA_RESTART,
0x718a58}, {SIG_DFL}, 8) = 0
open("out1lq.wav", O_RDONLY|O_LARGEFILE) = 3
read(3, "RIFF6\261\2\0WAVEfmt \22\0\0\0\1\0\4\0", 24) = 24
read(3, "\"V", 2)                       = 2
read(3, "\0\0\20\261\2\0\10\0\20\0\0\0", 12) = 12
read(3, "data\20\261\2\0", 8)           = 8
write(2, "Playing WAVE \'out1lq.wav\' : ", 28Playing WAVE 'out1lq.wav' :
) = 28
write(2, "Signed 16 bit Little Endian, ", 29Signed 16 bit Little Endian,
) = 29
write(2, "Rate 22050 Hz, ", 15Rate 22050 Hz, )         = 15
write(2, "Channels 4", 10Channels 4)              = 10
write(2, "\n", 1
)                       = 1
ioctl(4, 0xc25c4110, 0xbff7f300)        = 0
ioctl(4, 0xc25c4110, 0xbff7ef30)        = 0
ioctl(4, 0xc25c4110, 0xbff7ef30)        = 0
ioctl(4, 0xc25c4110, 0xbff7ea50)        = 0
ioctl(4, 0xc25c4110, 0xbff7ef60)        = 0
ioctl(4, 0xc25c4110, 0xbff7ef60)        = 0
ioctl(4, 0xc25c4110, 0xbff7f300)        = 0
ioctl(4, 0xc25c4110, 0xbff7ef30)        = 0
ioctl(4, 0xc25c4110, 0xbff7ef30)        = 0
ioctl(4, 0xc25c4110, 0xbff7ef60)        = 0
ioctl(4, 0xc25c4110, 0xbff7ef60)        = 0
ioctl(4, 0xc25c4110, 0xbff7f300)        = 0
ioctl(4, 0xc25c4110, 0xbff7f060)        = 0
ioctl(4, 0xc25c4110, 0xbff7ec90)        = 0
ioctl(4, 0xc25c4110, 0xbff7ec90)        = 0
ioctl(4, 0xc25c4110, 0xbff7ecc0)        = 0
ioctl(4, 0xc25c4110, 0xbff7ecc0)        = 0
ioctl(4, 0xc25c4110, 0xbff7f060)        = 0
ioctl(4, 0xc25c4110, 0xbff7f060)        = 0
ioctl(4, 0xc25c4110, 0xbff7ec90)        = 0
ioctl(4, 0xc25c4110, 0xbff7ec90)        = 0
ioctl(4, 0xc25c4110, 0xbff7ecc0)        = 0
ioctl(4, 0xc25c4110, 0xbff7ecc0)        = 0
ioctl(4, 0xc25c4110, 0xbff7f060)        = 0
ioctl(4, 0xc25c4110, 0xbff7f060)        = 0
ioctl(4, 0xc25c4110, 0xbff7ec90)        = 0
ioctl(4, 0xc25c4110, 0xbff7ec90)        = 0
ioctl(4, 0xc25c4110, 0xbff7ecc0)        = 0
ioctl(4, 0xc25c4110, 0xbff7ecc0)        = 0
ioctl(4, 0xc25c4110, 0xbff7f060)        = 0
ioctl(4, 0xc25c4110, 0xbff7f060)        = 0
ioctl(4, 0xc25c4110, 0xbff7ec90)        = 0
ioctl(4, 0xc25c4110, 0xbff7ec90)        = 0
ioctl(4, 0xc25c4110, 0xbff7f060)        = 0
ioctl(4, 0xc25c4110, 0xbff7f060)        = 0
ioctl(4, 0xc25c4110, 0xbff7f060)        = 0
ioctl(4, 0xc25c4110, 0xbff7ec90)        = 0
ioctl(4, 0xc25c4110, 0xbff7ec90)        = 0
ioctl(4, 0xc25c4110, 0xbff7f060)        = 0
ioctl(4, 0xc25c4110, 0xbff7eb40)        = 0
ioctl(4, 0xc25c4110, 0xbff7e770)        = 0
ioctl(4, 0xc25c4110, 0xbff7e770)        = 0
ioctl(4, 0xc25c4110, 0xbff7e770)        = 0
ioctl(4, 0xc25c4110, 0xbff7eb40)        = 0
ioctl(4, 0xc25c4110, 0xbff7eb40)        = 0
ioctl(4, 0xc25c4110, 0xbff7eb40)        = 0
ioctl(4, 0xc25c4110, 0xbff7eb40)        = 0
ioctl(4, 0xc25c4110, 0xbff7e770)        = 0
ioctl(4, 0xc25c4110, 0xbff7e770)        = 0
ioctl(4, 0xc25c4110, 0xbff7eb40)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7eda0)        = 0
ioctl(4, 0xc25c4110, 0xbff7f260)        = 0
ioctl(4, 0xc25c4110, 0xbff7f260)        = 0
ioctl(4, 0xc25c4110, 0xbff7f260)        = 0
ioctl(4, 0xc25c4110, 0xbff7f260)        = 0
ioctl(4, 0xc25c4110, 0xbff7f260)        = 0
ioctl(4, 0xc25c4110, 0xbff7f290)        = 0
ioctl(4, 0xc25c4110, 0xbff7f290)        = 0
ioctl(4, 0xc25c4110, 0xbff7f290)        = 0
ioctl(4, 0xc25c4110, 0xbff7f290)        = 0
ioctl(4, 0xc25c4110, 0xbff7f670)        = 0
ioctl(4, 0xc25c4111, 0xbff7f670)        = 0
ioctl(4, 0xc0684113, 0xbff7f1e0)        = 0
ioctl(4, 0x4140, 0)                     = 0
ioctl(4, 0xc0684113, 0xbff7f600)        = 0
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\277\374\0\0\0\0\0\0\237\374\0\0\0\0\0\0\204\374\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\272\4\0\0\0\0\0\0&\5\0\0\0\0\0\0\223\5\0\0\0\0\0\0\372"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\245\360\0\0\0\0\0\0\236\360\0\0\0\0\0\0\230\360\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "4\24\0\0\0\0\0\0@\24\0\0\0\0\0\0003\24\0\0\0\0\0\0\25\24"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "`\347\0\0\0\0\0\0a\347\0\0\0\0\0\0Z\347\0\0\0\0\0\0[\347"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\247\375\0\0\0\0\0\0\247\373\0\0\0\0\0\0\255\371\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "q\345\0\0\0\0\0\0\263\345\0\0\0\0\0\0\365\345\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "@\351\0\0\0\0\0\0\200\353\0\0\0\0\0\0\353\355\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "l\341\0\0\0\0\0\0\230\337\0\0\0\0\0\0\3\336\0\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\314\352\0\0\0\0\0\0\233\351\0\0\0\0\0\0r\350\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "m\367\0\0\0\0\0\0\330\373\0\0\0\0\0\0M\0\0\0\0\0\0\0\305"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\206\325\0\0\0\0\0\0\32\325\0\0\0\0\0\0\311\324\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "4\34\0\0\0\0\0\0I\30\0\0\0\0\0\0\5\24\0\0\0\0\0\0{\17\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\225\360\0\0\0\0\0\0\23\363\0\0\0\0\0\0\234\365\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, ".\347\0\0\0\0\0\0\361\353\0\0\0\0\0\0\f\361\0\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "D*\0\0\0\0\0\0\305)\0\0\0\0\0\0\10)\0\0\0\0\0\0\23(\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\20$\0\0\0\0\0\0\311%\0\0\0\0\0\0>\'\0\0\0\0\0\0n(\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\34\f\0\0\0\0\0\0\334\5\0\0\0\0\0\0|\377\0\0\0\0\0\0\35"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\27\21\0\0\0\0\0\0]\r\0\0\0\0\0\0\205\t\0\0\0\0\0\0\225"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\373\3\0\0\0\0\0\0\263\n\0\0\0\0\0\0 \21\0\0\0\0\0\0\24"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\247\331\0\0\0\0\0\0e\333\0\0\0\0\0\0\222\335\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\373\333\0\0\0\0\0\0p\331\0\0\0\0\0\0%\330\0\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "}&\0\0\0\0\0\0\\%\0\0\0\0\0\0\247#\0\0\0\0\0\0j!\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\226\r\0\0\0\0\0\0\214\6\0\0\0\0\0\0D\377\0\0\0\0\0\0\2"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\312\334\0\0\0\0\0\0;\333\0\0\0\0\0\0\"\333\0\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "N\355\0\0\0\0\0\0\324\361\0\0\0\0\0\0\244\366\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\344\22\0\0\0\0\0\0f\f\0\0\0\0\0\0Z\5\0\0\0\0\0\0\21\376"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\335\r\0\0\0\0\0\0\26\t\0\0\0\0\0\0\27\4\0\0\0\0\0\0\1"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "/\36\0\0\0\0\0\0\337\36\0\0\0\0\0\0\0\36\0\0\0\0\0\0\234"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\330\10\0\0\0\0\0\0\\\r\0\0\0\0\0\0\200\21\0\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "/\23\0\0\0\0\0\0#\27\0\0\0\0\0\0\307\31\0\0\0\0\0\0\366"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "%\347\0\0\0\0\0\0\36\350\0\0\0\0\0\0\341\351\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "[\21\0\0\0\0\0\0\222\24\0\0\0\0\0\0{\26\0\0\0\0\0\0\370"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "-\370\0\0\0\0\0\0z\363\0\0\0\0\0\0\234\357\0\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\366\356\0\0\0\0\0\0\327\360\0\0\0\0\0\0V\363\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "s\376\0\0\0\0\0\0\37\372\0\0\0\0\0\0009\366\0\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\34\371\0\0\0\0\0\0\241\366\0\0\0\0\0\0\226\364\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\363\372\0\0\0\0\0\0$\370\0\0\0\0\0\0\370\365\0\0\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, " \3\0\0\0\0\0\0\376\0\0\0\0\0\0\0\322\376\0\0\0\0\0\0\263"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\337\370\0\0\0\0\0\0\340\370\0\0\0\0\0\0\204\371\0\0\0"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\205\2\0\0\0\0\0\0q\1\0\0\0\0\0\0G\0\0\0\0\0\0\0\34\377"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "o\377\0\0\0\0\0\0\f\0\0\0\0\0\0\0\254\0\0\0\0\0\0\0?\1"...,
4096) = 4096
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
read(3, "\357\377\0\0\0\0\0\0\346\377\0\0\0\0\0\0\337\377\0\0\0"...,
272) = 272
ioctl(4, 0x400c4150, 0xbff7f890)        = 0
ioctl(4, 0x4144, 0x110)                 = 0
close(3)                                = 0
ioctl(4, 0x4143, 0x110)                 = 0
ioctl(4, 0x4112, 0x200)                 = 0
close(4)                                = 0
munmap(0xbf5bf000, 4096)                = 0
munmap(0xbf5be000, 4096)                = 0
exit_group(0)                           = ?



#dmesg

Routes snd_vortex_pcm_hw_params()-----------
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
----------------------------------------
Routes After adb_allocroute() in snd_vortex_pcm_hw_params-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028104 : 00000042   ADBDMA(00) -> SRCIN(02)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028144 : 00002052   SRCOUT(00) -> MIXIN(02)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
0002814c : 00002254   SRCOUT(02) -> MIXIN(04)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282c0 : 00000040   ADBDMA(00) -> SRCIN(00)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
21a00 : 00000004   mixin(02) -> mixout(00)
21a20 : 00000008   mixin(03) -> mixout(01)
21a44 : 00000001   mixin(04) -> mixout(02)
21a64 : 00000002   mixin(05) -> mixout(03)
21a80 : 00000004   mixin(02) -> mixout(04)
21a84 : 00000001   mixin(04) -> mixout(04)
21aa0 : 00000008   mixin(03) -> mixout(05)
21aa4 : 00000002   mixin(05) -> mixout(05)
----------------------------------------
vortex: IRQ fifo error
Routes Before delete routes in snd_vortex_pcm_hw_free()-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028104 : 00000042   ADBDMA(00) -> SRCIN(02)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028144 : 00002052   SRCOUT(00) -> MIXIN(02)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
0002814c : 00002254   SRCOUT(02) -> MIXIN(04)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282c0 : 00000040   ADBDMA(00) -> SRCIN(00)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
21a00 : 00000004   mixin(02) -> mixout(00)
21a20 : 00000008   mixin(03) -> mixout(01)
21a44 : 00000001   mixin(04) -> mixout(02)
21a64 : 00000002   mixin(05) -> mixout(03)
21a80 : 00000004   mixin(02) -> mixout(04)
21a84 : 00000001   mixin(04) -> mixout(04)
21aa0 : 00000008   mixin(03) -> mixout(05)
21aa4 : 00000002   mixin(05) -> mixout(05)
----------------------------------------
Routes After delete routes in snd_vortex_pcm_hw_free()-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028104 : 00000042   ADBDMA(00) -> SRCIN(02)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
0002814c : 00002254   SRCOUT(02) -> MIXIN(04)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
----------------------------------------
Routes Before delete routes in snd_vortex_pcm_hw_free()-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028104 : 00000042   ADBDMA(00) -> SRCIN(02)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
0002814c : 00002254   SRCOUT(02) -> MIXIN(04)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
----------------------------------------
Routes After delete routes in snd_vortex_pcm_hw_free()-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028104 : 00000042   ADBDMA(00) -> SRCIN(02)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
0002814c : 00002254   SRCOUT(02) -> MIXIN(04)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
----------------------------------------

# aplay out1lq.wav
Playing WAVE 'out1lq.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Channels 4

The sound come out from rear speaker instead of front on second run.

# dmesg

Routes snd_vortex_pcm_hw_params()-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
----------------------------------------
Routes After adb_allocroute() in snd_vortex_pcm_hw_params-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028104 : 00000042   ADBDMA(00) -> SRCIN(02)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028144 : 00002052   SRCOUT(00) -> MIXIN(02)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
0002814c : 00002254   SRCOUT(02) -> MIXIN(04)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282c0 : 00000040   ADBDMA(00) -> SRCIN(00)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
21a00 : 00000004   mixin(02) -> mixout(00)
21a20 : 00000008   mixin(03) -> mixout(01)
21a44 : 00000001   mixin(04) -> mixout(02)
21a64 : 00000002   mixin(05) -> mixout(03)
21a80 : 00000004   mixin(02) -> mixout(04)
21a84 : 00000001   mixin(04) -> mixout(04)
21aa0 : 00000008   mixin(03) -> mixout(05)
21aa4 : 00000002   mixin(05) -> mixout(05)
----------------------------------------
Routes Before delete routes in snd_vortex_pcm_hw_free()-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028104 : 00000042   ADBDMA(00) -> SRCIN(02)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028144 : 00002052   SRCOUT(00) -> MIXIN(02)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
0002814c : 00002254   SRCOUT(02) -> MIXIN(04)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282c0 : 00000040   ADBDMA(00) -> SRCIN(00)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
21a00 : 00000004   mixin(02) -> mixout(00)
21a20 : 00000008   mixin(03) -> mixout(01)
21a44 : 00000001   mixin(04) -> mixout(02)
21a64 : 00000002   mixin(05) -> mixout(03)
21a80 : 00000004   mixin(02) -> mixout(04)
21a84 : 00000001   mixin(04) -> mixout(04)
21aa0 : 00000008   mixin(03) -> mixout(05)
21aa4 : 00000002   mixin(05) -> mixout(05)
----------------------------------------
Routes After delete routes in snd_vortex_pcm_hw_free()-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028104 : 00000042   ADBDMA(00) -> SRCIN(02)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
0002814c : 00002254   SRCOUT(02) -> MIXIN(04)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
----------------------------------------
Routes Before delete routes in snd_vortex_pcm_hw_free()-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028104 : 00000042   ADBDMA(00) -> SRCIN(02)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
0002814c : 00002254   SRCOUT(02) -> MIXIN(04)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
----------------------------------------
Routes After delete routes in snd_vortex_pcm_hw_free()-----------
00028100 : 00000041   ADBDMA(00) -> SRCIN(01)
00028104 : 00000042   ADBDMA(00) -> SRCIN(02)
00028108 : 00000043   ADBDMA(00) -> SRCIN(03)
00028140 : 00007151   CODECIN(1) -> MIXIN(01)
00028148 : 00002153   SRCOUT(01) -> MIXIN(03)
0002814c : 00002254   SRCOUT(02) -> MIXIN(04)
00028150 : 00002355   SRCOUT(03) -> MIXIN(05)
00028220 : 00007f89   EQOUT(1) -> CODECOUT(1)
00028224 : 0000328c   MIXOUT(02) -> CODECOUT(4)
00028230 : 0000338d   MIXOUT(03) -> CODECOUT(5)
00028234 : 00007050   CODECIN(0) -> MIXIN(00)
00028248 : 00003593   MIXOUT(05) -> SPDIFOUT(1)
00028280 : 000031a1   MIXOUT(01) -> EQIN(1)
00028284 : 00007e88   EQOUT(0) -> CODECOUT(0)
000282f8 : 000030a0   MIXOUT(00) -> EQIN(0)
00028304 : 00003492   MIXOUT(04) -> SPDIFOUT(0)
----------------------------------------
MIXIN_MIXOUT ENABLE
----------------------------------------



/*
	code for dumping the routes and mixin mixout setting.
	you need to modify the code if you are using au8820
*/


char *au8830_src[256]={
"ADBDMA(00)","ADBDMA(01)","ADBDMA(02)","ADBDMA(03)","ADBDMA(04)","ADBDMA(05)","ADBDMA(06)","ADBDMA(07)","ADBDMA(08)","ADBDMA(09)","ADBDMA(10)","ADBDMA(11)","ADBDMA(12)","ADBDMA(13)","ADBDMA(14)","ADBDM(15)",
"0x10","0x11","0x12","0x13","0x14","0x15","0x16","0x17","0x18","0x19","0x1a","0x1b","0x1c","0x1d","0x1e","0x1f",
"SRCOUT(00)","SRCOUT(01)","SRCOUT(02)","SRCOUT(03)","SRCOUT(04)","SRCOUT(05)","SRCOUT(06)","SRCOUT(07)","SRCOUT(08)","SRCOUT(09)","SRCOUT(10)","SRCOUT(11)","SRCOUT(12)","SRCOUT(13)","SRCOUT(14)","SRCOUT(15)",
"MIXOUT(00)","MIXOUT(01)","MIXOUT(02)","MIXOUT(03)","MIXOUT(04)","MIXOUT(05)","MIXOUT(06)","MIXOUT(07)","MIXOUT(08)","MIXOUT(09)","MIXOUT(10)","MIXOUT(11)","MIXOUT(12)","MIXOUT(13)","MIXOUT(14)","MIXOUT(15)",
"WT0(01)","WT0(01)","WT0(02)","WT0(03)","WT0(04)","WT0(05)","WT0(06)","WT0(07)",
"WT0(08)","WT0(09)","WT0(10)","WT0(11)","WT0(12)","WT0(13)","WT0(14)","WT0(15)",
"WT0(16)","WT0(17)","WT0(18)","WT0(19)","WT0(20)","WT0(21)","WT0(22)","WT0(23)",
"WT0(24)","WT0(25)","WT0(26)","WT0(27)","WT0(28)","WT0(29)","WT0(30)","WT0(31)",
"WT0MIX(0)","WT0MIX(1)","WT0MIX(2)","WT0MIX(3)","WT0MIX(4)","WT0MIX(5)","XTALKOUT(0)","XTALKOUT(1)","0x68","0x69","0x6a","0x6b","0x6c","0x6d","0x6e","0x6f",
"CODECIN(0)","CODECIN(1)","0x72","0x73","0x74","0x75","0x76","0x77","SPDIFIN(0)","SPDIFIN(1)","SPORTIN(0)","SPDIFIN(1)","0x7c","0x7d","EQOUT(0)","EQOUT(1)",
"WT1(00)","WT1(01)","WT1(02)","WT1(03)","WT1(04)","WT1(05)","WT1(06)","WT1(07)","WT1(08)","WT1(09)","WT1(10)","WT1(11)","WT1(12)","WT1(13)","WT1(14)","WT1(15)",
"WT1(16)","WT1(17)","WT1(18)","WT1(19)","WT1(20)","WT1(21)","WT1(22)","WT1(23)","WT1(24)","WT1(25)","WT1(26)","WT1(27)","WT1(28)","WT1(29)","WT1(30)","WT1(31)",
"WT1MIX(0)","WT1MIX(1)","WT1MIX(2)","WT1MIX(3)","WT1MIX(4)","WT1MIX(5)","A3DOUT(0)","A3DOUT(1)", 

"A3DOUT(2)","A3DOUT(3)","A3DOUT(4)","A3DOUT(5)","A3DOUT(6)","A3DOUT(7)","0xae","0xaf",
"0xb0","0xb1","0xb2","0xb3","0xb4","0xb5","0xb6","0xb7","0xb8","0xb9","0xba","0xbb","0xbc","0xbd","0xbe","0xbf",
"0xc0","0xc1","0xc2","0xc3","0xc4","0xc5","0xc6","0xc7","0xc8","0xc9","0xca","0xcb","0xcc","0xcd","0xce","0xcf",
"0xd0","0xd1","0xd2","0xd3","0xd4","0xd5","0xd6","0xd7","0xd8","0xd9","0xda","0xdb","0xdc","0xdd","0xde","0xdf",
"0xe0","0xe1","0xe2","0xe3","0xe4","0xe5","0xe6","0xe7","0xe8","0xe9","0xea","0xeb","0xec","0xed","0xee","0xef",
"0xf0","0xf1","0xf2","0xf3","0xf4","0xf5","0xf6","0xf7","0xf8","0xf9","0xfa","0xfb","0xfc","0xfd","0xfe","0xff"};


char *au8830_dest[256]={
"0x00","0x01","0x02","0x03","0x04","0x05","0x06","0x07","0x08","0x09","0x0a","0x0b","0x0c","0x0d","0x0e","0x0f",
"0x10","0x11","0x12","0x13","0x14","0x15","0x16","0x17","0x18","0x19","0x1a","0x1b","0x1c","0x1d","0x1e","0x1f",
"0x20","0x21","0x22","0x23","0x24","0x25","0x26","0x27","0x28","0x29","0x2a","0x2b","0x2c","0x2d","0x2e","0x2f",
"0x30","0x31","0x32","0x33","0x34","0x35","0x36","0x37","0x38","0x39","0x3a","0x3b","0x3c","0x3d","0x3e","0x3f",
"SRCIN(00)","SRCIN(01)","SRCIN(02)","SRCIN(03)","SRCIN(04)","SRCIN(05)","SRCIN(06)","SRCIN(07)",
"SRCIN(08)","SRCIN(09)","SRCIN(10)","SRCIN(11)","SRCIN(12)","SRCIN(13)","SRCIN(14)","SRCIN(15)",
"MIXIN(00)","MIXIN(01)","MIXIN(02)","MIXIN(03)","MIXIN(04)","MIXIN(05)","MIXIN(06)","MIXIN(07)",
"MIXIN(08)","MIXIN(09)","MIXIN(10)","MIXIN(11)","MIXIN(12)","MIXIN(13)","MIXIN(14)","MIXIN(15)",
"0x60","0x61","0x62","0x63","0x64","0x65","XTALKOUT(0)","XTALKOUT(1)",
"0x68","0x69","0x6a","0x6b","0x6c","0x6d","0x6e","0x6f",
"0x70","0x71","0x72","0x73","0x74","0x75","0x76","0x77","0x78","0x79","0x7a","0x7b","0x7c","0x7d","0x7e","0x7f",
"0x80","0x81","0x82","0x83","0x84","0x85","0x86","0x87",
"CODECOUT(0)","CODECOUT(1)","0x8a","0x8b","CODECOUT(4)","CODECOUT(5)","0x8e","0x8f",
"SPORTOUT(0)","SPORTOUT(1)","SPDIFOUT(0)","SPDIFOUT(1)","0x94","0x95","XTALKIN(0)","XTALKIN(1)","XTALKIN(2)","XTALKIN(3)","XTALKIN(4)","XTALKIN(5)","XTALKIN(6)","XTALKIN(7)","XTALKIN(8)","XTALKIN(9)",
"EQIN(0)","EQIN(1)","0xa2","0xa3","0xa4","0xa5","0xa6","0xa7",
"0xa8","0xa9","0xaa","0xab","0xac","0xad","0xae","0xaf",
"0xb0","0xb1","0xb2","0xb3","0xb4","0xb5","0xb6","0xb7","0xb8","0xb9","0xba","0xbb","0xbc","0xbd","0xbe","0xbf",
"0xc0","0xc1","0xc2","0xc3","0xc4","0xc5","0xc6","0xc7","0xc8","0xc9","0xca","0xcb","0xcc","0xcd","0xce","0xcf",
"0xd0","0xd1","0xd2","0xd3","0xd4","0xd5","0xd6","0xd7","0xd8","0xd9","0xda","0xdb","0xdc","0xdd","0xde","0xdf",
"0xe0","0xe1","0xe2","0xe3","0xe4","0xe5","0xe6","0xe7","0xe8","0xe9","0xea","0xeb","0xec","0xed","0xee","0xef",
"0xf0","0xf1","0xf2","0xf3","0xf4","0xf5","0xf6","0xf7","0xf8","0xf9","0xfa","0xfb","0xfc","0xfd","0xfe","0xff"};

static void vortex_dump_mixin_mixout(vortex_t * vortex)
{
     u32 addr,value;
     int i,j;
     unsigned char src,dest;
     addr=VORTEX_MIX_ENIN;
     printk(KERN_INFO "MIXIN_MIXOUT ENABLE\n");
     for (i=0; i<128; i++) {
         value=hwread(vortex->mmio,addr);
         if (value != 0) {
	    j=0;
	    while ((j<4)&&(((1<<j)& value) == 0))
	        j++;
	    if (value & (1<<j)) {
                 src=j+(((addr/4)% 8)*4);
                 dest=(addr-VORTEX_MIX_ENIN)/32;
	        printk(KERN_INFO "%.5x : %.8x   mixin(%.2d) -> mixout(%.2d)\n",
addr,value,src,dest);
             };
         };
         addr+=4;
     };
     printk(KERN_INFO "----------------------------------------\n");
}

void vortex_dump_routes(vortex_t *vortex,char * debug_msg)
{
	u32 value;
	u8 src,dest;
	int i;
         printk(KERN_INFO "Routes %s-----------\n",debug_msg);
	for (i=0; i<(VORTEX_ADB_RTBASE_COUNT+VORTEX_ADB_CHNBASE_COUNT); i++) {
		value=hwread(vortex->mmio,VORTEX_ADB_RTBASE+i*4);
		if ( value != ROUTE_MASK ) {
			src=(value >>ADB_SHIFT)& ADB_MASK;
			dest=value & ADB_MASK;
		   	printk(KERN_INFO "%.8x : %.8x   %s -> %s\n",
			VORTEX_ADB_RTBASE+i*4,value,au8830_src[src],au8830_dest[dest]);
		};
	};	
	printk(KERN_INFO "----------------------------------------\n");
	vortex_dump_mixin_mixout(vortex);
}
















-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
