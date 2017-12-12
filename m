From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Add support for A83T" to the asoc tree
Date: Tue, 12 Dec 2017 11:16:54 +0000
Message-ID: <E1eOiYQ-0007uD-6c@debutante>
References: <20171212081148.9194-2-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171212081148.9194-2-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>, linux-arm-kernel@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-i2s: Add support for A83T

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

>From 21faaea1343f2f8dc6539302c92231afc6d999a5 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 12 Dec 2017 16:11:45 +0800
Subject: [PATCH] ASoC: sun4i-i2s: Add support for A83T

The I2S controller in the A83T is mostly compatible with the one found
in earlier SoCs such as the A20 and A31. While the documents publicly
available for the A83T do not cover this hardware, the officially
released BSP kernel does have register definitions for it. These were
matched against the A20 user manual. The only difference is the TX FIFO
and interrupt status registers have been swapped around, like what we
have seen with the SPDIF controller.

This patch adds support for this hardware.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sun4i-i2s.txt         |  2 ++
 sound/soc/sunxi/sun4i-i2s.c                         | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
index 05d7135a8d2f..b9d50d6cdef3 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -8,6 +8,7 @@ Required properties:
 - compatible: should be one of the following:
    - "allwinner,sun4i-a10-i2s"
    - "allwinner,sun6i-a31-i2s"
+   - "allwinner,sun8i-a83t-i2s"
    - "allwinner,sun8i-h3-i2s"
 - reg: physical base address of the controller and length of memory mapped
   region.
@@ -23,6 +24,7 @@ Required properties:
 
 Required properties for the following compatibles:
 	- "allwinner,sun6i-a31-i2s"
+	- "allwinner,sun8i-a83t-i2s"
 	- "allwinner,sun8i-h3-i2s"
 - resets: phandle to the reset line for this codec
 
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 04f92583a969..13d7ecabe1b6 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -897,6 +897,23 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
 };
 
+static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
+	.has_reset		= true,
+	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
+	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
+	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
+	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
+	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
+	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.has_slave_select_bit	= true,
+	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
+	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
+	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
+	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
+	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
+};
+
 static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
@@ -1120,6 +1137,10 @@ static const struct of_device_id sun4i_i2s_match[] = {
 		.compatible = "allwinner,sun6i-a31-i2s",
 		.data = &sun6i_a31_i2s_quirks,
 	},
+	{
+		.compatible = "allwinner,sun8i-a83t-i2s",
+		.data = &sun8i_a83t_i2s_quirks,
+	},
 	{
 		.compatible = "allwinner,sun8i-h3-i2s",
 		.data = &sun8i_h3_i2s_quirks,
-- 
2.15.1
