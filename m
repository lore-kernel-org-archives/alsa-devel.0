From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: add rockchip tranceiver
	bindings" to the asoc tree
Date: Fri, 09 Oct 2015 12:21:36 +0100
Message-ID: <E1ZkVk0-0006cy-VV@finisterre>
References: <1444311079-2892-2-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BAD79265173
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 13:21:49 +0200 (CEST)
In-Reply-To: <1444311079-2892-2-git-send-email-sjoerd.simons@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: add rockchip tranceiver bindings

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

>From 51e5084e718f990e88aeb0a9219adef15f847dc8 Mon Sep 17 00:00:00 2001
From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Date: Thu, 8 Oct 2015 15:31:12 +0200
Subject: [PATCH] ASoC: dt-bindings: add rockchip tranceiver bindings

Add devicetree bindings for the spdif tranceiver found on
found on rk3066, rk3188 and rk3288 SoCs

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/rockchip-spdif.txt   | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
new file mode 100644
index 0000000..33dd82c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
@@ -0,0 +1,44 @@
+* Rockchip SPDIF transceiver
+
+The S/PDIF audio block is a stereo transceiver that allows the
+processor to receive and transmit digital audio via an coaxial cable or
+a fibre cable.
+
+Required properties:
+
+- compatible: should be one of the following:
+   - "rockchip,rk3288-spdif", "rockchip,rk3188-spdif" or
+     "rockchip,rk3066-spdif"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: should contain the SPDIF interrupt.
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+- dmas: DMA specifiers for tx dma. See the DMA client binding,
+  Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should be "tx"
+- clocks: a list of phandle + clock-specifier pairs, one for each entry
+  in clock-names.
+- clock-names: should contain following:
+   - "hclk": clock for SPDIF controller
+   - "mclk" : clock for SPDIF bus
+
+Required properties on RK3288:
+  - rockchip,grf: the phandle of the syscon node for the general register
+                   file (GRF)
+
+Example for the rk3188 SPDIF controller:
+
+spdif: spdif@0x1011e000 {
+	compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
+	reg = <0x1011e000 0x2000>;
+	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	dmas = <&dmac1_s 8>;
+	dma-names = "tx";
+	clock-names = "hclk", "mclk";
+	clocks = <&cru HCLK_SPDIF>, <&cru SCLK_SPDIF>;
+	status = "disabled";
+	#sound-dai-cells = <0>;
+};
-- 
2.5.0
