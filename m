From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v5 1/4] ASoC: tlv320aic32x4: Support for master
	clock
Date: Mon, 17 Feb 2014 11:04:17 +0100
Message-ID: <1392631460-32002-2-git-send-email-mpa@pengutronix.de>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D3E7A261B21
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 11:04:38 +0100 (CET)
In-Reply-To: <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>, Markus Pargmann <mpa@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Add support for a master clock passed through DT. The master clock of
the codec is only active when the codec is in use.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/sound/tlv320aic32x4.txt    |  4 ++++
 sound/soc/codecs/tlv320aic32x4.c                   | 23 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
index db05510..352be7b 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
@@ -8,6 +8,8 @@ Required properties:
 
 Optional properties:
  - reset-gpios: Reset-GPIO phandle with args as described in gpio/gpio.txt
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
index 1dd50e4..d96cb7c 100644
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
@@ -539,6 +554,10 @@ static int aic32x4_set_bias_level(struct snd_soc_codec *codec,
 		/* Switch off BCLK_N Divider */
 		snd_soc_update_bits(codec, AIC32X4_BCLKN,
 				    AIC32X4_BCLKEN, 0);
+
+		/* Switch off master clock */
+		if (!IS_ERR(aic32x4->mclk))
+			clk_disable_unprepare(aic32x4->mclk);
 		break;
 	case SND_SOC_BIAS_OFF:
 		break;
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
1.8.5.3
