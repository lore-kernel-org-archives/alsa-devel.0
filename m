From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 4/4] ASoC: Implement mux control sharing
Date: Thu, 28 Apr 2011 17:38:01 -0600
Message-ID: <1304033881-1160-5-git-send-email-swarren@nvidia.com>
References: <1304033881-1160-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A6B91039CA
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 01:38:15 +0200 (CEST)
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

Control sharing is enabled when two widgets include pointers to the
same kcontrol_new in their definition. Specifically:

static const struct snd_kcontrol_new adcinput_mux =
	SOC_DAPM_ENUM("ADC Input", adcinput_enum);

static const struct snd_soc_dapm_widget wm8903_dapm_widgets[] = {
  SND_SOC_DAPM_MUX("Left ADC Input", SND_SOC_NOPM, 0, 0, &adcinput_mux),
  SND_SOC_DAPM_MUX("Right ADC Input", SND_SOC_NOPM, 0, 0, &adcinput_mux),
};

This is useful when a single register bit or field affects multiple
muxes at once. The common case is to have separate control bits or
fields for each mux (channel). An alternative way of looking at this
is that the mux is a stereo (or even n-channel) mux, rather than
independant mono muxes.

Without this change, a separate kcontrol will be created for each
DAPM_MUX. This has the following disadvantages:

* Confuses the user/programmer with redundant controls that don't
  map to separate hardware.

* When one of the controls is changed, ASoC fails to update the DAPM
  logic for paths solely affected by the other controls impacted by
  the same register bits. This causes some paths not to be correctly
  powered up or down. Prior to this change, to work around this, the
  user or programmer had to manually toggle all duplicate controls away
  from the intended setting, and then back to it.

Control sharing implies that the control is named based on the
kcontrol_new itself, not any of the widgets that are affected by it.

Control sharing is implemented by: When creating kcontrols, if a
kcontrol does not yet exist for a particular kcontrol_new, then a new
kcontrol is created with a list of widgets containing just a single
entry. This is the normal case. However, if a kcontrol does already
exists for the given kcontrol_new, the current widget is simply added
to that kcontrol's list of affected widgets.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-dapm.c |  106 +++++++++++++++++++++++++++++++++++---------------
 1 files changed, 75 insertions(+), 31 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e140618..77e6934 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -324,6 +324,28 @@ static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 	return -ENODEV;
 }
 
+static int dapm_is_shared_kcontrol(struct snd_soc_dapm_context *dapm,
+	const struct snd_kcontrol_new *kcontrol_new,
+	struct snd_kcontrol **kcontrol)
+{
+	struct snd_soc_dapm_widget *w;
+	int i;
+
+	*kcontrol = NULL;
+
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		for (i = 0; i < w->num_kcontrols; i++) {
+			if (&w->kcontrol_news[i] == kcontrol_new) {
+				if (w->kcontrols)
+					*kcontrol = w->kcontrols[i];
+				return 1;
+			}
+		}
+	}
+
+	return 0;
+}
+
 /* create new dapm mixer control */
 static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w)
@@ -433,58 +455,80 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	struct snd_card *card = dapm->card->snd_card;
 	const char *prefix;
 	size_t prefix_len;
-	int ret = 0;
+	int ret;
 	struct snd_soc_dapm_widget_list *wlist;
+	int shared, wlistentries;
 	size_t wlistsize;
+	char *name;
 
-	if (!w->num_kcontrols) {
-		dev_err(dapm->dev, "asoc: mux %s has no controls\n", w->name);
+	if (w->num_kcontrols != 1) {
+		dev_err(dapm->dev,
+			"asoc: mux %s has incorrect number of controls\n",
+			w->name);
 		return -EINVAL;
 	}
 
+	shared = dapm_is_shared_kcontrol(dapm, &w->kcontrol_news[0],
+					 &kcontrol);
+	if (kcontrol) {
+		wlist = kcontrol->private_data;
+		wlistentries = wlist->num_widgets + 1;
+	} else {
+		wlist = NULL;
+		wlistentries = 1;
+	}
 	wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
-		    sizeof(struct snd_soc_dapm_widget *),
-	wlist = kzalloc(wlistsize, GFP_KERNEL);
+		wlistentries * sizeof(struct snd_soc_dapm_widget *),
+	wlist = krealloc(wlist, wlistsize, GFP_KERNEL);
 	if (wlist == NULL) {
 		dev_err(dapm->dev,
 			"asoc: can't allocate widget list for %s\n", w->name);
 		return -ENOMEM;
 	}
-	wlist->num_widgets = 1;
-	wlist->widgets[0] = w;
-
-	if (dapm->codec)
-		prefix = dapm->codec->name_prefix;
-	else
-		prefix = NULL;
+	wlist->num_widgets = wlistentries;
+	wlist->widgets[wlistentries - 1] = w;
 
-	if (prefix)
-		prefix_len = strlen(prefix) + 1;
-	else
-		prefix_len = 0;
+	if (!kcontrol) {
+		if (dapm->codec)
+			prefix = dapm->codec->name_prefix;
+		else
+			prefix = NULL;
+
+		if (shared) {
+			name = w->kcontrol_news[0].name;
+			prefix_len = 0;
+		} else {
+			name = w->name;
+			if (prefix)
+				prefix_len = strlen(prefix) + 1;
+			else
+				prefix_len = 0;
+		}
 
-	/* The control will get a prefix from the control creation
-	 * process but we're also using the same prefix for widgets so
-	 * cut the prefix off the front of the widget name.
-	 */
-	kcontrol = snd_soc_cnew(&w->kcontrol_news[0], wlist,
-				w->name + prefix_len, prefix);
-	ret = snd_ctl_add(card, kcontrol);
+		/*
+		 * The control will get a prefix from the control creation
+		 * process but we're also using the same prefix for widgets so
+		 * cut the prefix off the front of the widget name.
+		 */
+		kcontrol = snd_soc_cnew(&w->kcontrol_news[0], wlist,
+					name + prefix_len, prefix);
+		ret = snd_ctl_add(card, kcontrol);
+		if (ret < 0) {
+			dev_err(dapm->dev,
+				"asoc: failed to add kcontrol %s\n", w->name);
+			kfree(wlist);
+			return ret;
+		}
+	}
 
-	if (ret < 0)
-		goto err;
+	kcontrol->private_data = wlist;
 
 	w->kcontrols[0] = kcontrol;
 
 	list_for_each_entry(path, &w->sources, list_sink)
 		path->kcontrol = kcontrol;
 
-	return ret;
-
-err:
-	dev_err(dapm->dev, "asoc: failed to add kcontrol %s\n", w->name);
-	kfree(wlist);
-	return ret;
+	return 0;
 }
 
 /* create new dapm volume control */
-- 
1.7.0.4
