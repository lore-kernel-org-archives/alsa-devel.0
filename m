From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: fix line out no sound issue" to the asoc tree
Date: Tue, 11 Aug 2015 19:01:09 +0100
Message-ID: <E1ZPDrJ-0007Mg-0d@finisterre>
References: <1439274445-22547-1-git-send-email-john.lin@realtek.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1439274445-22547-1-git-send-email-john.lin@realtek.com>
Sender: stable-owner@vger.kernel.org
To: John Lin <john.lin@realtek.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: fix line out no sound issue

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

>From 9b850ca4f1c5acd7fcbbd4b38a2d27132801a8d5 Mon Sep 17 00:00:00 2001
From: John Lin <john.lin@realtek.com>
Date: Tue, 11 Aug 2015 14:27:25 +0800
Subject: [PATCH] ASoC: rt5640: fix line out no sound issue

The power for line out was not turned on when line out is enabled.
So we add "LOUT amp" widget to turn on the power for line out.

Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/rt5640.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 9bc78e5..ff72cd8 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -984,6 +984,35 @@ static int rt5640_hp_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5640_lout_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		hp_amp_power_on(codec);
+		snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
+			RT5640_PWR_LM, RT5640_PWR_LM);
+		snd_soc_update_bits(codec, RT5640_OUTPUT,
+			RT5640_L_MUTE | RT5640_R_MUTE, 0);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT5640_OUTPUT,
+			RT5640_L_MUTE | RT5640_R_MUTE,
+			RT5640_L_MUTE | RT5640_R_MUTE);
+		snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
+			RT5640_PWR_LM, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static int rt5640_hp_power_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
@@ -1179,13 +1208,16 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 		0, rt5640_spo_l_mix, ARRAY_SIZE(rt5640_spo_l_mix)),
 	SND_SOC_DAPM_MIXER("SPOR MIX", SND_SOC_NOPM, 0,
 		0, rt5640_spo_r_mix, ARRAY_SIZE(rt5640_spo_r_mix)),
-	SND_SOC_DAPM_MIXER("LOUT MIX", RT5640_PWR_ANLG1, RT5640_PWR_LM_BIT, 0,
+	SND_SOC_DAPM_MIXER("LOUT MIX", SND_SOC_NOPM, 0, 0,
 		rt5640_lout_mix, ARRAY_SIZE(rt5640_lout_mix)),
 	SND_SOC_DAPM_SUPPLY_S("Improve HP Amp Drv", 1, SND_SOC_NOPM,
 		0, 0, rt5640_hp_power_event, SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0,
 		rt5640_hp_event,
 		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_S("LOUT amp", 1, SND_SOC_NOPM, 0, 0,
+		rt5640_lout_event,
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("HP L Amp", RT5640_PWR_ANLG1,
 		RT5640_PWR_HP_L_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("HP R Amp", RT5640_PWR_ANLG1,
@@ -1500,8 +1532,10 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"HP R Playback", "Switch", "HP Amp"},
 	{"HPOL", NULL, "HP L Playback"},
 	{"HPOR", NULL, "HP R Playback"},
-	{"LOUTL", NULL, "LOUT MIX"},
-	{"LOUTR", NULL, "LOUT MIX"},
+
+	{"LOUT amp", NULL, "LOUT MIX"},
+	{"LOUTL", NULL, "LOUT amp"},
+	{"LOUTR", NULL, "LOUT amp"},
 };
 
 static const struct snd_soc_dapm_route rt5640_specific_dapm_routes[] = {
-- 
2.5.0
