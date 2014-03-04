From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [RFC][PATCH 2/3] ASoc: codec: remove the set_cache_io() entirely from CODEC ASoC probe.
Date: Tue, 4 Mar 2014 16:25:28 +0800
Message-ID: <1393921529-28985-3-git-send-email-Li.Xiubo@freescale.com>
References: <1393921529-28985-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393921529-28985-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

As we can set the CODEC I/O while snd_soc_register_codec(), so the
calling of set_cache_io() from CODEC ASoC probe could be removed
entirely.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/codecs/cq93vc.c  |  6 ++++--
 sound/soc/codecs/mc13783.c | 10 ++--------
 sound/soc/codecs/wm5102.c  |  6 ++----
 sound/soc/codecs/wm5110.c  |  6 ++----
 sound/soc/codecs/wm8350.c  |  6 ++++--
 sound/soc/codecs/wm8400.c  |  6 ++++--
 sound/soc/codecs/wm8994.c  |  4 ++--
 sound/soc/codecs/wm8997.c  |  7 ++-----
 8 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 1e25c7a..27e2b7e 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -139,8 +139,6 @@ static int cq93vc_probe(struct snd_soc_codec *codec)
 
 	davinci_vc->cq93vc.codec = codec;
 
-	snd_soc_codec_set_cache_io(codec, davinci_vc->regmap);
-
 	/* Off, with power on */
 	cq93vc_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -165,6 +163,10 @@ static struct snd_soc_codec_driver soc_codec_dev_cq93vc = {
 
 static int cq93vc_platform_probe(struct platform_device *pdev)
 {
+	struct davinci_vc *davinci_vc = codec->dev->platform_data;
+
+	soc_codec_dev_cq93vc.regmap = davinci_vc->regmap;
+
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_cq93vc, &cq93vc_dai, 1);
 }
diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 3331cc7..63b4dcb 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -612,14 +612,6 @@ static struct snd_kcontrol_new mc13783_control_list[] = {
 static int mc13783_probe(struct snd_soc_codec *codec)
 {
 	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	ret = snd_soc_codec_set_cache_io(codec,
-			dev_get_regmap(codec->dev->parent, NULL));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		return ret;
-	}
 
 	/* these are the reset values */
 	mc13xxx_reg_write(priv->mc13xxx, MC13783_AUDIO_RX0, 0x25893);
@@ -770,6 +762,8 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, priv);
 	priv->mc13xxx = dev_get_drvdata(pdev->dev.parent);
 
+	soc_codec_dev_mc13783.regmap = dev_get_regmap(pdev->dev->parent, NULL);
+
 	if (priv->adc_ssi_port == priv->dac_ssi_port)
 		ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_mc13783,
 			mc13783_dai_sync, ARRAY_SIZE(mc13783_dai_sync));
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 01b6ee4..4c3ebfd 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1760,10 +1760,6 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, priv->core.arizona->regmap);
-	if (ret != 0)
-		return ret;
-
 	ret = snd_soc_add_codec_controls(codec, wm_adsp2_fw_controls, 2);
 	if (ret != 0)
 		return ret;
@@ -1874,6 +1870,8 @@ static int wm5102_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	soc_codec_dev_wm5102.regmap = arizona->regmap;
+
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5102,
 				      wm5102_dai, ARRAY_SIZE(wm5102_dai));
 }
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index cf5d828f..bfb4597 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1589,10 +1589,6 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = &codec->dapm;
 
-	ret = snd_soc_codec_set_cache_io(codec, priv->core.arizona->regmap);
-	if (ret != 0)
-		return ret;
-
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
 
@@ -1710,6 +1706,8 @@ static int wm5110_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	soc_codec_dev_wm5110.regmap = arizona->regmap;
+
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5110,
 				      wm5110_dai, ARRAY_SIZE(wm5110_dai));
 }
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 757256b..9a8f4d4 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1505,8 +1505,6 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	if (ret != 0)
 		return ret;
 
-	snd_soc_codec_set_cache_io(codec, wm8350->regmap);
-
 	/* Put the codec into reset if it wasn't already */
 	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
@@ -1625,6 +1623,10 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8350 = {
 
 static int wm8350_probe(struct platform_device *pdev)
 {
+	struct wm8350 *wm8350 = dev_get_platdata(pdev->dev);
+
+	soc_codec_dev_wm8350.regmap = wm8350->regmap;
+
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8350,
 			&wm8350_dai, 1);
 }
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 146564f..38c0a4a 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1318,8 +1318,6 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 	priv->wm8400 = wm8400;
 	priv->codec = codec;
 
-	snd_soc_codec_set_cache_io(codec, wm8400->regmap);
-
 	ret = devm_regulator_bulk_get(wm8400->dev,
 				 ARRAY_SIZE(power), &power[0]);
 	if (ret != 0) {
@@ -1378,6 +1376,10 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
 
 static int wm8400_probe(struct platform_device *pdev)
 {
+	struct wm8400 *wm8400 = dev_get_platdata(codec->dev);
+
+	soc_codec_dev_wm8400.regmap = wm8400->regmap;
+
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8400,
 			&wm8400_dai, 1);
 }
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index decc3c9..128c50c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4000,8 +4000,6 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	wm8994->hubs.codec = codec;
 
-	snd_soc_codec_set_cache_io(codec, control->regmap);
-
 	mutex_init(&wm8994->accdet_lock);
 	INIT_DELAYED_WORK(&wm8994->jackdet_bootstrap,
 			  wm1811_jackdet_bootstrap);
@@ -4458,6 +4456,8 @@ static int wm8994_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	soc_codec_dev_wm8994.regmap = wm8994->wm8994->regmap;
+
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8994,
 			wm8994_dai, ARRAY_SIZE(wm8994_dai));
 }
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 5e1a32e..8ad6537 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1051,11 +1051,6 @@ static struct snd_soc_dai_driver wm8997_dai[] = {
 static int wm8997_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm8997_priv *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	ret = snd_soc_codec_set_cache_io(codec, priv->core.arizona->regmap);
-	if (ret != 0)
-		return ret;
 
 	arizona_init_spk(codec);
 
@@ -1145,6 +1140,8 @@ static int wm8997_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	soc_codec_dev_wm8997.regmap = arizona->regmap;
+
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8997,
 				      wm8997_dai, ARRAY_SIZE(wm8997_dai));
 }
-- 
1.8.4
