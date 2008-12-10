From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/8] ASoC: Add codec registration API
Date: Wed, 10 Dec 2008 20:01:12 +0000
Message-ID: <1228939275-7768-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081210195858.GA4062@rakim.wolfsonmicro.main>
	<1228939275-7768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 89914243CC
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 21:01:17 +0100 (CET)
In-Reply-To: <1228939275-7768-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Another part of the backporting of Liam's ASoC v2 work. Using this is
more complicated than the other registration types since currently the
codec is instantiated during the probe of the ASoC device so we can't
currently readily wait for the codec to register.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    5 +++++
 sound/soc/soc-core.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ce3661d..f86e455 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -161,6 +161,8 @@ extern struct snd_ac97_bus_ops soc_ac97_ops;
 
 int snd_soc_register_platform(struct snd_soc_platform *platform);
 void snd_soc_unregister_platform(struct snd_soc_platform *platform);
+int snd_soc_register_codec(struct snd_soc_codec *codec);
+void snd_soc_unregister_codec(struct snd_soc_codec *codec);
 
 /* pcm <-> DAI connect */
 void snd_soc_free_pcms(struct snd_soc_device *socdev);
@@ -247,6 +249,9 @@ struct snd_soc_codec {
 	char *name;
 	struct module *owner;
 	struct mutex mutex;
+	struct device *dev;
+
+	struct list_head list;
 
 	/* callbacks */
 	int (*set_bias_level)(struct snd_soc_codec *,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4d2db7c..b098c0b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -47,6 +47,7 @@ static DEFINE_MUTEX(client_mutex);
 static LIST_HEAD(card_list);
 static LIST_HEAD(dai_list);
 static LIST_HEAD(platform_list);
+static LIST_HEAD(codec_list);
 
 static int snd_soc_register_card(struct snd_soc_card *card);
 static int snd_soc_unregister_card(struct snd_soc_card *card);
@@ -2224,6 +2225,48 @@ void snd_soc_unregister_platform(struct snd_soc_platform *platform)
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_platform);
 
+/**
+ * snd_soc_register_codec - Register a codec with the ASoC core
+ *
+ * @param codec codec to register
+ */
+int snd_soc_register_codec(struct snd_soc_codec *codec)
+{
+	if (!codec->name)
+		return -EINVAL;
+
+	/* The device should become mandatory over time */
+	if (!codec->dev)
+		printk(KERN_WARNING "No device for codec %s\n", codec->name);
+
+	INIT_LIST_HEAD(&codec->list);
+
+	mutex_lock(&client_mutex);
+	list_add(&codec->list, &codec_list);
+	snd_soc_instantiate_cards();
+	mutex_unlock(&client_mutex);
+
+	pr_debug("Registered codec '%s'\n", codec->name);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_register_codec);
+
+/**
+ * snd_soc_unregister_codec - Unregister a codec from the ASoC core
+ *
+ * @param codec codec to unregister
+ */
+void snd_soc_unregister_codec(struct snd_soc_codec *codec)
+{
+	mutex_lock(&client_mutex);
+	list_del(&codec->list);
+	mutex_unlock(&client_mutex);
+
+	pr_debug("Unregistered codec '%s'\n", codec->name);
+}
+EXPORT_SYMBOL_GPL(snd_soc_unregister_codec);
+
 static int __init snd_soc_init(void)
 {
 #ifdef CONFIG_DEBUG_FS
-- 
1.5.6.5
