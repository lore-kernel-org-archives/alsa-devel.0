From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 16/35] ASoC: Intel: Skylake: Make
	dsp_ops::stream_tag obsolete
Date: Thu, 22 Aug 2019 21:04:06 +0200
Message-ID: <20190822190425.23001-17-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A959AF805FC
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:06 +0200 (CEST)
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

stream_tag field is the last obstacle in removing skl_dsp_loader_ops
structure. It is required only during fw load procedure and never lives
outside of that process - prepare_fw functions take place directly
before actual FW file transfer and once that's done, these are
redundant. Update _prepare_fw routines to return stream_tag on success
and use said return immediately in _transfer_fw_host_dma.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 14 ++++++--------
 sound/soc/intel/skylake/cnl-sst.c | 13 ++++++-------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 1ca4fba0f35f..45da02f74f4d 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -107,7 +107,6 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 		return stream_tag;
 	}
 
-	ctx->dsp_ops.stream_tag = stream_tag;
 	memcpy(ctx->dmab.area, fwdata, fwsize);
 
 	/* Step 1: Power up core 0 and core1 */
@@ -159,7 +158,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 		goto base_fw_load_failed;
 	}
 
-	return ret;
+	return stream_tag;
 
 base_fw_load_failed:
 	skl_dsp_cleanup(ctx->dev, &ctx->dmab, stream_tag);
@@ -168,16 +167,16 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 	return ret;
 }
 
-static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
+static int sst_transfer_fw_host_dma(struct sst_dsp *ctx, int stream_tag)
 {
 	int ret;
 
-	skl_dsp_trigger(ctx->dev, true, ctx->dsp_ops.stream_tag);
+	skl_dsp_trigger(ctx->dev, true, stream_tag);
 	ret = sst_dsp_register_poll(ctx, BXT_ADSP_FW_STATUS, SKL_FW_STS_MASK,
 			BXT_ROM_INIT, BXT_BASEFW_TIMEOUT, "Firmware boot");
 
-	skl_dsp_trigger(ctx->dev, false, ctx->dsp_ops.stream_tag);
-	skl_dsp_cleanup(ctx->dev, &ctx->dmab, ctx->dsp_ops.stream_tag);
+	skl_dsp_trigger(ctx->dev, false, stream_tag);
+	skl_dsp_cleanup(ctx->dev, &ctx->dmab, stream_tag);
 
 	return ret;
 }
@@ -207,7 +206,6 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	stripped_fw.size = ctx->fw->size;
 	skl_dsp_strip_extended_manifest(&stripped_fw);
 
-
 	for (i = 0; i < BXT_FW_ROM_INIT_RETRY; i++) {
 		ret = sst_bxt_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
 		if (ret == 0)
@@ -223,7 +221,7 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 		goto sst_load_base_firmware_failed;
 	}
 
-	ret = sst_transfer_fw_host_dma(ctx);
+	ret = sst_transfer_fw_host_dma(ctx, ret);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Transfer firmware failed %d\n", ret);
 		dev_info(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 5ad34e9f51eb..4d9a4d5886f4 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -54,7 +54,6 @@ static int cnl_prepare_fw(struct sst_dsp *ctx, const void *fwdata, u32 fwsize)
 		return stream_tag;
 	}
 
-	ctx->dsp_ops.stream_tag = stream_tag;
 	memcpy(ctx->dmab.area, fwdata, fwsize);
 
 	/* purge FW request */
@@ -81,7 +80,7 @@ static int cnl_prepare_fw(struct sst_dsp *ctx, const void *fwdata, u32 fwsize)
 		goto base_fw_load_failed;
 	}
 
-	return 0;
+	return stream_tag;
 
 base_fw_load_failed:
 	skl_dsp_cleanup(ctx->dev, &ctx->dmab, stream_tag);
@@ -90,17 +89,17 @@ static int cnl_prepare_fw(struct sst_dsp *ctx, const void *fwdata, u32 fwsize)
 	return ret;
 }
 
-static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
+static int sst_transfer_fw_host_dma(struct sst_dsp *ctx, int stream_tag)
 {
 	int ret;
 
-	skl_dsp_trigger(ctx->dev, true, ctx->dsp_ops.stream_tag);
+	skl_dsp_trigger(ctx->dev, true, stream_tag);
 	ret = sst_dsp_register_poll(ctx, CNL_ADSP_FW_STATUS, CNL_FW_STS_MASK,
 				    CNL_FW_INIT, CNL_BASEFW_TIMEOUT,
 				    "firmware boot");
 
-	skl_dsp_trigger(ctx->dev, false, ctx->dsp_ops.stream_tag);
-	skl_dsp_cleanup(ctx->dev, &ctx->dmab, ctx->dsp_ops.stream_tag);
+	skl_dsp_trigger(ctx->dev, false, stream_tag);
+	skl_dsp_cleanup(ctx->dev, &ctx->dmab, stream_tag);
 
 	return ret;
 }
@@ -137,7 +136,7 @@ static int cnl_load_base_firmware(struct sst_dsp *ctx)
 		goto cnl_load_base_firmware_failed;
 	}
 
-	ret = sst_transfer_fw_host_dma(ctx);
+	ret = sst_transfer_fw_host_dma(ctx, ret);
 	if (ret < 0) {
 		dev_err(ctx->dev, "transfer firmware failed: %d\n", ret);
 		cnl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
-- 
2.17.1
