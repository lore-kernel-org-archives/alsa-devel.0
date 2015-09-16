From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sunxi: Add the Allwinner A10 codec
	bindings" to the asoc tree
Date: Wed, 16 Sep 2015 21:01:47 +0100
Message-ID: <E1ZcItn-0007sr-49@finisterre>
References: <1442064384-23379-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07E33264F28
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:01:54 +0200 (CEST)
In-Reply-To: <1442064384-23379-2-git-send-email-maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sunxi: Add the Allwinner A10 codec bindings

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

>From 4ec73d3c81be5a401546afc6628aaf8add253ff1 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sat, 12 Sep 2015 15:26:23 +0200
Subject: [PATCH] ASoC: sunxi: Add the Allwinner A10 codec bindings

The Allwinner SoCs have an in-SoC audio controller taking the role of a DAI
and a codec.

Add the binding documentation for that controller on the A10.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sun4i-codec.txt      | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
new file mode 100644
index 0000000..680144b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -0,0 +1,33 @@
+* Allwinner A10 Codec
+
+Required properties:
+- compatible: must be either "allwinner,sun4i-a10-codec" or
+  "allwinner,sun7i-a20-codec"
+- reg: must contain the registers location and length
+- interrupts: must contain the codec interrupt
+- dmas: DMA channels for tx and rx dma. See the DMA client binding,
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should include "tx" and "rx".
+- clocks: a list of phandle + clock-specifer pairs, one for each entry
+  in clock-names.
+- clock-names: should contain followings:
+   - "apb": the parent APB clock for this controller
+   - "codec": the parent module clock
+- routing : A list of the connections between audio components.  Each
+  entry is a pair of strings, the first being the connection's sink,
+  the second being the connection's source.
+
+
+Example:
+codec: codec@01c22c00 {
+	#sound-dai-cells = <0>;
+	compatible = "allwinner,sun7i-a20-codec";
+	reg = <0x01c22c00 0x40>;
+	interrupts = <0 30 4>;
+	clocks = <&apb0_gates 0>, <&codec_clk>;
+	clock-names = "apb", "codec";
+	dmas = <&dma 0 19>, <&dma 0 19>;
+	dma-names = "rx", "tx";
+	routing = "Headphone Jack", "HP Right",
+		  "Headphone Jack", "HP Left";
+};
-- 
2.5.0
