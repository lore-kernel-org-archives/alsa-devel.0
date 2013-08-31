From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: wm8400: Use supplies to manage input
	power
Date: Sat, 31 Aug 2013 13:22:34 +0100
Message-ID: <1377951755-27028-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8894F261A07
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 14:22:49 +0200 (CEST)
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

Rather than using a fake register to manage input power create some supply
widgets and use those.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8400.c | 73 ++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 55 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index d2a0928..95c33d1 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -32,13 +32,6 @@
 
 #include "wm8400.h"
 
-/* Fake register for internal state */
-#define WM8400_INTDRIVBITS      (WM8400_REGISTER_COUNT + 1)
-#define WM8400_INMIXL_PWR			0
-#define WM8400_AINLMUX_PWR			1
-#define WM8400_INMIXR_PWR			2
-#define WM8400_AINRMUX_PWR			3
-
 static struct regulator_bulk_data power[] = {
 	{
 		.supply = "I2S1VDD",
@@ -79,10 +72,7 @@ static inline unsigned int wm8400_read(struct snd_soc_codec *codec,
 {
 	struct wm8400_priv *wm8400 = snd_soc_codec_get_drvdata(codec);
 
-	if (reg == WM8400_INTDRIVBITS)
-		return wm8400->fake_register;
-	else
-		return wm8400_reg_read(wm8400->wm8400, reg);
+	return wm8400_reg_read(wm8400->wm8400, reg);
 }
 
 /*
@@ -93,11 +83,7 @@ static int wm8400_write(struct snd_soc_codec *codec, unsigned int reg,
 {
 	struct wm8400_priv *wm8400 = snd_soc_codec_get_drvdata(codec);
 
-	if (reg == WM8400_INTDRIVBITS) {
-		wm8400->fake_register = value;
-		return 0;
-	} else
-		return wm8400_set_bits(wm8400->wm8400, reg, 0xffff, value);
+	return wm8400_set_bits(wm8400->wm8400, reg, 0xffff, value);
 }
 
 static void wm8400_codec_reset(struct snd_soc_codec *codec)
@@ -352,32 +338,6 @@ SOC_SINGLE("RIN34 Mute Switch", WM8400_RIGHT_LINE_INPUT_3_4_VOLUME,
  * _DAPM_ Controls
  */
 
-static int inmixer_event (struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
-{
-	u16 reg, fakepower;
-
-	reg = snd_soc_read(w->codec, WM8400_POWER_MANAGEMENT_2);
-	fakepower = snd_soc_read(w->codec, WM8400_INTDRIVBITS);
-
-	if (fakepower & ((1 << WM8400_INMIXL_PWR) |
-		(1 << WM8400_AINLMUX_PWR))) {
-		reg |= WM8400_AINL_ENA;
-	} else {
-		reg &= ~WM8400_AINL_ENA;
-	}
-
-	if (fakepower & ((1 << WM8400_INMIXR_PWR) |
-		(1 << WM8400_AINRMUX_PWR))) {
-		reg |= WM8400_AINR_ENA;
-	} else {
-		reg &= ~WM8400_AINR_ENA;
-	}
-	snd_soc_write(w->codec, WM8400_POWER_MANAGEMENT_2, reg);
-
-	return 0;
-}
-
 static int outmixer_event (struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol * kcontrol, int event)
 {
@@ -658,27 +618,26 @@ SND_SOC_DAPM_MIXER("RIN34 PGA", WM8400_POWER_MANAGEMENT_2,
 		   0, &wm8400_dapm_rin34_pga_controls[0],
 		   ARRAY_SIZE(wm8400_dapm_rin34_pga_controls)),
 
+SND_SOC_DAPM_SUPPLY("INL", WM8400_POWER_MANAGEMENT_2, WM8400_AINL_ENA_SHIFT,
+		    0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("INR", WM8400_POWER_MANAGEMENT_2, WM8400_AINR_ENA_SHIFT,
+		    0, NULL, 0),
+
 /* INMIXL */
-SND_SOC_DAPM_MIXER_E("INMIXL", WM8400_INTDRIVBITS, WM8400_INMIXL_PWR, 0,
+SND_SOC_DAPM_MIXER("INMIXL", SND_SOC_NOPM, 0, 0,
 	&wm8400_dapm_inmixl_controls[0],
-	ARRAY_SIZE(wm8400_dapm_inmixl_controls),
-	inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	ARRAY_SIZE(wm8400_dapm_inmixl_controls)),
 
 /* AINLMUX */
-SND_SOC_DAPM_MUX_E("AILNMUX", WM8400_INTDRIVBITS, WM8400_AINLMUX_PWR, 0,
-	&wm8400_dapm_ainlmux_controls, inmixer_event,
-	SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_MUX("AILNMUX", SND_SOC_NOPM, 0, 0, &wm8400_dapm_ainlmux_controls),
 
 /* INMIXR */
-SND_SOC_DAPM_MIXER_E("INMIXR", WM8400_INTDRIVBITS, WM8400_INMIXR_PWR, 0,
+SND_SOC_DAPM_MIXER("INMIXR", SND_SOC_NOPM, 0, 0,
 	&wm8400_dapm_inmixr_controls[0],
-	ARRAY_SIZE(wm8400_dapm_inmixr_controls),
-	inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	ARRAY_SIZE(wm8400_dapm_inmixr_controls)),
 
 /* AINRMUX */
-SND_SOC_DAPM_MUX_E("AIRNMUX", WM8400_INTDRIVBITS, WM8400_AINRMUX_PWR, 0,
-	&wm8400_dapm_ainrmux_controls, inmixer_event,
-	SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_MUX("AIRNMUX", SND_SOC_NOPM, 0, 0, &wm8400_dapm_ainrmux_controls),
 
 /* Output Side */
 /* DACs */
@@ -789,11 +748,13 @@ static const struct snd_soc_dapm_route wm8400_dapm_routes[] = {
 	{"LIN34 PGA", "LIN3 Switch", "LIN3"},
 	{"LIN34 PGA", "LIN4 Switch", "LIN4/RXN"},
 	/* INMIXL */
+	{"INMIXL", NULL, "INL"},
 	{"INMIXL", "Record Left Volume", "LOMIX"},
 	{"INMIXL", "LIN2 Volume", "LIN2"},
 	{"INMIXL", "LINPGA12 Switch", "LIN12 PGA"},
 	{"INMIXL", "LINPGA34 Switch", "LIN34 PGA"},
 	/* AILNMUX */
+	{"AILNMUX", NULL, "INL"},
 	{"AILNMUX", "INMIXL Mix", "INMIXL"},
 	{"AILNMUX", "DIFFINL Mix", "LIN12 PGA"},
 	{"AILNMUX", "DIFFINL Mix", "LIN34 PGA"},
@@ -808,12 +769,14 @@ static const struct snd_soc_dapm_route wm8400_dapm_routes[] = {
 	/* RIN34 PGA */
 	{"RIN34 PGA", "RIN3 Switch", "RIN3"},
 	{"RIN34 PGA", "RIN4 Switch", "RIN4/RXP"},
-	/* INMIXL */
+	/* INMIXR */
+	{"INMIXR", NULL, "INR"},
 	{"INMIXR", "Record Right Volume", "ROMIX"},
 	{"INMIXR", "RIN2 Volume", "RIN2"},
 	{"INMIXR", "RINPGA12 Switch", "RIN12 PGA"},
 	{"INMIXR", "RINPGA34 Switch", "RIN34 PGA"},
 	/* AIRNMUX */
+	{"AIRNMUX", NULL, "INR"},
 	{"AIRNMUX", "INMIXR Mix", "INMIXR"},
 	{"AIRNMUX", "DIFFINR Mix", "RIN12 PGA"},
 	{"AIRNMUX", "DIFFINR Mix", "RIN34 PGA"},
-- 
1.8.4.rc3
