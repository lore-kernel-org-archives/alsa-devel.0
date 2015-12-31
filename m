From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/5] ASoC: Support registering a DAI dynamically
Date: Thu, 31 Dec 2015 16:40:43 +0800
Message-ID: <ce77885082109fef7b6a7694d9c02156381b9b81.1451550513.git.mengdong.lin@linux.intel.com>
References: <cover.1451550513.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B921D265B6C
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 09:23:46 +0100 (CET)
In-Reply-To: <cover.1451550513.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Define API snd_soc_register_dai() to add a DAI dynamically and
create the DAI widgets. Topology can use this API to register DAIs
when probing a component with topology info. These DAIs's playback
& capture widgets will be freed when the sound card is unregistered
and the DAIs will be freed when cleaning up the component.

And a dobj is embedded into the struct snd_soc_dai_driver. Topology
can use the dobj to find the DAI drivers created by it and free them
when the topology component is removed.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 212eaaf..964b7de 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -222,6 +222,7 @@ struct snd_soc_dai_driver {
 	const char *name;
 	unsigned int id;
 	unsigned int base;
+	struct snd_soc_dobj dobj;
 
 	/* DAI driver callbacks */
 	int (*probe)(struct snd_soc_dai *dai);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8436a11..796b757 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1685,6 +1685,9 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 void snd_soc_remove_dai_link(struct snd_soc_card *card,
 			     struct snd_soc_dai_link *dai_link);
 
+int snd_soc_register_dai(struct snd_soc_component *component,
+	struct snd_soc_dai_driver *dai_drv);
+
 #include <sound/soc-dai.h>
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bfd2424..be1e692 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2861,6 +2861,48 @@ err:
 	return ret;
 }
 
+/**
+ * snd_soc_register_dai - Register a DAI dynamically & create its widgets
+ *
+ * @component: The component the DAIs are registered for
+ * @dai_drv: DAI driver to use for the DAI
+ *
+ * Topology can use this API to register DAIs when probing a component.
+ * These DAIs's widgets will be freed in the card cleanup and the DAIs
+ * will be freed in the component cleanup.
+ */
+int snd_soc_register_dai(struct snd_soc_component *component,
+	struct snd_soc_dai_driver *dai_drv)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	struct snd_soc_dai *dai;
+	int ret;
+
+	if (dai_drv->dobj.type != SND_SOC_DOBJ_PCM) {
+		dev_err(component->dev, "Invalid dai type %d\n",
+			dai_drv->dobj.type);
+		return -EINVAL;
+	}
+
+	lockdep_assert_held(&client_mutex);
+	dai = soc_add_dai(component, dai_drv, false);
+	if (!dai)
+		return -ENOMEM;
+
+	/* Create the DAI widgets here. After adding DAIs, topology may
+	 * also add routes that need these widgets as source or sink.
+	 */
+	ret = snd_soc_dapm_new_dai_widgets(dapm, dai);
+	if (ret != 0) {
+		dev_err(component->dev,
+			"Failed to create DAI widgets %d\n", ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_register_dai);
+
 static void snd_soc_component_seq_notifier(struct snd_soc_dapm_context *dapm,
 	enum snd_soc_dapm_type type, int subseq)
 {
-- 
2.5.0
