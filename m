From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [ASoC] Fix: Revert 'ASoC: imx-ssi: Remove mono support'.
Date: Mon,  3 Sep 2012 10:27:11 +0200
Message-ID: <1346660831-9662-1-git-send-email-javier.martin@vista-silicon.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, gcembed@gmail.com, fabio.estevam@freescale.com, s.hauer@pengutronix.de, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

The following commit should be reverted: 0865a75d4166bddc533fd50831829ceefb94f9b0

The bug this patch is meant to solve doesn't occur in Visstrim_M10 boards.
Furthermore, after applying this patch sound in Visstrim_M10 is played
at slower rates.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
diff --git b/sound/soc/fsl/imx-ssi.c a/sound/soc/fsl/imx-ssi.c
index ac337ac..28dd76c 100644
--- b/sound/soc/fsl/imx-ssi.c
+++ a/sound/soc/fsl/imx-ssi.c
@@ -380,13 +380,13 @@ static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
 static struct snd_soc_dai_driver imx_ssi_dai = {
 	.probe = imx_ssi_dai_probe,
 	.playback = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_96000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.capture = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_96000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
