From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98926: add missing \n to end of dev_err/dev_dbg messages" to the asoc tree
Date: Sat, 24 Sep 2016 22:58:13 -0700
Message-ID: <E1bo2S5-0002sT-BF@finisterre>
References: <20160916165216.12041-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160916165216.12041-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, trivial@kernel.org, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, anish kumar <yesanishhere@gmail.com>, Axel Lin <axel.lin@ingics.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98926: add missing \n to end of dev_err/dev_dbg messages

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

>From 478cc9f93c28dccd1db373a4c996fefb5d67b072 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 16 Sep 2016 17:52:16 +0100
Subject: [PATCH] ASoC: max98926: add missing \n to end of dev_err/dev_dbg
 messages

Trival fix, some dev_err and deb_dbg messages are missing a \n, so
add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98926.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 8d14adae5cc5..96073d41fab5 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -347,7 +347,7 @@ static int max98926_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		max98926_set_sense_data(max98926);
 		break;
 	default:
-		dev_err(codec->dev, "DAI clock mode unsupported");
+		dev_err(codec->dev, "DAI clock mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -364,7 +364,7 @@ static int max98926_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		invert = MAX98926_DAI_BCI_MASK | MAX98926_DAI_WCI_MASK;
 		break;
 	default:
-		dev_err(codec->dev, "DAI invert mode unsupported");
+		dev_err(codec->dev, "DAI invert mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -408,7 +408,7 @@ static int max98926_dai_hw_params(struct snd_pcm_substream *substream,
 		max98926->ch_size = 32;
 		break;
 	default:
-		dev_dbg(codec->dev, "format unsupported %d",
+		dev_dbg(codec->dev, "format unsupported %d\n",
 			params_format(params));
 		return -EINVAL;
 	}
-- 
2.9.3
