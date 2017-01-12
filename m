From: jeeja.kp@intel.com
Subject: [PATCH v2 1/2] ASoC: Intel: bxtn: Store the FW/Library
	context at boot
Date: Thu, 12 Jan 2017 09:54:43 +0530
Message-ID: <1484195084-24446-2-git-send-email-jeeja.kp@intel.com>
References: <1484195084-24446-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C39C62675BB
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2017 05:13:48 +0100 (CET)
In-Reply-To: <1484195084-24446-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Store the DSP firmware/library at boot, so that for S3 to S0 transition
use the stored ctx for downloading the firmware to DSP memory.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 55 +++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 15a063a..7762d5a 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -50,33 +50,47 @@ static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
 	 return sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE);
 }
 
+static void sst_bxt_release_library(struct skl_lib_info *linfo, int lib_count)
+{
+	int i;
+
+	for (i = 1; i < lib_count; i++) {
+		if (linfo[i].fw) {
+			release_firmware(linfo[i].fw);
+			linfo[i].fw = NULL;
+		}
+	}
+}
+
 static int
 bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 {
 	struct snd_dma_buffer dmab;
 	struct skl_sst *skl = ctx->thread_context;
-	const struct firmware *fw = NULL;
 	struct firmware stripped_fw;
 	int ret = 0, i, dma_id, stream_tag;
 
 	/* library indices start from 1 to N. 0 represents base FW */
 	for (i = 1; i < lib_count; i++) {
-		ret = request_firmware(&fw, linfo[i].name, ctx->dev);
-		if (ret < 0) {
-			dev_err(ctx->dev, "Request lib %s failed:%d\n",
+		if (linfo[i].fw == NULL) {
+			ret = request_firmware(&linfo[i].fw, linfo[i].name,
+						ctx->dev);
+			if (ret < 0) {
+				dev_err(ctx->dev, "Request lib %s failed:%d\n",
 					linfo[i].name, ret);
-			return ret;
+				goto load_library_failed;
+			}
 		}
 
 		if (skl->is_first_boot) {
-			ret = snd_skl_parse_uuids(ctx, fw,
+			ret = snd_skl_parse_uuids(ctx, linfo[i].fw,
 					BXT_ADSP_FW_BIN_HDR_OFFSET, i);
 			if (ret < 0)
 				goto load_library_failed;
 		}
 
-		stripped_fw.data = fw->data;
-		stripped_fw.size = fw->size;
+		stripped_fw.data = linfo[i].fw->data;
+		stripped_fw.size = linfo[i].fw->size;
 		skl_dsp_strip_extended_manifest(&stripped_fw);
 
 		stream_tag = ctx->dsp_ops.prepare(ctx->dev, 0x40,
@@ -99,14 +113,12 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 
 		ctx->dsp_ops.trigger(ctx->dev, false, stream_tag);
 		ctx->dsp_ops.cleanup(ctx->dev, &dmab, stream_tag);
-		release_firmware(fw);
-		fw = NULL;
 	}
 
 	return ret;
 
 load_library_failed:
-	release_firmware(fw);
+	sst_bxt_release_library(linfo, lib_count);
 	return ret;
 }
 
@@ -208,16 +220,14 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	struct skl_sst *skl = ctx->thread_context;
 	int ret;
 
-	ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Request firmware failed %d\n", ret);
-		goto sst_load_base_firmware_failed;
+	if (ctx->fw == NULL) {
+		ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
+		if (ret < 0) {
+			dev_err(ctx->dev, "Request firmware failed %d\n", ret);
+			return ret;
+		}
 	}
 
-	/* check for extended manifest */
-	if (ctx->fw == NULL)
-		goto sst_load_base_firmware_failed;
-
 	/* prase uuids on first boot */
 	if (skl->is_first_boot) {
 		ret = snd_skl_parse_uuids(ctx, ctx->fw, BXT_ADSP_FW_BIN_HDR_OFFSET, 0);
@@ -265,8 +275,11 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 		}
 	}
 
+	return ret;
+
 sst_load_base_firmware_failed:
 	release_firmware(ctx->fw);
+	ctx->fw = NULL;
 	return ret;
 }
 
@@ -635,6 +648,10 @@ EXPORT_SYMBOL_GPL(bxt_sst_init_fw);
 
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
+
+	sst_bxt_release_library(ctx->lib_info, ctx->lib_count);
+	if (ctx->dsp->fw)
+		release_firmware(ctx->dsp->fw);
 	skl_freeup_uuid_list(ctx);
 	skl_ipc_free(&ctx->ipc);
 	ctx->dsp->cl_dev.ops.cl_cleanup_controller(ctx->dsp);
-- 
2.5.0
