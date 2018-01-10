From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: Added missing blank lines" to the asoc tree
Date: Wed, 10 Jan 2018 11:13:57 +0000
Message-ID: <E1eZEKT-00058S-Sq@debutante>
References: <1515560521-10850-2-git-send-email-ryans.lee@maximintegrated.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515560521-10850-2-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc: Ryan Lee <ryans.lee@maximintegrated.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.comryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373: Added missing blank lines

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

>From e1053262cf318a2bb4a0e1e9c402a3033c669381 Mon Sep 17 00:00:00 2001
From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Date: Tue, 9 Jan 2018 21:01:59 -0800
Subject: [PATCH] ASoC: max98373: Added missing blank lines

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 9af0d985d6e9..cb389571b253 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -176,6 +176,7 @@ static int max98373_get_bclk_sel(int bclk)
 	}
 	return 0;
 }
+
 static int max98373_set_clock(struct snd_soc_codec *codec,
 	struct snd_pcm_hw_params *params)
 {
@@ -270,6 +271,7 @@ static int max98373_dai_hw_params(struct snd_pcm_substream *substream,
 			params_rate(params));
 		goto err;
 	}
+
 	/* set DAI_SR to correct LRCLK frequency */
 	regmap_update_bits(max98373->regmap,
 		MAX98373_R2027_PCM_SR_SETUP_1,
-- 
2.15.1
