From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use seq_file to dump the contents of dai_list,platform_list and codec_list" to the asoc tree
Date: Thu, 18 Jan 2018 11:54:53 +0000
Message-ID: <E1ec8mT-0005Ef-5q@debutante>
References: <1516204198-14690-1-git-send-email-dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516204198-14690-1-git-send-email-dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: use seq_file to dump the contents of dai_list,platform_list and codec_list

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 700c17ca8968f473631594e8a7c2cc880ba2c891 Mon Sep 17 00:00:00 2001
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 18 Jan 2018 13:31:26 +0800
Subject: [PATCH] ASoC: use seq_file to dump the contents of
 dai_list,platform_list and codec_list

Now the debugfs files dais/platforms/codecs have a size limit PAGE_SIZE and
the user can not see the whole contents of dai_list/platform_list/codec_list
when they are larger than this limit.

This patch uses seq_file instead to make sure dais/platforms/codecs show the
full contents of dai_list/platform_list/codec_list.

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 111 +++++++++++++++++----------------------------------
 1 file changed, 37 insertions(+), 74 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0edac80df34..7b582112e3fc 100644
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
2.15.1
