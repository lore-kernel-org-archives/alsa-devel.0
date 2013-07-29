From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/10] ASoC: dapm: Move 'value' field from
	widget to control
Date: Mon, 29 Jul 2013 17:13:59 +0200
Message-ID: <1375110845-8069-5-git-send-email-lars@metafoo.de>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-130.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id A5E2E262607
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 17:13:15 +0200 (CEST)
In-Reply-To: <1375110845-8069-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The 'value' field is really per control and not per widget. Currently it is only
used for virtual MUXes, which only have one control per widget. So in that case
there is not so much of a difference between whether it is stored per widget or
per control. Moving the 'value' field from the widget to the control will allow
us to use it also for cases where we have more than one control per widget. E.g.
for mixers with multiple input controls.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  1 -
 sound/soc/soc-dapm.c     | 53 +++++++++++++++++++++++++++---------------------
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index ebfae8f..d7d26cc 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -523,7 +523,6 @@ struct snd_soc_dapm_widget {
 	/* dapm control */
 	int reg;				/* negative reg = no direct dapm */
 	unsigned char shift;			/* bits to shift */
-	unsigned int value;				/* widget current value */
 	unsigned int mask;			/* non-shifted mask */
 	unsigned int on_val;			/* on state value */
 	unsigned int off_val;			/* off state value */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index da35b10..bad6f6d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -175,6 +175,7 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 }
 
 struct dapm_kcontrol_data {
+	unsigned int value;
 	struct snd_soc_dapm_widget_list wlist;
 };
 
@@ -233,6 +234,26 @@ static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol)
+{
+	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
+
+	return data->value;
+}
+
+static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
+	unsigned int value)
+{
+	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
+
+	if (data->value == value)
+		return false;
+
+	data->value = value;
+
+	return true;
+}
+
 /**
  * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
  * @kcontrol: The kcontrol
@@ -2786,9 +2807,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_double);
 int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = dapm_kcontrol_get_wlist(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct snd_soc_card *card = codec->card;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, mux, change;
@@ -2811,8 +2830,6 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 
 	change = snd_soc_test_bits(codec, e->reg, mask, val);
 	if (change) {
-		widget->value = val;
-
 		update.kcontrol = kcontrol;
 		update.reg = e->reg;
 		update.mask = mask;
@@ -2839,11 +2856,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
 int snd_soc_dapm_get_enum_virt(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = dapm_kcontrol_get_wlist(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-
-	ucontrol->value.enumerated.item[0] = widget->value;
-
+	ucontrol->value.enumerated.item[0] = dapm_kcontrol_get_value(kcontrol);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_virt);
@@ -2858,10 +2871,9 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_virt);
 int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = dapm_kcontrol_get_wlist(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct snd_soc_card *card = codec->card;
+	unsigned int value;
 	struct soc_enum *e =
 		(struct soc_enum *)kcontrol->private_value;
 	int change;
@@ -2871,11 +2883,10 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
-	change = widget->value != ucontrol->value.enumerated.item[0];
-	if (change) {
-		widget->value = ucontrol->value.enumerated.item[0];
-		soc_dapm_mux_update_power(card, kcontrol, widget->value, e);
-	}
+	value = ucontrol->value.enumerated.item[0];
+	change = dapm_kcontrol_set_value(kcontrol, value);
+	if (change)
+		soc_dapm_mux_update_power(card, kcontrol, value, e);
 
 	mutex_unlock(&card->dapm_mutex);
 	return change;
@@ -2938,9 +2949,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_value_enum_double);
 int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = dapm_kcontrol_get_wlist(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct snd_soc_card *card = codec->card;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, mux, change;
@@ -2963,8 +2972,6 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 
 	change = snd_soc_test_bits(codec, e->reg, mask, val);
 	if (change) {
-		widget->value = val;
-
 		update.kcontrol = kcontrol;
 		update.reg = e->reg;
 		update.mask = mask;
-- 
1.8.0
