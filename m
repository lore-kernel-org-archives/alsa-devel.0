From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Give more data to clients via
	callbacks" to the asoc tree
Date: Mon, 18 Jun 2018 13:00:52 +0100
Message-ID: <E1fUsq4-0000Sz-FP@debutante>
References: <20180614195037.11929-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7701E2676E6
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:54 +0200 (CEST)
In-Reply-To: <20180614195037.11929-1-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Give more data to clients via callbacks

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c60b613a7097cff20fdd05e2891ce69542f0d5a3 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Thu, 14 Jun 2018 20:50:37 +0100
Subject: [PATCH] ASoC: topology: Give more data to clients via callbacks

Give topology clients more access to the topology data by passing index,
pcm, link_config and dai_driver to clients. This allows clients to fully
instantiate and track topology objects.

The SOF driver is the first user of these new APIs and needs them to build
component topology driver and FW objects.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-topology.h           | 23 +++++++++++--------
 sound/soc/intel/skylake/skl-pcm.c      |  7 +++---
 sound/soc/intel/skylake/skl-topology.c |  5 +++--
 sound/soc/intel/skylake/skl-topology.h |  5 +++--
 sound/soc/soc-topology.c               | 31 +++++++++++++++-----------
 5 files changed, 42 insertions(+), 29 deletions(-)

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
index afa86b9e4dcf..1f4dd08d36c5 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1017,10 +1017,11 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
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
index fcdc716754b6..647e52aecdc3 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3024,7 +3024,7 @@ void skl_cleanup_resources(struct skl *skl)
  * information to the driver about module and pipeline parameters which DSP
  * FW expects like ids, resource values, formats etc
  */
-static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
+static int skl_tplg_widget_load(struct snd_soc_component *cmpnt, int index,
 				struct snd_soc_dapm_widget *w,
 				struct snd_soc_tplg_dapm_widget *tplg_w)
 {
@@ -3131,6 +3131,7 @@ static int skl_init_enum_data(struct device *dev, struct soc_enum *se,
 }
 
 static int skl_tplg_control_load(struct snd_soc_component *cmpnt,
+				int index,
 				struct snd_kcontrol_new *kctl,
 				struct snd_soc_tplg_ctl_hdr *hdr)
 {
@@ -3619,7 +3620,7 @@ static int skl_tplg_get_manifest_data(struct snd_soc_tplg_manifest *manifest,
 	return 0;
 }
 
-static int skl_manifest_load(struct snd_soc_component *cmpnt,
+static int skl_manifest_load(struct snd_soc_component *cmpnt, int index,
 				struct snd_soc_tplg_manifest *manifest)
 {
 	struct hdac_ext_bus *ebus = snd_soc_component_get_drvdata(cmpnt);
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 6d7e0569695f..af198ea0379e 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -512,8 +512,9 @@ int skl_pcm_host_dma_prepare(struct device *dev,
 int skl_pcm_link_dma_prepare(struct device *dev,
 			struct skl_pipe_params *params);
 
-int skl_dai_load(struct snd_soc_component *cmp,
-		 struct snd_soc_dai_driver *pcm_dai);
+int skl_dai_load(struct snd_soc_component *cmp, int index,
+		struct snd_soc_dai_driver *dai_drv,
+		struct snd_soc_tplg_pcm *pcm, struct snd_soc_dai *dai);
 void skl_tplg_add_moduleid_in_bind_params(struct skl *skl,
 				struct snd_soc_dapm_widget *w);
 #endif
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 53f121a50c97..9b33260fd537 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -259,7 +259,7 @@ static int soc_tplg_vendor_load_(struct soc_tplg *tplg,
 	int ret = 0;
 
 	if (tplg->comp && tplg->ops && tplg->ops->vendor_load)
-		ret = tplg->ops->vendor_load(tplg->comp, hdr);
+		ret = tplg->ops->vendor_load(tplg->comp, tplg->index, hdr);
 	else {
 		dev_err(tplg->dev, "ASoC: no vendor load callback for ID %d\n",
 			hdr->vendor_type);
@@ -291,7 +291,8 @@ static int soc_tplg_widget_load(struct soc_tplg *tplg,
 	struct snd_soc_dapm_widget *w, struct snd_soc_tplg_dapm_widget *tplg_w)
 {
 	if (tplg->comp && tplg->ops && tplg->ops->widget_load)
-		return tplg->ops->widget_load(tplg->comp, w, tplg_w);
+		return tplg->ops->widget_load(tplg->comp, tplg->index, w,
+			tplg_w);
 
 	return 0;
 }
@@ -302,27 +303,30 @@ static int soc_tplg_widget_ready(struct soc_tplg *tplg,
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
@@ -643,7 +647,8 @@ static int soc_tplg_init_kcontrol(struct soc_tplg *tplg,
 	struct snd_kcontrol_new *k, struct snd_soc_tplg_ctl_hdr *hdr)
 {
 	if (tplg->comp && tplg->ops && tplg->ops->control_load)
-		return tplg->ops->control_load(tplg->comp, k, hdr);
+		return tplg->ops->control_load(tplg->comp, tplg->index, k,
+			hdr);
 
 	return 0;
 }
@@ -1702,7 +1707,7 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 		dai_drv->compress_new = snd_soc_new_compress;
 
 	/* pass control to component driver for optional further init */
-	ret = soc_tplg_dai_load(tplg, dai_drv);
+	ret = soc_tplg_dai_load(tplg, dai_drv, pcm, NULL);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
 		kfree(dai_drv);
@@ -1772,7 +1777,7 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 		set_link_flags(link, pcm->flag_mask, pcm->flags);
 
 	/* pass control to component driver for optional further init */
-	ret = soc_tplg_dai_link_load(tplg, link);
+	ret = soc_tplg_dai_link_load(tplg, link, NULL);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: FE link loading failed\n");
 		kfree(link);
@@ -2080,7 +2085,7 @@ static int soc_tplg_link_config(struct soc_tplg *tplg,
 		set_link_flags(link, cfg->flag_mask, cfg->flags);
 
 	/* pass control to component driver for optional further init */
-	ret = soc_tplg_dai_link_load(tplg, link);
+	ret = soc_tplg_dai_link_load(tplg, link, cfg);
 	if (ret < 0) {
 		dev_err(tplg->dev, "ASoC: physical link loading failed\n");
 		return ret;
@@ -2202,7 +2207,7 @@ static int soc_tplg_dai_config(struct soc_tplg *tplg,
 		set_dai_flags(dai_drv, d->flag_mask, d->flags);
 
 	/* pass control to component driver for optional further init */
-	ret = soc_tplg_dai_load(tplg, dai_drv);
+	ret = soc_tplg_dai_load(tplg, dai_drv, NULL, dai);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
 		return ret;
@@ -2311,7 +2316,7 @@ static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 
 	/* pass control to component driver for optional further init */
 	if (tplg->comp && tplg->ops && tplg->ops->manifest)
-		return tplg->ops->manifest(tplg->comp, _manifest);
+		return tplg->ops->manifest(tplg->comp, tplg->index, _manifest);
 
 	if (!abi_match)	/* free the duplicated one */
 		kfree(_manifest);
-- 
2.17.1
