From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8328: Set symmetric rates" to the asoc tree
Date: Tue, 10 May 2016 19:49:19 +0100
Message-ID: <E1b0Cid-0007MI-Tn@debutante>
References: <20160509112437.8924-10-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509112437.8924-10-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328: Set symmetric rates

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

>From ca0d8797397c5daa6260a6c67b845d79f65140f5 Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Mon, 9 May 2016 12:24:37 +0100
Subject: [PATCH] ASoC: es8328: Set symmetric rates

Although the ES8328 does support different rates for capture and
playback, only very limited combinations are supported (8kHz and 48kHz
or 8.0182kHz and 44.1kHz) with most rates required to be symmetric.

Instead of adding a lot of complexity for little gain, let's enforce
symmetric rates.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index b8ca214a5332..2086d7107622 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -703,6 +703,7 @@ static struct snd_soc_dai_driver es8328_dai = {
 		.formats = ES8328_FORMATS,
 	},
 	.ops = &es8328_dai_ops,
+	.symmetric_rates = 1,
 };
 
 static int es8328_suspend(struct snd_soc_codec *codec)
-- 
2.8.1
