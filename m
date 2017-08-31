From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98927: Added missing \n to end of dev_err messages" to the asoc tree
Date: Thu, 31 Aug 2017 12:54:54 +0100
Message-ID: <E1dnO3i-0000mH-Lr@debutante>
References: <1495162913-21616-1-git-send-email-ryans.lee@maximintegrated.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495162913-21616-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98927: Added missing \n to end of dev_err messages

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

>From 01c6f1b5c832b75af5d34555201050db896285a8 Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Mon, 28 Aug 2017 16:30:56 -0700
Subject: [PATCH] ASoC: max98927: Added missing \n to end of dev_err messages

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 768e84dbcdf6..f74cdb065bf2 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -159,7 +159,7 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		mode = MAX98927_PCM_MASTER_MODE_MASTER;
 		break;
 	default:
-		dev_err(codec->dev, "DAI clock mode unsupported");
+		dev_err(codec->dev, "DAI clock mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -175,7 +175,7 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		invert = MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE;
 		break;
 	default:
-		dev_err(codec->dev, "DAI invert mode unsupported");
+		dev_err(codec->dev, "DAI invert mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -311,7 +311,7 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_32;
 		break;
 	default:
-		dev_err(codec->dev, "format unsupported %d",
+		dev_err(codec->dev, "format unsupported %d\n",
 			params_format(params));
 		goto err;
 	}
-- 
2.14.1
