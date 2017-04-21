From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 2/6] ASoC: Intel: Skylake: Commonize library
	load
Date: Fri, 21 Apr 2017 20:28:09 +0530
Message-ID: <1492786693-24167-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1492786693-24167-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id EF454267101
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:11:17 +0200 (CEST)
In-Reply-To: <1492786693-24167-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

request firmware, strip extended manifest and release library changes
are common to kabylake and APL.

So move these common code to utils to be reused in later patches for
kabylake library load.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c       | 38 ++++-------------------------
 sound/soc/intel/skylake/skl-sst-dsp.h   |  7 +++++-
 sound/soc/intel/skylake/skl-sst-utils.c | 43 +++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 34 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index c54f56c568e8..2df7d104bfca 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -53,18 +53,6 @@ static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
 	 return sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE);
 }
 
-static void sst_bxt_release_library(struct skl_lib_info *linfo, int lib_count)
-{
-	int i;
-
-	for (i = 1; i < lib_count; i++) {
-		if (linfo[i].fw) {
-			release_firmware(linfo[i].fw);
-			linfo[i].fw = NULL;
-		}
-	}
-}
-
 static int
 bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 {
@@ -75,26 +63,10 @@ static void sst_bxt_release_library(struct skl_lib_info *linfo, int lib_count)
 
 	/* library indices start from 1 to N. 0 represents base FW */
 	for (i = 1; i < lib_count; i++) {
-		if (linfo[i].fw == NULL) {
-			ret = request_firmware(&linfo[i].fw, linfo[i].name,
-						ctx->dev);
-			if (ret < 0) {
-				dev_err(ctx->dev, "Request lib %s failed:%d\n",
-					linfo[i].name, ret);
-				goto load_library_failed;
-			}
-		}
-
-		if (skl->is_first_boot) {
-			ret = snd_skl_parse_uuids(ctx, linfo[i].fw,
+		ret = skl_prepare_lib_load(skl, &skl->lib_info[i], &stripped_fw,
 					BXT_ADSP_FW_BIN_HDR_OFFSET, i);
-			if (ret < 0)
-				goto load_library_failed;
-		}
-
-		stripped_fw.data = linfo[i].fw->data;
-		stripped_fw.size = linfo[i].fw->size;
-		skl_dsp_strip_extended_manifest(&stripped_fw);
+		if (ret < 0)
+			goto load_library_failed;
 
 		stream_tag = ctx->dsp_ops.prepare(ctx->dev, 0x40,
 					stripped_fw.size, &dmab);
@@ -121,7 +93,7 @@ static void sst_bxt_release_library(struct skl_lib_info *linfo, int lib_count)
 	return ret;
 
 load_library_failed:
-	sst_bxt_release_library(linfo, lib_count);
+	skl_release_library(linfo, lib_count);
 	return ret;
 }
 
@@ -648,7 +620,7 @@ int bxt_sst_init_fw(struct device *dev, struct skl_sst *ctx)
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
 
-	sst_bxt_release_library(ctx->lib_info, ctx->lib_count);
+	skl_release_library(ctx->lib_info, ctx->lib_count);
 	if (ctx->dsp->fw)
 		release_firmware(ctx->dsp->fw);
 	skl_freeup_uuid_list(ctx);
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index c1f95e23933d..6d9aed23d5cd 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -18,6 +18,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/uuid.h>
+#include <linux/firmware.h>
 #include <sound/memalloc.h>
 #include "skl-sst-cldma.h"
 
@@ -145,7 +146,7 @@ struct skl_dsp_fw_ops {
 	int (*load_fw)(struct sst_dsp  *ctx);
 	/* FW module parser/loader */
 	int (*load_library)(struct sst_dsp *ctx,
-		struct skl_lib_info *linfo, int count);
+		struct skl_lib_info *linfo, int lib_count);
 	int (*parse_fw)(struct sst_dsp *ctx);
 	int (*set_state_D0)(struct sst_dsp *ctx, unsigned int core_id);
 	int (*set_state_D3)(struct sst_dsp *ctx, unsigned int core_id);
@@ -250,5 +251,9 @@ int skl_get_pvt_instance_id_map(struct skl_sst *ctx,
 int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
 		struct skl_dsp_loader_ops dsp_ops, struct skl_sst **dsp,
 		struct sst_dsp_device *skl_dev);
+int skl_prepare_lib_load(struct skl_sst *skl, struct skl_lib_info *linfo,
+			struct firmware *stripped_fw,
+			unsigned int hdr_offset, int index);
+void skl_release_library(struct skl_lib_info *linfo, int lib_count);
 
 #endif /*__SKL_SST_DSP_H__*/
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index a72152123c3c..81ee251881b4 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -398,3 +398,46 @@ int skl_sst_ctx_init(struct device *dev, int irq, const char *fw_name,
 
 	return ret;
 }
+
+int skl_prepare_lib_load(struct skl_sst *skl, struct skl_lib_info *linfo,
+		struct firmware *stripped_fw,
+		unsigned int hdr_offset, int index)
+{
+	int ret;
+	struct sst_dsp *dsp = skl->dsp;
+
+	if (linfo->fw == NULL) {
+		ret = request_firmware(&linfo->fw, linfo->name,
+					skl->dev);
+		if (ret < 0) {
+			dev_err(skl->dev, "Request lib %s failed:%d\n",
+				linfo->name, ret);
+			return ret;
+		}
+	}
+
+	if (skl->is_first_boot) {
+		ret = snd_skl_parse_uuids(dsp, linfo->fw, hdr_offset, index);
+		if (ret < 0)
+			return ret;
+	}
+
+	stripped_fw->data = linfo->fw->data;
+	stripped_fw->size = linfo->fw->size;
+	skl_dsp_strip_extended_manifest(stripped_fw);
+
+	return 0;
+}
+
+void skl_release_library(struct skl_lib_info *linfo, int lib_count)
+{
+	int i;
+
+	/* library indices start from 1 to N. 0 represents base FW */
+	for (i = 1; i < lib_count; i++) {
+		if (linfo[i].fw) {
+			release_firmware(linfo[i].fw);
+			linfo[i].fw = NULL;
+		}
+	}
+}
-- 
1.9.1
