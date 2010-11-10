From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Factor out boiler plate for DAPM event
	generation
Date: Wed, 10 Nov 2010 16:32:19 +0000
Message-ID: <1289406739-19608-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B4402454D
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 17:33:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Make the DAPM sequence execution look a bit nicer by factoring out the
code to invoke an event into a single function since it's all the same
pretty much.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   98 +++++++++++++++++++++++++-------------------------
 1 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 450307c..5a5db3f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -726,13 +726,55 @@ static void dapm_seq_insert(struct snd_soc_dapm_widget *new_widget,
 	list_add_tail(&new_widget->power_list, list);
 }
 
+static void dapm_seq_check_event(struct snd_soc_dapm_context *dapm,
+				 struct snd_soc_dapm_widget *w, int event)
+{
+	struct snd_soc_card *card = dapm->card;
+	const char *ev_name;
+	int power, ret;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		ev_name = "PRE_PMU";
+		power = 1;
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		ev_name = "POST_PMU";
+		power = 1;
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		ev_name = "PRE_PMD";
+		power = 0;
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		ev_name = "POST_PMD";
+		power = 0;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	if (w->power != power)
+		return;
+
+	if (w->event && (w->event_flags & event)) {
+		pop_dbg(dapm->dev, card->pop_time, "pop test : %s %s\n",
+			w->name, ev_name);
+		ret = w->event(w, NULL, event);
+		if (ret < 0)
+			pr_err("%s: %s event failed: %d\n",
+			       ev_name, w->name, ret);
+	}
+}
+
 /* Apply the coalesced changes from a DAPM sequence */
 static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 				   struct list_head *pending)
 {
-	struct snd_soc_dapm_widget *w;
 	struct snd_soc_card *card = dapm->card;
-	int reg, power, ret;
+	struct snd_soc_dapm_widget *w;
+	int reg, power;
 	unsigned int value = 0;
 	unsigned int mask = 0;
 	unsigned int cur_mask;
@@ -757,29 +799,9 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 			"pop test : Queue %s: reg=0x%x, 0x%x/0x%x\n",
 			w->name, reg, value, mask);
 
-		/* power up pre event */
-		if (w->power && w->event &&
-		    (w->event_flags & SND_SOC_DAPM_PRE_PMU)) {
-			pop_dbg(dapm->dev, card->pop_time,
-				"pop test : %s PRE_PMU\n", w->name);
-			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
-			if (ret < 0)
-				dev_err(dapm->dev,
-					"%s: pre event failed: %d\n",
-					w->name, ret);
-		}
-
-		/* power down pre event */
-		if (!w->power && w->event &&
-		    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
-			pop_dbg(dapm->dev, card->pop_time,
-				"pop test : %s PRE_PMD\n", w->name);
-			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
-			if (ret < 0)
-				dev_err(dapm->dev,
-					"%s: pre event failed: %d\n",
-					w->name, ret);
-		}
+		/* Check for events */
+		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_PRE_PMU);
+		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_PRE_PMD);
 	}
 
 	if (reg >= 0) {
@@ -791,30 +813,8 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 	}
 
 	list_for_each_entry(w, pending, power_list) {
-		/* power up post event */
-		if (w->power && w->event &&
-		    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
-			pop_dbg(dapm->dev, card->pop_time,
-				"pop test : %s POST_PMU\n", w->name);
-			ret = w->event(w,
-				       NULL, SND_SOC_DAPM_POST_PMU);
-			if (ret < 0)
-				dev_err(dapm->dev,
-					"%s: post event failed: %d\n",
-					w->name, ret);
-		}
-
-		/* power down post event */
-		if (!w->power && w->event &&
-		    (w->event_flags & SND_SOC_DAPM_POST_PMD)) {
-			pop_dbg(dapm->dev, card->pop_time,
-				"pop test : %s POST_PMD\n", w->name);
-			ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
-			if (ret < 0)
-				dev_err(dapm->dev,
-					"%s: post event failed: %d\n",
-					w->name, ret);
-		}
+		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_POST_PMU);
+		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_POST_PMD);
 	}
 }
 
-- 
1.7.1
