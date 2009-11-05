From: Daniel Mack <daniel@caiaq.de>
Subject: ALSA/ASoC crash in pm_qos_remove_requirement()?
Date: Thu, 5 Nov 2009 13:10:32 +0100
Message-ID: <20091105121032.GR14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 38B7E103942
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 13:10:36 +0100 (CET)
Content-Disposition: inline
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
Cc: Michael Hirsch <m.hirsch@raumfeld.com>
List-Id: alsa-devel@alsa-project.org

Has anyone seen a similar crash to the one below recently?
It happened to us on PXA300 embedded platforms.

Any pointers appreciated.

Thanks,
Daniel


[  882.823660] Unable to handle kernel paging request at virtual address 62696c2f
[  882.830853] pgd = c6000000
[  882.833536] [62696c2f] *pgd=00000000
[  882.837081] Internal error: Oops: 3 [#3]
[  882.840971] last sysfs file: /sys/devices/platform/spi_gpio.0/spi0.2/value
[  882.847793] Modules linked in: eeti_ts libertas_sdio pxamci ds2760_battery w1_ds2760 wire
[  882.855926] CPU: 0    Tainted: G      D     (2.6.32-rc6 #1)
[  882.861483] PC is at pm_qos_remove_requirement+0x78/0xb8
[  882.866773] LR is at snd_pcm_hw_params+0x258/0x2e4
[  882.871535] pc : [<c006da64>]    lr : [<c02685ec>]    psr: 60000093
[  882.871546] sp : c7fa1da0  ip : 00000001  fp : bea08668
[  882.882938] r10: c793b534  r9 : 00000001  r8 : c04dbd10
[  882.888125] r7 : 60000013  r6 : c7f57000  r5 : 00000000  r4 : 62696c2f
[  882.894604] r3 : c03548f0  r2 : 005893bc  r1 : c793b534  r0 : 00000001
[  882.901085] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM Segment user
[  882.908260] Control: 0000397f  Table: a6000018  DAC: 00000015
[  882.913962] Process p0-renderer (pid: 1235, stack limit = 0xc7fa0278)
[  882.920355] Stack: (0xc7fa1da0 to 0xc7fa2000)
[  882.924691] 1da0: c7f56000 00000000 c7f57000 00000001 c793b534 c7fa0000 c7f9f480 c02685ec
[  882.932822] 1dc0: c7f57000 c25c4111 bea08668 c793b500 bea08668 c0268a0c 00000000 00000000
[  882.940954] 1de0: 00000000 c7f66160 c7fa1e04 00000000 c7f66160 c0090d1c 00000000 c004a0d0
[  882.949078] 1e00: c7fbd880 c7f661dc 00000080 00000000 00000000 c76920ac 00000046 00000046
[  882.957203] 1e20: 00000000 c0605660 00000000 a65b330f c0605660 00000000 00000000 c0093974
[  882.965326] 1e40: 00000000 00000000 00000200 c7f78934 00000000 00000046 4044d000 c0605660
[  882.973452] 1e60: 00000000 00000000 c6001010 c7f66160 00000000 4044d000 c7f78934 c7f80634
[  882.981584] 1e80: c7f80600 c00941e8 00000046 00000000 00000000 40007000 3048c51d 0000004d
[  882.989708] 1ea0: c6000000 00000202 00000134 00000359 c05266a0 c0070834 3048c51d 00000000
[  882.997834] 1ec0: c7fa1eec c7f66160 c7fea000 c7f9f480 c25c4111 bea08668 c793b500 bea08668
[  883.005966] 1ee0: c7fa0000 4062a608 bea08668 c0269eb0 c04d6624 bea08268 00000005 c7fa1fb0
[  883.014100] 1f00: 4044da44 c7f9f480 c25c4111 bea08668 c7f9f480 c00b207c 00000012 c7f9f480
[  883.022232] 1f20: 00000012 c00b2780 c04d9d60 c006d164 c7fa1f5c c7f9401c c7fea000 00000015
[  883.030366] 1f40: 00000000 c7fea000 c7f80780 c7f80600 c7fa1fac c7fa1f60 c0351fec c0052f54
[  883.038498] 1f60: 00000000 c005b5c8 00000012 bea08668 c25c4111 c7f9f480 c00440c4 c7fa0000
[  883.046631] 1f80: 4062a608 c00b2820 40005030 00000001 03368914 bea08668 404b1674 00063a20
[  883.054764] 1fa0: 00000036 c0043f40 bea08668 404b1674 00000012 c25c4111 bea08668 00020001
[  883.062896] 1fc0: bea08668 404b1674 00063a20 00000036 00063778 00000000 4062a608 bea08668
[  883.071021] 1fe0: 404b19c0 bea08198 404593fc 40759234 20000010 00000012 00000000 00000000
[  883.079172] [<c006da64>] (pm_qos_remove_requirement+0x78/0xb8) from [<c02685ec>] (snd_pcm_hw_params+0x258/0x2e4)
[  883.089292] [<c02685ec>] (snd_pcm_hw_params+0x258/0x2e4) from [<c0268a0c>] (snd_pcm_common_ioctl1+0x22c/0xf00)
[  883.099241] [<c0268a0c>] (snd_pcm_common_ioctl1+0x22c/0xf00) from [<c0269eb0>] (snd_pcm_playback_ioctl1+0x3d0/0x3f4)
[  883.109713] [<c0269eb0>] (snd_pcm_playback_ioctl1+0x3d0/0x3f4) from [<c00b207c>] (vfs_ioctl+0x2c/0x70)
[  883.118971] [<c00b207c>] (vfs_ioctl+0x2c/0x70) from [<c00b2780>] (do_vfs_ioctl+0x4f4/0x55c)
[  883.127275] [<c00b2780>] (do_vfs_ioctl+0x4f4/0x55c) from [<c00b2820>] (sys_ioctl+0x38/0x5c)
[  883.135592] [<c00b2820>] (sys_ioctl+0x38/0x5c) from [<c0043f40>] (ret_fast_syscall+0x0/0x28)
[  883.143978] Code: eb00d3da e3a03001 ea000006 e1a04006 (e5946000)
[  883.150212] ---[ end trace 9912192a230e6312 ]---
