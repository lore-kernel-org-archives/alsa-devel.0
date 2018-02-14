From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH v4] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
Date: Wed, 14 Feb 2018 22:48:07 +0800
Message-ID: <1518619687-31442-1-git-send-email-dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, andy.shevchenko@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

There is some duplicate code in soc-core.c, and the kernel provides
DEFINE_SHOW_ATTRIBUTE() helper macro to decrease it in seq_file.h.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v4:
 * resend patch using outlook email, because I can't disable gmail
   word wrap in plain text mode

v3: [addressed comments from Andy]
 * add missing tag

v2: [addressed comments from Andy]
 * modify code change description
 * do not rename m -> s

---
 sound/soc/soc-core.c | 45 ++++++---------------------------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96c44f6..f372f34 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -349,7 +349,7 @@ static void soc_init_codec_debugfs(struct snd_soc_component *component)
 			"ASoC: Failed to create codec register debugfs file\n");
 }
 
-static int codec_list_seq_show(struct seq_file *m, void *v)
+static int codec_list_show(struct seq_file *m, void *v)
 {
 	struct snd_soc_codec *codec;
 
@@ -362,20 +362,9 @@ static int codec_list_seq_show(struct seq_file *m, void *v)
 
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
+static int dai_list_show(struct seq_file *m, void *v)
 {
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
@@ -390,20 +379,9 @@ static int dai_list_seq_show(struct seq_file *m, void *v)
 
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
+static int platform_list_show(struct seq_file *m, void *v)
 {
 	struct snd_soc_platform *platform;
 
@@ -416,18 +394,7 @@ static int platform_list_seq_show(struct seq_file *m, void *v)
 
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
2.7.4
