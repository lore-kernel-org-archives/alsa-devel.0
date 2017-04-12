From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_esai: Remove unneeded definition"
	to the asoc tree
Date: Wed, 12 Apr 2017 17:00:22 +0100
Message-ID: <E1cyKgw-00062x-Fs@debutante>
References: <1492000641-27838-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 581F1266FA9
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 18:00:34 +0200 (CEST)
In-Reply-To: <1492000641-27838-1-git-send-email-fabio.estevam@nxp.com>
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

   ASoC: fsl_esai: Remove unneeded definition

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

>From f2a3ee01259ef33ffe4caa0875afe25c15938a14 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 12 Apr 2017 09:37:21 -0300
Subject: [PATCH] ASoC: fsl_esai: Remove unneeded definition

There is no need for defining FSL_ESAI_RATES locally as the standard
SNDRV_PCM_RATE_8000_192000 definition can be used instead.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 38bfd46f4ad8..809a069d490b 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -19,7 +19,6 @@
 #include "fsl_esai.h"
 #include "imx-pcm.h"
 
-#define FSL_ESAI_RATES		SNDRV_PCM_RATE_8000_192000
 #define FSL_ESAI_FORMATS	(SNDRV_PCM_FMTBIT_S8 | \
 				SNDRV_PCM_FMTBIT_S16_LE | \
 				SNDRV_PCM_FMTBIT_S20_3LE | \
@@ -647,14 +646,14 @@ static struct snd_soc_dai_driver fsl_esai_dai = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
 		.channels_max = 12,
-		.rates = FSL_ESAI_RATES,
+		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = FSL_ESAI_FORMATS,
 	},
 	.capture = {
 		.stream_name = "CPU-Capture",
 		.channels_min = 1,
 		.channels_max = 8,
-		.rates = FSL_ESAI_RATES,
+		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = FSL_ESAI_FORMATS,
 	},
 	.ops = &fsl_esai_dai_ops,
-- 
2.11.0
