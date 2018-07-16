From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: For capture have interrupts on I2S->ACP channel" to the asoc tree
Date: Mon, 16 Jul 2018 15:30:28 +0100
Message-ID: <E1ff4WC-0005St-2u@debutante>
References: <1531724566-4019-2-git-send-email-akshu.agrawal@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531724566-4019-2-git-send-email-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Agrawal@sirena.org.uk, Akshu <Akshu.Agrawal@amd.com>
Cc: Akshu Agrawal <akshu.agrawal@amd.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.orgMark Brown <broonie@kernel.org>, "Mukunda,, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>akshu.agrawal@amd.com, Guenter Roeck <linux@roeck-us.net>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: For capture have interrupts on I2S->ACP channel

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

>From 19e023e3befb4cb64b4a81b47a92a0c687672661 Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Mon, 16 Jul 2018 15:02:41 +0800
Subject: [PATCH] ASoC: AMD: For capture have interrupts on I2S->ACP channel

Having interrupts enabled for ACP<->SYSMEM DMA transfer, we are in
for an interrupt storm.
For both playback and capture interrupts should be enabled for
I2S<->ACP DMA.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index eeb867767252..94bcf69008df 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -224,13 +224,11 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 			switch (asic_type) {
 			case CHIP_STONEY:
 				dmadscr[i].xfer_val |=
-				BIT(22) |
 				(ACP_DMA_ATTR_SHARED_MEM_TO_DAGB_GARLIC << 16) |
 				(size / 2);
 				break;
 			default:
 				dmadscr[i].xfer_val |=
-				BIT(22) |
 				(ACP_DMA_ATTR_SHAREDMEM_TO_DAGB_ONION << 16) |
 				(size / 2);
 			}
@@ -421,9 +419,9 @@ static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 
 	switch (ch_num) {
 	case ACP_TO_I2S_DMA_CH_NUM:
-	case ACP_TO_SYSRAM_CH_NUM:
+	case I2S_TO_ACP_DMA_CH_NUM:
 	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
-	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
+	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
@@ -705,18 +703,18 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
-		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
+		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
-			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
+			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-- 
2.18.0.rc2
