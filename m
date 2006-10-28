From: Corvus Corax <corvus-ml@cybertrench.com>
Subject: ld10k1 doesnt run with glibc4 on amd64 doe to detected
 (possible) double free
Date: Sat, 28 Oct 2006 03:35:29 +0200
Message-ID: <20061028033529.6e5bb899@VikingPC.home>
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


I just got this, after my gentoo system did a glibc update:

ld10k1
*** glibc detected *** ld10k1: double free or corruption (!prev):
0x0000000000531790 *** ======= Backtrace: =========
/lib/libc.so.6[0x2aaaab1857ec]
/lib/libc.so.6(__libc_free+0x76)[0x2aaaab186356]
ld10k1[0x40a35f]
ld10k1[0x406850]
ld10k1[0x402656]
/lib/libc.so.6(__libc_start_main+0xf6)[0x2aaaab139136]
ld10k1[0x401d89]
======= Memory map: ========
00400000-00410000 r-xp 00000000 03:06
1683568                            /usr/local/sbin/ld10k1 0050f000-00511000
rw-p 0000f000 03:06 1683568                            /usr/local/sbin/ld10k1
00511000-00562000 rw-p 00511000 00:00 0                                  [heap]
2aaaaaaab000-2aaaaaac6000 r-xp 00000000 03:06
265591                     /lib64/ld-2.4.so 2aaaaaac6000-2aaaaaac7000 rw-p
2aaaaaac6000 00:00 0 2aaaaaae7000-2aaaaaae8000 rw-p 2aaaaaae7000 00:00 0
2aaaaabc5000-2aaaaabc6000 r--p 0001a000 03:06
265591                     /lib64/ld-2.4.so 2aaaaabc6000-2aaaaabc7000 rw-p
0001b000 03:06 265591                     /lib64/ld-2.4.so
2aaaaabc7000-2aaaaaca1000 r-xp 00000000 03:06
1550447                    /usr/lib64/libasound.so.2.0.0
2aaaaaca1000-2aaaaada1000 ---p 000da000 03:06
1550447                    /usr/lib64/libasound.so.2.0.0
2aaaaada1000-2aaaaada9000 rw-p 000da000 03:06
1550447                    /usr/lib64/libasound.so.2.0.0
2aaaaada9000-2aaaaae00000 r-xp 00000000 03:06
266037                     /lib64/libm-2.4.so 2aaaaae00000-2aaaaaeff000 ---p
00057000 03:06 266037                     /lib64/libm-2.4.so
2aaaaaeff000-2aaaaaf01000 rw-p 00056000 03:06
266037                     /lib64/libm-2.4.so 2aaaaaf01000-2aaaaaf03000 r-xp
00000000 03:06 265062                     /lib64/libdl-2.4.so
2aaaaaf03000-2aaaab003000 ---p 00002000 03:06
265062                     /lib64/libdl-2.4.so 2aaaab003000-2aaaab005000 rw-p
00002000 03:06 265062                     /lib64/libdl-2.4.so
2aaaab005000-2aaaab006000 rw-p 2aaaab005000 00:00 0 2aaaab006000-2aaaab017000
r-xp 00000000 03:06 266370                     /lib64/libpthread-2.4.so
2aaaab017000-2aaaab116000 ---p 00011000 03:06
266370                     /lib64/libpthread-2.4.so 2aaaab116000-2aaaab117000
r--p 00010000 03:06 266370                     /lib64/libpthread-2.4.so
2aaaab117000-2aaaab118000 rw-p 00011000 03:06
266370                     /lib64/libpthread-2.4.so 2aaaab118000-2aaaab11c000
rw-p 2aaaab118000 00:00 0 2aaaab11c000-2aaaab23e000 r-xp 00000000 03:06
266003                     /lib64/libc-2.4.so 2aaaab23e000-2aaaab33d000 ---p
00122000 03:06 266003                     /lib64/libc-2.4.so
2aaaab33d000-2aaaab340000 r--p 00121000 03:06
266003                     /lib64/libc-2.4.so 2aaaab340000-2aaaab342000 rw-p
00124000 03:06 266003                     /lib64/libc-2.4.so
2aaaab342000-2aaaab349000 rw-p 2aaaab342000 00:00 0 2aaaab400000-2aaaab421000
rw-p 2aaaab400000 00:00 0 2aaaab421000-2aaaab500000 ---p 2aaaab421000 00:00 0
2aaaab500000-2aaaab50b000 r-xp 00000000 03:06
2534708                    /lib64/libgcc_s.so.1 2aaaab50b000-2aaaab60a000 ---p
0000b000 03:06 2534708                    /lib64/libgcc_s.so.1
2aaaab60a000-2aaaab60b000 rw-p 0000a000 03:06
2534708                    /lib64/libgcc_s.so.1 7fffff91e000-7fffff933000 rw-p
7fffff91e000 00:00 0                      [stack]
ffffffffff600000-ffffffffffe00000 ---p 00000000 00:00 0                  [vdso]
Abgebrochen


this is what gdb says:

Program received signal SIGABRT, Aborted.
[Switching to Thread 46912505150976 (LWP 9239)]
0x00002aaaab14b7e9 in raise () from /lib/libc.so.6
(gdb) bt
#0  0x00002aaaab14b7e9 in raise () from /lib/libc.so.6
#1  0x00002aaaab14cbce in abort () from /lib/libc.so.6
#2  0x00002aaaab18040e in __fsetlocking () from /lib/libc.so.6
#3  0x00002aaaab1857ec in malloc_usable_size () from /lib/libc.so.6
#4  0x00002aaaab186356 in free () from /lib/libc.so.6
#5  0x000000000040a35f in ld10k1_init_driver (dsp_mgr=0x5109a0, tram_size=0) at
ld10k1_driver.c:414 #6  0x0000000000406850 in main_loop (param=0x7fffffa9a2c0,
audigy=9239, card_id=0x6 <Address 0x6 out of bounds>, tram_size=0,
ctlp=0x5203b0) at ld10k1_fnc1.c:202 #7  0x0000000000402656 in main
(argc=-5659936, argv=0x7fffffa9a2f0) at ld10k1.c:333


now I guess the bug was there before but didnt raise - can anyone confirm this?




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
