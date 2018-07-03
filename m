From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Do not generate interrups for
	every captured sample" to the asoc tree
Date: Tue, 03 Jul 2018 16:34:15 +0100
Message-ID: <E1faNJn-0003l5-IK@debutante>
References: <20180702211956.149355-5-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 46CE526776A
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 17:34:27 +0200 (CEST)
In-Reply-To: <20180702211956.149355-5-djkurtz@chromium.org>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Do not generate interrups for every captured sample

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

>From 8c6b964eddd2c39a9796899b2be099ece1b6c6ca Mon Sep 17 00:00:00 2001
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Mon, 2 Jul 2018 15:19:54 -0600
Subject: [PATCH] ASoC: AMD: Do not generate interrups for every captured
 sample

On capture, audio data is first copied from I2S to ACP memory, and then
from ACP to SYSRAM.  The I2S_TO_ACP_DMA interrupt fires on every sample
transferred from I2S to ACP memory.  That is it fires ~48000 times per
second when capturing @ 48 kHz.  Since we don't do anything on this
interrupt anyway, disable it to save quite a few unnecessary interrupts.
The real "work" (calling snd_pcm_period_elapsed()) is done when transfer
from ACP to SYSRAM is complete.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index df53412967e1..cd4d2520ac14 100644
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
2.18.0.rc2
