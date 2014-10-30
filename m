From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Work around to fix HW D3
	potential crash issue
Date: Thu, 30 Oct 2014 22:57:58 +0800
Message-ID: <1414681078-11409-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 658E82605A2
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 15:57:54 +0100 (CET)
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

When using clock gatings to save power, there are some known issues:
1. core clock gating (DCLCGE) must be disabled during D0 and D3 entry
and updating SRAM banks (VDRTCTL0).
2. DSP trunk clock gating (DTCGE) can cause FW crashes, disable it in D0.

To align with the new W/A flow from FW team, we must set VDRTCTL0.D3PGD
to 1 (D3 power gating disabled) at first startup and keep it all the time.
ADSP will be in D0 on first boot by BIOS part of WA. Required delays must
be preserved (waiting for HW to stabilize, after enabling CCG, changing
SRAM PG, D3PG).

D3->D0:
1. Disable core clock gating (VDRTCTL2.DCLCGE = 0)
2. Enable other CG apart from DTCG and DCLCG (VDRTCTL2. DCLCGE and DTCGE = 0)
3. Disable D3PG (VDRTCTL0.D3PGD = 1)
4. Power up necessary SRAM and wait at least for 18 clock cycles for every
bank you have powered up
5. Set D0 state(PMCS.PS = 0), wait for HW
6. Restore MCLK (clkctl.smos, disabled in D3 entry point 4)
7. Stall and reset core, set CSR
8. Enable core clock gating (VDRTCTL2.DCLCGE = 1), delay 50 us
9. Unreset core
10.Load FW, configure PLL and other necessary things
11.Unstall core

Changing SRAM PG during D0:
1. Disable core clock gating (VDRTCTL2.DCLCGE = 0)
2. Set PG mask
3. Wait at least for 18 clock cycles for every bank you have powered up
4. Enable core clock gating, delay 50 us

D0->D3:
1. Disable core clock gating (DCLCGE = 0)
2. Stall and reset core
3. Power down entire SRAM and wait at least for 18 clock cycles for every bank
(Enable SRAM PG (ISRAMPGE = 0x3FF, DSRAMPGE = 0xFFFFF, D3SRAMPGD = 0), remember
about preserving VDRTCTL0.D3PGD = 1)
4. Shutdown PLL, disable MCLK(clkctl.smos = 0), Enable DTCG to save power
5. Set D3 state(PMCS.PS = 3), delay 50 us
6. Enable core clock gating, delay 50 us

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-dsp.h         |  14 ++++--
 sound/soc/intel/sst-haswell-dsp.c | 102 ++++++++++++++++++++++++++++++++------
 2 files changed, 98 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index 2753b85..f291e32 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -159,12 +159,18 @@
 #define SST_VDRTCTL3		0xaC
 
 /* VDRTCTL0 */
-#define SST_VDRTCL0_APLLSE_MASK		1
-#define SST_VDRTCL0_DSRAMPGE_SHIFT	16
-#define SST_VDRTCL0_DSRAMPGE_MASK	(0xffff << SST_VDRTCL0_DSRAMPGE_SHIFT)
-#define SST_VDRTCL0_ISRAMPGE_SHIFT	6
+#define SST_VDRTCL0_D3PGD		(1 << 0)
+#define SST_VDRTCL0_D3SRAMPGD		(1 << 1)
+#define SST_VDRTCL0_DSRAMPGE_SHIFT	12
+#define SST_VDRTCL0_DSRAMPGE_MASK	(0xfffff << SST_VDRTCL0_DSRAMPGE_SHIFT)
+#define SST_VDRTCL0_ISRAMPGE_SHIFT	2
 #define SST_VDRTCL0_ISRAMPGE_MASK	(0x3ff << SST_VDRTCL0_ISRAMPGE_SHIFT)
 
+/* VDRTCTL2 */
+#define SST_VDRTCL2_DCLCGE		(1 << 1)
+#define SST_VDRTCL2_DTCGE		(1 << 10)
+#define SST_VDRTCL2_APLLSE_MASK		(1 << 31)
+
 /* PMCS */
 #define SST_PMCS		0x84
 #define SST_PMCS_PS_MASK	0x3
diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 86aea34..57039b0 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -250,17 +250,42 @@ static irqreturn_t hsw_irq(int irq, void *context)
 static void hsw_set_dsp_D3(struct sst_dsp *sst)
 {
 	u32 val;
+	u32 reg;
+
+	/* Disable core clock gating (VDRTCTL2.DCLCGE = 0) */
+	reg = readl(sst->addr.pci_cfg + SST_VDRTCTL2);
+	reg &= ~(SST_VDRTCL2_DCLCGE | SST_VDRTCL2_DTCGE);
+	writel(reg, sst->addr.pci_cfg + SST_VDRTCTL2);
 
-	/* switch off audio PLL, DRAM & IRAM blocks */
+	/* enable power gating and switch off DRAM & IRAM blocks */
 	val = readl(sst->addr.pci_cfg + SST_VDRTCTL0);
-	val |= SST_VDRTCL0_APLLSE_MASK | SST_VDRTCL0_DSRAMPGE_MASK |
+	val |= SST_VDRTCL0_DSRAMPGE_MASK |
 		SST_VDRTCL0_ISRAMPGE_MASK;
+	val &= ~(SST_VDRTCL0_D3PGD | SST_VDRTCL0_D3SRAMPGD);
 	writel(val, sst->addr.pci_cfg + SST_VDRTCTL0);
 
-	/* Set D3 state */
+	/* switch off audio PLL */
+	val = readl(sst->addr.pci_cfg + SST_VDRTCTL2);
+	val |= SST_VDRTCL2_APLLSE_MASK;
+	writel(val, sst->addr.pci_cfg + SST_VDRTCTL2);
+
+	/* disable MCLK(clkctl.smos = 0) */
+	sst_dsp_shim_update_bits_unlocked(sst, SST_CLKCTL,
+		SST_CLKCTL_MASK, 0);
+
+	/* Set D3 state, delay 50 us */
 	val = readl(sst->addr.pci_cfg + SST_PMCS);
 	val |= SST_PMCS_PS_MASK;
 	writel(val, sst->addr.pci_cfg + SST_PMCS);
+	udelay(50);
+
+	/* Enable core clock gating (VDRTCTL2.DCLCGE = 1), delay 50 us */
+	reg = readl(sst->addr.pci_cfg + SST_VDRTCTL2);
+	reg |= SST_VDRTCL2_DCLCGE | SST_VDRTCL2_DTCGE;
+	writel(reg, sst->addr.pci_cfg + SST_VDRTCTL2);
+
+	udelay(50);
+
 }
 
 static void hsw_reset(struct sst_dsp *sst)
@@ -283,6 +308,16 @@ static int hsw_set_dsp_D0(struct sst_dsp *sst)
 	int tries = 10;
 	u32 reg;
 
+	/* Disable core clock gating (VDRTCTL2.DCLCGE = 0) */
+	reg = readl(sst->addr.pci_cfg + SST_VDRTCTL2);
+	reg &= ~(SST_VDRTCL2_DCLCGE | SST_VDRTCL2_DTCGE);
+	writel(reg, sst->addr.pci_cfg + SST_VDRTCTL2);
+
+	/* Disable D3PG (VDRTCTL0.D3PGD = 1) */
+	reg = readl(sst->addr.pci_cfg + SST_VDRTCTL0);
+	reg |= SST_VDRTCL0_D3PGD;
+	writel(reg, sst->addr.pci_cfg + SST_VDRTCTL0);
+
 	/* Set D0 state */
 	reg = readl(sst->addr.pci_cfg + SST_PMCS);
 	reg &= ~SST_PMCS_PS_MASK;
@@ -300,14 +335,6 @@ static int hsw_set_dsp_D0(struct sst_dsp *sst)
 	return -ENODEV;
 
 finish:
-	hsw_reset(sst);
-
-	/* switch on audio PLL, DRAM & IRAM blocks */
-	reg = readl(sst->addr.pci_cfg + SST_VDRTCTL0);
-	reg &= ~(SST_VDRTCL0_APLLSE_MASK | SST_VDRTCL0_DSRAMPGE_MASK |
-		SST_VDRTCL0_ISRAMPGE_MASK);
-	writel(reg, sst->addr.pci_cfg + SST_VDRTCTL0);
-
 	/* select SSP1 19.2MHz base clock, SSP clock 0, turn off Low Power Clock */
 	sst_dsp_shim_update_bits_unlocked(sst, SST_CSR,
 		SST_CSR_S1IOCS | SST_CSR_SBCS1 | SST_CSR_LPCS, 0x0);
@@ -322,6 +349,28 @@ finish:
 		SST_CLKCTL_MASK | SST_CLKCTL_DCPLCG | SST_CLKCTL_SCOE0,
 		SST_CLKCTL_MASK | SST_CLKCTL_DCPLCG | SST_CLKCTL_SCOE0);
 
+	/* Stall and reset core, set CSR */
+	hsw_reset(sst);
+
+	/* Enable core clock gating (VDRTCTL2.DCLCGE = 1), delay 50 us */
+	reg = readl(sst->addr.pci_cfg + SST_VDRTCTL2);
+	reg |= SST_VDRTCL2_DCLCGE | SST_VDRTCL2_DTCGE;
+	writel(reg, sst->addr.pci_cfg + SST_VDRTCTL2);
+
+	udelay(50);
+
+	/* switch on audio PLL */
+	reg = readl(sst->addr.pci_cfg + SST_VDRTCTL2);
+	reg &= ~SST_VDRTCL2_APLLSE_MASK;
+	writel(reg, sst->addr.pci_cfg + SST_VDRTCTL2);
+
+	/* set default power gating control, enable power gating control for all blocks. that is,
+	can't be accessed, please enable each block before accessing. */
+	reg = readl(sst->addr.pci_cfg + SST_VDRTCTL0);
+	reg |= SST_VDRTCL0_DSRAMPGE_MASK | SST_VDRTCL0_ISRAMPGE_MASK;
+	writel(reg, sst->addr.pci_cfg + SST_VDRTCTL0);
+
+
 	/* disable DMA finish function for SSP0 & SSP1 */
 	sst_dsp_shim_update_bits_unlocked(sst, SST_CSR2, SST_CSR2_SDFD_SSP1,
 		SST_CSR2_SDFD_SSP1);
@@ -343,9 +392,6 @@ finish:
 	sst_dsp_shim_write(sst, 0x80, 0x6);
 	sst_dsp_shim_write(sst, 0xe0, 0x300a);
 
-	/* disable all clock gating */
-	writel(0x0, sst->addr.pci_cfg + SST_VDRTCTL2);
-
 	return 0;
 }
 
@@ -497,6 +543,11 @@ static int hsw_block_enable(struct sst_mem_block *block)
 	dev_dbg(block->dsp->dev, " enabled block %d:%d at offset 0x%x\n",
 		block->type, block->index, block->offset);
 
+	/* Disable core clock gating (VDRTCTL2.DCLCGE = 0) */
+	val = readl(sst->addr.pci_cfg + SST_VDRTCTL2);
+	val &= ~SST_VDRTCL2_DCLCGE;
+	writel(val, sst->addr.pci_cfg + SST_VDRTCTL2);
+
 	val = readl(sst->addr.pci_cfg + SST_VDRTCTL0);
 	bit = hsw_block_get_bit(block);
 	writel(val & ~bit, sst->addr.pci_cfg + SST_VDRTCTL0);
@@ -504,6 +555,13 @@ static int hsw_block_enable(struct sst_mem_block *block)
 	/* wait 18 DSP clock ticks */
 	udelay(10);
 
+	/* Enable core clock gating (VDRTCTL2.DCLCGE = 1), delay 50 us */
+	val = readl(sst->addr.pci_cfg + SST_VDRTCTL2);
+	val |= SST_VDRTCL2_DCLCGE;
+	writel(val, sst->addr.pci_cfg + SST_VDRTCTL2);
+
+	udelay(50);
+
 	/*add a dummy read before the SRAM block is written, otherwise the writing may miss bytes sometimes.*/
 	sst_mem_block_dummy_read(block);
 	return 0;
@@ -521,10 +579,26 @@ static int hsw_block_disable(struct sst_mem_block *block)
 	dev_dbg(block->dsp->dev, " disabled block %d:%d at offset 0x%x\n",
 		block->type, block->index, block->offset);
 
+	/* Disable core clock gating (VDRTCTL2.DCLCGE = 0) */
+	val = readl(sst->addr.pci_cfg + SST_VDRTCTL2);
+	val &= ~SST_VDRTCL2_DCLCGE;
+	writel(val, sst->addr.pci_cfg + SST_VDRTCTL2);
+
+
 	val = readl(sst->addr.pci_cfg + SST_VDRTCTL0);
 	bit = hsw_block_get_bit(block);
 	writel(val | bit, sst->addr.pci_cfg + SST_VDRTCTL0);
 
+	/* wait 18 DSP clock ticks */
+	udelay(10);
+
+	/* Enable core clock gating (VDRTCTL2.DCLCGE = 1), delay 50 us */
+	val = readl(sst->addr.pci_cfg + SST_VDRTCTL2);
+	val |= SST_VDRTCL2_DCLCGE;
+	writel(val, sst->addr.pci_cfg + SST_VDRTCTL2);
+
+	udelay(50);
+
 	return 0;
 }
 
-- 
1.9.1
