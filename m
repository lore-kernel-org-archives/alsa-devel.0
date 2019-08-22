From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 20/35] ASoC: Intel: Skylake: Remove redundant
	SRAM fields
Date: Thu, 22 Aug 2019 21:04:10 +0200
Message-ID: <20190822190425.23001-21-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8681F804CB
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:13 +0200 (CEST)
In-Reply-To: <20190822190425.23001-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

sram0_base and sram1_base are Skylake-specific fields and should not be
part of common sst framework. Moreover, these are completely unused, so
remove them.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/common/sst-dsp-priv.h | 2 --
 sound/soc/intel/skylake/bxt-sst.c     | 2 --
 sound/soc/intel/skylake/cnl-sst.c     | 2 --
 sound/soc/intel/skylake/skl-sst.c     | 2 --
 4 files changed, 8 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 53dcd87bab44..a4628a89d47d 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -69,8 +69,6 @@ struct sst_addr {
 	u32 dram_offset;
 	u32 dsp_iram_offset;
 	u32 dsp_dram_offset;
-	u32 sram0_base;
-	u32 sram1_base;
 	void __iomem *lpe;
 	void __iomem *shim;
 	void __iomem *pci_cfg;
diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index fdd94711c3b4..5b46215fbc0f 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -563,8 +563,6 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst->fw_ops = bxt_fw_ops;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
-	sst->addr.sram0_base = BXT_ADSP_SRAM0_BASE;
-	sst->addr.sram1_base = BXT_ADSP_SRAM1_BASE;
 
 	sst_dsp_mailbox_init(sst,
 		(BXT_ADSP_SRAM0_BASE + SKL_FW_REGS_SIZE), SKL_MAILBOX_SIZE,
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index d3da23e0ef05..47b991c03742 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -440,8 +440,6 @@ int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst->fw_ops = cnl_fw_ops;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
-	sst->addr.sram0_base = CNL_ADSP_SRAM0_BASE;
-	sst->addr.sram1_base = CNL_ADSP_SRAM1_BASE;
 
 	sst_dsp_mailbox_init(sst,
 		(CNL_ADSP_SRAM0_BASE + SKL_FW_REGS_SIZE), SKL_MAILBOX_SIZE,
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 191931578fd2..c823936ffd34 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -533,8 +533,6 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	sst = skl->dsp;
 	sst->addr.lpe = mmio_base;
 	sst->addr.shim = mmio_base;
-	sst->addr.sram0_base = SKL_ADSP_SRAM0_BASE;
-	sst->addr.sram1_base = SKL_ADSP_SRAM1_BASE;
 
 	sst_dsp_mailbox_init(sst,
 		(SKL_ADSP_SRAM0_BASE + SKL_FW_REGS_SIZE), SKL_MAILBOX_SIZE,
-- 
2.17.1
