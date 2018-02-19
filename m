From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: renaming pcm substream names and
	bytescount params" to the asoc tree
Date: Mon, 19 Feb 2018 16:57:32 +0000
Message-ID: <E1enoku-0002GM-Gs@debutante>
References: <1518766434-7911-2-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 01362267440
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 17:57:37 +0100 (CET)
In-Reply-To: <1518766434-7911-2-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mukunda@sirena.org.uk
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: renaming pcm substream names and bytescount params

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e21358c43b426301aefef27c498eee2e2525b3ce Mon Sep 17 00:00:00 2001
From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Date: Fri, 16 Feb 2018 13:03:46 +0530
Subject: [PATCH] ASoC: amd: renaming pcm substream names and bytescount params

With in ACP, There are three I2S controllers can be configured.
(I2S SP ,I2S MICSP and I2S BT).These controllers can
support both playback/capture scenarios.
Default enabled i2s controller instance is i2s sp instance.

Renamed stream names and bytescount params as i2ssp.
These changes required to distinguish with other I2S controller
instance pcm substreams and bytescount params.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 49 +++++++++++++++++++++++----------------------
 sound/soc/amd/acp.h         |  8 ++++----
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index c33a512283a4..3c39a0d8125d 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -662,7 +662,7 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 				       1, 0);
 		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_CH_NUM, false);
 
-		snd_pcm_period_elapsed(irq_data->play_stream);
+		snd_pcm_period_elapsed(irq_data->play_i2ssp_stream);
 
 		acp_reg_write((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) << 16,
 				acp_mmio, mmACP_EXTERNAL_INTR_STAT);
@@ -685,7 +685,7 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
 		valid_irq = true;
-		snd_pcm_period_elapsed(irq_data->capture_stream);
+		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
 		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
 				acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
@@ -743,11 +743,11 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	 * This enablement is not required for another stream, if current
 	 * stream is not closed
 	*/
-	if (!intr_data->play_stream && !intr_data->capture_stream)
+	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		intr_data->play_stream = substream;
+		intr_data->play_i2ssp_stream = substream;
 		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
 		 * Setting SRAM bank state code skipped for STONEY platform.
@@ -758,7 +758,7 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 							bank, true);
 		}
 	} else {
-		intr_data->capture_stream = substream;
+		intr_data->capture_i2ssp_stream = substream;
 		if (intr_data->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(intr_data->acp_mmio,
@@ -857,11 +857,11 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (bytescount > rtd->renderbytescount)
-			bytescount = bytescount - rtd->renderbytescount;
+		if (bytescount > rtd->i2ssp_renderbytescount)
+			bytescount = bytescount - rtd->i2ssp_renderbytescount;
 	} else {
-		if (bytescount > rtd->capturebytescount)
-			bytescount = bytescount - rtd->capturebytescount;
+		if (bytescount > rtd->i2ssp_capturebytescount)
+			bytescount = bytescount - rtd->i2ssp_capturebytescount;
 	}
 	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(runtime, pos);
@@ -917,8 +917,8 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		bytescount = acp_get_byte_count(rtd->acp_mmio,
 						substream->stream);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			if (rtd->renderbytescount == 0)
-				rtd->renderbytescount = bytescount;
+			if (rtd->i2ssp_renderbytescount == 0)
+				rtd->i2ssp_renderbytescount = bytescount;
 			acp_dma_start(rtd->acp_mmio,
 						SYSRAM_TO_ACP_CH_NUM, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
@@ -935,8 +935,8 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 					ACP_TO_I2S_DMA_CH_NUM, true);
 
 		} else {
-			if (rtd->capturebytescount == 0)
-				rtd->capturebytescount = bytescount;
+			if (rtd->i2ssp_capturebytescount == 0)
+				rtd->i2ssp_capturebytescount = bytescount;
 			acp_dma_start(rtd->acp_mmio,
 					    I2S_TO_ACP_DMA_CH_NUM, true);
 		}
@@ -953,11 +953,11 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			ret = acp_dma_stop(rtd->acp_mmio,
 					ACP_TO_I2S_DMA_CH_NUM);
-			rtd->renderbytescount = 0;
+			rtd->i2ssp_renderbytescount = 0;
 		} else {
 			ret = acp_dma_stop(rtd->acp_mmio,
 					I2S_TO_ACP_DMA_CH_NUM);
-			rtd->capturebytescount = 0;
+			rtd->i2ssp_capturebytescount = 0;
 		}
 		break;
 	default:
@@ -1003,7 +1003,7 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	kfree(rtd);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adata->play_stream = NULL;
+		adata->play_i2ssp_stream = NULL;
 		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
 		 * Setting SRAM bank state code skipped for STONEY platform.
@@ -1015,7 +1015,7 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 				false);
 		}
 	} else  {
-		adata->capture_stream = NULL;
+		adata->capture_i2ssp_stream = NULL;
 		if (adata->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
@@ -1026,7 +1026,7 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	/* Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
 	*/
-	if (!adata->play_stream && !adata->capture_stream)
+	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	return 0;
@@ -1076,8 +1076,9 @@ static int acp_audio_probe(struct platform_device *pdev)
 	 * and device doesn't generate any interrupts.
 	 */
 
-	audio_drv_data->play_stream = NULL;
-	audio_drv_data->capture_stream = NULL;
+	audio_drv_data->play_i2ssp_stream = NULL;
+	audio_drv_data->capture_i2ssp_stream = NULL;
+
 	audio_drv_data->asic_type =  *pdata;
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
@@ -1141,7 +1142,7 @@ static int acp_pcm_resume(struct device *dev)
 		return status;
 	}
 
-	if (adata->play_stream && adata->play_stream->runtime) {
+	if (adata->play_i2ssp_stream && adata->play_i2ssp_stream->runtime) {
 		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
 		 * Setting SRAM bank state code skipped for STONEY platform.
@@ -1152,17 +1153,17 @@ static int acp_pcm_resume(struct device *dev)
 						true);
 		}
 		config_acp_dma(adata->acp_mmio,
-			adata->play_stream->runtime->private_data,
+			adata->play_i2ssp_stream->runtime->private_data,
 			adata->asic_type);
 	}
-	if (adata->capture_stream && adata->capture_stream->runtime) {
+	if (adata->capture_i2ssp_stream && adata->capture_i2ssp_stream->runtime) {
 		if (adata->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
 						true);
 		}
 		config_acp_dma(adata->acp_mmio,
-			adata->capture_stream->runtime->private_data,
+			adata->capture_i2ssp_stream->runtime->private_data,
 			adata->asic_type);
 	}
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index ecb458935d1e..27803b26fc35 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -84,14 +84,14 @@ struct audio_substream_data {
 	u16 num_of_pages;
 	u16 direction;
 	uint64_t size;
-	u64 renderbytescount;
-	u64 capturebytescount;
+	u64 i2ssp_renderbytescount;
+	u64 i2ssp_capturebytescount;
 	void __iomem *acp_mmio;
 };
 
 struct audio_drv_data {
-	struct snd_pcm_substream *play_stream;
-	struct snd_pcm_substream *capture_stream;
+	struct snd_pcm_substream *play_i2ssp_stream;
+	struct snd_pcm_substream *capture_i2ssp_stream;
 	void __iomem *acp_mmio;
 	u32 asic_type;
 };
-- 
2.16.1
