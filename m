From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 07/32] ASoC: rt5651: Remove
	is_sys_clk_from_pll()
Date: Sun, 25 Feb 2018 11:46:48 +0100
Message-ID: <20180225104713.4745-8-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 234DA2673C4
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:28 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

is_sys_clk_from_pll() is used as a snd_soc_dapm_route.connected callback,
checking RT5651_GBL_CLK to determine if the sys-clk is PLL1 and thus the
PWR_PLL bit in reg PWR_ANLG2 must be set.

RT5651_GBL_CLK is changed by rt5651_set_dai_sysclk(), which gets called by
the pre_pmu / post_pmd functions of the "Platform Clock" dapm-supply.

This creates an ordering issue, during a dapm transition first all
connected() callbacks are called to build a list of supplies to enable
and then the complete list is walked to enable the supplies. Since the
connected() check happens before enabling any supplies,
is_sys_clk_from_pll() ends up deciding if the PWR_PLL bit should be set
based on the state the "Platform Clock" supply had *before* the transition.
This sometimes results in PWR_PLL being off, even though *after* the
transition PLL1 is configured as sys-clk.

This commit removes is_sys_clk_from_pll() instead simply setting / clearing
PWR_PLL in rt5651_set_dai_sysclk() based on the selected sys-clk, which
fixes this and as a bonus results in a nice cleanup.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note that many of the other rt56?? drivers have a similar
is_sys_clk_from_pll() functon and may need a similar fix.
---
 sound/soc/codecs/rt5651.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 7d2bb6fbde4e..d4a2a1ef87b2 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -393,20 +393,6 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	return idx;
 }
 
-static int is_sysclk_from_pll(struct snd_soc_dapm_widget *source,
-			 struct snd_soc_dapm_widget *sink)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
-	unsigned int val;
-
-	val = snd_soc_component_read32(component, RT5651_GLB_CLK);
-	val &= RT5651_SCLK_SRC_MASK;
-	if (val == RT5651_SCLK_SRC_PLL1)
-		return 1;
-	else
-		return 0;
-}
-
 /* Digital Mixer */
 static const struct snd_kcontrol_new rt5651_sto1_adc_l_mix[] = {
 	SOC_DAPM_SINGLE("ADC1 Switch", RT5651_STO1_ADC_MIXER,
@@ -878,8 +864,6 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY_S("ADC ASRC", 1, RT5651_PLL_MODE_2,
 			      11, 0, NULL, 0),
 
-	SND_SOC_DAPM_SUPPLY("PLL1", RT5651_PWR_ANLG2,
-			RT5651_PWR_PLL_BIT, 0, NULL, 0),
 	/* Input Side */
 	SND_SOC_DAPM_SUPPLY("JD Power", RT5651_PWR_ANLG2,
 		RT5651_PWM_JD_M_BIT, 0, NULL, 0),
@@ -1162,7 +1146,6 @@ static const struct snd_soc_dapm_route rt5651_dapm_routes[] = {
 	{"Stereo1 ADC MIXL", "ADC1 Switch", "Stereo1 ADC L1 Mux"},
 	{"Stereo1 ADC MIXL", "ADC2 Switch", "Stereo1 ADC L2 Mux"},
 	{"Stereo1 ADC MIXL", NULL, "Stereo1 Filter"},
-	{"Stereo1 Filter", NULL, "PLL1", is_sysclk_from_pll},
 	{"Stereo1 Filter", NULL, "ADC ASRC"},
 
 	{"Stereo1 ADC MIXR", "ADC1 Switch", "Stereo1 ADC R1 Mux"},
@@ -1172,7 +1155,6 @@ static const struct snd_soc_dapm_route rt5651_dapm_routes[] = {
 	{"Stereo2 ADC MIXL", "ADC1 Switch", "Stereo2 ADC L1 Mux"},
 	{"Stereo2 ADC MIXL", "ADC2 Switch", "Stereo2 ADC L2 Mux"},
 	{"Stereo2 ADC MIXL", NULL, "Stereo2 Filter"},
-	{"Stereo2 Filter", NULL, "PLL1", is_sysclk_from_pll},
 	{"Stereo2 Filter", NULL, "ADC ASRC"},
 
 	{"Stereo2 ADC MIXR", "ADC1 Switch", "Stereo2 ADC R1 Mux"},
@@ -1239,10 +1221,8 @@ static const struct snd_soc_dapm_route rt5651_dapm_routes[] = {
 	{"PDM R Mux", "DD MIX", "DAC MIXR"},
 
 	{"DAC L1", NULL, "Stereo DAC MIXL"},
-	{"DAC L1", NULL, "PLL1", is_sysclk_from_pll},
 	{"DAC L1", NULL, "DAC L1 Power"},
 	{"DAC R1", NULL, "Stereo DAC MIXR"},
-	{"DAC R1", NULL, "PLL1", is_sysclk_from_pll},
 	{"DAC R1", NULL, "DAC R1 Power"},
 
 	{"DD MIXL", "DAC L1 Switch", "DAC MIXL"},
@@ -1438,6 +1418,7 @@ static int rt5651_set_dai_sysclk(struct snd_soc_dai *dai,
 	struct snd_soc_component *component = dai->component;
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
 	unsigned int reg_val = 0;
+	unsigned int pll_bit = 0;
 
 	if (freq == rt5651->sysclk && clk_id == rt5651->sysclk_src)
 		return 0;
@@ -1448,6 +1429,7 @@ static int rt5651_set_dai_sysclk(struct snd_soc_dai *dai,
 		break;
 	case RT5651_SCLK_S_PLL1:
 		reg_val |= RT5651_SCLK_SRC_PLL1;
+		pll_bit |= RT5651_PWR_PLL;
 		break;
 	case RT5651_SCLK_S_RCCLK:
 		reg_val |= RT5651_SCLK_SRC_RCCLK;
@@ -1456,6 +1438,8 @@ static int rt5651_set_dai_sysclk(struct snd_soc_dai *dai,
 		dev_err(component->dev, "Invalid clock id (%d)\n", clk_id);
 		return -EINVAL;
 	}
+	snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
+		RT5651_PWR_PLL, pll_bit);
 	snd_soc_component_update_bits(component, RT5651_GLB_CLK,
 		RT5651_SCLK_SRC_MASK, reg_val);
 	rt5651->sysclk = freq;
-- 
2.14.3
