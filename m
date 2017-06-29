From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v2 3/4] ASoC: Intel: common: Add sram address
	to sst_addr structure
Date: Thu, 29 Jun 2017 12:26:03 +0530
Message-ID: <20170629065604.30105-4-guneshwor.o.singh@intel.com>
References: <20170629065604.30105-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 04D9A26729C
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 08:57:22 +0200 (CEST)
In-Reply-To: <20170629065604.30105-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

SRAM address and memory window size differ for different platforms.
So add members to sst_addr structure and initialize them in the
respective dsp_init().

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/common/sst-dsp-priv.h | 4 ++++
 sound/soc/intel/skylake/bxt-sst.c     | 4 ++++
 sound/soc/intel/skylake/skl-sst.c     | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index d13c84364c3c..8734040d64d3 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -77,6 +77,10 @@ struct sst_addr {
 	u32 dram_offset;
 	u32 dsp_iram_offset;
 	u32 dsp_dram_offset;
+	u32 sram0_base;
+	u32 sram1_base;
+	u32 w0_stat_sz;
+	u32 w0_up_sz;
 	void __iomem *lpe;
 	void __iomem *shim;
 	void __iomem *pci_cfg;
diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index f5e7dbb1ba39..cf11b84888b9 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -573,6 +573,10 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst->fw_ops = bxt_fw_ops;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
+	sst->addr.sram0_base = BXT_ADSP_SRAM0_BASE;
+	sst->addr.sram1_base = BXT_ADSP_SRAM1_BASE;
+	sst->addr.w0_stat_sz = SKL_ADSP_W0_STAT_SZ;
+	sst->addr.w0_up_sz = SKL_ADSP_W0_UP_SZ;
 
 	sst_dsp_mailbox_init(sst, (BXT_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, BXT_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 155e456b7a3a..aba9ea11ac74 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -553,6 +553,11 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst = skl->dsp;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
+	sst->addr.sram0_base = SKL_ADSP_SRAM0_BASE;
+	sst->addr.sram1_base = SKL_ADSP_SRAM1_BASE;
+	sst->addr.w0_stat_sz = SKL_ADSP_W0_STAT_SZ;
+	sst->addr.w0_up_sz = SKL_ADSP_W0_UP_SZ;
+
 	sst_dsp_mailbox_init(sst, (SKL_ADSP_SRAM0_BASE + SKL_ADSP_W0_STAT_SZ),
 			SKL_ADSP_W0_UP_SZ, SKL_ADSP_SRAM1_BASE, SKL_ADSP_W1_SZ);
 
-- 
2.13.0
