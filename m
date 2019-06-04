From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Fix sun8i tx channel offset mask" to the asoc tree
Date: Tue,  4 Jun 2019 15:58:57 +0100 (BST)
Message-ID: <20190604145857.84383440049@finisterre.sirena.org.uk>
References: <20190603174735.21002-2-codekipper@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190603174735.21002-2-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Cooper <codekipper@gmail.com>
Cc: alsa-devel@alsa-project.org, be17068@iperbole.bo.it, broonie@kernel.org, Chen-Yu Tsai <wens@csie.org>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.comMark Brown <broonie@kernel.org>, maxime.ripard@free-electrons.com, Maxime Ripard <maxime.ripard@bootlin.com>wens@csie.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-i2s: Fix sun8i tx channel offset mask

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

>From 7e46169a5f35762f335898a75d1b8a242f2ae0f5 Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Mon, 3 Jun 2019 19:47:27 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Fix sun8i tx channel offset mask

Although not causing any noticeable issues, the mask for the
channel offset is covering too many bits.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d5ec1a20499d..8162e107e50b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -110,7 +110,7 @@
 
 #define SUN8I_I2S_TX_CHAN_MAP_REG	0x44
 #define SUN8I_I2S_TX_CHAN_SEL_REG	0x34
-#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 11)
+#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 12)
 #define SUN8I_I2S_TX_CHAN_OFFSET(offset)	(offset << 12)
 #define SUN8I_I2S_TX_CHAN_EN_MASK		GENMASK(11, 4)
 #define SUN8I_I2S_TX_CHAN_EN(num_chan)		(((1 << num_chan) - 1) << 4)
-- 
2.20.1
