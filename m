From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 18/19] ASoC: tlv320aic31xx: Add headphone/headset detection
Date: Wed, 29 Nov 2017 15:32:59 -0600
Message-ID: <20171129213300.20021-19-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171129213300.20021-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This device can detect the insertion/removal of headphones and headsets.
Enable reporting this status by enabling this interrupt and forwarding
this to upper-layers if a jack has been defined.

This jack definition and the resulting operation from a jack detection
event must currently be defined by sound card platform code until CODEC
outputs to jack mappings can be defined generically.

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 33 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic31xx.h | 11 +++++++++++
 2 files changed, 44 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 094b1596f9cc..471b31be55d1 100644
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
@@ -161,6 +163,7 @@ struct aic31xx_priv {
 	struct gpio_desc *gpio_reset;
 	int micbias_vg;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
+	struct snd_soc_jack *jack;
 	unsigned int sysclk;
 	u8 p_div;
 	int rate_div_line;
@@ -1277,6 +1280,32 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
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
@@ -1365,9 +1394,13 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 				   AIC31XX_GPIO1_FUNC_SHIFT);
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
+			     AIC31XX_HSPLUGDET |
 			     AIC31XX_SC |
 			     AIC31XX_ENGINE);
 
+		regmap_write(aic31xx->regmap, AIC31XX_HSDETECT,
+			     AIC31XX_HSD_ENABLE);
+
 		ret = devm_request_threaded_irq(aic31xx->dev, aic31xx->irq,
 						NULL, aic31xx_irq,
 						IRQF_ONESHOT, "aic31xx-irq",
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
