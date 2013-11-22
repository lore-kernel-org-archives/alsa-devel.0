From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: wm8991: Use a supply to manage input
	power
Date: Fri, 22 Nov 2013 11:17:03 +0000
Message-ID: <1385119023-19335-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C5F76261A63
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 12:17:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Instead of using a fake register and events to manage input power use a
supply to do the job, saving code and preparing for regmap conversion of
the driver.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8991.c | 53 +++++++++++++++--------------------------------
 sound/soc/codecs/wm8991.h |  9 --------
 2 files changed, 17 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 3a39df7a3829..5078fc8e10f7 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -374,30 +374,6 @@ static const struct snd_kcontrol_new wm8991_snd_controls[] = {
 /*
  * _DAPM_ Controls
  */
-static int inmixer_event(struct snd_soc_dapm_widget *w,
-			 struct snd_kcontrol *kcontrol, int event)
-{
-	u16 reg, fakepower;
-
-	reg = snd_soc_read(w->codec, WM8991_POWER_MANAGEMENT_2);
-	fakepower = snd_soc_read(w->codec, WM8991_INTDRIVBITS);
-
-	if (fakepower & ((1 << WM8991_INMIXL_PWR_BIT) |
-			 (1 << WM8991_AINLMUX_PWR_BIT)))
-		reg |= WM8991_AINL_ENA;
-	else
-		reg &= ~WM8991_AINL_ENA;
-
-	if (fakepower & ((1 << WM8991_INMIXR_PWR_BIT) |
-			 (1 << WM8991_AINRMUX_PWR_BIT)))
-		reg |= WM8991_AINR_ENA;
-	else
-		reg &= ~WM8991_AINR_ENA;
-
-	snd_soc_write(w->codec, WM8991_POWER_MANAGEMENT_2, reg);
-	return 0;
-}
-
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol, int event)
 {
@@ -655,6 +631,11 @@ static const struct snd_soc_dapm_widget wm8991_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("RIN2"),
 	SND_SOC_DAPM_INPUT("Internal ADC Source"),
 
+	SND_SOC_DAPM_SUPPLY("INL", WM8991_POWER_MANAGEMENT_2,
+			    WM8991_AINL_ENA_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("INR", WM8991_POWER_MANAGEMENT_2,
+			    WM8991_AINR_ENA_BIT, 0, NULL, 0),
+
 	/* DACs */
 	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", WM8991_POWER_MANAGEMENT_2,
 		WM8991_ADCL_ENA_BIT, 0),
@@ -676,26 +657,22 @@ static const struct snd_soc_dapm_widget wm8991_dapm_widgets[] = {
 		ARRAY_SIZE(wm8991_dapm_rin34_pga_controls)),
 
 	/* INMIXL */
-	SND_SOC_DAPM_MIXER_E("INMIXL", WM8991_INTDRIVBITS, WM8991_INMIXL_PWR_BIT, 0,
+	SND_SOC_DAPM_MIXER("INMIXL", SND_SOC_NOPM, 0, 0,
 		&wm8991_dapm_inmixl_controls[0],
-		ARRAY_SIZE(wm8991_dapm_inmixl_controls),
-		inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+		ARRAY_SIZE(wm8991_dapm_inmixl_controls)),
 
 	/* AINLMUX */
-	SND_SOC_DAPM_MUX_E("AINLMUX", WM8991_INTDRIVBITS, WM8991_AINLMUX_PWR_BIT, 0,
-		&wm8991_dapm_ainlmux_controls, inmixer_event,
-		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("AINLMUX", SND_SOC_NOPM, 0, 0,
+		&wm8991_dapm_ainlmux_controls),
 
 	/* INMIXR */
-	SND_SOC_DAPM_MIXER_E("INMIXR", WM8991_INTDRIVBITS, WM8991_INMIXR_PWR_BIT, 0,
+	SND_SOC_DAPM_MIXER("INMIXR", SND_SOC_NOPM, 0, 0,
 		&wm8991_dapm_inmixr_controls[0],
-		ARRAY_SIZE(wm8991_dapm_inmixr_controls),
-		inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+		ARRAY_SIZE(wm8991_dapm_inmixr_controls)),
 
 	/* AINRMUX */
-	SND_SOC_DAPM_MUX_E("AINRMUX", WM8991_INTDRIVBITS, WM8991_AINRMUX_PWR_BIT, 0,
-		&wm8991_dapm_ainrmux_controls, inmixer_event,
-		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("AINRMUX", SND_SOC_NOPM, 0, 0,
+		&wm8991_dapm_ainrmux_controls),
 
 	/* Output Side */
 	/* DACs */
@@ -797,6 +774,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Right ADC", NULL, "Internal ADC Source"},
 
 	/* Input Side */
+	{"INMIXL", NULL, "INL"},
+	{"AINLMUX", NULL, "INL"},
+	{"INMIXR", NULL, "INR"},
+	{"AINRMUX", NULL, "INR"},
 	/* LIN12 PGA */
 	{"LIN12 PGA", "LIN1 Switch", "LIN1"},
 	{"LIN12 PGA", "LIN2 Switch", "LIN2"},
diff --git a/sound/soc/codecs/wm8991.h b/sound/soc/codecs/wm8991.h
index 07707d8d7e20..08ed383303c0 100644
--- a/sound/soc/codecs/wm8991.h
+++ b/sound/soc/codecs/wm8991.h
@@ -76,7 +76,6 @@
 #define WM8991_PLL1                             0x3C
 #define WM8991_PLL2                             0x3D
 #define WM8991_PLL3                             0x3E
-#define WM8991_INTDRIVBITS			0x3F
 
 #define WM8991_REGISTER_COUNT                   60
 #define WM8991_MAX_REGISTER                     0x3F
@@ -807,14 +806,6 @@
  */
 #define WM8991_PLLK2_MASK                       0x00FF  /* PLLK2 - [7:0] */
 
-/*
- * R63 (0x3F) - Internal Driver Bits
- */
-#define WM8991_INMIXL_PWR_BIT			0
-#define WM8991_AINLMUX_PWR_BIT			1
-#define WM8991_INMIXR_PWR_BIT			2
-#define WM8991_AINRMUX_PWR_BIT			3
-
 #define WM8991_MCLK_DIV 0
 #define WM8991_DACCLK_DIV 1
 #define WM8991_ADCCLK_DIV 2
-- 
1.8.4.4
