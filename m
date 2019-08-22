From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 15/35] ASoC: Intel: Skylake: Use dsp loading
	functions directly
Date: Thu, 22 Aug 2019 21:04:05 +0200
Message-ID: <20190822190425.23001-16-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1EA67F805FB
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:04 +0200 (CEST)
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

None of skl_dsp_loader_ops are actually extended as any parameter that
could be "extended" is already part of given function's parameter list.
Rather than obfustace non-derived calls with ops and dereferences, make
use of said operation directly. Takes part in remal of
skl_dsp_loader_ops structure.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c       | 18 +++++++++---------
 sound/soc/intel/skylake/cnl-sst.c       | 10 +++++-----
 sound/soc/intel/skylake/skl-messages.c  | 10 +++++-----
 sound/soc/intel/skylake/skl-sst-cldma.c | 10 +++++-----
 sound/soc/intel/skylake/skl-sst-dsp.h   |  9 +++++++++
 5 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index a8a2783f9b37..1ca4fba0f35f 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -60,7 +60,7 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 		if (ret < 0)
 			goto load_library_failed;
 
-		stream_tag = ctx->dsp_ops.prepare(ctx->dev, 0x40,
+		stream_tag = skl_dsp_prepare(ctx->dev, 0x40,
 					stripped_fw.size, &dmab);
 		if (stream_tag <= 0) {
 			dev_err(ctx->dev, "Lib prepare DMA err: %x\n",
@@ -72,14 +72,14 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 		dma_id = stream_tag - 1;
 		memcpy(dmab.area, stripped_fw.data, stripped_fw.size);
 
-		ctx->dsp_ops.trigger(ctx->dev, true, stream_tag);
+		skl_dsp_trigger(ctx->dev, true, stream_tag);
 		ret = skl_sst_ipc_load_library(&skl->ipc, dma_id, i, true);
 		if (ret < 0)
 			dev_err(ctx->dev, "IPC Load Lib for %s fail: %d\n",
 					linfo[i].name, ret);
 
-		ctx->dsp_ops.trigger(ctx->dev, false, stream_tag);
-		ctx->dsp_ops.cleanup(ctx->dev, &dmab, stream_tag);
+		skl_dsp_trigger(ctx->dev, false, stream_tag);
+		skl_dsp_cleanup(ctx->dev, &dmab, stream_tag);
 	}
 
 	return ret;
@@ -100,7 +100,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 {
 	int stream_tag, ret;
 
-	stream_tag = ctx->dsp_ops.prepare(ctx->dev, 0x40, fwsize, &ctx->dmab);
+	stream_tag = skl_dsp_prepare(ctx->dev, 0x40, fwsize, &ctx->dmab);
 	if (stream_tag <= 0) {
 		dev_err(ctx->dev, "Failed to prepare DMA FW loading err: %x\n",
 				stream_tag);
@@ -162,7 +162,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 	return ret;
 
 base_fw_load_failed:
-	ctx->dsp_ops.cleanup(ctx->dev, &ctx->dmab, stream_tag);
+	skl_dsp_cleanup(ctx->dev, &ctx->dmab, stream_tag);
 	skl_dsp_core_power_down(ctx, SKL_DSP_CORE_MASK(1));
 	skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 	return ret;
@@ -172,12 +172,12 @@ static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
 {
 	int ret;
 
-	ctx->dsp_ops.trigger(ctx->dev, true, ctx->dsp_ops.stream_tag);
+	skl_dsp_trigger(ctx->dev, true, ctx->dsp_ops.stream_tag);
 	ret = sst_dsp_register_poll(ctx, BXT_ADSP_FW_STATUS, SKL_FW_STS_MASK,
 			BXT_ROM_INIT, BXT_BASEFW_TIMEOUT, "Firmware boot");
 
-	ctx->dsp_ops.trigger(ctx->dev, false, ctx->dsp_ops.stream_tag);
-	ctx->dsp_ops.cleanup(ctx->dev, &ctx->dmab, ctx->dsp_ops.stream_tag);
+	skl_dsp_trigger(ctx->dev, false, ctx->dsp_ops.stream_tag);
+	skl_dsp_cleanup(ctx->dev, &ctx->dmab, ctx->dsp_ops.stream_tag);
 
 	return ret;
 }
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 0b0337f6ebff..5ad34e9f51eb 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -48,7 +48,7 @@ static int cnl_prepare_fw(struct sst_dsp *ctx, const void *fwdata, u32 fwsize)
 
 	int ret, stream_tag;
 
-	stream_tag = ctx->dsp_ops.prepare(ctx->dev, 0x40, fwsize, &ctx->dmab);
+	stream_tag = skl_dsp_prepare(ctx->dev, 0x40, fwsize, &ctx->dmab);
 	if (stream_tag <= 0) {
 		dev_err(ctx->dev, "dma prepare failed: 0%#x\n", stream_tag);
 		return stream_tag;
@@ -84,7 +84,7 @@ static int cnl_prepare_fw(struct sst_dsp *ctx, const void *fwdata, u32 fwsize)
 	return 0;
 
 base_fw_load_failed:
-	ctx->dsp_ops.cleanup(ctx->dev, &ctx->dmab, stream_tag);
+	skl_dsp_cleanup(ctx->dev, &ctx->dmab, stream_tag);
 	cnl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 
 	return ret;
@@ -94,13 +94,13 @@ static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
 {
 	int ret;
 
-	ctx->dsp_ops.trigger(ctx->dev, true, ctx->dsp_ops.stream_tag);
+	skl_dsp_trigger(ctx->dev, true, ctx->dsp_ops.stream_tag);
 	ret = sst_dsp_register_poll(ctx, CNL_ADSP_FW_STATUS, CNL_FW_STS_MASK,
 				    CNL_FW_INIT, CNL_BASEFW_TIMEOUT,
 				    "firmware boot");
 
-	ctx->dsp_ops.trigger(ctx->dev, false, ctx->dsp_ops.stream_tag);
-	ctx->dsp_ops.cleanup(ctx->dev, &ctx->dmab, ctx->dsp_ops.stream_tag);
+	skl_dsp_trigger(ctx->dev, false, ctx->dsp_ops.stream_tag);
+	skl_dsp_cleanup(ctx->dev, &ctx->dmab, ctx->dsp_ops.stream_tag);
 
 	return ret;
 }
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 8fd682872d0c..20ab980fe8a1 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -22,13 +22,13 @@
 #include "../common/sst-dsp-priv.h"
 #include "skl-topology.h"
 
-static int skl_alloc_dma_buf(struct device *dev,
+int skl_alloc_dma_buf(struct device *dev,
 		struct snd_dma_buffer *dmab, size_t size)
 {
 	return snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size, dmab);
 }
 
-static int skl_free_dma_buf(struct device *dev, struct snd_dma_buffer *dmab)
+int skl_free_dma_buf(struct device *dev, struct snd_dma_buffer *dmab)
 {
 	snd_dma_free_pages(dmab);
 	return 0;
@@ -66,7 +66,7 @@ static int skl_dsp_setup_spib(struct device *dev, unsigned int size,
 	return 0;
 }
 
-static int skl_dsp_prepare(struct device *dev, unsigned int format,
+int skl_dsp_prepare(struct device *dev, unsigned int format,
 			unsigned int size, struct snd_dma_buffer *dmab)
 {
 	struct hdac_bus *bus = dev_get_drvdata(dev);
@@ -98,7 +98,7 @@ static int skl_dsp_prepare(struct device *dev, unsigned int format,
 	return stream->stream_tag;
 }
 
-static int skl_dsp_trigger(struct device *dev, bool start, int stream_tag)
+int skl_dsp_trigger(struct device *dev, bool start, int stream_tag)
 {
 	struct hdac_bus *bus = dev_get_drvdata(dev);
 	struct hdac_stream *stream;
@@ -116,7 +116,7 @@ static int skl_dsp_trigger(struct device *dev, bool start, int stream_tag)
 	return 0;
 }
 
-static int skl_dsp_cleanup(struct device *dev,
+int skl_dsp_cleanup(struct device *dev,
 		struct snd_dma_buffer *dmab, int stream_tag)
 {
 	struct hdac_bus *bus = dev_get_drvdata(dev);
diff --git a/sound/soc/intel/skylake/skl-sst-cldma.c b/sound/soc/intel/skylake/skl-sst-cldma.c
index 5a2c35f58fda..ca2e18666582 100644
--- a/sound/soc/intel/skylake/skl-sst-cldma.c
+++ b/sound/soc/intel/skylake/skl-sst-cldma.c
@@ -152,8 +152,8 @@ static void skl_cldma_cleanup(struct sst_dsp  *ctx)
 	skl_cldma_cleanup_spb(ctx);
 	skl_cldma_stream_clear(ctx);
 
-	ctx->dsp_ops.free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_data);
-	ctx->dsp_ops.free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_bdl);
+	skl_free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_data);
+	skl_free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_bdl);
 }
 
 int skl_cldma_wait_interruptible(struct sst_dsp *ctx)
@@ -337,18 +337,18 @@ int skl_cldma_prepare(struct sst_dsp *ctx)
 	ctx->cl_dev.ops.cl_stop_dma = skl_cldma_stop;
 
 	/* Allocate buffer*/
-	ret = ctx->dsp_ops.alloc_dma_buf(ctx->dev,
+	ret = skl_alloc_dma_buf(ctx->dev,
 			&ctx->cl_dev.dmab_data, ctx->cl_dev.bufsize);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Alloc buffer for base fw failed: %x\n", ret);
 		return ret;
 	}
 	/* Setup Code loader BDL */
-	ret = ctx->dsp_ops.alloc_dma_buf(ctx->dev,
+	ret = skl_alloc_dma_buf(ctx->dev,
 			&ctx->cl_dev.dmab_bdl, PAGE_SIZE);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Alloc buffer for blde failed: %x\n", ret);
-		ctx->dsp_ops.free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_data);
+		skl_free_dma_buf(ctx->dev, &ctx->cl_dev.dmab_data);
 		return ret;
 	}
 	bdl = (__le32 *)ctx->cl_dev.dmab_bdl.area;
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 45d99b6b448e..97e16a602331 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -190,6 +190,15 @@ struct skl_module_table {
 	struct list_head list;
 };
 
+int skl_alloc_dma_buf(struct device *dev,
+		struct snd_dma_buffer *dmab, size_t size);
+int skl_free_dma_buf(struct device *dev, struct snd_dma_buffer *dmab);
+int skl_dsp_prepare(struct device *dev, unsigned int format,
+		unsigned int size, struct snd_dma_buffer *dmab);
+int skl_dsp_trigger(struct device *dev, bool start, int stream_tag);
+int skl_dsp_cleanup(struct device *dev, struct snd_dma_buffer *dmab,
+		int stream_tag);
+
 void skl_cldma_process_intr(struct sst_dsp *ctx);
 void skl_cldma_int_disable(struct sst_dsp *ctx);
 int skl_cldma_prepare(struct sst_dsp *ctx);
-- 
2.17.1
