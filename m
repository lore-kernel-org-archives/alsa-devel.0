From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: xtfpga-i2s: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:28:50 +0000
Message-ID: <E1elDE2-00030w-9P@debutante>
References: <87o9lzew5q.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F23A8267345
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:28:53 +0100 (CET)
In-Reply-To: <87o9lzew5q.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: xtfpga-i2s: replace platform to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 80f23c295b0bb64a65cd19aa5f09104d21bfa165 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:49:25 +0000
Subject: [PATCH] ASoC: xtfpga-i2s: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xtensa/xtfpga-i2s.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 2472144b329e..503560916620 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -483,13 +483,10 @@ static const struct snd_pcm_ops xtfpga_pcm_ops = {
 	.pointer	= xtfpga_pcm_pointer,
 };
 
-static const struct snd_soc_platform_driver xtfpga_soc_platform = {
-	.pcm_new	= xtfpga_pcm_new,
-	.ops		= &xtfpga_pcm_ops,
-};
-
 static const struct snd_soc_component_driver xtfpga_i2s_component = {
 	.name		= DRV_NAME,
+	.pcm_new	= xtfpga_pcm_new,
+	.ops		= &xtfpga_pcm_ops,
 };
 
 static const struct snd_soc_dai_ops xtfpga_i2s_dai_ops = {
@@ -591,18 +588,13 @@ static int xtfpga_i2s_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	err = snd_soc_register_platform(&pdev->dev, &xtfpga_soc_platform);
-	if (err < 0) {
-		dev_err(&pdev->dev, "couldn't register platform\n");
-		goto err;
-	}
 	err = devm_snd_soc_register_component(&pdev->dev,
 					      &xtfpga_i2s_component,
 					      xtfpga_i2s_dai,
 					      ARRAY_SIZE(xtfpga_i2s_dai));
 	if (err < 0) {
 		dev_err(&pdev->dev, "couldn't register component\n");
-		goto err_unregister_platform;
+		goto err;
 	}
 
 	pm_runtime_enable(&pdev->dev);
@@ -615,8 +607,6 @@ static int xtfpga_i2s_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-err_unregister_platform:
-	snd_soc_unregister_platform(&pdev->dev);
 err:
 	dev_err(&pdev->dev, "%s: err = %d\n", __func__, err);
 	return err;
@@ -626,7 +616,6 @@ static int xtfpga_i2s_remove(struct platform_device *pdev)
 {
 	struct xtfpga_i2s *i2s = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_platform(&pdev->dev);
 	if (i2s->regmap && !IS_ERR(i2s->regmap)) {
 		regmap_write(i2s->regmap, XTFPGA_I2S_CONFIG, 0);
 		regmap_write(i2s->regmap, XTFPGA_I2S_INT_MASK, 0);
-- 
2.16.1
