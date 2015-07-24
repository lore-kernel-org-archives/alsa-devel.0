From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm1681: Fix setting de-emphasis sampling rate selection" to the asoc tree
Date: Fri, 24 Jul 2015 12:31:16 +0100
Message-ID: <E1ZIbC8-000343-D9@debutante>
References: <1437664946.20606.5.camel@ingics.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437664946.20606.5.camel@ingics.com>
Sender: stable-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Marek Belisko <marek.belisko@streamunlimited.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm1681: Fix setting de-emphasis sampling rate selection

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

>From fa8173a3ef0570affde7da352de202190b3786c2 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 23 Jul 2015 23:22:26 +0800
Subject: [PATCH] ASoC: pcm1681: Fix setting de-emphasis sampling rate
 selection

The de-emphasis sampling rate selection is controlled by BIT[3:4] of
PCM1681_DEEMPH_CONTROL register. Do proper left shift to set it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Marek Belisko <marek.belisko@streamunlimited.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/pcm1681.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index 477e13d30971..e7ba557979cb 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -102,7 +102,7 @@ static int pcm1681_set_deemph(struct snd_soc_codec *codec)
 
 	if (val != -1) {
 		regmap_update_bits(priv->regmap, PCM1681_DEEMPH_CONTROL,
-					PCM1681_DEEMPH_RATE_MASK, val);
+				   PCM1681_DEEMPH_RATE_MASK, val << 3);
 		enable = 1;
 	} else
 		enable = 0;
-- 
2.1.4
