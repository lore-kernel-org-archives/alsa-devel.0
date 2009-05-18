From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: TWL4030: Move the Headset
	pop-attenuation code to PGA event
Date: Mon, 18 May 2009 16:02:05 +0300
Message-ID: <1242651725-15001-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<1242651725-15001-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 050AA1037E3
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 15:02:24 +0200 (CEST)
In-Reply-To: <1242651725-15001-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, getarunks@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This patch adds SND_SOC_DAPM_PGA_E to the headset path, which handles
the headset ramp up and down sequences needed for the pop noise
removal.

With this patch the order of the internal components in the twl4030
codec is turned on and off in a correct order.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |  116 ++++++++++++++++++++++++++++++++++---------
 1 files changed, 91 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 990aa4a..afe7879 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -130,6 +130,12 @@ struct twl4030_priv {
 	unsigned int rate;
 	unsigned int sample_bits;
 	unsigned int channels;
+
+	unsigned int sysclk;
+
+	/* Headset output state handling */
+	unsigned int hsl_enabled;
+	unsigned int hsr_enabled;
 };
 
 /*
@@ -564,39 +570,85 @@ static int handsfree_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int headsetl_event(struct snd_soc_dapm_widget *w,
-		struct snd_kcontrol *kcontrol, int event)
+static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 {
 	unsigned char hs_gain, hs_pop;
+	struct twl4030_priv *twl4030 = codec->private_data;
+	/* Base values for ramp delay calculation: 2^19 - 2^26 */
+	unsigned int ramp_base[] = {524288, 1048576, 2097152, 4194304,
+				    8388608, 16777216, 33554432, 67108864};
 
-	/* Save the current volume */
-	hs_gain = twl4030_read_reg_cache(w->codec, TWL4030_REG_HS_GAIN_SET);
-	hs_pop = twl4030_read_reg_cache(w->codec, TWL4030_REG_HS_POPN_SET);
+	hs_gain = twl4030_read_reg_cache(codec, TWL4030_REG_HS_GAIN_SET);
+	hs_pop = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
 
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		/* Do the anti-pop/bias ramp enable according to the TRM */
+	if (ramp) {
+		/* Headset ramp-up according to the TRM */
 		hs_pop |= TWL4030_VMID_EN;
-		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
-		/* Is this needed? Can we just use whatever gain here? */
-		twl4030_write(w->codec, TWL4030_REG_HS_GAIN_SET,
-				(hs_gain & (~0x0f)) | 0x0a);
+		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		twl4030_write(codec, TWL4030_REG_HS_GAIN_SET, hs_gain);
 		hs_pop |= TWL4030_RAMP_EN;
-		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
-
-		/* Restore the original volume */
-		twl4030_write(w->codec, TWL4030_REG_HS_GAIN_SET, hs_gain);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		/* Do the anti-pop/bias ramp disable according to the TRM */
+		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+	} else {
+		/* Headset ramp-down _not_ according to
+		 * the TRM, but in a way that it is working */
 		hs_pop &= ~TWL4030_RAMP_EN;
-		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		/* Wait ramp delay time + 1, so the VMID can settle */
+		mdelay((ramp_base[(hs_pop & TWL4030_RAMP_DELAY) >> 2] /
+			twl4030->sysclk) + 1);
 		/* Bypass the reg_cache to mute the headset */
 		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
 					hs_gain & (~0x0f),
 					TWL4030_REG_HS_GAIN_SET);
+
 		hs_pop &= ~TWL4030_VMID_EN;
-		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+	}
+}
+
+static int headsetlpga_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct twl4030_priv *twl4030 = w->codec->private_data;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* Do the ramp-up only once */
+		if (!twl4030->hsr_enabled)
+			headset_ramp(w->codec, 1);
+
+		twl4030->hsl_enabled = 1;
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* Do the ramp-down only if both headsetL/R is disabled */
+		if (!twl4030->hsr_enabled)
+			headset_ramp(w->codec, 0);
+
+		twl4030->hsl_enabled = 0;
+		break;
+	}
+	return 0;
+}
+
+static int headsetrpga_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct twl4030_priv *twl4030 = w->codec->private_data;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* Do the ramp-up only once */
+		if (!twl4030->hsl_enabled)
+			headset_ramp(w->codec, 1);
+
+		twl4030->hsr_enabled = 1;
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* Do the ramp-down only if both headsetL/R is disabled */
+		if (!twl4030->hsl_enabled)
+			headset_ramp(w->codec, 0);
+
+		twl4030->hsr_enabled = 0;
 		break;
 	}
 	return 0;
@@ -1069,13 +1121,18 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 			&twl4030_dapm_predriver_controls[0],
 			ARRAY_SIZE(twl4030_dapm_predriver_controls)),
 	/* HeadsetL/R */
-	SND_SOC_DAPM_MIXER_E("HeadsetL Mixer", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MIXER("HeadsetL Mixer", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_hsol_controls[0],
-			ARRAY_SIZE(twl4030_dapm_hsol_controls), headsetl_event,
+			ARRAY_SIZE(twl4030_dapm_hsol_controls)),
+	SND_SOC_DAPM_PGA_E("HeadsetL PGA", SND_SOC_NOPM,
+			0, 0, NULL, 0, headsetlpga_event,
 			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MIXER("HeadsetR Mixer", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_hsor_controls[0],
 			ARRAY_SIZE(twl4030_dapm_hsor_controls)),
+	SND_SOC_DAPM_PGA_E("HeadsetR PGA", SND_SOC_NOPM,
+			0, 0, NULL, 0, headsetrpga_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	/* CarkitL/R */
 	SND_SOC_DAPM_MIXER("CarkitL Mixer", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_carkitl_controls[0],
@@ -1180,10 +1237,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HeadsetL Mixer", "Voice", "Analog Voice Playback Mixer"},
 	{"HeadsetL Mixer", "AudioL1", "Analog L1 Playback Mixer"},
 	{"HeadsetL Mixer", "AudioL2", "Analog L2 Playback Mixer"},
+	{"HeadsetL PGA", NULL, "HeadsetL Mixer"},
 	/* HeadsetR */
 	{"HeadsetR Mixer", "Voice", "Analog Voice Playback Mixer"},
 	{"HeadsetR Mixer", "AudioR1", "Analog R1 Playback Mixer"},
 	{"HeadsetR Mixer", "AudioR2", "Analog R2 Playback Mixer"},
+	{"HeadsetR PGA", NULL, "HeadsetR Mixer"},
 	/* CarkitL */
 	{"CarkitL Mixer", "Voice", "Analog Voice Playback Mixer"},
 	{"CarkitL Mixer", "AudioL1", "Analog L1 Playback Mixer"},
@@ -1214,8 +1273,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"EARPIECE", NULL, "Earpiece Mixer"},
 	{"PREDRIVEL", NULL, "PredriveL Mixer"},
 	{"PREDRIVER", NULL, "PredriveR Mixer"},
-	{"HSOL", NULL, "HeadsetL Mixer"},
-	{"HSOR", NULL, "HeadsetR Mixer"},
+	{"HSOL", NULL, "HeadsetL PGA"},
+	{"HSOR", NULL, "HeadsetR PGA"},
 	{"CARKITL", NULL, "CarkitL Mixer"},
 	{"CARKITR", NULL, "CarkitR Mixer"},
 	{"HFL", NULL, "HandsfreeL Mux"},
@@ -1554,17 +1613,21 @@ static int twl4030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct twl4030_priv *twl4030 = codec->private_data;
 	u8 infreq;
 
 	switch (freq) {
 	case 19200000:
 		infreq = TWL4030_APLL_INFREQ_19200KHZ;
+		twl4030->sysclk = 19200;
 		break;
 	case 26000000:
 		infreq = TWL4030_APLL_INFREQ_26000KHZ;
+		twl4030->sysclk = 26000;
 		break;
 	case 38400000:
 		infreq = TWL4030_APLL_INFREQ_38400KHZ;
+		twl4030->sysclk = 38400;
 		break;
 	default:
 		printk(KERN_ERR "TWL4030 set sysclk: unknown rate %d\n",
@@ -1953,6 +2016,9 @@ static int twl4030_probe(struct platform_device *pdev)
 		kfree(codec);
 		return -ENOMEM;
 	}
+	/* Set default sysclk (used by the headsetl/rpga_event callback for
+	 * pop-attenuation) */
+	twl4030->sysclk = 26000;
 
 	codec->private_data = twl4030;
 	socdev->card->codec = codec;
-- 
1.6.3
