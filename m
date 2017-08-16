From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Medfield: Delete an error message for a failed memory allocation in snd_mfld_mc_probe()" to the asoc tree
Date: Wed, 16 Aug 2017 13:09:19 +0100
Message-ID: <E1dhx8R-0005da-Ne@finisterre>
References: <161e9c4c-1c97-d06f-35ec-3f165ad9e52e@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <161e9c4c-1c97-d06f-35ec-3f165ad9e52e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Medfield: Delete an error message for a failed memory allocation in snd_mfld_mc_probe()

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

>From 92ec46da6e35f5f7ff39741517a9466c82d1afb9 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 11:25:41 +0200
Subject: [PATCH] ASoC: Medfield: Delete an error message for a failed memory
 allocation in snd_mfld_mc_probe()

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/mfld_machine.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
index 4e08885f37aa..6f44acfb4aae 100644
--- a/sound/soc/intel/boards/mfld_machine.c
+++ b/sound/soc/intel/boards/mfld_machine.c
@@ -376,10 +376,8 @@ static int snd_mfld_mc_probe(struct platform_device *pdev)
 	/* audio interrupt base of SRAM location where
 	 * interrupts are stored by System FW */
 	mc_drv_ctx = devm_kzalloc(&pdev->dev, sizeof(*mc_drv_ctx), GFP_ATOMIC);
-	if (!mc_drv_ctx) {
-		pr_err("allocation failed\n");
+	if (!mc_drv_ctx)
 		return -ENOMEM;
-	}
 
 	irq_mem = platform_get_resource_byname(
 				pdev, IORESOURCE_MEM, "IRQ_BASE");
-- 
2.13.2
