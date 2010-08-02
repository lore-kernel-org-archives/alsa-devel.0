From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 2/2] ASoC: TWL4030: Capture route runtime DAPM
	ordering fix
Date: Mon,  2 Aug 2010 10:08:15 +0300
Message-ID: <1280732895-29010-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id C25651037FE
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 09:08:23 +0200 (CEST)
In-Reply-To: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Fix the ordering problem in DAPM domain, when the user
changes between digital and analog sources during active
capture (or loopback) scenario.
Before this patch, when the user changed from analog source
to digital there were a short time, when the codec enabled
analog mic bias (2.2 volts) instead of the correct digital
mic bias (1.8 volts) to the digital microphones.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   48 +++++++++++---------------------------------
 1 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index d401c59..7b618bb 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -577,36 +577,6 @@ static const struct snd_kcontrol_new twl4030_dapm_dbypassv_control =
 			TWL4030_REG_VSTPGA, 0, 0x29, 0,
 			twl4030_dapm_dbypassv_tlv);
 
-static int micpath_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
-{
-	struct soc_enum *e = (struct soc_enum *)w->kcontrols->private_value;
-	unsigned char adcmicsel, micbias_ctl;
-
-	adcmicsel = twl4030_read_reg_cache(w->codec, TWL4030_REG_ADCMICSEL);
-	micbias_ctl = twl4030_read_reg_cache(w->codec, TWL4030_REG_MICBIAS_CTL);
-	/* Prepare the bits for the given TX path:
-	 * shift_l == 0: TX1 microphone path
-	 * shift_l == 2: TX2 microphone path */
-	if (e->shift_l) {
-		/* TX2 microphone path */
-		if (adcmicsel & TWL4030_TX2IN_SEL)
-			micbias_ctl |= TWL4030_MICBIAS2_CTL; /* digimic */
-		else
-			micbias_ctl &= ~TWL4030_MICBIAS2_CTL;
-	} else {
-		/* TX1 microphone path */
-		if (adcmicsel & TWL4030_TX1IN_SEL)
-			micbias_ctl |= TWL4030_MICBIAS1_CTL; /* digimic */
-		else
-			micbias_ctl &= ~TWL4030_MICBIAS1_CTL;
-	}
-
-	twl4030_write(w->codec, TWL4030_REG_MICBIAS_CTL, micbias_ctl);
-
-	return 0;
-}
-
 /*
  * Output PGA builder:
  * Handle the muting and unmuting of the given output (turning off the
@@ -1430,12 +1400,10 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	/* Analog/Digital mic path selection.
 	   TX1 Left/Right: either analog Left/Right or Digimic0
 	   TX2 Left/Right: either analog Left/Right or Digimic1 */
-	SND_SOC_DAPM_MUX_E("TX1 Capture Route", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_micpathtx1_control, micpath_event,
-		SND_SOC_DAPM_POST_REG),
-	SND_SOC_DAPM_MUX_E("TX2 Capture Route", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_micpathtx2_control, micpath_event,
-		SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_MUX("TX1 Capture Route", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_micpathtx1_control),
+	SND_SOC_DAPM_MUX("TX2 Capture Route", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_micpathtx2_control),
 
 	/* Analog input mixers for the capture amplifiers */
 	SND_SOC_DAPM_MIXER("Analog Left",
@@ -1459,6 +1427,11 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 		TWL4030_REG_ADCMICSEL, 3, 0, NULL, 0,
 		digimic_event, SND_SOC_DAPM_POST_PMU),
 
+	SND_SOC_DAPM_SUPPLY("micbias1 select", TWL4030_REG_MICBIAS_CTL, 5, 0,
+			    NULL, 0),
+	SND_SOC_DAPM_SUPPLY("micbias2 select", TWL4030_REG_MICBIAS_CTL, 6, 0,
+			    NULL, 0),
+
 	SND_SOC_DAPM_MICBIAS("Mic Bias 1", TWL4030_REG_MICBIAS_CTL, 0, 0),
 	SND_SOC_DAPM_MICBIAS("Mic Bias 2", TWL4030_REG_MICBIAS_CTL, 1, 0),
 	SND_SOC_DAPM_MICBIAS("Headset Mic Bias", TWL4030_REG_MICBIAS_CTL, 2, 0),
@@ -1590,6 +1563,9 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Digimic0 Enable", NULL, "DIGIMIC0"},
 	{"Digimic1 Enable", NULL, "DIGIMIC1"},
 
+	{"DIGIMIC0", NULL, "micbias1 select"},
+	{"DIGIMIC1", NULL, "micbias2 select"},
+
 	/* TX1 Left capture path */
 	{"TX1 Capture Route", "Analog", "ADC Physical Left"},
 	{"TX1 Capture Route", "Digimic0", "Digimic0 Enable"},
-- 
1.7.2
