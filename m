From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 13/18] ASoC: Fix errors in WM8990
Date: Tue,  5 May 2009 11:02:26 +0100
Message-ID: <1241517751-2634-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CED9024526
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:02:36 +0200 (CEST)
In-Reply-To: <20090505100123.GB2050@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Jinyoung Park <parkjy@mtekvision.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jinyoung Park <parkjy@mtekvision.com>

The mis-typing exist in dapm controller definitions and dapm route definitions,
so happen mis-matched error when snd_soc_dapm_add_routes().

Cc: stable@kernel.org
Signed-off-by: Jinyoung Park <parkjy@mtekvision.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com
---
 sound/soc/codecs/wm8990.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index c518c3e..40cd274 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -729,7 +729,7 @@ SND_SOC_DAPM_MIXER_E("INMIXL", WM8990_INTDRIVBITS, WM8990_INMIXL_PWR_BIT, 0,
 	inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 /* AINLMUX */
-SND_SOC_DAPM_MUX_E("AILNMUX", WM8990_INTDRIVBITS, WM8990_AINLMUX_PWR_BIT, 0,
+SND_SOC_DAPM_MUX_E("AINLMUX", WM8990_INTDRIVBITS, WM8990_AINLMUX_PWR_BIT, 0,
 	&wm8990_dapm_ainlmux_controls, inmixer_event,
 	SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
@@ -740,7 +740,7 @@ SND_SOC_DAPM_MIXER_E("INMIXR", WM8990_INTDRIVBITS, WM8990_INMIXR_PWR_BIT, 0,
 	inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 /* AINRMUX */
-SND_SOC_DAPM_MUX_E("AIRNMUX", WM8990_INTDRIVBITS, WM8990_AINRMUX_PWR_BIT, 0,
+SND_SOC_DAPM_MUX_E("AINRMUX", WM8990_INTDRIVBITS, WM8990_AINRMUX_PWR_BIT, 0,
 	&wm8990_dapm_ainrmux_controls, inmixer_event,
 	SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
@@ -848,40 +848,40 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"LIN12 PGA", "LIN2 Switch", "LIN2"},
 	/* LIN34 PGA */
 	{"LIN34 PGA", "LIN3 Switch", "LIN3"},
-	{"LIN34 PGA", "LIN4 Switch", "LIN4"},
+	{"LIN34 PGA", "LIN4 Switch", "LIN4/RXN"},
 	/* INMIXL */
 	{"INMIXL", "Record Left Volume", "LOMIX"},
 	{"INMIXL", "LIN2 Volume", "LIN2"},
 	{"INMIXL", "LINPGA12 Switch", "LIN12 PGA"},
 	{"INMIXL", "LINPGA34 Switch", "LIN34 PGA"},
-	/* AILNMUX */
-	{"AILNMUX", "INMIXL Mix", "INMIXL"},
-	{"AILNMUX", "DIFFINL Mix", "LIN12PGA"},
-	{"AILNMUX", "DIFFINL Mix", "LIN34PGA"},
-	{"AILNMUX", "RXVOICE Mix", "LIN4/RXN"},
-	{"AILNMUX", "RXVOICE Mix", "RIN4/RXP"},
+	/* AINLMUX */
+	{"AINLMUX", "INMIXL Mix", "INMIXL"},
+	{"AINLMUX", "DIFFINL Mix", "LIN12 PGA"},
+	{"AINLMUX", "DIFFINL Mix", "LIN34 PGA"},
+	{"AINLMUX", "RXVOICE Mix", "LIN4/RXN"},
+	{"AINLMUX", "RXVOICE Mix", "RIN4/RXP"},
 	/* ADC */
-	{"Left ADC", NULL, "AILNMUX"},
+	{"Left ADC", NULL, "AINLMUX"},
 
 	/* RIN12 PGA */
 	{"RIN12 PGA", "RIN1 Switch", "RIN1"},
 	{"RIN12 PGA", "RIN2 Switch", "RIN2"},
 	/* RIN34 PGA */
 	{"RIN34 PGA", "RIN3 Switch", "RIN3"},
-	{"RIN34 PGA", "RIN4 Switch", "RIN4"},
+	{"RIN34 PGA", "RIN4 Switch", "RIN4/RXP"},
 	/* INMIXL */
 	{"INMIXR", "Record Right Volume", "ROMIX"},
 	{"INMIXR", "RIN2 Volume", "RIN2"},
 	{"INMIXR", "RINPGA12 Switch", "RIN12 PGA"},
 	{"INMIXR", "RINPGA34 Switch", "RIN34 PGA"},
-	/* AIRNMUX */
-	{"AIRNMUX", "INMIXR Mix", "INMIXR"},
-	{"AIRNMUX", "DIFFINR Mix", "RIN12PGA"},
-	{"AIRNMUX", "DIFFINR Mix", "RIN34PGA"},
-	{"AIRNMUX", "RXVOICE Mix", "RIN4/RXN"},
-	{"AIRNMUX", "RXVOICE Mix", "RIN4/RXP"},
+	/* AINRMUX */
+	{"AINRMUX", "INMIXR Mix", "INMIXR"},
+	{"AINRMUX", "DIFFINR Mix", "RIN12 PGA"},
+	{"AINRMUX", "DIFFINR Mix", "RIN34 PGA"},
+	{"AINRMUX", "RXVOICE Mix", "LIN4/RXN"},
+	{"AINRMUX", "RXVOICE Mix", "RIN4/RXP"},
 	/* ADC */
-	{"Right ADC", NULL, "AIRNMUX"},
+	{"Right ADC", NULL, "AINRMUX"},
 
 	/* LOMIX */
 	{"LOMIX", "LOMIX RIN3 Bypass Switch", "RIN3"},
@@ -922,7 +922,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"LOPMIX", "LOPMIX Left Mixer PGA Switch", "LOPGA"},
 
 	/* OUT3MIX */
-	{"OUT3MIX", "OUT3MIX LIN4/RXP Bypass Switch", "LIN4/RXP"},
+	{"OUT3MIX", "OUT3MIX LIN4/RXP Bypass Switch", "LIN4/RXN"},
 	{"OUT3MIX", "OUT3MIX Left Out PGA Switch", "LOPGA"},
 
 	/* OUT4MIX */
@@ -949,7 +949,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	/* Output Pins */
 	{"LON", NULL, "LONMIX"},
 	{"LOP", NULL, "LOPMIX"},
-	{"OUT", NULL, "OUT3MIX"},
+	{"OUT3", NULL, "OUT3MIX"},
 	{"LOUT", NULL, "LOUT PGA"},
 	{"SPKN", NULL, "SPKMIX"},
 	{"ROUT", NULL, "ROUT PGA"},
-- 
1.6.2.4
