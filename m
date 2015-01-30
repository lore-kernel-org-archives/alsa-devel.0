From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: Add sysfs entries via static attribute
	groups
Date: Fri, 30 Jan 2015 18:22:05 +0100
Message-ID: <1422638525-612-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 679EF260474
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 18:22:12 +0100 (CET)
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
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Instead of calling device_create_file() manually, assign the static
attribute group entries at the device registration.  This simplifies
the code and avoids the possible races.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/soc-dapm.h |  2 +-
 sound/soc/soc-core.c     | 40 ++++++++++++++++------------------------
 sound/soc/soc-dapm.c     | 16 +++++++---------
 3 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 89823cfe6f04..9fecd6752fcb 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -405,7 +405,7 @@ int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
 		struct snd_soc_dapm_update *update);
 
 /* dapm sys fs - used by the core */
-int snd_soc_dapm_sys_add(struct device *dev);
+extern const struct attribute_group soc_dapm_dev_attr_group;
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 				struct dentry *parent);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2c62620abca6..386365f4a628 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -949,8 +949,6 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
-		device_remove_file(rtd->dev, &dev_attr_pmdown_time);
-		device_remove_file(rtd->dev, &dev_attr_codec_reg);
 		device_unregister(rtd->dev);
 		rtd->dev_registered = 0;
 	}
@@ -1103,6 +1101,21 @@ err_probe:
 	return ret;
 }
 
+static struct attribute *soc_dev_attrs[] = {
+	&dev_attr_codec_reg.attr,
+	&dev_attr_pmdown_time.attr,
+	NULL
+};
+
+static const struct attribute_group soc_dev_attr_group = {
+	.attrs = soc_dev_attrs,
+};
+
+static const struct attribute_group *soc_dev_attr_groups[] = {
+	&soc_dev_attr_group,
+	&soc_dapm_dev_attr_group,
+};
+
 static void rtd_release(struct device *dev)
 {
 	kfree(dev);
@@ -1120,6 +1133,7 @@ static int soc_post_component_init(struct snd_soc_pcm_runtime *rtd,
 	device_initialize(rtd->dev);
 	rtd->dev->parent = rtd->card->dev;
 	rtd->dev->release = rtd_release;
+	rtd->dev->groups = soc_dev_attr_groups;
 	dev_set_name(rtd->dev, "%s", name);
 	dev_set_drvdata(rtd->dev, rtd);
 	mutex_init(&rtd->pcm_mutex);
@@ -1136,23 +1150,6 @@ static int soc_post_component_init(struct snd_soc_pcm_runtime *rtd,
 		return ret;
 	}
 	rtd->dev_registered = 1;
-
-	if (rtd->codec) {
-		/* add DAPM sysfs entries for this codec */
-		ret = snd_soc_dapm_sys_add(rtd->dev);
-		if (ret < 0)
-			dev_err(rtd->dev,
-				"ASoC: failed to add codec dapm sysfs entries: %d\n",
-				ret);
-
-		/* add codec sysfs entries */
-		ret = device_create_file(rtd->dev, &dev_attr_codec_reg);
-		if (ret < 0)
-			dev_err(rtd->dev,
-				"ASoC: failed to add codec sysfs files: %d\n",
-				ret);
-	}
-
 	return 0;
 }
 
@@ -1308,11 +1305,6 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	}
 #endif
 
-	ret = device_create_file(rtd->dev, &dev_attr_pmdown_time);
-	if (ret < 0)
-		dev_warn(rtd->dev, "ASoC: failed to add pmdown_time sysfs: %d\n",
-			ret);
-
 	if (cpu_dai->driver->compress_dai) {
 		/*create compress_device"*/
 		ret = soc_new_compress(rtd, num);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c5136bb1f982..a997bb8cae93 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2127,15 +2127,14 @@ static ssize_t dapm_widget_show(struct device *dev,
 
 static DEVICE_ATTR(dapm_widget, 0444, dapm_widget_show, NULL);
 
-int snd_soc_dapm_sys_add(struct device *dev)
-{
-	return device_create_file(dev, &dev_attr_dapm_widget);
-}
+static struct attribute *soc_dapm_dev_attrs[] = {
+	&dev_attr_dapm_widget.attr,
+	NULL
+};
 
-static void snd_soc_dapm_sys_remove(struct device *dev)
-{
-	device_remove_file(dev, &dev_attr_dapm_widget);
-}
+const struct attribute_group soc_dapm_dev_attr_group = {
+	.attrs = soc_dapm_dev_attrs,
+};
 
 static void dapm_free_path(struct snd_soc_dapm_path *path)
 {
@@ -3903,7 +3902,6 @@ void snd_soc_dapm_auto_nc_pins(struct snd_soc_card *card)
  */
 void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm)
 {
-	snd_soc_dapm_sys_remove(dapm->dev);
 	dapm_debugfs_cleanup(dapm);
 	dapm_free_widgets(dapm);
 	list_del(&dapm->list);
-- 
2.2.2
