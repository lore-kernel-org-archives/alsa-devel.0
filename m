From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Drop unit-addresses without reg properties" to the asoc tree
Date: Wed, 30 Aug 2017 16:22:41 +0100
Message-ID: <E1dn4pF-0003RT-4T@debutante>
References: <1504087266-5807-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1504087266-5807-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Drop unit-addresses without reg properties

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

>From a5702e1cb3c47221419617089d59f9741cf981e4 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 30 Aug 2017 12:01:06 +0200
Subject: [PATCH] ASoC: rsnd: Drop unit-addresses without reg properties

Nodes without reg properties must not have unit addresses:

    Warning (unit_address_vs_reg): Node .../rcar_sound,dvc/dvc@0 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/renesas,rsnd.txt     | 68 +++++++++++-----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 7246bb268bf9..a1536fdc60e6 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -199,10 +199,10 @@ Ex)
 	sound {
 		compatible = "simple-scu-audio-card";
 		...
-		simple-audio-card,cpu@0 {
+		simple-audio-card,cpu-0 {
 			sound-dai = <&rcar_sound 0>;
 		};
-		simple-audio-card,cpu@1 {
+		simple-audio-card,cpu-1 {
 			sound-dai = <&rcar_sound 1>;
 		};
 		simple-audio-card,codec {
@@ -441,79 +441,79 @@ rcar_sound: sound@ec500000 {
 			"clk_a", "clk_b", "clk_c", "clk_i";
 
 	rcar_sound,dvc {
-		dvc0: dvc@0 {
+		dvc0: dvc-0 {
 			dmas = <&audma0 0xbc>;
 			dma-names = "tx";
 		};
-		dvc1: dvc@1 {
+		dvc1: dvc-1 {
 			dmas = <&audma0 0xbe>;
 			dma-names = "tx";
 		};
 	};
 
 	rcar_sound,mix {
-		mix0: mix@0 { };
-		mix1: mix@1 { };
+		mix0: mix-0 { };
+		mix1: mix-1 { };
 	};
 
 	rcar_sound,ctu {
-		ctu00: ctu@0 { };
-		ctu01: ctu@1 { };
-		ctu02: ctu@2 { };
-		ctu03: ctu@3 { };
-		ctu10: ctu@4 { };
-		ctu11: ctu@5 { };
-		ctu12: ctu@6 { };
-		ctu13: ctu@7 { };
+		ctu00: ctu-0 { };
+		ctu01: ctu-1 { };
+		ctu02: ctu-2 { };
+		ctu03: ctu-3 { };
+		ctu10: ctu-4 { };
+		ctu11: ctu-5 { };
+		ctu12: ctu-6 { };
+		ctu13: ctu-7 { };
 	};
 
 	rcar_sound,src {
-		src0: src@0 {
+		src0: src-0 {
 			interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x85>, <&audma1 0x9a>;
 			dma-names = "rx", "tx";
 		};
-		src1: src@1 {
+		src1: src-1 {
 			interrupts = <0 353 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x87>, <&audma1 0x9c>;
 			dma-names = "rx", "tx";
 		};
-		src2: src@2 {
+		src2: src-2 {
 			interrupts = <0 354 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x89>, <&audma1 0x9e>;
 			dma-names = "rx", "tx";
 		};
-		src3: src@3 {
+		src3: src-3 {
 			interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x8b>, <&audma1 0xa0>;
 			dma-names = "rx", "tx";
 		};
-		src4: src@4 {
+		src4: src-4 {
 			interrupts = <0 356 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x8d>, <&audma1 0xb0>;
 			dma-names = "rx", "tx";
 		};
-		src5: src@5 {
+		src5: src-5 {
 			interrupts = <0 357 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x8f>, <&audma1 0xb2>;
 			dma-names = "rx", "tx";
 		};
-		src6: src@6 {
+		src6: src-6 {
 			interrupts = <0 358 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x91>, <&audma1 0xb4>;
 			dma-names = "rx", "tx";
 		};
-		src7: src@7 {
+		src7: src-7 {
 			interrupts = <0 359 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x93>, <&audma1 0xb6>;
 			dma-names = "rx", "tx";
 		};
-		src8: src@8 {
+		src8: src-8 {
 			interrupts = <0 360 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x95>, <&audma1 0xb8>;
 			dma-names = "rx", "tx";
 		};
-		src9: src@9 {
+		src9: src-9 {
 			interrupts = <0 361 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x97>, <&audma1 0xba>;
 			dma-names = "rx", "tx";
@@ -521,52 +521,52 @@ rcar_sound: sound@ec500000 {
 	};
 
 	rcar_sound,ssi {
-		ssi0: ssi@0 {
+		ssi0: ssi-0 {
 			interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
 			dma-names = "rx", "tx", "rxu", "txu";
 		};
-		ssi1: ssi@1 {
+		ssi1: ssi-1 {
 			interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
 			dma-names = "rx", "tx", "rxu", "txu";
 		};
-		ssi2: ssi@2 {
+		ssi2: ssi-2 {
 			interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
 			dma-names = "rx", "tx", "rxu", "txu";
 		};
-		ssi3: ssi@3 {
+		ssi3: ssi-3 {
 			interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
 			dma-names = "rx", "tx", "rxu", "txu";
 		};
-		ssi4: ssi@4 {
+		ssi4: ssi-4 {
 			interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
 			dma-names = "rx", "tx", "rxu", "txu";
 		};
-		ssi5: ssi@5 {
+		ssi5: ssi-5 {
 			interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
 			dma-names = "rx", "tx", "rxu", "txu";
 		};
-		ssi6: ssi@6 {
+		ssi6: ssi-6 {
 			interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
 			dma-names = "rx", "tx", "rxu", "txu";
 		};
-		ssi7: ssi@7 {
+		ssi7: ssi-7 {
 			interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
 			dma-names = "rx", "tx", "rxu", "txu";
 		};
-		ssi8: ssi@8 {
+		ssi8: ssi-8 {
 			interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
 			dma-names = "rx", "tx", "rxu", "txu";
 		};
-		ssi9: ssi@9 {
+		ssi9: ssi-9 {
 			interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
 			dma-names = "rx", "tx", "rxu", "txu";
-- 
2.14.1
