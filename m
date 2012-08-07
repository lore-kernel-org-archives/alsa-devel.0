From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: imx-ssi: Remove mono support
Date: Tue,  7 Aug 2012 16:51:34 -0300
Message-ID: <1344369094-24085-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6656395252567910635=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
 [209.85.161.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A813265FFC
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 21:22:01 +0200 (CEST)
Received: by ggni2 with SMTP id i2so843273ggn.38
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2012 12:51:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de, gcembed@gmail.com
List-Id: alsa-devel@alsa-project.org

--===============6656395252567910635==
Content-Type: text/plain

From: Fabio Estevam <fabio.estevam@freescale.com>

Playing a mono track results in incorrect playback rate, ie, the audio
is played at a faster rate.

Remove mono support in the driver by setting 'channes_min' to dual-channel 
and this allows mono tracks to be played correctly.

Reported-by: Gaëtan Carlier <gcembed@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Also change 'channels_min' for the capture
- Improve the commit log
 sound/soc/fsl/imx-ssi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 3c520c4..7074ae6 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -380,13 +380,14 @@ static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
 static struct snd_soc_dai_driver imx_ssi_dai = {
 	.probe = imx_ssi_dai_probe,
 	.playback = {
-		.channels_min = 1,
+		/* The SSI does not support monaural audio. */
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_96000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.capture = {
-		.channels_min = 1,
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_96000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-- 
1.7.1


--===============6656395252567910635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6656395252567910635==--
