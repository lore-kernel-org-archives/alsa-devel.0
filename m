From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: Don't try to register debugfs
	entries if the parent does not exist
Date: Thu,  9 Apr 2015 10:52:38 +0200
Message-ID: <1428569558-15883-3-git-send-email-lars@metafoo.de>
References: <1428569558-15883-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-026.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id E2FE8265919
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 10:52:56 +0200 (CEST)
In-Reply-To: <1428569558-15883-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <festevam@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

If the registration of a debugfs directory fails this is treated as a
non-fatal error in ASoC and operation continues as normal. This means we
need to be careful and check if the parent debugfs directory exists if we
try to register a debugfs file or sub-directory. Otherwise we might end up
passing NULL for the parent and the file or directory will be registered in
the top-level debugfs directory.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 66 +++++++++++++++++++++++++++++++++++-----------------
 sound/soc/soc-dapm.c |  3 +++
 sound/soc/soc-pcm.c  |  8 +++++--
 3 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e97b395..32ebe5b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -292,6 +292,9 @@ static const struct file_operations codec_reg_fops = {
 
 static void soc_init_component_debugfs(struct snd_soc_component *component)
 {
+	if (!component->card->debugfs_card_root)
+		return;
+
 	if (component->debugfs_prefix) {
 		char *name;
 
@@ -455,6 +458,9 @@ static const struct file_operations platform_list_fops = {
 
 static void soc_init_card_debugfs(struct snd_soc_card *card)
 {
+	if (!snd_soc_debugfs_root)
+		return;
+
 	card->debugfs_card_root = debugfs_create_dir(card->name,
 						     snd_soc_debugfs_root);
 	if (!card->debugfs_card_root) {
@@ -476,6 +482,34 @@ static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 	debugfs_remove_recursive(card->debugfs_card_root);
 }
 
+
+static void snd_soc_debugfs_init(void)
+{
+	snd_soc_debugfs_root = debugfs_create_dir("asoc", NULL);
+	if (IS_ERR(snd_soc_debugfs_root) || !snd_soc_debugfs_root) {
+		pr_warn("ASoC: Failed to create debugfs directory\n");
+		snd_soc_debugfs_root = NULL;
+		return;
+	}
+
+	if (!debugfs_create_file("codecs", 0444, snd_soc_debugfs_root, NULL,
+				 &codec_list_fops))
+		pr_warn("ASoC: Failed to create CODEC list debugfs file\n");
+
+	if (!debugfs_create_file("dais", 0444, snd_soc_debugfs_root, NULL,
+				 &dai_list_fops))
+		pr_warn("ASoC: Failed to create DAI list debugfs file\n");
+
+	if (!debugfs_create_file("platforms", 0444, snd_soc_debugfs_root, NULL,
+				 &platform_list_fops))
+		pr_warn("ASoC: Failed to create platform list debugfs file\n");
+}
+
+static void snd_soc_debugfs_exit(void)
+{
+	debugfs_remove_recursive(snd_soc_debugfs_root);
+}
+
 #else
 
 #define soc_init_codec_debugfs NULL
@@ -497,6 +531,15 @@ static inline void soc_init_card_debugfs(struct snd_soc_card *card)
 static inline void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 {
 }
+
+static inline void snd_soc_debugfs_init(void)
+{
+}
+
+static inline void snd_soc_debugfs_exit(void)
+{
+}
+
 #endif
 
 struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
@@ -3584,26 +3627,7 @@ EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_link_codecs);
 
 static int __init snd_soc_init(void)
 {
-#ifdef CONFIG_DEBUG_FS
-	snd_soc_debugfs_root = debugfs_create_dir("asoc", NULL);
-	if (IS_ERR(snd_soc_debugfs_root) || !snd_soc_debugfs_root) {
-		pr_warn("ASoC: Failed to create debugfs directory\n");
-		snd_soc_debugfs_root = NULL;
-	}
-
-	if (!debugfs_create_file("codecs", 0444, snd_soc_debugfs_root, NULL,
-				 &codec_list_fops))
-		pr_warn("ASoC: Failed to create CODEC list debugfs file\n");
-
-	if (!debugfs_create_file("dais", 0444, snd_soc_debugfs_root, NULL,
-				 &dai_list_fops))
-		pr_warn("ASoC: Failed to create DAI list debugfs file\n");
-
-	if (!debugfs_create_file("platforms", 0444, snd_soc_debugfs_root, NULL,
-				 &platform_list_fops))
-		pr_warn("ASoC: Failed to create platform list debugfs file\n");
-#endif
-
+	snd_soc_debugfs_init();
 	snd_soc_util_init();
 
 	return platform_driver_register(&soc_driver);
@@ -3613,9 +3637,9 @@ module_init(snd_soc_init);
 static void __exit snd_soc_exit(void)
 {
 	snd_soc_util_exit();
+	snd_soc_debugfs_exit();
 
 #ifdef CONFIG_DEBUG_FS
-	debugfs_remove_recursive(snd_soc_debugfs_root);
 #endif
 	platform_driver_unregister(&soc_driver);
 }
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4bd2a6f..defe0f0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1918,6 +1918,9 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 {
 	struct dentry *d;
 
+	if (!parent)
+		return;
+
 	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);
 
 	if (!dapm->debugfs_dapm) {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e67378a..35fe58f4 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1097,8 +1097,9 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 			stream ? "<-" : "->", be->dai_link->name);
 
 #ifdef CONFIG_DEBUG_FS
-	dpcm->debugfs_state = debugfs_create_u32(be->dai_link->name, 0644,
-			fe->debugfs_dpcm_root, &dpcm->state);
+	if (fe->debugfs_dpcm_root)
+		dpcm->debugfs_state = debugfs_create_u32(be->dai_link->name, 0644,
+				fe->debugfs_dpcm_root, &dpcm->state);
 #endif
 	return 1;
 }
@@ -2808,6 +2809,9 @@ void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
 	if (!rtd->dai_link)
 		return;
 
+	if (!rtd->card->debugfs_card_root)
+		return;
+
 	rtd->debugfs_dpcm_root = debugfs_create_dir(rtd->dai_link->name,
 			rtd->card->debugfs_card_root);
 	if (!rtd->debugfs_dpcm_root) {
-- 
1.8.0
