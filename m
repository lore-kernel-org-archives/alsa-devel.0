From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add SSIU BUSIF support for
	Document" to the asoc tree
Date: Tue,  6 Nov 2018 17:52:36 +0000 (GMT)
Message-ID: <20181106175236.09370112266B@debutante.sirena.org.uk>
References: <875zxax00v.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EA3D9267AB0
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 18:52:36 +0100 (CET)
In-Reply-To: <875zxax00v.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jiada Wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add SSIU BUSIF support for Document

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

>From da48a6eb82ea2eaa26464f863f0f39908727bfdb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 6 Nov 2018 05:20:56 +0000
Subject: [PATCH] ASoC: rsnd: add SSIU BUSIF support for Document

Gen2 has BUSIF0-3, Gen3 has BUSIF0-7 on some SSIU.
Current driver is assuming it is using BUSIF0 as default.
Thus, SSI is attaching SSIU (with BUSIF0) by using rsnd_ssiu_attach().
But, TDM split mode also needs other BUSIF to use it.
This patch adds missing SSIU BUSIFx support.

BUSIF is handled by SSIU instead of SSI anymore.
Thus, its settings no longer needed on SSI node on DT.
This patch removes its settings from Document, but driver is still
keeping compatibility. Thus, old DT style is still working.
But, to avoid confusing, it doesn't indicate old compatibility things on
Document. New SoC should have SSIU on DT from this patch.

1) old style DT is still supported (= no rcar_sound,ssiu node on DT)
2) If ssiu is not indicated on playback/capture,
   BUSIF0 will be used as default
	playback = <&ssi3>; /* ssiu30 will be selected */
3) you can select own ssiu
	playback = <&ssi32 &ssi3>; /* ssiu32 will be selected */

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/renesas,rsnd.txt           | 87 +++++++++----------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 8986764508db..6ed1a3658ffd 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -181,15 +181,12 @@ Volume Ramp
 * SSIU (Serial Sound Interface Unit)
 =============================================
 
-There is no DT settings for SSIU, because SSIU will be automatically
-selected via SSI.
 SSIU can avoid some under/over run error, because it has some buffer.
 But you can't use it if SSI was PIO mode.
-In DMA mode, you can select not to use SSIU by using "no-busif" on DT.
+In DMA mode, you can select not to use SSIU by using "no-busif" via SSI.
 
-	&ssi0 {
-		no-busif;
-	};
+SSIU handles BUSIF which will be used for TDM Split mode.
+This driver is assuming that audio-graph card will be used.
 
 =============================================
 * SSI (Serial Sound Interface)
@@ -268,6 +265,9 @@ Required properties:
 - rcar_sound,ssi		: Should contain SSI feature.
 				  The number of SSI subnode should be same as HW.
 				  see below for detail.
+- rcar_sound,ssiu		: Should contain SSIU feature.
+				  The number of SSIU subnode should be same as HW.
+				  see below for detail.
 - rcar_sound,src		: Should contain SRC feature.
 				  The number of SRC subnode should be same as HW.
 				  see below for detail.
@@ -437,56 +437,55 @@ rcar_sound: sound@ec500000 {
 		};
 	};
 
+	rcar_sound,ssiu {
+		ssiu00: ssiu-0 {
+			dmas = <&audma0 0x15>, <&audma1 0x16>;
+			dma-names = "rx", "tx";
+		};
+		ssiu01: ssiu-1 {
+			dmas = <&audma0 0x35>, <&audma1 0x36>;
+			dma-names = "rx", "tx";
+		};
+
+		...
+
+		ssiu95: ssiu-49 {
+			dmas = <&audma0 0xA5>, <&audma1 0xA6>;
+			dma-names = "rx", "tx";
+		};
+		ssiu96: ssiu-50 {
+			dmas = <&audma0 0xA7>, <&audma1 0xA8>;
+			dma-names = "rx", "tx";
+		};
+		ssiu97: ssiu-51 {
+			dmas = <&audma0 0xA9>, <&audma1 0xAA>;
+			dma-names = "rx", "tx";
+		};
+	};
+
 	rcar_sound,ssi {
 		ssi0: ssi-0 {
 			interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
-			dma-names = "rx", "tx", "rxu", "txu";
+			dmas = <&audma0 0x01>, <&audma1 0x02>;
+			dma-names = "rx", "tx";
 		};
 		ssi1: ssi-1 {
 			interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
-			dma-names = "rx", "tx", "rxu", "txu";
-		};
-		ssi2: ssi-2 {
-			interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
-			dma-names = "rx", "tx", "rxu", "txu";
-		};
-		ssi3: ssi-3 {
-			interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
-			dma-names = "rx", "tx", "rxu", "txu";
-		};
-		ssi4: ssi-4 {
-			interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
-			dma-names = "rx", "tx", "rxu", "txu";
-		};
-		ssi5: ssi-5 {
-			interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
-			dma-names = "rx", "tx", "rxu", "txu";
-		};
-		ssi6: ssi-6 {
-			interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
-			dma-names = "rx", "tx", "rxu", "txu";
-		};
-		ssi7: ssi-7 {
-			interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
-			dma-names = "rx", "tx", "rxu", "txu";
+			dmas = <&audma0 0x03>, <&audma1 0x04>;
+			dma-names = "rx", "tx";
 		};
+
+		...
+
 		ssi8: ssi-8 {
 			interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
-			dma-names = "rx", "tx", "rxu", "txu";
+			dmas = <&audma0 0x11>, <&audma1 0x12>;
+			dma-names = "rx", "tx";
 		};
 		ssi9: ssi-9 {
 			interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
-			dma-names = "rx", "tx", "rxu", "txu";
+			dmas = <&audma0 0x13>, <&audma1 0x14>;
+			dma-names = "rx", "tx";
 		};
 	};
 
-- 
2.19.0.rc2
