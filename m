From: Jianqun <jay.xu@rock-chips.com>
Subject: [PATCH] ASoC: rockchip-i2s: dt: swap tx and rx channed request number
Date: Sat, 13 Sep 2014 09:04:41 +0800
Message-ID: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: huangtao@rock-chips.com, cf@rock-chips.com, Jianqun <jay.xu@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Reference to RK3288 TRM, fix an error channel id for i2s tx and rx
Table 10-1 DMAC_BUS Request Mapping Table
Req number	Source	Polarity
0		I2S tx	High level
1		I2S rx	High level

Tested on RK3288 board.

Signed-off-by: Jianqun <jay.xu@rock-chips.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 6c55fcf..9b82c20 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -31,7 +31,7 @@ i2s@ff890000 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	dmas = <&pdma1 0>, <&pdma1 1>;
-	dma-names = "rx", "tx";
+	dma-names = "tx", "rx";
 	clock-names = "i2s_hclk", "i2s_clk";
 	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 };
-- 
1.9.1
