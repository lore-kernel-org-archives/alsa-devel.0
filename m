From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: Fix a typo in the name of a function" to the asoc tree
Date: Tue, 23 Jul 2019 12:29:10 +0100 (BST)
Message-ID: <20190723112910.E55942742B60@ypsilon.sirena.org.uk>
References: <20190722212639.26954-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722212639.26954-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: alsa-devel@alsa-project.org, bardliao@realtek.com, broonie@kernel.org, chiou@realtek.com, kernel-janitors@vger.kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: Fix a typo in the name of a function

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From f90aa354be7bffaec2b440eb1831c429ecb1a5e2 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 22 Jul 2019 23:26:39 +0200
Subject: [PATCH] ASoC: rt5665: Fix a typo in the name of a function

All function names start with rt5665_, except 'rt5655_set_verf()'.
It is likely a typo.

Fix it to be consistent.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20190722212639.26954-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index c050d84a6916..68299ce26d3e 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -2566,7 +2566,7 @@ static int set_dmic_power(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int rt5655_set_verf(struct snd_soc_dapm_widget *w,
+static int rt5665_set_verf(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
@@ -2686,11 +2686,11 @@ static const struct snd_soc_dapm_widget rt5665_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Mic Det Power", RT5665_PWR_VOL,
 		RT5665_PWR_MIC_DET_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("Vref1", RT5665_PWR_ANLG_1, RT5665_PWR_VREF1_BIT, 0,
-		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		rt5665_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("Vref2", RT5665_PWR_ANLG_1, RT5665_PWR_VREF2_BIT, 0,
-		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		rt5665_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("Vref3", RT5665_PWR_ANLG_1, RT5665_PWR_VREF3_BIT, 0,
-		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+		rt5665_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 
 	/* ASRC */
 	SND_SOC_DAPM_SUPPLY_S("I2S1 ASRC", 1, RT5665_ASRC_1,
-- 
2.20.1
