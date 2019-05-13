From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98357a: request GPIO when device get
	probed" to the asoc tree
Date: Mon, 13 May 2019 13:30:28 +0100 (BST)
Message-ID: <20190513123028.2FBE81129233@debutante.sirena.org.uk>
References: <20190509030454.216079-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 338DEF8973A
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:43 +0200 (CEST)
In-Reply-To: <20190509030454.216079-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, tiwai@suse.com, tzungbi@google.com, Mark Brown <broonie@kernel.org>, dgreid@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98357a: request GPIO when device get probed

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From bcd9382288af236321c83d27b0db196bf8814559 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Thu, 9 May 2019 11:04:54 +0800
Subject: [PATCH] ASoC: max98357a: request GPIO when device get probed

devm_gpiod_get_optional() returns EBUSY after component rebound.

Request GPIO in max98357a_platform_probe() to support component
rebinding.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98357a.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index d037a3e4d323..80080a6415b3 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -59,21 +59,7 @@ static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
 	{"Speaker", NULL, "HiFi Playback"},
 };
 
-static int max98357a_component_probe(struct snd_soc_component *component)
-{
-	struct gpio_desc *sdmode;
-
-	sdmode = devm_gpiod_get_optional(component->dev, "sdmode", GPIOD_OUT_LOW);
-	if (IS_ERR(sdmode))
-		return PTR_ERR(sdmode);
-
-	snd_soc_component_set_drvdata(component, sdmode);
-
-	return 0;
-}
-
 static const struct snd_soc_component_driver max98357a_component_driver = {
-	.probe			= max98357a_component_probe,
 	.dapm_widgets		= max98357a_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
 	.dapm_routes		= max98357a_dapm_routes,
@@ -112,16 +98,20 @@ static struct snd_soc_dai_driver max98357a_dai_driver = {
 
 static int max98357a_platform_probe(struct platform_device *pdev)
 {
+	struct gpio_desc *sdmode;
+
+	sdmode = devm_gpiod_get_optional(&pdev->dev,
+				"sdmode", GPIOD_OUT_LOW);
+	if (IS_ERR(sdmode))
+		return PTR_ERR(sdmode);
+
+	dev_set_drvdata(&pdev->dev, sdmode);
+
 	return devm_snd_soc_register_component(&pdev->dev,
 			&max98357a_component_driver,
 			&max98357a_dai_driver, 1);
 }
 
-static int max98357a_platform_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id max98357a_device_id[] = {
 	{ .compatible = "maxim,max98357a" },
@@ -145,7 +135,6 @@ static struct platform_driver max98357a_platform_driver = {
 		.acpi_match_table = ACPI_PTR(max98357a_acpi_match),
 	},
 	.probe	= max98357a_platform_probe,
-	.remove = max98357a_platform_remove,
 };
 module_platform_driver(max98357a_platform_driver);
 
-- 
2.20.1
