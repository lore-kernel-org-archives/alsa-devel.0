From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: Split DAPM power checks from
	sequencing of power changes
Date: Mon, 18 May 2009 16:05:55 +0100
Message-ID: <1242659158-1701-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1242659158-1701-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C725324458
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 17:06:08 +0200 (CEST)
In-Reply-To: <1242659158-1701-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

DAPM has always applied any changes to the power state of widgets as soon
as it has determined that they are required. Instead of doing this store
all the changes that are required on lists of widgets to power up and
down, then iterate over those lists and apply the changes. This changes
the sequence in which changes are implemented, doing all power downs
before power ups and always using the up/down sequences (previously they
were only used when changes were due to DAC/ADC power events). The error
handling is also changed so that we continue attempting to power widgets
if some changes fail.

The main benefit of this is to allow future changes to do optimisations
over the whole power sequence and to reduce the number of walks of the
widget graph required to check the power status of widgets.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    3 ++
 include/sound/soc.h      |    2 +
 sound/soc/soc-dapm.c     |   81 +++++++++++++++++++++++++++++++--------------
 3 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 533f9f2..b3f789d 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -385,6 +385,9 @@ struct snd_soc_dapm_widget {
 	/* widget input and outputs */
 	struct list_head sources;
 	struct list_head sinks;
+
+	/* used during DAPM updates */
+	struct list_head power_list;
 };
 
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6ab80bf..8309ce8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -372,6 +372,8 @@ struct snd_soc_codec {
 	enum snd_soc_bias_level bias_level;
 	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
+	struct list_head up_list;
+	struct list_head down_list;
 
 	/* codec DAI's */
 	struct snd_soc_dai *dai;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7847f80..04ef841 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -658,7 +658,7 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 			     struct snd_soc_dapm_widget *w)
 {
-	int power, ret;
+	int ret;
 
 	switch (w->id) {
 	case snd_soc_dapm_pre:
@@ -696,18 +696,8 @@ static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 		return 0;
 
 	default:
-		break;
+		return dapm_generic_apply_power(w);
 	}
-
-	if (!w->power_check)
-		return 0;
-
-	power = w->power_check(w);
-	if (w->power == power)
-		return 0;
-	w->power = power;
-
-	return dapm_generic_apply_power(w);
 }
 
 /*
@@ -722,27 +712,68 @@ static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 {
 	struct snd_soc_dapm_widget *w;
-	int i, c = 1, *seq = NULL, ret = 0;
-
-	/* do we have a sequenced stream event */
-	if (event == SND_SOC_DAPM_STREAM_START) {
-		c = ARRAY_SIZE(dapm_up_seq);
-		seq = dapm_up_seq;
-	} else if (event == SND_SOC_DAPM_STREAM_STOP) {
-		c = ARRAY_SIZE(dapm_down_seq);
-		seq = dapm_down_seq;
+	int ret = 0;
+	int i, power;
+
+	INIT_LIST_HEAD(&codec->up_list);
+	INIT_LIST_HEAD(&codec->down_list);
+
+	/* Check which widgets we need to power and store them in
+	 * lists indicating if they should be powered up or down.
+	 */
+	list_for_each_entry(w, &codec->dapm_widgets, list) {
+		switch (w->id) {
+		case snd_soc_dapm_pre:
+			list_add_tail(&codec->down_list, &w->power_list);
+			break;
+		case snd_soc_dapm_post:
+			list_add_tail(&codec->up_list, &w->power_list);
+			break;
+
+		default:
+			if (!w->power_check)
+				continue;
+
+			power = w->power_check(w);
+			if (w->power == power)
+				continue;
+
+			if (power)
+				list_add_tail(&w->power_list, &codec->up_list);
+			else
+				list_add_tail(&w->power_list,
+					      &codec->down_list);
+
+			w->power = power;
+			break;
+		}
 	}
 
-	for (i = 0; i < c; i++) {
-		list_for_each_entry(w, &codec->dapm_widgets, list) {
+	/* Power down widgets first; try to avoid amplifying pops. */
+	for (i = 0; i < ARRAY_SIZE(dapm_down_seq); i++) {
+		list_for_each_entry(w, &codec->down_list, power_list) {
+			/* is widget in stream order */
+			if (w->id != dapm_down_seq[i])
+				continue;
+
+			ret = dapm_power_widget(codec, event, w);
+			if (ret != 0)
+				pr_err("Failed to power down %s: %d\n",
+				       w->name, ret);
+		}
+	}
 
+	/* Now power up. */
+	for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++) {
+		list_for_each_entry(w, &codec->up_list, power_list) {
 			/* is widget in stream order */
-			if (seq && seq[i] && w->id != seq[i])
+			if (w->id != dapm_up_seq[i])
 				continue;
 
 			ret = dapm_power_widget(codec, event, w);
 			if (ret != 0)
-				return ret;
+				pr_err("Failed to power up %s: %d\n",
+				       w->name, ret);
 		}
 	}
 
-- 
1.6.3.1
