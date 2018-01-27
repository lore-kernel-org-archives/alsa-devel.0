From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 4/5] ASoC: Intel: Skylake: Find module id from
	UUID for bind params
Date: Sat, 27 Jan 2018 09:50:24 +0530
Message-ID: <20180127042025.22042-5-guneshwor.o.singh@intel.com>
References: <20180127042025.22042-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E6F07267284
 for <alsa-devel@alsa-project.org>; Sat, 27 Jan 2018 05:21:33 +0100 (CET)
In-Reply-To: <20180127042025.22042-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Sriram Periyasamy <sriramx.periyasamy@intel.com>

Module id is a property of firmware manifest and can vary across
platforms. So use the uuid to find module id dynamically for bind
params like kpb post bind params.

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c      |  2 +
 sound/soc/intel/skylake/skl-topology.c | 83 +++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl-topology.h | 13 +++++-
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 2685d511c06f..91d858e25fce 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1318,6 +1318,8 @@ static int skl_populate_modules(struct skl *skl)
 					"query module info failed\n");
 				return ret;
 			}
+
+			skl_tplg_add_moduleid_in_bind_params(skl, w);
 		}
 	}
 
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index dbe6a19b84f5..17da3b58c214 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -830,7 +830,7 @@ static int skl_fill_sink_instance_id(struct skl_sst *ctx, u32 *params,
 	if (mcfg->m_type == SKL_MODULE_TYPE_KPB) {
 		struct skl_kpb_params *kpb_params =
 				(struct skl_kpb_params *)params;
-		struct skl_mod_inst_map *inst = kpb_params->map;
+		struct skl_mod_inst_map *inst = kpb_params->u.map;
 
 		for (i = 0; i < kpb_params->num_modules; i++) {
 			pvt_id = skl_get_pvt_instance_id_map(ctx, inst->mod_id,
@@ -915,6 +915,87 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int skl_get_module_id(struct skl_sst *ctx, uuid_le *uuid)
+{
+	struct uuid_module *module;
+
+	list_for_each_entry(module, &ctx->uuid_list, list) {
+		if (uuid_le_cmp(*uuid, module->uuid) == 0)
+			return module->id;
+	}
+
+	return -EINVAL;
+}
+
+static int skl_tplg_find_moduleid_from_uuid(struct skl *skl,
+					const struct snd_kcontrol_new *k)
+{
+	struct soc_bytes_ext *sb = (void *) k->private_value;
+	struct skl_algo_data *bc = (struct skl_algo_data *)sb->dobj.private;
+	struct skl_kpb_params *uuid_params, *params;
+	struct hdac_bus *bus = ebus_to_hbus(skl_to_ebus(skl));
+	int i, size, module_id;
+
+	if (bc->set_params == SKL_PARAM_BIND && bc->max) {
+		uuid_params = (struct skl_kpb_params *)bc->params;
+		size = uuid_params->num_modules *
+			sizeof(struct skl_mod_inst_map) +
+			sizeof(uuid_params->num_modules);
+
+		params = devm_kzalloc(bus->dev, size, GFP_KERNEL);
+		if (!params)
+			return -ENOMEM;
+
+		params->num_modules = uuid_params->num_modules;
+
+		for (i = 0; i < uuid_params->num_modules; i++) {
+			module_id = skl_get_module_id(skl->skl_sst,
+				&uuid_params->u.map_uuid[i].mod_uuid);
+			if (module_id < 0) {
+				devm_kfree(bus->dev, params);
+				return -EINVAL;
+			}
+
+			params->u.map[i].mod_id = module_id;
+			params->u.map[i].inst_id =
+				uuid_params->u.map_uuid[i].inst_id;
+		}
+
+		devm_kfree(bus->dev, bc->params);
+		bc->params = (char *)params;
+		bc->max = size;
+	}
+
+	return 0;
+}
+
+/*
+ * Retrieve the module id from UUID mentioned in the
+ * post bind params
+ */
+void skl_tplg_add_moduleid_in_bind_params(struct skl *skl,
+				struct snd_soc_dapm_widget *w)
+{
+	struct skl_module_cfg *mconfig = w->priv;
+	int i;
+
+	/*
+	 * Post bind params are used for only for KPB
+	 * to set copier instances to drain the data
+	 * in fast mode
+	 */
+	if (mconfig->m_type != SKL_MODULE_TYPE_KPB)
+		return;
+
+	for (i = 0; i < w->num_kcontrols; i++)
+		if ((w->kcontrol_news[i].access &
+			SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) &&
+			(skl_tplg_find_moduleid_from_uuid(skl,
+			&w->kcontrol_news[i]) < 0))
+			dev_err(skl->skl_sst->dev,
+				"%s: invalid kpb post bind params\n",
+				__func__);
+}
 
 static int skl_tplg_module_add_deferred_bind(struct skl *skl,
 	struct skl_module_cfg *src, struct skl_module_cfg *dst)
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index b6496513fe55..a467129cc705 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -221,9 +221,18 @@ struct skl_mod_inst_map {
 	u16 inst_id;
 };
 
+struct skl_uuid_inst_map {
+	u16 inst_id;
+	u16 reserved;
+	uuid_le mod_uuid;
+} __packed;
+
 struct skl_kpb_params {
 	u32 num_modules;
-	struct skl_mod_inst_map map[0];
+	union {
+		struct skl_mod_inst_map map[0];
+		struct skl_uuid_inst_map map_uuid[0];
+	} u;
 };
 
 struct skl_module_inst_id {
@@ -505,4 +514,6 @@ int skl_pcm_link_dma_prepare(struct device *dev,
 
 int skl_dai_load(struct snd_soc_component *cmp,
 		 struct snd_soc_dai_driver *pcm_dai);
+void skl_tplg_add_moduleid_in_bind_params(struct skl *skl,
+				struct snd_soc_dapm_widget *w);
 #endif
-- 
2.16.1
