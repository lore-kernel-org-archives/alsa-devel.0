From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sunxi: Add A10 I2S controller binding documentation" to the asoc tree
Date: Thu, 30 Jun 2016 13:15:28 +0100
Message-ID: <E1bIasS-00012L-EU@finisterre>
References: <20160615211123.31068-2-maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160615211123.31068-2-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, gianfranco@moddevices.com, linux-kernel@vger.kernel.org, Code Kipper <codekipper@gmail.com>, Andrea Venturi <ennesimamail.av@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sunxi: Add A10 I2S controller binding documentation

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

>From 38c81719b1658fdff7d3509b8a0c6294ce29c3d4 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 15 Jun 2016 23:11:20 +0200
Subject: [PATCH] ASoC: sunxi: Add A10 I2S controller binding documentation

Introduce the device tree binding for the I2S controller found in the
Allwinner A10 and later SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sun4i-i2s.txt        | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
new file mode 100644
index 000000000000..7b526ec64991
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -0,0 +1,34 @@
+* Allwinner A10 I2S controller
+
+The I2S bus (Inter-IC sound bus) is a serial link for digital
+audio data transfer between devices in the system.
+
+Required properties:
+
+- compatible: should be one of the followings
+   - "allwinner,sun4i-a10-i2s"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: should contain the I2S interrupt.
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should include "tx" and "rx".
+- clocks: a list of phandle + clock-specifer pairs, one for each entry in clock-names.
+- clock-names: should contain followings:
+   - "apb" : clock for the I2S bus interface
+   - "mod" : module clock for the I2S controller
+- #sound-dai-cells : Must be equal to 0
+
+Example:
+
+i2s0: i2s@01c22400 {
+	#sound-dai-cells = <0>;
+	compatible = "allwinner,sun4i-a10-i2s";
+	reg = <0x01c22400 0x400>;
+	interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&apb0_gates 3>, <&i2s0_clk>;
+	clock-names = "apb", "mod";
+	dmas = <&dma SUN4I_DMA_NORMAL 3>,
+	       <&dma SUN4I_DMA_NORMAL 3>;
+	dma-names = "rx", "tx";
+};
-- 
2.8.1
