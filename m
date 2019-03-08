From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: fsl: sai: Reduce underrun when stream starts
Date: Fri, 8 Mar 2019 16:09:53 +0000
Message-ID: <20190308160933.29899-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Write initial words into SAI FIFO to reduce the underrun
error.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index db9e0872f73d..99edbba4e8fa 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -503,7 +503,9 @@ static int fsl_sai_trigger(struct snd_pcm_substream *su=
bstream, int cmd,
 {
 	struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(cpu_dai);
 	bool tx =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned int channels =3D substream->runtime->channels;
 	u32 xcsr, count =3D 100;
+	int i;
=20
 	/*
 	 * Asynchronous mode: Clear SYNC for both Tx and Rx.
@@ -526,6 +528,11 @@ static int fsl_sai_trigger(struct snd_pcm_substream *s=
ubstream, int cmd,
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
 				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
=20
+		for (i =3D 0; tx && i < channels; i++)
+			regmap_write(sai->regmap, FSL_SAI_TDR, 0x0);
+		if (tx)
+			udelay(10);
+
 		regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
 				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
 		regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
--=20
2.17.1
