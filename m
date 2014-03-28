From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/6] ASoC: rt5640: Rename the function of clock
	checking
Date: Fri, 28 Mar 2014 20:28:26 +0800
Message-ID: <1396009710-21324-2-git-send-email-oder_chiou@realtek.com>
References: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D0A0D2654D8
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 13:29:37 +0100 (CET)
In-Reply-To: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

In order to identify clearly, the patch renames the function
"check_sysclk1_source" to "is_sys_clk_from_pll".

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 9427511..2afce49 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -480,7 +480,7 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	return idx;
 }
 
-static int check_sysclk1_source(struct snd_soc_dapm_widget *source,
+static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
 	unsigned int val;
@@ -1273,22 +1273,22 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"Stereo ADC MIXL", "ADC1 Switch", "Stereo ADC L1 Mux"},
 	{"Stereo ADC MIXL", "ADC2 Switch", "Stereo ADC L2 Mux"},
 	{"Stereo ADC MIXL", NULL, "Stereo Filter"},
-	{"Stereo Filter", NULL, "PLL1", check_sysclk1_source},
+	{"Stereo Filter", NULL, "PLL1", is_sys_clk_from_pll},
 
 	{"Stereo ADC MIXR", "ADC1 Switch", "Stereo ADC R1 Mux"},
 	{"Stereo ADC MIXR", "ADC2 Switch", "Stereo ADC R2 Mux"},
 	{"Stereo ADC MIXR", NULL, "Stereo Filter"},
-	{"Stereo Filter", NULL, "PLL1", check_sysclk1_source},
+	{"Stereo Filter", NULL, "PLL1", is_sys_clk_from_pll},
 
 	{"Mono ADC MIXL", "ADC1 Switch", "Mono ADC L1 Mux"},
 	{"Mono ADC MIXL", "ADC2 Switch", "Mono ADC L2 Mux"},
 	{"Mono ADC MIXL", NULL, "Mono Left Filter"},
-	{"Mono Left Filter", NULL, "PLL1", check_sysclk1_source},
+	{"Mono Left Filter", NULL, "PLL1", is_sys_clk_from_pll},
 
 	{"Mono ADC MIXR", "ADC1 Switch", "Mono ADC R1 Mux"},
 	{"Mono ADC MIXR", "ADC2 Switch", "Mono ADC R2 Mux"},
 	{"Mono ADC MIXR", NULL, "Mono Right Filter"},
-	{"Mono Right Filter", NULL, "PLL1", check_sysclk1_source},
+	{"Mono Right Filter", NULL, "PLL1", is_sys_clk_from_pll},
 
 	{"IF2 ADC L", NULL, "Mono ADC MIXL"},
 	{"IF2 ADC R", NULL, "Mono ADC MIXR"},
@@ -1377,13 +1377,13 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"DIG MIXR", "DAC R2 Switch", "DAC R2 Mux"},
 
 	{"DAC L1", NULL, "Stereo DAC MIXL"},
-	{"DAC L1", NULL, "PLL1", check_sysclk1_source},
+	{"DAC L1", NULL, "PLL1", is_sys_clk_from_pll},
 	{"DAC R1", NULL, "Stereo DAC MIXR"},
-	{"DAC R1", NULL, "PLL1", check_sysclk1_source},
+	{"DAC R1", NULL, "PLL1", is_sys_clk_from_pll},
 	{"DAC L2", NULL, "Mono DAC MIXL"},
-	{"DAC L2", NULL, "PLL1", check_sysclk1_source},
+	{"DAC L2", NULL, "PLL1", is_sys_clk_from_pll},
 	{"DAC R2", NULL, "Mono DAC MIXR"},
-	{"DAC R2", NULL, "PLL1", check_sysclk1_source},
+	{"DAC R2", NULL, "PLL1", is_sys_clk_from_pll},
 
 	{"SPK MIXL", "REC MIXL Switch", "RECMIXL"},
 	{"SPK MIXL", "INL Switch", "INL VOL"},
-- 
1.8.1.1.439.g50a6b54
