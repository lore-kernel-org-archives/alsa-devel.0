From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 5/9] ASoC: amd: Interrupt handler changes for
	BT I2S instance
Date: Fri, 16 Feb 2018 13:03:50 +0530
Message-ID: <1518766434-7911-6-git-send-email-Vijendar.Mukunda@amd.com>
References: <1518766434-7911-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0062.outbound.protection.outlook.com [104.47.34.62])
 by alsa0.perex.cz (Postfix) with ESMTP id C94A5267D86
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 08:32:23 +0100 (CET)
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
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, lgirdwood@gmail.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

Interrupt handler changes for BT I2S instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index aaee70f..b1c1ff2 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -728,6 +728,21 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 				acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_9) ==
+			PLAYBACK_START_DMA_DESCR_CH9)
+			dscr_idx = PLAYBACK_END_DMA_DESCR_CH8;
+		else
+			dscr_idx = PLAYBACK_START_DMA_DESCR_CH8;
+		config_acp_dma_channel(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM, dscr_idx,
+				1, 0);
+		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM, false);
+		snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
+		acp_reg_write((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
 		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_15) ==
@@ -750,6 +765,27 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 				acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_11) ==
+			CAPTURE_START_DMA_DESCR_CH11)
+			dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
+		else
+			dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
+		config_acp_dma_channel(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM, dscr_idx,
+				1, 0);
+		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM, false);
+		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
+				acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
+	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
+		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
+			acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if (valid_irq)
 		return IRQ_HANDLED;
 	else
-- 
2.7.4
