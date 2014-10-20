From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 3/7] ASoC: Intel: Add call to calculate offsets
	internally within the DSP.
Date: Mon, 20 Oct 2014 15:06:48 +0100
Message-ID: <1413814012-5619-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 601CD26653D
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 16:07:42 +0200 (CEST)
In-Reply-To: <1413814012-5619-1-git-send-email-liam.r.girdwood@linux.intel.com>
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

A call to calculate internal DSP memory addresses used to allocate persistent
and scartch buffers.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-dsp-priv.h    |  7 +++++++
 sound/soc/intel/sst-firmware.c    | 22 +++++++++++++++++++---
 sound/soc/intel/sst-haswell-dsp.c |  8 ++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index 4c91449..92fd7f0 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -26,6 +26,9 @@ struct sst_mem_block;
 struct sst_module;
 struct sst_fw;
 
+/* do we need to remove or keep */
+#define DSP_DRAM_ADDR_OFFSET		0x400000
+
 /*
  * DSP Operations exported by platform Audio DSP driver.
  */
@@ -67,6 +70,8 @@ struct sst_addr {
 	u32 shim_offset;
 	u32 iram_offset;
 	u32 dram_offset;
+	u32 dsp_iram_offset;
+	u32 dsp_dram_offset;
 	void __iomem *lpe;
 	void __iomem *shim;
 	void __iomem *pci_cfg;
@@ -319,4 +324,6 @@ struct sst_mem_block *sst_mem_block_register(struct sst_dsp *dsp, u32 offset,
 	void *private);
 void sst_mem_block_unregister_all(struct sst_dsp *dsp);
 
+u32 sst_dsp_get_offset(struct sst_dsp *dsp, u32 offset,
+	enum sst_mem_type type);
 #endif
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 2b742a5..1de3f33 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -234,9 +234,8 @@ struct sst_module *sst_module_new(struct sst_fw *sst_fw,
 	sst_module->id = template->id;
 	sst_module->dsp = dsp;
 	sst_module->sst_fw = sst_fw;
-
-	memcpy(&sst_module->s, &template->s, sizeof(struct sst_module_data));
-	memcpy(&sst_module->p, &template->p, sizeof(struct sst_module_data));
+	sst_module->scratch_size = template->scratch_size;
+	sst_module->persistent_size = template->persistent_size;
 
 	INIT_LIST_HEAD(&sst_module->block_list);
 
@@ -712,3 +711,20 @@ struct sst_module *sst_module_get_from_id(struct sst_dsp *dsp, u32 id)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(sst_module_get_from_id);
+
+/* returns block address in DSP address space */
+u32 sst_dsp_get_offset(struct sst_dsp *dsp, u32 offset,
+	enum sst_mem_type type)
+{
+	switch (type) {
+	case SST_MEM_IRAM:
+		return offset - dsp->addr.iram_offset +
+			dsp->addr.dsp_iram_offset;
+	case SST_MEM_DRAM:
+		return offset - dsp->addr.dram_offset +
+			dsp->addr.dsp_dram_offset;
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(sst_dsp_get_offset);
diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 7f239d0..5058dc8 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -42,6 +42,10 @@
 #define SST_LP_SHIM_OFFSET	0xE7000
 #define SST_WPT_IRAM_OFFSET	0xA0000
 #define SST_LP_IRAM_OFFSET	0x80000
+#define SST_WPT_DSP_DRAM_OFFSET	0x400000
+#define SST_WPT_DSP_IRAM_OFFSET	0x00000
+#define SST_LPT_DSP_DRAM_OFFSET	0x400000
+#define SST_LPT_DSP_IRAM_OFFSET	0x00000
 
 #define SST_SHIM_PM_REG		0x84
 
@@ -462,12 +466,16 @@ static int hsw_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 		region = lp_region;
 		region_count = ARRAY_SIZE(lp_region);
 		sst->addr.iram_offset = SST_LP_IRAM_OFFSET;
+		sst->addr.dsp_iram_offset = SST_LPT_DSP_IRAM_OFFSET;
+		sst->addr.dsp_dram_offset = SST_LPT_DSP_DRAM_OFFSET;
 		sst->addr.shim_offset = SST_LP_SHIM_OFFSET;
 		break;
 	case SST_DEV_ID_WILDCAT_POINT:
 		region = wpt_region;
 		region_count = ARRAY_SIZE(wpt_region);
 		sst->addr.iram_offset = SST_WPT_IRAM_OFFSET;
+		sst->addr.dsp_iram_offset = SST_WPT_DSP_IRAM_OFFSET;
+		sst->addr.dsp_dram_offset = SST_WPT_DSP_DRAM_OFFSET;
 		sst->addr.shim_offset = SST_WPT_SHIM_OFFSET;
 		break;
 	default:
-- 
1.9.1
