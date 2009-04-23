From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/21] ASoC: Make the DAPM power check an
	operation on the widget
Date: Thu, 23 Apr 2009 20:55:38 +0100
Message-ID: <1240516555-22249-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E5E24103866
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

Rather than having switch statements at point of use make the DAPM
power check a member of the widget structure and set it when we
instantiate the widget.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 ++
 sound/soc/soc-dapm.c     |   27 +++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index fcc929d..839a97b 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -367,6 +367,8 @@ struct snd_soc_dapm_widget {
 	unsigned char suspend:1;		/* was active before suspend */
 	unsigned char pmdown:1;			/* waiting for timeout */
 
+	int (*power_check)(struct snd_soc_dapm_widget *w);
+
 	/* external events */
 	unsigned short event_flags;		/* flags to specify event types */
 	int (*event)(struct snd_soc_dapm_widget*, struct snd_kcontrol *, int);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 22522e2..d3d1735 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -631,20 +631,7 @@ static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 {
 	int power, ret;
 
-	/* Work out the new power state */
 	switch (w->id) {
-	case snd_soc_dapm_vmid:
-		/* No action required */
-		return 0;
-
-	case snd_soc_dapm_adc:
-		power = dapm_adc_check_power(w);
-		break;
-
-	case snd_soc_dapm_dac:
-		power = dapm_dac_check_power(w);
-		break;
-
 	case snd_soc_dapm_pre:
 		if (!w->event)
 			return 0;
@@ -680,10 +667,13 @@ static int dapm_power_widget(struct snd_soc_codec *codec, int event,
 		return 0;
 
 	default:
-		power = dapm_generic_check_power(w);
 		break;
 	}
 
+	if (!w->power_check)
+		return 0;
+
+	power = w->power_check(w);
 	if (w->power == power)
 		return 0;
 	w->power = power;
@@ -1147,15 +1137,22 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 		case snd_soc_dapm_switch:
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
+			w->power_check = dapm_generic_check_power;
 			dapm_new_mixer(codec, w);
 			break;
 		case snd_soc_dapm_mux:
 		case snd_soc_dapm_value_mux:
+			w->power_check = dapm_generic_check_power;
 			dapm_new_mux(codec, w);
 			break;
 		case snd_soc_dapm_adc:
+			w->power_check = dapm_adc_check_power;
+			break;
 		case snd_soc_dapm_dac:
+			w->power_check = dapm_dac_check_power;
+			break;
 		case snd_soc_dapm_pga:
+			w->power_check = dapm_generic_check_power;
 			dapm_new_pga(codec, w);
 			break;
 		case snd_soc_dapm_input:
@@ -1165,6 +1162,8 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 		case snd_soc_dapm_hp:
 		case snd_soc_dapm_mic:
 		case snd_soc_dapm_line:
+			w->power_check = dapm_generic_check_power;
+			break;
 		case snd_soc_dapm_vmid:
 		case snd_soc_dapm_pre:
 		case snd_soc_dapm_post:
-- 
1.5.6.3
