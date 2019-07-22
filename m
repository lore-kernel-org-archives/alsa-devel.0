From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: ad193x: Use regmap_multi_reg_write() when initializing" to the asoc tree
Date: Mon, 22 Jul 2019 13:22:09 +0100 (BST)
Message-ID: <20190722122209.3392127429FC@ypsilon.sirena.org.uk>
References: <20190710105119.22987-1-codrin.ciubotariu@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710105119.22987-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, Tzung-Bi Shih <tzungbi@google.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: ad193x: Use regmap_multi_reg_write() when initializing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From eaba5585944e6d692828bca701c9362f60172b8a Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Wed, 10 Jul 2019 13:51:19 +0300
Subject: [PATCH] ASoC: codecs: ad193x: Use regmap_multi_reg_write() when
 initializing

Using regmap_multi_reg_write() when we set the default values for our
registers makes the code smaller and easier to read.

Suggested-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20190710105119.22987-1-codrin.ciubotariu@microchip.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 80dab5df9633..fb04c9379b71 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -413,15 +413,10 @@ static struct snd_soc_dai_driver ad193x_no_adc_dai = {
 	.ops = &ad193x_dai_ops,
 };
 
-struct ad193x_reg_default {
-	unsigned int reg;
-	unsigned int val;
-};
-
 /* codec register values to set after reset */
 static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
 {
-	const struct ad193x_reg_default reg_init[] = {
+	const struct reg_sequence reg_init[] = {
 		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
 		{  1, 0x04 },	/* PLL_CLK_CTRL1: no on-chip Vref */
 		{  2, 0x40 },	/* DAC_CTRL0: TDM mode */
@@ -437,21 +432,17 @@ static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
 		{ 12, 0x00 },	/* DAC_L4_VOL: no attenuation */
 		{ 13, 0x00 },	/* DAC_R4_VOL: no attenuation */
 	};
-	const struct ad193x_reg_default reg_adc_init[] = {
+	const struct reg_sequence reg_adc_init[] = {
 		{ 14, 0x03 },	/* ADC_CTRL0: high-pass filter enable */
 		{ 15, 0x43 },	/* ADC_CTRL1: sata delay=1, adc aux mode */
 		{ 16, 0x00 },	/* ADC_CTRL2: reset */
 	};
-	int i;
 
-	for (i = 0; i < ARRAY_SIZE(reg_init); i++)
-		regmap_write(ad193x->regmap, reg_init[i].reg, reg_init[i].val);
+	regmap_multi_reg_write(ad193x->regmap, reg_init, ARRAY_SIZE(reg_init));
 
 	if (ad193x_has_adc(ad193x)) {
-		for (i = 0; i < ARRAY_SIZE(reg_adc_init); i++) {
-			regmap_write(ad193x->regmap, reg_adc_init[i].reg,
-				     reg_adc_init[i].val);
-		}
+		regmap_multi_reg_write(ad193x->regmap, reg_adc_init,
+				       ARRAY_SIZE(reg_adc_init));
 	}
 }
 
-- 
2.20.1
