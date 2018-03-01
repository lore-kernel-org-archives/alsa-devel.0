From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Remove is_sys_clk_from_pll()"
	to the asoc tree
Date: Thu, 01 Mar 2018 19:26:24 +0000
Message-ID: <E1erTqS-0001aF-FL@debutante>
References: <20180225104713.4745-8-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 84A0F267BAA
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:26:33 +0100 (CET)
In-Reply-To: <20180225104713.4745-8-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Remove is_sys_clk_from_pll()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d082174c99e77beb06a51c90ac61934554e516e1 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:48 +0100
Subject: [PATCH] ASoC: rt5651: Remove is_sys_clk_from_pll()

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 4d93248b6401..8548f9406520 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -398,20 +398,6 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
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
@@ -883,8 +869,6 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY_S("ADC ASRC", 1, RT5651_PLL_MODE_2,
 			      11, 0, NULL, 0),
 
-	SND_SOC_DAPM_SUPPLY("PLL1", RT5651_PWR_ANLG2,
-			RT5651_PWR_PLL_BIT, 0, NULL, 0),
 	/* Input Side */
 	SND_SOC_DAPM_SUPPLY("JD Power", RT5651_PWR_ANLG2,
 		RT5651_PWM_JD_M_BIT, 0, NULL, 0),
@@ -1167,7 +1151,6 @@ static const struct snd_soc_dapm_route rt5651_dapm_routes[] = {
 	{"Stereo1 ADC MIXL", "ADC1 Switch", "Stereo1 ADC L1 Mux"},
 	{"Stereo1 ADC MIXL", "ADC2 Switch", "Stereo1 ADC L2 Mux"},
 	{"Stereo1 ADC MIXL", NULL, "Stereo1 Filter"},
-	{"Stereo1 Filter", NULL, "PLL1", is_sysclk_from_pll},
 	{"Stereo1 Filter", NULL, "ADC ASRC"},
 
 	{"Stereo1 ADC MIXR", "ADC1 Switch", "Stereo1 ADC R1 Mux"},
@@ -1177,7 +1160,6 @@ static const struct snd_soc_dapm_route rt5651_dapm_routes[] = {
 	{"Stereo2 ADC MIXL", "ADC1 Switch", "Stereo2 ADC L1 Mux"},
 	{"Stereo2 ADC MIXL", "ADC2 Switch", "Stereo2 ADC L2 Mux"},
 	{"Stereo2 ADC MIXL", NULL, "Stereo2 Filter"},
-	{"Stereo2 Filter", NULL, "PLL1", is_sysclk_from_pll},
 	{"Stereo2 Filter", NULL, "ADC ASRC"},
 
 	{"Stereo2 ADC MIXR", "ADC1 Switch", "Stereo2 ADC R1 Mux"},
@@ -1244,10 +1226,8 @@ static const struct snd_soc_dapm_route rt5651_dapm_routes[] = {
 	{"PDM R Mux", "DD MIX", "DAC MIXR"},
 
 	{"DAC L1", NULL, "Stereo DAC MIXL"},
-	{"DAC L1", NULL, "PLL1", is_sysclk_from_pll},
 	{"DAC L1", NULL, "DAC L1 Power"},
 	{"DAC R1", NULL, "Stereo DAC MIXR"},
-	{"DAC R1", NULL, "PLL1", is_sysclk_from_pll},
 	{"DAC R1", NULL, "DAC R1 Power"},
 
 	{"DD MIXL", "DAC L1 Switch", "DAC MIXL"},
@@ -1443,6 +1423,7 @@ static int rt5651_set_dai_sysclk(struct snd_soc_dai *dai,
 	struct snd_soc_component *component = dai->component;
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
 	unsigned int reg_val = 0;
+	unsigned int pll_bit = 0;
 
 	if (freq == rt5651->sysclk && clk_id == rt5651->sysclk_src)
 		return 0;
@@ -1453,6 +1434,7 @@ static int rt5651_set_dai_sysclk(struct snd_soc_dai *dai,
 		break;
 	case RT5651_SCLK_S_PLL1:
 		reg_val |= RT5651_SCLK_SRC_PLL1;
+		pll_bit |= RT5651_PWR_PLL;
 		break;
 	case RT5651_SCLK_S_RCCLK:
 		reg_val |= RT5651_SCLK_SRC_RCCLK;
@@ -1461,6 +1443,8 @@ static int rt5651_set_dai_sysclk(struct snd_soc_dai *dai,
 		dev_err(component->dev, "Invalid clock id (%d)\n", clk_id);
 		return -EINVAL;
 	}
+	snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
+		RT5651_PWR_PLL, pll_bit);
 	snd_soc_component_update_bits(component, RT5651_GLB_CLK,
 		RT5651_SCLK_SRC_MASK, reg_val);
 	rt5651->sysclk = freq;
-- 
2.16.2
