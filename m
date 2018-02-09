From: Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH v3] ASoC: use DEFINE_SHOW_ATTRIBUTE() to
	decrease code duplication
Date: Fri, 9 Feb 2018 23:10:55 +0800
Message-ID: <CAErzpmuxmrJszRz5_SZXPMkdU2UWNHChrnKjnHuCWZYrs4hgTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 10880266E55
 for <alsa-devel@alsa-project.org>; Fri,  9 Feb 2018 16:11:17 +0100 (CET)
Received: by mail-qk0-f196.google.com with SMTP id w128so10351887qkb.5
 for <alsa-devel@alsa-project.org>; Fri, 09 Feb 2018 07:11:17 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

There is some duplicate code in soc-core.c, and the kernel provides
DEFINE_SHOW_ATTRIBUTE() helper macro to decrease it in seq_file.h.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v3: [addressed comments from Andy]
 * add missing tag

v2: [addressed comments from Andy]
 * modify code change description
 * do not rename m -> s
---
 sound/soc/soc-core.c | 45 ++++++---------------------------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96c44f6576c9..f372f34d7702 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -349,7 +349,7 @@ static void soc_init_codec_debugfs(struct
snd_soc_component *component)
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
-    return single_open(file, codec_list_seq_show, NULL);
-}
-
-static const struct file_operations codec_list_fops = {
-    .open = codec_list_seq_open,
-    .read = seq_read,
-    .llseek = seq_lseek,
-    .release = single_release,
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
-    return single_open(file, dai_list_seq_show, NULL);
-}
-
-static const struct file_operations dai_list_fops = {
-    .open = dai_list_seq_open,
-    .read = seq_read,
-    .llseek = seq_lseek,
-    .release = single_release,
-};
-
-static int platform_list_seq_show(struct seq_file *m, void *v)
+static int platform_list_show(struct seq_file *m, void *v)
 {
     struct snd_soc_platform *platform;

@@ -416,18 +394,7 @@ static int platform_list_seq_show(struct seq_file
*m, void *v)

     return 0;
 }
-
-static int platform_list_seq_open(struct inode *inode, struct file *file)
-{
-    return single_open(file, platform_list_seq_show, NULL);
-}
-
-static const struct file_operations platform_list_fops = {
-    .open = platform_list_seq_open,
-    .read = seq_read,
-    .llseek = seq_lseek,
-    .release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(platform_list);

 static void soc_init_card_debugfs(struct snd_soc_card *card)
 {
-- 
2.16.1
