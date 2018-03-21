From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: dma driver changes for BT I2S
	controller instance" to the asoc tree
Date: Wed, 21 Mar 2018 01:57:58 +0000 (GMT)
Message-ID: <20180321015758.3787444007A@finisterre.ee.mobilebroadband>
References: <1521533921-21782-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B81882673A4
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 02:58:02 +0100 (CET)
In-Reply-To: <1521533921-21782-1-git-send-email-Vijendar.Mukunda@amd.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: dma driver changes for BT I2S controller instance

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

>From 363fe37948e2b61a95eda08f860e6ba56dfd1aea Mon Sep 17 00:00:00 2001
From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Date: Tue, 20 Mar 2018 13:48:41 +0530
Subject: [PATCH] ASoC: amd: dma driver changes for BT I2S controller instance

With in ACP, There are three I2S controllers can be
configured/enabled ( I2S SP, I2S MICSP, I2S BT).
Default enabled I2S controller instance is I2S SP.
This patch provides required changes to support I2S BT
controller Instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 106 +++++++++++++++++++++++++++++++++++---------
 sound/soc/amd/acp.h         |   7 +++
 2 files changed, 91 insertions(+), 22 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 9d7ab014834e..d09fa59c4ce7 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -704,6 +704,7 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
 	struct audio_drv_data *intr_data = dev_get_drvdata(component->dev);
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(prtd->cpu_dai);
 	struct audio_substream_data *adata =
 		kzalloc(sizeof(struct audio_substream_data), GFP_KERNEL);
 	if (adata == NULL)
@@ -717,7 +718,21 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 		default:
 			runtime->hw = acp_pcm_hardware_playback;
 		}
+		adata->i2s_play_instance = dev->i2s_instance;
+		if (adata->i2s_play_instance == I2S_SP_INSTANCE)
+			adata->i2ssp_renderbytescount = 0;
+		else if (adata->i2s_play_instance == I2S_BT_INSTANCE)
+			adata->i2sbt_renderbytescount = 0;
+		else
+			return -EINVAL;
 	} else {
+		adata->i2s_capture_instance = dev->i2s_instance;
+		if (adata->i2s_capture_instance == I2S_SP_INSTANCE)
+			adata->i2ssp_capturebytescount = 0;
+		else if (adata->i2s_capture_instance == I2S_BT_INSTANCE)
+			adata->i2sbt_capturebytescount = 0;
+		else
+			return -EINVAL;
 		switch (intr_data->asic_type) {
 		case CHIP_STONEY:
 			runtime->hw = acp_st_pcm_hardware_capture;
@@ -743,11 +758,20 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	 * This enablement is not required for another stream, if current
 	 * stream is not closed
 	*/
-	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
+	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream &&
+		!intr_data->play_i2sbt_stream &&
+		!intr_data->capture_i2sbt_stream)
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
@@ -1008,34 +1039,49 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
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
+			 * won't be turned off. The default state for SRAM banks
+			 * is ON.Setting SRAM bank state code skipped for STONEY
+			 * platform.Added condition checks for Carrizo platform
+			 * only.
+			 */
+			if (adata->asic_type != CHIP_STONEY) {
+				for (bank = 1; bank <= 4; bank++)
+					acp_set_sram_bank_state(adata->acp_mmio,
+							bank, false);
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
-	*/
-	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
+	 */
+	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
+		!adata->play_i2sbt_stream && !adata->capture_i2sbt_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
+	kfree(rtd);
 
 	return 0;
 }
@@ -1087,6 +1133,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 	audio_drv_data->play_i2ssp_stream = NULL;
 	audio_drv_data->capture_i2ssp_stream = NULL;
+	audio_drv_data->play_i2sbt_stream = NULL;
+	audio_drv_data->capture_i2sbt_stream = NULL;
 
 	audio_drv_data->asic_type =  *pdata;
 
@@ -1175,6 +1223,20 @@ static int acp_pcm_resume(struct device *dev)
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
index 27803b26fc35..e7ae80f1b1bd 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -4,6 +4,7 @@
 
 #include "include/acp_2_2_d.h"
 #include "include/acp_2_2_sh_mask.h"
+#include "../dwc/local.h"
 
 #define ACP_PAGE_SIZE_4K_ENABLE			0x02
 
@@ -86,12 +87,18 @@ struct audio_substream_data {
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
2.16.2
