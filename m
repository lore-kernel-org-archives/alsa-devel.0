From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2] ASoC: fsl: sai: Fix underrrun for playback stream start
Date: Fri, 8 Mar 2019 17:39:30 +0000
Message-ID: <20190308173904.27298-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "festevam@gmail.com" <festevam@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

For [dir=3Dplayback, cmd =3D PCM_TRIGGER_START], fsl_sai_trigger
does the following:
	* Enable DMA request
	* Enable Transmitter

Now, because DMA doesn't copy data to TDR fast enough we hit
TX FIFO underrun error:

[   37.175974] fsl-sai 308b0000.sai: isr: Transmit underrun detected

The explanation for this can be found in SAI documentation for example
chapter 16.16.3.5.2 FIFO pointers of the i.MX8DXP reference manual [1]

"
If the Transmit FIFO is empty, then to avoid a FIFO underrun,
the Transmit Data Register must be written at least 3 bit clocks
before the start of the next unmasked word. Before enabling the
transmitter, the Transmit FIFO should be initialized with data
(since after the transmitter is enabled, the transmitter will
start a new frame, and if no data is in the FIFO, then the
transmitter will immediately give an error).
"

[1] https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
 - as per Fabio's request clarify the issue and the solution
 - move words writing before enabling DMA request

 sound/soc/fsl/fsl_sai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 2d376e3a3c80..a739baa99c1a 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -522,7 +522,9 @@ static int fsl_sai_trigger(struct snd_pcm_substream *su=
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
@@ -542,6 +544,11 @@ static int fsl_sai_trigger(struct snd_pcm_substream *s=
ubstream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		for (i =3D 0; tx && i < channels; i++)
+			regmap_write(sai->regmap, FSL_SAI_TDR, 0x0);
+		if (tx)
+			udelay(10);
+
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
 				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
=20
--=20
2.17.1
