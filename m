From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/3] ASoC: Move pop time from DAPM context to
	sound card
Date: Fri,  5 Nov 2010 20:35:21 +0200
Message-ID: <1288982121-22201-4-git-send-email-jhnikula@gmail.com>
References: <1288982121-22201-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 29D5310399C
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 19:35:27 +0100 (CET)
Received: by mail-ew0-f51.google.com with SMTP id 22so2093899ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 05 Nov 2010 11:35:27 -0700 (PDT)
In-Reply-To: <1288982121-22201-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Based on discussion the dapm_pop_time in debugsfs should be per card rather
than per device. Single pop time value for entire card is cleaner when the
DAPM sequencing is extended to cross-device paths.

debugfs/asoc/{card->name}/{codec dir}/dapm_pop_time
->
debugfs/asoc/{card->name}/dapm_pop_time

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc-dapm.h   |    2 +-
 include/sound/soc.h        |    3 ++-
 sound/soc/codecs/cx20442.c |    6 +++---
 sound/soc/soc-core.c       |   19 +++++++++++--------
 sound/soc/soc-dapm.c       |   30 ++++++++++++++++--------------
 5 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 5881876..78d3560 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -469,7 +469,6 @@ struct snd_soc_dapm_widget {
 
 /* DAPM context */
 struct snd_soc_dapm_context {
-	u32 pop_time;
 	struct list_head widgets;
 	struct list_head paths;
 	enum snd_soc_bias_level bias_level;
@@ -479,6 +478,7 @@ struct snd_soc_dapm_context {
 
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_codec *codec; /* parent codec */
+	struct snd_soc_card *card; /* parent card */
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dapm;
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 95ce0dd..5d39547 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -457,7 +457,6 @@ struct snd_soc_codec {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_codec_root;
 	struct dentry *debugfs_reg;
-	struct dentry *debugfs_pop_time;
 	struct dentry *debugfs_dapm;
 #endif
 };
@@ -592,7 +591,9 @@ struct snd_soc_card {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_card_root;
+	struct dentry *debugfs_pop_time;
 #endif
+	u32 pop_time;
 };
 
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 11beb1a..a9521ac 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -264,7 +264,7 @@ static void v253_close(struct tty_struct *tty)
 	/* Prevent the codec driver from further accessing the modem */
 	codec->hw_write = NULL;
 	cx20442->control_data = NULL;
-	codec->dapm.pop_time = 0;
+	codec->card->pop_time = 0;
 }
 
 /* Line discipline .hangup() */
@@ -292,7 +292,7 @@ static void v253_receive(struct tty_struct *tty,
 		/* Set up codec driver access to modem controls */
 		cx20442->control_data = tty;
 		codec->hw_write = (hw_write_t)tty->ops->write;
-		codec->dapm.pop_time = 1;
+		codec->card->pop_time = 1;
 	}
 }
 
@@ -349,7 +349,7 @@ static int cx20442_codec_probe(struct snd_soc_codec *codec)
 
 	cx20442->control_data = NULL;
 	codec->hw_write = NULL;
-	codec->dapm.pop_time = 0;
+	codec->card->pop_time = 0;
 
 	return 0;
 }
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a358ce9..bb24c28 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -255,13 +255,6 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 		printk(KERN_WARNING
 		       "ASoC: Failed to create codec register debugfs file\n");
 
-	codec->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0644,
-						     codec->debugfs_codec_root,
-						     &codec->dapm.pop_time);
-	if (!codec->debugfs_pop_time)
-		printk(KERN_WARNING
-		       "Failed to create pop time debugfs file\n");
-
 	codec->dapm.debugfs_dapm = debugfs_create_dir("dapm",
 						 codec->debugfs_codec_root);
 	if (!codec->dapm.debugfs_dapm)
@@ -380,9 +373,18 @@ static void soc_init_card_debugfs(struct snd_soc_card *card)
 {
 	card->debugfs_card_root = debugfs_create_dir(card->name,
 						     debugfs_root);
-	if (!card->debugfs_card_root)
+	if (!card->debugfs_card_root) {
 		dev_warn(card->dev,
 			 "ASoC: Failed to create codec debugfs directory\n");
+		return;
+	}
+
+	card->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0644,
+						    card->debugfs_card_root,
+						    &card->pop_time);
+	if (!card->debugfs_pop_time)
+		dev_warn(card->dev,
+		       "Failed to create pop time debugfs file\n");
 }
 
 static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
@@ -1426,6 +1428,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 
 	/* probe the CODEC */
 	if (!codec->probed) {
+		codec->dapm.card = card;
 		if (codec->driver->probe) {
 			ret = codec->driver->probe(codec);
 			if (ret < 0) {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b8f653e..960790c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -293,6 +293,7 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 	unsigned int old, new;
 	struct snd_soc_codec *codec = widget->codec;
 	struct snd_soc_dapm_context *dapm = widget->dapm;
+	struct snd_soc_card *card = dapm->card;
 
 	/* check for valid widgets */
 	if (widget->reg < 0 || widget->id == snd_soc_dapm_input ||
@@ -312,10 +313,10 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 
 	change = old != new;
 	if (change) {
-		pop_dbg(dapm->pop_time, "pop test %s : %s in %d ms\n",
+		pop_dbg(card->pop_time, "pop test %s : %s in %d ms\n",
 			widget->name, widget->power ? "on" : "off",
-			dapm->pop_time);
-		pop_wait(dapm->pop_time);
+			card->pop_time);
+		pop_wait(card->pop_time);
 		snd_soc_write(codec, widget->reg, new);
 	}
 	pr_debug("reg %x old %x new %x change %d\n", widget->reg,
@@ -720,6 +721,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 				   struct list_head *pending)
 {
 	struct snd_soc_dapm_widget *w;
+	struct snd_soc_card *card = dapm->card;
 	int reg, power, ret;
 	unsigned int value = 0;
 	unsigned int mask = 0;
@@ -741,14 +743,14 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		if (power)
 			value |= cur_mask;
 
-		pop_dbg(dapm->pop_time,
+		pop_dbg(card->pop_time,
 			"pop test : Queue %s: reg=0x%x, 0x%x/0x%x\n",
 			w->name, reg, value, mask);
 
 		/* power up pre event */
 		if (w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_PRE_PMU)) {
-			pop_dbg(dapm->pop_time, "pop test : %s PRE_PMU\n",
+			pop_dbg(card->pop_time, "pop test : %s PRE_PMU\n",
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
 			if (ret < 0)
@@ -759,7 +761,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		/* power down pre event */
 		if (!w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
-			pop_dbg(dapm->pop_time, "pop test : %s PRE_PMD\n",
+			pop_dbg(card->pop_time, "pop test : %s PRE_PMD\n",
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
 			if (ret < 0)
@@ -769,10 +771,10 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 	}
 
 	if (reg >= 0) {
-		pop_dbg(dapm->pop_time,
+		pop_dbg(card->pop_time,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
-			value, mask, reg, dapm->pop_time);
-		pop_wait(dapm->pop_time);
+			value, mask, reg, card->pop_time);
+		pop_wait(card->pop_time);
 		snd_soc_update_bits(dapm->codec, reg, mask, value);
 	}
 
@@ -780,7 +782,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		/* power up post event */
 		if (w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
-			pop_dbg(dapm->pop_time, "pop test : %s POST_PMU\n",
+			pop_dbg(card->pop_time, "pop test : %s POST_PMU\n",
 				w->name);
 			ret = w->event(w,
 				       NULL, SND_SOC_DAPM_POST_PMU);
@@ -792,7 +794,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 		/* power down post event */
 		if (!w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_POST_PMD)) {
-			pop_dbg(dapm->pop_time, "pop test : %s POST_PMD\n",
+			pop_dbg(card->pop_time, "pop test : %s POST_PMD\n",
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
 			if (ret < 0)
@@ -1012,9 +1014,9 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			pr_err("Failed to apply active bias: %d\n", ret);
 	}
 
-	pop_dbg(dapm->pop_time, "DAPM sequencing finished, waiting %dms\n",
-		dapm->pop_time);
-	pop_wait(dapm->pop_time);
+	pop_dbg(card->pop_time, "DAPM sequencing finished, waiting %dms\n",
+		card->pop_time);
+	pop_wait(card->pop_time);
 
 	return 0;
 }
-- 
1.7.2.3
