From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Specify target bias state directly
	as a bias state
Date: Mon,  6 Jun 2011 14:41:45 +0100
Message-ID: <1307367706-1325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65C5D24497
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 15:41:50 +0200 (CEST)
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

Rather than a simple flag to say if we want the DAPM context to be at full
power specify the target bias state. This should have no current effect
but is a bit more direct and so makes it easier to change our decisions
about the which bias state to go into in future.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 +-
 include/sound/soc.h      |    8 +++---
 sound/soc/soc-dapm.c     |   60 +++++++++++++++++++++++++--------------------
 3 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c46e7d8..7415878 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -510,7 +510,7 @@ struct snd_soc_dapm_context {
 	struct snd_soc_card *card; /* parent card */
 
 	/* used during DAPM updates */
-	int dev_power;
+	enum snd_soc_bias_level target_bias_level;
 	struct list_head list;
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/sound/soc.h b/include/sound/soc.h
index f1de3e0..0f29700 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -214,10 +214,10 @@
  * @OFF:     Power Off. No restrictions on transition times.
  */
 enum snd_soc_bias_level {
-	SND_SOC_BIAS_OFF,
-	SND_SOC_BIAS_STANDBY,
-	SND_SOC_BIAS_PREPARE,
-	SND_SOC_BIAS_ON,
+	SND_SOC_BIAS_OFF = 0,
+	SND_SOC_BIAS_STANDBY = 1,
+	SND_SOC_BIAS_PREPARE = 2,
+	SND_SOC_BIAS_ON = 3,
 };
 
 struct snd_jack;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 776e6f4..0bbded4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1042,16 +1042,17 @@ static void dapm_pre_sequence_async(void *data, async_cookie_t cookie)
 	struct snd_soc_dapm_context *d = data;
 	int ret;
 
-	if (d->dev_power && d->bias_level == SND_SOC_BIAS_OFF) {
+	/* If we're off and we're not supposed to be go into STANDBY */
+	if (d->bias_level == SND_SOC_BIAS_OFF &&
+	    d->target_bias_level != SND_SOC_BIAS_OFF) {
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
 			dev_err(d->dev,
 				"Failed to turn on bias: %d\n", ret);
 	}
 
-	/* If we're changing to all on or all off then prepare */
-	if ((d->dev_power && d->bias_level == SND_SOC_BIAS_STANDBY) ||
-	    (!d->dev_power && d->bias_level == SND_SOC_BIAS_ON)) {
+	/* Prepare for a STADDBY->ON or ON->STANDBY transition */
+	if (d->bias_level != d->target_bias_level) {
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_PREPARE);
 		if (ret != 0)
 			dev_err(d->dev,
@@ -1068,7 +1069,9 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
 	int ret;
 
 	/* If we just powered the last thing off drop to standby bias */
-	if (d->bias_level == SND_SOC_BIAS_PREPARE && !d->dev_power) {
+	if (d->bias_level == SND_SOC_BIAS_PREPARE &&
+	    (d->target_bias_level == SND_SOC_BIAS_STANDBY ||
+	     d->target_bias_level == SND_SOC_BIAS_OFF)) {
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
 			dev_err(d->dev, "Failed to apply standby bias: %d\n",
@@ -1076,14 +1079,16 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
 	}
 
 	/* If we're in standby and can support bias off then do that */
-	if (d->bias_level == SND_SOC_BIAS_STANDBY && d->idle_bias_off) {
+	if (d->bias_level == SND_SOC_BIAS_STANDBY &&
+	    d->target_bias_level == SND_SOC_BIAS_OFF) {
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_OFF);
 		if (ret != 0)
 			dev_err(d->dev, "Failed to turn off bias: %d\n", ret);
 	}
 
 	/* If we just powered up then move to active bias */
-	if (d->bias_level == SND_SOC_BIAS_PREPARE && d->dev_power) {
+	if (d->bias_level == SND_SOC_BIAS_PREPARE &&
+	    d->target_bias_level == SND_SOC_BIAS_ON) {
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_ON);
 		if (ret != 0)
 			dev_err(d->dev, "Failed to apply active bias: %d\n",
@@ -1108,13 +1113,19 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	LIST_HEAD(up_list);
 	LIST_HEAD(down_list);
 	LIST_HEAD(async_domain);
+	enum snd_soc_bias_level bias;
 	int power;
 
 	trace_snd_soc_dapm_start(card);
 
-	list_for_each_entry(d, &card->dapm_list, list)
-		if (d->n_widgets || d->codec == NULL)
-			d->dev_power = 0;
+	list_for_each_entry(d, &card->dapm_list, list) {
+		if (d->n_widgets || d->codec == NULL) {
+			if (d->idle_bias_off)
+				d->target_bias_level = SND_SOC_BIAS_OFF;
+			else
+				d->target_bias_level = SND_SOC_BIAS_STANDBY;
+		}
+	}
 
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
@@ -1137,7 +1148,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			else
 				power = 1;
 			if (power)
-				w->dapm->dev_power = 1;
+				w->dapm->target_bias_level = SND_SOC_BIAS_ON;
 
 			if (w->power == power)
 				continue;
@@ -1161,24 +1172,19 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		switch (event) {
 		case SND_SOC_DAPM_STREAM_START:
 		case SND_SOC_DAPM_STREAM_RESUME:
-			dapm->dev_power = 1;
+			dapm->target_bias_level = SND_SOC_BIAS_ON;
 			break;
 		case SND_SOC_DAPM_STREAM_STOP:
-			dapm->dev_power = !!dapm->codec->active;
+			if (dapm->codec->active)
+				dapm->target_bias_level = SND_SOC_BIAS_ON;
+			else
+				dapm->target_bias_level = SND_SOC_BIAS_STANDBY;
 			break;
 		case SND_SOC_DAPM_STREAM_SUSPEND:
-			dapm->dev_power = 0;
+			dapm->target_bias_level = SND_SOC_BIAS_STANDBY;
 			break;
 		case SND_SOC_DAPM_STREAM_NOP:
-			switch (dapm->bias_level) {
-				case SND_SOC_BIAS_STANDBY:
-				case SND_SOC_BIAS_OFF:
-					dapm->dev_power = 0;
-					break;
-				default:
-					dapm->dev_power = 1;
-					break;
-			}
+			dapm->target_bias_level = dapm->bias_level;
 			break;
 		default:
 			break;
@@ -1186,12 +1192,12 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	}
 
 	/* Force all contexts in the card to the same bias state */
-	power = 0;
+	bias = SND_SOC_BIAS_OFF;
 	list_for_each_entry(d, &card->dapm_list, list)
-		if (d->dev_power)
-			power = 1;
+		if (d->target_bias_level > bias)
+			bias = d->target_bias_level;
 	list_for_each_entry(d, &card->dapm_list, list)
-		d->dev_power = power;
+		d->target_bias_level = bias;
 
 
 	/* Run all the bias changes in parallel */
-- 
1.7.5.3
