From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98927: fix boolean assignments" to the asoc tree
Date: Mon,  7 Jan 2019 18:58:13 +0000 (GMT)
Message-ID: <20190107185813.1B96C1127492@debutante.sirena.org.uk>
References: <20190105020249.8639-14-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-14-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.combroonie@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98927: fix boolean assignments

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

>From 091cd877d8d6b2b934d565134172db771907d50a Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:41 -0600
Subject: [PATCH] ASoC: max98927: fix boolean assignments

Reported by Coccinelle:
sound/soc/codecs/max98927.c:508:2-20: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:889:3-28: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:891:3-28: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:893:2-27: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 065303a46535..e53d2007f3be 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -505,7 +505,7 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		max98927->tdm_mode = 0;
+		max98927->tdm_mode = false;
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_update_bits(max98927->regmap,
@@ -886,11 +886,11 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	if (!of_property_read_u32(i2c->dev.of_node,
 		"interleave_mode", &value)) {
 		if (value > 0)
-			max98927->interleave_mode = 1;
+			max98927->interleave_mode = true;
 		else
-			max98927->interleave_mode = 0;
+			max98927->interleave_mode = false;
 	} else
-		max98927->interleave_mode = 0;
+		max98927->interleave_mode = false;
 
 	/* regmap initialization */
 	max98927->regmap
-- 
2.20.1
