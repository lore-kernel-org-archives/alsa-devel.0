From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/21] ASoC: Factor out DAPM power checks for
	DACs and ADCs
Date: Thu, 23 Apr 2009 20:55:37 +0100
Message-ID: <1240516555-22249-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AFC6B10388A
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:02 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
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

This also switches us to using a switch statement for the widget type
in dapm_power_widget().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   81 +++++++++++++++++++++++++++++--------------------
 1 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 28e6e32..22522e2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -594,6 +594,34 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 	return out != 0 && in != 0;
 }
 
+/* Check to see if an ADC has power */
+static int dapm_adc_check_power(struct snd_soc_dapm_widget *w)
+{
+	int in;
+
+	if (w->active) {
+		in = is_connected_input_ep(w);
+		dapm_clear_walk(w->codec);
+		return in != 0;
+	} else {
+		return dapm_generic_check_power(w);
+	}
+}
+
+/* Check to see if a DAC has power */
+static int dapm_dac_check_power(struct snd_soc_dapm_widget *w)
+{
+	int out;
+
+	if (w->active) {
+		out = is_connected_output_ep(w);
+		dapm_clear_walk(w->codec);
+		return out != 0;
+	} else {
+		return dapm_generic_check_power(w);
+	}
+}
+
 /*
  * Scan a single DAPM widget for a complete audio path and update the
  * power status appropriately.
@@ -601,36 +629,23 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 			     struct snd_soc_dapm_widget *w)
 {
-	int in, out, power_change, power, ret;
+	int power, ret;
 
-	/* vmid - no action */
-	if (w->id == snd_soc_dapm_vmid)
+	/* Work out the new power state */
+	switch (w->id) {
+	case snd_soc_dapm_vmid:
+		/* No action required */
 		return 0;
 
-	/* active ADC */
-	if (w->id == snd_soc_dapm_adc && w->active) {
-		in = is_connected_input_ep(w);
-		dapm_clear_walk(w->codec);
-		power = (in != 0) ? 1 : 0;
-		if (power == w->power)
-			return 0;
-		w->power = power;
-		return dapm_generic_apply_power(w);
-	}
+	case snd_soc_dapm_adc:
+		power = dapm_adc_check_power(w);
+		break;
 
-	/* active DAC */
-	if (w->id == snd_soc_dapm_dac && w->active) {
-		out = is_connected_output_ep(w);
-		dapm_clear_walk(w->codec);
-		power = (out != 0) ? 1 : 0;
-		if (power == w->power)
-			return 0;
-		w->power = power;
-		return dapm_generic_apply_power(w);
-	}
+	case snd_soc_dapm_dac:
+		power = dapm_dac_check_power(w);
+		break;
 
-	/* pre and post event widgets */
-	if (w->id == snd_soc_dapm_pre) {
+	case snd_soc_dapm_pre:
 		if (!w->event)
 			return 0;
 
@@ -646,8 +661,8 @@ static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 				return ret;
 		}
 		return 0;
-	}
-	if (w->id == snd_soc_dapm_post) {
+
+	case snd_soc_dapm_post:
 		if (!w->event)
 			return 0;
 
@@ -663,15 +678,15 @@ static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 				return ret;
 		}
 		return 0;
-	}
 
-	/* all other widgets */
-	power = dapm_generic_check_power(w);
-	power_change = (w->power == power) ? 0 : 1;
-	w->power = power;
+	default:
+		power = dapm_generic_check_power(w);
+		break;
+	}
 
-	if (!power_change)
+	if (w->power == power)
 		return 0;
+	w->power = power;
 
 	return dapm_generic_apply_power(w);
 }
-- 
1.5.6.3
