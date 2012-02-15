From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - add platform DAPM debugfs support
Date: Wed, 15 Feb 2012 15:15:36 +0000
Message-ID: <1329318937-14488-3-git-send-email-lrg@ti.com>
References: <1329318937-14488-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 379A3103E0A
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 16:15:51 +0100 (CET)
Received: by mail-we0-f181.google.com with SMTP id p13so834063wer.40
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 07:15:50 -0800 (PST)
In-Reply-To: <1329318937-14488-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Sebastien Guiriec <s-guiriec@ti.com>

Allow platform widgets to be visible in debugfs like codec widgets.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc.h  |    5 +++++
 sound/soc/soc-core.c |   33 ++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4f67e01..8fa4dca 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -706,6 +706,11 @@ struct snd_soc_platform {
 	struct list_head card_list;
 
 	struct snd_soc_dapm_context dapm;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_platform_root;
+	struct dentry *debugfs_dapm;
+#endif
 };
 
 struct snd_soc_dai_link {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8bd9995..e1d6bfc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -302,6 +302,27 @@ static void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
 	debugfs_remove_recursive(codec->debugfs_codec_root);
 }
 
+static void soc_init_platform_debugfs(struct snd_soc_platform *platform)
+{
+	struct dentry *debugfs_card_root = platform->card->debugfs_card_root;
+
+	platform->debugfs_platform_root = debugfs_create_dir(platform->name,
+						       debugfs_card_root);
+	if (!platform->debugfs_platform_root) {
+		dev_warn(platform->dev,
+			"Failed to create platform debugfs directory\n");
+		return;
+	}
+
+	snd_soc_dapm_debugfs_init(&platform->dapm,
+		platform->debugfs_platform_root);
+}
+
+static void soc_cleanup_platform_debugfs(struct snd_soc_platform *platform)
+{
+	debugfs_remove_recursive(platform->debugfs_platform_root);
+}
+
 static ssize_t codec_list_read_file(struct file *file, char __user *user_buf,
 				    size_t count, loff_t *ppos)
 {
@@ -435,6 +456,14 @@ static inline void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
 {
 }
 
+static inline void soc_init_platform_debugfs(struct snd_soc_platform *platform)
+{
+}
+
+static inline void soc_cleanup_platform_debugfs(struct snd_soc_platform *platform)
+{
+}
+
 static inline void soc_init_card_debugfs(struct snd_soc_card *card)
 {
 }
@@ -918,10 +947,10 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 			if (err < 0)
 				printk(KERN_ERR "asoc: failed to remove %s\n", platform->name);
 		}
-
 		/* Make sure all DAPM widgets are freed */
 		snd_soc_dapm_free(&platform->dapm);
 
+		soc_cleanup_platform_debugfs(platform);
 		platform->probed = 0;
 		list_del(&platform->card_list);
 		module_put(platform->dev->driver->owner);
@@ -1039,6 +1068,8 @@ static int soc_probe_platform(struct snd_soc_card *card,
 	if (!try_module_get(platform->dev->driver->owner))
 		return -ENODEV;
 
+	soc_init_platform_debugfs(platform);
+
 	if (driver->dapm_widgets)
 		snd_soc_dapm_new_controls(&platform->dapm,
 			driver->dapm_widgets, driver->num_dapm_widgets);
-- 
1.7.5.4
