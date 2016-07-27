From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ASoC: rt5659: Add mclk controls
Date: Wed, 27 Jul 2016 16:02:48 -0700
Message-ID: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The codec driver should control the mclk. So this patch adds this support.

Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/rt5659.txt |  3 +++
 sound/soc/codecs/rt5659.c                          | 24 ++++++++++++++++++++++
 sound/soc/codecs/rt5659.h                          |  1 +
 3 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5659.txt b/Documentation/devicetree/bindings/sound/rt5659.txt
index 5f79e7f..1766e05 100644
--- a/Documentation/devicetree/bindings/sound/rt5659.txt
+++ b/Documentation/devicetree/bindings/sound/rt5659.txt
@@ -12,6 +12,9 @@ Required properties:
 
 Optional properties:
 
+- clocks: The phandle of the master clock to the CODEC
+- clock-names: Should be "mclk"
+
 - realtek,in1-differential
 - realtek,in3-differential
 - realtek,in4-differential
diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 1b30914..d9ead96 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -3565,7 +3566,9 @@ static int rt5659_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 static int rt5659_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
@@ -3582,6 +3585,17 @@ static int rt5659_set_bias_level(struct snd_soc_codec *codec,
 			RT5659_PWR_FV1 | RT5659_PWR_FV2);
 		break;
 
+	case SND_SOC_BIAS_STANDBY:
+		if (dapm->bias_level == SND_SOC_BIAS_OFF) {
+			ret = clk_prepare_enable(rt5659->mclk);
+			if (ret) {
+				dev_err(codec->dev,
+					"failed to enable MCLK: %d\n", ret);
+				return ret;
+			}
+		}
+		break;
+
 	case SND_SOC_BIAS_OFF:
 		regmap_update_bits(rt5659->regmap, RT5659_PWR_DIG_1,
 			RT5659_PWR_LDO, 0);
@@ -3591,6 +3605,7 @@ static int rt5659_set_bias_level(struct snd_soc_codec *codec,
 			RT5659_PWR_MB | RT5659_PWR_VREF2);
 		regmap_update_bits(rt5659->regmap, RT5659_DIG_MISC,
 			RT5659_DIG_GATE_CTRL, 0);
+		clk_disable_unprepare(rt5659->mclk);
 		break;
 
 	default:
@@ -4020,6 +4035,15 @@ static int rt5659_i2c_probe(struct i2c_client *i2c,
 
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
 
+	/* Check if MCLK provided */
+	rt5659->mclk = devm_clk_get(&i2c->dev, "mclk");
+	if (IS_ERR(rt5659->mclk)) {
+		if (PTR_ERR(rt5659->mclk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		/* Otherwise mark the mclk pointer to NULL */
+		rt5659->mclk = NULL;
+	}
+
 	rt5659_calibrate(rt5659);
 
 	/* line in diff mode*/
diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index d31c9e5..d69b0eb 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -1796,6 +1796,7 @@ struct rt5659_priv {
 	struct gpio_desc *gpiod_reset;
 	struct snd_soc_jack *hs_jack;
 	struct delayed_work jack_detect_work;
+	struct clk *mclk;
 
 	int sysclk;
 	int sysclk_src;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
