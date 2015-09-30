From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: fix wrong register MIC_BIAS_VOLTAGE setup on probe" to the asoc tree
Date: Wed, 30 Sep 2015 20:32:14 +0100
Message-ID: <E1ZhN6s-00061D-Je@finisterre>
References: <557B0528.2060404@eurekelettronica.it>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <557B0528.2060404@eurekelettronica.it>
Sender: stable-owner@vger.kernel.org
To: Gianluca Renzi <gianlucarenzi@eurekelettronica.it>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: fix wrong register MIC_BIAS_VOLTAGE setup on probe

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

>From e256da84a04ea31c3c215997c847609af224e8f4 Mon Sep 17 00:00:00 2001
From: Gianluca Renzi <gianlucarenzi@eurekelettronica.it>
Date: Fri, 25 Sep 2015 21:33:41 +0200
Subject: [PATCH] ASoC: sgtl5000: fix wrong register MIC_BIAS_VOLTAGE setup on
 probe

Signed-off-by: Gianluca Renzi <gianlucarenzi@eurekelettronica.it>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/sgtl5000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 6e7843e..f540f82 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1376,8 +1376,8 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 			sgtl5000->micbias_resistor << SGTL5000_BIAS_R_SHIFT);
 
 	snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
-			SGTL5000_BIAS_R_MASK,
-			sgtl5000->micbias_voltage << SGTL5000_BIAS_R_SHIFT);
+			SGTL5000_BIAS_VOLT_MASK,
+			sgtl5000->micbias_voltage << SGTL5000_BIAS_VOLT_SHIFT);
 	/*
 	 * disable DAP
 	 * TODO:
-- 
2.5.0
