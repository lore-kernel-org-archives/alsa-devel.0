From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Add dapm_find_widget helper
Date: Wed, 27 Apr 2011 18:34:31 +0200
Message-ID: <1303922071-23466-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-147.synserver.de
	[212.40.185.147]) by alsa0.perex.cz (Postfix) with SMTP id 81BEA24156
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 18:34:49 +0200 (CEST)
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

This patch adds a helper function for searching DAPM widgets by name.
This allows to streamline functions which operate on widgets by name.
It also allows to get rid of copy'n'pasted code which was added to fallback to
widgets from other contexts if the widget was not found in the current context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c |  115 +++++++++++++++++++------------------------------
 1 files changed, 45 insertions(+), 70 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ba73b74..1707c41 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1434,40 +1434,43 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 	}
 }
 
-static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
-				const char *pin, int status)
+static struct snd_soc_dapm_widget *dapm_find_widget(
+			struct snd_soc_dapm_context *dapm, const char *pin,
+			bool search_other_contexts)
 {
 	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_widget *fallback = NULL;
 
 	list_for_each_entry(w, &dapm->card->widgets, list) {
-		if (w->dapm != dapm)
-			continue;
 		if (!strcmp(w->name, pin)) {
-			dev_dbg(w->dapm->dev, "dapm: pin %s = %d\n",
-				pin, status);
-			w->connected = status;
-			/* Allow disabling of forced pins */
-			if (status == 0)
-				w->force = 0;
-			return 0;
+			if (w->dapm == dapm)
+				return w;
+			else
+				fallback = w;
 		}
 	}
 
-	/* Try again in other contexts */
-	list_for_each_entry(w, &dapm->card->widgets, list) {
-		if (!strcmp(w->name, pin)) {
-			dev_dbg(w->dapm->dev, "dapm: pin %s = %d\n",
-				pin, status);
-			w->connected = status;
-			/* Allow disabling of forced pins */
-			if (status == 0)
-				w->force = 0;
-			return 0;
-		}
+	if (search_other_contexts)
+		return fallback;
+
+	return NULL;
+}
+
+static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
+				const char *pin, int status)
+{
+	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, true);
+
+	if (!w) {
+		dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
+		return -EINVAL;
 	}
 
-	dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
-	return -EINVAL;
+	w->connected = status;
+	if (status == 0)
+		w->force = 0;
+
+	return 0;
 }
 
 /**
@@ -2283,33 +2286,18 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_enable_pin);
 int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 				  const char *pin)
 {
-	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, true);
 
-	list_for_each_entry(w, &dapm->card->widgets, list) {
-		if (w->dapm != dapm)
-			continue;
-		if (!strcmp(w->name, pin)) {
-			dev_dbg(w->dapm->dev,
-				"dapm: force enable pin %s\n", pin);
-			w->connected = 1;
-			w->force = 1;
-			return 0;
-		}
+	if (!w) {
+		dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
+		return -EINVAL;
 	}
 
-	/* Try again with other contexts */
-	list_for_each_entry(w, &dapm->card->widgets, list) {
-		if (!strcmp(w->name, pin)) {
-			dev_dbg(w->dapm->dev,
-				"dapm: force enable pin %s\n", pin);
-			w->connected = 1;
-			w->force = 1;
-			return 0;
-		}
-	}
+	dev_dbg(w->dapm->dev, "dapm: force enable pin %s\n", pin);
+	w->connected = 1;
+	w->force = 1;
 
-	dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
-	return -EINVAL;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_force_enable_pin);
 
@@ -2361,20 +2349,10 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_nc_pin);
 int snd_soc_dapm_get_pin_status(struct snd_soc_dapm_context *dapm,
 				const char *pin)
 {
-	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, true);
 
-	list_for_each_entry(w, &dapm->card->widgets, list) {
-		if (w->dapm != dapm)
-			continue;
-		if (!strcmp(w->name, pin))
-			return w->connected;
-	}
-
-	/* Try again in other contexts */
-	list_for_each_entry(w, &dapm->card->widgets, list) {
-		if (!strcmp(w->name, pin))
-			return w->connected;
-	}
+	if (w)
+		return w->connected;
 
 	return 0;
 }
@@ -2394,19 +2372,16 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_pin_status);
 int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 				const char *pin)
 {
-	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, false);
 
-	list_for_each_entry(w, &dapm->card->widgets, list) {
-		if (w->dapm != dapm)
-			continue;
-		if (!strcmp(w->name, pin)) {
-			w->ignore_suspend = 1;
-			return 0;
-		}
+	if (!w) {
+		dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
+		return -EINVAL;
 	}
 
-	dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
-	return -EINVAL;
+	w->ignore_suspend = 1;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
 
-- 
1.7.2.5
