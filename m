From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: Remove is_sys_clk_from_pll,
	it has ordering issues" to the asoc tree
Date: Fri, 11 May 2018 03:54:19 +0100 (BST)
Message-ID: <20180511025419.2087D440080@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BB7172677A3
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 05:01:21 +0200 (CEST)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: Remove is_sys_clk_from_pll, it has ordering issues

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

>From 8e7a1f1f177fef28cbd5edc663044b8946d08ab2 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 8 May 2018 17:35:46 +0200
Subject: [PATCH] ASoC: rt5640: Remove is_sys_clk_from_pll, it has ordering
 issues

is_sys_clk_from_pll() is used as a snd_soc_dapm_route.connected callback,
checking RT5640_GBL_CLK to determine if the sys-clk is PLL1 and thus the
PWR_PLL bit in reg PWR_ANLG2 must be set.

RT5640_GBL_CLK is changed by rt5640_set_dai_sysclk(), which gets called by
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
PWR_PLL in rt5640_set_dai_sysclk() based on the selected sys-clk, which
fixes this and as a bonus results in a nice cleanup.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 05567426f211..140bad07429e 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -476,20 +476,6 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	return idx;
 }
 
-static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
-			 struct snd_soc_dapm_widget *sink)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
-	unsigned int val;
-
-	val = snd_soc_component_read32(component, RT5640_GLB_CLK);
-	val &= RT5640_SCLK_SRC_MASK;
-	if (val == RT5640_SCLK_SRC_PLL1)
-		return 1;
-	else
-		return 0;
-}
-
 static int is_using_asrc(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
@@ -1071,9 +1057,6 @@ static int rt5640_hp_post_event(struct snd_soc_dapm_widget *w,
 }
 
 static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
-	SND_SOC_DAPM_SUPPLY("PLL1", RT5640_PWR_ANLG2,
-			RT5640_PWR_PLL_BIT, 0, NULL, 0),
-
 	/* ASRC */
 	SND_SOC_DAPM_SUPPLY_S("Stereo Filter ASRC", 1, RT5640_ASRC_1,
 			 15, 0, NULL, 0),
@@ -1427,22 +1410,18 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"Stereo ADC MIXL", "ADC1 Switch", "Stereo ADC L1 Mux"},
 	{"Stereo ADC MIXL", "ADC2 Switch", "Stereo ADC L2 Mux"},
 	{"Stereo ADC MIXL", NULL, "Stereo Filter"},
-	{"Stereo Filter", NULL, "PLL1", is_sys_clk_from_pll},
 
 	{"Stereo ADC MIXR", "ADC1 Switch", "Stereo ADC R1 Mux"},
 	{"Stereo ADC MIXR", "ADC2 Switch", "Stereo ADC R2 Mux"},
 	{"Stereo ADC MIXR", NULL, "Stereo Filter"},
-	{"Stereo Filter", NULL, "PLL1", is_sys_clk_from_pll},
 
 	{"Mono ADC MIXL", "ADC1 Switch", "Mono ADC L1 Mux"},
 	{"Mono ADC MIXL", "ADC2 Switch", "Mono ADC L2 Mux"},
 	{"Mono ADC MIXL", NULL, "Mono Left Filter"},
-	{"Mono Left Filter", NULL, "PLL1", is_sys_clk_from_pll},
 
 	{"Mono ADC MIXR", "ADC1 Switch", "Mono ADC R1 Mux"},
 	{"Mono ADC MIXR", "ADC2 Switch", "Mono ADC R2 Mux"},
 	{"Mono ADC MIXR", NULL, "Mono Right Filter"},
-	{"Mono Right Filter", NULL, "PLL1", is_sys_clk_from_pll},
 
 	{"IF2 ADC L", NULL, "Mono ADC MIXL"},
 	{"IF2 ADC R", NULL, "Mono ADC MIXR"},
@@ -1512,10 +1491,8 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"DIG MIXR", "DAC R1 Switch", "DAC MIXR"},
 
 	{"DAC L1", NULL, "Stereo DAC MIXL"},
-	{"DAC L1", NULL, "PLL1", is_sys_clk_from_pll},
 	{"DAC L1", NULL, "DAC L1 Power"},
 	{"DAC R1", NULL, "Stereo DAC MIXR"},
-	{"DAC R1", NULL, "PLL1", is_sys_clk_from_pll},
 	{"DAC R1", NULL, "DAC R1 Power"},
 
 	{"SPK MIXL", "REC MIXL Switch", "RECMIXL"},
@@ -1622,10 +1599,8 @@ static const struct snd_soc_dapm_route rt5640_specific_dapm_routes[] = {
 	{"DIG MIXL", "DAC L2 Switch", "DAC L2 Mux"},
 
 	{"DAC L2", NULL, "Mono DAC MIXL"},
-	{"DAC L2", NULL, "PLL1", is_sys_clk_from_pll},
 	{"DAC L2", NULL, "DAC L2 Power"},
 	{"DAC R2", NULL, "Mono DAC MIXR"},
-	{"DAC R2", NULL, "PLL1", is_sys_clk_from_pll},
 	{"DAC R2", NULL, "DAC R2 Power"},
 
 	{"SPK MIXL", "DAC L2 Switch", "DAC L2"},
@@ -1861,6 +1836,7 @@ static int rt5640_set_dai_sysclk(struct snd_soc_dai *dai,
 	struct snd_soc_component *component = dai->component;
 	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 	unsigned int reg_val = 0;
+	unsigned int pll_bit = 0;
 
 	if (freq == rt5640->sysclk && clk_id == rt5640->sysclk_src)
 		return 0;
@@ -1871,6 +1847,7 @@ static int rt5640_set_dai_sysclk(struct snd_soc_dai *dai,
 		break;
 	case RT5640_SCLK_S_PLL1:
 		reg_val |= RT5640_SCLK_SRC_PLL1;
+		pll_bit |= RT5640_PWR_PLL;
 		break;
 	case RT5640_SCLK_S_RCCLK:
 		reg_val |= RT5640_SCLK_SRC_RCCLK;
@@ -1879,6 +1856,8 @@ static int rt5640_set_dai_sysclk(struct snd_soc_dai *dai,
 		dev_err(component->dev, "Invalid clock id (%d)\n", clk_id);
 		return -EINVAL;
 	}
+	snd_soc_component_update_bits(component, RT5640_PWR_ANLG2,
+		RT5640_PWR_PLL, pll_bit);
 	snd_soc_component_update_bits(component, RT5640_GLB_CLK,
 		RT5640_SCLK_SRC_MASK, reg_val);
 	rt5640->sysclk = freq;
-- 
2.17.0
