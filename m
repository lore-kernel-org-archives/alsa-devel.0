From: "Harisangam, Sharvari (S.)" <sharvari.harisangam@visteon.com>
Subject: [PATCH]  ASoC : fsl_ssi : Correct the condition to check AC97 mode
Date: Wed, 28 Dec 2016 11:06:44 +0000
Message-ID: <20161228110636.GA14768@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <5808485AAFB54047816CADF943E10447@eurprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

 Corrected the condition to check if ssi is configured for AC97
 mode. Other modes like dsp_a also satisfy the ANDing condition.

Signed-off-by: Sharvari Harisangam <sharvari.harisangam@visteon.com>
---
 sound/soc/fsl/fsl_ssi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ca6f6b1..4fbb7a2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -317,7 +317,8 @@ MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
=20
 static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
 {
-	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
+	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97) =3D=3D
+		SND_SOC_DAIFMT_AC97;
 }
=20
 static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
@@ -1016,7 +1017,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 				CCSR_SSI_SCR_TCH_EN);
 	}
=20
-	if (fmt & SND_SOC_DAIFMT_AC97)
+	if ((fmt & SND_SOC_DAIFMT_AC97) =3D=3D SND_SOC_DAIFMT_AC97)
 		fsl_ssi_setup_ac97(ssi_private);
=20
 	return 0;
--=20
2.7.4
