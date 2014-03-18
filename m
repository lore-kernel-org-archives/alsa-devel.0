From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/13] ASoC: Let snd_soc_platform subclass
	snd_soc_component
Date: Tue, 18 Mar 2014 09:02:12 +0100
Message-ID: <1395129736-11938-10-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id BC445261B14
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:47 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There is an increasing amount of code that is very similar between platforms,
CODECS and other components. Making platforms a component will allow us to
share this code. For now the patch just adds component and component_driver
fields to the platform and platform_driver structs and registers the platform as
a component. Followup patches will be used to consolidate code between the
different types of components.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 16 ++++++++++++++++
 sound/soc/soc-core.c | 14 ++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f8a79c1..94a2dc2 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -778,6 +778,7 @@ struct snd_soc_platform_driver {
 	int (*remove)(struct snd_soc_platform *);
 	int (*suspend)(struct snd_soc_dai *dai);
 	int (*resume)(struct snd_soc_dai *dai);
+	struct snd_soc_component_driver component_driver;
 
 	/* pcm creation and destruction */
 	int (*pcm_new)(struct snd_soc_pcm_runtime *);
@@ -831,6 +832,8 @@ struct snd_soc_platform {
 	struct list_head list;
 	struct list_head card_list;
 
+	struct snd_soc_component component;
+
 	struct snd_soc_dapm_context dapm;
 
 #ifdef CONFIG_DEBUG_FS
@@ -1107,6 +1110,19 @@ static inline struct snd_soc_codec *snd_soc_component_to_codec(
 	return container_of(component, struct snd_soc_codec, component);
 }
 
+/**
+ * snd_soc_component_to_platform() - Casts a component to the platform it is embedded in
+ * @component: The component to cast to a platform
+ *
+ * This function must only be used on components that are known to be platforms.
+ * Otherwise the behavior is undefined.
+ */
+static inline struct snd_soc_platform *snd_soc_component_to_platform(
+	struct snd_soc_component *component)
+{
+	return container_of(component, struct snd_soc_platform, component);
+}
+
 /* codec IO */
 unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
 unsigned int snd_soc_write(struct snd_soc_codec *codec,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1ee3dd6..3a07e6f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3927,6 +3927,8 @@ EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
 int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 		const struct snd_soc_platform_driver *platform_drv)
 {
+	int ret;
+
 	/* create platform component name */
 	platform->name = fmt_single_name(dev, &platform->id);
 	if (platform->name == NULL)
@@ -3939,6 +3941,16 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 	platform->dapm.stream_event = platform_drv->stream_event;
 	mutex_init(&platform->mutex);
 
+	/* register component */
+	ret = __snd_soc_register_component(dev, &platform->component,
+					   &platform_drv->component_driver,
+					   NULL, NULL, 0, false);
+	if (ret < 0) {
+		dev_err(platform->component.dev,
+			"ASoC: Failed to register component: %d\n", ret);
+		return ret;
+	}
+
 	mutex_lock(&client_mutex);
 	list_add(&platform->list, &platform_list);
 	mutex_unlock(&client_mutex);
@@ -3980,6 +3992,8 @@ EXPORT_SYMBOL_GPL(snd_soc_register_platform);
  */
 void snd_soc_remove_platform(struct snd_soc_platform *platform)
 {
+	snd_soc_unregister_component(platform->dev);
+
 	mutex_lock(&client_mutex);
 	list_del(&platform->list);
 	mutex_unlock(&client_mutex);
-- 
1.8.0
