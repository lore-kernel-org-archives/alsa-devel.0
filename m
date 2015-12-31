From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/5] ASoC: Define soc_add_dai() to add a DAI to
	a component
Date: Thu, 31 Dec 2015 16:40:20 +0800
Message-ID: <e5451d9a299337e2a565ff17fbfec60a9597799f.1451550513.git.mengdong.lin@linux.intel.com>
References: <cover.1451550513.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C9038265AE8
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 09:23:23 +0100 (CET)
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

Define soc_add_dai() as a wrapper to add a single DAI to a component.
It can be reused to register a DAI dynamically by topology.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4ddc5d5..bfd2424 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2771,6 +2771,56 @@ static void snd_soc_unregister_dais(struct snd_soc_component *component)
 	}
 }
 
+/* Create a DAI and add it to the component's DAI list */
+static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
+	struct snd_soc_dai_driver *dai_drv,
+	bool legacy_dai_naming)
+{
+	struct device *dev = component->dev;
+	struct snd_soc_dai *dai;
+
+	dev_dbg(dev, "ASoC: dynamically register DAI %s\n", dev_name(dev));
+
+	dai = kzalloc(sizeof(struct snd_soc_dai), GFP_KERNEL);
+	if (dai == NULL)
+		return NULL;
+
+	/*
+	 * Back in the old days when we still had component-less DAIs,
+	 * instead of having a static name, component-less DAIs would
+	 * inherit the name of the parent device so it is possible to
+	 * register multiple instances of the DAI. We still need to keep
+	 * the same naming style even though those DAIs are not
+	 * component-less anymore.
+	 */
+	if (legacy_dai_naming &&
+	   (dai_drv->id == 0 || dai_drv->name == NULL)) {
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
+		return NULL;
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
+}
+
 /**
  * snd_soc_register_dais - Register a DAI with the ASoC core
  *
@@ -2792,49 +2842,15 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 	dev_dbg(dev, "ASoC: dai register %s #%Zu\n", dev_name(dev), count);
 
 	component->dai_drv = dai_drv;
-	component->num_dai = count;
 
 	for (i = 0; i < count; i++) {
 
-		dai = kzalloc(sizeof(struct snd_soc_dai), GFP_KERNEL);
+		dai = soc_add_dai(component, dai_drv + i,
+				count == 1 && legacy_dai_naming);
 		if (dai == NULL) {
 			ret = -ENOMEM;
 			goto err;
 		}
-
-		/*
-		 * Back in the old days when we still had component-less DAIs,
-		 * instead of having a static name, component-less DAIs would
-		 * inherit the name of the parent device so it is possible to
-		 * register multiple instances of the DAI. We still need to keep
-		 * the same naming style even though those DAIs are not
-		 * component-less anymore.
-		 */
-		if (count == 1 && legacy_dai_naming &&
-			(dai_drv[i].id == 0 || dai_drv[i].name == NULL)) {
-			dai->name = fmt_single_name(dev, &dai->id);
-		} else {
-			dai->name = fmt_multiple_name(dev, &dai_drv[i]);
-			if (dai_drv[i].id)
-				dai->id = dai_drv[i].id;
-			else
-				dai->id = i;
-		}
-		if (dai->name == NULL) {
-			kfree(dai);
-			ret = -ENOMEM;
-			goto err;
-		}
-
-		dai->component = component;
-		dai->dev = dev;
-		dai->driver = &dai_drv[i];
-		if (!dai->driver->ops)
-			dai->driver->ops = &null_dai_ops;
-
-		list_add(&dai->list, &component->dai_list);
-
-		dev_dbg(dev, "ASoC: Registered DAI '%s'\n", dai->name);
 	}
 
 	return 0;
-- 
2.5.0
