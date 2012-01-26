From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5100: Use pm_runtime for powerdown
	managment
Date: Thu, 26 Jan 2012 18:40:02 +0000
Message-ID: <1327603202-9337-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95F8610389C
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 19:40:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Using pm_runtime to decide if the device should go into full power down
has the dual advantage of allowing easier integration with non-DAPM
reasons to power on the device (like the FLL) and allowing userspace to
control the final power down which is useful for tuning retention of
DSP firmware.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |  116 ++++++++++++++++++++++-----------------------
 1 files changed, 56 insertions(+), 60 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 39de946..c6c3821 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -18,6 +18,7 @@
 #include <linux/gcd.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/fixed.h>
 #include <linux/slab.h>
@@ -1261,54 +1262,6 @@ static const __devinitdata struct reg_default wm5100_reva_patches[] = {
 	{ WM5100_AUDIO_IF_3_19, 1 },
 };
 
-static int wm5100_set_bias_level(struct snd_soc_codec *codec,
-				 enum snd_soc_bias_level level)
-{
-	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	switch (level) {
-	case SND_SOC_BIAS_ON:
-		break;
-
-	case SND_SOC_BIAS_PREPARE:
-		break;
-
-	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			ret = regulator_bulk_enable(ARRAY_SIZE(wm5100->core_supplies),
-						    wm5100->core_supplies);
-			if (ret != 0) {
-				dev_err(codec->dev,
-					"Failed to enable supplies: %d\n",
-					ret);
-				return ret;
-			}
-
-			if (wm5100->pdata.ldo_ena) {
-				gpio_set_value_cansleep(wm5100->pdata.ldo_ena,
-							1);
-				msleep(2);
-			}
-
-			regcache_cache_only(wm5100->regmap, false);
-			regcache_sync(wm5100->regmap);
-		}
-		break;
-
-	case SND_SOC_BIAS_OFF:
-		regcache_cache_only(wm5100->regmap, true);
-		if (wm5100->pdata.ldo_ena)
-			gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
-		regulator_bulk_disable(ARRAY_SIZE(wm5100->core_supplies),
-				       wm5100->core_supplies);
-		break;
-	}
-	codec->dapm.bias_level = level;
-
-	return 0;
-}
-
 static int wm5100_dai_to_base(struct snd_soc_dai *dai)
 {
 	switch (dai->id) {
@@ -1836,6 +1789,8 @@ static int wm5100_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 
 	if (!Fout) {
 		dev_dbg(codec->dev, "FLL%d disabled", fll_id);
+		if (fll->fout)
+			pm_runtime_put(codec->dev);
 		fll->fout = 0;
 		snd_soc_update_bits(codec, base + 1, WM5100_FLL1_ENA, 0);
 		return 0;
@@ -1880,6 +1835,8 @@ static int wm5100_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	/* Clear any pending completions */
 	try_wait_for_completion(&fll->lock);
 
+	pm_runtime_get_sync(codec->dev);
+
 	snd_soc_update_bits(codec, base + 1, WM5100_FLL1_ENA, WM5100_FLL1_ENA);
 
 	if (i2c->irq)
@@ -1914,6 +1871,7 @@ static int wm5100_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	}
 	if (i == timeout) {
 		dev_err(codec->dev, "FLL%d lock timed out\n", fll_id);
+		pm_runtime_put(codec->dev);
 		return -ETIMEDOUT;
 	}
 
@@ -2377,9 +2335,6 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	regcache_cache_only(wm5100->regmap, true);
-
-
 	for (i = 0; i < ARRAY_SIZE(wm5100_dig_vu); i++)
 		snd_soc_update_bits(codec, wm5100_dig_vu[i], WM5100_OUT_VU,
 				    WM5100_OUT_VU);
@@ -2405,14 +2360,6 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	/* We'll get woken up again when the system has something useful
-	 * for us to do.
-	 */
-	if (wm5100->pdata.ldo_ena)
-		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
-	regulator_bulk_disable(ARRAY_SIZE(wm5100->core_supplies),
-			       wm5100->core_supplies);
-
 	return 0;
 
 err_gpio:
@@ -2444,7 +2391,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm5100 = {
 
 	.set_sysclk = wm5100_set_sysclk,
 	.set_pll = wm5100_set_fll,
-	.set_bias_level = wm5100_set_bias_level,
 	.idle_bias_off = 1,
 	.reg_cache_size = WM5100_MAX_REGISTER,
 	.volatile_register = wm5100_soc_volatile,
@@ -2661,6 +2607,10 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
+	pm_runtime_set_active(&i2c->dev);
+	pm_runtime_enable(&i2c->dev);
+	pm_request_idle(&i2c->dev);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm5100, wm5100_dai,
 				     ARRAY_SIZE(wm5100_dai));
@@ -2714,6 +2664,51 @@ static __devexit int wm5100_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int wm5100_runtime_suspend(struct device *dev)
+{
+	struct wm5100_priv *wm5100 = dev_get_drvdata(dev);
+
+	regcache_cache_only(wm5100->regmap, true);
+	regcache_mark_dirty(wm5100->regmap);
+	if (wm5100->pdata.ldo_ena)
+		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
+	regulator_bulk_disable(ARRAY_SIZE(wm5100->core_supplies),
+			       wm5100->core_supplies);
+
+	return 0;
+}
+
+static int wm5100_runtime_resume(struct device *dev)
+{
+	struct wm5100_priv *wm5100 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm5100->core_supplies),
+				    wm5100->core_supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable supplies: %d\n",
+			ret);
+		return ret;
+	}
+
+	if (wm5100->pdata.ldo_ena) {
+		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 1);
+		msleep(2);
+	}
+
+	regcache_cache_only(wm5100->regmap, false);
+	regcache_sync(wm5100->regmap);
+
+	return 0;
+}
+#endif
+
+static struct dev_pm_ops wm5100_pm = {
+	SET_RUNTIME_PM_OPS(wm5100_runtime_suspend, wm5100_runtime_resume,
+			   NULL)
+};
+
 static const struct i2c_device_id wm5100_i2c_id[] = {
 	{ "wm5100", 0 },
 	{ }
@@ -2724,6 +2719,7 @@ static struct i2c_driver wm5100_i2c_driver = {
 	.driver = {
 		.name = "wm5100",
 		.owner = THIS_MODULE,
+		.pm = &wm5100_pm,
 	},
 	.probe =    wm5100_i2c_probe,
 	.remove =   __devexit_p(wm5100_i2c_remove),
-- 
1.7.9.rc1
