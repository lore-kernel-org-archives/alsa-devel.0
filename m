From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Run bias level changes for all DAPM
	contexts in parallel
Date: Fri, 18 Feb 2011 19:55:13 +0000
Message-ID: <1298058913-22393-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <>
	<1298058913-22393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65CF7243EA
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 20:55:14 +0100 (CET)
In-Reply-To: <1298058913-22393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

As bias level changes can be quite time consuming and the bias changes
for multiple devices aren't strongly tied to each other (if anything it
can be advantageous to bring different devices up together) we can improve
the state transition time for multi-component systems by running the bias
level changes for all the devices in parallel. This is very simple to
achieve using the kernel async functionality so use that to schedule the
work.

This should have no practical effect for the overwhelming majority of
systems which have a single DAPM context - we'll bounce into another
thread to do the bias level change but otherwise everything will happen
in exactly the same order as it did before.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

I currently don't have access to a test system which can meaningfully
test this so I'm pushing it out without any testing and it may therefore
explode horribly.  Testing from people working on systems with multiple
CODECs would be especially useful.

 sound/soc/soc-dapm.c |  118 ++++++++++++++++++++++++++++---------------------
 1 files changed, 67 insertions(+), 51 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1a932bb..200ae7c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/async.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
@@ -1014,7 +1015,62 @@ static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
 	}
 }
 
+/* Async callback run prior to DAPM sequences - brings to _PREPARE if
+ * they're changing state.
+ */
+static void dapm_pre_sequence_async(void *data, async_cookie_t cookie)
+{
+	struct snd_soc_dapm_context *d = data;
+	int ret;
+
+	if (d->dev_power && d->bias_level == SND_SOC_BIAS_OFF) {
+		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_STANDBY);
+		if (ret != 0)
+			dev_err(d->dev,
+				"Failed to turn on bias: %d\n", ret);
+	}
+
+	/* If we're changing to all on or all off then prepare */
+	if ((d->dev_power && d->bias_level == SND_SOC_BIAS_STANDBY) ||
+	    (!d->dev_power && d->bias_level == SND_SOC_BIAS_ON)) {
+		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_PREPARE);
+		if (ret != 0)
+			dev_err(d->dev,
+				"Failed to prepare bias: %d\n", ret);
+	}
+}
+
+/* Async callback run prior to DAPM sequences - brings to their final
+ * state.
+ */
+static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
+{
+	struct snd_soc_dapm_context *d = data;
+	int ret;
+
+	/* If we just powered the last thing off drop to standby bias */
+	if (d->bias_level == SND_SOC_BIAS_PREPARE && !d->dev_power) {
+		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_STANDBY);
+		if (ret != 0)
+			dev_err(d->dev, "Failed to apply standby bias: %d\n",
+				ret);
+	}
 
+	/* If we're in standby and can support bias off then do that */
+	if (d->bias_level == SND_SOC_BIAS_STANDBY && d->idle_bias_off) {
+		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_OFF);
+		if (ret != 0)
+			dev_err(d->dev, "Failed to turn off bias: %d\n", ret);
+	}
+
+	/* If we just powered up then move to active bias */
+	if (d->bias_level == SND_SOC_BIAS_PREPARE && d->dev_power) {
+		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_ON);
+		if (ret != 0)
+			dev_err(d->dev, "Failed to apply active bias: %d\n",
+				ret);
+	}
+}
 
 /*
  * Scan each dapm widget for complete audio path.
@@ -1032,7 +1088,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	struct snd_soc_dapm_context *d;
 	LIST_HEAD(up_list);
 	LIST_HEAD(down_list);
-	int ret = 0;
+	LIST_HEAD(async_domain);
 	int power;
 
 	trace_snd_soc_dapm_start(card);
@@ -1110,25 +1166,11 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		}
 	}
 
-	list_for_each_entry(d, &dapm->card->dapm_list, list) {
-		if (d->dev_power && d->bias_level == SND_SOC_BIAS_OFF) {
-			ret = snd_soc_dapm_set_bias_level(d,
-							  SND_SOC_BIAS_STANDBY);
-			if (ret != 0)
-				dev_err(d->dev,
-					"Failed to turn on bias: %d\n", ret);
-		}
-
-		/* If we're changing to all on or all off then prepare */
-		if ((d->dev_power && d->bias_level == SND_SOC_BIAS_STANDBY) ||
-		    (!d->dev_power && d->bias_level == SND_SOC_BIAS_ON)) {
-			ret = snd_soc_dapm_set_bias_level(d,
-							  SND_SOC_BIAS_PREPARE);
-			if (ret != 0)
-				dev_err(d->dev,
-					"Failed to prepare bias: %d\n", ret);
-		}
-	}
+	/* Run all the bias changes in parallel */
+	list_for_each_entry(d, &dapm->card->dapm_list, list)
+		async_schedule_domain(dapm_pre_sequence_async, d,
+					&async_domain);
+	async_synchronize_full_domain(&async_domain);
 
 	/* Power down widgets first; try to avoid amplifying pops. */
 	dapm_seq_run(dapm, &down_list, event, false);
@@ -1138,37 +1180,11 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	/* Now power up. */
 	dapm_seq_run(dapm, &up_list, event, true);
 
-	list_for_each_entry(d, &dapm->card->dapm_list, list) {
-		/* If we just powered the last thing off drop to standby bias */
-		if (d->bias_level == SND_SOC_BIAS_PREPARE && !d->dev_power) {
-			ret = snd_soc_dapm_set_bias_level(d,
-							  SND_SOC_BIAS_STANDBY);
-			if (ret != 0)
-				dev_err(d->dev,
-					"Failed to apply standby bias: %d\n",
-					ret);
-		}
-
-		/* If we're in standby and can support bias off then do that */
-		if (d->bias_level == SND_SOC_BIAS_STANDBY &&
-		    d->idle_bias_off) {
-			ret = snd_soc_dapm_set_bias_level(d,
-							  SND_SOC_BIAS_OFF);
-			if (ret != 0)
-				dev_err(d->dev,
-					"Failed to turn off bias: %d\n", ret);
-		}
-
-		/* If we just powered up then move to active bias */
-		if (d->bias_level == SND_SOC_BIAS_PREPARE && d->dev_power) {
-			ret = snd_soc_dapm_set_bias_level(d,
-							  SND_SOC_BIAS_ON);
-			if (ret != 0)
-				dev_err(d->dev,
-					"Failed to apply active bias: %d\n",
-					ret);
-		}
-	}
+	/* Run all the bias changes in parallel */
+	list_for_each_entry(d, &dapm->card->dapm_list, list)
+		async_schedule_domain(dapm_post_sequence_async, d,
+					&async_domain);
+	async_synchronize_full_domain(&async_domain);
 
 	pop_dbg(dapm->dev, card->pop_time,
 		"DAPM sequencing finished, waiting %dms\n", card->pop_time);
-- 
1.7.2.3
