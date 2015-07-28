From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH 1/4] ASoC: dt-bindings: add rockchip tranceiver bindings
Date: Tue, 28 Jul 2015 14:03:28 +0200
Message-ID: <1438085011-16577-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add devicetree bindings for the spdif tranceiver found on
found on rk3066, rk3188 and rk3288 SoCs

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 .../devicetree/bindings/sound/rockchip-spdif.txt   | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
new file mode 100644
index 0000000..2da8a09
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
@@ -0,0 +1,41 @@
+* Rockchip SPDIF transceiver
+
+The S/PDIF audio block is a stereo transceiver that allows the
+processor to receive and transmit digital audio via an coaxial cable or
+a fibre cable.
+
+Required properties:
+
+- compatible: should be one of the following:
+   - "rockchip,rk3066-spdif": for rk3066
+   - "rockchip,rk3188-spdif", "rockchip,rk3066-spdif": for rk3188
+   - "rockchip,rk3288-spdif", "rockchip,rk3066-spdif": for rk3288
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
+   - "spdif_hclk": clock for SPPIF controller
+   - "spdif_clk" : clock for SPDIF bus
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
+	clock-names = "spdif_hclk", "spdif_clk";
+	clocks = <&cru HCLK_SPDIF>, <&cru SCLK_SPDIF>;
+	status = "disabled";
+	#sound-dai-cells = <0>;
+};
-- 
2.4.6
