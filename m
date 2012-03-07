From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 2/3] ASoC: dapm: Use DAPM mutex for DAPM ops
	instead of codec mutex.
Date: Wed,  7 Mar 2012 10:38:26 +0000
Message-ID: <1331116707-10016-2-git-send-email-lrg@ti.com>
References: <1331116707-10016-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id B785F1045B6
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 11:38:36 +0100 (CET)
Received: by mail-we0-f175.google.com with SMTP id a1so3858101wer.6
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 02:38:34 -0800 (PST)
In-Reply-To: <1331116707-10016-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

It has now become necessary to use a DAPM mutex instead of the codec
mutex to lock the DAPM operations. This is due to the recent multi
component support and forth coming Dynamic PCM updates.

Currently we lock DAPM operations with the codec mutex of the calling
RTD context. However, DAPM operations can span the whole card context
and all components.

This patch updates the DAPM operations that use the codec mutex to
now use the DAPM mutex PCM subclass for all DAPM ops.

We also add a mutex subclass for DAPM init and PCM operations.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    5 ++++
 include/sound/soc.h      |    1 +
 sound/soc/soc-core.c     |    1 +
 sound/soc/soc-dapm.c     |   59 ++++++++++++++++++++++++++++++---------------
 4 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index e46107f..6727384 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -431,6 +431,11 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_dai,		/* link to DAI structure */
 };
 
+enum snd_soc_dapm_subclass {
+	SND_SOC_DAPM_CLASS_INIT	= 0,
+	SND_SOC_DAPM_CLASS_PCM	= 1,
+};
+
 /*
  * DAPM audio route definition.
  *
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 70de2f8..66fd9bc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -805,6 +805,7 @@ struct snd_soc_card {
 
 	struct list_head list;
 	struct mutex mutex;
+	struct mutex dapm_mutex;
 
 	bool instantiated;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index acd0d93..5aef34a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3125,6 +3125,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->dapm_dirty);
 	card->instantiated = 0;
 	mutex_init(&card->mutex);
+	mutex_init(&card->dapm_mutex);
 
 	mutex_lock(&client_mutex);
 	list_add(&card->list, &card_list);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a837977..5beaa3e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1971,6 +1971,8 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
  */
 int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 {
+	int ret;
+
 	/*
 	 * Suppress early reports (eg, jacks syncing their state) to avoid
 	 * silly DAPM runs during card startup.
@@ -1978,7 +1980,10 @@ int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 	if (!dapm->card || !dapm->card->instantiated)
 		return 0;
 
-	return dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	ret = dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
+	mutex_unlock(&dapm->card->dapm_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
 
@@ -2144,6 +2149,7 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 {
 	int i, ret;
 
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
 		ret = snd_soc_dapm_add_route(dapm, route);
 		if (ret < 0) {
@@ -2153,6 +2159,7 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 		}
 		route++;
 	}
+	mutex_unlock(&dapm->card->dapm_mutex);
 
 	return 0;
 }
@@ -2225,12 +2232,14 @@ int snd_soc_dapm_weak_routes(struct snd_soc_dapm_context *dapm,
 	int i, err;
 	int ret = 0;
 
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
 		err = snd_soc_dapm_weak_route(dapm, route);
 		if (err)
 			ret = err;
 		route++;
 	}
+	mutex_unlock(&dapm->card->dapm_mutex);
 
 	return ret;
 }
@@ -2249,6 +2258,8 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 	struct snd_soc_dapm_widget *w;
 	unsigned int val;
 
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
+
 	list_for_each_entry(w, &dapm->card->widgets, list)
 	{
 		if (w->new)
@@ -2258,8 +2269,10 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 			w->kcontrols = kzalloc(w->num_kcontrols *
 						sizeof(struct snd_kcontrol *),
 						GFP_KERNEL);
-			if (!w->kcontrols)
+			if (!w->kcontrols) {
+				mutex_unlock(&dapm->card->dapm_mutex);
 				return -ENOMEM;
+			}
 		}
 
 		switch(w->id) {
@@ -2299,6 +2312,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 	}
 
 	dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
+	mutex_unlock(&dapm->card->dapm_mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
@@ -2358,6 +2372,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_card *card = codec->card;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
@@ -2384,7 +2399,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 		/* old connection must be powered down */
 		connect = invert ? 1 : 0;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
 
 	change = snd_soc_test_bits(widget->codec, reg, mask, val);
 	if (change) {
@@ -2406,7 +2421,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&card->dapm_mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);
@@ -2455,6 +2470,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_card *card = codec->card;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, mux, change;
 	unsigned int mask, bitmask;
@@ -2475,7 +2491,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= (bitmask - 1) << e->shift_r;
 	}
 
-	mutex_lock(&codec->mutex);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
 
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
 	if (change) {
@@ -2497,7 +2513,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&card->dapm_mutex);
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
@@ -2534,6 +2550,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_card *card = codec->card;
 	struct soc_enum *e =
 		(struct soc_enum *)kcontrol->private_value;
 	int change;
@@ -2543,7 +2560,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.enumerated.item[0] >= e->max)
 		return -EINVAL;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
 
 	change = widget->value != ucontrol->value.enumerated.item[0];
 	if (change) {
@@ -2556,7 +2573,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&card->dapm_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_virt);
@@ -2621,6 +2638,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_card *card = codec->card;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, mux, change;
 	unsigned int mask;
@@ -2639,7 +2657,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= e->mask << e->shift_r;
 	}
 
-	mutex_lock(&codec->mutex);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
 
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
 	if (change) {
@@ -2661,7 +2679,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&card->dapm_mutex);
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_value_enum_double);
@@ -2698,12 +2716,12 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	const char *pin = (const char *)kcontrol->private_value;
 
-	mutex_lock(&card->mutex);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
 
 	ucontrol->value.integer.value[0] =
 		snd_soc_dapm_get_pin_status(&card->dapm, pin);
 
-	mutex_unlock(&card->mutex);
+	mutex_unlock(&card->dapm_mutex);
 
 	return 0;
 }
@@ -2721,17 +2739,16 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	const char *pin = (const char *)kcontrol->private_value;
 
-	mutex_lock(&card->mutex);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
 
 	if (ucontrol->value.integer.value[0])
 		snd_soc_dapm_enable_pin(&card->dapm, pin);
 	else
 		snd_soc_dapm_disable_pin(&card->dapm, pin);
 
-	snd_soc_dapm_sync(&card->dapm);
-
-	mutex_unlock(&card->mutex);
+	mutex_unlock(&card->dapm_mutex);
 
+	snd_soc_dapm_sync(&card->dapm);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
@@ -2849,6 +2866,7 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w;
 	int i;
 
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
 		w = snd_soc_dapm_new_control(dapm, widget);
 		if (!w) {
@@ -2859,6 +2877,7 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 		}
 		widget++;
 	}
+	mutex_unlock(&dapm->card->dapm_mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
@@ -3013,11 +3032,11 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 			      struct snd_soc_dai *dai, int event)
 {
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = rtd->card;
 
-	mutex_lock(&codec->mutex);
-	soc_dapm_stream_event(&codec->dapm, stream, dai, event);
-	mutex_unlock(&codec->mutex);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	soc_dapm_stream_event(&card->dapm, stream, dai, event);
+	mutex_unlock(&card->dapm_mutex);
 	return 0;
 }
 
-- 
1.7.5.4
