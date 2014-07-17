From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: Move card field form platform/codec
	to component
Date: Thu, 17 Jul 2014 22:01:07 +0200
Message-ID: <1405627268-23939-4-git-send-email-lars@metafoo.de>
References: <1405627268-23939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id B1D9726548B
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 22:01:09 +0200 (CEST)
In-Reply-To: <1405627268-23939-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

Both the snd_soc_codec and snd_soc_platform struct do have a pointer to the
parent card and both handle this pointer in mostly the same way. This patch
moves the card field to the component level which will allow further code
consolidation between platforms and CODECS.

Since there are only a handful of users of the snd_soc_codec struct's card field
(and none of the snd_soc_platform's) these are update in this patch as well,
which allows it to be removed from the snd_soc_codec struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h        |  3 +--
 sound/soc/codecs/ac97.c    |  4 ++--
 sound/soc/codecs/cx20442.c |  6 +++---
 sound/soc/codecs/uda134x.c |  2 +-
 sound/soc/codecs/wm8960.c  |  2 +-
 sound/soc/codecs/wm_adsp.c |  4 ++--
 sound/soc/omap/ams-delta.c |  2 +-
 sound/soc/soc-core.c       | 19 ++++++++++---------
 sound/soc/soc-dapm.c       |  2 +-
 sound/soc/soc-jack.c       |  4 ++--
 10 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6a8d577..248db66 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -702,6 +702,7 @@ struct snd_soc_component {
 	int id;
 	const char *name_prefix;
 	struct device *dev;
+	struct snd_soc_card *card;
 
 	unsigned int active;
 
@@ -736,7 +737,6 @@ struct snd_soc_codec {
 	const struct snd_soc_codec_driver *driver;
 
 	struct mutex mutex;
-	struct snd_soc_card *card;
 	struct list_head list;
 	struct list_head card_list;
 
@@ -874,7 +874,6 @@ struct snd_soc_platform {
 	unsigned int suspended:1; /* platform is suspended */
 	unsigned int probed:1;
 
-	struct snd_soc_card *card;
 	struct list_head list;
 
 	struct snd_soc_component component;
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 8d9ba4ba..e889e1b 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -89,8 +89,8 @@ static int ac97_soc_probe(struct snd_soc_codec *codec)
 	int ret;
 
 	/* add codec as bus device for standard ac97 */
-	ret = snd_ac97_bus(codec->card->snd_card, 0, soc_ac97_ops, NULL,
-			   &ac97_bus);
+	ret = snd_ac97_bus(codec->component.card->snd_card, 0, soc_ac97_ops,
+			   NULL, &ac97_bus);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index d5fd00a..4ba60eb 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -253,7 +253,7 @@ static void v253_close(struct tty_struct *tty)
 	/* Prevent the codec driver from further accessing the modem */
 	codec->hw_write = NULL;
 	cx20442->control_data = NULL;
-	codec->card->pop_time = 0;
+	codec->component.card->pop_time = 0;
 }
 
 /* Line discipline .hangup() */
@@ -281,7 +281,7 @@ static void v253_receive(struct tty_struct *tty,
 		/* Set up codec driver access to modem controls */
 		cx20442->control_data = tty;
 		codec->hw_write = (hw_write_t)tty->ops->write;
-		codec->card->pop_time = 1;
+		codec->component.card->pop_time = 1;
 	}
 }
 
@@ -372,7 +372,7 @@ static int cx20442_codec_probe(struct snd_soc_codec *codec)
 
 	snd_soc_codec_set_drvdata(codec, cx20442);
 	codec->hw_write = NULL;
-	codec->card->pop_time = 0;
+	codec->component.card->pop_time = 0;
 
 	return 0;
 }
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index edf27ac..12fc0ae 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -479,7 +479,7 @@ static struct snd_soc_dai_driver uda134x_dai = {
 static int uda134x_soc_probe(struct snd_soc_codec *codec)
 {
 	struct uda134x_priv *uda134x;
-	struct uda134x_platform_data *pd = codec->card->dev->platform_data;
+	struct uda134x_platform_data *pd = codec->component.card->dev->platform_data;
 	const struct snd_soc_dapm_widget *widgets;
 	unsigned num_widgets;
 
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index a145d04..e96349b 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -472,7 +472,7 @@ static int wm8960_add_widgets(struct snd_soc_codec *codec)
 	 * list each time to find the desired power state do so now
 	 * and save the result.
 	 */
-	list_for_each_entry(w, &codec->card->widgets, list) {
+	list_for_each_entry(w, &codec->component.card->widgets, list) {
 		if (w->dapm != &codec->dapm)
 			continue;
 		if (strcmp(w->name, "LOUT1 PGA") == 0)
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 2537725..f412a99 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1382,7 +1382,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 	int ret;
 	int val;
 
-	dsp->card = codec->card;
+	dsp->card = codec->component.card;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -1617,7 +1617,7 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
 
-	dsp->card = codec->card;
+	dsp->card = codec->component.card;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 0cc41f9..8c9cc64 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -301,7 +301,7 @@ static int cx81801_open(struct tty_struct *tty)
 static void cx81801_close(struct tty_struct *tty)
 {
 	struct snd_soc_codec *codec = tty->disc_data;
-	struct snd_soc_dapm_context *dapm = &codec->card->dapm;
+	struct snd_soc_dapm_context *dapm = &codec->component.card->dapm;
 
 	del_timer_sync(&cx81801_timer);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2cb2edd..6337603 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -292,7 +292,7 @@ static struct dentry *soc_debugfs_create_dir(struct dentry *parent,
 
 static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 {
-	struct dentry *debugfs_card_root = codec->card->debugfs_card_root;
+	struct dentry *debugfs_card_root = codec->component.card->debugfs_card_root;
 
 	codec->debugfs_codec_root = soc_debugfs_create_dir(debugfs_card_root,
 						"codec:%s",
@@ -325,7 +325,7 @@ static void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
 
 static void soc_init_platform_debugfs(struct snd_soc_platform *platform)
 {
-	struct dentry *debugfs_card_root = platform->card->debugfs_card_root;
+	struct dentry *debugfs_card_root = platform->component.card->debugfs_card_root;
 
 	platform->debugfs_platform_root = soc_debugfs_create_dir(debugfs_card_root,
 						"platform:%s",
@@ -546,11 +546,12 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 	int err;
 
 	codec->ac97->dev.bus = &ac97_bus_type;
-	codec->ac97->dev.parent = codec->card->dev;
+	codec->ac97->dev.parent = codec->component.card->dev;
 	codec->ac97->dev.release = soc_ac97_device_release;
 
 	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
-		     codec->card->snd_card->number, 0, codec->component.name);
+		     codec->component.card->snd_card->number, 0,
+		     codec->component.name);
 	err = device_register(&codec->ac97->dev);
 	if (err < 0) {
 		dev_err(codec->dev, "ASoC: Can't register ac97 bus\n");
@@ -1179,7 +1180,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	const struct snd_soc_codec_driver *driver = codec->driver;
 	struct snd_soc_dai *dai;
 
-	codec->card = card;
+	codec->component.card = card;
 	codec->dapm.card = card;
 	soc_set_name_prefix(card, &codec->component);
 
@@ -1255,7 +1256,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 
-	platform->card = card;
+	platform->component.card = card;
 	platform->component.dapm.card = card;
 
 	if (!try_module_get(platform->dev->driver->owner))
@@ -2406,7 +2407,7 @@ EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol);
 int snd_soc_add_codec_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
-	struct snd_card *card = codec->card->snd_card;
+	struct snd_card *card = codec->component.card->snd_card;
 
 	return snd_soc_add_controls(card, codec->dev, controls, num_controls,
 			codec->component.name_prefix, &codec->component);
@@ -2426,7 +2427,7 @@ EXPORT_SYMBOL_GPL(snd_soc_add_codec_controls);
 int snd_soc_add_platform_controls(struct snd_soc_platform *platform,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
-	struct snd_card *card = platform->card->snd_card;
+	struct snd_card *card = platform->component.card->snd_card;
 
 	return snd_soc_add_controls(card, platform->dev, controls, num_controls,
 			NULL, &platform->component);
@@ -3101,7 +3102,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
 int snd_soc_limit_volume(struct snd_soc_codec *codec,
 	const char *name, int max)
 {
-	struct snd_card *card = codec->card->snd_card;
+	struct snd_card *card = codec->component.card->snd_card;
 	struct snd_kcontrol *kctl;
 	struct soc_mixer_control *mc;
 	int found = 0;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8cb68a38..8348352 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2090,7 +2090,7 @@ static ssize_t dapm_widget_show_codec(struct snd_soc_codec *codec, char *buf)
 	int count = 0;
 	char *state = "not set";
 
-	list_for_each_entry(w, &codec->card->widgets, list) {
+	list_for_each_entry(w, &codec->component.card->widgets, list) {
 		if (w->dapm != &codec->dapm)
 			continue;
 
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index d0d9881..ab47fea 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -43,7 +43,7 @@ int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
 	INIT_LIST_HEAD(&jack->jack_zones);
 	BLOCKING_INIT_NOTIFIER_HEAD(&jack->notifier);
 
-	return snd_jack_new(codec->card->snd_card, id, type, &jack->jack);
+	return snd_jack_new(codec->component.card->snd_card, id, type, &jack->jack);
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_new);
 
@@ -260,7 +260,7 @@ static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 static irqreturn_t gpio_handler(int irq, void *data)
 {
 	struct snd_soc_jack_gpio *gpio = data;
-	struct device *dev = gpio->jack->codec->card->dev;
+	struct device *dev = gpio->jack->codec->component.card->dev;
 
 	trace_snd_soc_jack_irq(gpio->name);
 
-- 
1.8.0
