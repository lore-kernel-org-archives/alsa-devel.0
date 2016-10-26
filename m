From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Move request of speaker IRQs
	into bus probe" to the asoc tree
Date: Wed, 26 Oct 2016 11:15:49 +0100
Message-ID: <E1bzLFN-0004TY-7t@debutante>
References: <1477475998-20114-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 425C126697D
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 12:15:56 +0200 (CEST)
In-Reply-To: <1477475998-20114-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Move request of speaker IRQs into bus probe

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

>From 31833ead95c2c0a374f35a8ae8148c00459a0d49 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 26 Oct 2016 10:59:57 +0100
Subject: [PATCH] ASoC: arizona: Move request of speaker IRQs into bus probe

It is more idiomatic to request all resources in the bus level probe,
this patch moves the request of the speaker thermal event IRQs from the
ASoC level probe into the bus level probe.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 17 +++++++++++------
 sound/soc/codecs/arizona.h |  3 ++-
 sound/soc/codecs/cs47l24.c | 19 +++++++++++++++----
 sound/soc/codecs/wm5102.c  | 20 ++++++++++++++++----
 sound/soc/codecs/wm5110.c  | 20 ++++++++++++++++----
 sound/soc/codecs/wm8997.c  | 26 +++++++++++++++++++++-----
 sound/soc/codecs/wm8998.c  | 28 +++++++++++++++++++++++-----
 7 files changed, 104 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 7f7d4b31a7fd..99ce6a0e73de 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -191,6 +191,14 @@ int arizona_init_spk(struct snd_soc_codec *codec)
 		break;
 	}
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_init_spk);
+
+int arizona_init_spk_irqs(struct arizona *arizona)
+{
+	int ret;
+
 	ret = arizona_request_irq(arizona, ARIZONA_IRQ_SPK_OVERHEAT_WARN,
 				  "Thermal warning", arizona_thermal_warn,
 				  arizona);
@@ -209,19 +217,16 @@ int arizona_init_spk(struct snd_soc_codec *codec)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(arizona_init_spk);
+EXPORT_SYMBOL_GPL(arizona_init_spk_irqs);
 
-int arizona_free_spk(struct snd_soc_codec *codec)
+int arizona_free_spk_irqs(struct arizona *arizona)
 {
-	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona *arizona = priv->arizona;
-
 	arizona_free_irq(arizona, ARIZONA_IRQ_SPK_OVERHEAT_WARN, arizona);
 	arizona_free_irq(arizona, ARIZONA_IRQ_SPK_OVERHEAT, arizona);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(arizona_free_spk);
+EXPORT_SYMBOL_GPL(arizona_free_spk_irqs);
 
 static const struct snd_soc_dapm_route arizona_mono_routes[] = {
 	{ "OUT1R", NULL, "OUT1L" },
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 9d0997bec870..34d65d1eafba 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -317,7 +317,8 @@ extern int arizona_init_gpio(struct snd_soc_codec *codec);
 extern int arizona_init_mono(struct snd_soc_codec *codec);
 extern int arizona_init_notifiers(struct snd_soc_codec *codec);
 
-extern int arizona_free_spk(struct snd_soc_codec *codec);
+extern int arizona_init_spk_irqs(struct arizona *arizona);
+extern int arizona_free_spk_irqs(struct arizona *arizona);
 
 extern int arizona_init_dai(struct arizona_priv *priv, int dai);
 
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 7df6a6769038..17e52c1599e4 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1170,8 +1170,6 @@ static int cs47l24_codec_remove(struct snd_soc_codec *codec)
 
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
 
-	arizona_free_spk(codec);
-
 	return 0;
 }
 
@@ -1287,20 +1285,31 @@ static int cs47l24_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	ret = arizona_init_spk_irqs(arizona);
+	if (ret < 0)
+		return ret;
+
 	ret = snd_soc_register_platform(&pdev->dev, &cs47l24_compr_platform);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
-		return ret;
+		goto err_spk_irqs;
 	}
 
 	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_cs47l24,
 				      cs47l24_dai, ARRAY_SIZE(cs47l24_dai));
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
-		snd_soc_unregister_platform(&pdev->dev);
+		goto err_platform;
 	}
 
 	return ret;
+
+err_platform:
+	snd_soc_unregister_platform(&pdev->dev);
+err_spk_irqs:
+	arizona_free_spk_irqs(arizona);
+
+	return ret;
 }
 
 static int cs47l24_remove(struct platform_device *pdev)
@@ -1314,6 +1323,8 @@ static int cs47l24_remove(struct platform_device *pdev)
 	wm_adsp2_remove(&cs47l24->core.adsp[1]);
 	wm_adsp2_remove(&cs47l24->core.adsp[2]);
 
+	arizona_free_spk_irqs(arizona);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index bb3de5b3d816..6f40ee6f0bbc 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1978,8 +1978,6 @@ static int wm5102_codec_remove(struct snd_soc_codec *codec)
 
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
 
-	arizona_free_spk(codec);
-
 	return 0;
 }
 
@@ -2097,25 +2095,37 @@ static int wm5102_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	ret = arizona_init_spk_irqs(arizona);
+	if (ret < 0)
+		return ret;
+
 	ret = snd_soc_register_platform(&pdev->dev, &wm5102_compr_platform);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
-		return ret;
+		goto err_spk_irqs;
 	}
 
 	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5102,
 				      wm5102_dai, ARRAY_SIZE(wm5102_dai));
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
-		snd_soc_unregister_platform(&pdev->dev);
+		goto err_platform;
 	}
 
 	return ret;
+
+err_platform:
+	snd_soc_unregister_platform(&pdev->dev);
+err_spk_irqs:
+	arizona_free_spk_irqs(arizona);
+
+	return ret;
 }
 
 static int wm5102_remove(struct platform_device *pdev)
 {
 	struct wm5102_priv *wm5102 = platform_get_drvdata(pdev);
+	struct arizona *arizona = wm5102->core.arizona;
 
 	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
@@ -2123,6 +2133,8 @@ static int wm5102_remove(struct platform_device *pdev)
 
 	wm_adsp2_remove(&wm5102->core.adsp[0]);
 
+	arizona_free_spk_irqs(arizona);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 407dc4a43b07..667fc25dd094 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2330,8 +2330,6 @@ static int wm5110_codec_remove(struct snd_soc_codec *codec)
 
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
 
-	arizona_free_spk(codec);
-
 	return 0;
 }
 
@@ -2453,25 +2451,37 @@ static int wm5110_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	ret = arizona_init_spk_irqs(arizona);
+	if (ret < 0)
+		return ret;
+
 	ret = snd_soc_register_platform(&pdev->dev, &wm5110_compr_platform);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
-		return ret;
+		goto err_spk_irqs;
 	}
 
 	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5110,
 				      wm5110_dai, ARRAY_SIZE(wm5110_dai));
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
-		snd_soc_unregister_platform(&pdev->dev);
+		goto err_platform;
 	}
 
 	return ret;
+
+err_platform:
+	snd_soc_unregister_platform(&pdev->dev);
+err_spk_irqs:
+	arizona_free_spk_irqs(arizona);
+
+	return ret;
 }
 
 static int wm5110_remove(struct platform_device *pdev)
 {
 	struct wm5110_priv *wm5110 = platform_get_drvdata(pdev);
+	struct arizona *arizona = wm5110->core.arizona;
 	int i;
 
 	snd_soc_unregister_platform(&pdev->dev);
@@ -2481,6 +2491,8 @@ static int wm5110_remove(struct platform_device *pdev)
 	for (i = 0; i < WM5110_NUM_ADSP; i++)
 		wm_adsp2_remove(&wm5110->core.adsp[i]);
 
+	arizona_free_spk_irqs(arizona);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index f5f5d4352670..600595c54fe7 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1077,8 +1077,6 @@ static int wm8997_codec_remove(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = NULL;
 
-	arizona_free_spk(codec);
-
 	return 0;
 }
 
@@ -1124,7 +1122,7 @@ static int wm8997_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
 	struct wm8997_priv *wm8997;
-	int i;
+	int i, ret;
 
 	wm8997 = devm_kzalloc(&pdev->dev, sizeof(struct wm8997_priv),
 			      GFP_KERNEL);
@@ -1164,15 +1162,33 @@ static int wm8997_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8997,
-				      wm8997_dai, ARRAY_SIZE(wm8997_dai));
+	ret = arizona_init_spk_irqs(arizona);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8997,
+				     wm8997_dai, ARRAY_SIZE(wm8997_dai));
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
+		goto err_spk_irqs;
+	}
+
+err_spk_irqs:
+	arizona_free_spk_irqs(arizona);
+
+	return ret;
 }
 
 static int wm8997_remove(struct platform_device *pdev)
 {
+	struct wm8997_priv *wm8997 = platform_get_drvdata(pdev);
+	struct arizona *arizona = wm8997->core.arizona;
+
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	arizona_free_spk_irqs(arizona);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 3eaa3615b82e..4cccaae6dcfa 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1337,8 +1337,6 @@ static int wm8998_codec_remove(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = NULL;
 
-	arizona_free_spk(codec);
-
 	return 0;
 }
 
@@ -1387,7 +1385,7 @@ static int wm8998_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
 	struct wm8998_priv *wm8998;
-	int i;
+	int i, ret;
 
 	wm8998 = devm_kzalloc(&pdev->dev, sizeof(struct wm8998_priv),
 			      GFP_KERNEL);
@@ -1419,15 +1417,35 @@ static int wm8998_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8998,
-				      wm8998_dai, ARRAY_SIZE(wm8998_dai));
+	ret = arizona_init_spk_irqs(arizona);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8998,
+				     wm8998_dai, ARRAY_SIZE(wm8998_dai));
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
+		goto err_spk_irqs;
+	}
+
+	return ret;
+
+err_spk_irqs:
+	arizona_free_spk_irqs(arizona);
+
+	return ret;
 }
 
 static int wm8998_remove(struct platform_device *pdev)
 {
+	struct wm8998_priv *wm8998 = platform_get_drvdata(pdev);
+	struct arizona *arizona = wm8998->core.arizona;
+
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	arizona_free_spk_irqs(arizona);
+
 	return 0;
 }
 
-- 
2.8.1
