From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH v2 4/4] ASoC: wm8804: Enable runtime PM
Date: Tue,  7 Apr 2015 12:55:10 +0100
Message-ID: <1428407710-26152-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428407710-26152-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428407710-26152-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, info-Ht5PubfIbSajfpyLsbbDOw@public.gmane.org, sapthagiri.baratam-sjhevXS25z0S+FvcfC7Uqw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Currently both the oscillator and the PLL are powered up in
set_bias_level. This can be problematic when using output clocks from
the wm8804 for other devices. The snd_soc_codec_set_pll API defines that
a clock should be available once the call returns, however, with all the
clocking controlled in set_bias_level this is not currently the case.

This patch enables pm_runtime for the wm8804, enabling both the
regulators and the oscillator when the chip resumes, and enabling the
PLL in the snd_soc_codec_set_pll call. Naturally the enabling the PLL
will also cause the chip to resume.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 sound/soc/codecs/wm8804-i2c.c |    1 +
 sound/soc/codecs/wm8804-spi.c |    1 +
 sound/soc/codecs/wm8804.c     |  109 ++++++++++++++++++++++-------------------
 sound/soc/codecs/wm8804.h     |    1 +
 4 files changed, 62 insertions(+), 50 deletions(-)

diff --git a/sound/soc/codecs/wm8804-i2c.c b/sound/soc/codecs/wm8804-i2c.c
index 5bd4af2..6596f5f 100644
--- a/sound/soc/codecs/wm8804-i2c.c
+++ b/sound/soc/codecs/wm8804-i2c.c
@@ -50,6 +50,7 @@ static struct i2c_driver wm8804_i2c_driver = {
 	.driver = {
 		.name = "wm8804",
 		.owner = THIS_MODULE,
+		.pm = &wm8804_pm,
 		.of_match_table = wm8804_of_match,
 	},
 	.probe = wm8804_i2c_probe,
diff --git a/sound/soc/codecs/wm8804-spi.c b/sound/soc/codecs/wm8804-spi.c
index 287e11e..407a3cf 100644
--- a/sound/soc/codecs/wm8804-spi.c
+++ b/sound/soc/codecs/wm8804-spi.c
@@ -43,6 +43,7 @@ static struct spi_driver wm8804_spi_driver = {
 	.driver = {
 		.name = "wm8804",
 		.owner = THIS_MODULE,
+		.pm = &wm8804_pm,
 		.of_match_table = wm8804_of_match,
 	},
 	.probe = wm8804_spi_probe,
diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index cff34be..1e403f6 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -59,6 +60,7 @@ static const struct reg_default wm8804_reg_defaults[] = {
 };
 
 struct wm8804_priv {
+	struct device *dev;
 	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8804_NUM_SUPPLIES];
 	struct notifier_block disable_nb[WM8804_NUM_SUPPLIES];
@@ -403,19 +405,19 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
 			  int source, unsigned int freq_in,
 			  unsigned int freq_out)
 {
-	struct snd_soc_codec *codec;
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8804_priv *wm8804 = snd_soc_codec_get_drvdata(codec);
+	bool change;
 
-	codec = dai->codec;
 	if (!freq_in || !freq_out) {
 		/* disable the PLL */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x1, 0x1);
-		return 0;
+		regmap_update_bits_check(wm8804->regmap, WM8804_PWRDN,
+					 0x1, 0x1, &change);
+		if (change)
+			pm_runtime_put(wm8804->dev);
 	} else {
 		int ret;
 		struct pll_div pll_div;
-		struct wm8804_priv *wm8804;
-
-		wm8804 = snd_soc_codec_get_drvdata(codec);
 
 		ret = pll_factors(&pll_div, freq_out, freq_in,
 				  wm8804->mclk_div);
@@ -423,7 +425,10 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
 			return ret;
 
 		/* power down the PLL before reprogramming it */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x1, 0x1);
+		regmap_update_bits_check(wm8804->regmap, WM8804_PWRDN,
+					 0x1, 0x1, &change);
+		if (!change)
+			pm_runtime_get_sync(wm8804->dev);
 
 		/* set PLLN and PRESCALE */
 		snd_soc_update_bits(codec, WM8804_PLL4, 0xf | 0x10,
@@ -501,47 +506,6 @@ static int wm8804_set_clkdiv(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int wm8804_set_bias_level(struct snd_soc_codec *codec,
-				 enum snd_soc_bias_level level)
-{
-	int ret;
-	struct wm8804_priv *wm8804;
-
-	wm8804 = snd_soc_codec_get_drvdata(codec);
-	switch (level) {
-	case SND_SOC_BIAS_ON:
-		break;
-	case SND_SOC_BIAS_PREPARE:
-		/* power up the OSC and the PLL */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x9, 0);
-		break;
-	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			ret = regulator_bulk_enable(ARRAY_SIZE(wm8804->supplies),
-						    wm8804->supplies);
-			if (ret) {
-				dev_err(codec->dev,
-					"Failed to enable supplies: %d\n",
-					ret);
-				return ret;
-			}
-			regcache_sync(wm8804->regmap);
-		}
-		/* power down the OSC and the PLL */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x9, 0x9);
-		break;
-	case SND_SOC_BIAS_OFF:
-		/* power down the OSC and the PLL */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x9, 0x9);
-		regulator_bulk_disable(ARRAY_SIZE(wm8804->supplies),
-				       wm8804->supplies);
-		break;
-	}
-
-	codec->dapm.bias_level = level;
-	return 0;
-}
-
 static const struct snd_soc_dai_ops wm8804_dai_ops = {
 	.hw_params = wm8804_hw_params,
 	.set_fmt = wm8804_set_fmt,
@@ -579,7 +543,6 @@ static struct snd_soc_dai_driver wm8804_dai = {
 };
 
 static const struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
-	.set_bias_level = wm8804_set_bias_level,
 	.idle_bias_off = true,
 
 	.dapm_widgets = wm8804_dapm_widgets,
@@ -613,6 +576,7 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 
 	dev_set_drvdata(dev, wm8804);
 
+	wm8804->dev = dev;
 	wm8804->regmap = regmap;
 
 	wm8804->reset = devm_gpiod_get_optional(dev, "wlf,reset",
@@ -703,6 +667,10 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 		goto err_reg_enable;
 	}
 
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
 	return 0;
 
 err_reg_enable:
@@ -713,10 +681,51 @@ EXPORT_SYMBOL_GPL(wm8804_probe);
 
 void wm8804_remove(struct device *dev)
 {
+	pm_runtime_disable(dev);
 	snd_soc_unregister_codec(dev);
 }
 EXPORT_SYMBOL_GPL(wm8804_remove);
 
+#if IS_ENABLED(CONFIG_PM)
+static int wm8804_runtime_resume(struct device *dev)
+{
+	struct wm8804_priv *wm8804 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8804->supplies),
+				    wm8804->supplies);
+	if (ret) {
+		dev_err(wm8804->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	regcache_sync(wm8804->regmap);
+
+	/* Power up OSCCLK */
+	regmap_update_bits(wm8804->regmap, WM8804_PWRDN, 0x8, 0x0);
+
+	return 0;
+}
+
+static int wm8804_runtime_suspend(struct device *dev)
+{
+	struct wm8804_priv *wm8804 = dev_get_drvdata(dev);
+
+	/* Power down OSCCLK */
+	regmap_update_bits(wm8804->regmap, WM8804_PWRDN, 0x8, 0x8);
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8804->supplies),
+			       wm8804->supplies);
+
+	return 0;
+}
+#endif
+
+const struct dev_pm_ops wm8804_pm = {
+	SET_RUNTIME_PM_OPS(wm8804_runtime_suspend, wm8804_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_GPL(wm8804_pm);
+
 MODULE_DESCRIPTION("ASoC WM8804 driver");
 MODULE_AUTHOR("Dimitris Papastamos <dp-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8804.h b/sound/soc/codecs/wm8804.h
index a39a256..aa72fa6 100644
--- a/sound/soc/codecs/wm8804.h
+++ b/sound/soc/codecs/wm8804.h
@@ -65,6 +65,7 @@
 #define WM8804_MCLKDIV_128FS			1
 
 extern const struct regmap_config wm8804_regmap_config;
+extern const struct dev_pm_ops wm8804_pm;
 
 int wm8804_probe(struct device *dev, struct regmap *regmap);
 void wm8804_remove(struct device *dev);
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
