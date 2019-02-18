From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: ad193x: Remove capture support for codecs without ADC" to the asoc tree
Date: Mon, 18 Feb 2019 18:49:39 +0000 (GMT)
Message-ID: <20190218184939.C1A051128008@debutante.sirena.org.uk>
References: <20190218160954.13929-2-codrin.ciubotariu@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218160954.13929-2-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, lars@metafoo.de, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, Codrin.Ciubotariu@microchip.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: ad193x: Remove capture support for codecs without ADC

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7aac8d13fc60db3ec2422f26c4dc2425a7fef20c Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Mon, 18 Feb 2019 16:10:28 +0000
Subject: [PATCH] ASoC: codecs: ad193x: Remove capture support for codecs
 without ADC

Some ad193x codecs don't have ADCs, so they have no capture capabilities.
This way, we can use this driver in multicodec cards.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 4b60ebee491d..21a38cc9e3da 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -351,6 +351,20 @@ static struct snd_soc_dai_driver ad193x_dai = {
 	.ops = &ad193x_dai_ops,
 };
 
+/* codec DAI instance for DAC only */
+static struct snd_soc_dai_driver ad193x_no_adc_dai = {
+	.name = "ad193x-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.ops = &ad193x_dai_ops,
+};
+
 static int ad193x_component_probe(struct snd_soc_component *component)
 {
 	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
@@ -444,8 +458,11 @@ int ad193x_probe(struct device *dev, struct regmap *regmap,
 
 	dev_set_drvdata(dev, ad193x);
 
+	if (ad193x_has_adc(ad193x))
+		return devm_snd_soc_register_component(dev, &soc_component_dev_ad193x,
+						       &ad193x_dai, 1);
 	return devm_snd_soc_register_component(dev, &soc_component_dev_ad193x,
-		&ad193x_dai, 1);
+		&ad193x_no_adc_dai, 1);
 }
 EXPORT_SYMBOL_GPL(ad193x_probe);
 
-- 
2.20.1
