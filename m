From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 13/21] ASoC: max98927: fix boolean assignments
Date: Fri,  4 Jan 2019 20:02:41 -0600
Message-ID: <20190105020249.8639-14-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Reported by Coccinelle:
sound/soc/codecs/max98927.c:508:2-20: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:889:3-28: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:891:3-28: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:893:2-27: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.17.1
