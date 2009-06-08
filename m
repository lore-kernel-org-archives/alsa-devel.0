From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/7] ASoC: Factor out DAPM sequence execution
Date: Mon,  8 Jun 2009 15:28:48 +0100
Message-ID: <1244471333-6485-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090608142734.GA6137@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A1CF72445E
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 16:28:58 +0200 (CEST)
In-Reply-To: <20090608142734.GA6137@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Lump the list walk into a single function, and pull in the power
application too so we can do some further refactoring. Pure code
motion.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |  122 +++++++++++++++++++++++++-------------------------
 1 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1b38e21..257d4f1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -707,55 +707,6 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 	return power;
 }
 
-/*
- * Scan a single DAPM widget for a complete audio path and update the
- * power status appropriately.
- */
-static int dapm_power_widget(struct snd_soc_codec *codec, int event,
-			     struct snd_soc_dapm_widget *w)
-{
-	int ret;
-
-	switch (w->id) {
-	case snd_soc_dapm_pre:
-		if (!w->event)
-			return 0;
-
-		if (event == SND_SOC_DAPM_STREAM_START) {
-			ret = w->event(w,
-				       NULL, SND_SOC_DAPM_PRE_PMU);
-			if (ret < 0)
-				return ret;
-		} else if (event == SND_SOC_DAPM_STREAM_STOP) {
-			ret = w->event(w,
-				       NULL, SND_SOC_DAPM_PRE_PMD);
-			if (ret < 0)
-				return ret;
-		}
-		return 0;
-
-	case snd_soc_dapm_post:
-		if (!w->event)
-			return 0;
-
-		if (event == SND_SOC_DAPM_STREAM_START) {
-			ret = w->event(w,
-				       NULL, SND_SOC_DAPM_POST_PMU);
-			if (ret < 0)
-				return ret;
-		} else if (event == SND_SOC_DAPM_STREAM_STOP) {
-			ret = w->event(w,
-				       NULL, SND_SOC_DAPM_POST_PMD);
-			if (ret < 0)
-				return ret;
-		}
-		return 0;
-
-	default:
-		return dapm_generic_apply_power(w);
-	}
-}
-
 static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
 			    struct snd_soc_dapm_widget *b,
 			    int sort[])
@@ -782,6 +733,65 @@ static void dapm_seq_insert(struct snd_soc_dapm_widget *new_widget,
 	list_add_tail(&new_widget->power_list, list);
 }
 
+/* Apply a DAPM power sequence */
+static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
+			 int event)
+{
+	struct snd_soc_dapm_widget *w;
+	int ret;
+
+	list_for_each_entry(w, list, power_list) {
+		switch (w->id) {
+		case snd_soc_dapm_pre:
+			if (!w->event)
+				list_for_each_entry_continue(w, list,
+							     power_list);
+
+			if (event == SND_SOC_DAPM_STREAM_START) {
+				ret = w->event(w,
+					       NULL, SND_SOC_DAPM_PRE_PMU);
+				if (ret < 0)
+					pr_err("PRE widget failed: %d\n",
+					       ret);
+			} else if (event == SND_SOC_DAPM_STREAM_STOP) {
+				ret = w->event(w,
+					       NULL, SND_SOC_DAPM_PRE_PMD);
+				if (ret < 0)
+					pr_err("PRE widget failed: %d\n",
+					       ret);
+			}
+			break;
+
+		case snd_soc_dapm_post:
+			if (!w->event)
+				list_for_each_entry_continue(w, list,
+							     power_list);
+
+			if (event == SND_SOC_DAPM_STREAM_START) {
+				ret = w->event(w,
+					       NULL, SND_SOC_DAPM_POST_PMU);
+				if (ret < 0)
+					pr_err("POST widget failed: %d\n",
+					       ret);
+			} else if (event == SND_SOC_DAPM_STREAM_STOP) {
+				ret = w->event(w,
+					       NULL, SND_SOC_DAPM_POST_PMD);
+				if (ret < 0)
+					pr_err("POST widget failed: %d\n",
+					       ret);
+			}
+			break;
+
+		default:
+			ret = dapm_generic_apply_power(w);
+			if (ret < 0)
+				pr_err("Failed to apply widget power: %d\n",
+				       ret);
+			break;
+		}
+	}
+}
+
 /*
  * Scan each dapm widget for complete audio path.
  * A complete path is a route that has valid endpoints i.e.:-
@@ -847,20 +857,10 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	}
 
 	/* Power down widgets first; try to avoid amplifying pops. */
-	list_for_each_entry(w, &codec->down_list, power_list) {
-		ret = dapm_power_widget(codec, event, w);
-		if (ret != 0)
-			pr_err("Failed to power down %s: %d\n",
-			       w->name, ret);
-	}
+	dapm_seq_run(codec, &codec->down_list, event);
 
 	/* Now power up. */
-	list_for_each_entry(w, &codec->up_list, power_list) {
-		ret = dapm_power_widget(codec, event, w);
-		if (ret != 0)
-			pr_err("Failed to power up %s: %d\n",
-			       w->name, ret);
-	}
+	dapm_seq_run(codec, &codec->up_list, event);
 
 	/* If we just powered the last thing off drop to standby bias */
 	if (codec->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
-- 
1.6.3.1
