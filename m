From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Ensure reset bit is cleared before
	configuring" to the asoc tree
Date: Mon, 10 Sep 2018 12:35:00 +0100 (BST)
Message-ID: <20180910113500.2C25F1122D51@debutante.sirena.org.uk>
References: <1536566815-3271-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A830C2676ED
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 13:35:02 +0200 (CEST)
In-Reply-To: <1536566815-3271-2-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "Mukunda, , Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Ensure reset bit is cleared before configuring

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

>From 2a665dba016d5493c7d826fec82b0cb643b30d42 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Mon, 10 Sep 2018 13:36:30 +0530
Subject: [PATCH] ASoC: AMD: Ensure reset bit is cleared before configuring

HW register descriptions says:
"DMA Channel Reset...Software must confirm that this bit is
cleared before reprogramming any of the channel configuration registers."
There could be cases where dma stop errored out leaving dma channel
in reset state. We need to ensure that before the start of another dma,
channel is out of the reset state.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index e359938e3d7e..77b265bd0505 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/sizes.h>
 #include <linux/pm_runtime.h>
 
@@ -184,6 +185,24 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
 	acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
 }
 
+static void pre_config_reset(void __iomem *acp_mmio, u16 ch_num)
+{
+	u32 dma_ctrl;
+	int ret;
+
+	/* clear the reset bit */
+	dma_ctrl = acp_reg_read(acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
+	dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChRst_MASK;
+	acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
+	/* check the reset bit before programming configuration registers */
+	ret = readl_poll_timeout(acp_mmio + ((mmACP_DMA_CNTL_0 + ch_num) * 4),
+				 dma_ctrl,
+				 !(dma_ctrl & ACP_DMA_CNTL_0__DMAChRst_MASK),
+				 100, ACP_DMA_RESET_TIME);
+	if (ret < 0)
+		pr_err("Failed to clear reset of channel : %d\n", ch_num);
+}
+
 /*
  * Initialize the DMA descriptor information for transfer between
  * system memory <-> ACP SRAM
@@ -236,6 +255,7 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
 					      &dmadscr[i]);
 	}
+	pre_config_reset(acp_mmio, ch);
 	config_acp_dma_channel(acp_mmio, ch,
 			       dma_dscr_idx - 1,
 			       NUM_DSCRS_PER_CHANNEL,
@@ -275,6 +295,7 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
 					      &dmadscr[i]);
 	}
+	pre_config_reset(acp_mmio, ch);
 	/* Configure the DMA channel with the above descriptore */
 	config_acp_dma_channel(acp_mmio, ch, dma_dscr_idx - 1,
 			       NUM_DSCRS_PER_CHANNEL,
-- 
2.19.0.rc1
