From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Fix da7219->alc_en state when enabling ALC" to the asoc tree
Date: Wed, 21 Oct 2015 13:34:04 +0100
Message-ID: <E1Zosai-0003xc-0o@finisterre>
References: <1445387677.5319.1.camel@ingics.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1445387677.5319.1.camel@ingics.com>
Sender: stable-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Fix da7219->alc_en state when enabling ALC

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

>From c5cff89b5f64b4fc7f6fd9be44b1aa7e766a94e4 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 21 Oct 2015 08:34:37 +0800
Subject: [PATCH] ASoC: da7219: Fix da7219->alc_en state when enabling ALC

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Tested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index abba4b3..f238c1e 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -402,7 +402,7 @@ static int da7219_alc_sw_put(struct snd_kcontrol *kcontrol,
 	/* Force ALC offset calibration if enabling ALC */
 	if ((ucontrol->value.integer.value[0]) && (!da7219->alc_en)) {
 		da7219_alc_calib(codec);
-		da7219->alc_en = false;
+		da7219->alc_en = true;
 	} else {
 		da7219->alc_en = false;
 	}
-- 
2.6.1
