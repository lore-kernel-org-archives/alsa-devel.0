From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH] ASoC: use seq_file to dump the contents of dai_list, platoform_list and codec_list
Date: Wed, 17 Jan 2018 23:49:58 +0800
Message-ID: <1516204198-14690-1-git-send-email-dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

Now the debugfs files dais/codecs/platforms have a size limit PAGE_SIZE and
the user can not see the whole contents of dai_list/platform_list/codec_list
when they are larger than this limit.

This patch uses seq_file instead to make sure dais/platforms/codecs show the
full contents of dai_list/platform_list/codec_list.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/soc-core.c | 111 +++++++++++++++++----------------------------------
 1 file changed, 37 insertions(+), 74 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0edac8..7b58211 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -349,120 +349,84 @@ static void soc_init_codec_debugfs(struct snd_soc_component *component)
 			"ASoC: Failed to create codec register debugfs file\n");
 }
 
-static ssize_t codec_list_read_file(struct file *file, char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static int codec_list_seq_show(struct seq_file *m, void *v)
 {
-	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	ssize_t len, ret = 0;
 	struct snd_soc_codec *codec;
 
-	if (!buf)
-		return -ENOMEM;
-
 	mutex_lock(&client_mutex);
 
-	list_for_each_entry(codec, &codec_list, list) {
-		len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
-			       codec->component.name);
-		if (len >= 0)
-			ret += len;
-		if (ret > PAGE_SIZE) {
-			ret = PAGE_SIZE;
-			break;
-		}
-	}
+	list_for_each_entry(codec, &codec_list, list)
+		seq_printf(m, "%s\n", codec->component.name);
 
 	mutex_unlock(&client_mutex);
 
-	if (ret >= 0)
-		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
-
-	kfree(buf);
+	return 0;
+}
 
-	return ret;
+static int codec_list_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, codec_list_seq_show, NULL);
 }
 
 static const struct file_operations codec_list_fops = {
-	.read = codec_list_read_file,
-	.llseek = default_llseek,/* read accesses f_pos */
+	.open = codec_list_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
 };
 
-static ssize_t dai_list_read_file(struct file *file, char __user *user_buf,
-				  size_t count, loff_t *ppos)
+static int dai_list_seq_show(struct seq_file *m, void *v)
 {
-	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	ssize_t len, ret = 0;
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 
-	if (!buf)
-		return -ENOMEM;
-
 	mutex_lock(&client_mutex);
 
-	list_for_each_entry(component, &component_list, list) {
-		list_for_each_entry(dai, &component->dai_list, list) {
-			len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
-				dai->name);
-			if (len >= 0)
-				ret += len;
-			if (ret > PAGE_SIZE) {
-				ret = PAGE_SIZE;
-				break;
-			}
-		}
-	}
+	list_for_each_entry(component, &component_list, list)
+		list_for_each_entry(dai, &component->dai_list, list)
+			seq_printf(m, "%s\n", dai->name);
 
 	mutex_unlock(&client_mutex);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
-
-	kfree(buf);
+	return 0;
+}
 
-	return ret;
+static int dai_list_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dai_list_seq_show, NULL);
 }
 
 static const struct file_operations dai_list_fops = {
-	.read = dai_list_read_file,
-	.llseek = default_llseek,/* read accesses f_pos */
+	.open = dai_list_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
 };
 
-static ssize_t platform_list_read_file(struct file *file,
-				       char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static int platform_list_seq_show(struct seq_file *m, void *v)
 {
-	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	ssize_t len, ret = 0;
 	struct snd_soc_platform *platform;
 
-	if (!buf)
-		return -ENOMEM;
-
 	mutex_lock(&client_mutex);
 
-	list_for_each_entry(platform, &platform_list, list) {
-		len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
-			       platform->component.name);
-		if (len >= 0)
-			ret += len;
-		if (ret > PAGE_SIZE) {
-			ret = PAGE_SIZE;
-			break;
-		}
-	}
+	list_for_each_entry(platform, &platform_list, list)
+		seq_printf(m, "%s\n", platform->component.name);
 
 	mutex_unlock(&client_mutex);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
-
-	kfree(buf);
+	return 0;
+}
 
-	return ret;
+static int platform_list_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, platform_list_seq_show, NULL);
 }
 
 static const struct file_operations platform_list_fops = {
-	.read = platform_list_read_file,
-	.llseek = default_llseek,/* read accesses f_pos */
+	.open = platform_list_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
 };
 
 static void soc_init_card_debugfs(struct snd_soc_card *card)
@@ -491,7 +455,6 @@ static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 	debugfs_remove_recursive(card->debugfs_card_root);
 }
 
-
 static void snd_soc_debugfs_init(void)
 {
 	snd_soc_debugfs_root = debugfs_create_dir("asoc", NULL);
-- 
2.7.4
