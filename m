From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 01/11] ASoC: rt5651: Avoid duplicating DMI
	quirks between codec and machine driver
Date: Tue, 20 Feb 2018 23:15:01 +0100
Message-ID: <20180220221511.22861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 57B0E2671A9
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 23:15:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Instead of duplicating the DMI quirks between the codec and machine driver,
add a rt5651_set_pdata() codec private function which the machine driver
can use to pass in pdata.

This means we need to delay setting up the jack-detect registers, so this
commits moves this to rt5651_set_jack() code. Note this is actually a good
thing as before we would register the irq handler before rt5651->hp_jack
was assigned, leading to a potential NULL deref if the jack_detect work
runs before the machine driver has called set_jack.

While at it also move over to the standard snd_soc_codec_set_jack()
function instead of using a codec private function for this.

Note this commit causes the machine-driver to now actually honor the
BYT_RT5651_DMIC_EN quirk, which was ignored before. To avoid this causing
a functional change in what is purely a refactor commit, this commit
removes the quirk from the defaults.

If we really want the BYT_RT5651_DMIC_EN behavior anywhere it should be
specifically enabled by follow up commits.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c             | 232 +++++++++++++++-------------------
 sound/soc/codecs/rt5651.h             |   6 +-
 sound/soc/intel/boards/bytcr_rt5651.c |  43 +++++--
 3 files changed, 139 insertions(+), 142 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 45a73049cf64..c5d19a80506b 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -19,7 +19,6 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
-#include <linux/dmi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -32,10 +31,6 @@
 #include "rl6231.h"
 #include "rt5651.h"
 
-#define RT5651_JD_MAP(quirk)	((quirk) & GENMASK(7, 0))
-#define RT5651_IN2_DIFF		BIT(16)
-#define RT5651_DMIC_EN		BIT(17)
-
 #define RT5651_DEVICE_ID_VALUE 0x6281
 
 #define RT5651_PR_RANGE_BASE (0xff + 1)
@@ -43,8 +38,6 @@
 
 #define RT5651_PR_BASE (RT5651_PR_RANGE_BASE + (0 * RT5651_PR_SPACING))
 
-static unsigned long rt5651_quirk;
-
 static const struct regmap_range_cfg rt5651_ranges[] = {
 	{ .name = "PR", .range_min = RT5651_PR_BASE,
 	  .range_max = RT5651_PR_BASE + 0xb4,
@@ -1585,10 +1578,88 @@ static int rt5651_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+static irqreturn_t rt5651_irq(int irq, void *data)
+{
+	struct rt5651_priv *rt5651 = data;
+
+	queue_delayed_work(system_power_efficient_wq,
+			   &rt5651->jack_detect_work, msecs_to_jiffies(250));
+
+	return IRQ_HANDLED;
+}
+
+static int rt5651_set_jack(struct snd_soc_codec *codec,
+			   struct snd_soc_jack *hp_jack, void *data)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	if (!rt5651->pdata.jd_src || !rt5651->irq)
+		return -EINVAL;
+
+	/* IRQ output on GPIO1 */
+	regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
+			   RT5651_GP1_PIN_MASK, RT5651_GP1_PIN_IRQ);
+
+	switch (rt5651->pdata.jd_src) {
+	case RT5651_JD1_1:
+		regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
+				   RT5651_JD_TRG_SEL_MASK,
+				   RT5651_JD_TRG_SEL_JD1_1);
+		regmap_update_bits(rt5651->regmap, RT5651_IRQ_CTRL1,
+				   RT5651_JD1_1_IRQ_EN,
+				   RT5651_JD1_1_IRQ_EN);
+		break;
+	case RT5651_JD1_2:
+		regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
+				   RT5651_JD_TRG_SEL_MASK,
+				   RT5651_JD_TRG_SEL_JD1_2);
+		regmap_update_bits(rt5651->regmap, RT5651_IRQ_CTRL1,
+				   RT5651_JD1_2_IRQ_EN,
+				   RT5651_JD1_2_IRQ_EN);
+		break;
+	case RT5651_JD2:
+		regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
+				   RT5651_JD_TRG_SEL_MASK,
+				   RT5651_JD_TRG_SEL_JD2);
+		regmap_update_bits(rt5651->regmap, RT5651_IRQ_CTRL1,
+				   RT5651_JD2_IRQ_EN,
+				   RT5651_JD2_IRQ_EN);
+		break;
+	case RT5651_JD_NULL:
+		break;
+	default:
+		dev_warn(codec->dev, "Currently only JD1_1 / JD1_2 / JD2 are supported\n");
+		break;
+	}
+
+	snd_soc_dapm_force_enable_pin(dapm, "JD Power");
+	snd_soc_dapm_force_enable_pin(dapm, "LDO");
+	snd_soc_dapm_sync(dapm);
+
+	regmap_update_bits(rt5651->regmap, RT5651_MICBIAS,
+			   0x38, 0x38);
+
+	ret = devm_request_threaded_irq(codec->dev, rt5651->irq, NULL,
+					rt5651_irq,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT, "rt5651", rt5651);
+	if (ret) {
+		dev_err(codec->dev, "Failed to reguest IRQ: %d\n", ret);
+		return ret;
+	}
+
+	rt5651->hp_jack = hp_jack;
+	rt5651_irq(0, rt5651);
+
+	return 0;
+}
+
 static int rt5651_probe(struct snd_soc_codec *codec)
 {
 	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 
 	rt5651->codec = codec;
 
@@ -1604,15 +1675,6 @@ static int rt5651_probe(struct snd_soc_codec *codec)
 
 	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	if (rt5651->pdata.jd_src) {
-		snd_soc_dapm_force_enable_pin(dapm, "JD Power");
-		snd_soc_dapm_force_enable_pin(dapm, "LDO");
-		snd_soc_dapm_sync(dapm);
-
-		regmap_update_bits(rt5651->regmap, RT5651_MICBIAS,
-				   0x38, 0x38);
-	}
-
 	return 0;
 }
 
@@ -1698,6 +1760,7 @@ static const struct snd_soc_codec_driver soc_codec_dev_rt5651 = {
 	.resume = rt5651_resume,
 	.set_bias_level = rt5651_set_bias_level,
 	.idle_bias_off = true,
+	.set_jack = rt5651_set_jack,
 	.component_driver = {
 		.controls		= rt5651_snd_controls,
 		.num_controls		= ARRAY_SIZE(rt5651_snd_controls),
@@ -1747,54 +1810,16 @@ static const struct i2c_device_id rt5651_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5651_i2c_id);
 
-static int rt5651_quirk_cb(const struct dmi_system_id *id)
-{
-	rt5651_quirk = (unsigned long) id->driver_data;
-	return 1;
-}
-
-static const struct dmi_system_id rt5651_quirk_table[] = {
-	{
-		.callback = rt5651_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
-		},
-		.driver_data = (unsigned long *) RT5651_JD1_1,
-	},
-	{}
-};
-
 static int rt5651_parse_dt(struct rt5651_priv *rt5651, struct device_node *np)
 {
-	if (of_property_read_bool(np, "realtek,in2-differential"))
-		rt5651_quirk |= RT5651_IN2_DIFF;
-	if (of_property_read_bool(np, "realtek,dmic-en"))
-		rt5651_quirk |= RT5651_DMIC_EN;
+	rt5651->pdata.in2_diff =
+		of_property_read_bool(np, "realtek,in2-differential");
+	rt5651->pdata.dmic_en =
+		of_property_read_bool(np, "realtek,dmic-en");
 
 	return 0;
 }
 
-static void rt5651_set_pdata(struct rt5651_priv *rt5651)
-{
-	if (rt5651_quirk & RT5651_IN2_DIFF)
-		rt5651->pdata.in2_diff = true;
-	if (rt5651_quirk & RT5651_DMIC_EN)
-		rt5651->pdata.dmic_en = true;
-	if (RT5651_JD_MAP(rt5651_quirk))
-		rt5651->pdata.jd_src = RT5651_JD_MAP(rt5651_quirk);
-}
-
-static irqreturn_t rt5651_irq(int irq, void *data)
-{
-	struct rt5651_priv *rt5651 = data;
-
-	queue_delayed_work(system_power_efficient_wq,
-			   &rt5651->jack_detect_work, msecs_to_jiffies(250));
-
-	return IRQ_HANDLED;
-}
-
 static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
@@ -1860,17 +1885,26 @@ static void rt5651_jack_detect_work(struct work_struct *work)
 	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
 }
 
-int rt5651_set_jack_detect(struct snd_soc_codec *codec,
-			   struct snd_soc_jack *hp_jack)
+static void rt5651_apply_pdata(struct rt5651_priv *rt5651)
 {
-	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+	if (rt5651->pdata.in2_diff)
+		regmap_update_bits(rt5651->regmap, RT5651_IN1_IN2,
+					RT5651_IN_DF2, RT5651_IN_DF2);
 
-	rt5651->hp_jack = hp_jack;
-	rt5651_irq(0, rt5651);
+	if (rt5651->pdata.dmic_en)
+		regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
+				RT5651_GP2_PIN_MASK, RT5651_GP2_PIN_DMIC1_SCL);
+}
 
-	return 0;
+void rt5651_set_pdata(struct snd_soc_codec *codec,
+		      struct rt5651_platform_data *pdata)
+{
+	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
+
+	rt5651->pdata = *pdata;
+	rt5651_apply_pdata(rt5651);
 }
-EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
+EXPORT_SYMBOL_GPL(rt5651_set_pdata);
 
 static int rt5651_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
@@ -1890,10 +1924,6 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 		rt5651->pdata = *pdata;
 	else if (i2c->dev.of_node)
 		rt5651_parse_dt(rt5651, i2c->dev.of_node);
-	else
-		dmi_check_system(rt5651_quirk_table);
-
-	rt5651_set_pdata(rt5651);
 
 	rt5651->regmap = devm_regmap_init_i2c(i2c, &rt5651_regmap);
 	if (IS_ERR(rt5651->regmap)) {
@@ -1917,69 +1947,13 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
-	if (rt5651->pdata.in2_diff)
-		regmap_update_bits(rt5651->regmap, RT5651_IN1_IN2,
-					RT5651_IN_DF2, RT5651_IN_DF2);
-
-	if (rt5651->pdata.dmic_en)
-		regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
-				RT5651_GP2_PIN_MASK, RT5651_GP2_PIN_DMIC1_SCL);
+	if (pdata || i2c->dev.of_node)
+		rt5651_apply_pdata(rt5651);
 
+	rt5651->irq = i2c->irq;
 	rt5651->hp_mute = 1;
-
-	if (rt5651->pdata.jd_src) {
-
-		/* IRQ output on GPIO1 */
-		regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
-				   RT5651_GP1_PIN_MASK, RT5651_GP1_PIN_IRQ);
-
-		switch (rt5651->pdata.jd_src) {
-		case RT5651_JD1_1:
-			regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
-					   RT5651_JD_TRG_SEL_MASK,
-					   RT5651_JD_TRG_SEL_JD1_1);
-			regmap_update_bits(rt5651->regmap, RT5651_IRQ_CTRL1,
-					   RT5651_JD1_1_IRQ_EN,
-					   RT5651_JD1_1_IRQ_EN);
-			break;
-		case RT5651_JD1_2:
-			regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
-					   RT5651_JD_TRG_SEL_MASK,
-					   RT5651_JD_TRG_SEL_JD1_2);
-			regmap_update_bits(rt5651->regmap, RT5651_IRQ_CTRL1,
-					   RT5651_JD1_2_IRQ_EN,
-					   RT5651_JD1_2_IRQ_EN);
-			break;
-		case RT5651_JD2:
-			regmap_update_bits(rt5651->regmap, RT5651_JD_CTRL2,
-					   RT5651_JD_TRG_SEL_MASK,
-					   RT5651_JD_TRG_SEL_JD2);
-			regmap_update_bits(rt5651->regmap, RT5651_IRQ_CTRL1,
-					   RT5651_JD2_IRQ_EN,
-					   RT5651_JD2_IRQ_EN);
-			break;
-		case RT5651_JD_NULL:
-			break;
-		default:
-			dev_warn(&i2c->dev, "Currently only JD1_1 / JD1_2 / JD2 are supported\n");
-			break;
-		}
-	}
-
 	INIT_DELAYED_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
 
-	if (i2c->irq) {
-		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
-						rt5651_irq,
-						IRQF_TRIGGER_RISING |
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT, "rt5651", rt5651);
-		if (ret) {
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
-			return ret;
-		}
-	}
-
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5651,
 				rt5651_dai, ARRAY_SIZE(rt5651_dai));
 
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 4f8b202121d7..151ac92f6bad 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2065,6 +2065,7 @@ struct rt5651_priv {
 	struct snd_soc_jack *hp_jack;
 	struct delayed_work jack_detect_work;
 
+	int irq;
 	int sysclk;
 	int sysclk_src;
 	int lrck[RT5651_AIFS];
@@ -2079,6 +2080,7 @@ struct rt5651_priv {
 	bool hp_mute;
 };
 
-int rt5651_set_jack_detect(struct snd_soc_codec *codec,
-			   struct snd_soc_jack *hp_jack);
+void rt5651_set_pdata(struct snd_soc_codec *codec,
+		      struct rt5651_platform_data *pdata);
+
 #endif /* __RT5651_H__ */
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 49c538f2770a..8ef5b5500fb7 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -42,7 +42,15 @@ enum {
 	BYT_RT5651_IN3_MAP,
 };
 
-#define BYT_RT5651_MAP(quirk)	((quirk) & GENMASK(7, 0))
+enum {
+	BYT_RT5651_JD_NULL	= (RT5651_JD_NULL << 4),
+	BYT_RT5651_JD1_1	= (RT5651_JD1_1 << 4),
+	BYT_RT5651_JD1_2	= (RT5651_JD1_2 << 4),
+	BYT_RT5651_JD2		= (RT5651_JD2 << 4),
+};
+
+#define BYT_RT5651_MAP(quirk)	((quirk) & GENMASK(3, 0))
+#define BYT_RT5651_JDSRC(quirk)	(((quirk) & GENMASK(7, 4)) >> 4)
 #define BYT_RT5651_DMIC_EN	BIT(16)
 #define BYT_RT5651_MCLK_EN	BIT(17)
 #define BYT_RT5651_MCLK_25MHZ	BIT(18)
@@ -53,7 +61,6 @@ struct byt_rt5651_private {
 };
 
 static unsigned long byt_rt5651_quirk = BYT_RT5651_DMIC_MAP |
-					BYT_RT5651_DMIC_EN |
 					BYT_RT5651_MCLK_EN;
 
 static void log_quirks(struct device *dev)
@@ -66,6 +73,9 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN2_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN3_MAP)
 		dev_info(dev, "quirk IN3_MAP enabled");
+	if (BYT_RT5651_JDSRC(byt_rt5651_quirk))
+		dev_info(dev, "quirk jack-detect src %ld\n",
+			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		dev_info(dev, "quirk DMIC enabled");
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
@@ -288,6 +298,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
 		},
 		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
+					BYT_RT5651_JD1_1 |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{}
@@ -299,6 +310,7 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_codec *codec = runtime->codec;
 	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
 	const struct snd_soc_dapm_route *custom_map;
+	struct rt5651_platform_data pdata = {};
 	int num_routes;
 	int ret;
 
@@ -360,17 +372,26 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 			dev_err(card->dev, "unable to set MCLK rate\n");
 	}
 
-	ret = snd_soc_card_jack_new(runtime->card, "Headset",
-				    SND_JACK_HEADSET, &priv->jack,
-				    bytcr_jack_pins, ARRAY_SIZE(bytcr_jack_pins));
-	if (ret) {
-		dev_err(runtime->dev, "Headset jack creation failed %d\n", ret);
-		return ret;
-	}
+	pdata.jd_src = BYT_RT5651_JDSRC(byt_rt5651_quirk);
+	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
+		pdata.dmic_en = true;
+	rt5651_set_pdata(codec, &pdata);
+
+	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
+		ret = snd_soc_card_jack_new(runtime->card, "Headset",
+				SND_JACK_HEADSET, &priv->jack,
+				bytcr_jack_pins, ARRAY_SIZE(bytcr_jack_pins));
+		if (ret) {
+			dev_err(runtime->dev, "Jack creation failed %d\n", ret);
+			return ret;
+		}
 
-	rt5651_set_jack_detect(codec, &priv->jack);
+		ret = snd_soc_codec_set_jack(codec, &priv->jack, NULL);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static const struct snd_soc_pcm_stream byt_rt5651_dai_params = {
-- 
2.14.3
