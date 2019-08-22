From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 31/35] ASoC: Intel: Reuse sst_pdata::fw field
Date: Thu, 22 Aug 2019 21:04:21 +0200
Message-ID: <20190822190425.23001-32-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F182F80679
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:32 +0200 (CEST)
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

Similarly to fw_name, sst_pdata::fw can be used to unify usage of
firmware objects for all SSTs.

This change invalidates sst_dsp::fw field.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 16 +++++++++-------
 sound/soc/intel/skylake/cnl-sst.c | 15 ++++++++-------
 sound/soc/intel/skylake/skl-sst.c | 23 +++++++++++++----------
 3 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 286da9fbc4de..79728e418176 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -185,10 +185,11 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 {
 	struct firmware stripped_fw;
 	struct skl_dev *skl = ctx->thread_context;
+	struct sst_pdata *pdata = ctx->pdata;
 	int ret, i;
 
-	if (ctx->fw == NULL) {
-		ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
+	if (!pdata->fw) {
+		ret = request_firmware(&pdata->fw, ctx->fw_name, ctx->dev);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Request firmware failed %d\n", ret);
 			return ret;
@@ -197,13 +198,14 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 
 	/* prase uuids on first boot */
 	if (skl->is_first_boot) {
-		ret = snd_skl_parse_uuids(ctx, ctx->fw, BXT_ADSP_FW_BIN_HDR_OFFSET, 0);
+		ret = snd_skl_parse_uuids(ctx, pdata->fw,
+				BXT_ADSP_FW_BIN_HDR_OFFSET, 0);
 		if (ret < 0)
 			goto sst_load_base_firmware_failed;
 	}
 
-	stripped_fw.data = ctx->fw->data;
-	stripped_fw.size = ctx->fw->size;
+	stripped_fw.data = pdata->fw->data;
+	stripped_fw.size = pdata->fw->size;
 	skl_dsp_strip_extended_manifest(&stripped_fw);
 
 	for (i = 0; i < BXT_FW_ROM_INIT_RETRY; i++) {
@@ -246,8 +248,8 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	return ret;
 
 sst_load_base_firmware_failed:
-	release_firmware(ctx->fw);
-	ctx->fw = NULL;
+	release_firmware(pdata->fw);
+	pdata->fw = NULL;
 	return ret;
 }
 
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index a6113d8afcbb..58efeb6c8a8a 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -108,10 +108,11 @@ static int cnl_load_base_firmware(struct sst_dsp *ctx)
 {
 	struct firmware stripped_fw;
 	struct skl_dev *cnl = ctx->thread_context;
+	struct sst_pdata *pdata = ctx->pdata;
 	int ret;
 
-	if (!ctx->fw) {
-		ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
+	if (!pdata->fw) {
+		ret = request_firmware(&pdata->fw, ctx->fw_name, ctx->dev);
 		if (ret < 0) {
 			dev_err(ctx->dev, "request firmware failed: %d\n", ret);
 			goto cnl_load_base_firmware_failed;
@@ -120,14 +121,14 @@ static int cnl_load_base_firmware(struct sst_dsp *ctx)
 
 	/* parse uuids if first boot */
 	if (cnl->is_first_boot) {
-		ret = snd_skl_parse_uuids(ctx, ctx->fw,
+		ret = snd_skl_parse_uuids(ctx, pdata->fw,
 					  CNL_ADSP_FW_HDR_OFFSET, 0);
 		if (ret < 0)
 			goto cnl_load_base_firmware_failed;
 	}
 
-	stripped_fw.data = ctx->fw->data;
-	stripped_fw.size = ctx->fw->size;
+	stripped_fw.data = pdata->fw->data;
+	stripped_fw.size = pdata->fw->size;
 	skl_dsp_strip_extended_manifest(&stripped_fw);
 
 	ret = cnl_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
@@ -157,8 +158,8 @@ static int cnl_load_base_firmware(struct sst_dsp *ctx)
 	return 0;
 
 cnl_load_base_firmware_failed:
-	release_firmware(ctx->fw);
-	ctx->fw = NULL;
+	release_firmware(pdata->fw);
+	pdata->fw = NULL;
 
 	return ret;
 }
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index e0f2bf828541..8e1d02e29a32 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -67,14 +67,15 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 {
 	int ret = 0, i;
 	struct skl_dev *skl = ctx->thread_context;
+	struct sst_pdata *pdata = ctx->pdata;
 	struct firmware stripped_fw;
 	u32 reg;
 
 	skl->boot_complete = false;
 	init_waitqueue_head(&skl->boot_wait);
 
-	if (ctx->fw == NULL) {
-		ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
+	if (!pdata->fw) {
+		ret = request_firmware(&pdata->fw, ctx->fw_name, ctx->dev);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Request firmware failed %d\n", ret);
 			return -EIO;
@@ -83,18 +84,19 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 
 	/* prase uuids on first boot */
 	if (skl->is_first_boot) {
-		ret = snd_skl_parse_uuids(ctx, ctx->fw, SKL_ADSP_FW_BIN_HDR_OFFSET, 0);
+		ret = snd_skl_parse_uuids(ctx, pdata->fw,
+				SKL_ADSP_FW_BIN_HDR_OFFSET, 0);
 		if (ret < 0) {
 			dev_err(ctx->dev, "UUID parsing err: %d\n", ret);
-			release_firmware(ctx->fw);
+			release_firmware(pdata->fw);
 			skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
 			return ret;
 		}
 	}
 
 	/* check for extended manifest */
-	stripped_fw.data = ctx->fw->data;
-	stripped_fw.size = ctx->fw->size;
+	stripped_fw.data = pdata->fw->data;
+	stripped_fw.size = pdata->fw->size;
 
 	skl_dsp_strip_extended_manifest(&stripped_fw);
 
@@ -152,8 +154,8 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 	ctx->cl_dev.ops.cl_cleanup_controller(ctx);
 skl_load_base_firmware_failed:
 	skl_dsp_disable_core(ctx, SKL_DSP_CORE0_MASK);
-	release_firmware(ctx->fw);
-	ctx->fw = NULL;
+	release_firmware(pdata->fw);
+	pdata->fw = NULL;
 	return ret;
 }
 
@@ -602,10 +604,11 @@ EXPORT_SYMBOL_GPL(skl_sst_init_fw);
 void skl_sst_dsp_cleanup(struct skl_dev *skl)
 {
 	struct sst_dsp *dsp = skl->dsp;
+	struct sst_pdata *pdata = dsp->pdata;
 
 	skl_release_library(skl->lib_info, skl->lib_count);
-	if (dsp->fw)
-		release_firmware(dsp->fw);
+	if (pdata->fw)
+		release_firmware(pdata->fw);
 	skl_clear_module_table(dsp);
 
 	skl_freeup_uuid_list(skl);
-- 
2.17.1
