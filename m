From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 07/21] ASoC: max98383: fix boolean assignments to true/false
Date: Fri,  4 Jan 2019 20:02:35 -0600
Message-ID: <20190105020249.8639-8-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ryan Lee <RyanS.Lee@maximintegrated.com>, Benson Leung <bleung@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Grant Grundler <grundler@chromium.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Reported by Coccinelle:

sound/soc/codecs/max98373.c:411:2-20: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98373.c:922:2-27: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98373.c:924:2-27: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/max98373.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 9c8616a7b61c..528695cd6a1c 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -408,7 +408,7 @@ static int max98373_dac_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(max98373->regmap,
 			MAX98373_R20FF_GLOBAL_SHDN,
 			MAX98373_GLOBAL_EN_MASK, 0);
-		max98373->tdm_mode = 0;
+		max98373->tdm_mode = false;
 		break;
 	default:
 		return 0;
@@ -919,9 +919,9 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 
 	/* update interleave mode info */
 	if (device_property_read_bool(&i2c->dev, "maxim,interleave_mode"))
-		max98373->interleave_mode = 1;
+		max98373->interleave_mode = true;
 	else
-		max98373->interleave_mode = 0;
+		max98373->interleave_mode = false;
 
 
 	/* regmap initialization */
-- 
2.17.1
