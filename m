From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 4/5] ASoC: codecs: ad193x: Add runtime support for DSP_A and
 I2S modes
Date: Mon, 18 Feb 2019 16:10:34 +0000
Message-ID: <20190218160954.13929-5-codrin.ciubotariu@microchip.com>
References: <20190218160954.13929-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218160954.13929-1-codrin.ciubotariu@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Codrin.Ciubotariu@microchip.com
List-Id: alsa-devel@alsa-project.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

The driver only supports DPS_A for DAC, which is configured at probe.
This patch adds support for DSP_A and I2S modes by using the set_fmt()
callback.

A trivial break is also removed from a case's default branch.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 315ec9775118..f8cf182518a3 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -188,23 +188,26 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *cod=
ec_dai,
 {
 	struct ad193x_priv *ad193x =3D snd_soc_component_get_drvdata(codec_dai->c=
omponent);
 	unsigned int adc_serfmt =3D 0;
+	unsigned int dac_serfmt =3D 0;
 	unsigned int adc_fmt =3D 0;
 	unsigned int dac_fmt =3D 0;
=20
 	/* At present, the driver only support AUX ADC mode(SND_SOC_DAIFMT_I2S
-	 * with TDM) and ADC&DAC TDM mode(SND_SOC_DAIFMT_DSP_A)
+	 * with TDM), ADC&DAC TDM mode(SND_SOC_DAIFMT_DSP_A) and DAC I2S mode
+	 * (SND_SOC_DAIFMT_I2S)
 	 */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		adc_serfmt |=3D AD193X_ADC_SERFMT_TDM;
+		dac_serfmt |=3D AD193X_DAC_SERFMT_STEREO;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		adc_serfmt |=3D AD193X_ADC_SERFMT_AUX;
+		dac_serfmt |=3D AD193X_DAC_SERFMT_TDM;
 		break;
 	default:
 		if (ad193x_has_adc(ad193x))
 			return -EINVAL;
-		break;
 	}
=20
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -261,6 +264,8 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec=
_dai,
 		regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL2,
 				   AD193X_ADC_FMT_MASK, adc_fmt);
 	}
+	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL0,
+			   AD193X_DAC_SERFMT_MASK, dac_serfmt);
 	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL1,
 		AD193X_DAC_FMT_MASK, dac_fmt);
=20
--=20
2.17.1
