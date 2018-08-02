From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH 2/3] ASoC: AMD: Modified DMA pointer for capture
Date: Thu,  2 Aug 2018 12:11:55 +0530
Message-ID: <1533192134-11626-2-git-send-email-akshu.agrawal@amd.com>
References: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680073.outbound.protection.outlook.com [40.107.68.73])
 by alsa0.perex.cz (Postfix) with ESMTP id A690A2677E2
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 08:43:43 +0200 (CEST)
In-Reply-To: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, akshu.agrawal@amd.com, Mark Brown <broonie@kernel.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>

Give position on ACP->SYSMEM DMA channel for
the number of bytes that have been transferred on
the current descriptor under service.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 34 ++++++++++++++++++++++------------
 sound/soc/amd/acp.h         |  3 +++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 816abd6..6240a77 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -922,10 +922,9 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_11;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_11;
+			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH10;
 			adata->capture_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -945,10 +944,9 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_15;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_15;
+			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH14;
 			adata->capture_i2ssp_stream = substream;
 		}
 	}
@@ -1002,6 +1000,9 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	u32 buffersize;
 	u32 pos = 0;
 	u64 bytescount = 0;
+	u32 dma_count = 0;
+	u16 dscr;
+	u32 period_bytes;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -1010,10 +1011,19 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd);
-
-	bytescount -= rtd->bytescount;
-	pos = do_div(bytescount, buffersize);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		period_bytes = frames_to_bytes(runtime, runtime->period_size);
+		dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+		dma_count = acp_reg_read(rtd->acp_mmio, rtd->cur_trans_cnt);
+		if (dscr == rtd->end_dma_dscr)
+			dma_count += period_bytes;
+		pos = dma_count % buffersize;
+	} else {
+		bytescount = acp_get_byte_count(rtd);
+		if (bytescount > rtd->bytescount)
+			bytescount -= rtd->bytescount;
+		pos = do_div(bytescount, buffersize);
+	}
 	return bytes_to_frames(runtime, pos);
 }
 
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 0a2240b..cf7c0b9 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -134,10 +134,13 @@ struct audio_substream_data {
 	u16 destination;
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
+	u16 end_dma_dscr;
 	u32 pte_offset;
 	u32 sram_bank;
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
+	u32 dma_curr_dscr;
+	u32 cur_trans_cnt;
 	uint64_t size;
 	u64 bytescount;
 	void __iomem *acp_mmio;
-- 
1.9.1
