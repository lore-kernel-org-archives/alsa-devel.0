From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fix valid stream condition" to the asoc tree
Date: Fri,  3 May 2019 07:21:32 +0100 (BST)
Message-ID: <20190503062132.3FEC1441D6B@finisterre.ee.mobilebroadband>
References: <20190429094750.1857-2-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429094750.1857-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fix valid stream condition

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

>From 6a7c59c6d9f3b280e81d7a04bbe4e55e90152dce Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 29 Apr 2019 11:47:49 +0200
Subject: [PATCH] ASoC: fix valid stream condition

A stream may specify a rate range using 'rate_min' and 'rate_max', so a
stream may be valid and not specify any rates. However, as stream cannot
be valid and not have any channel. Let's use this condition instead to
determine if a stream is valid or not.

Fixes: cde79035c6cf ("ASoC: Handle multiple codecs with split playback / capture")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d21247546f7f..57088bd69e5d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -43,8 +43,8 @@ static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
 	else
 		codec_stream = &dai->driver->capture;
 
-	/* If the codec specifies any rate at all, it supports the stream. */
-	return codec_stream->rates;
+	/* If the codec specifies any channels at all, it supports the stream */
+	return codec_stream->channels_min;
 }
 
 /**
-- 
2.20.1
