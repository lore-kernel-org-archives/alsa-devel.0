From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: add workaround for silence of rk3288 ACODEC" to the asoc tree
Date: Fri,  4 Jan 2019 17:09:08 +0000 (GMT)
Message-ID: <20190104170908.7DD6F11270A3@debutante.sirena.org.uk>
References: <20181220153636.5213-2-katsuhiro@katsuster.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181220153636.5213-2-katsuhiro@katsuster.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: add workaround for silence of rk3288 ACODEC

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

>From f5758544d98c8bec7793aeea28928f5e8bd45d47 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Fri, 21 Dec 2018 00:36:36 +0900
Subject: [PATCH] ASoC: rockchip: add workaround for silence of rk3288 ACODEC

This patch adds reset and precharge in shutdown of PCM device.

ACODEC goes to silence if we change Fs to 44.1kHz from 48kHz. This
workaround seems to work but I don't know this workaround is correct
sequence or not for ACODEC.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rk3328_codec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index 71f3fc2d970c..f3442a2283ea 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -261,9 +261,12 @@ static int rk3328_codec_close_playback(struct rk3328_codec_priv *rk3328)
 		mdelay(1);
 	}
 
+	/* Workaround for silence when changed Fs 48 -> 44.1kHz */
+	rk3328_codec_reset(rk3328);
+
 	regmap_update_bits(rk3328->regmap, DAC_PRECHARGE_CTRL,
 			   DAC_CHARGE_CURRENT_ALL_MASK,
-			   DAC_CHARGE_CURRENT_I);
+			   DAC_CHARGE_CURRENT_ALL_ON);
 
 	return 0;
 }
-- 
2.20.1
