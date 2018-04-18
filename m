From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH v2 2/3] ASoC: amd: dma driver changes for BT
	I2S instance
Date: Wed, 18 Apr 2018 16:34:53 +0530
Message-ID: <1524049494-19526-3-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0051.outbound.protection.outlook.com [104.47.36.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 22803267679
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 13:02:56 +0200 (CEST)
In-Reply-To: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Daniel Kurtz <djkurtz@chromium.org>, Jason Clinton <jclinton@chromium.org>, Mark Brown <broonie@kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

With in ACP, There are three I2S controllers can be
configured/enabled ( I2S SP, I2S MICSP, I2S BT).
Default enabled I2S controller instance is I2S SP.
This patch provides required changes to support I2S BT
controller Instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
v1->v2: defined i2s instance macros in acp header file
 sound/soc/amd/Kconfig       |   1 +
 sound/soc/amd/acp-pcm-dma.c | 388 +++++++++++++++++++++++++++-----------------
 sound/soc/amd/acp.h         |  67 +++++++-
 3 files changed, 298 insertions(+), 158 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 6cbf9cf..6b7c620 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -1,5 +1,6 @@
 config SND_SOC_AMD_ACP
 	tristate "AMD Audio Coprocessor support"
+	select SND_DESIGNWARE_PCM
 	help
 	 This option enables ACP DMA support on AMD platform.
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 5ffe2ef..7c392fe 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -23,6 +23,8 @@
 #include <drm/amd_asic_type.h>
 #include "acp.h"
 
+#include "../dwc/local.h"
+
 #define DRV_NAME "acp_audio_dma"
 
 #define PLAYBACK_MIN_NUM_PERIODS    2
@@ -37,13 +39,14 @@
 #define MAX_BUFFER (PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define MIN_BUFFER MAX_BUFFER
 
-#define ST_PLAYBACK_MAX_PERIOD_SIZE 8192
+#define ST_PLAYBACK_MAX_PERIOD_SIZE 4096
 #define ST_CAPTURE_MAX_PERIOD_SIZE  ST_PLAYBACK_MAX_PERIOD_SIZE
 #define ST_MAX_BUFFER (ST_PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define ST_MIN_BUFFER ST_MAX_BUFFER
 
 #define DRV_NAME "acp_audio_dma"
 
+
 static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP |
@@ -317,54 +320,21 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 }
 
 static void config_acp_dma(void __iomem *acp_mmio,
-			   struct audio_substream_data *audio_config,
+			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
-	u32 pte_offset, sram_bank;
-	u16 ch1, ch2, destination, dma_dscr_idx;
-
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK) {
-		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-		destination = TO_ACP_I2S_1;
-
-	} else {
-		pte_offset = ACP_CAPTURE_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		switch (asic_type) {
-		case CHIP_STONEY:
-			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
-			break;
-		default:
-			sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
-		}
-		destination = FROM_ACP_I2S_1;
-	}
-
-	acp_pte_config(acp_mmio, audio_config->pg, audio_config->num_of_pages,
-		       pte_offset);
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
-
+	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
+		       rtd->pte_offset);
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
-	set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, pte_offset, ch1,
-				       sram_bank, dma_dscr_idx, asic_type);
-
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
+	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
+				       rtd->direction, rtd->pte_offset,
+				       rtd->ch1, rtd->sram_bank,
+				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
-	set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, sram_bank,
-				       destination, ch2, dma_dscr_idx,
-				       asic_type);
+	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
+				       rtd->direction, rtd->sram_bank,
+				       rtd->destination, rtd->ch2,
+				       rtd->dma_dscr_idx_2, asic_type);
 }
 
 /* Start a given DMA channel transfer */
@@ -390,6 +360,9 @@ static void acp_dma_start(void __iomem *acp_mmio,
 	case ACP_TO_I2S_DMA_CH_NUM:
 	case ACP_TO_SYSRAM_CH_NUM:
 	case I2S_TO_ACP_DMA_CH_NUM:
+	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
+	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
+	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
@@ -670,6 +643,24 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_9) ==
+			PLAYBACK_START_DMA_DESCR_CH9)
+			dscr_idx = PLAYBACK_END_DMA_DESCR_CH8;
+		else
+			dscr_idx = PLAYBACK_START_DMA_DESCR_CH8;
+		config_acp_dma_channel(acp_mmio,
+				       SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
+				       dscr_idx, 1, 0);
+		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
+			      false);
+		snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
+		acp_reg_write((intr_flag &
+			      BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
 		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_15) ==
@@ -692,6 +683,31 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_11) ==
+			CAPTURE_START_DMA_DESCR_CH11)
+			dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
+		else
+			dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
+		config_acp_dma_channel(acp_mmio,
+				       ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+				       dscr_idx, 1, 0);
+		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+			      false);
+		acp_reg_write((intr_flag &
+			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
+	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
+		acp_reg_write((intr_flag &
+			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if (valid_irq)
 		return IRQ_HANDLED;
 	else
@@ -707,6 +723,7 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
 								    DRV_NAME);
 	struct audio_drv_data *intr_data = dev_get_drvdata(component->dev);
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(prtd->cpu_dai);
 	struct audio_substream_data *adata =
 		kzalloc(sizeof(struct audio_substream_data), GFP_KERNEL);
 	if (!adata)
@@ -720,6 +737,8 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 		default:
 			runtime->hw = acp_pcm_hardware_playback;
 		}
+		adata->i2s_play_instance = dev->i2s_instance;
+		adata->bytescount = 0;
 	} else {
 		switch (intr_data->asic_type) {
 		case CHIP_STONEY:
@@ -728,6 +747,8 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 		default:
 			runtime->hw = acp_pcm_hardware_capture;
 		}
+		adata->i2s_capture_instance = dev->i2s_instance;
+		adata->bytescount = 0;
 	}
 
 	ret = snd_pcm_hw_constraint_integer(runtime,
@@ -747,11 +768,46 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	 * This enablement is not required for another stream, if current
 	 * stream is not closed
 	 */
-	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
+	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream &&
+	    !intr_data->play_i2sbt_stream && !intr_data->capture_i2sbt_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		intr_data->play_i2ssp_stream = substream;
+		switch (adata->i2s_play_instance) {
+		case I2S_BT_INSTANCE:
+			adata->pte_offset = ACP_ST_BT_PLAYBACK_PTE_OFFSET;
+			adata->ch1 = SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM;
+			adata->ch2 = ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM;
+			adata->sram_bank = ACP_SRAM_BANK_3_ADDRESS;
+			adata->destination = TO_BLUETOOTH;
+			adata->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH8;
+			adata->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH9;
+			adata->byte_cnt_high =
+			mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
+			adata->byte_cnt_low =
+			mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
+			intr_data->play_i2sbt_stream = substream;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			switch (intr_data->asic_type) {
+			case CHIP_STONEY:
+				adata->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+				break;
+			default:
+				adata->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+			}
+			adata->ch1 = SYSRAM_TO_ACP_CH_NUM;
+			adata->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+			adata->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
+			adata->destination = TO_ACP_I2S_1;
+			adata->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
+			adata->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+			adata->byte_cnt_high = mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
+			adata->byte_cnt_low = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
+			intr_data->play_i2ssp_stream = substream;
+			break;
+		}
 		/*
 		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
@@ -763,7 +819,40 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 							bank, true);
 		}
 	} else {
-		intr_data->capture_i2ssp_stream = substream;
+		switch (adata->i2s_capture_instance) {
+		case I2S_BT_INSTANCE:
+			adata->pte_offset = ACP_ST_BT_CAPTURE_PTE_OFFSET;
+			adata->ch1 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
+			adata->ch2 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			adata->sram_bank = ACP_SRAM_BANK_4_ADDRESS;
+			adata->destination = FROM_BLUETOOTH;
+			adata->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
+			adata->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
+			adata->byte_cnt_high =
+			mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
+			adata->byte_cnt_low =
+			mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			intr_data->capture_i2sbt_stream = substream;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+			adata->ch1 = SYSRAM_TO_ACP_CH_NUM;
+			adata->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+			switch (intr_data->asic_type) {
+			case CHIP_STONEY:
+				adata->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
+				break;
+			default:
+				adata->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
+			}
+			adata->destination = FROM_ACP_I2S_1;
+			adata->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
+			adata->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+			adata->byte_cnt_high = mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+			adata->byte_cnt_low = mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			intr_data->capture_i2ssp_stream = substream;
+		}
 		if (intr_data->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(intr_data->acp_mmio,
@@ -797,10 +886,25 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
-		else
-			val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			switch (rtd->i2s_play_instance) {
+			case I2S_BT_INSTANCE:
+				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
+			}
+		} else {
+			switch (rtd->i2s_capture_instance) {
+			case I2S_BT_INSTANCE:
+				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+			}
+		}
 		acp_reg_write(val, adata->acp_mmio,
 			      mmACP_I2S_16BIT_RESOLUTION_EN);
 	}
@@ -837,26 +941,15 @@ static int acp_dma_hw_free(struct snd_pcm_substream *substream)
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static u64 acp_get_byte_count(void __iomem *acp_mmio, int stream)
+static u64 acp_get_byte_count(struct audio_substream_data *rtd)
 {
-	union acp_dma_count playback_dma_count;
-	union acp_dma_count capture_dma_count;
-	u64 bytescount = 0;
+	union acp_dma_count byte_count;
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		playback_dma_count.bcount.high = acp_reg_read(acp_mmio,
-					mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH);
-		playback_dma_count.bcount.low  = acp_reg_read(acp_mmio,
-					mmACP_I2S_TRANSMIT_BYTE_CNT_LOW);
-		bytescount = playback_dma_count.bytescount;
-	} else {
-		capture_dma_count.bcount.high = acp_reg_read(acp_mmio,
-					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH);
-		capture_dma_count.bcount.low  = acp_reg_read(acp_mmio,
-					mmACP_I2S_RECEIVED_BYTE_CNT_LOW);
-		bytescount = capture_dma_count.bytescount;
-	}
-	return bytescount;
+	byte_count.bcount.high = acp_reg_read(rtd->acp_mmio,
+					      rtd->byte_cnt_high);
+	byte_count.bcount.low  = acp_reg_read(rtd->acp_mmio,
+					      rtd->byte_cnt_low);
+	return byte_count.bytescount;
 }
 
 static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
@@ -872,15 +965,10 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
+	bytescount = acp_get_byte_count(rtd);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (bytescount > rtd->i2ssp_renderbytescount)
-			bytescount = bytescount - rtd->i2ssp_renderbytescount;
-	} else {
-		if (bytescount > rtd->i2ssp_capturebytescount)
-			bytescount = bytescount - rtd->i2ssp_capturebytescount;
-	}
+	if (bytescount > rtd->bytescount)
+		bytescount = bytescount - rtd->bytescount;
 	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(runtime, pos);
 }
@@ -898,21 +986,14 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 
 	if (!rtd)
 		return -EINVAL;
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		config_acp_dma_channel(rtd->acp_mmio, SYSRAM_TO_ACP_CH_NUM,
-				       PLAYBACK_START_DMA_DESCR_CH12,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_I2S_DMA_CH_NUM,
-				       PLAYBACK_START_DMA_DESCR_CH13,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-	} else {
-		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_SYSRAM_CH_NUM,
-				       CAPTURE_START_DMA_DESCR_CH14,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-		config_acp_dma_channel(rtd->acp_mmio, I2S_TO_ACP_DMA_CH_NUM,
-				       CAPTURE_START_DMA_DESCR_CH15,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-	}
+	config_acp_dma_channel(rtd->acp_mmio,
+			       rtd->ch1,
+			       rtd->dma_dscr_idx_1,
+			       NUM_DSCRS_PER_CHANNEL, 0);
+	config_acp_dma_channel(rtd->acp_mmio,
+			       rtd->ch2,
+			       rtd->dma_dscr_idx_2,
+			       NUM_DSCRS_PER_CHANNEL, 0);
 	return 0;
 }
 
@@ -934,15 +1015,13 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		bytescount = acp_get_byte_count(rtd->acp_mmio,
-						substream->stream);
+		bytescount = acp_get_byte_count(rtd);
+		if (rtd->bytescount == 0)
+			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			if (rtd->i2ssp_renderbytescount == 0)
-				rtd->i2ssp_renderbytescount = bytescount;
-			acp_dma_start(rtd->acp_mmio,
-				      SYSRAM_TO_ACP_CH_NUM, false);
+			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
-						BIT(SYSRAM_TO_ACP_CH_NUM)) {
+				BIT(rtd->ch1)) {
 				if (!loops--) {
 					dev_err(component->dev,
 						"acp dma start timeout\n");
@@ -950,40 +1029,21 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				}
 				cpu_relax();
 			}
-
-			acp_dma_start(rtd->acp_mmio,
-				      ACP_TO_I2S_DMA_CH_NUM, true);
-
-		} else {
-			if (rtd->i2ssp_capturebytescount == 0)
-				rtd->i2ssp_capturebytescount = bytescount;
-			acp_dma_start(rtd->acp_mmio,
-				      I2S_TO_ACP_DMA_CH_NUM, true);
 		}
+		acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		/*
-		 * Need to stop only circular DMA channels :
-		 * ACP_TO_I2S_DMA_CH_NUM / I2S_TO_ACP_DMA_CH_NUM. Non-circular
-		 * channels will stopped automatically after its transfer
-		 * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
-		 */
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   SYSRAM_TO_ACP_CH_NUM);
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   ACP_TO_I2S_DMA_CH_NUM);
-			rtd->i2ssp_renderbytescount = 0;
+			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
+			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 		} else {
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   I2S_TO_ACP_DMA_CH_NUM);
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   ACP_TO_SYSRAM_CH_NUM);
-			rtd->i2ssp_capturebytescount = 0;
+			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
+			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 		}
+		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
@@ -1028,27 +1088,40 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
-	kfree(rtd);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adata->play_i2ssp_stream = NULL;
-		/*
-		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
-		 * won't be turned off. The default state for SRAM banks is ON.
-		 * Setting SRAM bank state code skipped for STONEY platform.
-		 * added condition checks for Carrizo platform only
-		 */
-		if (adata->asic_type != CHIP_STONEY) {
-			for (bank = 1; bank <= 4; bank++)
-				acp_set_sram_bank_state(adata->acp_mmio, bank,
-							false);
+		switch (rtd->i2s_play_instance) {
+		case I2S_BT_INSTANCE:
+			adata->play_i2sbt_stream = NULL;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->play_i2ssp_stream = NULL;
+			/*
+			 * For Stoney, Memory gating is disabled,i.e SRAM Banks
+			 * won't be turned off. The default state for SRAM banks
+			 * is ON.Setting SRAM bank state code skipped for STONEY
+			 * platform. Added condition checks for Carrizo platform
+			 * only.
+			 */
+			if (adata->asic_type != CHIP_STONEY) {
+				for (bank = 1; bank <= 4; bank++)
+					acp_set_sram_bank_state(adata->acp_mmio,
+								bank, false);
+			}
 		}
 	} else  {
-		adata->capture_i2ssp_stream = NULL;
-		if (adata->asic_type != CHIP_STONEY) {
-			for (bank = 5; bank <= 8; bank++)
-				acp_set_sram_bank_state(adata->acp_mmio, bank,
-							false);
+		switch (rtd->i2s_capture_instance) {
+		case I2S_BT_INSTANCE:
+			adata->capture_i2sbt_stream = NULL;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->capture_i2ssp_stream = NULL;
+			if (adata->asic_type != CHIP_STONEY) {
+				for (bank = 5; bank <= 8; bank++)
+					acp_set_sram_bank_state(adata->acp_mmio,
+								bank, false);
+			}
 		}
 	}
 
@@ -1056,8 +1129,10 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	 * Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
 	 */
-	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
+	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
+	    !adata->play_i2sbt_stream && !adata->capture_i2sbt_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
+	kfree(rtd);
 
 	return 0;
 }
@@ -1110,6 +1185,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 	audio_drv_data->play_i2ssp_stream = NULL;
 	audio_drv_data->capture_i2ssp_stream = NULL;
+	audio_drv_data->play_i2sbt_stream = NULL;
+	audio_drv_data->capture_i2sbt_stream = NULL;
 
 	audio_drv_data->asic_type =  *pdata;
 
@@ -1166,6 +1243,7 @@ static int acp_pcm_resume(struct device *dev)
 {
 	u16 bank;
 	int status;
+	struct audio_substream_data *rtd;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
 	status = acp_init(adata->acp_mmio, adata->asic_type);
@@ -1185,9 +1263,8 @@ static int acp_pcm_resume(struct device *dev)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
 							true);
 		}
-		config_acp_dma(adata->acp_mmio,
-			       adata->play_i2ssp_stream->runtime->private_data,
-			       adata->asic_type);
+		rtd = adata->play_i2ssp_stream->runtime->private_data;
+		config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
 	}
 	if (adata->capture_i2ssp_stream &&
 	    adata->capture_i2ssp_stream->runtime) {
@@ -1196,9 +1273,20 @@ static int acp_pcm_resume(struct device *dev)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
 							true);
 		}
-		config_acp_dma(adata->acp_mmio,
-			       adata->capture_i2ssp_stream->runtime->private_data,
-			       adata->asic_type);
+		rtd =  adata->capture_i2ssp_stream->runtime->private_data;
+		config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+	}
+	if (adata->asic_type != CHIP_CARRIZO) {
+		if (adata->play_i2sbt_stream &&
+		    adata->play_i2sbt_stream->runtime) {
+			rtd = adata->play_i2sbt_stream->runtime->private_data;
+			config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+		}
+		if (adata->capture_i2sbt_stream &&
+		    adata->capture_i2sbt_stream->runtime) {
+			rtd = adata->capture_i2sbt_stream->runtime->private_data;
+			config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+		}
 	}
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 0e6089b..95c39a3 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -10,17 +10,30 @@
 #define ACP_PLAYBACK_PTE_OFFSET			10
 #define ACP_CAPTURE_PTE_OFFSET			0
 
+/* Playback and Capture Offset for Stoney */
+#define ACP_ST_PLAYBACK_PTE_OFFSET	0x04
+#define ACP_ST_CAPTURE_PTE_OFFSET	0x00
+#define ACP_ST_BT_PLAYBACK_PTE_OFFSET	0x08
+#define ACP_ST_BT_CAPTURE_PTE_OFFSET	0x0c
+
 #define ACP_GARLIC_CNTL_DEFAULT			0x00000FB4
 #define ACP_ONION_CNTL_DEFAULT			0x00000FB4
 
 #define ACP_PHYSICAL_BASE			0x14000
 
-/* Playback SRAM address (as a destination in dma descriptor) */
-#define ACP_SHARED_RAM_BANK_1_ADDRESS		0x4002000
-
-/* Capture SRAM address (as a source in dma descriptor) */
-#define ACP_SHARED_RAM_BANK_5_ADDRESS		0x400A000
-#define ACP_SHARED_RAM_BANK_3_ADDRESS		0x4006000
+/*
+ * In case of I2S SP controller instance, Stoney uses SRAM bank 1 for
+ * playback and SRAM Bank 2 for capture where as in case of BT I2S
+ * Instance, Stoney uses SRAM Bank 3 for playback & SRAM Bank 4 will
+ * be used for capture. Carrizo uses I2S SP controller instance. SRAM Banks
+ * 1, 2, 3, 4 will be used for playback & SRAM Banks 5, 6, 7, 8 will be used
+ * for capture scenario.
+ */
+#define ACP_SRAM_BANK_1_ADDRESS		0x4002000
+#define ACP_SRAM_BANK_2_ADDRESS		0x4004000
+#define ACP_SRAM_BANK_3_ADDRESS		0x4006000
+#define ACP_SRAM_BANK_4_ADDRESS		0x4008000
+#define ACP_SRAM_BANK_5_ADDRESS		0x400A000
 
 #define ACP_DMA_RESET_TIME			10000
 #define ACP_CLOCK_EN_TIME_OUT_VALUE		0x000000FF
@@ -35,8 +48,13 @@
 
 #define TO_ACP_I2S_1   0x2
 #define TO_ACP_I2S_2   0x4
+#define TO_BLUETOOTH   0x3
 #define FROM_ACP_I2S_1 0xa
 #define FROM_ACP_I2S_2 0xb
+#define FROM_BLUETOOTH 0xb
+
+#define I2S_SP_INSTANCE                 0x01
+#define I2S_BT_INSTANCE                 0x02
 
 #define ACP_TILE_ON_MASK                0x03
 #define ACP_TILE_OFF_MASK               0x02
@@ -57,6 +75,14 @@
 #define ACP_TO_SYSRAM_CH_NUM 14
 #define I2S_TO_ACP_DMA_CH_NUM 15
 
+/* Playback DMA Channels for I2S BT instance */
+#define SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM  8
+#define ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM 9
+
+/* Capture DMA Channels for I2S BT Instance */
+#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 10
+#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 11
+
 #define NUM_DSCRS_PER_CHANNEL 2
 
 #define PLAYBACK_START_DMA_DESCR_CH12 0
@@ -69,9 +95,22 @@
 #define CAPTURE_START_DMA_DESCR_CH15 6
 #define CAPTURE_END_DMA_DESCR_CH15 7
 
+/* I2S BT Instance DMA Descriptors */
+#define PLAYBACK_START_DMA_DESCR_CH8 8
+#define PLAYBACK_END_DMA_DESCR_CH8 9
+#define PLAYBACK_START_DMA_DESCR_CH9 10
+#define PLAYBACK_END_DMA_DESCR_CH9 11
+
+#define CAPTURE_START_DMA_DESCR_CH10 12
+#define CAPTURE_END_DMA_DESCR_CH10 13
+#define CAPTURE_START_DMA_DESCR_CH11 14
+#define CAPTURE_END_DMA_DESCR_CH11 15
+
 #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
 #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
 #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
+#define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
+
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
 	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
@@ -84,16 +123,28 @@ struct audio_substream_data {
 	struct page *pg;
 	unsigned int order;
 	u16 num_of_pages;
+	u16 i2s_play_instance;
+	u16 i2s_capture_instance;
 	u16 direction;
+	u16 ch1;
+	u16 ch2;
+	u16 destination;
+	u16 dma_dscr_idx_1;
+	u16 dma_dscr_idx_2;
+	u32 pte_offset;
+	u32 sram_bank;
+	u32 byte_cnt_high;
+	u32 byte_cnt_low;
 	uint64_t size;
-	u64 i2ssp_renderbytescount;
-	u64 i2ssp_capturebytescount;
+	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
 struct audio_drv_data {
 	struct snd_pcm_substream *play_i2ssp_stream;
 	struct snd_pcm_substream *capture_i2ssp_stream;
+	struct snd_pcm_substream *play_i2sbt_stream;
+	struct snd_pcm_substream *capture_i2sbt_stream;
 	void __iomem *acp_mmio;
 	u32 asic_type;
 };
-- 
2.7.4
