From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 5/6] ASoC: AMD: Do not generate interrups for every captured sample
Date: Mon,  2 Jul 2018 15:19:54 -0600
Message-ID: <20180702211956.149355-5-djkurtz@chromium.org>
References: <20180702211956.149355-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702211956.149355-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On capture, audio data is first copied from I2S to ACP memory, and then
from ACP to SYSRAM.  The I2S_TO_ACP_DMA interrupt fires on every sample
transferred from I2S to ACP memory.  That is it fires ~48000 times per
second when capturing @ 48 kHz.  Since we don't do anything on this
interrupt anyway, disable it to save quite a few unnecessary interrupts.
The real "work" (calling snd_pcm_period_elapsed()) is done when transfer
from ACP to SYSRAM is complete.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 2a6a6e65e27c3..ab60129f4f266 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -412,10 +412,8 @@ static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 	switch (ch_num) {
 	case ACP_TO_I2S_DMA_CH_NUM:
 	case ACP_TO_SYSRAM_CH_NUM:
-	case I2S_TO_ACP_DMA_CH_NUM:
 	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
 	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
-	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
@@ -704,12 +702,6 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
-		valid_irq = true;
-		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
-			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
-	}
-
 	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
@@ -718,13 +710,6 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
-		valid_irq = true;
-		acp_reg_write((intr_flag &
-			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
-			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
-	}
-
 	if (valid_irq)
 		return IRQ_HANDLED;
 	else
-- 
2.18.0.399.gad0ab374a1-goog
