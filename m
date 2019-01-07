From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mt6351: remove unneeded variable" to the asoc tree
Date: Mon,  7 Jan 2019 18:58:05 +0000 (GMT)
Message-ID: <20190107185805.B04001127491@debutante.sirena.org.uk>
References: <20190105020249.8639-18-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-18-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.combroonie@kernel.org, Wei Yongjun <weiyongjun1@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, Kai Chieh Chuang <kaichieh.chuang@mediatek.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mt6351: remove unneeded variable

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

>From d61780c155e8bef8dceb3ac98d29f79c24e264eb Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:45 -0600
Subject: [PATCH] ASoC: mt6351: remove unneeded variable

Reported by Coccinelle:
mt6351.c:1418:5-8: Unneeded variable: "ret". Return "0" on line 1437

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/mt6351.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/mt6351.c b/sound/soc/codecs/mt6351.c
index f73dcd753584..4b3ce01c5a93 100644
--- a/sound/soc/codecs/mt6351.c
+++ b/sound/soc/codecs/mt6351.c
@@ -1415,8 +1415,6 @@ static const struct snd_soc_dapm_route mt6351_dapm_routes[] = {
 
 static int mt6351_codec_init_reg(struct snd_soc_component *cmpnt)
 {
-	int ret = 0;
-
 	/* Disable CLKSQ 26MHz */
 	regmap_update_bits(cmpnt->regmap, MT6351_TOP_CLKSQ, 0x0001, 0x0);
 	/* disable AUDGLB */
@@ -1434,7 +1432,7 @@ static int mt6351_codec_init_reg(struct snd_soc_component *cmpnt)
 	/* Reverse the PMIC clock*/
 	regmap_update_bits(cmpnt->regmap, MT6351_AFE_PMIC_NEWIF_CFG2,
 			   0x8000, 0x8000);
-	return ret;
+	return 0;
 }
 
 static int mt6351_codec_probe(struct snd_soc_component *cmpnt)
-- 
2.20.1
