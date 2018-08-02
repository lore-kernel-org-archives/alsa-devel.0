From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH 1/3] ASoC: AMD: Make ACP->SYSMEM DMA non circular
Date: Thu,  2 Aug 2018 12:11:54 +0530
Message-ID: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Guenter Roeck <linux@roeck-us.net>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In capture case we don't want ACP to SYSMEM dma
to be circular. This is because if an in place DSP
filter is applied to captured output then circular DMA
can overwrite the filter value with stale data.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 94bcf69..816abd6 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -400,7 +400,7 @@ static void acp_dma_cap_channel_disable(void __iomem *acp_mmio,
 }
 
 /* Start a given DMA channel transfer */
-static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
+static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num, bool is_circular)
 {
 	u32 dma_ctrl;
 
@@ -429,8 +429,11 @@ static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 		break;
 	}
 
-	/* circular for both DMA channel */
-	dma_ctrl |= ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
+	/* enable for ACP to SRAM DMA channel */
+	if (is_circular == true)
+		dma_ctrl |= ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
+	else
+		dma_ctrl &= ~ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
 
 	acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
 }
@@ -674,6 +677,7 @@ static int acp_deinit(void __iomem *acp_mmio)
 /* ACP DMA irq handler routine for playback, capture usecases */
 static irqreturn_t dma_irq_handler(int irq, void *arg)
 {
+	u16 dscr_idx;
 	u32 intr_flag, ext_intr_status;
 	struct audio_drv_data *irq_data;
 	void __iomem *acp_mmio;
@@ -705,6 +709,15 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_14) ==
+				CAPTURE_START_DMA_DESCR_CH15)
+			dscr_idx = CAPTURE_END_DMA_DESCR_CH14;
+		else
+			dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
+		config_acp_dma_channel(acp_mmio, ACP_TO_SYSRAM_CH_NUM, dscr_idx,
+				       1, 0);
+		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_CH_NUM, false);
+
 		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
 		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
@@ -712,6 +725,17 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_10) ==
+			CAPTURE_START_DMA_DESCR_CH11)
+			dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
+		else
+			dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
+		config_acp_dma_channel(acp_mmio,
+				       ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+				       dscr_idx, 1, 0);
+		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+			      false);
+
 		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
 			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
@@ -1053,9 +1077,11 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				acp_dma_cap_channel_enable(rtd->acp_mmio,
 							   CAP_CHANNEL1);
 			}
+			acp_dma_start(rtd->acp_mmio, rtd->ch1, true);
+		} else {
+			acp_dma_start(rtd->acp_mmio, rtd->ch1, true);
+			acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		}
-		acp_dma_start(rtd->acp_mmio, rtd->ch1);
-		acp_dma_start(rtd->acp_mmio, rtd->ch2);
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
1.9.1
