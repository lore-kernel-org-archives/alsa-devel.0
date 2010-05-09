From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: Refactor DAPM suspend handling
Date: Sun,  9 May 2010 13:08:36 +0100
Message-ID: <1273406918-17007-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100509120741.GA16918@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B8F624591
	for <alsa-devel@alsa-project.org>;
	Sun,  9 May 2010 14:08:43 +0200 (CEST)
In-Reply-To: <20100509120741.GA16918@sirena.org.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Instead of using stream events to handle power down during suspend
integrate the handling with the normal widget path checking by
replacing all cases where we report a connected endpoint in a path
with a function snd_soc_dapm_suspend_check() which looks at the ALSA
power state for the card and reports false if we are in a D3 state.

Since the core moves us into D3 prior to initating the suspend all
power checks during suspend will cause the widgets to be powered
down. In order to ensure that widgets are powered up on resume set
the card to D2 at the start of resume handling (ALSA API calls
require D0 so we are still protected against userspace access).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    3 ++
 sound/soc/soc-dapm.c |   53 ++++++++++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4079223..9573976 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -963,6 +963,9 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	dev_dbg(socdev->dev, "starting resume work\n");
 
+	/* Bring us up into D2 so that DAPM starts enabling things */
+	snd_power_change_state(codec->card, SNDRV_CTL_POWER_D2);
+
 	if (card->resume_pre)
 		card->resume_pre(pdev);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b30b0a2..8c8b291 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -430,6 +430,23 @@ static inline void dapm_clear_walk(struct snd_soc_codec *codec)
 		p->walked = 0;
 }
 
+/* We implement power down on suspend by checking the power state of
+ * the ALSA card - when we are suspending the ALSA state for the card
+ * is set to D3.
+ */
+static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
+{
+	struct snd_soc_codec *codec = widget->codec;
+
+	switch (snd_power_get_state(codec->card)) {
+	case SNDRV_CTL_POWER_D3hot:
+	case SNDRV_CTL_POWER_D3cold:
+		return 0;
+	default:
+		return 1;
+	}
+}
+
 /*
  * Recursively check for a completed path to an active or physically connected
  * output widget. Returns number of complete paths.
@@ -446,7 +463,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 	case snd_soc_dapm_adc:
 	case snd_soc_dapm_aif_out:
 		if (widget->active)
-			return 1;
+			return snd_soc_dapm_suspend_check(widget);
 	default:
 		break;
 	}
@@ -454,12 +471,12 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 	if (widget->connected) {
 		/* connected pin ? */
 		if (widget->id == snd_soc_dapm_output && !widget->ext)
-			return 1;
+			return snd_soc_dapm_suspend_check(widget);
 
 		/* connected jack or spk ? */
 		if (widget->id == snd_soc_dapm_hp || widget->id == snd_soc_dapm_spk ||
 		    (widget->id == snd_soc_dapm_line && !list_empty(&widget->sources)))
-			return 1;
+			return snd_soc_dapm_suspend_check(widget);
 	}
 
 	list_for_each_entry(path, &widget->sinks, list_source) {
@@ -492,7 +509,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	case snd_soc_dapm_dac:
 	case snd_soc_dapm_aif_in:
 		if (widget->active)
-			return 1;
+			return snd_soc_dapm_suspend_check(widget);
 	default:
 		break;
 	}
@@ -500,16 +517,16 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	if (widget->connected) {
 		/* connected pin ? */
 		if (widget->id == snd_soc_dapm_input && !widget->ext)
-			return 1;
+			return snd_soc_dapm_suspend_check(widget);
 
 		/* connected VMID/Bias for lower pops */
 		if (widget->id == snd_soc_dapm_vmid)
-			return 1;
+			return snd_soc_dapm_suspend_check(widget);
 
 		/* connected jack ? */
 		if (widget->id == snd_soc_dapm_mic ||
 		    (widget->id == snd_soc_dapm_line && !list_empty(&widget->sinks)))
-			return 1;
+			return snd_soc_dapm_suspend_check(widget);
 	}
 
 	list_for_each_entry(path, &widget->sources, list_sink) {
@@ -897,22 +914,12 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 			if (!w->power_check)
 				continue;
 
-			/* If we're suspending then pull down all the 
-			 * power. */
-			switch (event) {
-			case SND_SOC_DAPM_STREAM_SUSPEND:
-				power = 0;
-				break;
-
-			default:
-				if (!w->force)
-					power = w->power_check(w);
-				else
-					power = 1;
-				if (power)
-					sys_power = 1;
-				break;
-			}
+			if (!w->force)
+				power = w->power_check(w);
+			else
+				power = 1;
+			if (power)
+				sys_power = 1;
 
 			if (w->power == power)
 				continue;
-- 
1.7.0.5
