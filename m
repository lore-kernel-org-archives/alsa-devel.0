From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Add offset to RX channel select" to the asoc tree
Date: Tue,  4 Jun 2019 15:58:56 +0100 (BST)
Message-ID: <20190604145856.F07A6440046@finisterre.sirena.org.uk>
References: <20190603174735.21002-3-codekipper@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190603174735.21002-3-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Cooper <codekipper@gmail.com>
Cc: alsa-devel@alsa-project.org, be17068@iperbole.bo.it, broonie@kernel.org, Chen-Yu Tsai <wens@csie.org>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.comMark Brown <broonie@kernel.org>, maxime.ripard@free-electrons.com, Maxime Ripard <maxime.ripard@bootlin.com>wens@csie.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-i2s: Add offset to RX channel select

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From f9927000cb35f250051f0f1878db12ee2626eea1 Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Mon, 3 Jun 2019 19:47:28 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Add offset to RX channel select

Whilst testing the capture functionality of the i2s on the newer
SoCs it was noticed that the recording was somewhat distorted.
This was due to the offset not being set correctly on the receiver
side.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8162e107e50b..bc128e2a6096 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -460,6 +460,10 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
 				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
+
+		regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
+				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
+				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
 	}
 
 	regmap_field_write(i2s->field_fmt_mode, val);
-- 
2.20.1
