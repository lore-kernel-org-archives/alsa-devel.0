From: mengdong.lin@linux.intel.com
Subject: [PATCH 01/13] ASoC: topology: Able to create BE DAIs
Date: Fri, 19 Aug 2016 18:12:35 +0800
Message-ID: <390c016a47953561511f529467a1985b77cfd043.1471599648.git.mengdong.lin@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C0F502665CC
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 12:06:44 +0200 (CEST)
In-Reply-To: <cover.1471599648.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Topology will check with ASoC if a BE DAI already exists by checking
its name. If the BE DAI doesn't exist, topology will create a new one
and the dai_load ops will be called for device specific init.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index d318fe4..9ebb9f2 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -39,6 +39,7 @@ enum snd_soc_dobj_type {
 	SND_SOC_DOBJ_ENUM,
 	SND_SOC_DOBJ_BYTES,
 	SND_SOC_DOBJ_PCM,
+	SND_SOC_DOBJ_BE_DAI,
 	SND_SOC_DOBJ_DAI_LINK,
 	SND_SOC_DOBJ_CODEC_LINK,
 	SND_SOC_DOBJ_WIDGET,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 84e3fa1..f6f5027 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2872,7 +2872,8 @@ int snd_soc_register_dai(struct snd_soc_component *component,
 	struct snd_soc_dai *dai;
 	int ret;
 
-	if (dai_drv->dobj.type != SND_SOC_DOBJ_PCM) {
+	if (!(dai_drv->dobj.type == SND_SOC_DOBJ_PCM ||
+	    dai_drv->dobj.type == SND_SOC_DOBJ_BE_DAI)) {
 		dev_err(component->dev, "Invalid dai type %d\n",
 			dai_drv->dobj.type);
 		return -EINVAL;
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index a9e83a2..1e26dc6 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1710,42 +1710,14 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	return 0;
 }
 
-/* *
- * soc_tplg_be_dai_config - Find and configure an existing BE DAI.
- * @tplg: topology context
- * @be: topology BE DAI configs.
- *
- * The BE dai should already be registered by the platform driver. The
- * platform driver should specify the BE DAI name and ID for matching.
- */
-static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
+static int config_be_dai(struct soc_tplg *tplg,
+				  struct snd_soc_dai_driver *dai_drv,
 				  struct snd_soc_tplg_be_dai *be)
 {
-	struct snd_soc_dai_link_component dai_component = {0};
-	struct snd_soc_dai *dai;
-	struct snd_soc_dai_driver *dai_drv;
 	struct snd_soc_pcm_stream *stream;
 	struct snd_soc_tplg_stream_caps *caps;
 	int ret;
 
-	dai_component.dai_name = be->dai_name;
-	dai = snd_soc_find_dai(&dai_component);
-	if (!dai) {
-		dev_err(tplg->dev, "ASoC: BE DAI %s not registered\n",
-			be->dai_name);
-		return -EINVAL;
-	}
-
-	if (be->dai_id != dai->id) {
-		dev_err(tplg->dev, "ASoC: BE DAI %s id mismatch\n",
-			be->dai_name);
-		return -EINVAL;
-	}
-
-	dai_drv = dai->driver;
-	if (!dai_drv)
-		return -EINVAL;
-
 	if (be->playback) {
 		stream = &dai_drv->playback;
 		caps = &be->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
@@ -1764,13 +1736,80 @@ static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_load(tplg, dai_drv);
 	if (ret < 0) {
-		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
+		dev_err(tplg->comp->dev, "ASoC: BE DAI loading failed\n");
 		return ret;
 	}
 
 	return 0;
 }
 
+static int soc_tplg_be_dai_create(struct soc_tplg *tplg,
+				  struct snd_soc_tplg_be_dai *be)
+{
+	struct snd_soc_dai_driver *dai_drv;
+	int ret;
+
+	dai_drv = kzalloc(sizeof(struct snd_soc_dai_driver), GFP_KERNEL);
+	if (dai_drv == NULL)
+		return -ENOMEM;
+
+	dai_drv->name = be->dai_name;
+	dai_drv->id = be->dai_id;
+
+	ret = config_be_dai(tplg, dai_drv, be);
+	if (ret < 0) {
+		kfree(dai_drv);
+		return ret;
+	}
+
+	dai_drv->dobj.index = tplg->index;
+	dai_drv->dobj.ops = tplg->ops;
+	dai_drv->dobj.type = SND_SOC_DOBJ_BE_DAI;
+	list_add(&dai_drv->dobj.list, &tplg->comp->dobj_list);
+
+	/* register the DAI to the component */
+	return snd_soc_register_dai(tplg->comp, dai_drv);
+}
+
+/* *
+ * soc_tplg_be_dai_config - Create a new BE DAI or configure an existing one.
+ * @tplg: topology context
+ * @be: topology BE DAI configs.
+ *
+ * The BE dai should already be registered by the platform driver. The
+ * platform driver should specify the BE DAI name and ID for matching.
+ */
+static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
+				  struct snd_soc_tplg_be_dai *be)
+{
+	struct snd_soc_dai_link_component dai_component = {0};
+	struct snd_soc_dai *dai;
+	struct snd_soc_dai_driver *dai_drv;
+
+	if (!strlen(be->dai_name)) {
+		dev_err(tplg->dev, "ASoC: Invalid BE DAI name\n");
+		return -EINVAL;
+	}
+
+	dai_component.dai_name = be->dai_name;
+	dai = snd_soc_find_dai(&dai_component);
+	if (!dai) /* BE DAI doesn't exist, create it */
+		return soc_tplg_be_dai_create(tplg, be);
+
+	/* configure an existing BE DAI */
+	if (be->dai_id != dai->id) {
+		dev_err(tplg->dev, "ASoC: BE DAI %s id mismatch\n",
+			be->dai_name);
+		return -EINVAL;
+	}
+
+	dai_drv = dai->driver;
+	if (!dai_drv)
+		return -EINVAL;
+
+	return config_be_dai(tplg, dai_drv, be);
+}
+
 static int soc_tplg_be_dai_elems_load(struct soc_tplg *tplg,
 				      struct snd_soc_tplg_hdr *hdr)
 {
@@ -2062,6 +2101,9 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 			case SND_SOC_DOBJ_PCM:
 				remove_dai(comp, dobj, pass);
 				break;
+			case SND_SOC_DOBJ_BE_DAI:
+				remove_dai(comp, dobj, pass);
+				break;
 			case SND_SOC_DOBJ_DAI_LINK:
 				remove_link(comp, dobj, pass);
 				break;
-- 
2.5.0
