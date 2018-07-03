From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Fix Capture DMA channel names" to
	the asoc tree
Date: Tue, 03 Jul 2018 16:34:17 +0100
Message-ID: <E1faNJp-0003mJ-Mm@debutante>
References: <20180702211956.149355-4-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 83DDD267763
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 17:34:25 +0200 (CEST)
In-Reply-To: <20180702211956.149355-4-djkurtz@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, "Mukunda, ,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Fix Capture DMA channel names

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

>From 55af49ac1b8627dfbfa2689af118d994d7a0ba1b Mon Sep 17 00:00:00 2001
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Mon, 2 Jul 2018 15:19:53 -0600
Subject: [PATCH] ASoC: AMD: Fix Capture DMA channel names

On capture, audio data is first copied from I2S to ACP memory, and then
to SYSRAM.  For each step the channel number increases, so the names in
the driver were wrong.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 24 ++++++++++++------------
 sound/soc/amd/acp.h         |  8 ++++----
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 034fac3de037..df53412967e1 100644
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
index 3190fdce6307..0a2240bff62e 100644
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
2.18.0.rc2
