From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 2/5] ASoC: codecs: ad193x: Set constraint to always have 32
 sample bits
Date: Mon, 18 Feb 2019 16:10:30 +0000
Message-ID: <20190218160954.13929-3-codrin.ciubotariu@microchip.com>
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

DACs and ADCs on ad193x codecs require a 32 bit slot size. We should
assure that no other size is used.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 21a38cc9e3da..c16c9969d1a0 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -37,6 +37,13 @@ static SOC_ENUM_SINGLE_DECL(ad193x_deemp_enum, AD193X_DA=
C_CTRL2, 1,
=20
 static const DECLARE_TLV_DB_MINMAX(adau193x_tlv, -9563, 0);
=20
+static const unsigned int ad193x_sb[] =3D {32};
+
+static struct snd_pcm_hw_constraint_list constr =3D {
+	.list =3D ad193x_sb,
+	.count =3D ARRAY_SIZE(ad193x_sb),
+};
+
 static const struct snd_kcontrol_new ad193x_snd_controls[] =3D {
 	/* DAC volume control */
 	SOC_DOUBLE_R_TLV("DAC1 Volume", AD193X_DAC_L1_VOL,
@@ -321,7 +328,16 @@ static int ad193x_hw_params(struct snd_pcm_substream *=
substream,
 	return 0;
 }
=20
+static int ad193x_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				   &constr);
+}
+
 static const struct snd_soc_dai_ops ad193x_dai_ops =3D {
+	.startup =3D ad193x_startup,
 	.hw_params =3D ad193x_hw_params,
 	.digital_mute =3D ad193x_mute,
 	.set_tdm_slot =3D ad193x_set_tdm_slot,
--=20
2.17.1
