From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 17/35] ASoC: Intel: Skylake: Remove
	skl_dsp_loader_ops
Date: Thu, 22 Aug 2019 21:04:07 +0200
Message-ID: <20190822190425.23001-18-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 188D6F805A1
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:09 +0200 (CEST)
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

With all fields deprecated, yet another struct can be removed. Let's do
so and don't forget about any functions or fields tied to its existence.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/common/sst-dsp-priv.h   |  1 -
 sound/soc/intel/skylake/bxt-sst.c       |  5 ++--
 sound/soc/intel/skylake/cnl-sst-dsp.h   |  3 +-
 sound/soc/intel/skylake/cnl-sst.c       |  5 ++--
 sound/soc/intel/skylake/skl-messages.c  | 40 +------------------------
 sound/soc/intel/skylake/skl-sst-dsp.h   | 24 ++-------------
 sound/soc/intel/skylake/skl-sst-utils.c |  3 +-
 sound/soc/intel/skylake/skl-sst.c       |  5 ++--
 sound/soc/intel/skylake/skl.h           |  2 --
 9 files changed, 12 insertions(+), 76 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 8a7009937d59..0fe9bebcfb38 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -306,7 +306,6 @@ struct sst_dsp {
 	const char *fw_name;
 
 	/* To allocate CL dma buffers */
-	struct skl_dsp_loader_ops dsp_ops;
 	struct skl_dsp_fw_ops fw_ops;
 	int sst_state;
 	struct skl_cl_dev cl_dev;
diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 45da02f74f4d..c7961050c2ee 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -546,14 +546,13 @@ static struct sst_pdata skl_dev = {
 };
 
 int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
-			const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
-			struct skl_dev **dsp)
+			const char *fw_name, struct skl_dev **dsp)
 {
 	struct skl_dev *skl;
 	struct sst_dsp *sst;
 	int ret;
 
-	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp_ops, dsp, &skl_dev);
+	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp, &skl_dev);
 	if (ret < 0) {
 		dev_err(dev, "%s: no device\n", __func__);
 		return ret;
diff --git a/sound/soc/intel/skylake/cnl-sst-dsp.h b/sound/soc/intel/skylake/cnl-sst-dsp.h
index 30b586acc858..70da4f312f53 100644
--- a/sound/soc/intel/skylake/cnl-sst-dsp.h
+++ b/sound/soc/intel/skylake/cnl-sst-dsp.h
@@ -94,7 +94,6 @@ void cnl_ipc_op_int_disable(struct sst_dsp *ctx);
 bool cnl_ipc_int_status(struct sst_dsp *ctx);
 
 int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
-		     const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
-		     struct skl_dev **dsp);
+		     const char *fw_name, struct skl_dev **dsp);
 
 #endif /*__CNL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 4d9a4d5886f4..2f10076cc906 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -423,14 +423,13 @@ static struct sst_pdata cnl_dev = {
 };
 
 int cnl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
-		     const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
-		     struct skl_dev **dsp)
+		     const char *fw_name, struct skl_dev **dsp)
 {
 	struct skl_dev *cnl;
 	struct sst_dsp *sst;
 	int ret;
 
-	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp_ops, dsp, &cnl_dev);
+	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp, &cnl_dev);
 	if (ret < 0) {
 		dev_err(dev, "%s: no device\n", __func__);
 		return ret;
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 20ab980fe8a1..6fbceec67b53 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -140,72 +140,37 @@ int skl_dsp_cleanup(struct device *dev,
 	return 0;
 }
 
-static struct skl_dsp_loader_ops skl_get_loader_ops(void)
-{
-	struct skl_dsp_loader_ops loader_ops;
-
-	memset(&loader_ops, 0, sizeof(struct skl_dsp_loader_ops));
-
-	loader_ops.alloc_dma_buf = skl_alloc_dma_buf;
-	loader_ops.free_dma_buf = skl_free_dma_buf;
-
-	return loader_ops;
-};
-
-static struct skl_dsp_loader_ops bxt_get_loader_ops(void)
-{
-	struct skl_dsp_loader_ops loader_ops;
-
-	memset(&loader_ops, 0, sizeof(loader_ops));
-
-	loader_ops.alloc_dma_buf = skl_alloc_dma_buf;
-	loader_ops.free_dma_buf = skl_free_dma_buf;
-	loader_ops.prepare = skl_dsp_prepare;
-	loader_ops.trigger = skl_dsp_trigger;
-	loader_ops.cleanup = skl_dsp_cleanup;
-
-	return loader_ops;
-};
-
 static const struct skl_dsp_ops dsp_ops[] = {
 	{
 		.id = 0x9d70,
-		.loader_ops = skl_get_loader_ops,
 		.init = skl_sst_dsp_init,
 	},
 	{
 		.id = 0x9d71,
-		.loader_ops = skl_get_loader_ops,
 		.init = skl_sst_dsp_init,
 	},
 	{
 		.id = 0x5a98,
-		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
 	},
 	{
 		.id = 0x3198,
-		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
 	},
 	{
 		.id = 0x9dc8,
-		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
 	},
 	{
 		.id = 0xa348,
-		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
 	},
 	{
 		.id = 0x02c8,
-		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
 	},
 	{
 		.id = 0x06c8,
-		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
 	},
 };
@@ -226,7 +191,6 @@ int skl_init_dsp(struct skl_dev *skl)
 {
 	void __iomem *mmio_base;
 	struct hdac_bus *bus = skl_to_bus(skl);
-	struct skl_dsp_loader_ops loader_ops;
 	int irq = bus->irq;
 	const struct skl_dsp_ops *ops;
 	int ret;
@@ -248,10 +212,8 @@ int skl_init_dsp(struct skl_dev *skl)
 		goto unmap_mmio;
 	}
 
-	loader_ops = ops->loader_ops();
 	ret = ops->init(bus->dev, mmio_base, irq,
-				skl->fw_name, loader_ops,
-				&skl);
+				skl->fw_name, &skl);
 
 	if (ret < 0)
 		goto unmap_mmio;
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 97e16a602331..9f2dae92c1c9 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -150,22 +150,6 @@ struct skl_dsp_fw_ops {
 
 };
 
-struct skl_dsp_loader_ops {
-	int stream_tag;
-
-	int (*alloc_dma_buf)(struct device *dev,
-		struct snd_dma_buffer *dmab, size_t size);
-	int (*free_dma_buf)(struct device *dev,
-		struct snd_dma_buffer *dmab);
-	int (*prepare)(struct device *dev, unsigned int format,
-				unsigned int byte_size,
-				struct snd_dma_buffer *bufp);
-	int (*trigger)(struct device *dev, bool start, int stream_tag);
-
-	int (*cleanup)(struct device *dev, struct snd_dma_buffer *dmab,
-				 int stream_tag);
-};
-
 #define MAX_INSTANCE_BUFF 2
 
 struct uuid_module {
@@ -227,11 +211,9 @@ int skl_dsp_put_core(struct sst_dsp *ctx, unsigned int core_id);
 
 int skl_dsp_boot(struct sst_dsp *ctx);
 int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
-		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
-		struct skl_dev **dsp);
+		const char *fw_name, struct skl_dev **dsp);
 int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
-		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
-		struct skl_dev **dsp);
+		const char *fw_name, struct skl_dev **dsp);
 int bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo,
 		int lib_count);
 
@@ -248,7 +230,7 @@ int skl_dsp_strip_extended_manifest(struct firmware *fw);
 void skl_dsp_set_astate_cfg(struct skl_dev *skl, u32 cnt, void *data);
 
 int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
-		struct skl_dsp_loader_ops dsp_ops, struct skl_dev **dsp,
+		struct skl_dev **dsp,
 		struct sst_pdata *pdata);
 int skl_prepare_lib_load(struct skl_dev *skl, struct skl_lib_info *linfo,
 			struct firmware *stripped_fw,
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 8e03a10855c4..bbe67e298efe 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -355,7 +355,7 @@ int skl_dsp_strip_extended_manifest(struct firmware *fw)
 }
 
 int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
-	struct skl_dsp_loader_ops dsp_ops, struct skl_dev **dsp,
+	struct skl_dev **dsp,
 	struct sst_pdata *pdata)
 {
 	struct skl_dev *skl = *dsp;
@@ -375,7 +375,6 @@ int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
 
 	sst = skl->dsp;
 	sst->fw_name = fw_name;
-	sst->dsp_ops = dsp_ops;
 	init_waitqueue_head(&skl->mod_load_wait);
 	INIT_LIST_HEAD(&sst->module_list);
 
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 6bb003add9e2..e9a7b2509b35 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -517,14 +517,13 @@ static struct sst_pdata skl_dev = {
 };
 
 int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
-		const char *fw_name, struct skl_dsp_loader_ops dsp_ops,
-		struct skl_dev **dsp)
+		const char *fw_name, struct skl_dev **dsp)
 {
 	struct skl_dev *skl;
 	struct sst_dsp *sst;
 	int ret;
 
-	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp_ops, dsp, &skl_dev);
+	ret = skl_sst_ctx_init(dev, irq, fw_name, dsp, &skl_dev);
 	if (ret < 0) {
 		dev_err(dev, "%s: no device\n", __func__);
 		return ret;
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 62e2f2d450e4..beeef67cb55f 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -155,10 +155,8 @@ struct skl_machine_pdata {
 
 struct skl_dsp_ops {
 	int id;
-	struct skl_dsp_loader_ops (*loader_ops)(void);
 	int (*init)(struct device *dev, void __iomem *mmio_base,
 			int irq, const char *fw_name,
-			struct skl_dsp_loader_ops loader_ops,
 			struct skl_dev **skl_sst);
 };
 
-- 
2.17.1
