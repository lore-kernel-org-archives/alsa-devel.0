From: Vicente Bergas <vicencb@gmail.com>
Subject: =?iso-8859-1?q?=5Bregression=5D_snd=5Fsoc=5Fsimple?=
 =?iso-8859-1?q?=5Fcard=3A_refcount=5Ft=3A_underflow=3B_use-after-free=2E?=
Date: Thu, 14 Feb 2019 19:10:57 +0100
Message-ID: <f9733cec-f945-41b0-8bf9-9b5680dcb97a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FF25267492
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 19:11:00 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id i12so7573657wrw.0
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 10:11:00 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,
in linux 5.0-rc there is a regression regarding snd_soc_simple_card.
Since updated from 4.20 there is a new error appearing in the kernel log,
although sound works fine and the system is stable.

The issue has not been bisected, but it probably lies at or arround
this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=da215354eb55c382d3d5c426ea0e9aa7ef7c10e1

The DT node referred in the trace below is:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399.dtsi?id=da215354eb55c382d3d5c426ea0e9aa7ef7c10e1#n1692

The kernel comes from the ArchLinuxArm distribution, its configuration is:
https://archlinuxarm.org/packages/aarch64/linux-aarch64-rc/files/config

This trace is from "dmesg -tl1,2,3,4":
OF: ERROR: Bad of_node_put() on /hdmi-sound
CPU: 2 PID: 370 Comm: kworker/2:2 Tainted: G         C        
5.0.0-rc6-1-ARCH #1
Hardware name: Sapphire-RK3399 Board (DT)
Workqueue: events deferred_probe_work_func
Call trace:
 dump_backtrace+0x0/0x1b8
 show_stack+0x24/0x30
 dump_stack+0x98/0xbc
 of_node_release+0xd0/0xd8
 kobject_put+0x8c/0x1f0
 of_node_put+0x24/0x30
 __of_get_next_child+0x50/0x70
 of_get_next_child+0x64/0x90
 asoc_simple_card_probe+0xe4/0x6b0 [snd_soc_simple_card]
 platform_drv_probe+0x58/0xa8
 really_probe+0x1f0/0x3d8
 driver_probe_device+0xe4/0x138
 __device_attach_driver+0xb4/0x140
 bus_for_each_drv+0x8c/0xd8
 __device_attach+0xdc/0x158
 device_initial_probe+0x24/0x30
 bus_probe_device+0x9c/0xa8
 deferred_probe_work_func+0xa0/0xf0
 process_one_work+0x1ac/0x400
 worker_thread+0x50/0x488
 kthread+0x130/0x138
 ret_from_fork+0x10/0x1c
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 2 PID: 370 at lib/refcount.c:187 
refcount_sub_and_test_checked+0xb8/0xd0
Modules linked in: snd_soc_hdmi_codec rockchip_vpu(C+) rockchip_rga 
videobuf2_dma_contig videobuf2_dma_sg v4l2_mem2mem videobuf2_vmalloc 
videobuf2_memops videobuf2_v4l2 videobuf2_common rc_cec snd_soc_simple_card 
realtek snd_soc_rockchip_i2s snd_soc_simple_card_utils snd_soc_rockchip_pcm 
dw_hdmi_cec dw_hdmi_i2s_audio dw_wdt videodev rtc_rk808 media 
hid_kensington dwmac_rk rockchip_saradc rockchip_thermal stmmac_platform 
stmmac squashfs loop crypto_user gpio_keys rockchipdrm analogix_dp dw_hdmi 
cec rc_core dw_mipi_dsi drm_kms_helper syscopyarea sysfillrect sysimgblt 
fb_sys_fops drm drm_panel_orientation_quirks
CPU: 2 PID: 370 Comm: kworker/2:2 Tainted: G         C        
5.0.0-rc6-1-ARCH #1
Hardware name: Sapphire-RK3399 Board (DT)
Workqueue: events deferred_probe_work_func
pstate: 80000085 (Nzcv daIf -PAN -UAO)
pc : refcount_sub_and_test_checked+0xb8/0xd0
lr : refcount_sub_and_test_checked+0xb8/0xd0
sp : ffff000012d9ba20
x29: ffff000012d9ba20 x28: 0000000000000000 
x27: 0000000000000002 x26: 0000000000000001 
x25: ffff0000115ad6c8 x24: ffff0000090bb428 
x23: ffff8000f781a740 x22: 0000000000000000 
x21: ffff8000f781a740 x20: ffff8000f781a740 
x19: ffff8000f781a790 x18: 0000000000000000 
x17: 0000000000000000 x16: 0000000000000000 
x15: ffffffffffffffff x14: 0000000000000003 
x13: 0000000000000000 x12: ffff000011810000 
x11: ffff0000115d6000 x10: ffff000011810f48 
x9 : 0000000000000000 x8 : ffff00001181f170 
x7 : 0000000000000000 x6 : 0000000000000001 
x5 : 0000000000000000 x4 : 0000000000000001 
x3 : 0000000000000007 x2 : 0000000000000007 
x1 : 86b2dbbfc7425b00 x0 : 0000000000000000 
Call trace:
 refcount_sub_and_test_checked+0xb8/0xd0
 refcount_dec_and_test_checked+0x14/0x20
 kobject_put+0x24/0x1f0
 of_node_put+0x24/0x30
 __of_get_next_child+0x50/0x70
 of_get_next_child+0x64/0x90
 asoc_simple_card_probe+0x544/0x6b0 [snd_soc_simple_card]
 platform_drv_probe+0x58/0xa8
 really_probe+0x1f0/0x3d8
 driver_probe_device+0xe4/0x138
 __device_attach_driver+0xb4/0x140
 bus_for_each_drv+0x8c/0xd8
 __device_attach+0xdc/0x158
 device_initial_probe+0x24/0x30
 bus_probe_device+0x9c/0xa8
 deferred_probe_work_func+0xa0/0xf0
 process_one_work+0x1ac/0x400
 worker_thread+0x50/0x488
 kthread+0x130/0x138
 ret_from_fork+0x10/0x1c
---[ end trace ae290e9394a14a2f ]---
asoc-simple-card hdmi-sound: ASoC: no DMI vendor name!

Regards,
  Vicente.
