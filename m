From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 6/8] ASoC: amd: pointer and trigger callback
	modifications for bt i2s
Date: Mon, 26 Mar 2018 18:43:01 +0530
Message-ID: <1522069983-11381-7-git-send-email-Vijendar.Mukunda@amd.com>
References: <1522069983-11381-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0054.outbound.protection.outlook.com [104.47.41.54])
 by alsa0.perex.cz (Postfix) with ESMTP id B4AC426722D
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 15:12:44 +0200 (CEST)
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

modified trigger and pointer callbacks for bt i2s
instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 189 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 144 insertions(+), 45 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 86d2287..c695e42 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -956,23 +956,43 @@ static int acp_dma_hw_free(struct snd_pcm_substream *substream)
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static u64 acp_get_byte_count(void __iomem *acp_mmio, int stream)
+static u64 acp_get_byte_count(void __iomem *acp_mmio, u16 instance, int stream)
 {
 	union acp_dma_count playback_dma_count;
 	union acp_dma_count capture_dma_count;
 	u64 bytescount = 0;
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		playback_dma_count.bcount.high = acp_reg_read(acp_mmio,
+		switch (instance) {
+		case I2S_BT_INSTANCE:
+			playback_dma_count.bcount.high = acp_reg_read(acp_mmio,
+					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH);
+			playback_dma_count.bcount.low  = acp_reg_read(acp_mmio,
+					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW);
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			playback_dma_count.bcount.high = acp_reg_read(acp_mmio,
 					mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH);
-		playback_dma_count.bcount.low  = acp_reg_read(acp_mmio,
+			playback_dma_count.bcount.low  = acp_reg_read(acp_mmio,
 					mmACP_I2S_TRANSMIT_BYTE_CNT_LOW);
+		}
 		bytescount = playback_dma_count.bytescount;
 	} else {
-		capture_dma_count.bcount.high = acp_reg_read(acp_mmio,
+		switch (instance) {
+		case I2S_BT_INSTANCE:
+			capture_dma_count.bcount.high = acp_reg_read(acp_mmio,
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH);
+			capture_dma_count.bcount.low  = acp_reg_read(acp_mmio,
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW);
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			capture_dma_count.bcount.high = acp_reg_read(acp_mmio,
 					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH);
-		capture_dma_count.bcount.low  = acp_reg_read(acp_mmio,
+			capture_dma_count.bcount.low  = acp_reg_read(acp_mmio,
 					mmACP_I2S_RECEIVED_BYTE_CNT_LOW);
+		}
 		bytescount = capture_dma_count.bytescount;
 	}
 	return bytescount;
@@ -991,14 +1011,38 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (bytescount > rtd->i2ssp_renderbytescount)
-			bytescount = bytescount - rtd->i2ssp_renderbytescount;
+		bytescount = acp_get_byte_count(rtd->acp_mmio,
+					rtd->i2s_play_instance,
+					substream->stream);
+		switch (rtd->i2s_play_instance) {
+		case I2S_BT_INSTANCE:
+			if (bytescount > rtd->i2sbt_renderbytescount)
+				bytescount = bytescount -
+					rtd->i2sbt_renderbytescount;
+		break;
+		case I2S_SP_INSTANCE:
+		default:
+			if (bytescount > rtd->i2ssp_renderbytescount)
+				bytescount = bytescount -
+					rtd->i2ssp_renderbytescount;
+		}
 	} else {
-		if (bytescount > rtd->i2ssp_capturebytescount)
-			bytescount = bytescount - rtd->i2ssp_capturebytescount;
+		bytescount = acp_get_byte_count(rtd->acp_mmio,
+					rtd->i2s_capture_instance,
+					substream->stream);
+		switch (rtd->i2s_capture_instance) {
+		case I2S_BT_INSTANCE:
+			if (bytescount > rtd->i2sbt_capturebytescount)
+				bytescount = bytescount -
+					rtd->i2sbt_capturebytescount;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			if (bytescount > rtd->i2ssp_capturebytescount)
+				bytescount = bytescount -
+					rtd->i2ssp_capturebytescount;
+		}
 	}
 	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(runtime, pos);
@@ -1089,54 +1133,109 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		bytescount = acp_get_byte_count(rtd->acp_mmio,
-						substream->stream);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			if (rtd->i2ssp_renderbytescount == 0)
-				rtd->i2ssp_renderbytescount = bytescount;
-			acp_dma_start(rtd->acp_mmio,
-						SYSRAM_TO_ACP_CH_NUM, false);
-			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
-						BIT(SYSRAM_TO_ACP_CH_NUM)) {
-				if (!loops--) {
-					dev_err(component->dev,
-						"acp dma start timeout\n");
-					return -ETIMEDOUT;
+			bytescount = acp_get_byte_count(rtd->acp_mmio,
+					rtd->i2s_play_instance,
+					substream->stream);
+			switch (rtd->i2s_play_instance) {
+			case I2S_BT_INSTANCE:
+				if (rtd->i2sbt_renderbytescount == 0)
+					rtd->i2sbt_renderbytescount = bytescount;
+				acp_dma_start(rtd->acp_mmio,
+					SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
+					false);
+				while (acp_reg_read(rtd->acp_mmio,
+					mmACP_DMA_CH_STS) &
+					BIT(SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM)) {
+					if (!loops--) {
+						dev_err(component->dev,
+							"acp dma start timeout\n");
+						return -ETIMEDOUT;
+					}
+					cpu_relax();
 				}
-				cpu_relax();
-			}
-
-			acp_dma_start(rtd->acp_mmio,
+				acp_dma_start(rtd->acp_mmio,
+					ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM,
+					true);
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				if (rtd->i2ssp_renderbytescount == 0)
+					rtd->i2ssp_renderbytescount = bytescount;
+				acp_dma_start(rtd->acp_mmio,
+					SYSRAM_TO_ACP_CH_NUM, false);
+				while (acp_reg_read(rtd->acp_mmio,
+					mmACP_DMA_CH_STS) &
+					BIT(SYSRAM_TO_ACP_CH_NUM)) {
+					if (!loops--) {
+						dev_err(component->dev,
+							"acp dma start timeout\n");
+						return -ETIMEDOUT;
+					}
+					cpu_relax();
+				}
+				acp_dma_start(rtd->acp_mmio,
 					ACP_TO_I2S_DMA_CH_NUM, true);
-
+			}
 		} else {
-			if (rtd->i2ssp_capturebytescount == 0)
-				rtd->i2ssp_capturebytescount = bytescount;
-			acp_dma_start(rtd->acp_mmio,
-					    I2S_TO_ACP_DMA_CH_NUM, true);
+			bytescount = acp_get_byte_count(rtd->acp_mmio,
+						rtd->i2s_capture_instance,
+						substream->stream);
+			switch (rtd->i2s_capture_instance) {
+			case I2S_BT_INSTANCE:
+				if (rtd->i2sbt_capturebytescount == 0)
+					rtd->i2sbt_capturebytescount = 0;
+				acp_dma_start(rtd->acp_mmio,
+					I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM,
+					true);
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				if (rtd->i2ssp_capturebytescount == 0)
+					rtd->i2ssp_capturebytescount = bytescount;
+				acp_dma_start(rtd->acp_mmio,
+					I2S_TO_ACP_DMA_CH_NUM, true);
+			}
 		}
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		/* Need to stop only circular DMA channels :
-		 * ACP_TO_I2S_DMA_CH_NUM / I2S_TO_ACP_DMA_CH_NUM. Non-circular
-		 * channels will stopped automatically after its transfer
-		 * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
-		 */
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			ret = acp_dma_stop(rtd->acp_mmio,
+			switch (rtd->i2s_play_instance) {
+			case I2S_BT_INSTANCE:
+				ret = acp_dma_stop(rtd->acp_mmio,
+					SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM);
+				ret = acp_dma_stop(rtd->acp_mmio,
+					ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM);
+				rtd->i2sbt_renderbytescount = 0;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				ret = acp_dma_stop(rtd->acp_mmio,
 						SYSRAM_TO_ACP_CH_NUM);
-			ret = acp_dma_stop(rtd->acp_mmio,
-					ACP_TO_I2S_DMA_CH_NUM);
-			rtd->i2ssp_renderbytescount = 0;
+				ret =  acp_dma_stop(rtd->acp_mmio,
+						ACP_TO_I2S_DMA_CH_NUM);
+				rtd->i2ssp_renderbytescount = 0;
+			}
 		} else {
-			ret = acp_dma_stop(rtd->acp_mmio,
-					I2S_TO_ACP_DMA_CH_NUM);
-			ret = acp_dma_stop(rtd->acp_mmio,
+			switch (rtd->i2s_capture_instance) {
+			case I2S_BT_INSTANCE:
+				ret = acp_dma_stop(rtd->acp_mmio,
+					I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM);
+				ret = acp_dma_stop(rtd->acp_mmio,
+					ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM);
+				rtd->i2sbt_capturebytescount = 0;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				ret = acp_dma_stop(rtd->acp_mmio,
+						I2S_TO_ACP_DMA_CH_NUM);
+				ret = acp_dma_stop(rtd->acp_mmio,
 						ACP_TO_SYSRAM_CH_NUM);
-			rtd->i2ssp_capturebytescount = 0;
+				rtd->i2ssp_capturebytescount = 0;
+			}
 		}
 		break;
 	default:
-- 
2.7.4
