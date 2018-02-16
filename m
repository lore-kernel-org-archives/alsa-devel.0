From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 3/9] ASoC: amd: dma driver changes for BT I2S
	controller instance
Date: Fri, 16 Feb 2018 13:03:48 +0530
Message-ID: <1518766434-7911-4-git-send-email-Vijendar.Mukunda@amd.com>
References: <1518766434-7911-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0046.outbound.protection.outlook.com [104.47.40.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 74601267D84
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 08:32:13 +0100 (CET)
In-Reply-To: <1518766434-7911-1-git-send-email-Vijendar.Mukunda@amd.com>
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
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, Akshu Agrawal <akshu.agrawal@amd.com>, lgirdwood@gmail.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

Implemented dma driver changes to support BT I2S controller
instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 103 +++++++++++++++++++++++++++++++++++---------
 sound/soc/amd/acp.h         |   8 ++++
 2 files changed, 90 insertions(+), 21 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 91c4775..963ffa7 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -717,7 +717,23 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 		default:
 			runtime->hw = acp_pcm_hardware_playback;
 		}
+		if (strcmp(prtd->cpu_dai->name, "designware-i2s.1.auto") == 0) {
+			adata->i2s_play_instance = I2S_SP_INSTANCE;
+			adata->i2ssp_renderbytescount = 0;
+		}
+		if (strcmp(prtd->cpu_dai->name, "designware-i2s.3.auto") == 0) {
+			adata->i2s_play_instance = I2S_BT_INSTANCE;
+			adata->i2sbt_renderbytescount = 0;
+		}
 	} else {
+		if (strcmp(prtd->cpu_dai->name, "designware-i2s.2.auto") == 0) {
+			adata->i2s_capture_instance = I2S_SP_INSTANCE;
+			adata->i2ssp_capturebytescount = 0;
+		}
+		if (strcmp(prtd->cpu_dai->name, "designware-i2s.4.auto") == 0) {
+			adata->i2s_capture_instance = I2S_BT_INSTANCE;
+			adata->i2sbt_capturebytescount = 0;
+		}
 		switch (intr_data->asic_type) {
 		case CHIP_STONEY:
 			runtime->hw = acp_st_pcm_hardware_capture;
@@ -743,11 +759,19 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	 * This enablement is not required for another stream, if current
 	 * stream is not closed
 	*/
-	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
+	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream &&
+		!intr_data->play_i2sbt_stream && !intr_data->capture_i2sbt_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		intr_data->play_i2ssp_stream = substream;
+		switch (adata->i2s_play_instance) {
+		case I2S_BT_INSTANCE:
+			intr_data->play_i2sbt_stream = substream;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			intr_data->play_i2ssp_stream = substream;
+		}
 		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
 		 * Setting SRAM bank state code skipped for STONEY platform.
@@ -758,7 +782,14 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 							bank, true);
 		}
 	} else {
-		intr_data->capture_i2ssp_stream = substream;
+		switch (adata->i2s_capture_instance) {
+		case I2S_BT_INSTANCE:
+			intr_data->capture_i2sbt_stream = substream;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			intr_data->capture_i2ssp_stream = substream;
+		}
 		if (intr_data->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(intr_data->acp_mmio,
@@ -1004,34 +1035,48 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
-	kfree(rtd);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adata->play_i2ssp_stream = NULL;
-		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
-		 * won't be turned off. The default state for SRAM banks is ON.
-		 * Setting SRAM bank state code skipped for STONEY platform.
-		 * added condition checks for Carrizo platform only
-		 */
-		if (adata->asic_type != CHIP_STONEY) {
-			for (bank = 1; bank <= 4; bank++)
-				acp_set_sram_bank_state(adata->acp_mmio, bank,
-				false);
+		switch (rtd->i2s_play_instance) {
+		case I2S_BT_INSTANCE:
+			adata->play_i2sbt_stream = NULL;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->play_i2ssp_stream = NULL;
+			/* For Stoney, Memory gating is disabled,i.e SRAM Banks
+			 * won't be turned off. The default state for SRAM banks is ON.
+			 * Setting SRAM bank state code skipped for STONEY platform.
+			 * added condition checks for Carrizo platform only
+			 */
+			if (adata->asic_type != CHIP_STONEY) {
+				for (bank = 1; bank <= 4; bank++)
+					acp_set_sram_bank_state(adata->acp_mmio, bank,
+							false);
+			}
 		}
 	} else  {
-		adata->capture_i2ssp_stream = NULL;
-		if (adata->asic_type != CHIP_STONEY) {
-			for (bank = 5; bank <= 8; bank++)
-				acp_set_sram_bank_state(adata->acp_mmio, bank,
-						     false);
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
+							bank, false);
+			}
 		}
 	}
 
 	/* Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
 	*/
-	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
+	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
+		!adata->play_i2sbt_stream && !adata->capture_i2sbt_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
+	kfree(rtd);
 
 	return 0;
 }
@@ -1083,6 +1128,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 	audio_drv_data->play_i2ssp_stream = NULL;
 	audio_drv_data->capture_i2ssp_stream = NULL;
+	audio_drv_data->play_i2sbt_stream = NULL;
+	audio_drv_data->capture_i2sbt_stream = NULL;
 
 	audio_drv_data->asic_type =  *pdata;
 
@@ -1171,6 +1218,20 @@ static int acp_pcm_resume(struct device *dev)
 			adata->capture_i2ssp_stream->runtime->private_data,
 			adata->asic_type);
 	}
+	if (adata->asic_type != CHIP_CARRIZO) {
+		if (adata->play_i2sbt_stream &&
+			adata->play_i2sbt_stream->runtime) {
+			config_acp_dma(adata->acp_mmio,
+				adata->play_i2sbt_stream->runtime->private_data,
+				adata->asic_type);
+		}
+		if (adata->capture_i2sbt_stream &&
+			adata->capture_i2sbt_stream->runtime) {
+			config_acp_dma(adata->acp_mmio,
+				adata->capture_i2sbt_stream->runtime->private_data,
+				adata->asic_type);
+		}
+	}
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
 }
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 27803b2..366474f 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -70,6 +70,8 @@
 #define CAPTURE_END_DMA_DESCR_CH15 7
 
 #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
+#define I2S_SP_INSTANCE 1
+#define I2S_BT_INSTANCE 3
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
 	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
@@ -86,12 +88,18 @@ struct audio_substream_data {
 	uint64_t size;
 	u64 i2ssp_renderbytescount;
 	u64 i2ssp_capturebytescount;
+	u64 i2sbt_renderbytescount;
+	u64 i2sbt_capturebytescount;
 	void __iomem *acp_mmio;
+	u16 i2s_play_instance;
+	u16 i2s_capture_instance;
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
