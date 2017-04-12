From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] ASoC: fsl_esai: Remove unneeded definition
Date: Wed, 12 Apr 2017 09:37:21 -0300
Message-ID: <1492000641-27838-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0064.outbound.protection.outlook.com [104.47.40.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B2BD2665D5
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 14:37:32 +0200 (CEST)
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

There is no need for defining FSL_ESAI_RATES locally as the standard
SNDRV_PCM_RATE_8000_192000 definition can be used instead.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl_esai.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 38bfd46..809a069 100644
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
2.7.4
