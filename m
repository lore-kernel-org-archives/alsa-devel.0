From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Remove card from
	snd_soc_dapm_set_bias_level()
Date: Fri, 18 Feb 2011 19:55:12 +0000
Message-ID: <1298058913-22393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63FF9243E6
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 20:55:14 +0100 (CET)
In-Reply-To: <>
References: <>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We can get the card from the DAPM context so don't bother passing it as
an argument.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3bee4b2..1a932bb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -125,17 +125,17 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 
 /**
  * snd_soc_dapm_set_bias_level - set the bias level for the system
- * @card: audio device
+ * @dapm: DAPM context
  * @level: level to configure
  *
  * Configure the bias (power) levels for the SoC audio device.
  *
  * Returns 0 for success else error.
  */
-static int snd_soc_dapm_set_bias_level(struct snd_soc_card *card,
-				       struct snd_soc_dapm_context *dapm,
+static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 				       enum snd_soc_bias_level level)
 {
+	struct snd_soc_card *card = dapm->card;
 	int ret = 0;
 
 	switch (level) {
@@ -1112,7 +1112,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 
 	list_for_each_entry(d, &dapm->card->dapm_list, list) {
 		if (d->dev_power && d->bias_level == SND_SOC_BIAS_OFF) {
-			ret = snd_soc_dapm_set_bias_level(card, d,
+			ret = snd_soc_dapm_set_bias_level(d,
 							  SND_SOC_BIAS_STANDBY);
 			if (ret != 0)
 				dev_err(d->dev,
@@ -1122,7 +1122,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		/* If we're changing to all on or all off then prepare */
 		if ((d->dev_power && d->bias_level == SND_SOC_BIAS_STANDBY) ||
 		    (!d->dev_power && d->bias_level == SND_SOC_BIAS_ON)) {
-			ret = snd_soc_dapm_set_bias_level(card, d,
+			ret = snd_soc_dapm_set_bias_level(d,
 							  SND_SOC_BIAS_PREPARE);
 			if (ret != 0)
 				dev_err(d->dev,
@@ -1141,7 +1141,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	list_for_each_entry(d, &dapm->card->dapm_list, list) {
 		/* If we just powered the last thing off drop to standby bias */
 		if (d->bias_level == SND_SOC_BIAS_PREPARE && !d->dev_power) {
-			ret = snd_soc_dapm_set_bias_level(card, d,
+			ret = snd_soc_dapm_set_bias_level(d,
 							  SND_SOC_BIAS_STANDBY);
 			if (ret != 0)
 				dev_err(d->dev,
@@ -1152,7 +1152,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		/* If we're in standby and can support bias off then do that */
 		if (d->bias_level == SND_SOC_BIAS_STANDBY &&
 		    d->idle_bias_off) {
-			ret = snd_soc_dapm_set_bias_level(card, d,
+			ret = snd_soc_dapm_set_bias_level(d,
 							  SND_SOC_BIAS_OFF);
 			if (ret != 0)
 				dev_err(d->dev,
@@ -1161,7 +1161,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 
 		/* If we just powered up then move to active bias */
 		if (d->bias_level == SND_SOC_BIAS_PREPARE && d->dev_power) {
-			ret = snd_soc_dapm_set_bias_level(card, d,
+			ret = snd_soc_dapm_set_bias_level(d,
 							  SND_SOC_BIAS_ON);
 			if (ret != 0)
 				dev_err(d->dev,
@@ -2439,9 +2439,9 @@ static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 	 * standby.
 	 */
 	if (powerdown) {
-		snd_soc_dapm_set_bias_level(NULL, dapm, SND_SOC_BIAS_PREPARE);
+		snd_soc_dapm_set_bias_level(dapm, SND_SOC_BIAS_PREPARE);
 		dapm_seq_run(dapm, &down_list, 0, false);
-		snd_soc_dapm_set_bias_level(NULL, dapm, SND_SOC_BIAS_STANDBY);
+		snd_soc_dapm_set_bias_level(dapm, SND_SOC_BIAS_STANDBY);
 	}
 }
 
@@ -2454,7 +2454,7 @@ void snd_soc_dapm_shutdown(struct snd_soc_card *card)
 
 	list_for_each_entry(codec, &card->codec_dev_list, list) {
 		soc_dapm_shutdown_codec(&codec->dapm);
-		snd_soc_dapm_set_bias_level(card, &codec->dapm, SND_SOC_BIAS_OFF);
+		snd_soc_dapm_set_bias_level(&codec->dapm, SND_SOC_BIAS_OFF);
 	}
 }
 
-- 
1.7.2.3
