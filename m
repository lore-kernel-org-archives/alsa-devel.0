From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Fix rx rotation settings
Date: Wed, 3 Sep 2014 17:17:21 +0300
Message-ID: <1409753841-31084-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id CA1032655F2
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 16:17:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

We need to take into account the slot size as well when calculating the
RROT for received data.
This patch will fix S24_3LE audio capture.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 6a6b2ff7d7d7..267cd4937c7c 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -463,11 +463,11 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 }
 
 static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
-				       int word_length)
+				       int slot_size, int word_length)
 {
 	u32 fmt;
 	u32 tx_rotate = (word_length / 4) & 0x7;
-	u32 rx_rotate = (32 - word_length) / 4;
+	u32 rx_rotate = (slot_size - word_length) / 4;
 	u32 mask = (1ULL << word_length) - 1;
 
 	/*
@@ -726,7 +726,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
 	struct davinci_pcm_dma_params *dma_params =
 					&mcasp->dma_params[substream->stream];
-	int word_length;
+	int word_length, slot_size;
 	int channels = params_channels(params);
 	int period_size = params_period_size(params);
 	int ret;
@@ -766,31 +766,32 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_U8:
 	case SNDRV_PCM_FORMAT_S8:
 		dma_params->data_type = 1;
-		word_length = 8;
+		slot_size = word_length = 8;
 		break;
 
 	case SNDRV_PCM_FORMAT_U16_LE:
 	case SNDRV_PCM_FORMAT_S16_LE:
 		dma_params->data_type = 2;
-		word_length = 16;
+		slot_size = word_length = 16;
 		break;
 
 	case SNDRV_PCM_FORMAT_U24_3LE:
 	case SNDRV_PCM_FORMAT_S24_3LE:
 		dma_params->data_type = 3;
-		word_length = 24;
+		slot_size = word_length = 24;
 		break;
 
 	case SNDRV_PCM_FORMAT_U24_LE:
 	case SNDRV_PCM_FORMAT_S24_LE:
 		dma_params->data_type = 4;
 		word_length = 24;
+		slot_size = 32;
 		break;
 
 	case SNDRV_PCM_FORMAT_U32_LE:
 	case SNDRV_PCM_FORMAT_S32_LE:
 		dma_params->data_type = 4;
-		word_length = 32;
+		slot_size = word_length = 32;
 		break;
 
 	default:
@@ -803,7 +804,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	else
 		dma_params->acnt = dma_params->data_type;
 
-	davinci_config_channel_size(mcasp, word_length);
+	davinci_config_channel_size(mcasp, slot_size, word_length);
 
 	return 0;
 }
-- 
2.1.0
