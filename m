From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 16/21] ASoC: tscs42xx.c: fix boolean test
Date: Fri,  4 Jan 2019 20:02:44 -0600
Message-ID: <20190105020249.8639-17-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Steven Eckhoff <steven.eckhoff.opensource@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Reported by Coccinelle:
sound/soc/codecs/tscs42xx.c:392:5-31: WARNING: Comparison to bool

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/tscs42xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index 7396a6e5277e..27b8c6ba72fa 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -389,7 +389,7 @@ static int dac_event(struct snd_soc_dapm_widget *w,
 
 	mutex_lock(&tscs42xx->coeff_ram_lock);
 
-	if (tscs42xx->coeff_ram_synced == false) {
+	if (!tscs42xx->coeff_ram_synced) {
 		ret = write_coeff_ram(component, tscs42xx->coeff_ram, 0x00,
 			COEFF_RAM_COEFF_COUNT);
 		if (ret < 0)
-- 
2.17.1
