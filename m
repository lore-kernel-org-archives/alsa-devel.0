From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ASoC: wm8962: Convert to runtime PM for
	bias off management
Date: Thu, 16 Feb 2012 22:30:09 -0800
Message-ID: <1329460209-30495-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329460209-30495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B3DC103A62
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 07:30:48 +0100 (CET)
In-Reply-To: <1329460209-30495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensourc.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This allows userspace control of final power off, allowing policy decisions
for register configuration retention.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |  113 ++++++++++++++++++++++++++++----------------
 1 files changed, 72 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index a328b7b..2f06886 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -20,6 +20,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -2479,9 +2480,6 @@ static void wm8962_configure_bclk(struct snd_soc_codec *codec)
 static int wm8962_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
 	if (level == codec->dapm.bias_level)
 		return 0;
 
@@ -2498,51 +2496,15 @@ static int wm8962_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			ret = regulator_bulk_enable(ARRAY_SIZE(wm8962->supplies),
-						    wm8962->supplies);
-			if (ret != 0) {
-				dev_err(codec->dev,
-					"Failed to enable supplies: %d\n",
-					ret);
-				return ret;
-			}
-
-			regcache_cache_only(wm8962->regmap, false);
-			regcache_sync(wm8962->regmap);
-
-			snd_soc_update_bits(codec, WM8962_ANTI_POP,
-					    WM8962_STARTUP_BIAS_ENA |
-					    WM8962_VMID_BUF_ENA,
-					    WM8962_STARTUP_BIAS_ENA |
-					    WM8962_VMID_BUF_ENA);
-
-			/* Bias enable at 2*50k for ramp */
-			snd_soc_update_bits(codec, WM8962_PWR_MGMT_1,
-					    WM8962_VMID_SEL_MASK |
-					    WM8962_BIAS_ENA,
-					    WM8962_BIAS_ENA | 0x180);
-
-			msleep(5);
-		}
-
 		/* VMID 2*250k */
 		snd_soc_update_bits(codec, WM8962_PWR_MGMT_1,
 				    WM8962_VMID_SEL_MASK, 0x100);
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, WM8962_PWR_MGMT_1,
-				    WM8962_VMID_SEL_MASK | WM8962_BIAS_ENA, 0);
-
-		snd_soc_update_bits(codec, WM8962_ANTI_POP,
-				    WM8962_STARTUP_BIAS_ENA |
-				    WM8962_VMID_BUF_ENA, 0);
-
-		regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies),
-				       wm8962->supplies);
 		break;
 	}
+
 	codec->dapm.bias_level = level;
 	return 0;
 }
@@ -2844,6 +2806,8 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 		snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
 				    WM8962_FLL_ENA, 0);
 
+		pm_runtime_put(codec->dev);
+
 		return 0;
 	}
 
@@ -2892,6 +2856,7 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 
 	try_wait_for_completion(&wm8962->fll_lock);
 
+	pm_runtime_get_sync(codec->dev);
 
 	snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
 			    WM8962_FLL_FRAC | WM8962_FLL_REFCLK_SRC_MASK |
@@ -3714,7 +3679,9 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 				ret);
 	}
 
-	regcache_cache_only(wm8962->regmap, true);
+	pm_runtime_set_active(&i2c->dev);
+	pm_runtime_enable(&i2c->dev);
+	pm_request_idle(&i2c->dev);
 
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8962, &wm8962_dai, 1);
@@ -3746,6 +3713,69 @@ static __devexit int wm8962_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int wm8962_runtime_resume(struct device *dev)
+{
+	struct wm8962_priv *wm8962 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8962->supplies),
+				    wm8962->supplies);
+	if (ret != 0) {
+		dev_err(dev,
+			"Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	regcache_cache_only(wm8962->regmap, false);
+	regcache_sync(wm8962->regmap);
+
+	regmap_update_bits(wm8962->regmap, WM8962_ANTI_POP,
+			   WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA,
+			   WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA);
+
+	/* Bias enable at 2*50k for ramp */
+	regmap_update_bits(wm8962->regmap, WM8962_PWR_MGMT_1,
+			   WM8962_VMID_SEL_MASK | WM8962_BIAS_ENA,
+			   WM8962_BIAS_ENA | 0x180);
+
+	msleep(5);
+
+	/* VMID back to 2x250k for standby */
+	regmap_update_bits(wm8962->regmap, WM8962_PWR_MGMT_1,
+			   WM8962_VMID_SEL_MASK, 0x100);
+
+	dev_crit(dev, "RESUME\n");
+
+	return 0;
+}
+
+static int wm8962_runtime_suspend(struct device *dev)
+{
+	struct wm8962_priv *wm8962 = dev_get_drvdata(dev);
+
+	dev_crit(dev, "SUSPEND\n");
+
+	regmap_update_bits(wm8962->regmap, WM8962_PWR_MGMT_1,
+			   WM8962_VMID_SEL_MASK | WM8962_BIAS_ENA, 0);
+
+	regmap_update_bits(wm8962->regmap, WM8962_ANTI_POP,
+			   WM8962_STARTUP_BIAS_ENA |
+			   WM8962_VMID_BUF_ENA, 0);
+
+	regcache_cache_only(wm8962->regmap, true);
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies),
+			       wm8962->supplies);
+
+	return 0;
+}
+#endif
+
+static struct dev_pm_ops wm8962_pm = {
+	SET_RUNTIME_PM_OPS(wm8962_runtime_suspend, wm8962_runtime_resume, NULL)
+};
+
 static const struct i2c_device_id wm8962_i2c_id[] = {
 	{ "wm8962", 0 },
 	{ }
@@ -3756,6 +3786,7 @@ static struct i2c_driver wm8962_i2c_driver = {
 	.driver = {
 		.name = "wm8962",
 		.owner = THIS_MODULE,
+		.pm = &wm8962_pm,
 	},
 	.probe =    wm8962_i2c_probe,
 	.remove =   __devexit_p(wm8962_i2c_remove),
-- 
1.7.9.rc1
