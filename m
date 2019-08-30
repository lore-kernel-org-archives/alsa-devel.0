From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: Convert Allwinner A33 codec to a schema"
 to the asoc tree
Date: Fri, 30 Aug 2019 17:06:07 +0100 (BST)
Message-ID: <20190830160607.A4AD82742BD3@ypsilon.sirena.org.uk>
References: <20190828125209.28173-3-mripard@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190828125209.28173-3-mripard@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: Convert Allwinner A33 codec to a schema

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

>From 8a99f76ac1a591f27f5216951bf8a8fdad58e987 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Wed, 28 Aug 2019 14:52:07 +0200
Subject: [PATCH] ASoC: dt-bindings: Convert Allwinner A33 codec to a schema

The Allwinner A33 SoC have an embedded audio codec that is supported in Linux,
with a matching Device Tree binding.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/20190828125209.28173-3-mripard@kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../sound/allwinner,sun8i-a33-codec.yaml      | 57 +++++++++++++++++
 .../bindings/sound/sun8i-a33-codec.txt        | 63 -------------------
 2 files changed, 57 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
new file mode 100644
index 000000000000..5e7cc05bbff1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/allwinner,sun8i-a33-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A33 Codec Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    const: allwinner,sun8i-a33-codec
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mod
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    audio-codec@1c22e00 {
+      #sound-dai-cells = <0>;
+      compatible = "allwinner,sun8i-a33-codec";
+      reg = <0x01c22e00 0x400>;
+      interrupts = <0 29 4>;
+      clocks = <&ccu 47>, <&ccu 92>;
+      clock-names = "bus", "mod";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
deleted file mode 100644
index 7ecf6bd60d27..000000000000
--- a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-Allwinner SUN8I audio codec
-------------------------------------
-
-On Sun8i-A33 SoCs, the audio is separated in different parts:
-	  - A DAI driver. It uses the "sun4i-i2s" driver which is
-	  documented here:
-	  Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
-	  - An analog part of the codec which is handled as PRCM registers.
-	  See Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
-	  - An digital part of the codec which is documented in this current
-	  binding documentation.
-	  - And finally, an audio card which links all the above components.
-	  The simple-audio card will be used.
-	  See Documentation/devicetree/bindings/sound/simple-card.txt
-
-This bindings documentation exposes Sun8i codec (digital part).
-
-Required properties:
-- compatible: must be "allwinner,sun8i-a33-codec"
-- reg: must contain the registers location and length
-- interrupts: must contain the codec interrupt
-- clocks: a list of phandle + clock-specifer pairs, one for each entry
-  in clock-names.
-- clock-names: should contain followings:
-   - "bus": the parent APB clock for this controller
-   - "mod": the parent module clock
-
-Here is an example to add a sound card and the codec binding on sun8i SoCs that
-are similar to A33 using simple-card:
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "sun8i-a33-audio";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,frame-master = <&link_codec>;
-		simple-audio-card,bitclock-master = <&link_codec>;
-		simple-audio-card,mclk-fs = <512>;
-		simple-audio-card,aux-devs = <&codec_analog>;
-		simple-audio-card,routing =
-				"Left DAC", "Digital Left DAC",
-				"Right DAC", "Digital Right DAC";
-
-		simple-audio-card,cpu {
-			sound-dai = <&dai>;
-		};
-
-		link_codec: simple-audio-card,codec {
-			sound-dai = <&codec>;
-		};
-
-	soc@1c00000 {
-		[...]
-
-		audio-codec@1c22e00 {
-			#sound-dai-cells = <0>;
-			compatible = "allwinner,sun8i-a33-codec";
-			reg = <0x01c22e00 0x400>;
-			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
-			clock-names = "bus", "mod";
-		};
-	};
-
-- 
2.20.1
