From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/3 v2] ASoC: rt5677: Revise the filter powers
Date: Tue, 23 Dec 2014 10:27:54 +0800
Message-ID: <1419301676-16243-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7770C261467
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 03:28:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add the filter powers of the dac mono3 and mono4, and remove the connection
of dac stereo1 filter that connect to DAC1 MIX.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 81fe146..a15e39d 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -2645,10 +2645,18 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	/* DAC Mixer */
 	SND_SOC_DAPM_SUPPLY("dac stereo1 filter", RT5677_PWR_DIG2,
 		RT5677_PWR_DAC_S1F_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("dac mono left filter", RT5677_PWR_DIG2,
+	SND_SOC_DAPM_SUPPLY("dac mono2 left filter", RT5677_PWR_DIG2,
 		RT5677_PWR_DAC_M2F_L_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("dac mono right filter", RT5677_PWR_DIG2,
+	SND_SOC_DAPM_SUPPLY("dac mono2 right filter", RT5677_PWR_DIG2,
 		RT5677_PWR_DAC_M2F_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("dac mono3 left filter", RT5677_PWR_DIG2,
+		RT5677_PWR_DAC_M3F_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("dac mono3 right filter", RT5677_PWR_DIG2,
+		RT5677_PWR_DAC_M3F_R_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("dac mono4 left filter", RT5677_PWR_DIG2,
+		RT5677_PWR_DAC_M4F_L_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("dac mono4 right filter", RT5677_PWR_DIG2,
+		RT5677_PWR_DAC_M4F_R_BIT, 0, NULL, 0),
 
 	SND_SOC_DAPM_MIXER("Stereo DAC MIXL", SND_SOC_NOPM, 0, 0,
 		rt5677_sto1_dac_l_mix, ARRAY_SIZE(rt5677_sto1_dac_l_mix)),
@@ -3455,10 +3463,8 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 
 	{ "DAC1 MIXL", "Stereo ADC Switch", "ADDA1 Mux" },
 	{ "DAC1 MIXL", "DAC1 Switch", "DAC1 Mux" },
-	{ "DAC1 MIXL", NULL, "dac stereo1 filter" },
 	{ "DAC1 MIXR", "Stereo ADC Switch", "ADDA1 Mux" },
 	{ "DAC1 MIXR", "DAC1 Switch", "DAC1 Mux" },
-	{ "DAC1 MIXR", NULL, "dac stereo1 filter" },
 
 	{ "DAC1 FS", NULL, "DAC1 MIXL" },
 	{ "DAC1 FS", NULL, "DAC1 MIXR" },
@@ -3530,30 +3536,34 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "Mono DAC MIXL", "DAC1 L Switch", "DAC1 MIXL" },
 	{ "Mono DAC MIXL", "DAC2 L Switch", "DAC2 L Mux" },
 	{ "Mono DAC MIXL", "DAC2 R Switch", "DAC2 R Mux" },
-	{ "Mono DAC MIXL", NULL, "dac mono left filter" },
+	{ "Mono DAC MIXL", NULL, "dac mono2 left filter" },
 	{ "Mono DAC MIXR", "ST R Switch", "Sidetone Mux" },
 	{ "Mono DAC MIXR", "DAC1 R Switch", "DAC1 MIXR" },
 	{ "Mono DAC MIXR", "DAC2 R Switch", "DAC2 R Mux" },
 	{ "Mono DAC MIXR", "DAC2 L Switch", "DAC2 L Mux" },
-	{ "Mono DAC MIXR", NULL, "dac mono right filter" },
+	{ "Mono DAC MIXR", NULL, "dac mono2 right filter" },
 
 	{ "DD1 MIXL", "Sto DAC Mix L Switch", "Stereo DAC MIXL" },
 	{ "DD1 MIXL", "Mono DAC Mix L Switch", "Mono DAC MIXL" },
 	{ "DD1 MIXL", "DAC3 L Switch", "DAC3 L Mux" },
 	{ "DD1 MIXL", "DAC3 R Switch", "DAC3 R Mux" },
+	{ "DD1 MIXL", NULL, "dac mono3 left filter" },
 	{ "DD1 MIXR", "Sto DAC Mix R Switch", "Stereo DAC MIXR" },
 	{ "DD1 MIXR", "Mono DAC Mix R Switch", "Mono DAC MIXR" },
 	{ "DD1 MIXR", "DAC3 L Switch", "DAC3 L Mux" },
 	{ "DD1 MIXR", "DAC3 R Switch", "DAC3 R Mux" },
+	{ "DD1 MIXR", NULL, "dac mono3 right filter" },
 
 	{ "DD2 MIXL", "Sto DAC Mix L Switch", "Stereo DAC MIXL" },
 	{ "DD2 MIXL", "Mono DAC Mix L Switch", "Mono DAC MIXL" },
 	{ "DD2 MIXL", "DAC4 L Switch", "DAC4 L Mux" },
 	{ "DD2 MIXL", "DAC4 R Switch", "DAC4 R Mux" },
+	{ "DD2 MIXL", NULL, "dac mono4 left filter" },
 	{ "DD2 MIXR", "Sto DAC Mix R Switch", "Stereo DAC MIXR" },
 	{ "DD2 MIXR", "Mono DAC Mix R Switch", "Mono DAC MIXR" },
 	{ "DD2 MIXR", "DAC4 L Switch", "DAC4 L Mux" },
 	{ "DD2 MIXR", "DAC4 R Switch", "DAC4 R Mux" },
+	{ "DD2 MIXR", NULL, "dac mono4 right filter" },
 
 	{ "Stereo DAC MIX", NULL, "Stereo DAC MIXL" },
 	{ "Stereo DAC MIX", NULL, "Stereo DAC MIXR" },
-- 
1.8.1.1.439.g50a6b54
