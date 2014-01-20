From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2 3/4] ASoC: tlv320aic32x4: Support for master clock
Date: Mon, 20 Jan 2014 13:05:57 +0100
Message-ID: <1390219558-25341-4-git-send-email-mpa@pengutronix.de>
References: <1390219558-25341-1-git-send-email-mpa@pengutronix.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390219558-25341-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add support for a master clock passed through DT. The master clock of
the codec is only active when the codec is in use.

Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 .../devicetree/bindings/sound/tlv320aic32x4.txt    |  4 ++++
 sound/soc/codecs/tlv320aic32x4.c                   | 23 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
index cff06ea..e90e6f0 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
@@ -8,6 +8,8 @@ Required properties:
 
 Optional properties:
  - gpio-reset: Reset-GPIO phandle with args as described in gpio/gpio.txt
+ - clocks/clock-names: Clock named 'mclk' for the master clock of the codec.
+   See clock/clock-bindings.txt for information about the detailed format.
 
 
 Example:
@@ -15,4 +17,6 @@ Example:
 codec: tlv320aic32x4@18 {
 	compatible = "ti,tlv320aic32x4";
 	reg = <0x18>;
+	clocks = <&clks 201>;
+	clock-names = "mclk";
 };
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 6c38cb7..d7fa8dc 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -33,6 +33,7 @@
 #include <linux/i2c.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
+#include <linux/clk.h>
 
 #include <sound/tlv320aic32x4.h>
 #include <sound/core.h>
@@ -67,6 +68,7 @@ struct aic32x4_priv {
 	u32 micpga_routing;
 	bool swapdacs;
 	int rstn_gpio;
+	struct clk *mclk;
 };
 
 /* 0dB min, 0.5dB steps */
@@ -487,8 +489,21 @@ static int aic32x4_mute(struct snd_soc_dai *dai, int mute)
 static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
+	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
+		/* Switch on master clock */
+		if (!IS_ERR(aic32x4->mclk)) {
+			int ret;
+
+			ret = clk_prepare_enable(aic32x4->mclk);
+			if (ret) {
+				dev_err(codec->dev, "Failed to enable master clock\n");
+				return ret;
+			}
+		}
+
 		/* Switch on PLL */
 		snd_soc_update_bits(codec, AIC32X4_PLLPR,
 				    AIC32X4_PLLEN, AIC32X4_PLLEN);
@@ -516,6 +531,10 @@ static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
+		/* Switch off master clock */
+		if (!IS_ERR(aic32x4->mclk))
+			clk_disable_unprepare(aic32x4->mclk);
+
 		/* Switch off PLL */
 		snd_soc_update_bits(codec, AIC32X4_PLLPR,
 				    AIC32X4_PLLEN, 0);
@@ -717,6 +736,10 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 		aic32x4->rstn_gpio = -1;
 	}
 
+	aic32x4->mclk = devm_clk_get(&i2c->dev, "mclk");
+	if (IS_ERR(aic32x4->mclk))
+		dev_info(&i2c->dev, "No mclk found, continuing without clock\n");
+
 	if (gpio_is_valid(aic32x4->rstn_gpio)) {
 		ret = devm_gpio_request_one(&i2c->dev, aic32x4->rstn_gpio,
 				GPIOF_OUT_INIT_LOW, "tlv320aic32x4 rstn");
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
