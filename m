From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1 - try2] ASoC: add support for multiple
	cards/codecs in debugfs
Date: Thu,  1 Oct 2009 10:32:47 +0300
Message-ID: <1254382367-27948-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1254382367-27948-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AE5C1038EE
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 09:32:56 +0200 (CEST)
In-Reply-To: <1254382367-27948-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

In order to support multiple codecs on the same system in the debugfs
the directory hierarchy need to be changed by adding directory per codec
under the asoc direcorty:

debugfs/asoc/{dev_name(socdev->dev)}-{codec->name}/codec_reg
                                                  /dapm_pop_time
                                                  /dapm/{widgets}

With the original implementation only the debugfs files are only
created for the first codec, other codecs loaded later would fail to
create the debugfs files (since they are already exist).
Furthermore in this situation any of the codecs has been removed, would
cause the debugfs entries to disappear, regardless if the codec, which
created them are still loaded (the one which loaded first).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |   28 ++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 475cb7e..0b1f917 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -413,6 +413,7 @@ struct snd_soc_codec {
 	unsigned int num_dai;

 #ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_codec_root;
 	struct dentry *debugfs_reg;
 	struct dentry *debugfs_pop_time;
 	struct dentry *debugfs_dapm;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f5b356f..ea0b8be 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -126,7 +126,7 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)

 	if (codec_dai->symmetric_rates || cpu_dai->symmetric_rates ||
 	    machine->symmetric_rates) {
-		dev_dbg(card->dev, "Symmetry forces %dHz rate\n",
+		dev_dbg(card->dev, "Symmetry forces %dHz rate\n",
 			machine->rate);

 		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
@@ -1254,21 +1254,35 @@ static const struct file_operations codec_reg_fops = {

 static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 {
+	char codec_root[128];
+
+	snprintf(codec_root, sizeof(codec_root),
+		 "%s-%s", dev_name(codec->socdev->dev), codec->name);
+
+	codec->debugfs_codec_root = debugfs_create_dir(codec_root,
+						       debugfs_root);
+	if (!codec->debugfs_codec_root) {
+		printk(KERN_WARNING
+		       "ASoC: Failed to create codec debugfs directory\n");
+		return;
+	}
+
 	codec->debugfs_reg = debugfs_create_file("codec_reg", 0644,
-						 debugfs_root, codec,
-						 &codec_reg_fops);
+						 codec->debugfs_codec_root,
+						 codec, &codec_reg_fops);
 	if (!codec->debugfs_reg)
 		printk(KERN_WARNING
 		       "ASoC: Failed to create codec register debugfs file\n");

 	codec->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0744,
-						     debugfs_root,
+						     codec->debugfs_codec_root,
 						     &codec->pop_time);
 	if (!codec->debugfs_pop_time)
 		printk(KERN_WARNING
 		       "Failed to create pop time debugfs file\n");

-	codec->debugfs_dapm = debugfs_create_dir("dapm", debugfs_root);
+	codec->debugfs_dapm = debugfs_create_dir("dapm",
+						 codec->debugfs_codec_root);
 	if (!codec->debugfs_dapm)
 		printk(KERN_WARNING
 		       "Failed to create DAPM debugfs directory\n");
@@ -1278,9 +1292,7 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)

 static void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
 {
-	debugfs_remove_recursive(codec->debugfs_dapm);
-	debugfs_remove(codec->debugfs_pop_time);
-	debugfs_remove(codec->debugfs_reg);
+	debugfs_remove_recursive(codec->debugfs_codec_root);
 }

 #else
--
1.6.5.rc1
