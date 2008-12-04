From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Push debugfs files out of the
	snd_soc_device structure
Date: Thu,  4 Dec 2008 11:26:43 +0000
Message-ID: <1228390006-30338-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081204112542.GA30250@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 753422414F
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2008 12:26:47 +0100 (CET)
In-Reply-To: <20081204112542.GA30250@rakim.wolfsonmicro.main>
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

This is in preparation for the removal of struct snd_soc_device.

The pop time configuration should really be a property of the card not
the codec but since DAPM currently uses the codec rather than the card
using the codec is fine for now.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    8 +++--
 sound/soc/soc-core.c |   73 ++++++++++++++++++++++++++++----------------------
 2 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ad8141a..3ee608d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -279,6 +279,11 @@ struct snd_soc_codec {
 	/* codec DAI's */
 	struct snd_soc_dai *dai;
 	unsigned int num_dai;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_reg;
+	struct dentry *debugfs_pop_time;
+#endif
 };
 
 /* codec device */
@@ -364,9 +369,6 @@ struct snd_soc_device {
 	struct snd_soc_codec *codec;
 	struct snd_soc_codec_device *codec_dev;
 	void *codec_data;
-#ifdef CONFIG_DEBUG_FS
-	struct dentry	*debugfs_root;
-#endif
 };
 
 /* runtime channel data */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fe89260..3411439 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -39,6 +39,10 @@ static DEFINE_MUTEX(pcm_mutex);
 static DEFINE_MUTEX(io_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(soc_pm_waitq);
 
+#ifdef CONFIG_DEBUG_FS
+static struct dentry *debugfs_root;
+#endif
+
 /*
  * This is a timeout to do a DAPM powerdown after a stream is closed().
  * It can be used to eliminate pops between different playback streams, e.g.
@@ -1002,7 +1006,9 @@ static ssize_t codec_reg_read_file(struct file *file, char __user *user_buf,
 			       size_t count, loff_t *ppos)
 {
 	ssize_t ret;
-	struct snd_soc_device *devdata = file->private_data;
+	struct snd_soc_codec *codec = file->private_data;
+	struct device *card_dev = codec->card->dev;
+	struct snd_soc_device *devdata = card_dev->driver_data;
 	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -1021,8 +1027,7 @@ static ssize_t codec_reg_write_file(struct file *file,
 	char *start = buf;
 	unsigned long reg, value;
 	int step = 1;
-	struct snd_soc_device *devdata = file->private_data;
-	struct snd_soc_codec *codec = devdata->codec;
+	struct snd_soc_codec *codec = file->private_data;
 
 	buf_size = min(count, (sizeof(buf)-1));
 	if (copy_from_user(buf, user_buf, buf_size))
@@ -1051,44 +1056,36 @@ static const struct file_operations codec_reg_fops = {
 	.write = codec_reg_write_file,
 };
 
-static void soc_init_debugfs(struct snd_soc_device *socdev)
+static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 {
-	struct dentry *root, *file;
-	struct snd_soc_codec *codec = socdev->codec;
-	root = debugfs_create_dir(dev_name(socdev->dev), NULL);
-	if (IS_ERR(root) || !root)
-		goto exit1;
-
-	file = debugfs_create_file("codec_reg", 0644,
-			root, socdev, &codec_reg_fops);
-	if (!file)
-		goto exit2;
-
-	file = debugfs_create_u32("dapm_pop_time", 0744,
-			root, &codec->pop_time);
-	if (!file)
-		goto exit2;
-	socdev->debugfs_root = root;
-	return;
-exit2:
-	debugfs_remove_recursive(root);
-exit1:
-	dev_err(socdev->dev, "debugfs is not available\n");
+	codec->debugfs_reg = debugfs_create_file("codec_reg", 0644,
+						 debugfs_root, codec,
+						 &codec_reg_fops);
+	if (!codec->debugfs_reg)
+		printk(KERN_WARNING
+		       "ASoC: Failed to create codec register debugfs file\n");
+
+	codec->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0744,
+						     debugfs_root,
+						     &codec->pop_time);
+	if (!codec->debugfs_pop_time)
+		printk(KERN_WARNING
+		       "Failed to create pop time debugfs file\n");
 }
 
-static void soc_cleanup_debugfs(struct snd_soc_device *socdev)
+static void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
 {
-	debugfs_remove_recursive(socdev->debugfs_root);
-	socdev->debugfs_root = NULL;
+	debugfs_remove(codec->debugfs_pop_time);
+	debugfs_remove(codec->debugfs_reg);
 }
 
 #else
 
-static inline void soc_init_debugfs(struct snd_soc_device *socdev)
+static inline void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 {
 }
 
-static inline void soc_cleanup_debugfs(struct snd_soc_device *socdev)
+static inline void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
 {
 }
 #endif
@@ -1305,7 +1302,7 @@ int snd_soc_init_card(struct snd_soc_device *socdev)
 	if (err < 0)
 		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
 
-	soc_init_debugfs(socdev);
+	soc_init_codec_debugfs(socdev->codec);
 	mutex_unlock(&codec->mutex);
 
 out:
@@ -1329,7 +1326,7 @@ void snd_soc_free_pcms(struct snd_soc_device *socdev)
 #endif
 
 	mutex_lock(&codec->mutex);
-	soc_cleanup_debugfs(socdev);
+	soc_cleanup_codec_debugfs(socdev->codec);
 #ifdef CONFIG_SND_SOC_AC97_BUS
 	for (i = 0; i < codec->num_dai; i++) {
 		codec_dai = &codec->dai[i];
@@ -1962,11 +1959,23 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 
 static int __devinit snd_soc_init(void)
 {
+#ifdef CONFIG_DEBUG_FS
+	debugfs_root = debugfs_create_dir("asoc", NULL);
+	if (IS_ERR(debugfs_root) || !debugfs_root) {
+		printk(KERN_WARNING
+		       "ASoC: Failed to create debugfs directory\n");
+		debugfs_root = NULL;
+	}
+#endif
+
 	return platform_driver_register(&soc_driver);
 }
 
 static void __exit snd_soc_exit(void)
 {
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(debugfs_root);
+#endif
 	platform_driver_unregister(&soc_driver);
 }
 
-- 
1.5.6.5
