From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Always enable DRAM block for FW
	dump
Date: Thu,  8 Jan 2015 20:12:52 +0800
Message-ID: <1420719172-28777-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C5FA260410
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 13:11:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The first 512 bytes of data DRAM memory is used for FW dump,
and this first data SRAM block should be never power gated
(always on), here always enable the block(DSRAM[0]) for D0
stage.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-dsp.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 57039b0..c42ffae 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -306,7 +306,7 @@ static void hsw_reset(struct sst_dsp *sst)
 static int hsw_set_dsp_D0(struct sst_dsp *sst)
 {
 	int tries = 10;
-	u32 reg;
+	u32 reg, fw_dump_bit;
 
 	/* Disable core clock gating (VDRTCTL2.DCLCGE = 0) */
 	reg = readl(sst->addr.pci_cfg + SST_VDRTCTL2);
@@ -368,7 +368,9 @@ finish:
 	can't be accessed, please enable each block before accessing. */
 	reg = readl(sst->addr.pci_cfg + SST_VDRTCTL0);
 	reg |= SST_VDRTCL0_DSRAMPGE_MASK | SST_VDRTCL0_ISRAMPGE_MASK;
-	writel(reg, sst->addr.pci_cfg + SST_VDRTCTL0);
+	/* for D0, always enable the block(DSRAM[0]) used for FW dump */
+	fw_dump_bit = 1 << SST_VDRTCL0_DSRAMPGE_SHIFT;
+	writel(reg & ~fw_dump_bit, sst->addr.pci_cfg + SST_VDRTCTL0);
 
 
 	/* disable DMA finish function for SSP0 & SSP1 */
@@ -491,6 +493,7 @@ static const struct sst_sram_shift sram_shift[] = {
 	{SST_DEV_ID_LYNX_POINT, 6, 16}, /* lp */
 	{SST_DEV_ID_WILDCAT_POINT, 2, 12}, /* wpt */
 };
+
 static u32 hsw_block_get_bit(struct sst_mem_block *block)
 {
 	u32 bit = 0, shift = 0, index;
@@ -587,7 +590,9 @@ static int hsw_block_disable(struct sst_mem_block *block)
 
 	val = readl(sst->addr.pci_cfg + SST_VDRTCTL0);
 	bit = hsw_block_get_bit(block);
-	writel(val | bit, sst->addr.pci_cfg + SST_VDRTCTL0);
+	/* don't disable DSRAM[0], keep it always enable for FW dump*/
+	if (bit != (1 << SST_VDRTCL0_DSRAMPGE_SHIFT))
+		writel(val | bit, sst->addr.pci_cfg + SST_VDRTCTL0);
 
 	/* wait 18 DSP clock ticks */
 	udelay(10);
@@ -612,7 +617,7 @@ static int hsw_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 	const struct sst_adsp_memregion *region;
 	struct device *dev;
 	int ret = -ENODEV, i, j, region_count;
-	u32 offset, size;
+	u32 offset, size, fw_dump_bit;
 
 	dev = sst->dma_dev;
 
@@ -669,9 +674,11 @@ static int hsw_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 		}
 	}
 
+	/* always enable the block(DSRAM[0]) used for FW dump */
+	fw_dump_bit = 1 << SST_VDRTCL0_DSRAMPGE_SHIFT;
 	/* set default power gating control, enable power gating control for all blocks. that is,
 	can't be accessed, please enable each block before accessing. */
-	writel(0xffffffff, sst->addr.pci_cfg + SST_VDRTCTL0);
+	writel(0xffffffff & ~fw_dump_bit, sst->addr.pci_cfg + SST_VDRTCTL0);
 
 	return 0;
 }
-- 
1.9.1
