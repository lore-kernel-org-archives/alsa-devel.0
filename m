From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Define soc_add_dai() to add a DAI to a
	component" to the asoc tree
Date: Sun, 10 Jan 2016 12:07:40 +0000
Message-ID: <E1aIEma-0007Nx-Qf@debutante>
References: <e5451d9a299337e2a565ff17fbfec60a9597799f.1451550513.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77D1D2605EA
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:07:46 +0100 (CET)
In-Reply-To: <e5451d9a299337e2a565ff17fbfec60a9597799f.1451550513.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Define soc_add_dai() to add a DAI to a component

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

>From 5e4fb372117f476e0c7f85418ed3e39506fbb75c Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Thu, 31 Dec 2015 16:40:20 +0800
Subject: [PATCH] ASoC: Define soc_add_dai() to add a DAI to a component

Define soc_add_dai() as a wrapper to add a single DAI to a component.
It can be reused to register a DAI dynamically by topology.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 88 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 36 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6b1982dcedf1..1bd0b37b907f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2744,6 +2744,56 @@ static void snd_soc_unregister_dais(struct snd_soc_component *component)
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
@@ -2765,49 +2815,15 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
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
2.7.0.rc3
