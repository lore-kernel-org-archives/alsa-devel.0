From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/10] ASoC: dapm: Wrap kcontrol widget list
	access
Date: Mon, 29 Jul 2013 17:13:58 +0200
Message-ID: <1375110845-8069-4-git-send-email-lars@metafoo.de>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-130.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id E872A2625FE
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

In preparation for adding additional per control data wrap all access to the
widget list in helper functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 119 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 41 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b18ac5b..da35b10 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -174,14 +174,72 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	return kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
 }
 
+struct dapm_kcontrol_data {
+	struct snd_soc_dapm_widget_list wlist;
+};
+
+static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
+	struct snd_kcontrol *kcontrol)
+{
+	struct dapm_kcontrol_data *data;
+
+	data = kzalloc(sizeof(*data) + sizeof(widget), GFP_KERNEL);
+	if (!data) {
+		dev_err(widget->dapm->dev,
+				"ASoC: can't allocate kcontrol data for %s\n",
+				widget->name);
+		return -ENOMEM;
+	}
+
+	data->wlist.widgets[0] = widget;
+	data->wlist.num_widgets = 1;
+
+	kcontrol->private_data = data;
+
+	return 0;
+}
+
+static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
+{
+	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kctl);
+	kfree(data);
+}
+
+static struct snd_soc_dapm_widget_list *dapm_kcontrol_get_wlist(
+	const struct snd_kcontrol *kcontrol)
+{
+	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
+
+	return &data->wlist;
+}
+
+static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
+	struct snd_soc_dapm_widget *widget)
+{
+	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
+	struct dapm_kcontrol_data *new_data;
+	unsigned int n = data->wlist.num_widgets + 1;
+
+	new_data = krealloc(data, sizeof(*data) + sizeof(widget) * n,
+		GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->wlist.widgets[n - 1] = widget;
+	data->wlist.num_widgets = n;
+
+	kcontrol->private_data = data;
+
+	return 0;
+}
+
 /**
  * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
  * @kcontrol: The kcontrol
  */
 struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	return wlist->widgets[0]->codec;
+	return dapm_kcontrol_get_wlist(kcontrol)->widgets[0]->codec;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_codec);
 
@@ -488,11 +546,6 @@ static int dapm_is_shared_kcontrol(struct snd_soc_dapm_context *dapm,
 	return 0;
 }
 
-static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
-{
-	kfree(kctl->private_data);
-}
-
 /*
  * Determine if a kcontrol is shared. If it is, look it up. If it isn't,
  * create it. Either way, add the widget into the control's widget list
@@ -506,9 +559,6 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 	size_t prefix_len;
 	int shared;
 	struct snd_kcontrol *kcontrol;
-	struct snd_soc_dapm_widget_list *wlist;
-	int wlistentries;
-	size_t wlistsize;
 	bool wname_in_long_name, kcname_in_long_name;
 	char *long_name;
 	const char *name;
@@ -527,25 +577,6 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 	shared = dapm_is_shared_kcontrol(dapm, w, &w->kcontrol_news[kci],
 					 &kcontrol);
 
-	if (kcontrol) {
-		wlist = kcontrol->private_data;
-		wlistentries = wlist->num_widgets + 1;
-	} else {
-		wlist = NULL;
-		wlistentries = 1;
-	}
-
-	wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
-			wlistentries * sizeof(struct snd_soc_dapm_widget *);
-	wlist = krealloc(wlist, wlistsize, GFP_KERNEL);
-	if (wlist == NULL) {
-		dev_err(dapm->dev, "ASoC: can't allocate widget list for %s\n",
-			w->name);
-		return -ENOMEM;
-	}
-	wlist->num_widgets = wlistentries;
-	wlist->widgets[wlistentries - 1] = w;
-
 	if (!kcontrol) {
 		if (shared) {
 			wname_in_long_name = false;
@@ -568,7 +599,6 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 				kcname_in_long_name = false;
 				break;
 			default:
-				kfree(wlist);
 				return -EINVAL;
 			}
 		}
@@ -583,10 +613,8 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 			long_name = kasprintf(GFP_KERNEL, "%s %s",
 				 w->name + prefix_len,
 				 w->kcontrol_news[kci].name);
-			if (long_name == NULL) {
-				kfree(wlist);
+			if (long_name == NULL)
 				return -ENOMEM;
-			}
 
 			name = long_name;
 		} else if (wname_in_long_name) {
@@ -597,21 +625,30 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 			name = w->kcontrol_news[kci].name;
 		}
 
-		kcontrol = snd_soc_cnew(&w->kcontrol_news[kci], wlist, name,
+		kcontrol = snd_soc_cnew(&w->kcontrol_news[kci], NULL, name,
 					prefix);
 		kcontrol->private_free = dapm_kcontrol_free;
 		kfree(long_name);
+
+		ret = dapm_kcontrol_data_alloc(w, kcontrol);
+		if (ret) {
+			snd_ctl_free_one(kcontrol);
+			return ret;
+		}
+
 		ret = snd_ctl_add(card, kcontrol);
 		if (ret < 0) {
 			dev_err(dapm->dev,
 				"ASoC: failed to add widget %s dapm kcontrol %s: %d\n",
 				w->name, name, ret);
-			kfree(wlist);
 			return ret;
 		}
+	} else {
+		ret = dapm_kcontrol_add_widget(kcontrol, w);
+		if (ret)
+			return ret;
 	}
 
-	kcontrol->private_data = wlist;
 	w->kcontrols[kci] = kcontrol;
 	path->kcontrol = kcontrol;
 
@@ -1443,7 +1480,7 @@ static void dapm_widget_update(struct snd_soc_card *card)
 	if (!update)
 		return;
 
-	wlist = snd_kcontrol_chip(update->kcontrol);
+	wlist = dapm_kcontrol_get_wlist(update->kcontrol);
 
 	for (wi = 0; wi < wlist->num_widgets; wi++) {
 		w = wlist->widgets[wi];
@@ -2749,7 +2786,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_double);
 int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = dapm_kcontrol_get_wlist(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
 	struct snd_soc_card *card = codec->card;
@@ -2802,7 +2839,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
 int snd_soc_dapm_get_enum_virt(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = dapm_kcontrol_get_wlist(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 
 	ucontrol->value.enumerated.item[0] = widget->value;
@@ -2821,7 +2858,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_virt);
 int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = dapm_kcontrol_get_wlist(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
 	struct snd_soc_card *card = codec->card;
@@ -2901,7 +2938,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_value_enum_double);
 int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget_list *wlist = dapm_kcontrol_get_wlist(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
 	struct snd_soc_card *card = codec->card;
-- 
1.8.0
