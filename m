From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/6] ASoC: TWL4030: Enable Headset Left
	anti-pop/bias ramp only if the Headset Left is in use
Date: Tue, 27 Jan 2009 11:29:41 +0200
Message-ID: <1233048584-29662-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-2-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id B8B1F1037EA
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 10:30:01 +0100 (CET)
In-Reply-To: <1233048584-29662-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

The Headset Left anti-pop and bias ramp does not need to be
enabled, if the headset is not in use.
Move the code to DAPM event handler for HeadsetL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   71 ++++++++++++++++++++++++++++----------------
 1 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 7d35cd4..0e3198f 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -414,6 +414,47 @@ static int handsfree_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int headsetl_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	unsigned char hs_gain, hs_pop;
+
+	/* Save the current volume */
+	hs_gain = twl4030_read_reg_cache(w->codec, TWL4030_REG_HS_GAIN_SET);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* Do the anti-pop/bias ramp enable according to the TRM */
+		hs_pop = TWL4030_RAMP_DELAY_645MS;
+		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		hs_pop |= TWL4030_VMID_EN;
+		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		/* Is this needed? Can we just use whatever gain here? */
+		twl4030_write(w->codec, TWL4030_REG_HS_GAIN_SET,
+				(hs_gain & (~0x0f)) | 0x0a);
+		hs_pop |= TWL4030_RAMP_EN;
+		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+
+		/* Restore the original volume */
+		twl4030_write(w->codec, TWL4030_REG_HS_GAIN_SET, hs_gain);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* Do the anti-pop/bias ramp disable according to the TRM */
+		hs_pop = twl4030_read_reg_cache(w->codec,
+						TWL4030_REG_HS_POPN_SET);
+		hs_pop &= ~TWL4030_RAMP_EN;
+		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		/* Bypass the reg_cache to mute the headset */
+		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+					hs_gain & (~0x0f),
+					TWL4030_REG_HS_GAIN_SET);
+		hs_pop &= ~TWL4030_VMID_EN;
+		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		break;
+	}
+	return 0;
+}
+
 /*
  * Some of the gain controls in TWL (mostly those which are associated with
  * the outputs) are implemented in an interesting way:
@@ -720,8 +761,9 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_VALUE_MUX("PredriveR Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_predriver_control),
 	/* HeadsetL/R */
-	SND_SOC_DAPM_MUX("HeadsetL Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_hsol_control),
+	SND_SOC_DAPM_MUX_E("HeadsetL Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_hsol_control, headsetl_event,
+		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX("HeadsetR Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_hsor_control),
 	/* CarkitL/R */
@@ -882,7 +924,7 @@ static int twl4030_add_widgets(struct snd_soc_codec *codec)
 
 static void twl4030_power_up(struct snd_soc_codec *codec)
 {
-	u8 anamicl, regmisc1, byte, popn;
+	u8 anamicl, regmisc1, byte;
 	int i = 0;
 
 	/* set CODECPDZ to turn on codec */
@@ -915,33 +957,10 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 	/* toggle CODECPDZ as per TRM */
 	twl4030_codec_enable(codec, 0);
 	twl4030_codec_enable(codec, 1);
-
-	/* program anti-pop with bias ramp delay */
-	popn = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
-	popn &= TWL4030_RAMP_DELAY;
-	popn |=	TWL4030_RAMP_DELAY_645MS;
-	twl4030_write(codec, TWL4030_REG_HS_POPN_SET, popn);
-	popn |=	TWL4030_VMID_EN;
-	twl4030_write(codec, TWL4030_REG_HS_POPN_SET, popn);
-
-	/* enable anti-pop ramp */
-	popn |= TWL4030_RAMP_EN;
-	twl4030_write(codec, TWL4030_REG_HS_POPN_SET, popn);
 }
 
 static void twl4030_power_down(struct snd_soc_codec *codec)
 {
-	u8 popn;
-
-	/* disable anti-pop ramp */
-	popn = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
-	popn &= ~TWL4030_RAMP_EN;
-	twl4030_write(codec, TWL4030_REG_HS_POPN_SET, popn);
-
-	/* disable bias out */
-	popn &= ~TWL4030_VMID_EN;
-	twl4030_write(codec, TWL4030_REG_HS_POPN_SET, popn);
-
 	/* power down */
 	twl4030_codec_enable(codec, 0);
 }
-- 
1.6.1
