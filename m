From: Vikram Narayanan <vikram186@gmail.com>
Subject: [PATCH] checkpatch fixes in ASoC
Date: Sun, 19 Feb 2012 14:11:09 +0530
Message-ID: <4F40B5A5.3080605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Various checkpatch fixes in the ASoC tree

Signed-off-by: Vikram Narayanan <vikram186@gmail.com>
---
 sound/soc/soc-cache.c |    5 ++---
 sound/soc/soc-core.c  |   17 ++++++++---------
 sound/soc/soc-dapm.c  |   14 ++++++++------
 sound/soc/soc-pcm.c   |    4 ++--
 sound/soc/soc-utils.c |    2 +-
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 9077aa4..6b6c226 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -73,7 +73,7 @@ struct snd_soc_rbtree_node {
 	unsigned int word_size; /* number of bytes needed to represent the register index */
 	void *block; /* block of adjacent registers */
 	unsigned int blklen; /* number of registers available in the block */
-} __attribute__ ((packed));
+} __attribute__ ((__packed));
 
 struct snd_soc_rbtree_ctx {
 	struct rb_root root;
@@ -1017,9 +1017,8 @@ int snd_soc_cache_sync(struct snd_soc_codec *codec)
 	int ret;
 	const char *name;
 
-	if (!codec->cache_sync) {
+	if (!codec->cache_sync)
 		return 0;
-	}
 
 	if (!codec->cache_ops || !codec->cache_ops->sync)
 		return -ENOSYS;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a25fa63..c13d414 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -195,7 +195,7 @@ static ssize_t pmdown_time_set(struct device *dev,
 			container_of(dev, struct snd_soc_pcm_runtime, dev);
 	int ret;
 
-	ret = strict_strtol(buf, 10, &rtd->pmdown_time);
+	ret = kstrtol(buf, 10, &rtd->pmdown_time);
 	if (ret)
 		return ret;
 
@@ -254,10 +254,10 @@ static ssize_t codec_reg_write_file(struct file *file,
 
 	while (*start == ' ')
 		start++;
-	reg = simple_strtoul(start, &start, 16);
+	reg = kstrtoul(start, &start, 16);
 	while (*start == ' ')
 		start++;
-	if (strict_strtoul(start, 16, &value))
+	if (kstrtoul(start, 16, &value))
 		return -EINVAL;
 
 	/* Userspace has been fiddling around behind the kernel's back */
@@ -458,7 +458,7 @@ static int soc_ac97_dev_unregister(struct snd_soc_codec *codec)
 }
 
 /* stop no dev release warning */
-static void soc_ac97_device_release(struct device *dev){}
+static void soc_ac97_device_release(struct device *dev) {}
 
 /* register ac97 codec to bus */
 static int soc_ac97_dev_register(struct snd_soc_codec *codec)
@@ -758,9 +758,9 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	dev_dbg(card->dev, "binding %s at idx %d\n", dai_link->name, num);
 
 	/* do we already have the CPU DAI for this link ? */
-	if (rtd->cpu_dai) {
+	if (rtd->cpu_dai)
 		goto find_codec;
-	}
+
 	/* no, then find CPU DAI from registered DAIs*/
 	list_for_each_entry(cpu_dai, &dai_list, list) {
 		if (!strcmp(cpu_dai->name, dai_link->cpu_dai_name)) {
@@ -773,9 +773,8 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 
 find_codec:
 	/* do we already have the CODEC for this link ? */
-	if (rtd->codec) {
+	if (rtd->codec)
 		goto find_platform;
-	}
 
 	/* no, then find CODEC from registered CODECs*/
 	list_for_each_entry(codec, &codec_list, list) {
@@ -2028,7 +2027,7 @@ int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
 		err = snd_ctl_add(card, snd_soc_cnew(control, platform,
 				control->name, NULL));
 		if (err < 0) {
-			dev_err(platform->dev, "Failed to add %s %d\n",control->name, err);
+			dev_err(platform->dev, "Failed to add %s %d\n", control->name, err);
 			return err;
 		}
 	}
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index fcd4cb5..07abd58 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -379,7 +379,7 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 			list_add(&path->list, &dapm->card->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
-			path->name = (char*)e->texts[i];
+			path->name = (char *)e->texts[i];
 			dapm_set_path_status(dest, path, 0);
 			return 0;
 		}
@@ -1769,7 +1769,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 {
 	struct snd_soc_pcm_runtime *rtd =
 			container_of(dev, struct snd_soc_pcm_runtime, dev);
-	struct snd_soc_codec *codec =rtd->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_widget *w;
 	int count = 0;
 	char *state = "not set";
@@ -1795,7 +1795,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 		case snd_soc_dapm_regulator_supply:
 			if (w->name)
 				count += sprintf(buf + count, "%s: %s\n",
-					w->name, w->power ? "On":"Off");
+					w->name, w->power ? "On" : "Off");
 		break;
 		default:
 		break;
@@ -2209,7 +2209,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 				return -ENOMEM;
 		}
 
-		switch(w->id) {
+		switch (w->id) {
 		case snd_soc_dapm_switch:
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
@@ -2700,7 +2700,9 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	size_t name_len;
 	int ret;
 
-	if ((w = dapm_cnew_widget(widget)) == NULL)
+	w = dapm_cnew_widget(widget);
+
+	if (!w)
 		return -ENOMEM;
 
 	switch (w->id) {
@@ -2829,7 +2831,7 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 			w->name, w->sname, stream, event);
 		if (strstr(w->sname, stream)) {
 			dapm_mark_dirty(w, "stream event");
-			switch(event) {
+			switch (event) {
 			case SND_SOC_DAPM_STREAM_START:
 				w->active = 1;
 				break;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ee15337..174fdbb 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2010 Texas Instruments Inc.
  *
  * Authors: Liam Girdwood <lrg@ti.com>
- *          Mark Brown <broonie@opensource.wolfsonmicro.com>       
+ *          Mark Brown <broonie@opensource.wolfsonmicro.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -613,7 +613,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	if (codec_dai->driver->capture.channels_min)
 		capture = 1;
 
-	dev_dbg(rtd->card->dev, "registered pcm #%d %s\n",num,new_name);
+	dev_dbg(rtd->card->dev, "registered pcm #%d %s\n", num, new_name);
 	ret = snd_pcm_new(rtd->card->snd_card, new_name,
 			num, playback, capture, &pcm);
 	if (ret < 0) {
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 4220bb0..2eac245 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -5,7 +5,7 @@
  *
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
  *         Liam Girdwood <lrg@slimlogic.co.uk>
- *         
+ *
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
-- 
1.7.4.1
