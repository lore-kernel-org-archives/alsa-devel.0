From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/10] ASoC: dapm: Add a helper to get the
	CODEC for DAPM kcontrol
Date: Mon, 29 Jul 2013 17:13:57 +0200
Message-ID: <1375110845-8069-3-git-send-email-lars@metafoo.de>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-130.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 349F02625EA
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 17:13:14 +0200 (CEST)
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

We use the same 3 lines to get the CODEC for a kcontrol in a quite a few places.
This patch puts them into a common helper function. Having this encapsulated in
a helper function will also make it more easier to eventually change the data
layout of the kcontrol's private data.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h       |  2 ++
 sound/soc/codecs/tlv320aic3x.c |  7 +++----
 sound/soc/codecs/twl6040.c     |  4 +---
 sound/soc/codecs/wm8903.c      |  4 +---
 sound/soc/codecs/wm8994.c      |  4 +---
 sound/soc/codecs/wm8995.c      |  5 +----
 sound/soc/codecs/wm_hubs.c     |  8 ++------
 sound/soc/soc-dapm.c           | 40 +++++++++++++++++++++++-----------------
 8 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 3397292..ebfae8f 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -427,6 +427,8 @@ void dapm_mark_io_dirty(struct snd_soc_dapm_context *dapm);
 int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	struct snd_soc_dapm_widget_list **list);
 
+struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol);
+
 /* dapm widget types */
 enum snd_soc_dapm_type {
 	snd_soc_dapm_input = 0,		/* input pin */
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d3417c8..6e3f269 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -138,8 +138,7 @@ static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
 static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
@@ -165,14 +164,14 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 	mask <<= shift;
 	val <<= shift;
 
-	change = snd_soc_test_bits(widget->codec, val, mask, reg);
+	change = snd_soc_test_bits(codec, val, mask, reg);
 	if (change) {
 		update.kcontrol = kcontrol;
 		update.reg = reg;
 		update.mask = mask;
 		update.val = val;
 
-		snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol, connect,
+		snd_soc_dapm_mixer_update_power(&codec->dapm, kcontrol, connect,
 			&update);
 	}
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index caf8784..3c79dbb 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -438,9 +438,7 @@ static irqreturn_t twl6040_audio_handler(int irq, void *data)
 static int twl6040_soc_dapm_put_vibra_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val;
 
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index fa24ced..eebcb1d 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -364,9 +364,7 @@ static void wm8903_seq_notifier(struct snd_soc_dapm_context *dapm,
 static int wm8903_class_w_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 	u16 reg;
 	int ret;
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index a8d7b0c..d76b056 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1438,9 +1438,7 @@ SOC_DAPM_SINGLE("AIF1.1 Switch", WM8994_DAC2_RIGHT_MIXER_ROUTING,
 static int wm8994_put_class_w(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *w = wlist->widgets[0];
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	int ret;
 
 	ret = snd_soc_dapm_put_volsw(kcontrol, ucontrol);
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 90a65c4..da2899e6 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -549,12 +549,9 @@ static int check_clk_sys(struct snd_soc_dapm_widget *source,
 static int wm8995_put_class_w(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *w = wlist->widgets[0];
-	struct snd_soc_codec *codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	int ret;
 
-	codec = w->codec;
 	ret = snd_soc_dapm_put_volsw(kcontrol, ucontrol);
 	wm8995_update_class_w(codec);
 	return ret;
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 2d9e099..8b50e59 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -699,9 +699,7 @@ EXPORT_SYMBOL_GPL(wm_hubs_update_class_w);
 static int class_w_put_volsw(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	int ret;
 
 	ret = snd_soc_dapm_put_volsw(kcontrol, ucontrol);
@@ -721,9 +719,7 @@ static int class_w_put_volsw(struct snd_kcontrol *kcontrol,
 static int class_w_put_double(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	int ret;
 
 	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5db8df2..b18ac5b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -174,6 +174,17 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	return kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
 }
 
+/**
+ * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
+ * @kcontrol: The kcontrol
+ */
+struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol)
+{
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	return wlist->widgets[0]->codec;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_codec);
+
 static void dapm_reset(struct snd_soc_card *card)
 {
 	struct snd_soc_dapm_widget *w;
@@ -2617,8 +2628,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
 int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
@@ -2628,12 +2638,12 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int invert = mc->invert;
 
 	if (snd_soc_volsw_is_stereo(mc))
-		dev_warn(widget->dapm->dev,
+		dev_warn(codec->dapm.dev,
 			 "ASoC: Control '%s' is stereo, which is not supported\n",
 			 kcontrol->id.name);
 
 	ucontrol->value.integer.value[0] =
-		(snd_soc_read(widget->codec, reg) >> shift) & mask;
+		(snd_soc_read(codec, reg) >> shift) & mask;
 	if (invert)
 		ucontrol->value.integer.value[0] =
 			max - ucontrol->value.integer.value[0];
@@ -2654,9 +2664,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_volsw);
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct snd_soc_card *card = codec->card;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
@@ -2670,7 +2678,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_update update;
 
 	if (snd_soc_volsw_is_stereo(mc))
-		dev_warn(widget->dapm->dev,
+		dev_warn(codec->dapm.dev,
 			 "ASoC: Control '%s' is stereo, which is not supported\n",
 			 kcontrol->id.name);
 
@@ -2684,7 +2692,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
-	change = snd_soc_test_bits(widget->codec, reg, mask, val);
+	change = snd_soc_test_bits(codec, reg, mask, val);
 	if (change) {
 		update.kcontrol = kcontrol;
 		update.reg = reg;
@@ -2715,12 +2723,11 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);
 int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val;
 
-	val = snd_soc_read(widget->codec, e->reg);
+	val = snd_soc_read(codec, e->reg);
 	ucontrol->value.enumerated.item[0] = (val >> e->shift_l) & e->mask;
 	if (e->shift_l != e->shift_r)
 		ucontrol->value.enumerated.item[1] =
@@ -2765,7 +2772,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
-	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
+	change = snd_soc_test_bits(codec, e->reg, mask, val);
 	if (change) {
 		widget->value = val;
 
@@ -2854,12 +2861,11 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_virt);
 int snd_soc_dapm_get_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int reg_val, val, mux;
 
-	reg_val = snd_soc_read(widget->codec, e->reg);
+	reg_val = snd_soc_read(codec, e->reg);
 	val = (reg_val >> e->shift_l) & e->mask;
 	for (mux = 0; mux < e->max; mux++) {
 		if (val == e->values[mux])
@@ -2918,7 +2924,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
-	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
+	change = snd_soc_test_bits(codec, e->reg, mask, val);
 	if (change) {
 		widget->value = val;
 
-- 
1.8.0
