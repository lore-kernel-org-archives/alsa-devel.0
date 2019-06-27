From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/2] ASoC: codecs: ad193x: Group register initialization at probe
Date: Thu, 27 Jun 2019 15:02:07 +0300
Message-ID: <20190627120208.4661-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
List-Id: alsa-devel@alsa-project.org

Create a structure with the register initialization values at probe and
use it to initialize all the registers at once.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

The order of the initialization is changed, but it doesn't seem to
matter.
There is one checkpatch warning, let me know if you want to remove it:
WARNING: line over 80 characters
#32: FILE: sound/soc/codecs/ad193x.c:425:
+		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */

 sound/soc/codecs/ad193x.c | 52 +++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 3ebc0524f4b2..f944228f014e 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -413,6 +413,38 @@ static struct snd_soc_dai_driver ad193x_no_adc_dai = {
 	.ops = &ad193x_dai_ops,
 };
 
+struct ad193x_reg_default {
+	unsigned int reg;
+	unsigned int val;
+};
+
+/* codec register values to set after reset */
+static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
+{
+	const struct ad193x_reg_default reg_init[] = {
+		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
+		{  1, 0x04 },	/* PLL_CLK_CTRL1: no on-chip Vref */
+		{  2, 0x40 },	/* DAC_CTRL0: TDM mode */
+		{  4, 0x1A },	/* DAC_CTRL2: 48kHz de-emphasis, unmute dac */
+		{  5, 0x00 },	/* DAC_CHNL_MUTE: unmute DAC channels */
+	};
+	const struct ad193x_reg_default reg_adc_init[] = {
+		{ 14, 0x03 },	/* ADC_CTRL0: high-pass filter enable */
+		{ 15, 0x43 },	/* ADC_CTRL1: sata delay=1, adc aux mode */
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(reg_init); i++)
+		regmap_write(ad193x->regmap, reg_init[i].reg, reg_init[i].val);
+
+	if (ad193x_has_adc(ad193x)) {
+		for (i = 0; i < ARRAY_SIZE(reg_adc_init); i++) {
+			regmap_write(ad193x->regmap, reg_adc_init[i].reg,
+				     reg_adc_init[i].val);
+		}
+	}
+}
+
 static int ad193x_component_probe(struct snd_soc_component *component)
 {
 	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
@@ -420,25 +452,7 @@ static int ad193x_component_probe(struct snd_soc_component *component)
 	int num, ret;
 
 	/* default setting for ad193x */
-
-	/* unmute dac channels */
-	regmap_write(ad193x->regmap, AD193X_DAC_CHNL_MUTE, 0x0);
-	/* de-emphasis: 48kHz, powedown dac */
-	regmap_write(ad193x->regmap, AD193X_DAC_CTRL2, 0x1A);
-	/* dac in tdm mode */
-	regmap_write(ad193x->regmap, AD193X_DAC_CTRL0, 0x40);
-
-	/* adc only */
-	if (ad193x_has_adc(ad193x)) {
-		/* high-pass filter enable */
-		regmap_write(ad193x->regmap, AD193X_ADC_CTRL0, 0x3);
-		/* sata delay=1, adc aux mode */
-		regmap_write(ad193x->regmap, AD193X_ADC_CTRL1, 0x43);
-	}
-
-	/* pll input: mclki/xi */
-	regmap_write(ad193x->regmap, AD193X_PLL_CLK_CTRL0, 0x99); /* mclk=24.576Mhz: 0x9D; mclk=12.288Mhz: 0x99 */
-	regmap_write(ad193x->regmap, AD193X_PLL_CLK_CTRL1, 0x04);
+	ad193x_reg_default_init(ad193x);
 
 	/* adc only */
 	if (ad193x_has_adc(ad193x)) {
-- 
2.20.1
