From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 09/10] ASoC: tlv320aic31xx: Add headphone/headset detection
Date: Thu, 7 Dec 2017 09:38:59 -0600
Message-ID: <20171207153900.9831-10-afd@ti.com>
References: <20171207153900.9831-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207153900.9831-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

This device can detect the insertion/removal of headphones and headsets.
Enable reporting this status by enabling this interrupt and forwarding
this to upper-layers if a jack has been defined.

This jack definition and the resulting operation from a jack detection
event must currently be defined by sound card platform code until CODEC
outputs to jack mappings can be defined generically.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 45 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic31xx.h | 11 ++++++++++
 2 files changed, 56 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 8ee407eab81b..fef402e0f9e8 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -25,6 +25,7 @@
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -89,6 +90,7 @@ static bool aic31xx_volatile(struct device *dev, unsigned int reg)
 	case AIC31XX_INTRADCFLAG: /* Sticky interrupt flags */
 	case AIC31XX_INTRDACFLAG2:
 	case AIC31XX_INTRADCFLAG2:
+	case AIC31XX_HSDETECT:
 		return true;
 	}
 	return false;
@@ -156,6 +158,7 @@ struct aic31xx_priv {
 	struct gpio_desc *gpio_reset;
 	int micbias_vg;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
+	struct snd_soc_jack *jack;
 	unsigned int sysclk;
 	u8 p_div;
 	int rate_div_line;
@@ -1149,6 +1152,20 @@ static int aic31xx_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+int aic31xx_set_jack(struct snd_soc_codec *codec,
+		     struct snd_soc_jack *jack, void *data)
+{
+	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
+
+	aic31xx->jack = jack;
+
+	/* Enable/Disable jack detection */
+	regmap_write(aic31xx->regmap, AIC31XX_HSDETECT,
+		     jack ? AIC31XX_HSD_ENABLE : 0);
+
+	return 0;
+}
+
 static int aic31xx_codec_probe(struct snd_soc_codec *codec)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
@@ -1174,6 +1191,7 @@ static int aic31xx_codec_probe(struct snd_soc_codec *codec)
 
 static const struct snd_soc_codec_driver soc_codec_driver_aic31xx = {
 	.probe			= aic31xx_codec_probe,
+	.set_jack		= aic31xx_set_jack,
 	.set_bias_level		= aic31xx_set_bias_level,
 	.suspend_bias_off	= true,
 
@@ -1272,6 +1290,32 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 	if (value & AIC31XX_HPRSCDETECT)
 		dev_err(dev, "Short circuit on Right output is detected\n");
 
+	if (value & AIC31XX_HSPLUG) {
+		int status = 0;
+
+		ret = regmap_read(aic31xx->regmap, AIC31XX_HSDETECT, &value);
+		if (ret) {
+			dev_err(dev, "Failed to read headset type: %d\n", ret);
+			return IRQ_NONE;
+		}
+
+		switch ((value & AIC31XX_HSD_TYPE_MASK) >>
+			AIC31XX_HSD_TYPE_SHIFT) {
+		case AIC31XX_HSD_HP:
+			status |= SND_JACK_HEADPHONE;
+			break;
+		case AIC31XX_HSD_HS:
+			status |= SND_JACK_HEADSET;
+			break;
+		default:
+			break;
+		}
+
+		if (aic31xx->jack)
+			snd_soc_jack_report(aic31xx->jack, status,
+					    AIC31XX_JACK_MASK);
+	}
+
 	ret = regmap_read(aic31xx->regmap, AIC31XX_OFFLAG, &value);
 	if (ret) {
 		dev_err(dev, "Failed to read overflow flag: %d\n", ret);
@@ -1360,6 +1404,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 				   AIC31XX_GPIO1_FUNC_SHIFT);
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
+			     AIC31XX_HSPLUGDET |
 			     AIC31XX_SC |
 			     AIC31XX_ENGINE);
 
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index d062663f66b5..66c85df4d5be 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -20,6 +20,9 @@
 #define AIC31XX_MINIDSP_BIT		BIT(2)
 #define DAC31XX_BIT			BIT(3)
 
+#define AIC31XX_JACK_MASK (SND_JACK_HEADPHONE | \
+			   SND_JACK_HEADSET)
+
 enum aic31xx_type {
 	AIC3100	= 0,
 	AIC3110 = AIC31XX_STEREO_CLASS_D_BIT,
@@ -213,6 +216,14 @@ enum aic31xx_type {
 /* AIC31XX_DACMUTE */
 #define AIC31XX_DACMUTE_MASK		GENMASK(3, 2)
 
+/* AIC31XX_HSDETECT */
+#define AIC31XX_HSD_ENABLE		BIT(7)
+#define AIC31XX_HSD_TYPE_MASK		GENMASK(6, 5)
+#define AIC31XX_HSD_TYPE_SHIFT		5
+#define AIC31XX_HSD_NONE		0x00
+#define AIC31XX_HSD_HP			0x01
+#define AIC31XX_HSD_HS			0x03
+
 /* AIC31XX_MICBIAS */
 #define AIC31XX_MICBIAS_MASK		GENMASK(1, 0)
 #define AIC31XX_MICBIAS_SHIFT		0
-- 
2.15.0
