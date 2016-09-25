From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add table for module id
	for quick ref" to the asoc tree
Date: Sat, 24 Sep 2016 22:58:34 -0700
Message-ID: <E1bo2SQ-0002zh-HF@finisterre>
References: <1472042001-9582-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D2592665B1
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2016 07:58:47 +0200 (CEST)
In-Reply-To: <1472042001-9582-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add table for module id for quick ref

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

>From 55a92ea9cf6d6cac2f1be1bf53f0a120656b2060 Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Thu, 22 Sep 2016 14:00:39 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add table for module id for quick ref

Since modules ids are generated dynamically, we do not know the id
associate with modules in another pipelines. This limits our ability to
tell DSP about neighbouring modules.

So add a table for quick referencing of allocated module ids.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-dsp.h   |  2 ++
 sound/soc/intel/skylake/skl-sst-utils.c | 37 +++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index b61bd03ee4f0..b9e71d051fb1 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -219,6 +219,8 @@ int skl_get_pvt_id(struct skl_sst *ctx,
 				struct skl_module_cfg *mconfig);
 int skl_put_pvt_id(struct skl_sst *ctx,
 				struct skl_module_cfg *mconfig);
+int skl_get_pvt_instance_id_map(struct skl_sst *ctx,
+				int module_id, int instance_id);
 void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 876b9e04e880..1aa0f371b381 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -102,6 +102,7 @@ struct uuid_module {
 	int is_loadable;
 	int max_instance;
 	u64 pvt_id[MAX_INSTANCE_BUFF];
+	int *instance_id;
 
 	struct list_head list;
 };
@@ -135,6 +136,31 @@ int snd_skl_get_module_info(struct skl_sst *ctx,
 }
 EXPORT_SYMBOL_GPL(snd_skl_get_module_info);
 
+static int skl_get_pvtid_map(struct uuid_module *module, int instance_id)
+{
+	int pvt_id;
+
+	for (pvt_id = 0; pvt_id < module->max_instance; pvt_id++) {
+		if (module->instance_id[pvt_id] == instance_id)
+			return pvt_id;
+	}
+	return -EINVAL;
+}
+
+int skl_get_pvt_instance_id_map(struct skl_sst *ctx,
+				int module_id, int instance_id)
+{
+	struct uuid_module *module;
+
+	list_for_each_entry(module, &ctx->uuid_list, list) {
+		if (module->id == module_id)
+			return skl_get_pvtid_map(module, instance_id);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(skl_get_pvt_instance_id_map);
+
 static inline int skl_getid_32(struct uuid_module *module, u64 *val,
 				int word1_mask, int word2_mask)
 {
@@ -203,8 +229,11 @@ int skl_get_pvt_id(struct skl_sst *ctx, struct skl_module_cfg *mconfig)
 		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
 
 			pvt_id = skl_pvtid_128(module);
-			if (pvt_id >= 0)
+			if (pvt_id >= 0) {
+				module->instance_id[pvt_id] =
+						mconfig->id.instance_id;
 				return pvt_id;
+			}
 		}
 	}
 
@@ -254,7 +283,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 {
 	struct adsp_fw_hdr *adsp_hdr;
 	struct adsp_module_entry *mod_entry;
-	int i, num_entry;
+	int i, num_entry, size;
 	uuid_le *uuid_bin;
 	const char *buf;
 	struct skl_sst *skl = ctx->thread_context;
@@ -318,6 +347,10 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 		module->id = (i | (index << 12));
 		module->is_loadable = mod_entry->type.load_type;
 		module->max_instance = mod_entry->instance_max_count;
+		size = sizeof(int) * mod_entry->instance_max_count;
+		module->instance_id = devm_kzalloc(ctx->dev, size, GFP_KERNEL);
+		if (!module->instance_id)
+			return -ENOMEM;
 
 		list_add_tail(&module->list, &skl->uuid_list);
 
-- 
2.9.3
