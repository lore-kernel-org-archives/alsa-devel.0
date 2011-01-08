From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/7] ASoC: Export debugfs root dentry
Date: Fri,  7 Jan 2011 22:36:11 -0700
Message-ID: <1294464977-25814-2-git-send-email-swarren@nvidia.com>
References: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D146810387C
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 06:36:36 +0100 (CET)
In-Reply-To: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

A couple Tegra ASoC drivers will create debugfs entries. Mark requested
these by under debugfs/asoc/ not just debugfs/. To enable this, export
the dentry representing debugfs/asoc/.

Also, rename debugfs_root -> asoc_debugfs_root now it's exported to
prevent potential symbol name clashes.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/sound/soc.h  |    4 ++++
 sound/soc/soc-core.c |   19 ++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 74921f2..96aadbb 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -756,4 +756,8 @@ static inline void *snd_soc_pcm_get_drvdata(struct snd_soc_pcm_runtime *rtd)
 
 #include <sound/soc-dai.h>
 
+#ifdef CONFIG_DEBUG_FS
+extern struct dentry *asoc_debugfs_root;
+#endif
+
 #endif
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bac7291..731e2cc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -48,7 +48,8 @@ static DEFINE_MUTEX(pcm_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(soc_pm_waitq);
 
 #ifdef CONFIG_DEBUG_FS
-static struct dentry *debugfs_root;
+struct dentry *asoc_debugfs_root;
+EXPORT_SYMBOL_GPL(asoc_debugfs_root);
 #endif
 
 static DEFINE_MUTEX(client_mutex);
@@ -356,7 +357,7 @@ static const struct file_operations platform_list_fops = {
 static void soc_init_card_debugfs(struct snd_soc_card *card)
 {
 	card->debugfs_card_root = debugfs_create_dir(card->name,
-						     debugfs_root);
+						     asoc_debugfs_root);
 	if (!card->debugfs_card_root) {
 		dev_warn(card->dev,
 			 "ASoC: Failed to create codec debugfs directory\n");
@@ -3577,22 +3578,22 @@ EXPORT_SYMBOL_GPL(snd_soc_unregister_codec);
 static int __init snd_soc_init(void)
 {
 #ifdef CONFIG_DEBUG_FS
-	debugfs_root = debugfs_create_dir("asoc", NULL);
-	if (IS_ERR(debugfs_root) || !debugfs_root) {
+	asoc_debugfs_root = debugfs_create_dir("asoc", NULL);
+	if (IS_ERR(asoc_debugfs_root) || !asoc_debugfs_root) {
 		printk(KERN_WARNING
 		       "ASoC: Failed to create debugfs directory\n");
-		debugfs_root = NULL;
+		asoc_debugfs_root = NULL;
 	}
 
-	if (!debugfs_create_file("codecs", 0444, debugfs_root, NULL,
+	if (!debugfs_create_file("codecs", 0444, asoc_debugfs_root, NULL,
 				 &codec_list_fops))
 		pr_warn("ASoC: Failed to create CODEC list debugfs file\n");
 
-	if (!debugfs_create_file("dais", 0444, debugfs_root, NULL,
+	if (!debugfs_create_file("dais", 0444, asoc_debugfs_root, NULL,
 				 &dai_list_fops))
 		pr_warn("ASoC: Failed to create DAI list debugfs file\n");
 
-	if (!debugfs_create_file("platforms", 0444, debugfs_root, NULL,
+	if (!debugfs_create_file("platforms", 0444, asoc_debugfs_root, NULL,
 				 &platform_list_fops))
 		pr_warn("ASoC: Failed to create platform list debugfs file\n");
 #endif
@@ -3604,7 +3605,7 @@ module_init(snd_soc_init);
 static void __exit snd_soc_exit(void)
 {
 #ifdef CONFIG_DEBUG_FS
-	debugfs_remove_recursive(debugfs_root);
+	debugfs_remove_recursive(asoc_debugfs_root);
 #endif
 	platform_driver_unregister(&soc_driver);
 }
-- 
1.7.0.4
