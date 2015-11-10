From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Avoid the pop sound that comes
	from the filter power" to the asoc tree
Date: Tue, 10 Nov 2015 18:59:56 +0000
Message-ID: <E1ZwE96-00026Q-Mj@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5FE9260575
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 20:00:02 +0100 (CET)
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
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: Avoid the pop sound that comes from the filter power

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

>From c22d7666c5c4473cfffe8c40fcf86bd6e16317df Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Mon, 9 Nov 2015 18:01:04 +0800
Subject: [PATCH] ASoC: rt5677: Avoid the pop sound that comes from the filter
 power

The patch changes the type of DACs mixer to AUTODISABLE and add the delay
time after power up to avoid the pop sound that comes from the filter
power.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 100 ++++++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index b4cd7e3bf5f8..69d987a9935c 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -1386,90 +1386,90 @@ static const struct snd_kcontrol_new rt5677_dac_r_mix[] = {
 };
 
 static const struct snd_kcontrol_new rt5677_sto1_dac_l_mix[] = {
-	SOC_DAPM_SINGLE("ST L Switch", RT5677_STO1_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("ST L Switch", RT5677_STO1_DAC_MIXER,
 			RT5677_M_ST_DAC1_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC1 L Switch", RT5677_STO1_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC1 L Switch", RT5677_STO1_DAC_MIXER,
 			RT5677_M_DAC1_L_STO_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC2 L Switch", RT5677_STO1_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC2 L Switch", RT5677_STO1_DAC_MIXER,
 			RT5677_M_DAC2_L_STO_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC1 R Switch", RT5677_STO1_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC1 R Switch", RT5677_STO1_DAC_MIXER,
 			RT5677_M_DAC1_R_STO_L_SFT, 1, 1),
 };
 
 static const struct snd_kcontrol_new rt5677_sto1_dac_r_mix[] = {
-	SOC_DAPM_SINGLE("ST R Switch", RT5677_STO1_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("ST R Switch", RT5677_STO1_DAC_MIXER,
 			RT5677_M_ST_DAC1_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC1 R Switch", RT5677_STO1_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC1 R Switch", RT5677_STO1_DAC_MIXER,
 			RT5677_M_DAC1_R_STO_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC2 R Switch", RT5677_STO1_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC2 R Switch", RT5677_STO1_DAC_MIXER,
 			RT5677_M_DAC2_R_STO_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC1 L Switch", RT5677_STO1_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC1 L Switch", RT5677_STO1_DAC_MIXER,
 			RT5677_M_DAC1_L_STO_R_SFT, 1, 1),
 };
 
 static const struct snd_kcontrol_new rt5677_mono_dac_l_mix[] = {
-	SOC_DAPM_SINGLE("ST L Switch", RT5677_MONO_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("ST L Switch", RT5677_MONO_DAC_MIXER,
 			RT5677_M_ST_DAC2_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC1 L Switch", RT5677_MONO_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC1 L Switch", RT5677_MONO_DAC_MIXER,
 			RT5677_M_DAC1_L_MONO_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC2 L Switch", RT5677_MONO_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC2 L Switch", RT5677_MONO_DAC_MIXER,
 			RT5677_M_DAC2_L_MONO_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC2 R Switch", RT5677_MONO_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC2 R Switch", RT5677_MONO_DAC_MIXER,
 			RT5677_M_DAC2_R_MONO_L_SFT, 1, 1),
 };
 
 static const struct snd_kcontrol_new rt5677_mono_dac_r_mix[] = {
-	SOC_DAPM_SINGLE("ST R Switch", RT5677_MONO_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("ST R Switch", RT5677_MONO_DAC_MIXER,
 			RT5677_M_ST_DAC2_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC1 R Switch", RT5677_MONO_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC1 R Switch", RT5677_MONO_DAC_MIXER,
 			RT5677_M_DAC1_R_MONO_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC2 R Switch", RT5677_MONO_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC2 R Switch", RT5677_MONO_DAC_MIXER,
 			RT5677_M_DAC2_R_MONO_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC2 L Switch", RT5677_MONO_DAC_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC2 L Switch", RT5677_MONO_DAC_MIXER,
 			RT5677_M_DAC2_L_MONO_R_SFT, 1, 1),
 };
 
 static const struct snd_kcontrol_new rt5677_dd1_l_mix[] = {
-	SOC_DAPM_SINGLE("Sto DAC Mix L Switch", RT5677_DD1_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("Sto DAC Mix L Switch", RT5677_DD1_MIXER,
 			RT5677_M_STO_L_DD1_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("Mono DAC Mix L Switch", RT5677_DD1_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("Mono DAC Mix L Switch", RT5677_DD1_MIXER,
 			RT5677_M_MONO_L_DD1_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC3 L Switch", RT5677_DD1_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC3 L Switch", RT5677_DD1_MIXER,
 			RT5677_M_DAC3_L_DD1_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC3 R Switch", RT5677_DD1_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC3 R Switch", RT5677_DD1_MIXER,
 			RT5677_M_DAC3_R_DD1_L_SFT, 1, 1),
 };
 
 static const struct snd_kcontrol_new rt5677_dd1_r_mix[] = {
-	SOC_DAPM_SINGLE("Sto DAC Mix R Switch", RT5677_DD1_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("Sto DAC Mix R Switch", RT5677_DD1_MIXER,
 			RT5677_M_STO_R_DD1_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("Mono DAC Mix R Switch", RT5677_DD1_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("Mono DAC Mix R Switch", RT5677_DD1_MIXER,
 			RT5677_M_MONO_R_DD1_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC3 R Switch", RT5677_DD1_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC3 R Switch", RT5677_DD1_MIXER,
 			RT5677_M_DAC3_R_DD1_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC3 L Switch", RT5677_DD1_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC3 L Switch", RT5677_DD1_MIXER,
 			RT5677_M_DAC3_L_DD1_R_SFT, 1, 1),
 };
 
 static const struct snd_kcontrol_new rt5677_dd2_l_mix[] = {
-	SOC_DAPM_SINGLE("Sto DAC Mix L Switch", RT5677_DD2_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("Sto DAC Mix L Switch", RT5677_DD2_MIXER,
 			RT5677_M_STO_L_DD2_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("Mono DAC Mix L Switch", RT5677_DD2_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("Mono DAC Mix L Switch", RT5677_DD2_MIXER,
 			RT5677_M_MONO_L_DD2_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC4 L Switch", RT5677_DD2_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC4 L Switch", RT5677_DD2_MIXER,
 			RT5677_M_DAC4_L_DD2_L_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC4 R Switch", RT5677_DD2_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC4 R Switch", RT5677_DD2_MIXER,
 			RT5677_M_DAC4_R_DD2_L_SFT, 1, 1),
 };
 
 static const struct snd_kcontrol_new rt5677_dd2_r_mix[] = {
-	SOC_DAPM_SINGLE("Sto DAC Mix R Switch", RT5677_DD2_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("Sto DAC Mix R Switch", RT5677_DD2_MIXER,
 			RT5677_M_STO_R_DD2_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("Mono DAC Mix R Switch", RT5677_DD2_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("Mono DAC Mix R Switch", RT5677_DD2_MIXER,
 			RT5677_M_MONO_R_DD2_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC4 R Switch", RT5677_DD2_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC4 R Switch", RT5677_DD2_MIXER,
 			RT5677_M_DAC4_R_DD2_R_SFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC4 L Switch", RT5677_DD2_MIXER,
+	SOC_DAPM_SINGLE_AUTODISABLE("DAC4 L Switch", RT5677_DD2_MIXER,
 			RT5677_M_DAC4_L_DD2_R_SFT, 1, 1),
 };
 
@@ -2596,6 +2596,21 @@ static int rt5677_vref_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5677_filter_power_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		msleep(50);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("PLL1", RT5677_PWR_ANLG2, RT5677_PWR_PLL1_BIT,
 		0, rt5677_set_pll1_event, SND_SOC_DAPM_PRE_PMU |
@@ -3072,19 +3087,26 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 
 	/* DAC Mixer */
 	SND_SOC_DAPM_SUPPLY("dac stereo1 filter", RT5677_PWR_DIG2,
-		RT5677_PWR_DAC_S1F_BIT, 0, NULL, 0),
+		RT5677_PWR_DAC_S1F_BIT, 0, rt5677_filter_power_event,
+		SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("dac mono2 left filter", RT5677_PWR_DIG2,
-		RT5677_PWR_DAC_M2F_L_BIT, 0, NULL, 0),
+		RT5677_PWR_DAC_M2F_L_BIT, 0, rt5677_filter_power_event,
+		SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("dac mono2 right filter", RT5677_PWR_DIG2,
-		RT5677_PWR_DAC_M2F_R_BIT, 0, NULL, 0),
+		RT5677_PWR_DAC_M2F_R_BIT, 0, rt5677_filter_power_event,
+		SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("dac mono3 left filter", RT5677_PWR_DIG2,
-		RT5677_PWR_DAC_M3F_L_BIT, 0, NULL, 0),
+		RT5677_PWR_DAC_M3F_L_BIT, 0, rt5677_filter_power_event,
+		SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("dac mono3 right filter", RT5677_PWR_DIG2,
-		RT5677_PWR_DAC_M3F_R_BIT, 0, NULL, 0),
+		RT5677_PWR_DAC_M3F_R_BIT, 0, rt5677_filter_power_event,
+		SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("dac mono4 left filter", RT5677_PWR_DIG2,
-		RT5677_PWR_DAC_M4F_L_BIT, 0, NULL, 0),
+		RT5677_PWR_DAC_M4F_L_BIT, 0, rt5677_filter_power_event,
+		SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("dac mono4 right filter", RT5677_PWR_DIG2,
-		RT5677_PWR_DAC_M4F_R_BIT, 0, NULL, 0),
+		RT5677_PWR_DAC_M4F_R_BIT, 0, rt5677_filter_power_event,
+		SND_SOC_DAPM_POST_PMU),
 
 	SND_SOC_DAPM_MIXER("Stereo DAC MIXL", SND_SOC_NOPM, 0, 0,
 		rt5677_sto1_dac_l_mix, ARRAY_SIZE(rt5677_sto1_dac_l_mix)),
-- 
2.6.2
