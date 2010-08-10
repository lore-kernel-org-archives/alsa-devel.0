From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 2/5] ASoC: multi-component - DAPM Core
Date: Tue, 10 Aug 2010 18:02:22 +0100
Message-ID: <1281459745-28846-2-git-send-email-lrg@slimlogic.co.uk>
References: <1281459745-28846-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id ACA2D24554
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 19:02:38 +0200 (CEST)
Received: by mail-ew0-f51.google.com with SMTP id 21so3809793ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 10:02:38 -0700 (PDT)
In-Reply-To: <1281459745-28846-1-git-send-email-lrg@slimlogic.co.uk>
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

This patch adds DAPM support for ASoC multi-component and removes struct
snd_soc_socdev from DAPM core. All DAPM calls are now made on a card, codec
or runtime PCM level basis rather than using snd_soc_socdev.

Also added void snd_soc_dapm_shutdown() to shutdown all CODECs in a card.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 include/sound/soc-dapm.h |    8 ++--
 sound/soc/soc-dapm.c     |   88 +++++++++++++++++++++++----------------------
 2 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c5d9987..c4a4456 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -322,14 +322,14 @@ int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec);
-void snd_soc_dapm_free(struct snd_soc_device *socdev);
+void snd_soc_dapm_free(struct snd_soc_codec *codec);
 int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
 			    const struct snd_soc_dapm_route *route, int num);
 
 /* dapm events */
-int snd_soc_dapm_stream_event(struct snd_soc_codec *codec, char *stream,
-	int event);
-void snd_soc_dapm_shutdown(struct snd_soc_device *socdev);
+int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
+	const char *stream, int event);
+void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 03cb7c0..fb68c7d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -112,43 +112,41 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 
 /**
  * snd_soc_dapm_set_bias_level - set the bias level for the system
- * @socdev: audio device
+ * @card: audio device
  * @level: level to configure
  *
  * Configure the bias (power) levels for the SoC audio device.
  *
  * Returns 0 for success else error.
  */
-static int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
-				       enum snd_soc_bias_level level)
+static int snd_soc_dapm_set_bias_level(struct snd_soc_card *card,
+		struct snd_soc_codec *codec, enum snd_soc_bias_level level)
 {
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int ret = 0;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		dev_dbg(socdev->dev, "Setting full bias\n");
+		dev_dbg(codec->dev, "Setting full bias\n");
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		dev_dbg(socdev->dev, "Setting bias prepare\n");
+		dev_dbg(codec->dev, "Setting bias prepare\n");
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		dev_dbg(socdev->dev, "Setting standby bias\n");
+		dev_dbg(codec->dev, "Setting standby bias\n");
 		break;
 	case SND_SOC_BIAS_OFF:
-		dev_dbg(socdev->dev, "Setting bias off\n");
+		dev_dbg(codec->dev, "Setting bias off\n");
 		break;
 	default:
-		dev_err(socdev->dev, "Setting invalid bias %d\n", level);
+		dev_err(codec->dev, "Setting invalid bias %d\n", level);
 		return -EINVAL;
 	}
 
-	if (card->set_bias_level)
+	if (card && card->set_bias_level)
 		ret = card->set_bias_level(card, level);
 	if (ret == 0) {
-		if (codec->set_bias_level)
-			ret = codec->set_bias_level(codec, level);
+		if (codec->driver->set_bias_level)
+			ret = codec->driver->set_bias_level(codec, level);
 		else
 			codec->bias_level = level;
 	}
@@ -370,7 +368,7 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 
 			path->kcontrol = snd_soc_cnew(&w->kcontrols[i], w,
 				path->long_name);
-			ret = snd_ctl_add(codec->card, path->kcontrol);
+			ret = snd_ctl_add(codec->snd_card, path->kcontrol);
 			if (ret < 0) {
 				printk(KERN_ERR "asoc: failed to add dapm kcontrol %s: %d\n",
 				       path->long_name,
@@ -398,7 +396,7 @@ static int dapm_new_mux(struct snd_soc_codec *codec,
 	}
 
 	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, w->name);
-	ret = snd_ctl_add(codec->card, kcontrol);
+	ret = snd_ctl_add(codec->snd_card, kcontrol);
 	if (ret < 0)
 		goto err;
 
@@ -437,9 +435,9 @@ static inline void dapm_clear_walk(struct snd_soc_codec *codec)
  */
 static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
 {
-	struct snd_soc_codec *codec = widget->codec;
+	int level = snd_power_get_state(widget->codec->snd_card);
 
-	switch (snd_power_get_state(codec->card)) {
+	switch (level) {
 	case SNDRV_CTL_POWER_D3hot:
 	case SNDRV_CTL_POWER_D3cold:
 		if (widget->ignore_suspend)
@@ -893,7 +891,7 @@ static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
  */
 static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 {
-	struct snd_soc_device *socdev = codec->socdev;
+	struct snd_soc_card *card = codec->card;
 	struct snd_soc_dapm_widget *w;
 	LIST_HEAD(up_list);
 	LIST_HEAD(down_list);
@@ -966,7 +964,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	}
 
 	if (sys_power && codec->bias_level == SND_SOC_BIAS_OFF) {
-		ret = snd_soc_dapm_set_bias_level(socdev,
+		ret = snd_soc_dapm_set_bias_level(card, codec,
 						  SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
 			pr_err("Failed to turn on bias: %d\n", ret);
@@ -975,8 +973,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	/* If we're changing to all on or all off then prepare */
 	if ((sys_power && codec->bias_level == SND_SOC_BIAS_STANDBY) ||
 	    (!sys_power && codec->bias_level == SND_SOC_BIAS_ON)) {
-		ret = snd_soc_dapm_set_bias_level(socdev,
-						  SND_SOC_BIAS_PREPARE);
+		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_PREPARE);
 		if (ret != 0)
 			pr_err("Failed to prepare bias: %d\n", ret);
 	}
@@ -989,8 +986,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 
 	/* If we just powered the last thing off drop to standby bias */
 	if (codec->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
-		ret = snd_soc_dapm_set_bias_level(socdev,
-						  SND_SOC_BIAS_STANDBY);
+		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
 			pr_err("Failed to apply standby bias: %d\n", ret);
 	}
@@ -998,15 +994,14 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	/* If we're in standby and can support bias off then do that */
 	if (codec->bias_level == SND_SOC_BIAS_STANDBY &&
 	    codec->idle_bias_off) {
-		ret = snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_OFF);
+		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_OFF);
 		if (ret != 0)
 			pr_err("Failed to turn off bias: %d\n", ret);
 	}
 
 	/* If we just powered up then move to active bias */
 	if (codec->bias_level == SND_SOC_BIAS_PREPARE && sys_power) {
-		ret = snd_soc_dapm_set_bias_level(socdev,
-						  SND_SOC_BIAS_ON);
+		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_ON);
 		if (ret != 0)
 			pr_err("Failed to apply active bias: %d\n", ret);
 	}
@@ -1188,8 +1183,9 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 static ssize_t dapm_widget_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	struct snd_soc_device *devdata = dev_get_drvdata(dev);
-	struct snd_soc_codec *codec = devdata->card->codec;
+	struct snd_soc_pcm_runtime *rtd =
+			container_of(dev, struct snd_soc_pcm_runtime, dev);
+	struct snd_soc_codec *codec =rtd->codec;
 	struct snd_soc_dapm_widget *w;
 	int count = 0;
 	char *state = "not set";
@@ -1998,9 +1994,10 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
  *
  * Returns 0 for success else error.
  */
-int snd_soc_dapm_stream_event(struct snd_soc_codec *codec,
-	char *stream, int event)
+int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
+	const char *stream, int event)
 {
+	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_widget *w;
 
 	if (stream == NULL)
@@ -2168,25 +2165,19 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
 
 /**
  * snd_soc_dapm_free - free dapm resources
- * @socdev: SoC device
+ * @card: SoC device
  *
  * Free all dapm widgets and resources.
  */
-void snd_soc_dapm_free(struct snd_soc_device *socdev)
+void snd_soc_dapm_free(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	snd_soc_dapm_sys_remove(socdev->dev);
+	snd_soc_dapm_sys_remove(codec->dev);
 	dapm_free_widgets(codec);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_free);
 
-/*
- * snd_soc_dapm_shutdown - callback for system shutdown
- */
-void snd_soc_dapm_shutdown(struct snd_soc_device *socdev)
+static void soc_dapm_shutdown_codec(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
 	struct snd_soc_dapm_widget *w;
 	LIST_HEAD(down_list);
 	int powerdown = 0;
@@ -2203,12 +2194,23 @@ void snd_soc_dapm_shutdown(struct snd_soc_device *socdev)
 	 * standby.
 	 */
 	if (powerdown) {
-		snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_PREPARE);
+		snd_soc_dapm_set_bias_level(NULL, codec, SND_SOC_BIAS_PREPARE);
 		dapm_seq_run(codec, &down_list, 0, dapm_down_seq);
-		snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_STANDBY);
+		snd_soc_dapm_set_bias_level(NULL, codec, SND_SOC_BIAS_STANDBY);
 	}
+}
+
+/*
+ * snd_soc_dapm_shutdown - callback for system shutdown
+ */
+void snd_soc_dapm_shutdown(struct snd_soc_card *card)
+{
+	struct snd_soc_codec *codec;
+
+	list_for_each_entry(codec, &card->codec_dev_list, list)
+		soc_dapm_shutdown_codec(codec);
 
-	snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_OFF);
+	snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_OFF);
 }
 
 /* Module information */
-- 
1.7.0.4
