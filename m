From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 3/3 v2] ASoC: rt5677: Adjust the routing of
	"PLL1"
Date: Tue, 23 Dec 2014 10:27:56 +0800
Message-ID: <1419301676-16243-3-git-send-email-oder_chiou@realtek.com>
References: <1419301676-16243-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ABF8261480
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 03:28:06 +0100 (CET)
In-Reply-To: <1419301676-16243-1-git-send-email-oder_chiou@realtek.com>
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

Remove the duplicated PLL1 connections of the adc stereo filters,
and remove the PLL1 connections of the DACs because the PLL1 should be
connected to dac filters.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 66abfa3..cf39fe6 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3014,8 +3014,6 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 
 	{ "Stereo1 ADC MIXL", NULL, "Sto1 ADC MIXL" },
 	{ "Stereo1 ADC MIXL", NULL, "adc stereo1 filter" },
-	{ "adc stereo1 filter", NULL, "PLL1", is_sys_clk_from_pll },
-
 	{ "Stereo1 ADC MIXR", NULL, "Sto1 ADC MIXR" },
 	{ "Stereo1 ADC MIXR", NULL, "adc stereo1 filter" },
 	{ "adc stereo1 filter", NULL, "PLL1", is_sys_clk_from_pll },
@@ -3036,8 +3034,6 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 
 	{ "Stereo2 ADC MIXL", NULL, "Stereo2 ADC LR Mux" },
 	{ "Stereo2 ADC MIXL", NULL, "adc stereo2 filter" },
-	{ "adc stereo2 filter", NULL, "PLL1", is_sys_clk_from_pll },
-
 	{ "Stereo2 ADC MIXR", NULL, "Sto2 ADC MIXR" },
 	{ "Stereo2 ADC MIXR", NULL, "adc stereo2 filter" },
 	{ "adc stereo2 filter", NULL, "PLL1", is_sys_clk_from_pll },
@@ -3052,8 +3048,6 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 
 	{ "Stereo3 ADC MIXL", NULL, "Sto3 ADC MIXL" },
 	{ "Stereo3 ADC MIXL", NULL, "adc stereo3 filter" },
-	{ "adc stereo3 filter", NULL, "PLL1", is_sys_clk_from_pll },
-
 	{ "Stereo3 ADC MIXR", NULL, "Sto3 ADC MIXR" },
 	{ "Stereo3 ADC MIXR", NULL, "adc stereo3 filter" },
 	{ "adc stereo3 filter", NULL, "PLL1", is_sys_clk_from_pll },
@@ -3068,8 +3062,6 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 
 	{ "Stereo4 ADC MIXL", NULL, "Sto4 ADC MIXL" },
 	{ "Stereo4 ADC MIXL", NULL, "adc stereo4 filter" },
-	{ "adc stereo4 filter", NULL, "PLL1", is_sys_clk_from_pll },
-
 	{ "Stereo4 ADC MIXR", NULL, "Sto4 ADC MIXR" },
 	{ "Stereo4 ADC MIXR", NULL, "adc stereo4 filter" },
 	{ "adc stereo4 filter", NULL, "PLL1", is_sys_clk_from_pll },
@@ -3686,39 +3678,46 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "Stereo DAC MIXR", "DAC2 R Switch", "DAC2 R Mux" },
 	{ "Stereo DAC MIXR", "DAC1 L Switch", "DAC1 MIXL" },
 	{ "Stereo DAC MIXR", NULL, "dac stereo1 filter" },
+	{ "dac stereo1 filter", NULL, "PLL1", is_sys_clk_from_pll },
 
 	{ "Mono DAC MIXL", "ST L Switch", "Sidetone Mux" },
 	{ "Mono DAC MIXL", "DAC1 L Switch", "DAC1 MIXL" },
 	{ "Mono DAC MIXL", "DAC2 L Switch", "DAC2 L Mux" },
 	{ "Mono DAC MIXL", "DAC2 R Switch", "DAC2 R Mux" },
 	{ "Mono DAC MIXL", NULL, "dac mono2 left filter" },
+	{ "dac mono2 left filter", NULL, "PLL1", is_sys_clk_from_pll },
 	{ "Mono DAC MIXR", "ST R Switch", "Sidetone Mux" },
 	{ "Mono DAC MIXR", "DAC1 R Switch", "DAC1 MIXR" },
 	{ "Mono DAC MIXR", "DAC2 R Switch", "DAC2 R Mux" },
 	{ "Mono DAC MIXR", "DAC2 L Switch", "DAC2 L Mux" },
 	{ "Mono DAC MIXR", NULL, "dac mono2 right filter" },
+	{ "dac mono2 right filter", NULL, "PLL1", is_sys_clk_from_pll },
 
 	{ "DD1 MIXL", "Sto DAC Mix L Switch", "Stereo DAC MIXL" },
 	{ "DD1 MIXL", "Mono DAC Mix L Switch", "Mono DAC MIXL" },
 	{ "DD1 MIXL", "DAC3 L Switch", "DAC3 L Mux" },
 	{ "DD1 MIXL", "DAC3 R Switch", "DAC3 R Mux" },
 	{ "DD1 MIXL", NULL, "dac mono3 left filter" },
+	{ "dac mono3 left filter", NULL, "PLL1", is_sys_clk_from_pll },
 	{ "DD1 MIXR", "Sto DAC Mix R Switch", "Stereo DAC MIXR" },
 	{ "DD1 MIXR", "Mono DAC Mix R Switch", "Mono DAC MIXR" },
 	{ "DD1 MIXR", "DAC3 L Switch", "DAC3 L Mux" },
 	{ "DD1 MIXR", "DAC3 R Switch", "DAC3 R Mux" },
 	{ "DD1 MIXR", NULL, "dac mono3 right filter" },
+	{ "dac mono3 right filter", NULL, "PLL1", is_sys_clk_from_pll },
 
 	{ "DD2 MIXL", "Sto DAC Mix L Switch", "Stereo DAC MIXL" },
 	{ "DD2 MIXL", "Mono DAC Mix L Switch", "Mono DAC MIXL" },
 	{ "DD2 MIXL", "DAC4 L Switch", "DAC4 L Mux" },
 	{ "DD2 MIXL", "DAC4 R Switch", "DAC4 R Mux" },
 	{ "DD2 MIXL", NULL, "dac mono4 left filter" },
+	{ "dac mono4 left filter", NULL, "PLL1", is_sys_clk_from_pll },
 	{ "DD2 MIXR", "Sto DAC Mix R Switch", "Stereo DAC MIXR" },
 	{ "DD2 MIXR", "Mono DAC Mix R Switch", "Mono DAC MIXR" },
 	{ "DD2 MIXR", "DAC4 L Switch", "DAC4 L Mux" },
 	{ "DD2 MIXR", "DAC4 R Switch", "DAC4 R Mux" },
 	{ "DD2 MIXR", NULL, "dac mono4 right filter" },
+	{ "dac mono4 right filter", NULL, "PLL1", is_sys_clk_from_pll },
 
 	{ "Stereo DAC MIX", NULL, "Stereo DAC MIXL" },
 	{ "Stereo DAC MIX", NULL, "Stereo DAC MIXR" },
@@ -3740,11 +3739,8 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "DAC3 SRC Mux", "DD MIX2L", "DD2 MIXL" },
 
 	{ "DAC 1", NULL, "DAC12 SRC Mux" },
-	{ "DAC 1", NULL, "PLL1", is_sys_clk_from_pll },
 	{ "DAC 2", NULL, "DAC12 SRC Mux" },
-	{ "DAC 2", NULL, "PLL1", is_sys_clk_from_pll },
 	{ "DAC 3", NULL, "DAC3 SRC Mux" },
-	{ "DAC 3", NULL, "PLL1", is_sys_clk_from_pll },
 
 	{ "PDM1 L Mux", "STO1 DAC MIX", "Stereo DAC MIXL" },
 	{ "PDM1 L Mux", "MONO DAC MIX", "Mono DAC MIXL" },
-- 
1.8.1.1.439.g50a6b54
