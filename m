From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] ASoC: Move DAPM debugfs directory creation
	to snd_soc_dapm_debugfs_init
Date: Sat, 30 Apr 2011 19:45:48 +0200
Message-ID: <1304185550-12003-2-git-send-email-lars@metafoo.de>
References: <1304185550-12003-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-170.synserver.de (smtp-out-171.synserver.de
	[212.40.185.171]) by alsa0.perex.cz (Postfix) with SMTP id 147B4244EE
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Apr 2011 19:46:09 +0200 (CEST)
In-Reply-To: <1304185550-12003-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Move the creation of the DAPM debugfs directory to snd_soc_dapm_debugfs_init
instead of having the same duplicated code in both codec and card DAPM setup.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |    3 ++-
 sound/soc/soc-core.c     |   16 ++--------------
 sound/soc/soc-dapm.c     |   13 ++++++++++---
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d5f1b9a..f8a7c9a 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -356,7 +356,8 @@ void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
-void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm);
+void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
+				struct dentry *parent);
 
 /* dapm audio pin control and status */
 int snd_soc_dapm_enable_pin(struct snd_soc_dapm_context *dapm,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6a3cb53..983ec64 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -302,13 +302,7 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 		printk(KERN_WARNING
 		       "ASoC: Failed to create codec register debugfs file\n");
 
-	codec->dapm.debugfs_dapm = debugfs_create_dir("dapm",
-						 codec->debugfs_codec_root);
-	if (!codec->dapm.debugfs_dapm)
-		printk(KERN_WARNING
-		       "Failed to create DAPM debugfs directory\n");
-
-	snd_soc_dapm_debugfs_init(&codec->dapm);
+	snd_soc_dapm_debugfs_init(&codec->dapm, codec->debugfs_codec_root);
 }
 
 static void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
@@ -1926,13 +1920,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 					card->num_dapm_routes);
 
 #ifdef CONFIG_DEBUG_FS
-	card->dapm.debugfs_dapm = debugfs_create_dir("dapm",
-						     card->debugfs_card_root);
-	if (!card->dapm.debugfs_dapm)
-		printk(KERN_WARNING
-		       "Failed to create card DAPM debugfs directory\n");
-
-	snd_soc_dapm_debugfs_init(&card->dapm);
+	snd_soc_dapm_debugfs_init(&card->dapm, card->debugfs_card_root);
 #endif
 
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 378f08a..ffed456 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1254,13 +1254,19 @@ static const struct file_operations dapm_bias_fops = {
 	.llseek = default_llseek,
 };
 
-void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
+void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
+	struct dentry *parent)
 {
 	struct snd_soc_dapm_widget *w;
 	struct dentry *d;
 
-	if (!dapm->debugfs_dapm)
+	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);
+
+	if (!dapm->debugfs_dapm) {
+		printk(KERN_WARNING
+		       "Failed to create DAPM debugfs directory\n");
 		return;
+	}
 
 	d = debugfs_create_file("bias_level", 0444,
 				dapm->debugfs_dapm, dapm,
@@ -1283,7 +1289,8 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 	}
 }
 #else
-void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
+void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
+	struct dentry *parent)
 {
 }
 #endif
-- 
1.7.2.5
