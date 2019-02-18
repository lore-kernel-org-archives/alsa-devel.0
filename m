From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: ad193x: Add runtime support for
	DSP_A and I2S modes" to the asoc tree
Date: Mon, 18 Feb 2019 18:49:33 +0000 (GMT)
Message-ID: <20190218184933.433021128008@debutante.sirena.org.uk>
References: <20190218160954.13929-5-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B6D56265543
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 19:49:34 +0100 (CET)
In-Reply-To: <20190218160954.13929-5-codrin.ciubotariu@microchip.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, Codrin.Ciubotariu@microchip.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: ad193x: Add runtime support for DSP_A and I2S modes

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

>From bccf9c7e14830af0004399d42d861b33c92eacff Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Mon, 18 Feb 2019 16:10:34 +0000
Subject: [PATCH] ASoC: codecs: ad193x: Add runtime support for DSP_A and I2S
 modes

The driver only supports DPS_A for DAC, which is configured at probe.
This patch adds support for DSP_A and I2S modes by using the set_fmt()
callback.

A trivial break is also removed from a case's default branch.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 315ec9775118..f8cf182518a3 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -188,23 +188,26 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 {
 	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(codec_dai->component);
 	unsigned int adc_serfmt = 0;
+	unsigned int dac_serfmt = 0;
 	unsigned int adc_fmt = 0;
 	unsigned int dac_fmt = 0;
 
 	/* At present, the driver only support AUX ADC mode(SND_SOC_DAIFMT_I2S
-	 * with TDM) and ADC&DAC TDM mode(SND_SOC_DAIFMT_DSP_A)
+	 * with TDM), ADC&DAC TDM mode(SND_SOC_DAIFMT_DSP_A) and DAC I2S mode
+	 * (SND_SOC_DAIFMT_I2S)
 	 */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		adc_serfmt |= AD193X_ADC_SERFMT_TDM;
+		dac_serfmt |= AD193X_DAC_SERFMT_STEREO;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		adc_serfmt |= AD193X_ADC_SERFMT_AUX;
+		dac_serfmt |= AD193X_DAC_SERFMT_TDM;
 		break;
 	default:
 		if (ad193x_has_adc(ad193x))
 			return -EINVAL;
-		break;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -261,6 +264,8 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL2,
 				   AD193X_ADC_FMT_MASK, adc_fmt);
 	}
+	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL0,
+			   AD193X_DAC_SERFMT_MASK, dac_serfmt);
 	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL1,
 		AD193X_DAC_FMT_MASK, dac_fmt);
 
-- 
2.20.1
