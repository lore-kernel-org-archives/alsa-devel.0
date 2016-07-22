From: mengdong.lin@linux.intel.com
Subject: [PATCH 3/3] ASoC: topology: Able to create BE DAIs
Date: Fri, 22 Jul 2016 13:59:50 +0800
Message-ID: <001ecaeba478e2ef863a232c89412b09d4b6de11.1469165422.git.mengdong.lin@linux.intel.com>
References: <cover.1469165422.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D17E5265913
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 07:54:43 +0200 (CEST)
In-Reply-To: <cover.1469165422.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Topology will check with ASoC if a BE DAI already exists by checking
its name. If the BE DAI doesn't exist, topology will create a new one
and the dai_load ops will be called for device specific init.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index b897b9d..c7aa6e2 100644
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
index 16369ca..c0ee988 100644
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
index 05a18f6..924f370 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1709,42 +1709,14 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
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
@@ -1770,6 +1742,74 @@ static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
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
+		dev_err(tplg->dev, "ASoC: Invalid BE DAI name\n",
+			be->dai_name);
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
@@ -2061,6 +2101,9 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
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
