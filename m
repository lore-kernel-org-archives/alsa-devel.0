From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH 3/3] ASoC: AMD: Set delay value for the capture
	case
Date: Thu,  2 Aug 2018 12:11:56 +0530
Message-ID: <1533192134-11626-3-git-send-email-akshu.agrawal@amd.com>
References: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0084.outbound.protection.outlook.com [104.47.40.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B39C22677CD
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 08:43:56 +0200 (CEST)
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
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, Mark Brown <broonie@kernel.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, akshu.agrawal@amd.com, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

ACP->SYSMEM DMA happens at every I2S->SYSMEM period
completion. Thus, there is delay of x frames till
I2S->SYSMEM reaches a period length. This delay is
communicated to user space.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 6240a77..c24611c 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -922,6 +922,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
 			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_11;
 			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_11;
 			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH10;
@@ -944,6 +948,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
 			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_15;
 			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_15;
 			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH14;
@@ -1002,7 +1010,7 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	u64 bytescount = 0;
 	u32 dma_count = 0;
 	u16 dscr;
-	u32 period_bytes;
+	u32 period_bytes, delay;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -1011,6 +1019,10 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
+	bytescount = acp_get_byte_count(rtd);
+	if (bytescount > rtd->bytescount)
+		bytescount -= rtd->bytescount;
+
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		period_bytes = frames_to_bytes(runtime, runtime->period_size);
 		dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
@@ -1018,10 +1030,9 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		if (dscr == rtd->end_dma_dscr)
 			dma_count += period_bytes;
 		pos = dma_count % buffersize;
+		delay = do_div(bytescount, period_bytes);
+		runtime->delay = bytes_to_frames(runtime, delay);
 	} else {
-		bytescount = acp_get_byte_count(rtd);
-		if (bytescount > rtd->bytescount)
-			bytescount -= rtd->bytescount;
 		pos = do_div(bytescount, buffersize);
 	}
 	return bytes_to_frames(runtime, pos);
-- 
1.9.1
