From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Do DAPM control updates in the
	middle of DAPM sequences
Date: Tue, 14 Dec 2010 17:53:22 +0000
Message-ID: <1292349202-25538-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1292349202-25538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 77ACD103819
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 18:53:24 +0100 (CET)
In-Reply-To: <1292349202-25538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Attempt to minimise audible effects from mixer and mux updates by
implementing the actual register changes between powering down widgets
that have become unused and powering up widgets that are newly used.

This means that we're making the change with the minimum set of widgets
powered, that the input path is connected when we're powering up widgets
(so things like DC offset correction can run with their signal active)
and that we bring things down to cold before switching away.  Since
hardware tends to be designed for the power on/off case more than for
dynamic reconfiguration this should minimise pops and clicks during
reconfiguration while active.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Peter, I think this will address your widget reordering issue - I'd
appreciate it if you could test and let me know if it helps.  If this
works it avoids the need for the the widget to know anything about the
particular algorithm implemented by DAPM which seems more robust to me.

Sorry about how long it took to get this done.

 include/sound/soc-dapm.h |   10 ++++
 sound/soc/soc-dapm.c     |  130 +++++++++++++++++++++++++--------------------
 2 files changed, 82 insertions(+), 58 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index aef975f..1490c72 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -460,6 +460,14 @@ struct snd_soc_dapm_widget {
 	struct list_head power_list;
 };
 
+struct snd_soc_dapm_update {
+	struct snd_soc_dapm_widget *widget;
+	struct snd_kcontrol *kcontrol;
+	int reg;
+	int mask;
+	int val;
+};
+
 /* DAPM context */
 struct snd_soc_dapm_context {
 	struct list_head widgets;
@@ -469,6 +477,8 @@ struct snd_soc_dapm_context {
 	struct delayed_work delayed_work;
 	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
 
+	struct snd_soc_dapm_update *update;
+
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_codec *codec; /* parent codec */
 	struct snd_soc_card *card; /* parent card */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3d310af..9077cf0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -916,6 +916,41 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 		dapm_seq_run_coalesced(dapm, &pending);
 }
 
+static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
+{
+	struct snd_soc_dapm_update *update = dapm->update;
+	struct snd_soc_dapm_widget *w;
+	int ret;
+
+	if (!update)
+		return;
+
+	w = update->widget;
+
+	if (w->event &&
+	    (w->event_flags & SND_SOC_DAPM_PRE_REG)) {
+		ret = w->event(w, update->kcontrol, SND_SOC_DAPM_PRE_REG);
+		if (ret != 0)
+			pr_err("%s DAPM pre-event failed: %d\n",
+			       w->name, ret);
+	}
+
+	ret = snd_soc_update_bits(w->codec, update->reg, update->mask,
+				  update->val);
+	if (ret < 0)
+		pr_err("%s DAPM update failed: %d\n", w->name, ret);
+
+	if (w->event &&
+	    (w->event_flags & SND_SOC_DAPM_POST_REG)) {
+		ret = w->event(w, update->kcontrol, SND_SOC_DAPM_POST_REG);
+		if (ret != 0)
+			pr_err("%s DAPM post-event failed: %d\n",
+			       w->name, ret);
+	}
+}
+
+
+
 /*
  * Scan each dapm widget for complete audio path.
  * A complete path is a route that has valid endpoints i.e.:-
@@ -1026,6 +1061,8 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	/* Power down widgets first; try to avoid amplifying pops. */
 	dapm_seq_run(dapm, &down_list, event, dapm_down_seq);
 
+	dapm_widget_update(dapm);
+
 	/* Now power up. */
 	dapm_seq_run(dapm, &up_list, event, dapm_up_seq);
 
@@ -1634,13 +1671,12 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
-	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
-	unsigned int val, val2, val_mask;
-	int connect;
-	int ret;
+	unsigned int val, val_mask;
+	int connect, change;
+	struct snd_soc_dapm_update update;
 
 	val = (ucontrol->value.integer.value[0] & mask);
 
@@ -1648,18 +1684,12 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 		val = max - val;
 	val_mask = mask << shift;
 	val = val << shift;
-	if (shift != rshift) {
-		val2 = (ucontrol->value.integer.value[1] & mask);
-		if (invert)
-			val2 = max - val2;
-		val_mask |= mask << rshift;
-		val |= val2 << rshift;
-	}
 
 	mutex_lock(&widget->codec->mutex);
 	widget->value = val;
 
-	if (snd_soc_test_bits(widget->codec, reg, val_mask, val)) {
+	change = snd_soc_test_bits(widget->codec, reg, val_mask, val);
+	if (change) {
 		if (val)
 			/* new connection */
 			connect = invert ? 0:1;
@@ -1667,28 +1697,20 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 			/* old connection must be powered down */
 			connect = invert ? 1:0;
 
+		update.kcontrol = kcontrol;
+		update.widget = widget;
+		update.reg = reg;
+		update.mask = mask;
+		update.val = val;
+		widget->dapm->update = &update;
+
 		dapm_mixer_update_power(widget, kcontrol, connect);
+
+		widget->dapm->update = NULL;
 	}
 
-	if (widget->event) {
-		if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
-			ret = widget->event(widget, kcontrol,
-						SND_SOC_DAPM_PRE_REG);
-			if (ret < 0) {
-				ret = 1;
-				goto out;
-			}
-		}
-		ret = snd_soc_update_bits(widget->codec, reg, val_mask, val);
-		if (widget->event_flags & SND_SOC_DAPM_POST_REG)
-			ret = widget->event(widget, kcontrol,
-						SND_SOC_DAPM_POST_REG);
-	} else
-		ret = snd_soc_update_bits(widget->codec, reg, val_mask, val);
-
-out:
 	mutex_unlock(&widget->codec->mutex);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);
 
@@ -1736,7 +1758,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, mux, change;
 	unsigned int mask, bitmask;
-	int ret = 0;
+	struct snd_soc_dapm_update update;
 
 	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
 		;
@@ -1755,24 +1777,20 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	mutex_lock(&widget->codec->mutex);
 	widget->value = val;
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
-	dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
-	if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
-		ret = widget->event(widget,
-				    kcontrol, SND_SOC_DAPM_PRE_REG);
-		if (ret < 0)
-			goto out;
-	}
+	update.kcontrol = kcontrol;
+	update.widget = widget;
+	update.reg = e->reg;
+	update.mask = mask;
+	update.val = val;
+	widget->dapm->update = &update;
 
-	ret = snd_soc_update_bits(widget->codec, e->reg, mask, val);
+	dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
-	if (widget->event_flags & SND_SOC_DAPM_POST_REG)
-		ret = widget->event(widget,
-				    kcontrol, SND_SOC_DAPM_POST_REG);
+	widget->dapm->update = NULL;
 
-out:
 	mutex_unlock(&widget->codec->mutex);
-	return ret;
+	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
 
@@ -1884,7 +1902,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, mux, change;
 	unsigned int mask;
-	int ret = 0;
+	struct snd_soc_dapm_update update;
 
 	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
@@ -1901,24 +1919,20 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	mutex_lock(&widget->codec->mutex);
 	widget->value = val;
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
-	dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
-	if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
-		ret = widget->event(widget,
-				    kcontrol, SND_SOC_DAPM_PRE_REG);
-		if (ret < 0)
-			goto out;
-	}
+	update.kcontrol = kcontrol;
+	update.widget = widget;
+	update.reg = e->reg;
+	update.mask = mask;
+	update.val = val;
+	widget->dapm->update = &update;
 
-	ret = snd_soc_update_bits(widget->codec, e->reg, mask, val);
+	dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
-	if (widget->event_flags & SND_SOC_DAPM_POST_REG)
-		ret = widget->event(widget,
-				    kcontrol, SND_SOC_DAPM_POST_REG);
+	widget->dapm->update = NULL;
 
-out:
 	mutex_unlock(&widget->codec->mutex);
-	return ret;
+	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_value_enum_double);
 
-- 
1.7.1
