From: Tim Goetze <tim@quitte.de>
Subject: caps-bug (fwd)
Date: Mon, 19 Apr 2010 14:11:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004191410310.2993@spring.q>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.162])
	by alsa0.perex.cz (Postfix) with ESMTP id EDE55246D7
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 14:11:26 +0200 (CEST)
Received: from spring.q (p5B11E11B.dip.t-dialin.net [91.17.225.27])
	by post.strato.de (fruni mo7) (RZmta 23.0) with ESMTP id 60217em3JC3Chh
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 14:11:24 +0200 (MEST)
Received: from localhost ([127.0.0.1]) by spring.q with esmtp (Exim 4.71)
	(envelope-from <tim@quitte.de>) id 1O3pou-00016J-Gr
	for alsa-devel@alsa-project.org; Mon, 19 Apr 2010 14:11:20 +0200
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
List-Id: alsa-devel@alsa-project.org

Hello alsa team,

please find attached a bug report I received a short while ago.  The 
finder isolated the problem on his own.  It turned out that the "type 
equal" pcm slave ran the stereo plugin "Eq2x2" without connecting all 
of the plugin's input and output ports.  This is in violation of 
ladspa.h, which mandates:

"""The plugin may assume that all its input and output ports
have been connected to the relevant data location (see the
`connect_port()' function below) before it is asked to run."""

-> http://www.ladspa.org/ladspa_sdk/ladspa.h.txt

Cheers, Tim

PS: not subscribed to this list.

---------- Forwarded message ----------
Subject: caps-bug
From: x@y.z
To: tim@quitte.de
Date: Tue, 13 Apr 2010 11:35:41 +0200

Dear caps team,

I'm using caps and the alsaequal alsa plugin together in my application.
There is a failure when i want to
close the pcm stream (snd_pcm_close).

I'm working on redhat enterprise 5.4.

Here is an extract of my alsa.conf:

pcm.AudigySe {
        type hw
        card 0
        device 0
}

pcm.audigy_out1eq {
    type plug
    slave.pcm {
        type equal
        slave.pcm "plug:AudigySe"
        library "/usr/local/lib/ladspa/caps.so"
        module "Eq2x2"
    }
}

I've reproduced the bug using the aplay utility here:

bash-3.2$ aplay -D pcm.audigy_out1eq abcdef.wav -d 1
Playing WAVE 'abcdef.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
*** glibc detected *** aplay: double free or corruption (!prev): 0x09776520
***
======= Backtrace: =========
/lib/libc.so.6[0xb99595]
/lib/libc.so.6(cfree+0x59)[0xb999d9]
/usr/lib/libstdc++.so.6(_ZdlPv+0x21)[0x41b581]
/usr/lib/libstdc++.so.6(_ZdaPv+0x1d)[0x41b5dd]
/usr/local/lib/ladspa/caps.so(_fini+0x164)[0xebaf04]
/lib/ld-linux.so.2[0xb24cc2]
/lib/ld-linux.so.2[0xb25467]
/lib/libdl.so.2[0xca1ce4]
/lib/ld-linux.so.2[0xb1fe26]
/lib/libdl.so.2[0xca22cc]
/lib/libdl.so.2(dlclose+0x2a)[0xca1d1a]
/usr/lib/alsa-lib/libasound_module_pcm_equal.so(LADSPAunload+0x1d)[0x3190ed]
/usr/lib/alsa-lib/libasound_module_pcm_equal.so[0x3182c7]
/lib/libasound.so.2[0x584f5c3]
/lib/libasound.so.2(snd_pcm_close+0x76)[0x580e906]
/lib/libasound.so.2[0x582a84b]
/lib/libasound.so.2(snd_pcm_close+0x76)[0x580e906]
aplay[0x805136a]
/lib/libc.so.6(__libc_start_main+0xdc)[0xb45e9c]
aplay(snd_pcm_mmap_readi+0x41)[0x804a3f1]
======= Memory map: ========
00110000-0011b000 r-xp 00000000 08:02 2068216
/lib/libgcc_s-4.1.2-20080825.so.1
0011b000-0011c000 rwxp 0000a000 08:02 2068216
/lib/libgcc_s-4.1.2-20080825.so.1
001a6000-001ad000 r-xp 00000000 08:02 2068209    /lib/librt-2.5.so
001ad000-001ae000 r-xp 00006000 08:02 2068209    /lib/librt-2.5.so
001ae000-001af000 rwxp 00007000 08:02 2068209    /lib/librt-2.5.so
00317000-0031a000 r-xp 00000000 08:02 1775899
/usr/lib/alsa-lib/libasound_module_pcm_equal.so
0031a000-0031b000 rwxp 00002000 08:02 1775899
/usr/lib/alsa-lib/libasound_module_pcm_equal.so
00368000-00448000 r-xp 00000000 08:02 1154975    /usr/lib/libstdc++.so.6.0.8
00448000-0044c000 r-xp 000df000 08:02 1154975    /usr/lib/libstdc++.so.6.0.8
0044c000-0044d000 rwxp 000e3000 08:02 1154975    /usr/lib/libstdc++.so.6.0.8
0044d000-00453000 rwxp 0044d000 00:00 0
009f9000-009fa000 r-xp 009f9000 00:00 0          [vdso]
00b12000-00b2c000 r-xp 00000000 08:02 2068205    /lib/ld-2.5.so
00b2c000-00b2d000 r-xp 00019000 08:02 2068205    /lib/ld-2.5.so
00b2d000-00b2e000 rwxp 0001a000 08:02 2068205    /lib/ld-2.5.so
00b30000-00c6f000 r-xp 00000000 08:02 2068206    /lib/libc-2.5.so
00c6f000-00c70000 --xp 0013f000 08:02 2068206    /lib/libc-2.5.so
00c70000-00c72000 r-xp 0013f000 08:02 2068206    /lib/libc-2.5.so
00c72000-00c73000 rwxp 00141000 08:02 2068206    /lib/libc-2.5.so
00c73000-00c76000 rwxp 00c73000 00:00 0
00c78000-00c9d000 r-xp 00000000 08:02 2068213    /lib/libm-2.5.so
00c9d000-00c9e000 r-xp 00024000 08:02 2068213    /lib/libm-2.5.so
00c9e000-00c9f000 rwxp 00025000 08:02 2068213    /lib/libm-2.5.so
00ca1000-00ca3000 r-xp 00000000 08:02 2068207    /lib/libdl-2.5.so
00ca3000-00ca4000 r-xp 00001000 08:02 2068207    /lib/libdl-2.5.so
00ca4000-00ca5000 rwxp 00002000 08:02 2068207    /lib/libdl-2.5.so
00ca7000-00cba000 r-xp 00000000 08:02 2068208    /lib/libpthread-2.5.so
00cba000-00cbb000 r-xp 00013000 08:02 2068208    /lib/libpthread-2.5.so
00cbb000-00cbc000 rwxp 00014000 08:02 2068208    /lib/libpthread-2.5.so
00cbc000-00cbe000 rwxp 00cbc000 00:00 0
00e94000-00ee2000 r-xp 00000000 08:02 1937496
/usr/local/lib/ladspa/caps.so
00ee2000-00f83000 rwxp 0004d000 08:02 1937496
/usr/local/lib/ladspa/caps.so
057c3000-0589d000 r-xp 00000000 08:02 2068232    /lib/libasound.so.2.0.0
0589d000-058a2000 rwxp 000d9000 08:02 2068232    /lib/libasound.so.2.0.0
08048000-08054000 r-xp 00000000 08:02 1155406    /usr/bin/aplay
08054000-08056000 rw-p 0000b000 08:02 1155406    /usr/bin/aplay
0976a000-0978b000 rw-p 0976a000 00:00 0          [heap]
b7d8d000-b7d8e000 r--p 00ca8000 08:02 1151208
/usr/lib/locale/locale-archive
b7d8e000-b7f8e000 r--p 00000000 08:02 1151208
/usr/lib/locale/locale-archive
b7f8e000-b7f91000 rw-p b7f8e000 00:00 0
bfe19000-bfe2e000 rw-p bffea000 00:00 0          [stack]
Aborted by signal Abandon...
Erreur de segmentation (core dumped)

Is there a problem like a null descriptor here ?:

void _fini()
{
    for (ulong i = 0; i < N; ++i)
        delete descriptors[i];
}
