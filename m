From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 3/4] ASoC: Store a list of widgets in a DAPM
	mux/mixer kcontrol
Date: Thu, 28 Apr 2011 17:38:00 -0600
Message-ID: <1304033881-1160-4-git-send-email-swarren@nvidia.com>
References: <1304033881-1160-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C4F11039EC
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 01:38:14 +0200 (CEST)
In-Reply-To: <1304033881-1160-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

A future change will allow multiple widgets to be affected by the same
control. For example, a single register bit that controls separate muxes
in both the L and R audio paths.

This change updates the code that handles relevant controls to be able
to iterate over a list of affected widgets. Note that only the put
functions need significant modification to implement the iteration; the
get functions do not need to iterate, nor unify the results, since all
affected widgets reference the same kcontrol.

When creating the list of widgets, always create a 1-sized list, since
the control sharing is not implemented in this change.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/sound/soc-dapm.h |    6 ++
 sound/soc/soc-dapm.c     |  187 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 137 insertions(+), 56 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 8c4b90b..2a32b14 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -517,4 +517,10 @@ struct snd_soc_dapm_context {
 #endif
 };
 
+/* A list of widgets associated with an object, typically a snd_kcontrol */
+struct snd_soc_dapm_widget_list {
+	int num_widgets;
+	struct snd_soc_dapm_widget *widgets[0];
+};
+
 #endif
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 24d19a0..e140618 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -333,6 +333,8 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_path *path;
 	struct snd_card *card = dapm->card->snd_card;
 	const char *prefix;
+	struct snd_soc_dapm_widget_list *wlist;
+	size_t wlistsize;
 
 	if (dapm->codec)
 		prefix = dapm->codec->name_prefix;
@@ -354,6 +356,18 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 			if (path->name != (char *)w->kcontrol_news[i].name)
 				continue;
 
+			wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
+				    sizeof(struct snd_soc_dapm_widget *),
+			wlist = kzalloc(wlistsize, GFP_KERNEL);
+			if (wlist == NULL) {
+				dev_err(dapm->dev,
+					"asoc: can't allocate widget list for %s\n",
+					w->name);
+				return -ENOMEM;
+			}
+			wlist->num_widgets = 1;
+			wlist->widgets[0] = w;
+
 			/* add dapm control with long name.
 			 * for dapm_mixer this is the concatenation of the
 			 * mixer and kcontrol name.
@@ -366,8 +380,10 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 
 			path->long_name = kmalloc(name_len, GFP_KERNEL);
 
-			if (path->long_name == NULL)
+			if (path->long_name == NULL) {
+				kfree(wlist);
 				return -ENOMEM;
+			}
 
 			switch (w->id) {
 			default:
@@ -389,13 +405,15 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 
 			path->long_name[name_len - 1] = '\0';
 
-			path->kcontrol = snd_soc_cnew(&w->kcontrol_news[i], w,
-						      path->long_name, prefix);
+			path->kcontrol = snd_soc_cnew(&w->kcontrol_news[i],
+						      wlist, path->long_name,
+						      prefix);
 			ret = snd_ctl_add(card, path->kcontrol);
 			if (ret < 0) {
 				dev_err(dapm->dev,
 					"asoc: failed to add dapm kcontrol %s: %d\n",
 					path->long_name, ret);
+				kfree(wlist);
 				kfree(path->long_name);
 				path->long_name = NULL;
 				return ret;
@@ -416,12 +434,25 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	const char *prefix;
 	size_t prefix_len;
 	int ret = 0;
+	struct snd_soc_dapm_widget_list *wlist;
+	size_t wlistsize;
 
 	if (!w->num_kcontrols) {
 		dev_err(dapm->dev, "asoc: mux %s has no controls\n", w->name);
 		return -EINVAL;
 	}
 
+	wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
+		    sizeof(struct snd_soc_dapm_widget *),
+	wlist = kzalloc(wlistsize, GFP_KERNEL);
+	if (wlist == NULL) {
+		dev_err(dapm->dev,
+			"asoc: can't allocate widget list for %s\n", w->name);
+		return -ENOMEM;
+	}
+	wlist->num_widgets = 1;
+	wlist->widgets[0] = w;
+
 	if (dapm->codec)
 		prefix = dapm->codec->name_prefix;
 	else
@@ -436,8 +467,8 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	 * process but we're also using the same prefix for widgets so
 	 * cut the prefix off the front of the widget name.
 	 */
-	kcontrol = snd_soc_cnew(&w->kcontrol_news[0], w, w->name + prefix_len,
-				prefix);
+	kcontrol = snd_soc_cnew(&w->kcontrol_news[0], wlist,
+				w->name + prefix_len, prefix);
 	ret = snd_ctl_add(card, kcontrol);
 
 	if (ret < 0)
@@ -452,6 +483,7 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 
 err:
 	dev_err(dapm->dev, "asoc: failed to add kcontrol %s\n", w->name);
+	kfree(wlist);
 	return ret;
 }
 
@@ -1791,7 +1823,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
 int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
@@ -1830,7 +1863,9 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_volsw);
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct snd_soc_codec *codec = widget->codec;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
@@ -1841,6 +1876,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int val;
 	int connect, change;
 	struct snd_soc_dapm_update update;
+	int wi;
 
 	val = (ucontrol->value.integer.value[0] & mask);
 
@@ -1849,31 +1885,36 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	mask = mask << shift;
 	val = val << shift;
 
-	mutex_lock(&widget->codec->mutex);
-	widget->value = val;
+	if (val)
+		/* new connection */
+		connect = invert ? 0 : 1;
+	else
+		/* old connection must be powered down */
+		connect = invert ? 1 : 0;
+
+	mutex_lock(&codec->mutex);
 
 	change = snd_soc_test_bits(widget->codec, reg, mask, val);
 	if (change) {
-		if (val)
-			/* new connection */
-			connect = invert ? 0:1;
-		else
-			/* old connection must be powered down */
-			connect = invert ? 1:0;
+		for (wi = 0; wi < wlist->num_widgets; wi++) {
+			widget = wlist->widgets[wi];
 
-		update.kcontrol = kcontrol;
-		update.widget = widget;
-		update.reg = reg;
-		update.mask = mask;
-		update.val = val;
-		widget->dapm->update = &update;
+			widget->value = val;
 
-		dapm_mixer_update_power(widget, kcontrol, connect);
+			update.kcontrol = kcontrol;
+			update.widget = widget;
+			update.reg = reg;
+			update.mask = mask;
+			update.val = val;
+			widget->dapm->update = &update;
 
-		widget->dapm->update = NULL;
+			dapm_mixer_update_power(widget, kcontrol, connect);
+
+			widget->dapm->update = NULL;
+		}
 	}
 
-	mutex_unlock(&widget->codec->mutex);
+	mutex_unlock(&codec->mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);
@@ -1890,7 +1931,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);
 int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, bitmask;
 
@@ -1918,11 +1960,14 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_double);
 int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct snd_soc_codec *codec = widget->codec;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, mux, change;
 	unsigned int mask, bitmask;
 	struct snd_soc_dapm_update update;
+	int wi;
 
 	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
 		;
@@ -1938,22 +1983,29 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= (bitmask - 1) << e->shift_r;
 	}
 
-	mutex_lock(&widget->codec->mutex);
-	widget->value = val;
+	mutex_lock(&codec->mutex);
+
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
+	if (change) {
+		for (wi = 0; wi < wlist->num_widgets; wi++) {
+			widget = wlist->widgets[wi];
 
-	update.kcontrol = kcontrol;
-	update.widget = widget;
-	update.reg = e->reg;
-	update.mask = mask;
-	update.val = val;
-	widget->dapm->update = &update;
+			widget->value = val;
 
-	dapm_mux_update_power(widget, kcontrol, change, mux, e);
+			update.kcontrol = kcontrol;
+			update.widget = widget;
+			update.reg = e->reg;
+			update.mask = mask;
+			update.val = val;
+			widget->dapm->update = &update;
 
-	widget->dapm->update = NULL;
+			dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
-	mutex_unlock(&widget->codec->mutex);
+			widget->dapm->update = NULL;
+		}
+	}
+
+	mutex_unlock(&codec->mutex);
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
@@ -1968,7 +2020,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
 int snd_soc_dapm_get_enum_virt(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 
 	ucontrol->value.enumerated.item[0] = widget->value;
 
@@ -1986,22 +2039,33 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_virt);
 int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct snd_soc_codec *codec = widget->codec;
 	struct soc_enum *e =
 		(struct soc_enum *)kcontrol->private_value;
 	int change;
 	int ret = 0;
+	int wi;
 
 	if (ucontrol->value.enumerated.item[0] >= e->max)
 		return -EINVAL;
 
-	mutex_lock(&widget->codec->mutex);
+	mutex_lock(&codec->mutex);
 
 	change = widget->value != ucontrol->value.enumerated.item[0];
-	widget->value = ucontrol->value.enumerated.item[0];
-	dapm_mux_update_power(widget, kcontrol, change, widget->value, e);
+	if (change) {
+		for (wi = 0; wi < wlist->num_widgets; wi++) {
+			widget = wlist->widgets[wi];
+
+			widget->value = ucontrol->value.enumerated.item[0];
+
+			dapm_mux_update_power(widget, kcontrol, change,
+					      widget->value, e);
+		}
+	}
 
-	mutex_unlock(&widget->codec->mutex);
+	mutex_unlock(&codec->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_virt);
@@ -2022,7 +2086,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_virt);
 int snd_soc_dapm_get_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int reg_val, val, mux;
 
@@ -2062,11 +2127,14 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_value_enum_double);
 int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct snd_soc_codec *codec = widget->codec;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, mux, change;
 	unsigned int mask;
 	struct snd_soc_dapm_update update;
+	int wi;
 
 	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
@@ -2080,22 +2148,29 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= e->mask << e->shift_r;
 	}
 
-	mutex_lock(&widget->codec->mutex);
-	widget->value = val;
+	mutex_lock(&codec->mutex);
+
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
+	if (change) {
+		for (wi = 0; wi < wlist->num_widgets; wi++) {
+			widget = wlist->widgets[wi];
 
-	update.kcontrol = kcontrol;
-	update.widget = widget;
-	update.reg = e->reg;
-	update.mask = mask;
-	update.val = val;
-	widget->dapm->update = &update;
+			widget->value = val;
 
-	dapm_mux_update_power(widget, kcontrol, change, mux, e);
+			update.kcontrol = kcontrol;
+			update.widget = widget;
+			update.reg = e->reg;
+			update.mask = mask;
+			update.val = val;
+			widget->dapm->update = &update;
 
-	widget->dapm->update = NULL;
+			dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
-	mutex_unlock(&widget->codec->mutex);
+			widget->dapm->update = NULL;
+		}
+	}
+
+	mutex_unlock(&codec->mutex);
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_value_enum_double);
-- 
1.7.0.4
