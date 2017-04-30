From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4271: configure reset GPIO as output" to the asoc tree
Date: Sun, 30 Apr 2017 21:58:27 +0900
Message-ID: <E1d4oQl-00045I-Q5@finisterre>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: 
Sender: stable-owner@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4271: configure reset GPIO as output

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

>From 49b2e27ab9f66b0a22c21980ad8118a4038324ae Mon Sep 17 00:00:00 2001
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Date: Sat, 29 Apr 2017 12:19:33 +0200
Subject: [PATCH] ASoC: cs4271: configure reset GPIO as output

During reset "refactoring" the output configuration was lost.
This commit repairs sound on EDB93XX boards.

Fixes: 9a397f4 ("ASoC: cs4271: add regulator consumer support")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 4.6+
---
 sound/soc/codecs/cs4271.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 8c0f3b89b5bc..e78b5f055f25 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -498,7 +498,7 @@ static int cs4271_reset(struct snd_soc_codec *codec)
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 
 	if (gpio_is_valid(cs4271->gpio_nreset)) {
-		gpio_set_value(cs4271->gpio_nreset, 0);
+		gpio_direction_output(cs4271->gpio_nreset, 0);
 		mdelay(1);
 		gpio_set_value(cs4271->gpio_nreset, 1);
 		mdelay(1);
-- 
2.11.0
