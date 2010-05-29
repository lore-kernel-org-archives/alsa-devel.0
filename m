From: Ruchi Sirauthiya <sirauthiya.ruchi@gmail.com>
Subject: arecord and DMA misaligned error with device
Date: Sat, 29 May 2010 23:43:40 +0530
Message-ID: <AANLkTilGJrApaQ2N9vQLVLKQWq_tkv7qMVKzYHUlBdpl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 78A9E243D0
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 20:13:41 +0200 (CEST)
Received: by vws5 with SMTP id 5so39087vws.38
	for <alsa-devel@alsa-project.org>; Sat, 29 May 2010 11:13:40 -0700 (PDT)
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

Hi all,

I am working on an OMAP board with Linux kernel 2.6.22.18-omap3 and ALSA. I
got the
following stack trace when running 'arecord' continuously for a long time
(~30 minutes).

What could be the reason for "page allocation failure" and "DMA misaligned
error"? How can I solve this issue?

Thanks and Regards,

Ruchi Sirauthiya

---- LOG START ----

page allocation failure. order:5, mode:0xd1
[ 1249.046875] [<c0050380>] (dump_stack+0x0/0x14) from [<c00ae260>]
(__alloc_pages+0x288/0x29c)
[ 1249.054687] [<c00adfd8>] (__alloc_pages+0x0/0x29c) from [<c0051cac>]
(__dma_alloc+0x17c/0x3d4)
[ 1249.062500] [<c0051b30>] (__dma_alloc+0x0/0x3d4) from [<c0051f58>]
(dma_alloc_coherent+0x24/0x30)
[ 1249.070312] [<c0051f34>] (dma_alloc_coherent+0x0/0x30) from [<c02717b4>]
(snd_omap_alsa_hw_params+0x54/0x7c)
[ 1249.085937] [<c0271760>] (snd_omap_alsa_hw_params+0x0/0x7c) from
[<c02683dc>] (snd_pcm_hw_params+0x90/0x2e0)
[ 1249.093750] r5:c19d6000 r4:c15da000
[ 1249.093750] [<c026834c>] (snd_pcm_hw_params+0x0/0x2e0) from [<c02686b0>]
(snd_pcm_hw_params_user+0x84/0xe4)
[ 1249.109375] r9:cb8f4000 r8:c004c028 r7:c077e360 r6:c19d6000 r5:c077e360
[ 1249.109375] r4:001bdb48
[ 1249.117187] [<c026862c>] (snd_pcm_hw_params_user+0x0/0xe4) from
[<c02689c0>] (snd_pcm_common_ioctl1+0x1cc/0xf04)
[ 1249.125000] r7:c077e360 r6:001bdb48 r5:001bdb48 r4:c25c4111
[ 1249.132812] [<c02687f4>] (snd_pcm_common_ioctl1+0x0/0xf04) from
[<c0269b44>] (snd_pcm_capture_ioctl1+0x44c/0x470)
[ 1249.140625] [<c02696f8>] (snd_pcm_capture_ioctl1+0x0/0x470) from
[<c0269b9c>] (snd_pcm_capture_ioctl+0x34/0x38)
[ 1249.148437] [<c0269b68>] (snd_pcm_capture_ioctl+0x0/0x38) from
[<c00d0adc>] (do_ioctl+0x34/0x78)
[ 1249.164062] [<c00d0aa8>] (do_ioctl+0x0/0x78) from [<c00d0d80>]
(vfs_ioctl+0x260/0x278)
[ 1249.171875] r5:001bdb48 r4:ccb9a4e0
[ 1249.171875] [<c00d0b20>] (vfs_ioctl+0x0/0x278) from [<c00d0dd8>]
(sys_ioctl+0x40/0x64)
[ 1249.179687] r7:ccb9a4e0 r6:c25c4111 r5:001bdb48 r4:00000039
[ 1249.187500] [<c00d0d98>] (sys_ioctl+0x0/0x64) from [<c004be80>]
(ret_fast_syscall+0x0/0x2c)
[ 1249.195312] r7:00000036 r6:001ec5c8 r5:413b3bd4 r4:001bdb48
[ 1249.203125] Mem-info:
[ 1249.203125] DMA per-cpu:
[ 1249.203125] CPU 0: Hot: hi: 90, btch: 15 usd: 66 Cold: hi: 30, btch: 7
usd: 24
[ 1249.210937] Active:10183 inactive:35469 dirty:4 writeback:0 unstable:0
[ 1249.210937] free:739 slab:5167 mapped:2540 pagetables:125 bounce:0
[ 1249.226562] DMA free:2956kB min:1888kB low:2360kB high:2832kB
active:40732kB inactive:141876kB present:223520kB pages_scanned:0
all_unreclaimable? no
[ 1249.242187] lowmem_reserve[]: 0 0
[ 1249.242187] DMA: 13*4kB 33*8kB 27*16kB 3*32kB 31*64kB 1*128kB 0*256kB
0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 2956kB
[ 1249.257812] Free swap: 0kB
[ 1249.265625] 56320 pages of RAM
[ 1249.273437] 1016 free pages
[ 1249.273437] 3616 reserved pages
[ 1249.273437] 5167 slab pages
[ 1249.281250] 41756 pages shared
[ 1249.281250] 0 pages swap cached
[ 1249.343750] DMA misaligned error with device 1
[ 1249.343750] DMA misaligned error with device 1
[ 1249.351562] DMA misaligned error with device 1
[ 1249.359375] DMA misaligned error with device 1
[ 1249.359375] DMA misaligned error with device 1
[ 1249.367187] DMA misaligned error with device 1
[ 1249.367187] DMA misaligned error with device 1
[ 1249.375000] DMA misaligned error with device 1
[ 1249.375000] DMA misaligned error with device 1
[ 1249.382812] DMA misaligned error with device 1
[ 1249.390625] DMA misaligned error with device 1
[ 1249.390625] DMA misaligned error with device 1
[ 1249.398437] DMA misaligned error with device 1
[ 1249.398437] DMA misaligned error with device 1
[ 1249.406250] DMA misaligned error with device 1
[ 1249.406250] DMA misaligned error with device 1
...
... log truncated ...
...
---- LOG END ----
