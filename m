From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
Date: Fri,  9 Feb 2018 14:52:05 +0800
Message-ID: <20180209065206.15543-1-dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, andy.shevchenko@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

There is some duplicate code in soc-core.c,and the kernel provides
DEFINE_SHOW_ATTRIBUTE() helper macro to decrease it in seq_file.h.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/soc-core.c | 51 +++++++++------------------------------------------
 1 file changed, 9 insertions(+), 42 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96c44f6576c9..cb52d1e8e0b9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -349,33 +349,22 @@ static void soc_init_codec_debugfs(struct snd_soc_component *component)
 			"ASoC: Failed to create codec register debugfs file\n");
 }
 
-static int codec_list_seq_show(struct seq_file *m, void *v)
+static int codec_list_show(struct seq_file *s, void *v)
 {
 	struct snd_soc_codec *codec;
 
 	mutex_lock(&client_mutex);
 
 	list_for_each_entry(codec, &codec_list, list)
-		seq_printf(m, "%s\n", codec->component.name);
+		seq_printf(s, "%s\n", codec->component.name);
 
 	mutex_unlock(&client_mutex);
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(codec_list);
 
-static int codec_list_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, codec_list_seq_show, NULL);
-}
-
-static const struct file_operations codec_list_fops = {
-	.open = codec_list_seq_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int dai_list_seq_show(struct seq_file *m, void *v)
+static int dai_list_show(struct seq_file *s, void *v)
 {
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
@@ -384,50 +373,28 @@ static int dai_list_seq_show(struct seq_file *m, void *v)
 
 	list_for_each_entry(component, &component_list, list)
 		list_for_each_entry(dai, &component->dai_list, list)
-			seq_printf(m, "%s\n", dai->name);
+			seq_printf(s, "%s\n", dai->name);
 
 	mutex_unlock(&client_mutex);
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(dai_list);
 
-static int dai_list_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dai_list_seq_show, NULL);
-}
-
-static const struct file_operations dai_list_fops = {
-	.open = dai_list_seq_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int platform_list_seq_show(struct seq_file *m, void *v)
+static int platform_list_show(struct seq_file *s, void *v)
 {
 	struct snd_soc_platform *platform;
 
 	mutex_lock(&client_mutex);
 
 	list_for_each_entry(platform, &platform_list, list)
-		seq_printf(m, "%s\n", platform->component.name);
+		seq_printf(s, "%s\n", platform->component.name);
 
 	mutex_unlock(&client_mutex);
 
 	return 0;
 }
-
-static int platform_list_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, platform_list_seq_show, NULL);
-}
-
-static const struct file_operations platform_list_fops = {
-	.open = platform_list_seq_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(platform_list);
 
 static void soc_init_card_debugfs(struct snd_soc_card *card)
 {
-- 
2.16.1
