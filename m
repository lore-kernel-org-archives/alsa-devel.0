From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH RESEND V6 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Date: Wed, 15 May 2019 06:42:26 +0000
Message-ID: <39916109c570791be514db4a3a7793a9467d6484.1557901312.git.shengjiu.wang@nxp.com>
References: <cover.1557901312.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1557901312.git.shengjiu.wang@nxp.com>
Content-Language: en-US
Content-ID: <CAEF29172E4829499F5499A0F3141F40@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Unify the supported input and output rate, add the
12kHz/24kHz/128kHz to the support list

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index a8d6710f2541..cbbf6257f08a 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -27,13 +27,14 @@
 	dev_dbg(&asrc_priv->pdev->dev, "Pair %c: " fmt, 'A' + index, ##__VA_ARGS_=
_)
=20
 /* Corresponding to process_option */
-static int supported_input_rate[] =3D {
-	5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200,
-	96000, 176400, 192000,
+static unsigned int supported_asrc_rate[] =3D {
+	5512, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000,
+	64000, 88200, 96000, 128000, 176400, 192000,
 };
=20
-static int supported_asrc_rate[] =3D {
-	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 96000, 1764=
00, 192000,
+static struct snd_pcm_hw_constraint_list fsl_asrc_rate_constraints =3D {
+	.count =3D ARRAY_SIZE(supported_asrc_rate),
+	.list =3D supported_asrc_rate,
 };
=20
 /**
@@ -293,11 +294,11 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair =
*pair)
 	ideal =3D config->inclk =3D=3D INCLK_NONE;
=20
 	/* Validate input and output sample rates */
-	for (in =3D 0; in < ARRAY_SIZE(supported_input_rate); in++)
-		if (inrate =3D=3D supported_input_rate[in])
+	for (in =3D 0; in < ARRAY_SIZE(supported_asrc_rate); in++)
+		if (inrate =3D=3D supported_asrc_rate[in])
 			break;
=20
-	if (in =3D=3D ARRAY_SIZE(supported_input_rate)) {
+	if (in =3D=3D ARRAY_SIZE(supported_asrc_rate)) {
 		pair_err("unsupported input sample rate: %dHz\n", inrate);
 		return -EINVAL;
 	}
@@ -311,7 +312,7 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *p=
air)
 		return -EINVAL;
 	}
=20
-	if ((outrate >=3D 8000 && outrate <=3D 30000) &&
+	if ((outrate >=3D 5512 && outrate <=3D 30000) &&
 	    (outrate > 24 * inrate || inrate > 8 * outrate)) {
 		pair_err("exceed supported ratio range [1/24, 8] for \
 				inrate/outrate: %d/%d\n", inrate, outrate);
@@ -486,7 +487,9 @@ static int fsl_asrc_dai_startup(struct snd_pcm_substrea=
m *substream,
 		snd_pcm_hw_constraint_step(substream->runtime, 0,
 					   SNDRV_PCM_HW_PARAM_CHANNELS, 2);
=20
-	return 0;
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &fsl_asrc_rate_constraints);
 }
=20
 static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
@@ -599,7 +602,6 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
=20
-#define FSL_ASRC_RATES		 SNDRV_PCM_RATE_8000_192000
 #define FSL_ASRC_FORMATS	(SNDRV_PCM_FMTBIT_S24_LE | \
 				 SNDRV_PCM_FMTBIT_S16_LE | \
 				 SNDRV_PCM_FMTBIT_S20_3LE)
@@ -610,14 +612,18 @@ static struct snd_soc_dai_driver fsl_asrc_dai =3D {
 		.stream_name =3D "ASRC-Playback",
 		.channels_min =3D 1,
 		.channels_max =3D 10,
-		.rates =3D FSL_ASRC_RATES,
+		.rate_min =3D 5512,
+		.rate_max =3D 192000,
+		.rates =3D SNDRV_PCM_RATE_KNOT,
 		.formats =3D FSL_ASRC_FORMATS,
 	},
 	.capture =3D {
 		.stream_name =3D "ASRC-Capture",
 		.channels_min =3D 1,
 		.channels_max =3D 10,
-		.rates =3D FSL_ASRC_RATES,
+		.rate_min =3D 5512,
+		.rate_max =3D 192000,
+		.rates =3D SNDRV_PCM_RATE_KNOT,
 		.formats =3D FSL_ASRC_FORMATS,
 	},
 	.ops =3D &fsl_asrc_dai_ops,
--=20
2.21.0
