From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 17/21] ASoC: mt6351: remove unneeded variable
Date: Fri,  4 Jan 2019 20:02:45 -0600
Message-ID: <20190105020249.8639-18-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Kai Chieh Chuang <kaichieh.chuang@mediatek.com>, Wei Yongjun <weiyongjun1@huawei.com>, "moderated list:ARM/Mediatek SoC
        support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
        support" <linux-mediatek@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Reported by Coccinelle:
mt6351.c:1418:5-8: Unneeded variable: "ret". Return "0" on line 1437

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.17.1
