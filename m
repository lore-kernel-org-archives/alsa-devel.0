From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: Sort DAPM power sequences while
	building lists
Date: Mon,  8 Jun 2009 15:28:47 +0100
Message-ID: <1244471333-6485-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090608142734.GA6137@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1F8B24457
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 16:28:57 +0200 (CEST)
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

In the past the DAPM power sequencing was done by iterating over the list
of widgets once for each widget type and powering widgets of that type.
Instead of doing that do the sorting at the time we insert the widgets
into the lists of widgets to apply power changes to. This reduces the
amount of computation required for seqencing still further, though the
costs are generally dwarfed by the costs of the register writes
implementing them.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |  109 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 21c6907..1b38e21 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -52,19 +52,37 @@
 
 /* dapm power sequences - make this per codec in the future */
 static int dapm_up_seq[] = {
-	snd_soc_dapm_pre, snd_soc_dapm_supply, snd_soc_dapm_micbias,
-	snd_soc_dapm_mic, snd_soc_dapm_mux, snd_soc_dapm_value_mux,
-	snd_soc_dapm_dac, snd_soc_dapm_mixer, snd_soc_dapm_mixer_named_ctl,
-	snd_soc_dapm_pga, snd_soc_dapm_adc, snd_soc_dapm_hp, snd_soc_dapm_spk,
-	snd_soc_dapm_post
+	[snd_soc_dapm_pre] = 0,
+	[snd_soc_dapm_supply] = 1,
+	[snd_soc_dapm_micbias] = 2,
+	[snd_soc_dapm_mic] = 3,
+	[snd_soc_dapm_mux] = 4,
+	[snd_soc_dapm_value_mux] = 5,
+	[snd_soc_dapm_dac] = 6,
+	[snd_soc_dapm_mixer] = 7,
+	[snd_soc_dapm_mixer_named_ctl] = 8,
+	[snd_soc_dapm_pga] = 9,
+	[snd_soc_dapm_adc] = 10,
+	[snd_soc_dapm_hp] = 11,
+	[snd_soc_dapm_spk] = 12,
+	[snd_soc_dapm_post] = 13,
 };
 
 static int dapm_down_seq[] = {
-	snd_soc_dapm_pre, snd_soc_dapm_adc, snd_soc_dapm_hp, snd_soc_dapm_spk,
-	snd_soc_dapm_pga, snd_soc_dapm_mixer_named_ctl, snd_soc_dapm_mixer,
-	snd_soc_dapm_dac, snd_soc_dapm_mic, snd_soc_dapm_micbias,
-	snd_soc_dapm_mux, snd_soc_dapm_value_mux, snd_soc_dapm_supply,
-	snd_soc_dapm_post
+	[snd_soc_dapm_pre] = 0,
+	[snd_soc_dapm_adc] = 1,
+	[snd_soc_dapm_hp] = 2,
+	[snd_soc_dapm_spk] = 3,
+	[snd_soc_dapm_pga] = 4,
+	[snd_soc_dapm_mixer_named_ctl] = 5,
+	[snd_soc_dapm_mixer] = 6,
+	[snd_soc_dapm_dac] = 7,
+	[snd_soc_dapm_mic] = 8,
+	[snd_soc_dapm_micbias] = 9,
+	[snd_soc_dapm_mux] = 10,
+	[snd_soc_dapm_value_mux] = 11,
+	[snd_soc_dapm_supply] = 12,
+	[snd_soc_dapm_post] = 13,
 };
 
 static void pop_wait(u32 pop_time)
@@ -738,6 +756,32 @@ static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 	}
 }
 
+static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
+			    struct snd_soc_dapm_widget *b,
+			    int sort[])
+{
+	if (sort[a->id] != sort[b->id])
+		return sort[a->id] - sort[b->id];
+
+	return 0;
+}
+
+/* Insert a widget in order into a DAPM power sequence. */
+static void dapm_seq_insert(struct snd_soc_dapm_widget *new_widget,
+			    struct list_head *list,
+			    int sort[])
+{
+	struct snd_soc_dapm_widget *w;
+
+	list_for_each_entry(w, list, power_list)
+		if (dapm_seq_compare(new_widget, w, sort) < 0) {
+			list_add_tail(&new_widget->power_list, &w->power_list);
+			return;
+		}
+
+	list_add_tail(&new_widget->power_list, list);
+}
+
 /*
  * Scan each dapm widget for complete audio path.
  * A complete path is a route that has valid endpoints i.e.:-
@@ -752,7 +796,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	struct snd_soc_device *socdev = codec->socdev;
 	struct snd_soc_dapm_widget *w;
 	int ret = 0;
-	int i, power;
+	int power;
 	int sys_power = 0;
 
 	INIT_LIST_HEAD(&codec->up_list);
@@ -764,10 +808,10 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	list_for_each_entry(w, &codec->dapm_widgets, list) {
 		switch (w->id) {
 		case snd_soc_dapm_pre:
-			list_add_tail(&codec->down_list, &w->power_list);
+			dapm_seq_insert(w, &codec->down_list, dapm_down_seq);
 			break;
 		case snd_soc_dapm_post:
-			list_add_tail(&codec->up_list, &w->power_list);
+			dapm_seq_insert(w, &codec->up_list, dapm_up_seq);
 			break;
 
 		default:
@@ -782,10 +826,11 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 				continue;
 
 			if (power)
-				list_add_tail(&w->power_list, &codec->up_list);
+				dapm_seq_insert(w, &codec->up_list,
+						dapm_up_seq);
 			else
-				list_add_tail(&w->power_list,
-					      &codec->down_list);
+				dapm_seq_insert(w, &codec->down_list,
+						dapm_down_seq);
 
 			w->power = power;
 			break;
@@ -802,31 +847,19 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	}
 
 	/* Power down widgets first; try to avoid amplifying pops. */
-	for (i = 0; i < ARRAY_SIZE(dapm_down_seq); i++) {
-		list_for_each_entry(w, &codec->down_list, power_list) {
-			/* is widget in stream order */
-			if (w->id != dapm_down_seq[i])
-				continue;
-
-			ret = dapm_power_widget(codec, event, w);
-			if (ret != 0)
-				pr_err("Failed to power down %s: %d\n",
-				       w->name, ret);
-		}
+	list_for_each_entry(w, &codec->down_list, power_list) {
+		ret = dapm_power_widget(codec, event, w);
+		if (ret != 0)
+			pr_err("Failed to power down %s: %d\n",
+			       w->name, ret);
 	}
 
 	/* Now power up. */
-	for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++) {
-		list_for_each_entry(w, &codec->up_list, power_list) {
-			/* is widget in stream order */
-			if (w->id != dapm_up_seq[i])
-				continue;
-
-			ret = dapm_power_widget(codec, event, w);
-			if (ret != 0)
-				pr_err("Failed to power up %s: %d\n",
-				       w->name, ret);
-		}
+	list_for_each_entry(w, &codec->up_list, power_list) {
+		ret = dapm_power_widget(codec, event, w);
+		if (ret != 0)
+			pr_err("Failed to power up %s: %d\n",
+			       w->name, ret);
 	}
 
 	/* If we just powered the last thing off drop to standby bias */
-- 
1.6.3.1
