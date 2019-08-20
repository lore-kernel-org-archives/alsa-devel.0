From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Replace call to params_channels by local variable" to the asoc tree
Date: Tue, 20 Aug 2019 18:41:06 +0100 (BST)
Message-ID: <20190820174106.D4AE3274314C@ypsilon.sirena.org.uk>
References: <c0faaac69ad40248f24eed3c3b2fa1ccc4a85b70.1566242458.git-series.maxime.ripard@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c0faaac69ad40248f24eed3c3b2fa1ccc4a85b70.1566242458.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, Maxime Ripard <mripard@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-i2s: Replace call to params_channels by local variable

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From c7dd0828c088a71f30de8d249f63b2fa9f0d322d Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:10 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Replace call to params_channels by local
 variable

The sun4i_i2s_hw_params already has a variable holding the value returned
by params_channels, so let's just use that variable instead of calling
params_channels multiple times.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/c0faaac69ad40248f24eed3c3b2fa1ccc4a85b70.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d879db581073..77b7b81daf74 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -412,10 +412,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	/* Configure the channels */
 	regmap_field_write(i2s->field_txchansel,
-			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
-
+			   SUN4I_I2S_CHAN_SEL(channels));
 	regmap_field_write(i2s->field_rxchansel,
-			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
+			   SUN4I_I2S_CHAN_SEL(channels));
 
 	if (i2s->variant->has_chsel_tx_chen)
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-- 
2.20.1
