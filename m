From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: dapm: Run widget updates for shared
	controls at the same time
Date: Wed, 24 Jul 2013 15:27:37 +0200
Message-ID: <1374672459-5202-3-git-send-email-lars@metafoo.de>
References: <1374672459-5202-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id CFEF2265369
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 15:26:56 +0200 (CEST)
In-Reply-To: <1374672459-5202-1-git-send-email-lars@metafoo.de>
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
Cc: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <Andreas.Irestal@axis.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Hebbar Gururaja <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

Currently when updating a control that is shared between multiple widgets the
whole power-up/power-down sequence is being run once for each widget. The
control register is updated during the first run, which means the CODEC internal
routing is also updated for all widgets during this first run. The input and
output paths for each widgets are only updated though during the respective run
for that widget. This leads to a slight inconsistency between the CODEC's
internal state and ASoC's state, which causes non optimal behavior in regard to
click and pop avoidance.

E.g. consider the following setup where two MUXs share the same control.

          +------+
 A1 ------|      |
          | MUX1 |----- C1
 B1 ------|      |
          +------+
             |
  control ---+
             |
          +------+
 A2 ------|      |
          | MUX2 |----- C2
 B2 ------|      |
          +------+

If the control is updated to switch the MUXs from input A to input B with the
current code the power-up/power-down sequence will look like this:

Run soc_dapm_mux_update_power for MUX1
  Power-down A1
  Update MUXing
  Power-up B1

Run soc_dapm_mux_update_power for MUX2
  Power-down A2
  (Update MUXing)
  Power-up B2

Note that the second 'Update Muxing' is a no-op, since the register was already
updated.

While the preferred order for avoiding pops and clicks should be:

Run soc_dapm_mux_update_power for control
  Power-down A1
  Power-down A2
  Update MUXing
  Power-up B1
  Power-up B2

This patch changes the behavior to the later by running the updates for all
widgets that the control is attached to at the same time.

The new code is also a bit simpler since callers of
soc_dapm_{mux,muxer}_update_power don't have to loop over each widget anymore
and neither do we need to keep track for which of the kcontrol's widgets the
current update is.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |   7 +-
 sound/soc/soc-dapm.c     | 162 ++++++++++++++++++++---------------------------
 2 files changed, 71 insertions(+), 98 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 3e479f4..3717ad0 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -391,10 +391,10 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
 /* external DAPM widget events */
-int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
+int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 		struct snd_kcontrol *kcontrol, int connect);
-int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
-				 struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e);
+int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
+		struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e);
 
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
@@ -559,7 +559,6 @@ struct snd_soc_dapm_widget {
 };
 
 struct snd_soc_dapm_update {
-	struct snd_soc_dapm_widget *widget;
 	struct snd_kcontrol *kcontrol;
 	int reg;
 	int mask;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index db531f9..d511217 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1426,34 +1426,45 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_update *update = dapm->update;
-	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_widget_list *wlist;
+	struct snd_soc_dapm_widget *w = NULL;
+	unsigned int wi;
 	int ret;
 
 	if (!update)
 		return;
 
-	w = update->widget;
+	wlist = snd_kcontrol_chip(update->kcontrol);
 
-	if (w->event &&
-	    (w->event_flags & SND_SOC_DAPM_PRE_REG)) {
-		ret = w->event(w, update->kcontrol, SND_SOC_DAPM_PRE_REG);
-		if (ret != 0)
-			dev_err(dapm->dev, "ASoC: %s DAPM pre-event failed: %d\n",
-			       w->name, ret);
+	for (wi = 0; wi < wlist->num_widgets; wi++) {
+		w = wlist->widgets[wi];
+
+		if (w->event && (w->event_flags & SND_SOC_DAPM_PRE_REG)) {
+			ret = w->event(w, update->kcontrol, SND_SOC_DAPM_PRE_REG);
+			if (ret != 0)
+				dev_err(dapm->dev, "ASoC: %s DAPM pre-event failed: %d\n",
+					   w->name, ret);
+		}
 	}
 
+	if (!w)
+		return;
+
 	ret = soc_widget_update_bits_locked(w, update->reg, update->mask,
 				  update->val);
 	if (ret < 0)
 		dev_err(dapm->dev, "ASoC: %s DAPM update failed: %d\n",
 			w->name, ret);
 
-	if (w->event &&
-	    (w->event_flags & SND_SOC_DAPM_POST_REG)) {
-		ret = w->event(w, update->kcontrol, SND_SOC_DAPM_POST_REG);
-		if (ret != 0)
-			dev_err(dapm->dev, "ASoC: %s DAPM post-event failed: %d\n",
-			       w->name, ret);
+	for (wi = 0; wi < wlist->num_widgets; wi++) {
+		w = wlist->widgets[wi];
+
+		if (w->event && (w->event_flags & SND_SOC_DAPM_POST_REG)) {
+			ret = w->event(w, update->kcontrol, SND_SOC_DAPM_POST_REG);
+			if (ret != 0)
+				dev_err(dapm->dev, "ASoC: %s DAPM post-event failed: %d\n",
+					   w->name, ret);
+		}
 	}
 }
 
@@ -1906,19 +1917,14 @@ static inline void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
 #endif
 
 /* test and update the power status of a mux widget */
-static int soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
+static int soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
 				 struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e)
 {
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
-	if (widget->id != snd_soc_dapm_mux &&
-	    widget->id != snd_soc_dapm_virt_mux &&
-	    widget->id != snd_soc_dapm_value_mux)
-		return -ENODEV;
-
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->dapm->card->paths, list) {
+	list_for_each_entry(path, &dapm->card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1936,24 +1942,23 @@ static int soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 						"mux disconnection");
 			path->connect = 0; /* old connection must be powered down */
 		}
+		dapm_mark_dirty(path->sink, "mux change");
 	}
 
-	if (found) {
-		dapm_mark_dirty(widget, "mux change");
-		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
-	}
+	if (found)
+		dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
 
 	return found;
 }
 
-int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
-		struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e)
+int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_context *dapm,
+	struct snd_kcontrol *kcontrol, int mux, struct soc_enum *e)
 {
-	struct snd_soc_card *card = widget->dapm->card;
+	struct snd_soc_card *card = dapm->card;
 	int ret;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	ret = soc_dapm_mux_update_power(widget, kcontrol, mux, e);
+	ret = soc_dapm_mux_update_power(dapm, kcontrol, mux, e);
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
 		soc_dpcm_runtime_update(card);
@@ -1962,19 +1967,14 @@ int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mux_update_power);
 
 /* test and update the power status of a mixer or switch widget */
-static int soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
+static int soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 				   struct snd_kcontrol *kcontrol, int connect)
 {
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
-	if (widget->id != snd_soc_dapm_mixer &&
-	    widget->id != snd_soc_dapm_mixer_named_ctl &&
-	    widget->id != snd_soc_dapm_switch)
-		return -ENODEV;
-
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->dapm->card->paths, list) {
+	list_for_each_entry(path, &dapm->card->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1982,24 +1982,23 @@ static int soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		found = 1;
 		path->connect = connect;
 		dapm_mark_dirty(path->source, "mixer connection");
+		dapm_mark_dirty(path->sink, "mixer update");
 	}
 
-	if (found) {
-		dapm_mark_dirty(widget, "mixer update");
-		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
-	}
+	if (found)
+		dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
 
 	return found;
 }
 
-int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
-				struct snd_kcontrol *kcontrol, int connect)
+int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
+	struct snd_kcontrol *kcontrol, int connect)
 {
-	struct snd_soc_card *card = widget->dapm->card;
+	struct snd_soc_card *card = dapm->card;
 	int ret;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	ret = soc_dapm_mixer_update_power(widget, kcontrol, connect);
+	ret = soc_dapm_mixer_update_power(dapm, kcontrol, connect);
 	mutex_unlock(&card->dapm_mutex);
 	if (ret > 0)
 		soc_dpcm_runtime_update(card);
@@ -2665,7 +2664,6 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int val;
 	int connect, change;
 	struct snd_soc_dapm_update update;
-	int wi;
 
 	if (snd_soc_volsw_is_stereo(mc))
 		dev_warn(widget->dapm->dev,
@@ -2684,22 +2682,16 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 
 	change = snd_soc_test_bits(widget->codec, reg, mask, val);
 	if (change) {
-		for (wi = 0; wi < wlist->num_widgets; wi++) {
-			widget = wlist->widgets[wi];
-
-			widget->value = val;
+		update.kcontrol = kcontrol;
+		update.reg = reg;
+		update.mask = mask;
+		update.val = val;
 
-			update.kcontrol = kcontrol;
-			update.widget = widget;
-			update.reg = reg;
-			update.mask = mask;
-			update.val = val;
-			widget->dapm->update = &update;
+		widget->dapm->update = &update;
 
-			soc_dapm_mixer_update_power(widget, kcontrol, connect);
+		soc_dapm_mixer_update_power(widget->dapm, kcontrol, connect);
 
-			widget->dapm->update = NULL;
-		}
+		widget->dapm->update = NULL;
 	}
 
 	mutex_unlock(&card->dapm_mutex);
@@ -2754,7 +2746,6 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned int val, mux, change;
 	unsigned int mask;
 	struct snd_soc_dapm_update update;
-	int wi;
 
 	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
@@ -2772,22 +2763,17 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
 	if (change) {
-		for (wi = 0; wi < wlist->num_widgets; wi++) {
-			widget = wlist->widgets[wi];
+		widget->value = val;
 
-			widget->value = val;
+		update.kcontrol = kcontrol;
+		update.reg = e->reg;
+		update.mask = mask;
+		update.val = val;
+		widget->dapm->update = &update;
 
-			update.kcontrol = kcontrol;
-			update.widget = widget;
-			update.reg = e->reg;
-			update.mask = mask;
-			update.val = val;
-			widget->dapm->update = &update;
+		soc_dapm_mux_update_power(widget->dapm, kcontrol, mux, e);
 
-			soc_dapm_mux_update_power(widget, kcontrol, mux, e);
-
-			widget->dapm->update = NULL;
-		}
+		widget->dapm->update = NULL;
 	}
 
 	mutex_unlock(&card->dapm_mutex);
@@ -2831,7 +2817,6 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e =
 		(struct soc_enum *)kcontrol->private_value;
 	int change;
-	int wi;
 
 	if (ucontrol->value.enumerated.item[0] >= e->max)
 		return -EINVAL;
@@ -2840,13 +2825,8 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 
 	change = widget->value != ucontrol->value.enumerated.item[0];
 	if (change) {
-		for (wi = 0; wi < wlist->num_widgets; wi++) {
-			widget = wlist->widgets[wi];
-
-			widget->value = ucontrol->value.enumerated.item[0];
-
-			soc_dapm_mux_update_power(widget, kcontrol, widget->value, e);
-		}
+		widget->value = ucontrol->value.enumerated.item[0];
+		soc_dapm_mux_update_power(widget->dapm, kcontrol, widget->value, e);
 	}
 
 	mutex_unlock(&card->dapm_mutex);
@@ -2919,7 +2899,6 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned int val, mux, change;
 	unsigned int mask;
 	struct snd_soc_dapm_update update;
-	int wi;
 
 	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
@@ -2937,22 +2916,17 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
 	if (change) {
-		for (wi = 0; wi < wlist->num_widgets; wi++) {
-			widget = wlist->widgets[wi];
-
-			widget->value = val;
+		widget->value = val;
 
-			update.kcontrol = kcontrol;
-			update.widget = widget;
-			update.reg = e->reg;
-			update.mask = mask;
-			update.val = val;
-			widget->dapm->update = &update;
+		update.kcontrol = kcontrol;
+		update.reg = e->reg;
+		update.mask = mask;
+		update.val = val;
+		widget->dapm->update = &update;
 
-			soc_dapm_mux_update_power(widget, kcontrol, mux, e);
+		soc_dapm_mux_update_power(widget->dapm, kcontrol, mux, e);
 
-			widget->dapm->update = NULL;
-		}
+		widget->dapm->update = NULL;
 	}
 
 	mutex_unlock(&card->dapm_mutex);
-- 
1.8.0
