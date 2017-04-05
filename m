From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 1/2] ASoC: fsl_ssi: Remove FSLSSI_I2S_RATES
	definition
Date: Wed,  5 Apr 2017 16:44:05 -0300
Message-ID: <1491421446-13799-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 76F5D266943
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 21:44:57 +0200 (CEST)
Received: by mail-qk0-f194.google.com with SMTP id p22so3093452qka.0
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 12:44:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The comment for the FSLSSI_I2S_RATES definition states that the
driver currently only supports I2S slave mode, which is no longer
correct.

As FSLSSI_I2S_RATES is the same as the standard SNDRV_PCM_RATE_CONTINUOUS,
just remove its definition and its comments to make the code simpler.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Chnages since v1:
- Simply remove FSLSSI_I2S_RATES

 sound/soc/fsl/fsl_ssi.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fde08660..0b74d1c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -55,16 +55,6 @@
 #include "imx-pcm.h"
 
 /**
- * FSLSSI_I2S_RATES: sample rates supported by the I2S
- *
- * This driver currently only supports the SSI running in I2S slave mode,
- * which means the codec determines the sample rate.  Therefore, we tell
- * ALSA that we support all rates and let the codec driver decide what rates
- * are really supported.
- */
-#define FSLSSI_I2S_RATES SNDRV_PCM_RATE_CONTINUOUS
-
-/**
  * FSLSSI_I2S_FORMATS: audio formats supported by the SSI
  *
  * The SSI has a limitation in that the samples must be in the same byte
@@ -1212,14 +1202,14 @@ static struct snd_soc_dai_driver fsl_ssi_dai_template = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
 		.channels_max = 32,
-		.rates = FSLSSI_I2S_RATES,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = FSLSSI_I2S_FORMATS,
 	},
 	.capture = {
 		.stream_name = "CPU-Capture",
 		.channels_min = 1,
 		.channels_max = 32,
-		.rates = FSLSSI_I2S_RATES,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = FSLSSI_I2S_FORMATS,
 	},
 	.ops = &fsl_ssi_dai_ops,
-- 
2.7.4
