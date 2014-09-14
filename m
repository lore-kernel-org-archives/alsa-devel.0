From: Jianqun <jay.xu@rock-chips.com>
Subject: [PATCH v2] ASoC: rockchip-i2s: dt: fix an error in the
	example
Date: Sun, 14 Sep 2014 11:39:59 +0800
Message-ID: <1410665999-16718-1-git-send-email-jay.xu@rock-chips.com>
References: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vasmtpcom.263.net (va-smtp01.263.net [54.88.144.211])
 by alsa0.perex.cz (Postfix) with ESMTP id 9135226164D
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 05:40:13 +0200 (CEST)
In-Reply-To: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: huangtao@rock-chips.com, cf@rock-chips.com, Jianqun <jay.xu@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Reference to RK3288 TRM, fix an error in the example by swap "tx" and "rx".

Table 10-1 DMAC_BUS Request Mapping Table
Req number	Source	Polarity
0		I2S tx	High level
1		I2S rx	High level

Tested on RK3288 board.

Signed-off-by: Jianqun <jay.xu@rock-chips.com>
---
change since v1:
- modify patch's changelog as Mark's suggestion

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
