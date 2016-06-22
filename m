From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Revert "ASoC: Intel: Add support
	for PM ops in bxt-rt298"" to the asoc tree
Date: Wed, 22 Jun 2016 16:28:35 +0100
Message-ID: <E1bFk4x-0002I0-Rd@debutante>
References: <1466604861-24288-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 209E1266939
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 17:28:41 +0200 (CEST)
In-Reply-To: <1466604861-24288-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Revert "ASoC: Intel: Add support for PM ops in bxt-rt298"

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

>From 45a9e0753153907b1a5141377295daf5483805b7 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 22 Jun 2016 19:44:18 +0530
Subject: [PATCH] ASoC: Intel: Revert "ASoC: Intel: Add support for PM ops in
 bxt-rt298"

This reverts commit 3513798ca4bc ("ASoC: Intel: Add support for
PM ops in bxt-rt298") as the right way to fix this is to disable
async suspend

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 2ef33b113bb5..8b956500414b 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -454,33 +454,10 @@ static int broxton_audio_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(&pdev->dev, &broxton_rt298);
 }
 
-/*
- * we want the card to be suspend first and then platform driver. This
- * allows the DAPM to tear down pipelines on suspend and then platform shuts
- * down the DSP. For this use .prepare for suspending card
- *
- * Similarly, use complete to let DSP download firmware first and then sync
- * DAPM and restore pipelines to DSP
- */
-static void broxton_rt298_complete(struct device *dev)
-{
-	snd_soc_resume(dev);
-}
-
-static const struct dev_pm_ops broxton_pm_ops = {
-	.prepare = snd_soc_suspend,
-	.complete = broxton_rt298_complete,
-	.freeze = snd_soc_suspend,
-	.thaw = snd_soc_resume,
-	.poweroff = snd_soc_poweroff,
-	.restore = snd_soc_resume,
-};
-
 static struct platform_driver broxton_audio = {
 	.probe = broxton_audio_probe,
 	.driver = {
 		.name = "bxt_alc298s_i2s",
-		.pm = &broxton_pm_ops,
 	},
 };
 module_platform_driver(broxton_audio)
-- 
2.8.1
