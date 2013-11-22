From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/5] ASoC: wm8990: Use supplies to manage input
	power
Date: Fri, 22 Nov 2013 14:39:51 +0000
Message-ID: <1385131192-28693-4-git-send-email-broonie@kernel.org>
References: <1385131192-28693-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E1D46265020
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 15:40:03 +0100 (CET)
In-Reply-To: <1385131192-28693-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, patches@opensouce.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Instead of using a fake register use a supply widget to manage the power
for the inputs, this is more idiomatic and supports regmap conversion.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8990.c | 54 ++++++++++++++---------------------------------
 sound/soc/codecs/wm8990.h |  9 --------
 2 files changed, 16 insertions(+), 47 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 6ee1cf1d353d..2261fe1b68ce 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -376,32 +376,6 @@ SOC_SINGLE("RIN34 Mute Switch", WM8990_RIGHT_LINE_INPUT_3_4_VOLUME,
  * _DAPM_ Controls
  */
 
-static int inmixer_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
-{
-	u16 reg, fakepower;
-
-	reg = snd_soc_read(w->codec, WM8990_POWER_MANAGEMENT_2);
-	fakepower = snd_soc_read(w->codec, WM8990_INTDRIVBITS);
-
-	if (fakepower & ((1 << WM8990_INMIXL_PWR_BIT) |
-		(1 << WM8990_AINLMUX_PWR_BIT))) {
-		reg |= WM8990_AINL_ENA;
-	} else {
-		reg &= ~WM8990_AINL_ENA;
-	}
-
-	if (fakepower & ((1 << WM8990_INMIXR_PWR_BIT) |
-		(1 << WM8990_AINRMUX_PWR_BIT))) {
-		reg |= WM8990_AINR_ENA;
-	} else {
-		reg &= ~WM8990_AINR_ENA;
-	}
-	snd_soc_write(w->codec, WM8990_POWER_MANAGEMENT_2, reg);
-
-	return 0;
-}
-
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -656,6 +630,11 @@ SND_SOC_DAPM_INPUT("RIN1"),
 SND_SOC_DAPM_INPUT("RIN2"),
 SND_SOC_DAPM_INPUT("Internal ADC Source"),
 
+SND_SOC_DAPM_SUPPLY("INL", WM8990_POWER_MANAGEMENT_2, WM8990_AINL_ENA_BIT, 0,
+		    NULL, 0),
+SND_SOC_DAPM_SUPPLY("INR", WM8990_POWER_MANAGEMENT_2, WM8990_AINR_ENA_BIT, 0,
+		    NULL, 0),
+
 /* DACs */
 SND_SOC_DAPM_ADC("Left ADC", "Left Capture", WM8990_POWER_MANAGEMENT_2,
 	WM8990_ADCL_ENA_BIT, 0),
@@ -677,26 +656,20 @@ SND_SOC_DAPM_MIXER("RIN34 PGA", WM8990_POWER_MANAGEMENT_2, WM8990_RIN34_ENA_BIT,
 	ARRAY_SIZE(wm8990_dapm_rin34_pga_controls)),
 
 /* INMIXL */
-SND_SOC_DAPM_MIXER_E("INMIXL", WM8990_INTDRIVBITS, WM8990_INMIXL_PWR_BIT, 0,
+SND_SOC_DAPM_MIXER("INMIXL", SND_SOC_NOPM, 0, 0,
 	&wm8990_dapm_inmixl_controls[0],
-	ARRAY_SIZE(wm8990_dapm_inmixl_controls),
-	inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	ARRAY_SIZE(wm8990_dapm_inmixl_controls)),
 
 /* AINLMUX */
-SND_SOC_DAPM_MUX_E("AINLMUX", WM8990_INTDRIVBITS, WM8990_AINLMUX_PWR_BIT, 0,
-	&wm8990_dapm_ainlmux_controls, inmixer_event,
-	SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_MUX("AINLMUX", SND_SOC_NOPM, 0, 0, &wm8990_dapm_ainlmux_controls),
 
 /* INMIXR */
-SND_SOC_DAPM_MIXER_E("INMIXR", WM8990_INTDRIVBITS, WM8990_INMIXR_PWR_BIT, 0,
+SND_SOC_DAPM_MIXER("INMIXR", SND_SOC_NOPM, 0, 0,
 	&wm8990_dapm_inmixr_controls[0],
-	ARRAY_SIZE(wm8990_dapm_inmixr_controls),
-	inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	ARRAY_SIZE(wm8990_dapm_inmixr_controls)),
 
 /* AINRMUX */
-SND_SOC_DAPM_MUX_E("AINRMUX", WM8990_INTDRIVBITS, WM8990_AINRMUX_PWR_BIT, 0,
-	&wm8990_dapm_ainrmux_controls, inmixer_event,
-	SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_MUX("AINRMUX", SND_SOC_NOPM, 0, 0, &wm8990_dapm_ainrmux_controls),
 
 /* Output Side */
 /* DACs */
@@ -796,6 +769,11 @@ static const struct snd_soc_dapm_route wm8990_dapm_routes[] = {
 	{"Left ADC", NULL, "Internal ADC Source"},
 	{"Right ADC", NULL, "Internal ADC Source"},
 
+	{"AINLMUX", NULL, "INL"},
+	{"INMIXL", NULL, "INL"},
+	{"AINRMUX", NULL, "INR"},
+	{"INMIXR", NULL, "INR"},
+
 	/* Input Side */
 	/* LIN12 PGA */
 	{"LIN12 PGA", "LIN1 Switch", "LIN1"},
diff --git a/sound/soc/codecs/wm8990.h b/sound/soc/codecs/wm8990.h
index 77c98a4bfe9c..0e9c78040c4c 100644
--- a/sound/soc/codecs/wm8990.h
+++ b/sound/soc/codecs/wm8990.h
@@ -78,7 +78,6 @@
 #define WM8990_PLL1                             0x3C
 #define WM8990_PLL2                             0x3D
 #define WM8990_PLL3                             0x3E
-#define WM8990_INTDRIVBITS			0x3F
 
 #define WM8990_EXT_ACCESS_ENA			0x75
 #define WM8990_EXT_CTL1				0x7a
@@ -818,14 +817,6 @@
  */
 #define WM8990_PLLK2_MASK                       0x00FF  /* PLLK2 - [7:0] */
 
-/*
- * R63 (0x3F) - Internal Driver Bits
- */
-#define WM8990_INMIXL_PWR_BIT			0
-#define WM8990_AINLMUX_PWR_BIT			1
-#define WM8990_INMIXR_PWR_BIT			2
-#define WM8990_AINRMUX_PWR_BIT			3
-
 #define WM8990_MCLK_DIV 0
 #define WM8990_DACCLK_DIV 1
 #define WM8990_ADCCLK_DIV 2
-- 
1.8.4.4
