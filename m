From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2] ASoC: Intel: sst: only use sst-firmware when DW DMAC is available
Date: Thu, 22 Oct 2015 13:55:07 +0800
Message-ID: <1445493307-13667-1-git-send-email-yang.jie@intel.com>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, rdunlap@infradead.org, sfr@canb.auug.org.au, liam.r.girdwood@intel.com, yang.jie@intel.com, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, vinod.koul@intel.com, jarkko.nikula@intel.com, linux-audio-intel@eclists.intel.com
List-Id: alsa-devel@alsa-project.org

Currentlly, we use Synopsys DesignWare DMA Controller for
baytrail/haswell/broadwell ADSP firmware loading, but for
skylake, we don't use it, compiling sst-firmware.c may
introduce error when CONFIG_DW_DMAC_CORE is not enabled:

    sound/built-in.o: In function `sst_dma_new':
    (.text+0xd7b38): undefined reference to `dw_dma_probe'
    sound/built-in.o: In function `sst_dma_free':
    (.text+0xd7c0a): undefined reference to `dw_dma_remove'

Here we only compile sst-firmware when CONFIG_DW_DMAC_CORE
is selected, to fix the linking error issue.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/common/Makefile  | 6 +++++-
 sound/soc/intel/common/sst-dsp.c | 2 ++
 sound/soc/intel/common/sst-dsp.h | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index f24154c..d910558 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -1,7 +1,11 @@
-snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
+snd-soc-sst-dsp-objs := sst-dsp.o
 snd-soc-sst-acpi-objs := sst-acpi.o
 snd-soc-sst-ipc-objs := sst-ipc.o
 
+ifneq ($(CONFIG_DW_DMAC_CORE),)
+snd-soc-sst-dsp-objs += sst-firmware.o
+endif
+
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
 
diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index a627236..c9452e0 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -420,6 +420,7 @@ void sst_dsp_inbox_read(struct sst_dsp *sst, void *message, size_t bytes)
 }
 EXPORT_SYMBOL_GPL(sst_dsp_inbox_read);
 
+#if IS_ENABLED(CONFIG_DW_DMAC_CORE)
 struct sst_dsp *sst_dsp_new(struct device *dev,
 	struct sst_dsp_device *sst_dev, struct sst_pdata *pdata)
 {
@@ -484,6 +485,7 @@ void sst_dsp_free(struct sst_dsp *sst)
 	sst_dma_free(sst->dma);
 }
 EXPORT_SYMBOL_GPL(sst_dsp_free);
+#endif
 
 /* Module information */
 MODULE_AUTHOR("Liam Girdwood");
diff --git a/sound/soc/intel/common/sst-dsp.h b/sound/soc/intel/common/sst-dsp.h
index 1f45f18..859f0de 100644
--- a/sound/soc/intel/common/sst-dsp.h
+++ b/sound/soc/intel/common/sst-dsp.h
@@ -216,10 +216,12 @@ struct sst_pdata {
 	void *dsp;
 };
 
+#if IS_ENABLED(CONFIG_DW_DMAC_CORE)
 /* Initialization */
 struct sst_dsp *sst_dsp_new(struct device *dev,
 	struct sst_dsp_device *sst_dev, struct sst_pdata *pdata);
 void sst_dsp_free(struct sst_dsp *sst);
+#endif
 
 /* SHIM Read / Write */
 void sst_dsp_shim_write(struct sst_dsp *sst, u32 offset, u32 value);
-- 
2.1.4
