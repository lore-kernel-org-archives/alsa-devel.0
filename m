From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: add supplys for dac power" to
	the asoc tree
Date: Mon, 07 Mar 2016 14:42:59 +0700
Message-ID: <E1acpoh-00074l-9r@finisterre>
References: <1457334578-32302-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B50C264F23
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 08:43:04 +0100 (CET)
In-Reply-To: <1457334578-32302-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jack Yu <jack.yu@realtek.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: add supplys for dac power

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 57586fb76471c5fc521b2e9c3a4eae259b06d479 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 7 Mar 2016 15:09:38 +0800
Subject: [PATCH] ASoC: rt5640: add supplys for dac power

The DAC1/2 power is for both DACs and related mixer/mux. Add SUPPLY
type widgets to support it.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 863c190c5076..af9b5f18f0e0 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1217,11 +1217,14 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("DIG MIXR", SND_SOC_NOPM, 0, 0,
 		rt5640_dig_r_mix, ARRAY_SIZE(rt5640_dig_r_mix)),
 	/* DACs */
-	SND_SOC_DAPM_DAC("DAC L1", NULL, RT5640_PWR_DIG1,
-			RT5640_PWR_DAC_L1_BIT, 0),
-	SND_SOC_DAPM_DAC("DAC R1", NULL, RT5640_PWR_DIG1,
-			RT5640_PWR_DAC_R1_BIT, 0),
-
+	SND_SOC_DAPM_DAC("DAC L1", NULL, SND_SOC_NOPM,
+			0, 0),
+	SND_SOC_DAPM_DAC("DAC R1", NULL, SND_SOC_NOPM,
+			0, 0),
+	SND_SOC_DAPM_SUPPLY("DAC L1 Power", RT5640_PWR_DIG1,
+		RT5640_PWR_DAC_L1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC R1 Power", RT5640_PWR_DIG1,
+		RT5640_PWR_DAC_R1_BIT, 0, NULL, 0),
 	/* SPK/OUT Mixer */
 	SND_SOC_DAPM_MIXER("SPK MIXL", RT5640_PWR_MIXER, RT5640_PWR_SM_L_BIT,
 		0, rt5640_spk_l_mix, ARRAY_SIZE(rt5640_spk_l_mix)),
@@ -1298,9 +1301,9 @@ static const struct snd_soc_dapm_widget rt5640_specific_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Stereo DAC MIXR", SND_SOC_NOPM, 0, 0,
 		rt5640_sto_dac_r_mix, ARRAY_SIZE(rt5640_sto_dac_r_mix)),
 
-	SND_SOC_DAPM_DAC("DAC R2", NULL, RT5640_PWR_DIG1, RT5640_PWR_DAC_R2_BIT,
+	SND_SOC_DAPM_DAC("DAC R2", NULL, SND_SOC_NOPM, 0,
 		0),
-	SND_SOC_DAPM_DAC("DAC L2", NULL, RT5640_PWR_DIG1, RT5640_PWR_DAC_L2_BIT,
+	SND_SOC_DAPM_DAC("DAC L2", NULL, SND_SOC_NOPM, 0,
 		0),
 
 	SND_SOC_DAPM_MIXER("OUT MIXL", RT5640_PWR_MIXER, RT5640_PWR_OM_L_BIT,
@@ -1317,6 +1320,10 @@ static const struct snd_soc_dapm_widget rt5640_specific_dapm_widgets[] = {
 		rt5640_mono_mix, ARRAY_SIZE(rt5640_mono_mix)),
 	SND_SOC_DAPM_SUPPLY("Improve MONO Amp Drv", RT5640_PWR_ANLG1,
 		RT5640_PWR_MA_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC L2 Power", RT5640_PWR_DIG1,
+		RT5640_PWR_DAC_L2_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC R2 Power", RT5640_PWR_DIG1,
+		RT5640_PWR_DAC_R2_BIT, 0, NULL, 0),
 
 	SND_SOC_DAPM_OUTPUT("MONOP"),
 	SND_SOC_DAPM_OUTPUT("MONON"),
@@ -1328,11 +1335,6 @@ static const struct snd_soc_dapm_widget rt5639_specific_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Stereo DAC MIXR", SND_SOC_NOPM, 0, 0,
 		rt5639_sto_dac_r_mix, ARRAY_SIZE(rt5639_sto_dac_r_mix)),
 
-	SND_SOC_DAPM_SUPPLY("DAC L2 Filter", RT5640_PWR_DIG1,
-		RT5640_PWR_DAC_L2_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("DAC R2 Filter", RT5640_PWR_DIG1,
-		RT5640_PWR_DAC_R2_BIT, 0, NULL, 0),
-
 	SND_SOC_DAPM_MIXER("OUT MIXL", RT5640_PWR_MIXER, RT5640_PWR_OM_L_BIT,
 		0, rt5639_out_l_mix, ARRAY_SIZE(rt5639_out_l_mix)),
 	SND_SOC_DAPM_MIXER("OUT MIXR", RT5640_PWR_MIXER, RT5640_PWR_OM_R_BIT,
@@ -1493,8 +1495,10 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 
 	{"DAC MIXL", "Stereo ADC Switch", "Stereo ADC MIXL"},
 	{"DAC MIXL", "INF1 Switch", "IF1 DAC L"},
+	{"DAC MIXL", NULL, "DAC L1 Power"},
 	{"DAC MIXR", "Stereo ADC Switch", "Stereo ADC MIXR"},
 	{"DAC MIXR", "INF1 Switch", "IF1 DAC R"},
+	{"DAC MIXR", NULL, "DAC R1 Power"},
 
 	{"Stereo DAC MIXL", "DAC L1 Switch", "DAC MIXL"},
 	{"Stereo DAC MIXR", "DAC R1 Switch", "DAC MIXR"},
@@ -1507,8 +1511,10 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 
 	{"DAC L1", NULL, "Stereo DAC MIXL"},
 	{"DAC L1", NULL, "PLL1", is_sys_clk_from_pll},
+	{"DAC L1", NULL, "DAC L1 Power"},
 	{"DAC R1", NULL, "Stereo DAC MIXR"},
 	{"DAC R1", NULL, "PLL1", is_sys_clk_from_pll},
+	{"DAC R1", NULL, "DAC R1 Power"},
 
 	{"SPK MIXL", "REC MIXL Switch", "RECMIXL"},
 	{"SPK MIXL", "INL Switch", "INL VOL"},
@@ -1595,8 +1601,9 @@ static const struct snd_soc_dapm_route rt5640_specific_dapm_routes[] = {
 
 	{"DAC L2 Mux", "IF2", "IF2 DAC L"},
 	{"DAC L2 Mux", "Base L/R", "Audio DSP"},
-
+	{"DAC L2 Mux", NULL, "DAC L2 Power"},
 	{"DAC R2 Mux", "IF2", "IF2 DAC R"},
+	{"DAC R2 Mux", NULL, "DAC R2 Power"},
 
 	{"Stereo DAC MIXL", "DAC L2 Switch", "DAC L2 Mux"},
 	{"Stereo DAC MIXL", "ANC Switch", "ANC"},
@@ -1614,8 +1621,10 @@ static const struct snd_soc_dapm_route rt5640_specific_dapm_routes[] = {
 
 	{"DAC L2", NULL, "Mono DAC MIXL"},
 	{"DAC L2", NULL, "PLL1", is_sys_clk_from_pll},
+	{"DAC L2", NULL, "DAC L2 Power"},
 	{"DAC R2", NULL, "Mono DAC MIXR"},
 	{"DAC R2", NULL, "PLL1", is_sys_clk_from_pll},
+	{"DAC R2", NULL, "DAC R2 Power"},
 
 	{"SPK MIXL", "DAC L2 Switch", "DAC L2"},
 	{"SPK MIXR", "DAC R2 Switch", "DAC R2"},
@@ -1656,8 +1665,8 @@ static const struct snd_soc_dapm_route rt5639_specific_dapm_routes[] = {
 	{"DIG MIXL", "DAC L2 Switch", "IF2 DAC L"},
 	{"DIG MIXR", "DAC R2 Switch", "IF2 DAC R"},
 
-	{"IF2 DAC L", NULL, "DAC L2 Filter"},
-	{"IF2 DAC R", NULL, "DAC R2 Filter"},
+	{"IF2 DAC L", NULL, "DAC L2 Power"},
+	{"IF2 DAC R", NULL, "DAC R2 Power"},
 };
 
 static int get_sdp_info(struct snd_soc_codec *codec, int dai_id)
-- 
2.7.0
