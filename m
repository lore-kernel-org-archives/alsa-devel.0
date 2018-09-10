From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH 2/2] ASoC: AMD: Ensure reset bit is cleared
	before configuring
Date: Mon, 10 Sep 2018 13:36:30 +0530
Message-ID: <1536566815-3271-2-git-send-email-akshu.agrawal@amd.com>
References: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730085.outbound.protection.outlook.com [40.107.73.85])
 by alsa0.perex.cz (Postfix) with ESMTP id EFE33266E0E
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 10:07:43 +0200 (CEST)
In-Reply-To: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, Mark Brown <broonie@kernel.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

HW register descriptions says:
"DMA Channel Reset...Software must confirm that this bit is
cleared before reprogramming any of the channel configuration registers."
There could be cases where dma stop errored out leaving dma channel
in reset state. We need to ensure that before the start of another dma,
channel is out of the reset state.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index e359938..77b265b 100644
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
1.9.1
