From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update as
	parameter
Date: Thu, 28 Apr 2011 18:46:08 +0200
Message-ID: <1304009173-5786-2-git-send-email-lars@metafoo.de>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-163.synserver.de
	[212.40.185.163])
	by alsa0.perex.cz (Postfix) with SMTP id D1E7210399F
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 18:46:27 +0200 (CEST)
In-Reply-To: <1304009173-5786-1-git-send-email-lars@metafoo.de>
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

Pass the snd_dapm_soc_update struct as parameter to dapm_widget_update instead
of passing it indirectly as a field of the snd_soc_dapm_context struct.
This should make it more obvious were the struct is coming from and make the
code easier to comprehend.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |    2 -
 sound/soc/soc-dapm.c     |   47 ++++++++++++++++++++-------------------------
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d5f1b9a..cd52ad0 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -498,8 +498,6 @@ struct snd_soc_dapm_context {
 	struct delayed_work delayed_work;
 	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
 
-	struct snd_soc_dapm_update *update;
-
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
 			     enum snd_soc_dapm_type, int);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3f2e360..b51882e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -917,9 +917,8 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 	}
 }
 
-static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
+static void dapm_widget_update(struct snd_soc_dapm_update *update)
 {
-	struct snd_soc_dapm_update *update = dapm->update;
 	struct snd_soc_dapm_widget *w;
 	int ret;
 
@@ -1016,7 +1015,8 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
  *  o Input pin to Output pin (bypass, sidetone)
  *  o DAC to ADC (loopback).
  */
-static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
+static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event,
+	struct snd_soc_dapm_update *update)
 {
 	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dapm_widget *w;
@@ -1096,7 +1096,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	/* Power down widgets first; try to avoid amplifying pops. */
 	dapm_seq_run(dapm, &down_list, event, false);
 
-	dapm_widget_update(dapm);
+	dapm_widget_update(update);
 
 	/* Now power up. */
 	dapm_seq_run(dapm, &up_list, event, true);
@@ -1268,8 +1268,10 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 /* test and update the power status of a mux widget */
 static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 				 struct snd_kcontrol *kcontrol, int change,
-				 int mux, struct soc_enum *e)
+				 int mux, struct soc_enum *e,
+				 struct snd_soc_dapm_update *update)
 {
+	struct snd_soc_dapm_context *dapm = widget->dapm;
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
@@ -1282,7 +1284,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		return 0;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->dapm->card->paths, list) {
+	list_for_each_entry(path, &dapm->card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1298,15 +1300,17 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	}
 
 	if (found)
-		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
+		dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP, update);
 
 	return 0;
 }
 
 /* test and update the power status of a mixer or switch widget */
 static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
-				   struct snd_kcontrol *kcontrol, int connect)
+				   struct snd_kcontrol *kcontrol, int connect,
+				   struct snd_soc_dapm_update *update)
 {
+	struct snd_soc_dapm_context *dapm = widget->dapm;
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
@@ -1316,7 +1320,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		return -ENODEV;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->dapm->card->paths, list) {
+	list_for_each_entry(path, &dapm->card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1327,7 +1331,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 	}
 
 	if (found)
-		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
+		dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP, update);
 
 	return 0;
 }
@@ -1485,7 +1489,7 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
  */
 int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 {
-	return dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
+	return dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP, NULL);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
 
@@ -1737,7 +1741,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 		w->new = 1;
 	}
 
-	dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
+	dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP, NULL);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
@@ -1829,11 +1833,8 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 		update.reg = reg;
 		update.mask = mask;
 		update.val = val;
-		widget->dapm->update = &update;
 
-		dapm_mixer_update_power(widget, kcontrol, connect);
-
-		widget->dapm->update = NULL;
+		dapm_mixer_update_power(widget, kcontrol, connect, &update);
 	}
 
 	mutex_unlock(&widget->codec->mutex);
@@ -1910,11 +1911,8 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	update.reg = e->reg;
 	update.mask = mask;
 	update.val = val;
-	widget->dapm->update = &update;
-
-	dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
-	widget->dapm->update = NULL;
+	dapm_mux_update_power(widget, kcontrol, change, mux, e, &update);
 
 	mutex_unlock(&widget->codec->mutex);
 	return change;
@@ -1962,7 +1960,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 
 	change = widget->value != ucontrol->value.enumerated.item[0];
 	widget->value = ucontrol->value.enumerated.item[0];
-	dapm_mux_update_power(widget, kcontrol, change, widget->value, e);
+	dapm_mux_update_power(widget, kcontrol, change, widget->value, e, NULL);
 
 	mutex_unlock(&widget->codec->mutex);
 	return ret;
@@ -2052,11 +2050,8 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	update.reg = e->reg;
 	update.mask = mask;
 	update.val = val;
-	widget->dapm->update = &update;
-
-	dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
-	widget->dapm->update = NULL;
+	dapm_mux_update_power(widget, kcontrol, change, mux, e, &update);
 
 	mutex_unlock(&widget->codec->mutex);
 	return change;
@@ -2237,7 +2232,7 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 		}
 	}
 
-	dapm_power_widgets(dapm, event);
+	dapm_power_widgets(dapm, event, NULL);
 }
 
 /**
-- 
1.7.2.5
