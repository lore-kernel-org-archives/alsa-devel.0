From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 1/2] ASoC: rt5651: Enable jack detection on JD1_1
Date: Thu, 19 Oct 2017 12:03:22 +0100
Message-ID: <20171019110323.23751-2-carlo@caione.org>
References: <20171019110323.23751-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019110323.23751-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, albertchen@realtek.com, edgar_shen@realtek.com
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

Enable jack detection or the RT5651 codec on the JD1_1 pin.
The codec has no means to detect the type of the jack connected so we
assume that the jack is always an headset jack.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 include/sound/rt5651.h    |  7 ++++
 sound/soc/codecs/rt5651.c | 91 +++++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt5651.h |  3 ++
 3 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/include/sound/rt5651.h b/include/sound/rt5651.h
index d35de758dfb5..c563383149c4 100644
--- a/include/sound/rt5651.h
+++ b/include/sound/rt5651.h
@@ -11,11 +11,18 @@
 #ifndef __LINUX_SND_RT5651_H
 #define __LINUX_SND_RT5651_H
 
+enum rt5651_jd_src {
+	RT5651_JD_NULL,
+	RT5651_JD1_1,
+};
+
 struct rt5651_platform_data {
 	/* IN2 can optionally be differential */
 	bool in2_diff;
 
 	bool dmic_en;
+
+	enum rt5651_jd_src jd_src;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 28f7210cec91..9bc7f31af1a4 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -26,6 +26,7 @@
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
+#include <sound/jack.h>
 
 #include "rl6231.h"
 #include "rt5651.h"
@@ -880,6 +881,9 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("PLL1", RT5651_PWR_ANLG2,
 			RT5651_PWR_PLL_BIT, 0, NULL, 0),
 	/* Input Side */
+	SND_SOC_DAPM_SUPPLY("JD Power", RT5651_PWR_ANLG2,
+		RT5651_PWM_JD_M_BIT, 0, NULL, 0),
+
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("LDO", RT5651_PWR_ANLG1,
 			RT5651_PWR_LDO_BIT, 0, NULL, 0),
@@ -1528,6 +1532,8 @@ static int rt5651_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 static int rt5651_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
 		if (SND_SOC_BIAS_STANDBY == snd_soc_codec_get_bias_level(codec)) {
@@ -1556,8 +1562,13 @@ static int rt5651_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, RT5651_PWR_DIG2, 0x0000);
 		snd_soc_write(codec, RT5651_PWR_VOL, 0x0000);
 		snd_soc_write(codec, RT5651_PWR_MIXER, 0x0000);
-		snd_soc_write(codec, RT5651_PWR_ANLG1, 0x0000);
-		snd_soc_write(codec, RT5651_PWR_ANLG2, 0x0000);
+		if (rt5651->pdata.jd_src) {
+			snd_soc_write(codec, RT5651_PWR_ANLG2, 0x0204);
+			snd_soc_write(codec, RT5651_PWR_ANLG1, 0x0002);
+		} else {
+			snd_soc_write(codec, RT5651_PWR_ANLG1, 0x0000);
+			snd_soc_write(codec, RT5651_PWR_ANLG2, 0x0000);
+		}
 		break;
 
 	default:
@@ -1570,6 +1581,7 @@ static int rt5651_set_bias_level(struct snd_soc_codec *codec,
 static int rt5651_probe(struct snd_soc_codec *codec)
 {
 	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 
 	rt5651->codec = codec;
 
@@ -1585,6 +1597,13 @@ static int rt5651_probe(struct snd_soc_codec *codec)
 
 	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
+	if (rt5651->pdata.jd_src) {
+		snd_soc_dapm_force_enable_pin(dapm, "JD Power");
+		snd_soc_dapm_force_enable_pin(dapm, "PLL1");
+		snd_soc_dapm_force_enable_pin(dapm, "LDO");
+		snd_soc_dapm_sync(dapm);
+	}
+
 	return 0;
 }
 
@@ -1728,6 +1747,42 @@ static int rt5651_parse_dt(struct rt5651_priv *rt5651, struct device_node *np)
 	return 0;
 }
 
+static irqreturn_t rt5651_irq(int irq, void *data)
+{
+	struct rt5651_priv *rt5651 = data;
+	int val, report = 0;
+
+	if (!rt5651->codec)
+		return IRQ_HANDLED;
+
+	switch (rt5651->pdata.jd_src) {
+	case RT5651_JD1_1:
+		val = snd_soc_read(rt5651->codec, RT5651_INT_IRQ_ST) & 0x1000;
+		break;
+	default:
+		return IRQ_HANDLED;
+	}
+
+	if (!val)
+		report = SND_JACK_HEADSET;
+
+	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
+
+	return IRQ_HANDLED;
+}
+
+int rt5651_set_jack_detect(struct snd_soc_codec *codec,
+			   struct snd_soc_jack *hp_jack)
+{
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+
+	rt5651->hp_jack = hp_jack;
+	rt5651_irq(0, rt5651);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
+
 static int rt5651_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -1779,6 +1834,38 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 
 	rt5651->hp_mute = 1;
 
+	switch (rt5651->pdata.jd_src) {
+	case RT5651_JD1_1:
+		/* IRQ output on GPIO1 */
+		regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
+				   RT5651_GP1_PIN_MASK, RT5651_GP1_PIN_IRQ);
+
+		regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
+				   RT5651_JD_TRG_SEL_MASK,
+				   RT5651_JD_TRG_SEL_JD1_1);
+		regmap_update_bits(rt5651->regmap, RT5651_IRQ_CTRL1,
+				   RT5651_JD1_1_IRQ_EN,
+				   RT5651_JD1_1_IRQ_EN);
+		break;
+	case RT5651_JD_NULL:
+		break;
+	default:
+		dev_warn(&i2c->dev, "Currently only JD1_1 is supported\n");
+		break;
+	}
+
+	if (i2c->irq) {
+		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
+						rt5651_irq,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT, "rt5651", rt5651);
+		if (ret) {
+			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5651,
 				rt5651_dai, ARRAY_SIZE(rt5651_dai));
 
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 1bd33cfa6411..3c135f1869d4 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2062,6 +2062,7 @@ struct rt5651_priv {
 	struct snd_soc_codec *codec;
 	struct rt5651_platform_data pdata;
 	struct regmap *regmap;
+	struct snd_soc_jack *hp_jack;
 
 	int sysclk;
 	int sysclk_src;
@@ -2077,4 +2078,6 @@ struct rt5651_priv {
 	bool hp_mute;
 };
 
+int rt5651_set_jack_detect(struct snd_soc_codec *codec,
+			   struct snd_soc_jack *hp_jack);
 #endif /* __RT5651_H__ */
-- 
2.14.2
