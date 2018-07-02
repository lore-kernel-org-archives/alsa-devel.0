From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 4/6] ASoC: AMD: Fix Capture DMA channel names
Date: Mon,  2 Jul 2018 15:19:53 -0600
Message-ID: <20180702211956.149355-4-djkurtz@chromium.org>
References: <20180702211956.149355-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702211956.149355-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On capture, audio data is first copied from I2S to ACP memory, and then
to SYSRAM.  For each step the channel number increases, so the names in
the driver were wrong.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 24 ++++++++++++------------
 sound/soc/amd/acp.h         |  8 ++++----
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 224383fef0c3a..2a6a6e65e27c3 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -697,31 +697,31 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
-		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
+		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
-		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
+		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
-			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		acp_reg_write((intr_flag &
-			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
+			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
@@ -899,8 +899,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		switch (rtd->i2s_instance) {
 		case I2S_BT_INSTANCE:
 			rtd->pte_offset = ACP_ST_BT_CAPTURE_PTE_OFFSET;
-			rtd->ch1 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
-			rtd->ch2 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			rtd->ch1 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			rtd->ch2 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
 			rtd->sram_bank = ACP_SRAM_BANK_4_ADDRESS;
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
@@ -914,8 +914,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		case I2S_SP_INSTANCE:
 		default:
 			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
-			rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
-			rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
+			rtd->ch1 = I2S_TO_ACP_DMA_CH_NUM;
+			rtd->ch2 = ACP_TO_SYSRAM_CH_NUM;
 			switch (adata->asic_type) {
 			case CHIP_STONEY:
 				rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 3190fdce63074..0a2240bff62e1 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -74,16 +74,16 @@
 #define ACP_TO_I2S_DMA_CH_NUM 13
 
 /* Capture DMA channels */
-#define ACP_TO_SYSRAM_CH_NUM 14
-#define I2S_TO_ACP_DMA_CH_NUM 15
+#define I2S_TO_ACP_DMA_CH_NUM 14
+#define ACP_TO_SYSRAM_CH_NUM 15
 
 /* Playback DMA Channels for I2S BT instance */
 #define SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM  8
 #define ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM 9
 
 /* Capture DMA Channels for I2S BT Instance */
-#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 10
-#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 11
+#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 10
+#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 11
 
 #define NUM_DSCRS_PER_CHANNEL 2
 
-- 
2.18.0.399.gad0ab374a1-goog
