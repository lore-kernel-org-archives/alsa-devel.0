From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2] ASoC: Implement mixer control sharing
Date: Fri, 29 Mar 2013 15:40:10 -0600
Message-ID: <1364593210-2373-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DDD7260306
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2013 22:40:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

This is the equivalent of commit af46800 "ASoC: Implement mux control
sharing", but applied to mixers instead of muxes.

This allows a single control to affect multiple mixer widgets at once,
which is useful when there is a single set of register bits that affects
multiple mixers in HW, for example both the L and R mixers of a stereo
path.

Without this, you either:

1) End up with multiple controls that affect the same register bits, but
whose DAPM state falls out of sync with HW, since the DAPM state is only
updated for the specific control that is modified, and not for other
paths that are affected by the register bit(s).

2) False paths through DAPM, since you end up merging unconnected stereo
paths together into a single widget which hosts the single control, and
then branching back out again, thus conjoining the enable states of the
two input paths.

Now that the kcontrol creation logic is split out into a separate
function, dapm_create_or_share_mixmux_kcontrol(), also use that to
replace most of the body of dapm_new_mux(). This should produce no
functional change, but simply eliminates some mostly duplicated code.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Split dapm_new_mixer()'s loop body into a separate function,
    dapm_create_or_share_mixmux_kcontrol, to avoid a nasty goto. Also
    use this for dapm_new_mux().
---
 sound/soc/soc-dapm.c |  270 +++++++++++++++++++++++++-------------------------
 1 file changed, 136 insertions(+), 134 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 33acd8b..c7cacf9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -504,17 +504,27 @@ static int dapm_is_shared_kcontrol(struct snd_soc_dapm_context *dapm,
 	return 0;
 }
 
-/* create new dapm mixer control */
-static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
+/*
+ * Determine if a kcontrol is shared. If it is, look it up. If it isn't,
+ * create it. Either way, add the widget into the control's widget list
+ */
+static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
+	int kci, struct snd_soc_dapm_path *path)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
-	int i, ret = 0;
-	size_t name_len, prefix_len;
-	struct snd_soc_dapm_path *path;
 	struct snd_card *card = dapm->card->snd_card;
 	const char *prefix;
+	size_t prefix_len;
+	int shared;
+	struct snd_kcontrol *kcontrol;
 	struct snd_soc_dapm_widget_list *wlist;
+	int wlistentries;
 	size_t wlistsize;
+	bool wname_in_long_name, kcname_in_long_name;
+	size_t name_len;
+	char *long_name;
+	const char *name;
+	int ret;
 
 	if (dapm->codec)
 		prefix = dapm->codec->name_prefix;
@@ -526,103 +536,141 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 	else
 		prefix_len = 0;
 
-	/* add kcontrol */
-	for (i = 0; i < w->num_kcontrols; i++) {
+	shared = dapm_is_shared_kcontrol(dapm, w, &w->kcontrol_news[kci],
+					 &kcontrol);
 
-		/* match name */
-		list_for_each_entry(path, &w->sources, list_sink) {
+	if (kcontrol) {
+		wlist = kcontrol->private_data;
+		wlistentries = wlist->num_widgets + 1;
+	} else {
+		wlist = NULL;
+		wlistentries = 1;
+	}
 
-			/* mixer/mux paths name must match control name */
-			if (path->name != (char *)w->kcontrol_news[i].name)
-				continue;
+	wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
+			wlistentries * sizeof(struct snd_soc_dapm_widget *);
+	wlist = krealloc(wlist, wlistsize, GFP_KERNEL);
+	if (wlist == NULL) {
+		dev_err(dapm->dev, "ASoC: can't allocate widget list for %s\n",
+			w->name);
+		return -ENOMEM;
+	}
+	wlist->num_widgets = wlistentries;
+	wlist->widgets[wlistentries - 1] = w;
 
-			if (w->kcontrols[i]) {
-				path->kcontrol = w->kcontrols[i];
-				continue;
+	if (!kcontrol) {
+		if (shared) {
+			wname_in_long_name = false;
+			kcname_in_long_name = true;
+		} else {
+			switch (w->id) {
+			case snd_soc_dapm_switch:
+			case snd_soc_dapm_mixer:
+				wname_in_long_name = true;
+				kcname_in_long_name = true;
+				break;
+			case snd_soc_dapm_mixer_named_ctl:
+				wname_in_long_name = false;
+				kcname_in_long_name = true;
+				break;
+			case snd_soc_dapm_mux:
+			case snd_soc_dapm_virt_mux:
+			case snd_soc_dapm_value_mux:
+				wname_in_long_name = true;
+				kcname_in_long_name = false;
+				break;
+			default:
+				kfree(wlist);
+				return -EINVAL;
 			}
+		}
+
+		if (wname_in_long_name && kcname_in_long_name) {
+			name_len = strlen(w->name) - prefix_len + 1 +
+				   strlen(w->kcontrol_news[kci].name) + 1;
 
-			wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
-				    sizeof(struct snd_soc_dapm_widget *),
-			wlist = kzalloc(wlistsize, GFP_KERNEL);
-			if (wlist == NULL) {
-				dev_err(dapm->dev,
-					"ASoC: can't allocate widget list for %s\n",
-					w->name);
+			long_name = kmalloc(name_len, GFP_KERNEL);
+			if (long_name == NULL) {
+				kfree(wlist);
 				return -ENOMEM;
 			}
-			wlist->num_widgets = 1;
-			wlist->widgets[0] = w;
-
-			/* add dapm control with long name.
-			 * for dapm_mixer this is the concatenation of the
-			 * mixer and kcontrol name.
-			 * for dapm_mixer_named_ctl this is simply the
-			 * kcontrol name.
+
+			/*
+			 * The control will get a prefix from the control
+			 * creation process but we're also using the same
+			 * prefix for widgets so cut the prefix off the
+			 * front of the widget name.
 			 */
-			name_len = strlen(w->kcontrol_news[i].name) + 1;
-			if (w->id != snd_soc_dapm_mixer_named_ctl)
-				name_len += 1 + strlen(w->name);
+			snprintf(long_name, name_len, "%s %s",
+				 w->name + prefix_len,
+				 w->kcontrol_news[kci].name);
+			long_name[name_len - 1] = '\0';
+
+			name = long_name;
+		} else if (wname_in_long_name) {
+			long_name = NULL;
+			name = w->name + prefix_len;
+		} else {
+			long_name = NULL;
+			name = w->kcontrol_news[kci].name;
+		}
 
-			path->long_name = kmalloc(name_len, GFP_KERNEL);
+		kcontrol = snd_soc_cnew(&w->kcontrol_news[kci], wlist, name,
+					prefix);
+		ret = snd_ctl_add(card, kcontrol);
+		if (ret < 0) {
+			dev_err(dapm->dev,
+				"ASoC: failed to add widget %s dapm kcontrol %s: %d\n",
+				w->name, name, ret);
+			kfree(wlist);
+			kfree(long_name);
+			return ret;
+		}
 
-			if (path->long_name == NULL) {
-				kfree(wlist);
-				return -ENOMEM;
-			}
+		path->long_name = long_name;
+	}
 
-			switch (w->id) {
-			default:
-				/* The control will get a prefix from
-				 * the control creation process but
-				 * we're also using the same prefix
-				 * for widgets so cut the prefix off
-				 * the front of the widget name.
-				 */
-				snprintf((char *)path->long_name, name_len,
-					 "%s %s", w->name + prefix_len,
-					 w->kcontrol_news[i].name);
-				break;
-			case snd_soc_dapm_mixer_named_ctl:
-				snprintf((char *)path->long_name, name_len,
-					 "%s", w->kcontrol_news[i].name);
-				break;
-			}
+	kcontrol->private_data = wlist;
+	w->kcontrols[kci] = kcontrol;
+	path->kcontrol = kcontrol;
 
-			((char *)path->long_name)[name_len - 1] = '\0';
+	return 0;
+}
 
-			path->kcontrol = snd_soc_cnew(&w->kcontrol_news[i],
-						      wlist, path->long_name,
-						      prefix);
-			ret = snd_ctl_add(card, path->kcontrol);
-			if (ret < 0) {
-				dev_err(dapm->dev, "ASoC: failed to add widget"
-					" %s dapm kcontrol %s: %d\n",
-					w->name, path->long_name, ret);
-				kfree(wlist);
-				kfree(path->long_name);
-				path->long_name = NULL;
-				return ret;
+/* create new dapm mixer control */
+static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
+{
+	int i, ret;
+	struct snd_soc_dapm_path *path;
+
+	/* add kcontrol */
+	for (i = 0; i < w->num_kcontrols; i++) {
+		/* match name */
+		list_for_each_entry(path, &w->sources, list_sink) {
+			/* mixer/mux paths name must match control name */
+			if (path->name != (char *)w->kcontrol_news[i].name)
+				continue;
+
+			if (w->kcontrols[i]) {
+				path->kcontrol = w->kcontrols[i];
+				continue;
 			}
-			w->kcontrols[i] = path->kcontrol;
+
+			ret = dapm_create_or_share_mixmux_kcontrol(w, i, path);
+			if (ret < 0)
+				return ret;
 		}
 	}
-	return ret;
+
+	return 0;
 }
 
 /* create new dapm mux control */
 static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct snd_soc_dapm_path *path = NULL;
-	struct snd_kcontrol *kcontrol;
-	struct snd_card *card = dapm->card->snd_card;
-	const char *prefix;
-	size_t prefix_len;
+	struct snd_soc_dapm_path *path;
 	int ret;
-	struct snd_soc_dapm_widget_list *wlist;
-	int shared, wlistentries;
-	size_t wlistsize;
-	const char *name;
 
 	if (w->num_kcontrols != 1) {
 		dev_err(dapm->dev,
@@ -631,65 +679,19 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 		return -EINVAL;
 	}
 
-	shared = dapm_is_shared_kcontrol(dapm, w, &w->kcontrol_news[0],
-					 &kcontrol);
-	if (kcontrol) {
-		wlist = kcontrol->private_data;
-		wlistentries = wlist->num_widgets + 1;
-	} else {
-		wlist = NULL;
-		wlistentries = 1;
-	}
-	wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
-		wlistentries * sizeof(struct snd_soc_dapm_widget *),
-	wlist = krealloc(wlist, wlistsize, GFP_KERNEL);
-	if (wlist == NULL) {
-		dev_err(dapm->dev,
-			"ASoC: can't allocate widget list for %s\n", w->name);
-		return -ENOMEM;
-	}
-	wlist->num_widgets = wlistentries;
-	wlist->widgets[wlistentries - 1] = w;
-
-	if (!kcontrol) {
-		if (dapm->codec)
-			prefix = dapm->codec->name_prefix;
-		else
-			prefix = NULL;
-
-		if (shared) {
-			name = w->kcontrol_news[0].name;
-			prefix_len = 0;
-		} else {
-			name = w->name;
-			if (prefix)
-				prefix_len = strlen(prefix) + 1;
-			else
-				prefix_len = 0;
-		}
-
-		/*
-		 * The control will get a prefix from the control creation
-		 * process but we're also using the same prefix for widgets so
-		 * cut the prefix off the front of the widget name.
-		 */
-		kcontrol = snd_soc_cnew(&w->kcontrol_news[0], wlist,
-					name + prefix_len, prefix);
-		ret = snd_ctl_add(card, kcontrol);
-		if (ret < 0) {
-			dev_err(dapm->dev, "ASoC: failed to add kcontrol %s: %d\n",
-				w->name, ret);
-			kfree(wlist);
-			return ret;
-		}
+	path = list_first_entry(&w->sources, struct snd_soc_dapm_path,
+				list_sink);
+	if (!path) {
+		dev_err(dapm->dev, "ASoC: mux %s has no paths\n", w->name);
+		return -EINVAL;
 	}
 
-	kcontrol->private_data = wlist;
-
-	w->kcontrols[0] = kcontrol;
+	ret = dapm_create_or_share_mixmux_kcontrol(w, 0, path);
+	if (ret < 0)
+		return ret;
 
 	list_for_each_entry(path, &w->sources, list_sink)
-		path->kcontrol = kcontrol;
+		path->kcontrol = w->kcontrols[0];
 
 	return 0;
 }
-- 
1.7.10.4
