From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Question on arm64 unaligned faults during playback
Date: Mon, 8 Dec 2014 11:10:03 +0530
Message-ID: <CAM4voa=kiLsiLEzUbo3D+f1go5px78fXBSjSi7kGK4QCdnwPyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com
 [209.85.192.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 4892D260417
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 06:40:04 +0100 (CET)
Received: by mail-qg0-f49.google.com with SMTP id a108so3017690qge.8
 for <alsa-devel@alsa-project.org>; Sun, 07 Dec 2014 21:40:03 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: b42378@freescale.com, lars@metafoo.de, tiwai@suse.de, perex@perex.cz, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, p.zabel@pengutronix.de, padma.v@samsung.com
List-Id: alsa-devel@alsa-project.org

Hi,

I am working on a 64-bit ARM SoC (Samsung's Exynos7) and have observed
unaligned faults while testing certain sound streams with aplay.
Playing a 44.1k sampling rate stream gives the following crash while
48k streams work fine.


[root@(none) ~]# aplay test2_16bit_44k.wav
Playing WAVE 'test2_16bit_44k.wav' : Signed 1[   24.500724] sound:
2ch, 44100Hz, 88208bytes
6 bit Little Endian, Rate 44100 Hz, Stereo
[   24.520738] snd_pcm_lib_write_transfer:sound/core/pcm_lib.c hwbuf
is ffffff8000080000, runtime->dma_area is ffffff8000080000, hwoff is
0, frames_to_bytes is 0, frames is 5513
[   24.535661] snd_pcm_lib_write_transfer:sound/core/pcm_lib.c hwbuf
is ffffff8000085624, runtime->dma_area is ffffff8000080000, hwoff is
5513, frames_to_bytes is 22052, frames is 5513
[   24.551244] Unhandled fault: alignment fault (0x96000061) at
0xffffff8000085624
[   24.558448] Internal error: : 96000061 [#1] PREEMPT SMP
[   24.563449] Modules linked in:
[   24.566489] CPU: 0 PID: 928 Comm: aplay Not tainted 3.16.0+ #232
[   24.572473] task: ffffffc0a934c380 ti: ffffffc0038d4000 task.ti:
ffffffc0038d4000
[   24.579944] PC is at __copy_from_user+0x14/0x60
[   24.584450] LR is at snd_pcm_lib_write_transfer+0xe4/0x104
[   24.589912] pc : [<ffffffc0002d4784>] lr : [<ffffffc0004b58f0>]
pstate: 20000145
[   24.597285] sp : ffffffc0038d7c90
[   24.600583] x29: ffffffc0038d7c90 x28: ffffffc0038c1c00
[   24.605876] x27: ffffffc0a93eae00 x26: 0000000000001589
[   24.611168] x25: 0000000000000000 x24: 0000000000000000
[   24.616461] x23: 0000000000000008 x22: ffffff8000085624
[   24.621753] x21: 0000000000005624 x20: ffffffc0038c1c00
[   24.627046] x19: 0000000011d69620 x18: 0000007fd2e8b1c0
[   24.632339] x17: 0000007fa8057370 x16: ffffffc000196108
[   24.637632] x15: 232b226b00000000 x14: 617266202c333135
[   24.642925] x13: 352073692066666f x12: 7768202c30303030
[   24.648218] x11: 3830303030386666 x10: 6666666620736920
[   24.653510] x9 : 616572615f616d64 x8 : 000000000000026f
[   24.658803] x7 : ffffffc000998790 x6 : 0000000000000001
[   24.664095] x5 : 0000000000000000 x4 : 0000000011d6ec44
[   24.669388] x3 : f459f780f2b3f6d4 x2 : 0000000000005614
[   24.674681] x1 : 0000000011d69628 x0 : ffffff8000085624
[   24.679973]
[   24.681451] Process aplay (pid: 928, stack limit = 0xffffffc0038d4058)
[   24.687959] Stack: (0xffffffc0038d7c90 to 0xffffffc0038d8000)
[   24.693688] 7c80:                                     038d7cd0
ffffffc0 004b7578 ffffffc0
[   24.701846] 7ca0: 00001589 00000000 a93eaf50 ffffffc0 009ef000
ffffffc0 11d69620 00000000
[   24.710001] 7cc0: 004b580c ffffffc0 004b755c ffffffc0 038d7d70
ffffffc0 004b7758 ffffffc0
[   24.718158] 7ce0: a93eae00 ffffffc0 d2e8b438 0000007f a91eb858
ffffffc0 d2e8b438 0000007f
[   24.726313] 7d00: 40184150 00000000 d2e8b438 0000007f 00000115
00000000 0000001d 00000000
[   24.734470] 7d20: 00960000 ffffffc0 038d4000 ffffffc0 0000000a
00000000 038d7d68 ffffffc0
[   24.742626] 7d40: 00001589 00000000 00001589 00000000 00000000
00000000 009ef898 ffffffc0
[   24.750782] 7d60: a8b6d800 ffffffc0 0000409b 00000000 038d7da0
ffffffc0 004b2dd0 ffffffc0
[   24.758938] 7d80: a93eae00 ffffffc0 11d69620 00000000 11d69620
00000000 00001589 00000000
[   24.767094] 7da0: 038d7df0 ffffffc0 004b2e10 ffffffc0 a8b6d900
ffffffc0 d2e8b438 0000007f
[   24.775249] 7dc0: a91eb858 ffffffc0 00000004 00000000 00000001
00000000 00000000 00000000
[   24.783406] 7de0: 11d69620 00000000 00001589 00000000 038d7e00
ffffffc0 00195ecc ffffffc0
[   24.791563] 7e00: 038d7e90 ffffffc0 0019618c ffffffc0 00000000
00000000 a8b6d900 ffffffc0
[   24.799718] 7e20: a8b6d900 ffffffc0 00000004 00000000 40184150
00000000 00185888 ffffffc0
[   24.807875] 7e40: a8b6d800 ffffffc0 a8b6d800 ffffffc0 ffffffff
ffffffff a80f0588 0000007f
[   24.816030] 7e60: 80000000 00000000 00000015 00000000 038d7e80
ffffffc0 001a0340 ffffffc0
[   24.824187] 7e80: 038d7e90 ffffffc0 00196148 ffffffc0 d2e8b410
0000007f 0008425c ffffffc0
[   24.832343] 7ea0: 00000000 00000000 11d500e0 00000000 ffffffff
ffffffff a805737c 0000007f
[   24.840499] 7ec0: 60000000 00000000 00000015 00000000 00000004
00000000 40184150 00000000
[   24.848655] 7ee0: d2e8b438 0000007f a8223fbc 0000007f 00000003
00000000 00000000 00000000
[   24.856811] 7f00: a82d46f0 0000007f 00000000 00000000 0000001d
00000000 00000120 00000000
[   24.864967] 7f20: 01010101 01010101 00000016 00000000 00000003
00000000 11d510d0 00000000
[   24.873123] 7f40: 00000000 00000000 00000000 232b226b a8299b80
0000007f a8057370 0000007f
[   24.881279] 7f60: d2e8b1c0 0000007f 11d691f0 00000000 11d500e0
00000000 00001589 00000000
[   24.889435] 7f80: 11d69620 00000000 00000000 00000000 0041f7d8
00000000 00000003 00000000
[   24.897591] 7fa0: 00000000 00000000 00000004 00000000 00000003
00000000 d2e8b410 0000007f
[   24.905748] 7fc0: a8223ff0 0000007f d2e8b410 0000007f a805737c
0000007f 60000000 00000000
[   24.913904] 7fe0: 00000004 00000000 0000001d 00000000 d10d0579
f13ea086 786e62ff 1f2437e3
[   24.922054] Call trace:
[   24.924488] [<ffffffc0002d4784>] __copy_from_user+0x14/0x60
[   24.930040] [<ffffffc0004b7574>] snd_pcm_lib_write1+0x1fc/0x384
[   24.935940] [<ffffffc0004b7754>] snd_pcm_lib_write+0x58/0x80
[   24.941580] [<ffffffc0004b2dcc>] snd_pcm_playback_ioctl1+0x2e8/0x300
[   24.947913] [<ffffffc0004b2e0c>] snd_pcm_playback_ioctl+0x28/0x44
[   24.953990] [<ffffffc000195ec8>] do_vfs_ioctl+0x370/0x5b0
[   24.959367] [<ffffffc000196188>] SyS_ioctl+0x80/0x98
[   24.964314] Code: f1002042 540000a4 f8408423 f1002042 (f8008403)
[   24.976808] ---[ end trace 35415135d4341fc9 ]---


We are using the internal sram available for sound, for DMA buffer
allocation, using the generic SRAM driver. From the above log, the
buffer address offset is not 8-byte aligned and as we are using the
SRAM driver which maps the memory as device memory we are getting an
unaligned fault. Is it incorrect to use the generic sram driver for
arm64 or am I missing something ?

Regards,
Abhilash
