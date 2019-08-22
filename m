From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 33/35] ASoC: Intel: Skylake: Privatize SST init
	handlers
Date: Thu, 22 Aug 2019 21:04:23 +0200
Message-ID: <20190822190425.23001-34-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47302F8067A
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:35 +0200 (CEST)
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

With initialization order repaired, sst_ops::init overloads can be
privatized for Skylake platofmrs. Let's do so.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c     | 25 ++++++++++++-------------
 sound/soc/intel/skylake/cnl-sst-dsp.h |  2 --
 sound/soc/intel/skylake/cnl-sst.c     | 25 ++++++++++++-------------
 sound/soc/intel/skylake/skl-sst-dsp.h |  2 --
 sound/soc/intel/skylake/skl-sst.c     | 23 +++++++++++------------
 5 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 79728e418176..1edc38069615 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -533,18 +533,7 @@ static const struct skl_dsp_fw_ops bxt_fw_ops = {
 	.load_library = bxt_load_library,
 };
 
-struct sst_ops apl_sst_ops = {
-	.irq_handler = skl_dsp_sst_interrupt,
-	.thread_fn = skl_dsp_irq_thread_handler,
-	.write = sst_shim32_write,
-	.read = sst_shim32_read,
-	.ram_read = sst_memcpy_fromio_32,
-	.ram_write = sst_memcpy_toio_32,
-	.init = bxt_sst_dsp_init,
-	.free = skl_dsp_free,
-};
-
-int bxt_sst_dsp_init(struct sst_dsp *sst, struct sst_pdata *pdata)
+static int bxt_sst_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 {
 	struct skl_dev *skl = sst->thread_context;
 	void __iomem *mmio;
@@ -578,7 +567,17 @@ int bxt_sst_dsp_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
+
+struct sst_ops apl_sst_ops = {
+	.irq_handler = skl_dsp_sst_interrupt,
+	.thread_fn = skl_dsp_irq_thread_handler,
+	.write = sst_shim32_write,
+	.read = sst_shim32_read,
+	.ram_read = sst_memcpy_fromio_32,
+	.ram_write = sst_memcpy_toio_32,
+	.init = bxt_sst_init,
+	.free = skl_dsp_free,
+};
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel Broxton IPC driver");
diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.h b/sound/soc/intel/skylake/cnl-sst-dsp.h
index 7810ae11954a..a1ea242e9539 100644
--- a/sound/soc/intel/skylake/cnl-sst-dsp.h
+++ b/sound/soc/intel/skylake/cnl-sst-dsp.h
@@ -87,6 +87,4 @@ void cnl_ipc_op_int_enable(struct sst_dsp *ctx);
 void cnl_ipc_op_int_disable(struct sst_dsp *ctx);
 bool cnl_ipc_int_status(struct sst_dsp *ctx);
 
-int cnl_sst_dsp_init(struct sst_dsp *sst, struct sst_pdata *pdata);
-
 #endif /*__CNL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 58efeb6c8a8a..360e54d3c587 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -409,18 +409,7 @@ static int cnl_ipc_init(struct device *dev, struct skl_dev *cnl)
 	return 0;
 }
 
-struct sst_ops cnl_sst_ops = {
-	.irq_handler = cnl_dsp_sst_interrupt,
-	.thread_fn = cnl_dsp_irq_thread_handler,
-	.write = sst_shim32_write,
-	.read = sst_shim32_read,
-	.ram_read = sst_memcpy_fromio_32,
-	.ram_write = sst_memcpy_toio_32,
-	.init = cnl_sst_dsp_init,
-	.free = cnl_dsp_free,
-};
-
-int cnl_sst_dsp_init(struct sst_dsp *sst, struct sst_pdata *pdata)
+static int cnl_sst_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 {
 	struct skl_dev *cnl = sst->thread_context;
 	void __iomem *mmio;
@@ -449,7 +438,17 @@ int cnl_sst_dsp_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cnl_sst_dsp_init);
+
+struct sst_ops cnl_sst_ops = {
+	.irq_handler = cnl_dsp_sst_interrupt,
+	.thread_fn = cnl_dsp_irq_thread_handler,
+	.write = sst_shim32_write,
+	.read = sst_shim32_read,
+	.ram_read = sst_memcpy_fromio_32,
+	.ram_write = sst_memcpy_toio_32,
+	.init = cnl_sst_init,
+	.free = cnl_dsp_free,
+};
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel Cannonlake IPC driver");
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index a3714b706b8e..3294826d5cf7 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -206,8 +206,6 @@ int skl_dsp_get_core(struct sst_dsp *ctx, unsigned int core_id);
 int skl_dsp_put_core(struct sst_dsp *ctx, unsigned int core_id);
 
 int skl_dsp_boot(struct sst_dsp *ctx);
-int skl_sst_dsp_init(struct sst_dsp *sst, struct sst_pdata *pdata);
-int bxt_sst_dsp_init(struct sst_dsp *sst, struct sst_pdata *pdata);
 int bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo,
 		int lib_count);
 
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 8e1d02e29a32..209f45e3d5d0 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -505,17 +505,7 @@ static const struct skl_dsp_fw_ops skl_fw_ops = {
 	.unload_mod = skl_unload_module,
 };
 
-struct sst_ops skl_sst_ops = {
-	.irq_handler = skl_dsp_sst_interrupt,
-	.write = sst_shim32_write,
-	.read = sst_shim32_read,
-	.ram_read = sst_memcpy_fromio_32,
-	.ram_write = sst_memcpy_toio_32,
-	.init = skl_sst_dsp_init,
-	.free = skl_dsp_free,
-};
-
-int skl_sst_dsp_init(struct sst_dsp *sst, struct sst_pdata *pdata)
+static int skl_sst_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 {
 	struct skl_dev *skl = sst->thread_context;
 	void __iomem *mmio;
@@ -541,7 +531,16 @@ int skl_sst_dsp_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
+
+struct sst_ops skl_sst_ops = {
+	.irq_handler = skl_dsp_sst_interrupt,
+	.write = sst_shim32_write,
+	.read = sst_shim32_read,
+	.ram_read = sst_memcpy_fromio_32,
+	.ram_write = sst_memcpy_toio_32,
+	.init = skl_sst_init,
+	.free = skl_dsp_free,
+};
 
 int skl_sst_init_fw(struct skl_dev *skl)
 {
-- 
2.17.1
