From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 2/9] ASoC: sun4i-i2s: Add compatibility with A64 codec I2S
Date: Sun,  3 Dec 2017 12:41:50 -0800
Message-ID: <20171203204157.20829-3-anarsoul@gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171203204157.20829-1-anarsoul@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Marcus Cooper <codekipper@gmail.com>, =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper@gmail.com>

The I2S block used for the audio codec in the A64 is very similar
to what is used by the A10(sun4i) devices. However, its TX FIFO is
located at a different address.

[vasilykh: - added fixed_wss and wss_value to A64 quirks,
	   - changed compatible to 'allwinner,sun50i-a64-acodec-i2s,
	     since A64 has 3 more I2S blocks that are not compatible
	     with audio codec I2S]

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../devicetree/bindings/sound/sun4i-i2s.txt        |  2 ++
 sound/soc/sunxi/sun4i-i2s.c                        | 23 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
index 05d7135a8d2f..ab86f266962a 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -9,6 +9,7 @@ Required properties:
    - "allwinner,sun4i-a10-i2s"
    - "allwinner,sun6i-a31-i2s"
    - "allwinner,sun8i-h3-i2s"
+   - "allwinner,sun50i-a64-acodec-i2s"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
@@ -24,6 +25,7 @@ Required properties:
 Required properties for the following compatibles:
 	- "allwinner,sun6i-a31-i2s"
 	- "allwinner,sun8i-h3-i2s"
+	- "allwinner,sun50i-a64-acodec-i2s"
 - resets: phandle to the reset line for this codec
 
 Example:
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 54c16eb64713..2c060e015725 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -942,6 +942,25 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.field_rxchansel	= REG_FIELD(SUN8I_I2S_RX_CHAN_SEL_REG, 0, 2),
 };
 
+static const struct sun4i_i2s_quirks sun50i_a64_acodec_i2s_quirks = {
+	.has_reset		= true,
+	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
+	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.has_slave_select_bit	= true,
+	.fixed_wss		= true,
+	.wss_value		= 3,
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
+	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
+	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
+	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
+	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
+	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
+	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
+	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
+	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
+};
+
 static int sun4i_i2s_init_regmap_fields(struct device *dev,
 					struct sun4i_i2s *i2s)
 {
@@ -1146,6 +1165,10 @@ static const struct of_device_id sun4i_i2s_match[] = {
 		.compatible = "allwinner,sun8i-h3-i2s",
 		.data = &sun8i_h3_i2s_quirks,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-acodec-i2s",
+		.data = &sun50i_a64_acodec_i2s_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
-- 
2.15.0
