From: mengdong.lin@intel.com
Subject: [PATCH v2 07/10] ASoC: Support adding a DAI dynamically
Date: Mon, 10 Aug 2015 22:48:19 +0800
Message-ID: <66ecc438c3f464ec6baeb892b1cab674c935f6db.1439217448.git.mengdong.lin@intel.com>
References: <cover.1439217448.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 18EFB265A58
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 16:35:02 +0200 (CEST)
In-Reply-To: <cover.1439217448.git.mengdong.lin@intel.com>
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
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

API snd_soc_add_dai() is defined to register a DAI dynamically, create its
DAI widget, and notify the machine driver. This API can be used by the
topology core to add DAIs dynamically.

And a callback add_dai() is defined for the soc card. The machine driver
can implement this callback. Adding a new DAI dynmaically will trigger
this callback, and the machine driver can create relavant DAI link in the
callback context.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7e04ec0..2a474c8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1081,6 +1081,7 @@ struct snd_soc_card {
 	int (*set_bias_level_post)(struct snd_soc_card *,
 				   struct snd_soc_dapm_context *dapm,
 				   enum snd_soc_bias_level level);
+	int (*add_dai)(struct snd_soc_card *, struct snd_soc_dai_driver*);
 
 	long pmdown_time;
 
@@ -1634,6 +1635,9 @@ int snd_soc_of_get_dai_link_codecs(struct device *dev,
 void snd_soc_add_dai_link(struct snd_soc_card *card,
 				struct snd_soc_dai_link *dai_link);
 
+int snd_soc_add_dai(struct snd_soc_component *component,
+	struct snd_soc_dai_driver *dai_drv);
+
 #include <sound/soc-dai.h>
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2818709..b330676 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2792,6 +2792,98 @@ err:
 	return ret;
 }
 
+static struct snd_soc_dai *soc_register_dai(struct snd_soc_component *component,
+	struct snd_soc_dai_driver *dai_drv,
+	bool legacy_dai_naming)
+{
+	struct device *dev = component->dev;
+	struct snd_soc_dai *dai;
+	int ret;
+
+	dev_dbg(dev, "ASoC: dynamically register DAI %s\n", dev_name(dev));
+
+	dai = kzalloc(sizeof(struct snd_soc_dai), GFP_KERNEL);
+	if (dai == NULL) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/*
+	 * Back in the old days when we still had component-less DAIs,
+	 * instead of having a static name, component-less DAIs would
+	 * inherit the name of the parent device so it is possible to
+	 * register multiple instances of the DAI. We still need to keep
+	 * the same naming style even though those DAIs are not
+	 * component-less anymore.
+	 */
+	if (legacy_dai_naming) {
+		dai->name = fmt_single_name(dev, &dai->id);
+	} else {
+		dai->name = fmt_multiple_name(dev, dai_drv);
+		if (dai_drv->id)
+			dai->id = dai_drv->id;
+		else
+			dai->id = component->num_dai;
+	}
+	if (dai->name == NULL) {
+		kfree(dai);
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	dai->component = component;
+	dai->dev = dev;
+	dai->driver = dai_drv;
+	if (!dai->driver->ops)
+		dai->driver->ops = &null_dai_ops;
+
+	list_add(&dai->list, &component->dai_list);
+	component->num_dai++;
+
+	dev_dbg(dev, "ASoC: Registered DAI '%s'\n", dai->name);
+	return dai;
+
+err:
+	kfree(dai);
+	return NULL;
+}
+
+/**
+ * snd_soc_add_dai - Add a DAI dynamically with the ASoC core
+ *
+ * @component: The component the DAIs are registered for
+ * @dai_drv: DAI driver to use for the DAI
+ */
+int snd_soc_add_dai(struct snd_soc_component *component,
+	struct snd_soc_dai_driver *dai_drv)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	struct snd_soc_card *card = component->card;
+	struct snd_soc_dai *dai;
+	int ret;
+
+	lockdep_assert_held(&client_mutex);
+	dai = soc_register_dai(component, dai_drv, false);
+	if (!dai)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_new_dai_widgets(dapm, dai);
+	if (ret != 0) {
+		dev_err(component->dev,
+			"Failed to create DAI widgets %d\n", ret);
+	}
+
+	/* Notify the machine driver a new DAI is added, so the machine driver
+	 * can add new DAI links in the callback context.
+	 */
+	if (card && card->add_dai)
+		card->add_dai(card, dai_drv);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_add_dai);
+
 static void snd_soc_component_seq_notifier(struct snd_soc_dapm_context *dapm,
 	enum snd_soc_dapm_type type, int subseq)
 {
-- 
1.9.1
