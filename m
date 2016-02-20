From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sunxi: add sun4i SPDIF transceiver" to
	the asoc tree
Date: Sun, 21 Feb 2016 02:13:52 +0900
Message-ID: <E1aXB6O-0008CV-PX@finisterre>
References: <1454584162-32449-2-git-send-email-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AFF72606E8
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:14:06 +0100 (CET)
In-Reply-To: <1454584162-32449-2-git-send-email-codekipper@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marcus Cooper <codekipper@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sunxi: add sun4i SPDIF transceiver

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

>From 8020e1bbaa5e8d8340ab78c71a69ccdd362ab203 Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Mon, 8 Feb 2016 18:09:20 +0100
Subject: [PATCH] ASoC: sunxi: add sun4i SPDIF transceiver

Add devicetree bindings for the SPDIF transceiver found on
found on Allwinners A10 and A20 SoCs.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/sunxi,sun4i-spdif.txt           | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
new file mode 100644
index 0000000..13503aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
@@ -0,0 +1,39 @@
+Allwinner Sony/Philips Digital Interface Format (S/PDIF) Controller
+
+The Allwinner S/PDIF audio block is a transceiver that allows the
+processor to receive and transmit digital audio via an coaxial cable or
+a fibre cable.
+For now only playback is supported.
+
+Required properties:
+
+  - compatible		: should be one of the following:
+    - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
+
+  - reg			: Offset and length of the register set for the device.
+
+  - interrupts		: Contains the spdif interrupt.
+
+  - dmas		: Generic dma devicetree binding as described in
+			  Documentation/devicetree/bindings/dma/dma.txt.
+
+  - dma-names		: Two dmas have to be defined, "tx" and "rx".
+
+  - clocks		: Contains an entry for each entry in clock-names.
+
+  - clock-names		: Includes the following entries:
+	"apb"		  clock for the spdif bus.
+	"spdif"		  clock for spdif controller.
+
+Example:
+
+spdif: spdif@01c21000 {
+	compatible = "allwinner,sun4i-a10-spdif";
+	reg = <0x01c21000 0x40>;
+	interrupts = <13>;
+	clocks = <&apb0_gates 1>, <&spdif_clk>;
+	clock-names = "apb", "spdif";
+	dmas = <&dma 0 2>, <&dma 0 2>;
+	dma-names = "rx", "tx";
+	status = "okay";
+};
-- 
2.7.0
