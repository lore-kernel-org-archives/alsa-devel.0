From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Convert WM8903 to use PGA_S for
	output stage enables
Date: Wed,  9 Feb 2011 17:42:55 +0000
Message-ID: <1297273377-7898-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CE1012443E
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 18:43:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This simplfies the code and slightly reduces the startup time.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |  180 +++++++++++++++------------------------------
 1 files changed, 60 insertions(+), 120 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index b20611b..a5b2d07 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -251,6 +251,8 @@ static int wm8903_volatile_register(struct snd_soc_codec *codec, unsigned int re
 	case WM8903_REVISION_NUMBER:
 	case WM8903_INTERRUPT_STATUS_1:
 	case WM8903_WRITE_SEQUENCER_4:
+	case WM8903_POWER_MANAGEMENT_3:
+	case WM8903_POWER_MANAGEMENT_2:
 		return 1;
 
 	default:
@@ -309,11 +311,6 @@ static void wm8903_reset(struct snd_soc_codec *codec)
 	       sizeof(wm8903_reg_defaults));
 }
 
-#define WM8903_OUTPUT_SHORT 0x8
-#define WM8903_OUTPUT_OUT   0x4
-#define WM8903_OUTPUT_INT   0x2
-#define WM8903_OUTPUT_IN    0x1
-
 static int wm8903_cp_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
@@ -324,99 +321,6 @@ static int wm8903_cp_event(struct snd_soc_dapm_widget *w,
 }
 
 /*
- * Event for headphone and line out amplifier power changes.  Special
- * power up/down sequences are required in order to maximise pop/click
- * performance.
- */
-static int wm8903_output_event(struct snd_soc_dapm_widget *w,
-			       struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-	u16 val;
-	u16 reg;
-	u16 dcs_reg;
-	u16 dcs_bit;
-	int shift;
-
-	switch (w->reg) {
-	case WM8903_POWER_MANAGEMENT_2:
-		reg = WM8903_ANALOGUE_HP_0;
-		dcs_bit = 0 + w->shift;
-		break;
-	case WM8903_POWER_MANAGEMENT_3:
-		reg = WM8903_ANALOGUE_LINEOUT_0;
-		dcs_bit = 2 + w->shift;
-		break;
-	default:
-		BUG();
-		return -EINVAL;  /* Spurious warning from some compilers */
-	}
-
-	switch (w->shift) {
-	case 0:
-		shift = 0;
-		break;
-	case 1:
-		shift = 4;
-		break;
-	default:
-		BUG();
-		return -EINVAL;  /* Spurious warning from some compilers */
-	}
-
-	if (event & SND_SOC_DAPM_PRE_PMU) {
-		val = snd_soc_read(codec, reg);
-
-		/* Short the output */
-		val &= ~(WM8903_OUTPUT_SHORT << shift);
-		snd_soc_write(codec, reg, val);
-	}
-
-	if (event & SND_SOC_DAPM_POST_PMU) {
-		val = snd_soc_read(codec, reg);
-
-		val |= (WM8903_OUTPUT_IN << shift);
-		snd_soc_write(codec, reg, val);
-
-		val |= (WM8903_OUTPUT_INT << shift);
-		snd_soc_write(codec, reg, val);
-
-		/* Turn on the output ENA_OUTP */
-		val |= (WM8903_OUTPUT_OUT << shift);
-		snd_soc_write(codec, reg, val);
-
-		/* Enable the DC servo */
-		dcs_reg = snd_soc_read(codec, WM8903_DC_SERVO_0);
-		dcs_reg |= dcs_bit;
-		snd_soc_write(codec, WM8903_DC_SERVO_0, dcs_reg);
-
-		/* Remove the short */
-		val |= (WM8903_OUTPUT_SHORT << shift);
-		snd_soc_write(codec, reg, val);
-	}
-
-	if (event & SND_SOC_DAPM_PRE_PMD) {
-		val = snd_soc_read(codec, reg);
-
-		/* Short the output */
-		val &= ~(WM8903_OUTPUT_SHORT << shift);
-		snd_soc_write(codec, reg, val);
-
-		/* Disable the DC servo */
-		dcs_reg = snd_soc_read(codec, WM8903_DC_SERVO_0);
-		dcs_reg &= ~dcs_bit;
-		snd_soc_write(codec, WM8903_DC_SERVO_0, dcs_reg);
-
-		/* Then disable the intermediate and output stages */
-		val &= ~((WM8903_OUTPUT_OUT | WM8903_OUTPUT_INT |
-			  WM8903_OUTPUT_IN) << shift);
-		snd_soc_write(codec, reg, val);
-	}
-
-	return 0;
-}
-
-/*
  * When used with DAC outputs only the WM8903 charge pump supports
  * operation in class W mode, providing very low power consumption
  * when used with digital sources.  Enable and disable this mode
@@ -918,23 +822,40 @@ SND_SOC_DAPM_MIXER("Left Speaker Mixer", WM8903_POWER_MANAGEMENT_4, 1, 0,
 SND_SOC_DAPM_MIXER("Right Speaker Mixer", WM8903_POWER_MANAGEMENT_4, 0, 0,
 		   right_speaker_mixer, ARRAY_SIZE(right_speaker_mixer)),
 
-SND_SOC_DAPM_PGA_E("Left Headphone Output PGA", WM8903_POWER_MANAGEMENT_2,
-		   1, 0, NULL, 0, wm8903_output_event,
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		   SND_SOC_DAPM_PRE_PMD),
-SND_SOC_DAPM_PGA_E("Right Headphone Output PGA", WM8903_POWER_MANAGEMENT_2,
-		   0, 0, NULL, 0, wm8903_output_event,
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		   SND_SOC_DAPM_PRE_PMD),
-
-SND_SOC_DAPM_PGA_E("Left Line Output PGA", WM8903_POWER_MANAGEMENT_3, 1, 0,
-		   NULL, 0, wm8903_output_event,
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		   SND_SOC_DAPM_PRE_PMD),
-SND_SOC_DAPM_PGA_E("Right Line Output PGA", WM8903_POWER_MANAGEMENT_3, 0, 0,
-		   NULL, 0, wm8903_output_event,
-		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		   SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA_S("Left Headphone Output PGA", 0, WM8903_ANALOGUE_HP_0,
+		   4, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("Right Headphone Output PGA", 0, WM8903_ANALOGUE_HP_0,
+		   0, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA_S("Left Line Output PGA", 0, WM8903_ANALOGUE_LINEOUT_0, 4, 0,
+		   NULL, 0),
+SND_SOC_DAPM_PGA_S("Right Line Output PGA", 0, WM8903_ANALOGUE_LINEOUT_0, 0, 0,
+		   NULL, 0),
+
+SND_SOC_DAPM_PGA_S("HPL_RMV_SHORT", 4, WM8903_ANALOGUE_HP_0, 7, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("HPL_ENA_OUTP", 3, WM8903_ANALOGUE_HP_0, 6, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("HPL_ENA_DLY", 1, WM8903_ANALOGUE_HP_0, 5, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("HPR_RMV_SHORT", 4, WM8903_ANALOGUE_HP_0, 3, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("HPR_ENA_OUTP", 3, WM8903_ANALOGUE_HP_0, 2, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("HPR_ENA_DLY", 1, WM8903_ANALOGUE_HP_0, 1, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA_S("LINEOUTL_RMV_SHORT", 4, WM8903_ANALOGUE_LINEOUT_0, 7, 0,
+		   NULL, 0),
+SND_SOC_DAPM_PGA_S("LINEOUTL_ENA_OUTP", 3, WM8903_ANALOGUE_LINEOUT_0, 6, 0,
+		   NULL, 0),
+SND_SOC_DAPM_PGA_S("LINEOUTL_ENA_DLY", 1, WM8903_ANALOGUE_LINEOUT_0, 5, 0,
+		   NULL, 0),
+SND_SOC_DAPM_PGA_S("LINEOUTR_RMV_SHORT", 4, WM8903_ANALOGUE_LINEOUT_0, 3, 0,
+		   NULL, 0),
+SND_SOC_DAPM_PGA_S("LINEOUTR_ENA_OUTP", 3, WM8903_ANALOGUE_LINEOUT_0, 2, 0,
+		   NULL, 0),
+SND_SOC_DAPM_PGA_S("LINEOUTR_ENA_DLY", 1, WM8903_ANALOGUE_LINEOUT_0, 1, 0,
+		   NULL, 0),
+
+SND_SOC_DAPM_PGA_S("HPL_DCS", 3, WM8903_DC_SERVO_0, 3, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("HPR_DCS", 3, WM8903_DC_SERVO_0, 2, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("LINEOUTL_DCS", 3, WM8903_DC_SERVO_0, 1, 0, NULL, 0),
+SND_SOC_DAPM_PGA_S("LINEOUTR_DCS", 3, WM8903_DC_SERVO_0, 0, 0, NULL, 0),
 
 SND_SOC_DAPM_PGA("Left Speaker PGA", WM8903_POWER_MANAGEMENT_5, 1, 0,
 		 NULL, 0),
@@ -1050,11 +971,30 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "Left Speaker PGA", NULL, "Left Speaker Mixer" },
 	{ "Right Speaker PGA", NULL, "Right Speaker Mixer" },
 
-	{ "HPOUTL", NULL, "Left Headphone Output PGA" },
-	{ "HPOUTR", NULL, "Right Headphone Output PGA" },
-
-	{ "LINEOUTL", NULL, "Left Line Output PGA" },
-	{ "LINEOUTR", NULL, "Right Line Output PGA" },
+	{ "HPL_ENA_DLY", NULL, "Left Headphone Output PGA" },
+	{ "HPR_ENA_DLY", NULL, "Right Headphone Output PGA" },
+	{ "LINEOUTL_ENA_DLY", NULL, "Left Line Output PGA" },
+	{ "LINEOUTR_ENA_DLY", NULL, "Right Line Output PGA" },
+
+	{ "HPL_DCS", NULL, "HPL_ENA_DLY" },
+	{ "HPR_DCS", NULL, "HPR_ENA_DLY" },
+	{ "LINEOUTL_DCS", NULL, "LINEOUTL_ENA_DLY" },
+	{ "LINEOUTR_DCS", NULL, "LINEOUTR_ENA_DLY" },
+
+	{ "HPL_ENA_OUTP", NULL, "HPL_DCS" },
+	{ "HPR_ENA_OUTP", NULL, "HPR_DCS" },
+	{ "LINEOUTL_ENA_OUTP", NULL, "LINEOUTL_DCS" },
+	{ "LINEOUTR_ENA_OUTP", NULL, "LINEOUTR_DCS" },
+
+	{ "HPL_RMV_SHORT", NULL, "HPL_ENA_OUTP" },
+	{ "HPR_RMV_SHORT", NULL, "HPR_ENA_OUTP" },
+	{ "LINEOUTL_RMV_SHORT", NULL, "LINEOUTL_ENA_OUTP" },
+	{ "LINEOUTR_RMV_SHORT", NULL, "LINEOUTR_ENA_OUTP" },
+
+	{ "HPOUTL", NULL, "HPL_RMV_SHORT" },
+	{ "HPOUTR", NULL, "HPR_RMV_SHORT" },
+	{ "LINEOUTL", NULL, "LINEOUTL_RMV_SHORT" },
+	{ "LINEOUTR", NULL, "LINEOUTR_RMV_SHORT" },
 
 	{ "LOP", NULL, "Left Speaker PGA" },
 	{ "LON", NULL, "Left Speaker PGA" },
-- 
1.7.2.3
