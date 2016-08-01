From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: Add mclk controls" to the asoc tree
Date: Mon, 01 Aug 2016 18:07:04 +0100
Message-ID: <E1bUGgC-0006Ki-PA@debutante>
References: <1469743036-20034-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469743036-20034-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>broonie@kernel.org, mark.rutland@arm.com, oder_chiou@realtek.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5659: Add mclk controls

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

>From 6cf925e4ed8124c1fedde2451ba2b7ab8f34199b Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Thu, 28 Jul 2016 14:57:16 -0700
Subject: [PATCH] ASoC: rt5659: Add mclk controls

The codec driver should control the mclk. So this patch adds this support.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5659.txt |  3 +++
 sound/soc/codecs/rt5659.c                          | 24 ++++++++++++++++++++++
 sound/soc/codecs/rt5659.h                          |  1 +
 3 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5659.txt b/Documentation/devicetree/bindings/sound/rt5659.txt
index 5f79e7fde032..1766e0543fc5 100644
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
index 1b30914c2d91..42c183f97c31 100644
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
+		if (PTR_ERR(rt5659->mclk) != -ENOENT)
+			return PTR_ERR(rt5659->mclk);
+		/* Otherwise mark the mclk pointer to NULL */
+		rt5659->mclk = NULL;
+	}
+
 	rt5659_calibrate(rt5659);
 
 	/* line in diff mode*/
diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index d31c9e5bcec8..d69b0eb5a334 100644
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
2.8.1
