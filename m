From: Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 1/2] ASoC: rockchip-i2s: dt: add i2s_clkout to
	list of clocks
Date: Wed, 19 Nov 2014 11:06:04 +0800
Message-ID: <1416366365-4632-2-git-send-email-jay.xu@rock-chips.com>
References: <1416366365-4632-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from irl-smtp01.263.net (irl-smtp01.263.net [54.76.167.174])
 by alsa0.perex.cz (Postfix) with ESMTP id E6C7E2604E9
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 04:06:37 +0100 (CET)
In-Reply-To: <1416366365-4632-1-git-send-email-jay.xu@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com
Cc: Jianqun Xu <jay.xu@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Add i2s_clkout property, which enables output clock to chip outside,
this is generally for audio codec outside.

Also add it to example.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 9b82c20..3d23b15 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -21,6 +21,7 @@ Required properties:
 - clock-names: should contain followings:
    - "i2s_hclk": clock for I2S BUS
    - "i2s_clk" : clock for I2S controller
+   - "i2s_clko" : clock for codec outside of chip
 
 Example for rk3288 I2S controller:
 
@@ -32,6 +33,6 @@ i2s@ff890000 {
 	#size-cells = <0>;
 	dmas = <&pdma1 0>, <&pdma1 1>;
 	dma-names = "tx", "rx";
-	clock-names = "i2s_hclk", "i2s_clk";
-	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+	clock-names = "i2s_hclk", "i2s_clk", "i2s_clko";
+	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>, <&cru SCLK_I2S0_CLKOUT>;
 };
-- 
1.9.1
