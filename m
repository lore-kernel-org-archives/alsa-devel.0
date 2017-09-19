From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add handling for audio related device tree entries" to the asoc tree
Date: Tue, 19 Sep 2017 16:00:02 +0100
Message-ID: <E1duK0I-0002I9-1j@debutante>
References: <20170904154154.4395-3-ckeepax@opensource.cirrus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904154154.4395-3-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add handling for audio related device tree entries

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

>From 0a229b15d99e0a9761f9672f4ff7efeb18ce0ea1 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 4 Sep 2017 16:41:49 +0100
Subject: [PATCH] ASoC: arizona: Add handling for audio related device tree
 entries

Currently all the audio related device tree entries are handled by the
MFD code, for most parts of the Arizona driver we group the device
tree handling with the component that uses it and should do so here as
well.

Add handling in the ASoC code for the audio device tree entries, a
later patch removes the MFD side handling but there is no harm in it
being duplicated temporarily.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 136 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |   2 +
 sound/soc/codecs/cs47l24.c |   8 +++
 sound/soc/codecs/wm5102.c  |   8 +++
 sound/soc/codecs/wm5110.c  |   8 +++
 sound/soc/codecs/wm8997.c  |   8 +++
 sound/soc/codecs/wm8998.c  |   8 +++
 7 files changed, 178 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ba5f57a58219..e6967385dccb 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/gcd.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -295,8 +296,78 @@ EXPORT_SYMBOL_GPL(arizona_init_gpio);
 
 int arizona_init_common(struct arizona *arizona)
 {
+	struct arizona_pdata *pdata = &arizona->pdata;
+	unsigned int val, mask;
+	int i;
+
 	BLOCKING_INIT_NOTIFIER_HEAD(&arizona->notifier);
 
+	for (i = 0; i < ARIZONA_MAX_OUTPUT; ++i) {
+		/* Default is 0 so noop with defaults */
+		if (pdata->out_mono[i])
+			val = ARIZONA_OUT1_MONO;
+		else
+			val = 0;
+
+		regmap_update_bits(arizona->regmap,
+				   ARIZONA_OUTPUT_PATH_CONFIG_1L + (i * 8),
+				   ARIZONA_OUT1_MONO, val);
+	}
+
+	for (i = 0; i < ARIZONA_MAX_PDM_SPK; i++) {
+		if (pdata->spk_mute[i])
+			regmap_update_bits(arizona->regmap,
+					   ARIZONA_PDM_SPK1_CTRL_1 + (i * 2),
+					   ARIZONA_SPK1_MUTE_ENDIAN_MASK |
+					   ARIZONA_SPK1_MUTE_SEQ1_MASK,
+					   pdata->spk_mute[i]);
+
+		if (pdata->spk_fmt[i])
+			regmap_update_bits(arizona->regmap,
+					   ARIZONA_PDM_SPK1_CTRL_2 + (i * 2),
+					   ARIZONA_SPK1_FMT_MASK,
+					   pdata->spk_fmt[i]);
+	}
+
+	for (i = 0; i < ARIZONA_MAX_INPUT; i++) {
+		/* Default for both is 0 so noop with defaults */
+		val = pdata->dmic_ref[i] << ARIZONA_IN1_DMIC_SUP_SHIFT;
+		if (pdata->inmode[i] & ARIZONA_INMODE_DMIC)
+			val |= 1 << ARIZONA_IN1_MODE_SHIFT;
+
+		switch (arizona->type) {
+		case WM8998:
+		case WM1814:
+			regmap_update_bits(arizona->regmap,
+				ARIZONA_ADC_DIGITAL_VOLUME_1L + (i * 8),
+				ARIZONA_IN1L_SRC_SE_MASK,
+				(pdata->inmode[i] & ARIZONA_INMODE_SE)
+					<< ARIZONA_IN1L_SRC_SE_SHIFT);
+
+			regmap_update_bits(arizona->regmap,
+				ARIZONA_ADC_DIGITAL_VOLUME_1R + (i * 8),
+				ARIZONA_IN1R_SRC_SE_MASK,
+				(pdata->inmode[i] & ARIZONA_INMODE_SE)
+					<< ARIZONA_IN1R_SRC_SE_SHIFT);
+
+			mask = ARIZONA_IN1_DMIC_SUP_MASK |
+			       ARIZONA_IN1_MODE_MASK;
+			break;
+		default:
+			if (pdata->inmode[i] & ARIZONA_INMODE_SE)
+				val |= 1 << ARIZONA_IN1_SINGLE_ENDED_SHIFT;
+
+			mask = ARIZONA_IN1_DMIC_SUP_MASK |
+			       ARIZONA_IN1_MODE_MASK |
+			       ARIZONA_IN1_SINGLE_ENDED_MASK;
+			break;
+		}
+
+		regmap_update_bits(arizona->regmap,
+				   ARIZONA_IN1L_CONTROL + (i * 8),
+				   mask, val);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(arizona_init_common);
@@ -2692,6 +2763,71 @@ int arizona_lhpf_coeff_put(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(arizona_lhpf_coeff_put);
 
+int arizona_of_get_audio_pdata(struct arizona *arizona)
+{
+	struct arizona_pdata *pdata = &arizona->pdata;
+	struct device_node *np = arizona->dev->of_node;
+	struct property *prop;
+	const __be32 *cur;
+	u32 val;
+	u32 pdm_val[ARIZONA_MAX_PDM_SPK];
+	int ret;
+	int count = 0;
+
+	count = 0;
+	of_property_for_each_u32(np, "wlf,inmode", prop, cur, val) {
+		if (count == ARRAY_SIZE(pdata->inmode))
+			break;
+
+		pdata->inmode[count] = val;
+		count++;
+	}
+
+	count = 0;
+	of_property_for_each_u32(np, "wlf,dmic-ref", prop, cur, val) {
+		if (count == ARRAY_SIZE(pdata->dmic_ref))
+			break;
+
+		pdata->dmic_ref[count] = val;
+		count++;
+	}
+
+	count = 0;
+	of_property_for_each_u32(np, "wlf,out-mono", prop, cur, val) {
+		if (count == ARRAY_SIZE(pdata->out_mono))
+			break;
+
+		pdata->out_mono[count] = !!val;
+		count++;
+	}
+
+	count = 0;
+	of_property_for_each_u32(np, "wlf,max-channels-clocked", prop, cur, val) {
+		if (count == ARRAY_SIZE(pdata->max_channels_clocked))
+			break;
+
+		pdata->max_channels_clocked[count] = val;
+		count++;
+	}
+
+	ret = of_property_read_u32_array(np, "wlf,spk-fmt",
+					 pdm_val, ARRAY_SIZE(pdm_val));
+
+	if (ret >= 0)
+		for (count = 0; count < ARRAY_SIZE(pdata->spk_fmt); ++count)
+			pdata->spk_fmt[count] = pdm_val[count];
+
+	ret = of_property_read_u32_array(np, "wlf,spk-mute",
+					 pdm_val, ARRAY_SIZE(pdm_val));
+
+	if (ret >= 0)
+		for (count = 0; count < ARRAY_SIZE(pdata->spk_mute); ++count)
+			pdata->spk_mute[count] = pdm_val[count];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_of_get_audio_pdata);
+
 MODULE_DESCRIPTION("ASoC Wolfson Arizona class device support");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 292073ca3bd9..2d198fb2ce97 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -351,4 +351,6 @@ static inline int arizona_unregister_notifier(struct snd_soc_codec *codec,
 	return blocking_notifier_chain_unregister(&arizona->notifier, nb);
 }
 
+int arizona_of_get_audio_pdata(struct arizona *arizona);
+
 #endif
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index fdcc7318993b..0fe7d7a87ff3 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1229,6 +1229,14 @@ static int cs47l24_probe(struct platform_device *pdev)
 	if (!cs47l24)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (!dev_get_platdata(arizona->dev)) {
+			ret = arizona_of_get_audio_pdata(arizona);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	platform_set_drvdata(pdev, cs47l24);
 
 	cs47l24->core.arizona = arizona;
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 8354bdf7fc15..5a917dd73f32 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2042,6 +2042,14 @@ static int wm5102_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, wm5102);
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (!dev_get_platdata(arizona->dev)) {
+			ret = arizona_of_get_audio_pdata(arizona);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	mutex_init(&arizona->dac_comp_lock);
 
 	wm5102->core.arizona = arizona;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 0437df60be77..ba1e90ca8be4 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2397,6 +2397,14 @@ static int wm5110_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, wm5110);
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (!dev_get_platdata(arizona->dev)) {
+			ret = arizona_of_get_audio_pdata(arizona);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	wm5110->core.arizona = arizona;
 	wm5110->core.num_inputs = 8;
 
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 91c3c3e052d1..c5aef9ecdecc 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1134,6 +1134,14 @@ static int wm8997_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, wm8997);
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (!dev_get_platdata(arizona->dev)) {
+			ret = arizona_of_get_audio_pdata(arizona);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	wm8997->core.arizona = arizona;
 	wm8997->core.num_inputs = 4;
 
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 27a8e1e75f28..c59caaa75ba0 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1398,6 +1398,14 @@ static int wm8998_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, wm8998);
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (!dev_get_platdata(arizona->dev)) {
+			ret = arizona_of_get_audio_pdata(arizona);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	wm8998->core.arizona = arizona;
 	wm8998->core.num_inputs = 3;	/* IN1L, IN1R, IN2 */
 
-- 
2.14.1
