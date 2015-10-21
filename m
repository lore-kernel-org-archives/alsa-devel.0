From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: Drop unneeded properties
	rockchip i2s/spdif bindings" to the asoc tree
Date: Wed, 21 Oct 2015 13:34:11 +0100
Message-ID: <E1Zosap-0003ym-UA@finisterre>
References: <1445242539-9098-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24E382606B2
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 14:34:26 +0200 (CEST)
In-Reply-To: <1445242539-9098-1-git-send-email-sjoerd.simons@collabora.co.uk>
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

   ASoC: rockchip: Drop unneeded properties rockchip i2s/spdif bindings

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

>From 13531520e3106e73474225b68b889e9dc7da329e Mon Sep 17 00:00:00 2001
From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Date: Mon, 19 Oct 2015 10:15:39 +0200
Subject: [PATCH] ASoC: rockchip: Drop unneeded properties rockchip i2s/spdif
 bindings

Neither the rockchip i2s nor the rockchip spdif binding support child
devices so #address-cells and #size-cells properties aren't required.
Remove these from the bindings.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt   | 4 ----
 Documentation/devicetree/bindings/sound/rockchip-spdif.txt | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 9b82c20..085e0bc 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -12,8 +12,6 @@ Required properties:
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
-- #address-cells: should be 1.
-- #size-cells: should be 0.
 - dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
 	Documentation/devicetree/bindings/dma/dma.txt
 - dma-names: should include "tx" and "rx".
@@ -28,8 +26,6 @@ i2s@ff890000 {
 	compatible = "rockchip,rk3288-i2s", "rockchip,rk3066-i2s";
 	reg = <0xff890000 0x10000>;
 	interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
-	#address-cells = <1>;
-	#size-cells = <0>;
 	dmas = <&pdma1 0>, <&pdma1 1>;
 	dma-names = "tx", "rx";
 	clock-names = "i2s_hclk", "i2s_clk";
diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
index 33dd82c..e64dbde 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
@@ -12,8 +12,6 @@ Required properties:
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the SPDIF interrupt.
-- #address-cells: should be 1.
-- #size-cells: should be 0.
 - dmas: DMA specifiers for tx dma. See the DMA client binding,
   Documentation/devicetree/bindings/dma/dma.txt
 - dma-names: should be "tx"
@@ -33,8 +31,6 @@ spdif: spdif@0x1011e000 {
 	compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
 	reg = <0x1011e000 0x2000>;
 	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-	#address-cells = <1>;
-	#size-cells = <0>;
 	dmas = <&dmac1_s 8>;
 	dma-names = "tx";
 	clock-names = "hclk", "mclk";
-- 
2.6.1
