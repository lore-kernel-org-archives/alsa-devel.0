From: Mark Brown <broonie@linaro.org>
Subject: [PATCH] ASoC: dapm: Treat DAI widgets like AIF widgets
	for power
Date: Wed,  5 Jun 2013 19:37:20 +0100
Message-ID: <1370457440-27867-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DDBB261989
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 20:37:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Even though they are virtual widgets DAI widgets still get counted for the
DAPM context power management so we can't just use the active state to
check if they should be powered as they may not be part of a complete path.

Instead split them into input and output widgets and do the same power
checks as we perform on AIFs.

Reported-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Mark Brown <broonie@linaro.org>
---

Compile tested only thus far.

 include/sound/soc-dapm.h |    3 ++-
 sound/soc/soc-dapm.c     |   49 ++++++++++++++++++++++++----------------------
 sound/soc/soc-pcm.c      |    7 ++++++-
 3 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index f4f85dd..69e8e07 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -452,7 +452,8 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_aif_in,		/* audio interface input */
 	snd_soc_dapm_aif_out,		/* audio interface output */
 	snd_soc_dapm_siggen,		/* signal generator */
-	snd_soc_dapm_dai,		/* link to DAI structure */
+	snd_soc_dapm_dai_in,		/* link to DAI structure */
+	snd_soc_dapm_dai_out,
 	snd_soc_dapm_dai_link,		/* link between two DAI structures */
 };
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3507346..fdb14e4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -55,7 +55,8 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_clock_supply] = 1,
 	[snd_soc_dapm_micbias] = 2,
 	[snd_soc_dapm_dai_link] = 2,
-	[snd_soc_dapm_dai] = 3,
+	[snd_soc_dapm_dai_in] = 3,
+	[snd_soc_dapm_dai_out] = 3,
 	[snd_soc_dapm_aif_in] = 3,
 	[snd_soc_dapm_aif_out] = 3,
 	[snd_soc_dapm_mic] = 4,
@@ -92,7 +93,8 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_value_mux] = 9,
 	[snd_soc_dapm_aif_in] = 10,
 	[snd_soc_dapm_aif_out] = 10,
-	[snd_soc_dapm_dai] = 10,
+	[snd_soc_dapm_dai_in] = 10,
+	[snd_soc_dapm_dai_out] = 10,
 	[snd_soc_dapm_dai_link] = 11,
 	[snd_soc_dapm_clock_supply] = 12,
 	[snd_soc_dapm_regulator_supply] = 12,
@@ -419,7 +421,8 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_clock_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
-	case snd_soc_dapm_dai:
+	case snd_soc_dapm_dai_in:
+	case snd_soc_dapm_dai_out:
 	case snd_soc_dapm_hp:
 	case snd_soc_dapm_mic:
 	case snd_soc_dapm_spk:
@@ -813,7 +816,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 	switch (widget->id) {
 	case snd_soc_dapm_adc:
 	case snd_soc_dapm_aif_out:
-	case snd_soc_dapm_dai:
+	case snd_soc_dapm_dai_out:
 		if (widget->active) {
 			widget->outputs = snd_soc_dapm_suspend_check(widget);
 			return widget->outputs;
@@ -909,7 +912,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 	switch (widget->id) {
 	case snd_soc_dapm_dac:
 	case snd_soc_dapm_aif_in:
-	case snd_soc_dapm_dai:
+	case snd_soc_dapm_dai_in:
 		if (widget->active) {
 			widget->inputs = snd_soc_dapm_suspend_check(widget);
 			return widget->inputs;
@@ -1128,16 +1131,6 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 	return out != 0 && in != 0;
 }
 
-static int dapm_dai_check_power(struct snd_soc_dapm_widget *w)
-{
-	DAPM_UPDATE_STAT(w, power_checks);
-
-	if (w->active)
-		return w->active;
-
-	return dapm_generic_check_power(w);
-}
-
 /* Check to see if an ADC has power */
 static int dapm_adc_check_power(struct snd_soc_dapm_widget *w)
 {
@@ -2327,7 +2320,8 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_clock_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
-	case snd_soc_dapm_dai:
+	case snd_soc_dapm_dai_in:
+	case snd_soc_dapm_dai_out:
 	case snd_soc_dapm_dai_link:
 		list_add(&path->list, &dapm->card->paths);
 		list_add(&path->list_sink, &wsink->sources);
@@ -3134,10 +3128,12 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		break;
 	case snd_soc_dapm_adc:
 	case snd_soc_dapm_aif_out:
+	case snd_soc_dapm_dai_out:
 		w->power_check = dapm_adc_check_power;
 		break;
 	case snd_soc_dapm_dac:
 	case snd_soc_dapm_aif_in:
+	case snd_soc_dapm_dai_in:
 		w->power_check = dapm_dac_check_power;
 		break;
 	case snd_soc_dapm_pga:
@@ -3157,9 +3153,6 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_clock_supply:
 		w->power_check = dapm_supply_check_power;
 		break;
-	case snd_soc_dapm_dai:
-		w->power_check = dapm_dai_check_power;
-		break;
 	default:
 		w->power_check = dapm_always_on_check_power;
 		break;
@@ -3380,7 +3373,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 	template.reg = SND_SOC_NOPM;
 
 	if (dai->driver->playback.stream_name) {
-		template.id = snd_soc_dapm_dai;
+		template.id = snd_soc_dapm_dai_in;
 		template.name = dai->driver->playback.stream_name;
 		template.sname = dai->driver->playback.stream_name;
 
@@ -3398,7 +3391,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 	}
 
 	if (dai->driver->capture.stream_name) {
-		template.id = snd_soc_dapm_dai;
+		template.id = snd_soc_dapm_dai_out;
 		template.name = dai->driver->capture.stream_name;
 		template.sname = dai->driver->capture.stream_name;
 
@@ -3428,8 +3421,13 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 
 	/* For each DAI widget... */
 	list_for_each_entry(dai_w, &card->widgets, list) {
-		if (dai_w->id != snd_soc_dapm_dai)
+		switch (w->id) {
+		case snd_soc_dapm_dai_in:
+		case snd_soc_dapm_dai_out:
+			break;
+		default:
 			continue;
+		}
 
 		dai = dai_w->priv;
 
@@ -3438,8 +3436,13 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 			if (w->dapm != dai_w->dapm)
 				continue;
 
-			if (w->id == snd_soc_dapm_dai)
+			switch (w->id) {
+			case snd_soc_dapm_dai_in:
+			case snd_soc_dapm_dai_out:
 				continue;
+			default:
+				break;
+			}
 
 			if (!w->sname)
 				continue;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a14335e..b6c6403 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -931,8 +931,13 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	/* Create any new FE <--> BE connections */
 	for (i = 0; i < list->num_widgets; i++) {
 
-		if (list->widgets[i]->id != snd_soc_dapm_dai)
+		switch (list->widgets[i]->id) {
+		case snd_soc_dapm_dai_in:
+		case snd_soc_dapm_dai_out:
+			break;
+		default:
 			continue;
+		}
 
 		/* is there a valid BE rtd for this widget */
 		be = dpcm_get_be(card, list->widgets[i], stream);
-- 
1.7.10.4
