From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Skylake: modify
	snd_skl_get_module_info args
Date: Wed, 10 Aug 2016 09:40:48 +0530
Message-ID: <1470802250-9232-2-git-send-email-vinod.koul@intel.com>
References: <1470802250-9232-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BD91A265A79
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 06:03:14 +0200 (CEST)
In-Reply-To: <1470802250-9232-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Dharageswari R <dharageswari.r@intel.com>, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dharageswari R <dharageswari.r@intel.com>

snd_skl_get_module_info() takes skl_dfw_module as an argument. The users
then updates the topology data, so instead pass skl_module_cfg and let
snd_skl_get_module_info() fill that up.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.h   |  7 ++++---
 sound/soc/intel/skylake/skl-sst-utils.c | 10 +++++-----
 sound/soc/intel/skylake/skl-topology.c  | 14 +-------------
 3 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index fa053c039203..6ad5cab4b0d5 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -20,6 +20,7 @@
 #include <sound/memalloc.h>
 #include "skl-sst-cldma.h"
 #include "skl-tplg-interface.h"
+#include "skl-topology.h"
 
 struct sst_dsp;
 struct skl_sst;
@@ -210,10 +211,10 @@ int bxt_sst_init_fw(struct device *dev, struct skl_sst *ctx);
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 
-int snd_skl_get_module_info(struct skl_sst *ctx, u8 *uuid,
-		struct skl_dfw_module *dfw_config);
+int snd_skl_get_module_info(struct skl_sst *ctx,
+				struct skl_module_cfg *mconfig);
 int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
-		unsigned int offset, int index);
+				unsigned int offset, int index);
 void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index fe36e0cf391c..0f990ebbe620 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -115,13 +115,13 @@ struct skl_ext_manifest_hdr {
 	u32 entries;
 };
 
-int snd_skl_get_module_info(struct skl_sst *ctx, u8 *uuid,
-			struct skl_dfw_module *dfw_config)
+int snd_skl_get_module_info(struct skl_sst *ctx,
+				struct skl_module_cfg *mconfig)
 {
 	struct uuid_module *module;
 	uuid_le *uuid_mod;
 
-	uuid_mod = (uuid_le *)uuid;
+	uuid_mod = (uuid_le *)mconfig->guid;
 
 	if (list_empty(&ctx->uuid_list)) {
 		dev_err(ctx->dev, "Module list is empty\n");
@@ -130,8 +130,8 @@ int snd_skl_get_module_info(struct skl_sst *ctx, u8 *uuid,
 
 	list_for_each_entry(module, &ctx->uuid_list, list) {
 		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
-			dfw_config->module_id = module->id;
-			dfw_config->is_loadable = module->is_loadable;
+			mconfig->id.module_id = module->id;
+			mconfig->is_loadable = module->is_loadable;
 
 			return 0;
 		}
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index c13fbefe6abf..c09e2c7608a3 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -475,24 +475,12 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 
 		/* check if module ids are populated */
 		if (mconfig->id.module_id < 0) {
-			struct skl_dfw_module *dfw_config;
-
-			dfw_config = kzalloc(sizeof(*dfw_config), GFP_KERNEL);
-			if (!dfw_config)
-				return -ENOMEM;
-
-			ret = snd_skl_get_module_info(skl->skl_sst,
-				mconfig->guid, dfw_config);
+			ret = snd_skl_get_module_info(skl->skl_sst, mconfig);
 			if (ret < 0) {
 				dev_err(skl->skl_sst->dev,
 					"query module info failed: %d\n", ret);
-				kfree(dfw_config);
 				return ret;
 			}
-			mconfig->id.module_id = dfw_config->module_id;
-			mconfig->is_loadable = dfw_config->is_loadable;
-
-			kfree(dfw_config);
 		}
 
 		/* check resource available */
-- 
1.9.1
