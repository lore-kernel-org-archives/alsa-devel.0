From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 13/18] ASoC: Add platform registration API
Date: Tue,  9 Dec 2008 14:01:37 +0000
Message-ID: <1228831302-17605-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-12-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9731E103822
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:46 +0100 (CET)
In-Reply-To: <1228831302-17605-12-git-send-email-broonie@opensource.wolfsonmicro.com>
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

ASoC v2 allows platform drivers to instantiate independantly of the
overall ASoC card. This API allows drivers to notify the core when
they are registered.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    5 +++++
 sound/soc/soc-core.c |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4a578b5..ce3661d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -149,6 +149,7 @@ struct snd_soc_ops;
 struct snd_soc_dai_mode;
 struct snd_soc_pcm_runtime;
 struct snd_soc_dai;
+struct snd_soc_platform;
 struct snd_soc_codec;
 struct soc_enum;
 struct snd_soc_ac97_ops;
@@ -158,6 +159,9 @@ typedef int (*hw_read_t)(void *,char* ,int);
 
 extern struct snd_ac97_bus_ops soc_ac97_ops;
 
+int snd_soc_register_platform(struct snd_soc_platform *platform);
+void snd_soc_unregister_platform(struct snd_soc_platform *platform);
+
 /* pcm <-> DAI connect */
 void snd_soc_free_pcms(struct snd_soc_device *socdev);
 int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid);
@@ -296,6 +300,7 @@ struct snd_soc_codec_device {
 /* SoC platform interface */
 struct snd_soc_platform {
 	char *name;
+	struct list_head list;
 
 	int (*probe)(struct platform_device *pdev);
 	int (*remove)(struct platform_device *pdev);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 03460b0..ffae370 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -46,6 +46,7 @@ static struct dentry *debugfs_root;
 static DEFINE_MUTEX(client_mutex);
 static LIST_HEAD(card_list);
 static LIST_HEAD(dai_list);
+static LIST_HEAD(platform_list);
 
 static int snd_soc_register_card(struct snd_soc_card *card);
 static int snd_soc_unregister_card(struct snd_soc_card *card);
@@ -2102,6 +2103,43 @@ void snd_soc_unregister_dais(struct snd_soc_dai *dai, size_t count)
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_dais);
 
+/**
+ * snd_soc_register_platform - Register a platform with the ASoC core
+ *
+ * @param platform platform to register
+ */
+int snd_soc_register_platform(struct snd_soc_platform *platform)
+{
+	if (!platform->name)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&platform->list);
+
+	mutex_lock(&client_mutex);
+	list_add(&platform->list, &platform_list);
+	mutex_unlock(&client_mutex);
+
+	pr_debug("Registered platform '%s'\n", platform->name);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_register_platform);
+
+/**
+ * snd_soc_unregister_platform - Unregister a platform from the ASoC core
+ *
+ * @param platform platform to unregister
+ */
+void snd_soc_unregister_platform(struct snd_soc_platform *platform)
+{
+	mutex_lock(&client_mutex);
+	list_del(&platform->list);
+	mutex_unlock(&client_mutex);
+
+	pr_debug("Unregistered platform '%s'\n", platform->name);
+}
+EXPORT_SYMBOL_GPL(snd_soc_unregister_platform);
+
 static int __devinit snd_soc_init(void)
 {
 #ifdef CONFIG_DEBUG_FS
-- 
1.5.6.5
