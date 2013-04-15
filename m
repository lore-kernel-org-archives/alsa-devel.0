From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/17] ASoC: Add snd_soc_{add, remove}_platform
Date: Mon, 15 Apr 2013 19:19:49 +0200
Message-ID: <1366046404-8759-3-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 68368265213
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:08 +0200 (CEST)
In-Reply-To: <1366046404-8759-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

snd_soc_{add,remove}_platform are similar to snd_soc_register_platform and
snd_soc_unregister_platform with the difference that they won't allocate and
free the snd_soc_platform structure.

Also add snd_soc_lookup_platform which looks up a platform by the device it has
been registered for.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  4 +++
 sound/soc/soc-core.c | 85 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9eb0e4d..85c1522 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -375,6 +375,10 @@ int snd_soc_poweroff(struct device *dev);
 int snd_soc_register_platform(struct device *dev,
 		const struct snd_soc_platform_driver *platform_drv);
 void snd_soc_unregister_platform(struct device *dev);
+int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
+		const struct snd_soc_platform_driver *platform_drv);
+void snd_soc_remove_platform(struct snd_soc_platform *platform);
+struct snd_soc_platform *snd_soc_lookup_platform(struct device *dev);
 int snd_soc_register_codec(struct device *dev,
 		const struct snd_soc_codec_driver *codec_drv,
 		struct snd_soc_dai_driver *dai_drv, int num_dai);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7bf21a1..d56bbea 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3900,21 +3900,14 @@ static void snd_soc_unregister_dais(struct device *dev, size_t count)
 }
 
 /**
- * snd_soc_register_platform - Register a platform with the ASoC core
- *
- * @platform: platform to register
+ * snd_soc_add_platform - Add a platform to the ASoC core
+ * @dev: The parent device for the platform
+ * @platform: The platform to add
+ * @platform_driver: The driver for the platform
  */
-int snd_soc_register_platform(struct device *dev,
+int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 		const struct snd_soc_platform_driver *platform_drv)
 {
-	struct snd_soc_platform *platform;
-
-	dev_dbg(dev, "ASoC: platform register %s\n", dev_name(dev));
-
-	platform = kzalloc(sizeof(struct snd_soc_platform), GFP_KERNEL);
-	if (platform == NULL)
-		return -ENOMEM;
-
 	/* create platform component name */
 	platform->name = fmt_single_name(dev, &platform->id);
 	if (platform->name == NULL) {
@@ -3937,30 +3930,76 @@ int snd_soc_register_platform(struct device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_register_platform);
+EXPORT_SYMBOL_GPL(snd_soc_add_platform);
 
 /**
- * snd_soc_unregister_platform - Unregister a platform from the ASoC core
+ * snd_soc_register_platform - Register a platform with the ASoC core
  *
- * @platform: platform to unregister
+ * @platform: platform to register
  */
-void snd_soc_unregister_platform(struct device *dev)
+int snd_soc_register_platform(struct device *dev,
+		const struct snd_soc_platform_driver *platform_drv)
 {
 	struct snd_soc_platform *platform;
+	int ret;
 
-	list_for_each_entry(platform, &platform_list, list) {
-		if (dev == platform->dev)
-			goto found;
-	}
-	return;
+	dev_dbg(dev, "ASoC: platform register %s\n", dev_name(dev));
 
-found:
+	platform = kzalloc(sizeof(struct snd_soc_platform), GFP_KERNEL);
+	if (platform == NULL)
+		return -ENOMEM;
+
+	ret = snd_soc_add_platform(dev, platform, platform_drv);
+	if (ret)
+		kfree(platform);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_register_platform);
+
+/**
+ * snd_soc_remove_platform - Remove a platform from the ASoC core
+ * @platform: the platform to remove
+ */
+void snd_soc_remove_platform(struct snd_soc_platform *platform)
+{
 	mutex_lock(&client_mutex);
 	list_del(&platform->list);
 	mutex_unlock(&client_mutex);
 
-	dev_dbg(dev, "ASoC: Unregistered platform '%s'\n", platform->name);
+	dev_dbg(platform->dev, "ASoC: Unregistered platform '%s'\n",
+		platform->name);
 	kfree(platform->name);
+}
+EXPORT_SYMBOL_GPL(snd_soc_remove_platform);
+
+struct snd_soc_platform *snd_soc_lookup_platform(struct device *dev)
+{
+	struct snd_soc_platform *platform;
+
+	list_for_each_entry(platform, &platform_list, list) {
+		if (dev == platform->dev)
+			return platform;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_lookup_platform);
+
+/**
+ * snd_soc_unregister_platform - Unregister a platform from the ASoC core
+ *
+ * @platform: platform to unregister
+ */
+void snd_soc_unregister_platform(struct device *dev)
+{
+	struct snd_soc_platform *platform;
+
+	platform = snd_soc_lookup_platform(dev);
+	if (!platform)
+		return;
+
+	snd_soc_remove_platform(platform);
 	kfree(platform);
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_platform);
-- 
1.8.0
