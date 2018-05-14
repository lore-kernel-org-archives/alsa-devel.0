From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2] ASoC: amd: modified dma pointer callback implementation
Date: Mon, 14 May 2018 17:27:36 +0530
Message-ID: <1526299075-31475-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Kurtz <djkurtz@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Modified dma pointer callback implementation.
hw ptr calculated based on System Memory to
ACP SRAM dma channel transfer count in case of playback.
Increased min period size for playback to 4096 to avoid underruns.
In case of capture, hw ptr calculated based on dma transfer
count for ACP SRAM to System Memory Dma channel.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
v1->v2: removed hard coded values in acp dma pointer callback
	declared dma varaibles in rtd structure
 sound/soc/amd/acp-pcm-dma.c | 66 +++++++++++++++++++--------------------------
 sound/soc/amd/acp.h         | 15 +++--------
 2 files changed, 31 insertions(+), 50 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 906eb77..34a88ab 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -28,7 +28,7 @@
 #define PLAYBACK_MIN_NUM_PERIODS    2
 #define PLAYBACK_MAX_NUM_PERIODS    2
 #define PLAYBACK_MAX_PERIOD_SIZE    16384
-#define PLAYBACK_MIN_PERIOD_SIZE    1024
+#define PLAYBACK_MIN_PERIOD_SIZE    4096
 #define CAPTURE_MIN_NUM_PERIODS     2
 #define CAPTURE_MAX_NUM_PERIODS     2
 #define CAPTURE_MAX_PERIOD_SIZE     16384
@@ -854,10 +854,9 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = TO_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH8;
 			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH9;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_8;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_8;
+			rtd->end_dma_dscr = PLAYBACK_END_DMA_DESCR_CH8;
 			adata->play_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -875,10 +874,9 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = TO_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
 			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_12;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_12;
+			rtd->end_dma_dscr = PLAYBACK_END_DMA_DESCR_CH12;
 			adata->play_i2ssp_stream = substream;
 		}
 	} else {
@@ -891,10 +889,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			rtd->dma_cntl = mmACP_DMA_CNTL_10;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_10;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_10;
+			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH10;
 			adata->capture_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -914,10 +912,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			rtd->dma_cntl = mmACP_DMA_CNTL_14;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_14;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_14;
+			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH14;
 			adata->capture_i2ssp_stream = substream;
 		}
 	}
@@ -955,22 +953,13 @@ static int acp_dma_hw_free(struct snd_pcm_substream *substream)
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static u64 acp_get_byte_count(struct audio_substream_data *rtd)
-{
-	union acp_dma_count byte_count;
-
-	byte_count.bcount.high = acp_reg_read(rtd->acp_mmio,
-					      rtd->byte_cnt_high_reg_offset);
-	byte_count.bcount.low  = acp_reg_read(rtd->acp_mmio,
-					      rtd->byte_cnt_low_reg_offset);
-	return byte_count.bytescount;
-}
-
 static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 {
 	u32 buffersize;
 	u32 pos = 0;
-	u64 bytescount = 0;
+	u32 dma_count = 0;
+	u16 dscr;
+	u32 period_bytes;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -979,11 +968,15 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd);
-
-	if (bytescount > rtd->bytescount)
-		bytescount -= rtd->bytescount;
-	pos = do_div(bytescount, buffersize);
+	period_bytes = frames_to_bytes(runtime, runtime->period_size);
+	if ((substream->stream == SNDRV_PCM_STREAM_CAPTURE) &&
+	    acp_reg_read(rtd->acp_mmio, rtd->dma_cntl) == 0)
+		return 0;
+	dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+	dma_count = acp_reg_read(rtd->acp_mmio, rtd->cur_trans_cnt);
+	if (dscr == rtd->end_dma_dscr)
+		dma_count += period_bytes;
+	pos = dma_count % buffersize;
 	return bytes_to_frames(runtime, pos);
 }
 
@@ -1016,7 +1009,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	int ret;
 	u32 loops = 4000;
-	u64 bytescount = 0;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
@@ -1030,9 +1022,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		bytescount = acp_get_byte_count(rtd);
-		if (rtd->bytescount == 0)
-			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
@@ -1066,7 +1055,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 		}
-		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 9cd3e96..4740804 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -131,12 +131,13 @@ struct audio_substream_data {
 	u16 destination;
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
+	u16 end_dma_dscr;
 	u32 pte_offset;
 	u32 sram_bank;
-	u32 byte_cnt_high_reg_offset;
-	u32 byte_cnt_low_reg_offset;
+	u32 dma_cntl;
+	u32 dma_curr_dscr;
+	u32 cur_trans_cnt;
 	uint64_t size;
-	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
@@ -157,14 +158,6 @@ struct acp_platform_info {
 	u16 i2s_instance;
 };
 
-union acp_dma_count {
-	struct {
-	u32 low;
-	u32 high;
-	} bcount;
-	u64 bytescount;
-};
-
 enum {
 	ACP_TILE_P1 = 0,
 	ACP_TILE_P2,
-- 
2.7.4
