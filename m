From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cht_bsw_max98090_ti: Remove unused function cht_get_codec_dai()" to the asoc tree
Date: Wed, 24 May 2017 18:42:04 +0100
Message-ID: <E1dDaIO-0002si-IG@debutante>
References: <20170523190509.59212-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523190509.59212-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Yang A Fang <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cht_bsw_max98090_ti: Remove unused function cht_get_codec_dai()

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

>From 140385d87adce8d00864667f5132770ac5a13dac Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Tue, 23 May 2017 12:05:09 -0700
Subject: [PATCH] ASoC: cht_bsw_max98090_ti: Remove unused function
 cht_get_codec_dai()

Looks like the function has never been used since it was added by commit
17119a465706 ("ASoC: Intel: Add Cherrytrail & Braswell machine driver
cht_bsw_max98090_ti"). Removing it fixes the following warning when
building with clang:

sound/soc/intel/boards/cht_bsw_max98090_ti.c:42:35: error: unused
    function 'cht_get_codec_dai' [-Werror,-Wunused-function]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.11.0
