From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/5] sound: soc: core: no need to check return
	value of debugfs_create functions
Date: Fri, 14 Jun 2019 11:47:56 +0200
Message-ID: <20190614094756.2965-5-gregkh@linuxfoundation.org>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 053BDF896CE
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 12:07:25 +0200 (CEST)
In-Reply-To: <20190614094756.2965-1-gregkh@linuxfoundation.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Also, there is no need to store the individual debugfs file name, just
remove the whole directory all at once, saving a local variable.

Note, the soc-pcm "state" file has now moved to a subdirectory, as it is
only a good idea to save the dentries for debugfs directories, not
individual files, as the individual file debugfs functions are changing
to not return a dentry.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/sound/soc.h  |  1 -
 sound/soc/soc-core.c | 31 ++++++-------------------------
 sound/soc/soc-dapm.c | 26 ++++----------------------
 sound/soc/soc-pcm.c  | 14 ++++----------
 4 files changed, 14 insertions(+), 58 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 482b4ea87c3c..4acd8f6bf460 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1177,7 +1177,6 @@ struct snd_soc_card {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_card_root;
-	struct dentry *debugfs_pop_time;
 #endif
 	u32 pop_time;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2403bec2fccf..8d047e0a3e74 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -207,23 +207,11 @@ DEFINE_SHOW_ATTRIBUTE(component_list);
 
 static void soc_init_card_debugfs(struct snd_soc_card *card)
 {
-	if (!snd_soc_debugfs_root)
-		return;
-
 	card->debugfs_card_root = debugfs_create_dir(card->name,
 						     snd_soc_debugfs_root);
-	if (!card->debugfs_card_root) {
-		dev_warn(card->dev,
-			 "ASoC: Failed to create card debugfs directory\n");
-		return;
-	}
 
-	card->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0644,
-						    card->debugfs_card_root,
-						    &card->pop_time);
-	if (!card->debugfs_pop_time)
-		dev_warn(card->dev,
-			 "ASoC: Failed to create pop time debugfs file\n");
+	debugfs_create_u32("dapm_pop_time", 0644, card->debugfs_card_root,
+			   &card->pop_time);
 }
 
 static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
@@ -234,19 +222,12 @@ static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 static void snd_soc_debugfs_init(void)
 {
 	snd_soc_debugfs_root = debugfs_create_dir("asoc", NULL);
-	if (IS_ERR_OR_NULL(snd_soc_debugfs_root)) {
-		pr_warn("ASoC: Failed to create debugfs directory\n");
-		snd_soc_debugfs_root = NULL;
-		return;
-	}
 
-	if (!debugfs_create_file("dais", 0444, snd_soc_debugfs_root, NULL,
-				 &dai_list_fops))
-		pr_warn("ASoC: Failed to create DAI list debugfs file\n");
+	debugfs_create_file("dais", 0444, snd_soc_debugfs_root, NULL,
+			    &dai_list_fops);
 
-	if (!debugfs_create_file("components", 0444, snd_soc_debugfs_root, NULL,
-				 &component_list_fops))
-		pr_warn("ASoC: Failed to create component list debugfs file\n");
+	debugfs_create_file("components", 0444, snd_soc_debugfs_root, NULL,
+			    &component_list_fops);
 }
 
 static void snd_soc_debugfs_exit(void)
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 81a7a12196ff..bc43060e8a70 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2153,42 +2153,24 @@ static const struct file_operations dapm_bias_fops = {
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 	struct dentry *parent)
 {
-	struct dentry *d;
-
 	if (!parent)
 		return;
 
 	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);
 
-	if (!dapm->debugfs_dapm) {
-		dev_warn(dapm->dev,
-		       "ASoC: Failed to create DAPM debugfs directory\n");
-		return;
-	}
-
-	d = debugfs_create_file("bias_level", 0444,
-				dapm->debugfs_dapm, dapm,
-				&dapm_bias_fops);
-	if (!d)
-		dev_warn(dapm->dev,
-			 "ASoC: Failed to create bias level debugfs file\n");
+	debugfs_create_file("bias_level", 0444, dapm->debugfs_dapm, dapm,
+			    &dapm_bias_fops);
 }
 
 static void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct dentry *d;
 
 	if (!dapm->debugfs_dapm || !w->name)
 		return;
 
-	d = debugfs_create_file(w->name, 0444,
-				dapm->debugfs_dapm, w,
-				&dapm_widget_power_fops);
-	if (!d)
-		dev_warn(w->dapm->dev,
-			"ASoC: Failed to create %s debugfs file\n",
-			w->name);
+	debugfs_create_file(w->name, 0444, dapm->debugfs_dapm, w,
+			    &dapm_widget_power_fops);
 }
 
 static void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0a4f60c7a188..00ab01377909 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1258,9 +1258,9 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 			stream ? "<-" : "->", be->dai_link->name);
 
 #ifdef CONFIG_DEBUG_FS
-	if (fe->debugfs_dpcm_root)
-		dpcm->debugfs_state = debugfs_create_u32(be->dai_link->name, 0644,
-				fe->debugfs_dpcm_root, &dpcm->state);
+	dpcm->debugfs_state = debugfs_create_dir(be->dai_link->name,
+						 fe->debugfs_dpcm_root);
+	debugfs_create_u32("state", 0644, dpcm->debugfs_state, &dpcm->state);
 #endif
 	return 1;
 }
@@ -1315,7 +1315,7 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 		dpcm_be_reparent(fe, dpcm->be, stream);
 
 #ifdef CONFIG_DEBUG_FS
-		debugfs_remove(dpcm->debugfs_state);
+		debugfs_remove_recursive(dpcm->debugfs_state);
 #endif
 		spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 		list_del(&dpcm->list_be);
@@ -3449,12 +3449,6 @@ void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
 
 	rtd->debugfs_dpcm_root = debugfs_create_dir(rtd->dai_link->name,
 			rtd->card->debugfs_card_root);
-	if (!rtd->debugfs_dpcm_root) {
-		dev_dbg(rtd->dev,
-			 "ASoC: Failed to create dpcm debugfs directory %s\n",
-			 rtd->dai_link->name);
-		return;
-	}
 
 	debugfs_create_file("state", 0444, rtd->debugfs_dpcm_root,
 			    rtd, &dpcm_state_fops);
-- 
2.22.0
