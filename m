From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/3] ASoC: TWL4030: Handsfree pop removal
	redesign
Date: Mon, 25 May 2009 10:44:37 +0300
Message-ID: <1243237479-18631-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1243237479-18631-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 247D6103845
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 09:44:48 +0200 (CEST)
In-Reply-To: <1243237479-18631-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Move the HandsfreeL/R (IHFL/R) pop removal code from the DAPM_MUX_E
to a more appropriate DAPM_PGA_E widget.
Also fix the power-up sequence to match with the TRM.
The power-down sequence is not described in the TRM, so do it
in a way, which seams like the correct sequence.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   78 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 9197fdd..17ddcb2 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -546,27 +546,61 @@ static int micpath_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int handsfree_event(struct snd_soc_dapm_widget *w,
-		struct snd_kcontrol *kcontrol, int event)
+static void handsfree_ramp(struct snd_soc_codec *codec, int reg, int ramp)
 {
-	struct soc_enum *e = (struct soc_enum *)w->kcontrols->private_value;
 	unsigned char hs_ctl;
 
-	hs_ctl = twl4030_read_reg_cache(w->codec, e->reg);
+	hs_ctl = twl4030_read_reg_cache(codec, reg);
 
-	if (hs_ctl & TWL4030_HF_CTL_REF_EN) {
+	if (ramp) {
+		/* HF ramp-up */
+		hs_ctl |= TWL4030_HF_CTL_REF_EN;
+		twl4030_write(codec, reg, hs_ctl);
+		udelay(10);
 		hs_ctl |= TWL4030_HF_CTL_RAMP_EN;
-		twl4030_write(w->codec, e->reg, hs_ctl);
+		twl4030_write(codec, reg, hs_ctl);
+		udelay(40);
 		hs_ctl |= TWL4030_HF_CTL_LOOP_EN;
-		twl4030_write(w->codec, e->reg, hs_ctl);
 		hs_ctl |= TWL4030_HF_CTL_HB_EN;
-		twl4030_write(w->codec, e->reg, hs_ctl);
+		twl4030_write(codec, reg, hs_ctl);
 	} else {
-		hs_ctl &= ~(TWL4030_HF_CTL_RAMP_EN | TWL4030_HF_CTL_LOOP_EN
-				| TWL4030_HF_CTL_HB_EN);
-		twl4030_write(w->codec, e->reg, hs_ctl);
+		/* HF ramp-down */
+		hs_ctl &= ~TWL4030_HF_CTL_LOOP_EN;
+		hs_ctl &= ~TWL4030_HF_CTL_HB_EN;
+		twl4030_write(codec, reg, hs_ctl);
+		hs_ctl &= ~TWL4030_HF_CTL_RAMP_EN;
+		twl4030_write(codec, reg, hs_ctl);
+		udelay(40);
+		hs_ctl &= ~TWL4030_HF_CTL_REF_EN;
+		twl4030_write(codec, reg, hs_ctl);
 	}
+}
 
+static int handsfreelpga_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		handsfree_ramp(w->codec, TWL4030_REG_HFL_CTL, 1);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		handsfree_ramp(w->codec, TWL4030_REG_HFL_CTL, 0);
+		break;
+	}
+	return 0;
+}
+
+static int handsfreerpga_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		handsfree_ramp(w->codec, TWL4030_REG_HFR_CTL, 1);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		handsfree_ramp(w->codec, TWL4030_REG_HFR_CTL, 0);
+		break;
+	}
 	return 0;
 }
 
@@ -1190,12 +1224,16 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 
 	/* Output MUX controls */
 	/* HandsfreeL/R */
-	SND_SOC_DAPM_MUX_E("HandsfreeL Mux", TWL4030_REG_HFL_CTL, 5, 0,
-		&twl4030_dapm_handsfreel_control, handsfree_event,
-		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_MUX_E("HandsfreeR Mux", TWL4030_REG_HFR_CTL, 5, 0,
-		&twl4030_dapm_handsfreer_control, handsfree_event,
-		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("HandsfreeL Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_handsfreel_control),
+	SND_SOC_DAPM_PGA_E("HandsfreeL PGA", SND_SOC_NOPM,
+			0, 0, NULL, 0, handsfreelpga_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("HandsfreeR Mux", SND_SOC_NOPM, 5, 0,
+		&twl4030_dapm_handsfreer_control),
+	SND_SOC_DAPM_PGA_E("HandsfreeR PGA", SND_SOC_NOPM,
+			0, 0, NULL, 0, handsfreerpga_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	/* Vibra */
 	SND_SOC_DAPM_MUX("Vibra Mux", TWL4030_REG_VIBRA_CTL, 0, 0,
 		&twl4030_dapm_vibra_control),
@@ -1303,11 +1341,13 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HandsfreeL Mux", "AudioL1", "Analog L1 Playback Mixer"},
 	{"HandsfreeL Mux", "AudioL2", "Analog L2 Playback Mixer"},
 	{"HandsfreeL Mux", "AudioR2", "Analog R2 Playback Mixer"},
+	{"HandsfreeL PGA", NULL, "HandsfreeL Mux"},
 	/* HandsfreeR */
 	{"HandsfreeR Mux", "Voice", "Analog Voice Playback Mixer"},
 	{"HandsfreeR Mux", "AudioR1", "Analog R1 Playback Mixer"},
 	{"HandsfreeR Mux", "AudioR2", "Analog R2 Playback Mixer"},
 	{"HandsfreeR Mux", "AudioL2", "Analog L2 Playback Mixer"},
+	{"HandsfreeR PGA", NULL, "HandsfreeR Mux"},
 	/* Vibra */
 	{"Vibra Mux", "AudioL1", "DAC Left1"},
 	{"Vibra Mux", "AudioR1", "DAC Right1"},
@@ -1324,8 +1364,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HSOR", NULL, "HeadsetR PGA"},
 	{"CARKITL", NULL, "CarkitL Mixer"},
 	{"CARKITR", NULL, "CarkitR Mixer"},
-	{"HFL", NULL, "HandsfreeL Mux"},
-	{"HFR", NULL, "HandsfreeR Mux"},
+	{"HFL", NULL, "HandsfreeL PGA"},
+	{"HFR", NULL, "HandsfreeR PGA"},
 	{"Vibra Route", "Audio", "Vibra Mux"},
 	{"VIBRA", NULL, "Vibra Route"},
 
-- 
1.6.3.1
