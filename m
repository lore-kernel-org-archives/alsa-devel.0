From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/8] ASoC: dapm: Refactor
	snd_soc_dapm_new_widget() to return the widget
Date: Thu, 16 Feb 2012 21:56:05 -0800
Message-ID: <1329458170-22119-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 103CD103A40
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 06:56:17 +0100 (CET)
In-Reply-To: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Let the caller fiddle with the widget after we're done in order to
facilitate further refactoring.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   35 ++++++++++++++---------------------
 1 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c7032fa..bfaa9d2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2701,24 +2701,16 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
 
-/**
- * snd_soc_dapm_new_control - create new dapm control
- * @dapm: DAPM context
- * @widget: widget template
- *
- * Creates a new dapm control based upon the template.
- *
- * Returns 0 for success else error.
- */
-static int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
-				    const struct snd_soc_dapm_widget *widget)
+static struct snd_soc_dapm_widget *
+snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
+			 const struct snd_soc_dapm_widget *widget)
 {
 	struct snd_soc_dapm_widget *w;
 	size_t name_len;
 	int ret;
 
 	if ((w = dapm_cnew_widget(widget)) == NULL)
-		return -ENOMEM;
+		return NULL;
 
 	switch (w->id) {
 	case snd_soc_dapm_regulator_supply:
@@ -2727,7 +2719,7 @@ static int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 			ret = PTR_ERR(w->priv);
 			dev_err(dapm->dev, "Failed to request %s: %d\n",
 				w->name, ret);
-			return ret;
+			return NULL;
 		}
 		break;
 	default:
@@ -2740,7 +2732,7 @@ static int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	w->name = kmalloc(name_len, GFP_KERNEL);
 	if (w->name == NULL) {
 		kfree(w);
-		return -ENOMEM;
+		return NULL;
 	}
 	if (dapm->codec && dapm->codec->name_prefix)
 		snprintf(w->name, name_len, "%s %s",
@@ -2799,7 +2791,7 @@ static int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 
 	/* machine layer set ups unconnected pins and insertions */
 	w->connected = 1;
-	return 0;
+	return w;
 }
 
 /**
@@ -2816,15 +2808,16 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget,
 	int num)
 {
-	int i, ret;
+	struct snd_soc_dapm_widget *w;
+	int i;
 
 	for (i = 0; i < num; i++) {
-		ret = snd_soc_dapm_new_control(dapm, widget);
-		if (ret < 0) {
+		w = snd_soc_dapm_new_control(dapm, widget);
+		if (!w) {
 			dev_err(dapm->dev,
-				"ASoC: Failed to create DAPM control %s: %d\n",
-				widget->name, ret);
-			return ret;
+				"ASoC: Failed to create DAPM control %s\n",
+				widget->name);
+			return -ENOMEM;
 		}
 		widget++;
 	}
-- 
1.7.9.rc1
