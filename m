From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas5086: fix typo: "Inavlid" -> "Invalid"" to the asoc tree
Date: Wed, 24 Aug 2016 12:20:37 +0100
Message-ID: <E1bcWEX-0000Ai-U7@debutante>
References: <20160824064806.15809-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824064806.15809-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas5086: fix typo: "Inavlid" -> "Invalid"

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

>From e56375155e95019cd4abc55d30c2c1a415037e27 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 24 Aug 2016 07:48:06 +0100
Subject: [PATCH] ASoC: tas5086: fix typo: "Inavlid" -> "Invalid"

trivial typo fix in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas5086.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index d49d25d51957..1666ea697647 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -387,7 +387,7 @@ static int tas5086_hw_params(struct snd_pcm_substream *substream,
 	val = index_in_array(tas5086_ratios, ARRAY_SIZE(tas5086_ratios),
 			     priv->mclk / priv->rate);
 	if (val < 0) {
-		dev_err(codec->dev, "Inavlid MCLK / Fs ratio\n");
+		dev_err(codec->dev, "Invalid MCLK / Fs ratio\n");
 		return -EINVAL;
 	}
 
-- 
2.8.1
