From: jianqun <xjq@rock-chips.com>
Subject: [PATCH v3 1/2] ASoC: dt-bindings: add rockchip i2s bindings
Date: Sat,  5 Jul 2014 19:10:38 +0800
Message-ID: <1404558638-1739-1-git-send-email-xjq@rock-chips.com>
References: <1404458796-6818-1-git-send-email-xjq@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404458796-6818-1-git-send-email-xjq@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, robh+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, zhangqing@rock-chips.com, hj@rock-chips.com, kever.yang@rock-chips.com, huangtao@rock-chips.com, zyw@rock-chips.com, yzq@rock-chips.com, zhenfu.fang@rock-chips.com, cf@rock-chips.com, kfx@rock-chips.com, Jianqun Xu <xjq@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

From: Jianqun Xu <xjq@rock-chips.com>

Add devicetree bindings for i2s controller found on
rk3066, rk3188 and rk3288 processors from rockchip.

Signed-off-by: Jianqun Xu <xjq@rock-chips.com>
---
changes since v2:
- change the description of dma-names, adviced by Mark
- change the description of interrupts, adviced by Mark
- list clock-names to be easy to read, adviced by Mark
- modify compatible for rk3288 example, adviced by Mark and Heiko

changes since v1:
- modify the description of clock-names property, adviced by Mark Rutland.
- modify the example to fit for rk3288.

 .../devicetree/bindings/sound/rockchip-i2s.txt     |   37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
new file mode 100644
index 0000000..6c55fcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -0,0 +1,37 @@
+* Rockchip I2S controller
+
+The I2S bus (Inter-IC sound bus) is a serial link for digital
+audio data transfer between devices in the system.
+
+Required properties:
+
+- compatible: should be one of the followings
+   - "rockchip,rk3066-i2s": for rk3066
+   - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
+   - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: should contain the I2S interrupt.
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should include "tx" and "rx".
+- clocks: a list of phandle + clock-specifer pairs, one for each entry in clock-names.
+- clock-names: should contain followings:
+   - "i2s_hclk": clock for I2S BUS
+   - "i2s_clk" : clock for I2S controller
+
+Example for rk3288 I2S controller:
+
+i2s@ff890000 {
+	compatible = "rockchip,rk3288-i2s", "rockchip,rk3066-i2s";
+	reg = <0xff890000 0x10000>;
+	interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	dmas = <&pdma1 0>, <&pdma1 1>;
+	dma-names = "rx", "tx";
+	clock-names = "i2s_hclk", "i2s_clk";
+	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+};
-- 
1.7.9.5
