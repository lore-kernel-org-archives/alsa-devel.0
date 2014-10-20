From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/12] ASoC: dapm: Remove special DAI widget
	power check functions
Date: Mon, 20 Oct 2014 19:36:38 +0200
Message-ID: <1413826604-3212-7-git-send-email-lars@metafoo.de>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ADC12658C2
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 19:36:52 +0200 (CEST)
In-Reply-To: <1413826604-3212-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

dapm_adc_check_power() checks if the widget is active, if yes it only checks
whether there are any connected input paths. Otherwise it calls
dapm_generic_check_power() which will check for both connected input and
output paths. But the function that checks for connected output paths will
return true if the widget is a active sink. Which means the generic power
check function will work just fine and there is no need for a special power
check function.

The same applies for dapm_dac_check_power(), but with input and output paths
reversed.

This patch removes both dapm_adc_check_power() and dapm_dac_check_power()
and replace their usage with dapm_generic_check_power().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 40 ++--------------------------------------
 1 file changed, 2 insertions(+), 38 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0e1ae6f..8f40c35 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1162,38 +1162,6 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 	return out != 0 && in != 0;
 }
 
-/* Check to see if an ADC has power */
-static int dapm_adc_check_power(struct snd_soc_dapm_widget *w)
-{
-	int in;
-
-	DAPM_UPDATE_STAT(w, power_checks);
-
-	if (w->active) {
-		in = is_connected_input_ep(w, NULL);
-		dapm_clear_walk_input(w->dapm, &w->sources);
-		return in != 0;
-	} else {
-		return dapm_generic_check_power(w);
-	}
-}
-
-/* Check to see if a DAC has power */
-static int dapm_dac_check_power(struct snd_soc_dapm_widget *w)
-{
-	int out;
-
-	DAPM_UPDATE_STAT(w, power_checks);
-
-	if (w->active) {
-		out = is_connected_output_ep(w, NULL);
-		dapm_clear_walk_output(w->dapm, &w->sinks);
-		return out != 0;
-	} else {
-		return dapm_generic_check_power(w);
-	}
-}
-
 /* Check to see if a power supply is needed */
 static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 {
@@ -3064,12 +3032,6 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_mux:
 		w->power_check = dapm_generic_check_power;
 		break;
-	case snd_soc_dapm_dai_out:
-		w->power_check = dapm_adc_check_power;
-		break;
-	case snd_soc_dapm_dai_in:
-		w->power_check = dapm_dac_check_power;
-		break;
 	case snd_soc_dapm_adc:
 	case snd_soc_dapm_aif_out:
 	case snd_soc_dapm_dac:
@@ -3084,6 +3046,8 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_mic:
 	case snd_soc_dapm_line:
 	case snd_soc_dapm_dai_link:
+	case snd_soc_dapm_dai_out:
+	case snd_soc_dapm_dai_in:
 		w->power_check = dapm_generic_check_power;
 		break;
 	case snd_soc_dapm_supply:
-- 
1.8.0
