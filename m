From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: kernel panic with gta02 sound driver
Date: Mon, 30 Jan 2012 00:48:20 +0100
Message-ID: <1327880901-15944-1-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp203.alice.it (smtp203.alice.it [82.57.200.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E4EE24763
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 00:48:32 +0100 (CET)
Received: from trisquel.workgroup (82.48.81.29) by smtp203.alice.it
	(8.6.023.02) (authenticated as editempo@alice.it)
	id 4ECA5E2302386ED2 for alsa-devel@alsa-project.org;
	Mon, 30 Jan 2012 00:48:31 +0100
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


hi,

The patch contained in that mail fixes the dai link of
  the gta02 machine, it worked (better) on a 3.2.1 kernel
  (it didn't made the card work but only permitted the dai link
  to happen).

but with linux-next it produces a kernel panic:
[    0.985000] Alignment trap: not handling swp instruction
[    0.985000] Alignment trap: not handling instruction e1003092 at [<c03b0244>]
[    0.990000] Unhandled fault: alignment exception (0x803) at 0x37386d77
[    0.995000] Internal error: : 803 [#1]
[    0.995000] CPU: 0    Not tainted  (3.3.0-rc1-next-20120127+ #55)
[    0.995000] PC is at mutex_lock+0x8/0x14
[    0.995000] LR is at regmap_write+0x14/0x38
[    0.995000] pc : [<c03b0248>]    lr : [<c01bf7ac>]    psr: 60000013
[    0.995000] sp : c7821e28  ip : 00000000  fp : 00000000
[    0.995000] r10: c79a59c0  r9 : 00000001  r8 : c052fd5c
[    0.995000] r7 : 00000001  r6 : 0000001f  r5 : 00000000  r4 : 37386d77
[    0.995000] r3 : 00000000  r2 : 00000000  r1 : 0000001f  r0 : 37386d77
[    0.995000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    0.995000] Control: c000717f  Table: 30004000  DAC: 00000017
[    0.995000] Process swapper (pid: 1, stack limit = 0xc7820270)
[    0.995000] Stack: (0xc7821e28 to 0xc7822000)
[    0.995000] 1e20:                   c79bfa00 00000000 c79a5a40 c024e408 000000c0 c0257838
[    0.995000] 1e40: c79bfa00 c052fb80 c052efb8 c024e7e4 c041e348 c0013658 c052fb80 c79bf800
[    0.995000] 1e60: c79bfa00 00000000 c79bee60 00000000 c7894240 c024efb4 c052fb90 3ab5e842
[    0.995000] 1e80: c79bec80 00000000 c052ed50 c052fce8 c052fc3c c052fba0 c052fc54 c052fc34
[    0.995000] 1ea0: c052fc64 c052ebe8 00000000 c052fb80 c052fb98 c052eb60 00000000 c052ebe8
[    0.995000] 1ec0: 00000000 00000000 00000000 c0250484 c79bfc08 c79bfc08 00000000 00000000
[    0.995000] 1ee0: c052eb8c c025053c c052eb8c c79bfc08 c05842d4 c01b5edc c01b5ec8 c01b4c70
[    0.995000] 1f00: c79bfc08 c01b4e10 00000000 00000000 c05842b0 c01b3bc0 c7840c1c c79a60f4
[    0.995000] 1f20: c79bfc08 c79bfc3c c79bfc08 c01b4ee0 c79bfc08 c0527a98 c79bfc08 c01b3db4
[    0.995000] 1f40: c79bfc08 c79bfc10 c0527958 c01b26d0 c79bfc10 00000000 00000021 c0165884
[    0.995000] 1f60: c7821f88 c79bfc00 c79bfc08 c79bfc00 c79bfc08 00000000 00000013 00000000
[    0.995000] 1f80: 00000000 00000000 00000000 c01b646c c79bec20 c052fb80 00000000 c05854f8
[    0.995000] 1fa0: 00000013 c04efdb8 c05023b0 00000000 c04efd5c c04da800 c0009850 60000013
[    0.995000] 1fc0: 00000000 c0501f28 c050269c c05023b0 c050269c c0009850 00000013 00000000
[    0.995000] 1fe0: 00000000 c04da960 00000000 00000000 c04da8d0 c0009850 00000000 00000000
[    0.995000] [<c03b0248>] (mutex_lock+0x8/0x14) from [<c01bf7ac>] (regmap_write+0x14/0x38)
[    0.995000] [<c01bf7ac>] (regmap_write+0x14/0x38) from [<c024e408>] (snd_soc_write+0xc/0x10)
[    0.995000] [<c024e408>] (snd_soc_write+0xc/0x10) from [<c0257838>] (wm8753_probe+0x74/0x1c4)
[    0.995000] [<c0257838>] (wm8753_probe+0x74/0x1c4) from [<c024e7e4>] (soc_probe_codec+0x124/0x208)
[    0.995000] [<c024e7e4>] (soc_probe_codec+0x124/0x208) from [<c024efb4>] (snd_soc_instantiate_cards+0x664/0xd5c)
[    0.995000] [<c024efb4>] (snd_soc_instantiate_cards+0x664/0xd5c) from [<c0250484>] (snd_soc_register_card+0x240/0x2d4)
[    0.995000] [<c0250484>] (snd_soc_register_card+0x240/0x2d4) from [<c025053c>] (soc_probe+0x24/0x40)
[    0.995000] [<c025053c>] (soc_probe+0x24/0x40) from [<c01b5edc>] (platform_drv_probe+0x14/0x18)
[    0.995000] [<c01b5edc>] (platform_drv_probe+0x14/0x18) from [<c01b4c70>] (driver_probe_device+0xa0/0x1b0)
[    0.995000] [<c01b4c70>] (driver_probe_device+0xa0/0x1b0) from [<c01b3bc0>] (bus_for_each_drv+0x64/0x8c)
[    0.995000] [<c01b3bc0>] (bus_for_each_drv+0x64/0x8c) from [<c01b4ee0>] (device_attach+0x8c/0xa4)
[    0.995000] [<c01b4ee0>] (device_attach+0x8c/0xa4) from [<c01b3db4>] (bus_probe_device+0x88/0xac)
[    0.995000] [<c01b3db4>] (bus_probe_device+0x88/0xac) from [<c01b26d0>] (device_add+0x4a0/0x570)
[    0.995000] [<c01b26d0>] (device_add+0x4a0/0x570) from [<c01b646c>] (platform_device_add+0xf0/0x18c)
[    0.995000] [<c01b646c>] (platform_device_add+0xf0/0x18c) from [<c04efdb8>] (neo1973_init+0x5c/0x9c)
[    0.995000] [<c04efdb8>] (neo1973_init+0x5c/0x9c) from [<c04da800>] (do_one_initcall+0xa4/0x174)
[    0.995000] [<c04da800>] (do_one_initcall+0xa4/0x174) from [<c04da960>] (kernel_init+0x90/0x128)
[    0.995000] [<c04da960>] (kernel_init+0x90/0x128) from [<c0009850>] (kernel_thread_exit+0x0/0x8)
[    0.995000] Code: e28dd010 e8bd81f0 e3a02000 e1003092 (e3530001) 
[    1.000000] ---[ end trace 81e43b55a6684d02 ]---

What could be the cause? (the CPU is an armv4).

Denis.
