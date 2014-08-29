From: Jianqun <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 1/2] rockchip-i2s: dt: add grf requested properties to set power of I2S controller
Date: Fri, 29 Aug 2014 15:07:05 -0700
Message-ID: <1409350027-17604-2-git-send-email-jay.xu@rock-chips.com>
References: <1409350027-17604-1-git-send-email-jay.xu@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409350027-17604-1-git-send-email-jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jianqun <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add "rockchip,grf" for driver to get physical address of GRF, and "rockchip,grf-io-vsel"
for driver to set voltage for I2S controller according to hardware request.

Requested by rk3xxx I2S controller and tested ok on rk3288-pinky board.

Change-Id: I2587d15c25e64c569857369326653d8a450bae19
Signed-off-by: Jianqun <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 6c55fcf..b995fe6 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -9,6 +9,8 @@ Required properties:
    - "rockchip,rk3066-i2s": for rk3066
    - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
    - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
+- rockchip,grf: physical base address of GRF.
+- rockchip,grf-io-vsel: select this if I2S controller powerd by 1.8v.
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
@@ -26,12 +28,14 @@ Example for rk3288 I2S controller:
 
 i2s@ff890000 {
 	compatible = "rockchip,rk3288-i2s", "rockchip,rk3066-i2s";
+	rockchip,grf = <&grf>;
+	rockchip,grf-io-vsel;
 	reg = <0xff890000 0x10000>;
 	interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 	dmas = <&pdma1 0>, <&pdma1 1>;
-	dma-names = "rx", "tx";
+	dma-names = "tx", "rx";
 	clock-names = "i2s_hclk", "i2s_clk";
 	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 };
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
