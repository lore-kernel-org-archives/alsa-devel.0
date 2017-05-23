From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ASoC: cht_bsw_max98090_ti: Remove unused function cht_get_codec_dai()
Date: Tue, 23 May 2017 12:05:09 -0700
Message-ID: <20170523190509.59212-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Yang A Fang <yang.a.fang@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

Looks like the function has never been used since it was added by commit
17119a465706 ("ASoC: Intel: Add Cherrytrail & Braswell machine driver
cht_bsw_max98090_ti"). Removing it fixes the following warning when
building with clang:

sound/soc/intel/boards/cht_bsw_max98090_ti.c:42:35: error: unused
    function 'cht_get_codec_dai' [-Werror,-Wunused-function]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 742bc0d4e681..20755ecc7f9e 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -39,18 +39,6 @@ struct cht_mc_private {
 	bool ts3a227e_present;
 };
 
-static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	list_for_each_entry(rtd, &card->rtd_list, list) {
-		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
-			     strlen(CHT_CODEC_DAI)))
-			return rtd->codec_dai;
-	}
-	return NULL;
-}
-
 static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-- 
2.13.0.219.gdb65acc882-goog
