From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 1/5] ASoC: codecs: ad193x: Remove capture support for codecs
 without ADC
Date: Mon, 18 Feb 2019 16:10:28 +0000
Message-ID: <20190218160954.13929-2-codrin.ciubotariu@microchip.com>
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

Some ad193x codecs don't have ADCs, so they have no capture capabilities.
This way, we can use this driver in multicodec cards.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 4b60ebee491d..21a38cc9e3da 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -351,6 +351,20 @@ static struct snd_soc_dai_driver ad193x_dai =3D {
 	.ops =3D &ad193x_dai_ops,
 };
=20
+/* codec DAI instance for DAC only */
+static struct snd_soc_dai_driver ad193x_no_adc_dai =3D {
+	.name =3D "ad193x-hifi",
+	.playback =3D {
+		.stream_name =3D "Playback",
+		.channels_min =3D 2,
+		.channels_max =3D 8,
+		.rates =3D SNDRV_PCM_RATE_48000,
+		.formats =3D SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.ops =3D &ad193x_dai_ops,
+};
+
 static int ad193x_component_probe(struct snd_soc_component *component)
 {
 	struct ad193x_priv *ad193x =3D snd_soc_component_get_drvdata(component);
@@ -444,8 +458,11 @@ int ad193x_probe(struct device *dev, struct regmap *re=
gmap,
=20
 	dev_set_drvdata(dev, ad193x);
=20
+	if (ad193x_has_adc(ad193x))
+		return devm_snd_soc_register_component(dev, &soc_component_dev_ad193x,
+						       &ad193x_dai, 1);
 	return devm_snd_soc_register_component(dev, &soc_component_dev_ad193x,
-		&ad193x_dai, 1);
+		&ad193x_no_adc_dai, 1);
 }
 EXPORT_SYMBOL_GPL(ad193x_probe);
=20
--=20
2.17.1
