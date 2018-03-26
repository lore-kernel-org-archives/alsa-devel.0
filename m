From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 5/8] ASoC: amd: prepare callback modifications
	for bt i2s instance
Date: Mon, 26 Mar 2018 18:43:00 +0530
Message-ID: <1522069983-11381-6-git-send-email-Vijendar.Mukunda@amd.com>
References: <1522069983-11381-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0043.outbound.protection.outlook.com [104.47.33.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 685D2267190
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 15:12:38 +0200 (CEST)
In-Reply-To: <1522069983-11381-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, lgirdwood@gmail.com, Akshu.Agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

modified prepare callback for configuring dma channels for BT instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 53 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 9bd12bd..86d2287 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1012,25 +1012,62 @@ static int acp_dma_mmap(struct snd_pcm_substream *substream,
 
 static int acp_dma_prepare(struct snd_pcm_substream *substream)
 {
+	u16 start_dscr_idx;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
 
 	if (!rtd)
 		return -EINVAL;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		config_acp_dma_channel(rtd->acp_mmio, SYSRAM_TO_ACP_CH_NUM,
-					PLAYBACK_START_DMA_DESCR_CH12,
+		switch (rtd->i2s_play_instance) {
+		case I2S_BT_INSTANCE:
+			start_dscr_idx =  PLAYBACK_START_DMA_DESCR_CH8;
+			config_acp_dma_channel(rtd->acp_mmio,
+					SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
+					start_dscr_idx,
 					NUM_DSCRS_PER_CHANNEL, 0);
-		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_I2S_DMA_CH_NUM,
-					PLAYBACK_START_DMA_DESCR_CH13,
+			config_acp_dma_channel(rtd->acp_mmio,
+					ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM,
+					start_dscr_idx + 2,
 					NUM_DSCRS_PER_CHANNEL, 0);
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			start_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
+			config_acp_dma_channel(rtd->acp_mmio,
+					SYSRAM_TO_ACP_CH_NUM,
+					start_dscr_idx,
+					NUM_DSCRS_PER_CHANNEL, 0);
+			config_acp_dma_channel(rtd->acp_mmio,
+					ACP_TO_I2S_DMA_CH_NUM,
+					start_dscr_idx + 2,
+					NUM_DSCRS_PER_CHANNEL, 0);
+		}
 	} else {
-		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_SYSRAM_CH_NUM,
-					CAPTURE_START_DMA_DESCR_CH14,
+		switch (rtd->i2s_capture_instance) {
+		case I2S_BT_INSTANCE:
+			start_dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
+			config_acp_dma_channel(rtd->acp_mmio,
+					ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+					start_dscr_idx,
 					NUM_DSCRS_PER_CHANNEL, 0);
-		config_acp_dma_channel(rtd->acp_mmio, I2S_TO_ACP_DMA_CH_NUM,
-					CAPTURE_START_DMA_DESCR_CH15,
+			config_acp_dma_channel(rtd->acp_mmio,
+					I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM,
+					start_dscr_idx + 2,
 					NUM_DSCRS_PER_CHANNEL, 0);
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			start_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
+			config_acp_dma_channel(rtd->acp_mmio,
+					ACP_TO_SYSRAM_CH_NUM,
+					start_dscr_idx,
+					NUM_DSCRS_PER_CHANNEL, 0);
+			config_acp_dma_channel(rtd->acp_mmio,
+					I2S_TO_ACP_DMA_CH_NUM,
+					start_dscr_idx + 2,
+					NUM_DSCRS_PER_CHANNEL, 0);
+		}
 	}
 	return 0;
 }
-- 
2.7.4
