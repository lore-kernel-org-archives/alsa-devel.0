From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: tlv320aic31xx: Rename AIF_IN from
	'DAC IN' to 'AIF IN'
Date: Mon, 19 Feb 2018 11:45:07 +0200
Message-ID: <20180219094508.26662-2-peter.ujfalusi@ti.com>
References: <20180219094508.26662-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id AC4B8266EB0
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 10:44:37 +0100 (CET)
In-Reply-To: <20180219094508.26662-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, s.mueller-klieser@phytec.de, afd@ti.com
List-Id: alsa-devel@alsa-project.org

The audio interface is not really the DAC input. Use more generic name for
it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 7090342e8285..e5a1e2be17aa 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -468,7 +468,7 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
 }
 
 static const struct snd_soc_dapm_widget common31xx_dapm_widgets[] = {
-	SND_SOC_DAPM_AIF_IN("DAC IN", "DAC Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF IN", "Playback", 0, SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_MUX("DAC Left Input",
 			 SND_SOC_NOPM, 0, 0, &ldac_in_control),
@@ -584,12 +584,12 @@ static const struct snd_soc_dapm_widget aic310x_dapm_widgets[] = {
 static const struct snd_soc_dapm_route
 common31xx_audio_map[] = {
 	/* DAC Input Routing */
-	{"DAC Left Input", "Left Data", "DAC IN"},
-	{"DAC Left Input", "Right Data", "DAC IN"},
-	{"DAC Left Input", "Mono", "DAC IN"},
-	{"DAC Right Input", "Left Data", "DAC IN"},
-	{"DAC Right Input", "Right Data", "DAC IN"},
-	{"DAC Right Input", "Mono", "DAC IN"},
+	{"DAC Left Input", "Left Data", "AIF IN"},
+	{"DAC Left Input", "Right Data", "AIF IN"},
+	{"DAC Left Input", "Mono", "AIF IN"},
+	{"DAC Right Input", "Left Data", "AIF IN"},
+	{"DAC Right Input", "Right Data", "AIF IN"},
+	{"DAC Right Input", "Mono", "AIF IN"},
 	{"DAC Left", NULL, "DAC Left Input"},
 	{"DAC Right", NULL, "DAC Right Input"},
 
@@ -679,8 +679,8 @@ aic310x_audio_map[] = {
  */
 static const struct snd_soc_dapm_route
 common31xx_cm_audio_map[] = {
-	{"DAC Left Input", "Off", "DAC IN"},
-	{"DAC Right Input", "Off", "DAC IN"},
+	{"DAC Left Input", "Off", "AIF IN"},
+	{"DAC Right Input", "Off", "AIF IN"},
 
 	{"HPL", NULL, "DAC Left"},
 	{"HPR", NULL, "DAC Right"},
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
