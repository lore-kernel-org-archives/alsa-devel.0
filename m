From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 5/5] ASoC: codecs: ad193x: Add support to disable on-chip PLL
Date: Mon, 18 Feb 2019 16:10:36 +0000
Message-ID: <20190218160954.13929-6-codrin.ciubotariu@microchip.com>
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

The on-chip PLL can be disabled if on the MCLKI pin we have an external
clock at 512 x fs. This clock can be used as direct internal clock for
ADCs or DACs.
To support this, we add an extra clock id that can be configured
using the set_sysclk() callback.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 26 +++++++++++++++++++++++++-
 sound/soc/codecs/ad193x.h |  8 ++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index f8cf182518a3..96d7cb2e4a56 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -100,6 +100,15 @@ static const struct snd_soc_dapm_widget ad193x_adc_wid=
gets[] =3D {
 	SND_SOC_DAPM_INPUT("ADC2IN"),
 };
=20
+static int ad193x_check_pll(struct snd_soc_dapm_widget *source,
+			    struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_component *component =3D snd_soc_dapm_to_component(source-=
>dapm);
+	struct ad193x_priv *ad193x =3D snd_soc_component_get_drvdata(component);
+
+	return !!ad193x->sysclk;
+}
+
 static const struct snd_soc_dapm_route audio_paths[] =3D {
 	{ "DAC", NULL, "SYSCLK" },
 	{ "DAC Output", NULL, "DAC" },
@@ -108,7 +117,7 @@ static const struct snd_soc_dapm_route audio_paths[] =
=3D {
 	{ "DAC2OUT", NULL, "DAC Output" },
 	{ "DAC3OUT", NULL, "DAC Output" },
 	{ "DAC4OUT", NULL, "DAC Output" },
-	{ "SYSCLK", NULL, "PLL_PWR" },
+	{ "SYSCLK", NULL, "PLL_PWR", &ad193x_check_pll },
 };
=20
 static const struct snd_soc_dapm_route ad193x_adc_audio_paths[] =3D {
@@ -276,7 +285,22 @@ static int ad193x_set_dai_sysclk(struct snd_soc_dai *c=
odec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_component *component =3D codec_dai->component;
+	struct snd_soc_dapm_context *dapm =3D snd_soc_component_get_dapm(componen=
t);
 	struct ad193x_priv *ad193x =3D snd_soc_component_get_drvdata(component);
+
+	if (clk_id =3D=3D AD193X_SYSCLK_MCLK) {
+		/* MCLK must be 512 x fs */
+		if (dir =3D=3D SND_SOC_CLOCK_OUT || freq !=3D 24576000)
+			return -EINVAL;
+
+		regmap_update_bits(ad193x->regmap, AD193X_PLL_CLK_CTRL1,
+				   AD193X_PLL_SRC_MASK,
+				   AD193X_PLL_DAC_SRC_MCLK |
+				   AD193X_PLL_CLK_SRC_MCLK);
+
+		snd_soc_dapm_sync(dapm);
+		return 0;
+	}
 	switch (freq) {
 	case 12288000:
 	case 18432000:
diff --git a/sound/soc/codecs/ad193x.h b/sound/soc/codecs/ad193x.h
index 8b1e65f928d2..27d6afbd7dfb 100644
--- a/sound/soc/codecs/ad193x.h
+++ b/sound/soc/codecs/ad193x.h
@@ -31,6 +31,11 @@ int ad193x_probe(struct device *dev, struct regmap *regm=
ap,
 #define AD193X_PLL_INPUT_512    (2 << 1)
 #define AD193X_PLL_INPUT_768    (3 << 1)
 #define AD193X_PLL_CLK_CTRL1    0x01
+#define AD193X_PLL_SRC_MASK	0x03
+#define AD193X_PLL_DAC_SRC_PLL  0
+#define AD193X_PLL_DAC_SRC_MCLK 1
+#define AD193X_PLL_CLK_SRC_PLL  (0 << 1)
+#define AD193X_PLL_CLK_SRC_MCLK	(1 << 1)
 #define AD193X_DAC_CTRL0        0x02
 #define AD193X_DAC_POWERDOWN           0x01
 #define AD193X_DAC_SERFMT_MASK		0xC0
@@ -96,4 +101,7 @@ int ad193x_probe(struct device *dev, struct regmap *regm=
ap,
=20
 #define AD193X_NUM_REGS          17
=20
+#define AD193X_SYSCLK_PLL	0
+#define AD193X_SYSCLK_MCLK	1
+
 #endif
--=20
2.17.1
