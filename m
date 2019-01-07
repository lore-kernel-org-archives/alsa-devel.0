From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: fix boolean assignments" to the asoc tree
Date: Mon,  7 Jan 2019 18:58:11 +0000 (GMT)
Message-ID: <20190107185811.42BF31127491@debutante.sirena.org.uk>
References: <20190105020249.8639-15-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-15-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Oder Chiou <oder_chiou@realtek.com>, tiwai@suse.de, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, liam.r.girdwood@linux.intel.combroonie@kernel.org, Bard Liao <bardliao@realtek.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: fix boolean assignments

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

>From 577dc32f9a6fc20cd404e0eb965659e9271c78be Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:42 -0600
Subject: [PATCH] ASoC: rt5651: fix boolean assignments

Reported by Coccinelle:
sound/soc/codecs/rt5651.c:750:2-17: WARNING: Assignment of bool to 0/1
sound/soc/codecs/rt5651.c:754:2-17: WARNING: Assignment of bool to 0/1
sound/soc/codecs/rt5651.c:2192:1-16: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index b7ba64350a07..3882e238ff99 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -747,11 +747,11 @@ static int rt5651_hp_event(struct snd_soc_dapm_widget *w,
 			RT5651_HP_CP_PD | RT5651_HP_SG_EN);
 		regmap_update_bits(rt5651->regmap, RT5651_PR_BASE +
 			RT5651_CHPUMP_INT_REG1, 0x0700, 0x0400);
-		rt5651->hp_mute = 0;
+		rt5651->hp_mute = false;
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		rt5651->hp_mute = 1;
+		rt5651->hp_mute = true;
 		usleep_range(70000, 75000);
 		break;
 
@@ -2189,7 +2189,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
 	rt5651->irq = i2c->irq;
-	rt5651->hp_mute = 1;
+	rt5651->hp_mute = true;
 
 	INIT_DELAYED_WORK(&rt5651->bp_work, rt5651_button_press_work);
 	INIT_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
-- 
2.20.1
