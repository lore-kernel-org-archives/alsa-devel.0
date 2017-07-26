From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: board: Fix missing sentinel for
	bxt_board_id" to the asoc tree
Date: Wed, 26 Jul 2017 15:16:37 +0100
Message-ID: <E1daN77-0003P1-Sh@debutante>
References: <1500964186-25956-1-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A31E8267449
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 16:16:50 +0200 (CEST)
In-Reply-To: <1500964186-25956-1-git-send-email-pradeep.d.tewani@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pradeep Tewani <pradeep.d.tewani@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, fengguang.wu@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: board: Fix missing sentinel for bxt_board_id

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 82444cdb4673c146d43f3f5ff3baf582d4f4cb41 Mon Sep 17 00:00:00 2001
From: Pradeep Tewani <pradeep.d.tewani@intel.com>
Date: Tue, 25 Jul 2017 11:59:46 +0530
Subject: [PATCH] ASoC: Intel: board: Fix missing sentinel for bxt_board_id

Without a sentinel in the array of platform devices, we can get a panic
so add a sentinel. Full stack dump below:

[  231.564705] BUG: KASAN: global-out-of-bounds in platform_match+0xb0/0x146
[  231.565500] Read of size 1 at addr ffffffff8380a1a0 by task swapper/0/1
[  231.566280]
[  231.566594] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-00289-g152771f #1
[  231.567526] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
[  231.568730] Call Trace:
[  231.569128]  dump_stack+0xf8/0x14a
[  231.569615]  print_address_description+0x57/0x1e4
[  231.570216]  ? driver_probe_device+0x814/0x814
[  231.570798]  kasan_report+0x1cb/0x1eb
[  231.571302]  ? platform_match+0xb0/0x146
[  231.571833]  __asan_load1+0x45/0x47
[  231.572324]  platform_match+0xb0/0x146
[  231.572843]  ? platform_uevent+0x73/0x73
[  231.573370]  __driver_attach+0x47/0x16a
[  231.573890]  bus_for_each_dev+0x11a/0x15c
[  231.574422]  ? bus_remove_file+0x57/0x57
[  231.574951]  ? do_raw_spin_unlock+0xc3/0xe0
[  231.575501]  driver_attach+0x2b/0x2e
[  231.576002]  bus_add_driver+0x25e/0x3c5
[  231.576520]  ? set_debug_rodata+0x20/0x20
[  231.584776]  driver_register+0x13e/0x19d
[  231.585305]  __platform_driver_register+0x6c/0x71
[  231.585908]  ? skl_driver_init+0x20/0x20
[  231.586436]  broxton_audio_init+0x17/0x19
[  231.586976]  do_one_initcall+0x11a/0x221
[  231.587499]  ? start_kernel+0x525/0x525
[  231.588020]  ? lock_downgrade+0x281/0x2ec
[  231.588557]  ? trace_hardirqs_on_caller+0x223/0x267
[  231.589169]  ? _raw_spin_unlock_irqrestore+0x49/0x55
[  231.589791]  ? set_debug_rodata+0x20/0x20
[  231.590324]  kernel_init_freeable+0x1fd/0x2b0
[  231.590891]  ? rest_init+0x17c/0x17c
[  231.591384]  kernel_init+0x11/0x157
[  231.591876]  ? rest_init+0x17c/0x17c
[  231.592371]  ret_from_fork+0x2a/0x40
[  231.592865]
[  231.593166] The buggy address belongs to the variable:
[  231.593806]  bxt_board_ids+0x40/0x9e0

Fixes: 152771fbc3 ("ASoC: Intel: board: Add Geminilake platform support")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Pradeep Tewani <pradeep.d.tewani@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index a4b5bcb1f6f8..7843104fadcb 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -595,6 +595,7 @@ static const struct platform_device_id bxt_board_ids[] = {
 				(unsigned long)&broxton_rt298 },
 	{ .name = "glk_alc298s_i2s", .driver_data =
 				(unsigned long)&geminilake_rt298 },
+	{}
 };
 
 static struct platform_driver broxton_audio = {
-- 
2.13.2
