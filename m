From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 3/6] ASoC: topology: Give more data to
	clients via callbacks
Date: Tue, 27 Mar 2018 14:30:42 +0100
Message-ID: <20180327133045.29351-4-liam.r.girdwood@linux.intel.com>
References: <20180327133045.29351-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A036E26719A
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 15:31:03 +0200 (CEST)
In-Reply-To: <20180327133045.29351-1-liam.r.girdwood@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Give topology clients more access to the topology data by passing index,
pcm, link_config and dai_driver to clients. This allows clients to fully
instantiate and track topology objects.

The SOF driver is the first user of these new APIs and needs them to build
component topology driver and FW objects.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc-topology.h           | 23 ++++++++++++++---------
 sound/soc/intel/skylake/skl-pcm.c      |  7 ++++---
 sound/soc/intel/skylake/skl-topology.c |  5 +++--
 sound/soc/intel/skylake/skl-topology.h | 20 +++++---------------
 sound/soc/soc-topology.c               | 31 ++++++++++++++++++-------------
 5 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index f552c3f56368..e1f265e21ee1 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -30,6 +30,8 @@ struct snd_soc_dapm_context;
 struct snd_soc_card;
 struct snd_kcontrol_new;
 struct snd_soc_dai_link;
+struct snd_soc_dai_driver;
+struct snd_soc_dai;
 
 /* object scan be loaded and unloaded in groups with identfying indexes */
 #define SND_SOC_TPLG_INDEX_ALL	0	/* ID that matches all FW objects */
@@ -109,35 +111,38 @@ struct snd_soc_tplg_widget_events {
 struct snd_soc_tplg_ops {
 
 	/* external kcontrol init - used for any driver specific init */
-	int (*control_load)(struct snd_soc_component *,
+	int (*control_load)(struct snd_soc_component *, int index,
 		struct snd_kcontrol_new *, struct snd_soc_tplg_ctl_hdr *);
 	int (*control_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
 	/* external widget init - used for any driver specific init */
-	int (*widget_load)(struct snd_soc_component *,
+	int (*widget_load)(struct snd_soc_component *, int index,
 		struct snd_soc_dapm_widget *,
 		struct snd_soc_tplg_dapm_widget *);
-	int (*widget_ready)(struct snd_soc_component *,
+	int (*widget_ready)(struct snd_soc_component *, int index,
 		struct snd_soc_dapm_widget *,
 		struct snd_soc_tplg_dapm_widget *);
 	int (*widget_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
 	/* FE DAI - used for any driver specific init */
-	int (*dai_load)(struct snd_soc_component *,
-		struct snd_soc_dai_driver *dai_drv);
+	int (*dai_load)(struct snd_soc_component *, int index,
+		struct snd_soc_dai_driver *dai_drv,
+		struct snd_soc_tplg_pcm *pcm, struct snd_soc_dai *dai);
+
 	int (*dai_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
 	/* DAI link - used for any driver specific init */
-	int (*link_load)(struct snd_soc_component *,
-		struct snd_soc_dai_link *link);
+	int (*link_load)(struct snd_soc_component *, int index,
+		struct snd_soc_dai_link *link,
+		struct snd_soc_tplg_link_config *cfg);
 	int (*link_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
 	/* callback to handle vendor bespoke data */
-	int (*vendor_load)(struct snd_soc_component *,
+	int (*vendor_load)(struct snd_soc_component *, int index,
 		struct snd_soc_tplg_hdr *);
 	int (*vendor_unload)(struct snd_soc_component *,
 		struct snd_soc_tplg_hdr *);
@@ -146,7 +151,7 @@ struct snd_soc_tplg_ops {
 	void (*complete)(struct snd_soc_component *);
 
 	/* manifest - optional to inform component of manifest */
-	int (*manifest)(struct snd_soc_component *,
+	int (*manifest)(struct snd_soc_component *, int index,
 		struct snd_soc_tplg_manifest *);
 
 	/* vendor specific kcontrol handlers available for binding */
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 15cb8ac3e374..c466265a2fbb 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -989,10 +989,11 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 },
 };
 
-int skl_dai_load(struct snd_soc_component *cmp,
-		 struct snd_soc_dai_driver *pcm_dai)
+int skl_dai_load(struct snd_soc_component *cmp, int index,
+			struct snd_soc_dai_driver *dai_drv,
+			struct snd_soc_tplg_pcm *pcm, struct snd_soc_dai *dai)
 {
-	pcm_dai->ops = &skl_pcm_dai_ops;
+	dai_drv->ops = &skl_pcm_dai_ops;
 
 	return 0;
 }
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 3b1dca419883..6ac081f1f215 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2851,7 +2851,7 @@ void skl_cleanup_resources(struct skl *skl)
  * information to the driver about module and pipeline parameters which DSP
  * FW expects like ids, resource values, formats etc
  */
-static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
+static int skl_tplg_widget_load(struct snd_soc_component *cmpnt, int index,
 				struct snd_soc_dapm_widget *w,
 				struct snd_soc_tplg_dapm_widget *tplg_w)
 {
@@ -2958,6 +2958,7 @@ static int skl_init_enum_data(struct device *dev, struct soc_enum *se,
 }
 
 static int skl_tplg_control_load(struct snd_soc_component *cmpnt,
+				int index,
 				struct snd_kcontrol_new *kctl,
 				struct snd_soc_tplg_ctl_hdr *hdr)
 {
@@ -3446,7 +3447,7 @@ static int skl_tplg_get_manifest_data(struct snd_soc_tplg_manifest *manifest,
 	return 0;
 }
 
-static int skl_manifest_load(struct snd_soc_component *cmpnt,
+static int skl_manifest_load(struct snd_soc_component *cmpnt, int index,
 				struct snd_soc_tplg_manifest *manifest)
 {
 	struct hdac_ext_bus *ebus = snd_soc_component_get_drvdata(cmpnt);
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index b1e0667c0ae0..77857c598eed 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -221,18 +221,9 @@ struct skl_mod_inst_map {
 	u16 inst_id;
 };
 
-struct skl_uuid_inst_map {
-	u16 inst_id;
-	u16 reserved;
-	uuid_le mod_uuid;
-} __packed;
-
 struct skl_kpb_params {
 	u32 num_modules;
-	union {
-		struct skl_mod_inst_map map[0];
-		struct skl_uuid_inst_map map_uuid[0];
-	} u;
+	struct skl_mod_inst_map map[0];
 };
 
 struct skl_module_inst_id {
@@ -469,7 +460,7 @@ int skl_dsp_set_dma_control(struct skl_sst *ctx, u32 *caps,
 			u32 caps_size, u32 node_id);
 void skl_tplg_set_be_dmic_config(struct snd_soc_dai *dai,
 	struct skl_pipe_params *params, int stream);
-int skl_tplg_init(struct snd_soc_component *component,
+int skl_tplg_init(struct snd_soc_platform *platform,
 				struct hdac_ext_bus *ebus);
 struct skl_module_cfg *skl_tplg_fe_get_cpr_module(
 		struct snd_soc_dai *dai, int stream);
@@ -512,8 +503,7 @@ int skl_pcm_host_dma_prepare(struct device *dev,
 int skl_pcm_link_dma_prepare(struct device *dev,
 			struct skl_pipe_params *params);
 
-int skl_dai_load(struct snd_soc_component *cmp,
-		 struct snd_soc_dai_driver *pcm_dai);
-void skl_tplg_add_moduleid_in_bind_params(struct skl *skl,
-				struct snd_soc_dapm_widget *w);
+int skl_dai_load(struct snd_soc_component *, int index,
+		struct snd_soc_dai_driver *dai_drv,
+		struct snd_soc_tplg_pcm *pcm, struct snd_soc_dai *dai);
 #endif
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index dd521e85c84a..c43515d218ea 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -315,7 +315,7 @@ static int soc_tplg_vendor_load_(struct soc_tplg *tplg,
 	int ret = 0;
 
 	if (tplg->comp && tplg->ops && tplg->ops->vendor_load)
-		ret = tplg->ops->vendor_load(tplg->comp, hdr);
+		ret = tplg->ops->vendor_load(tplg->comp, tplg->index, hdr);
 	else {
 		dev_err(tplg->dev, "ASoC: no vendor load callback for ID %d\n",
 			hdr->vendor_type);
@@ -347,7 +347,8 @@ static int soc_tplg_widget_load(struct soc_tplg *tplg,
 	struct snd_soc_dapm_widget *w, struct snd_soc_tplg_dapm_widget *tplg_w)
 {
 	if (tplg->comp && tplg->ops && tplg->ops->widget_load)
-		return tplg->ops->widget_load(tplg->comp, w, tplg_w);
+		return tplg->ops->widget_load(tplg->comp, tplg->index, w,
+			tplg_w);
 
 	return 0;
 }
@@ -358,27 +359,30 @@ static int soc_tplg_widget_ready(struct soc_tplg *tplg,
 	struct snd_soc_dapm_widget *w, struct snd_soc_tplg_dapm_widget *tplg_w)
 {
 	if (tplg->comp && tplg->ops && tplg->ops->widget_ready)
-		return tplg->ops->widget_ready(tplg->comp, w, tplg_w);
+		return tplg->ops->widget_ready(tplg->comp, tplg->index, w,
+			tplg_w);
 
 	return 0;
 }
 
 /* pass DAI configurations to component driver for extra initialization */
 static int soc_tplg_dai_load(struct soc_tplg *tplg,
-	struct snd_soc_dai_driver *dai_drv)
+	struct snd_soc_dai_driver *dai_drv,
+	struct snd_soc_tplg_pcm *pcm, struct snd_soc_dai *dai)
 {
 	if (tplg->comp && tplg->ops && tplg->ops->dai_load)
-		return tplg->ops->dai_load(tplg->comp, dai_drv);
+		return tplg->ops->dai_load(tplg->comp, tplg->index, dai_drv,
+			pcm, dai);
 
 	return 0;
 }
 
 /* pass link configurations to component driver for extra initialization */
 static int soc_tplg_dai_link_load(struct soc_tplg *tplg,
-	struct snd_soc_dai_link *link)
+	struct snd_soc_dai_link *link, struct snd_soc_tplg_link_config *cfg)
 {
 	if (tplg->comp && tplg->ops && tplg->ops->link_load)
-		return tplg->ops->link_load(tplg->comp, link);
+		return tplg->ops->link_load(tplg->comp, tplg->index, link, cfg);
 
 	return 0;
 }
@@ -699,7 +703,8 @@ static int soc_tplg_init_kcontrol(struct soc_tplg *tplg,
 	struct snd_kcontrol_new *k, struct snd_soc_tplg_ctl_hdr *hdr)
 {
 	if (tplg->comp && tplg->ops && tplg->ops->control_load)
-		return tplg->ops->control_load(tplg->comp, k, hdr);
+		return tplg->ops->control_load(tplg->comp, tplg->index, k,
+			hdr);
 
 	return 0;
 }
@@ -1751,7 +1756,7 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	}
 
 	/* pass control to component driver for optional further init */
-	ret = soc_tplg_dai_load(tplg, dai_drv);
+	ret = soc_tplg_dai_load(tplg, dai_drv, pcm, NULL);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
 		kfree(dai_drv);
@@ -1821,7 +1826,7 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 		set_link_flags(link, pcm->flag_mask, pcm->flags);
 
 	/* pass control to component driver for optional further init */
-	ret = soc_tplg_dai_link_load(tplg, link);
+	ret = soc_tplg_dai_link_load(tplg, link, NULL);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: FE link loading failed\n");
 		kfree(link);
@@ -2112,7 +2117,7 @@ static int soc_tplg_link_config(struct soc_tplg *tplg,
 		set_link_flags(link, cfg->flag_mask, cfg->flags);
 
 	/* pass control to component driver for optional further init */
-	ret = soc_tplg_dai_link_load(tplg, link);
+	ret = soc_tplg_dai_link_load(tplg, link, cfg);
 	if (ret < 0) {
 		dev_err(tplg->dev, "ASoC: physical link loading failed\n");
 		return ret;
@@ -2234,7 +2239,7 @@ static int soc_tplg_dai_config(struct soc_tplg *tplg,
 		set_dai_flags(dai_drv, d->flag_mask, d->flags);
 
 	/* pass control to component driver for optional further init */
-	ret = soc_tplg_dai_load(tplg, dai_drv);
+	ret = soc_tplg_dai_load(tplg, dai_drv, NULL, dai);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
 		return ret;
@@ -2340,7 +2345,7 @@ static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 
 	/* pass control to component driver for optional further init */
 	if (tplg->comp && tplg->ops && tplg->ops->manifest)
-		return tplg->ops->manifest(tplg->comp, _manifest);
+		return tplg->ops->manifest(tplg->comp, tplg->index, _manifest);
 
 	if (!abi_match)	/* free the duplicated one */
 		kfree(_manifest);
-- 
2.14.1
