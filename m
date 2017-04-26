From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Commonize library load"
	to the asoc tree
Date: Wed, 26 Apr 2017 15:49:21 +0100
Message-ID: <E1d3OFt-0000T0-0g@finisterre>
References: <1492786693-24167-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE9B5267475
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 16:49:38 +0200 (CEST)
In-Reply-To: <1492786693-24167-3-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Commonize library load

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ebe8907687c052b36839b5f9ed09005db4fbe83c Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 25 Apr 2017 12:18:20 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Commonize library load

request firmware, strip extended manifest and release library changes
are common to kabylake and APL.

So move these common code to utils to be reused in later patches for
kabylake library load.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c       | 38 ++++-------------------------
 sound/soc/intel/skylake/skl-sst-dsp.h   |  7 +++++-
 sound/soc/intel/skylake/skl-sst-utils.c | 43 +++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 34 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 2bf6ebe29f50..d26545ee3e58 100644
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
@@ -75,26 +63,10 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 
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
@@ -121,7 +93,7 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 	return ret;
 
 load_library_failed:
-	sst_bxt_release_library(linfo, lib_count);
+	skl_release_library(linfo, lib_count);
 	return ret;
 }
 
@@ -648,7 +620,7 @@ EXPORT_SYMBOL_GPL(bxt_sst_init_fw);
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
@@ -250,5 +251,9 @@ void skl_dsp_enable_notification(struct skl_sst *ctx, bool enable);
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
2.11.0
