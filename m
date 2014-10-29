From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Add PM support to the HSW/BDW
	DSP core.
Date: Wed, 29 Oct 2014 17:40:41 +0000
Message-ID: <1414604443-7712-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CB9122604D4
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 18:44:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add support for PM wake, sleep and stall calls to the core HSW/BDW driver.
This includes reworking the reset and boot code and adding new calls
for setting D3/D0 state.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-dsp.c | 158 ++++++++++++++++++++++++++++----------
 1 file changed, 119 insertions(+), 39 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 5058dc8..86aea34 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -247,8 +247,67 @@ static irqreturn_t hsw_irq(int irq, void *context)
 	return ret;
 }
 
-static void hsw_boot(struct sst_dsp *sst)
+static void hsw_set_dsp_D3(struct sst_dsp *sst)
+{
+	u32 val;
+
+	/* switch off audio PLL, DRAM & IRAM blocks */
+	val = readl(sst->addr.pci_cfg + SST_VDRTCTL0);
+	val |= SST_VDRTCL0_APLLSE_MASK | SST_VDRTCL0_DSRAMPGE_MASK |
+		SST_VDRTCL0_ISRAMPGE_MASK;
+	writel(val, sst->addr.pci_cfg + SST_VDRTCTL0);
+
+	/* Set D3 state */
+	val = readl(sst->addr.pci_cfg + SST_PMCS);
+	val |= SST_PMCS_PS_MASK;
+	writel(val, sst->addr.pci_cfg + SST_PMCS);
+}
+
+static void hsw_reset(struct sst_dsp *sst)
+{
+	/* put DSP into reset and stall */
+	sst_dsp_shim_update_bits_unlocked(sst, SST_CSR,
+		SST_CSR_RST | SST_CSR_STALL,
+		SST_CSR_RST | SST_CSR_STALL);
+
+	/* keep in reset for 10ms */
+	mdelay(10);
+
+	/* take DSP out of reset and keep stalled for FW loading */
+	sst_dsp_shim_update_bits_unlocked(sst, SST_CSR,
+		SST_CSR_RST | SST_CSR_STALL, SST_CSR_STALL);
+}
+
+static int hsw_set_dsp_D0(struct sst_dsp *sst)
 {
+	int tries = 10;
+	u32 reg;
+
+	/* Set D0 state */
+	reg = readl(sst->addr.pci_cfg + SST_PMCS);
+	reg &= ~SST_PMCS_PS_MASK;
+	writel(reg, sst->addr.pci_cfg + SST_PMCS);
+
+	/* check that ADSP shim is enabled */
+	while (tries--) {
+		reg = readl(sst->addr.pci_cfg + SST_PMCS) & SST_PMCS_PS_MASK;
+		if (reg == 0)
+			goto finish;
+
+		msleep(1);
+	}
+
+	return -ENODEV;
+
+finish:
+	hsw_reset(sst);
+
+	/* switch on audio PLL, DRAM & IRAM blocks */
+	reg = readl(sst->addr.pci_cfg + SST_VDRTCTL0);
+	reg &= ~(SST_VDRTCL0_APLLSE_MASK | SST_VDRTCL0_DSRAMPGE_MASK |
+		SST_VDRTCL0_ISRAMPGE_MASK);
+	writel(reg, sst->addr.pci_cfg + SST_VDRTCTL0);
+
 	/* select SSP1 19.2MHz base clock, SSP clock 0, turn off Low Power Clock */
 	sst_dsp_shim_update_bits_unlocked(sst, SST_CSR,
 		SST_CSR_S1IOCS | SST_CSR_SBCS1 | SST_CSR_LPCS, 0x0);
@@ -267,30 +326,73 @@ static void hsw_boot(struct sst_dsp *sst)
 	sst_dsp_shim_update_bits_unlocked(sst, SST_CSR2, SST_CSR2_SDFD_SSP1,
 		SST_CSR2_SDFD_SSP1);
 
-	/* enable DMA engine 0,1 all channels to access host memory */
-	sst_dsp_shim_update_bits_unlocked(sst, SST_HMDC,
-		SST_HMDC_HDDA1(0xff) | SST_HMDC_HDDA0(0xff),
-		SST_HMDC_HDDA1(0xff) | SST_HMDC_HDDA0(0xff));
+	/* set on-demond mode on engine 0,1 for all channels */
+	sst_dsp_shim_update_bits(sst, SST_HMDC,
+			SST_HMDC_HDDA_E0_ALLCH | SST_HMDC_HDDA_E1_ALLCH,
+			SST_HMDC_HDDA_E0_ALLCH | SST_HMDC_HDDA_E1_ALLCH);
+
+	/* Enable Interrupt from both sides */
+	sst_dsp_shim_update_bits(sst, SST_IMRX, (SST_IMRX_BUSY | SST_IMRX_DONE),
+				 0x0);
+	sst_dsp_shim_update_bits(sst, SST_IMRD, (SST_IMRD_DONE | SST_IMRD_BUSY |
+				SST_IMRD_SSP0 | SST_IMRD_DMAC), 0x0);
+
+	/* clear IPC registers */
+	sst_dsp_shim_write(sst, SST_IPCX, 0x0);
+	sst_dsp_shim_write(sst, SST_IPCD, 0x0);
+	sst_dsp_shim_write(sst, 0x80, 0x6);
+	sst_dsp_shim_write(sst, 0xe0, 0x300a);
 
 	/* disable all clock gating */
 	writel(0x0, sst->addr.pci_cfg + SST_VDRTCTL2);
 
+	return 0;
+}
+
+static void hsw_boot(struct sst_dsp *sst)
+{
+	/* set oportunistic mode on engine 0,1 for all channels */
+	sst_dsp_shim_update_bits(sst, SST_HMDC,
+			SST_HMDC_HDDA_E0_ALLCH | SST_HMDC_HDDA_E1_ALLCH, 0);
+
 	/* set DSP to RUN */
 	sst_dsp_shim_update_bits_unlocked(sst, SST_CSR, SST_CSR_STALL, 0x0);
 }
 
-static void hsw_reset(struct sst_dsp *sst)
+static void hsw_stall(struct sst_dsp *sst)
 {
+	/* stall DSP */
+	sst_dsp_shim_update_bits(sst, SST_CSR,
+		SST_CSR_24MHZ_LPCS | SST_CSR_STALL,
+		SST_CSR_STALL | SST_CSR_24MHZ_LPCS);
+}
+
+static void hsw_sleep(struct sst_dsp *sst)
+{
+	dev_dbg(sst->dev, "HSW_PM dsp runtime suspend\n");
+
 	/* put DSP into reset and stall */
-	sst_dsp_shim_update_bits_unlocked(sst, SST_CSR,
-		SST_CSR_RST | SST_CSR_STALL, SST_CSR_RST | SST_CSR_STALL);
+	sst_dsp_shim_update_bits(sst, SST_CSR,
+		SST_CSR_24MHZ_LPCS | SST_CSR_RST | SST_CSR_STALL,
+		SST_CSR_RST | SST_CSR_STALL | SST_CSR_24MHZ_LPCS);
 
-	/* keep in reset for 10ms */
-	mdelay(10);
+	hsw_set_dsp_D3(sst);
+	dev_dbg(sst->dev, "HSW_PM dsp runtime suspend exit\n");
+}
 
-	/* take DSP out of reset and keep stalled for FW loading */
-	sst_dsp_shim_update_bits_unlocked(sst, SST_CSR,
-		SST_CSR_RST | SST_CSR_STALL, SST_CSR_STALL);
+static int hsw_wake(struct sst_dsp *sst)
+{
+	int ret;
+
+	dev_dbg(sst->dev, "HSW_PM dsp runtime resume\n");
+
+	ret = hsw_set_dsp_D0(sst);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(sst->dev, "HSW_PM dsp runtime resume exit\n");
+
+	return 0;
 }
 
 struct sst_adsp_memregion {
@@ -431,27 +533,6 @@ static struct sst_block_ops sst_hsw_ops = {
 	.disable = hsw_block_disable,
 };
 
-static int hsw_enable_shim(struct sst_dsp *sst)
-{
-	int tries = 10;
-	u32 reg;
-
-	/* enable shim */
-	reg = readl(sst->addr.pci_cfg + SST_SHIM_PM_REG);
-	writel(reg & ~0x3, sst->addr.pci_cfg + SST_SHIM_PM_REG);
-
-	/* check that ADSP shim is enabled */
-	while (tries--) {
-		reg = sst_dsp_shim_read_unlocked(sst, SST_CSR);
-		if (reg != 0xffffffff)
-			return 0;
-
-		msleep(1);
-	}
-
-	return -ENODEV;
-}
-
 static int hsw_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 {
 	const struct sst_adsp_memregion *region;
@@ -490,7 +571,7 @@ static int hsw_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 	}
 
 	/* enable the DSP SHIM */
-	ret = hsw_enable_shim(sst);
+	ret = hsw_set_dsp_D0(sst);
 	if (ret < 0) {
 		dev_err(dev, "error: failed to set DSP D0 and reset SHIM\n");
 		return ret;
@@ -500,10 +581,6 @@ static int hsw_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 	if (ret)
 		return ret;
 
-	/* Enable Interrupt from both sides */
-	sst_dsp_shim_update_bits_unlocked(sst, SST_IMRX, 0x3, 0x0);
-	sst_dsp_shim_update_bits_unlocked(sst, SST_IMRD,
-		(0x3 | 0x1 << 16 | 0x3 << 21), 0x0);
 
 	/* register DSP memory blocks - ideally we should get this from ACPI */
 	for (i = 0; i < region_count; i++) {
@@ -535,6 +612,9 @@ static void hsw_free(struct sst_dsp *sst)
 struct sst_ops haswell_ops = {
 	.reset = hsw_reset,
 	.boot = hsw_boot,
+	.stall = hsw_stall,
+	.wake = hsw_wake,
+	.sleep = hsw_sleep,
 	.write = sst_shim32_write,
 	.read = sst_shim32_read,
 	.write64 = sst_shim32_write64,
-- 
2.1.0
