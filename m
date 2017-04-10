From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Remove FSLSSI_I2S_RATES
	definition" to the asoc tree
Date: Mon, 10 Apr 2017 19:42:50 +0100
Message-ID: <E1cxeH4-0003rQ-5z@debutante>
References: <1491421446-13799-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 995B2266CAF
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 20:43:00 +0200 (CEST)
In-Reply-To: <1491421446-13799-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Remove FSLSSI_I2S_RATES definition

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 580556774ad33adf427765d560f95f66cb01c295 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 5 Apr 2017 16:44:05 -0300
Subject: [PATCH] ASoC: fsl_ssi: Remove FSLSSI_I2S_RATES definition

The comment for the FSLSSI_I2S_RATES definition states that the
driver currently only supports I2S slave mode, which is no longer
correct.

As FSLSSI_I2S_RATES is the same as the standard SNDRV_PCM_RATE_CONTINUOUS,
just remove its definition and its comments to make the code simpler.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Timur Tabi <timur@tabi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 50349437d961..184a47360f84 100644
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
@@ -1217,14 +1207,14 @@ static struct snd_soc_dai_driver fsl_ssi_dai_template = {
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
2.11.0
