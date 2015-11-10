From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH 2/3] ASoC: rockchip: add playback property
Date: Tue, 10 Nov 2015 15:32:08 +0800
Message-ID: <1447140729-18267-3-git-send-email-sugar.zhang@rock-chips.com>
References: <1447140729-18267-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 3659C260522
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 08:32:26 +0100 (CET)
In-Reply-To: <1447140729-18267-1-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

rockchip,playback-channels: max playback channels, 8 channels default.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 2267d24..b7f3a93 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -19,6 +19,7 @@ Required properties:
 - clock-names: should contain followings:
    - "i2s_hclk": clock for I2S BUS
    - "i2s_clk" : clock for I2S controller
+- rockchip,playback-channels: max playback channels, if not set, 8 channels default.
 - rockchip,capture-channels: max capture channels, if not set, 2 channels default.
 
 Example for rk3288 I2S controller:
@@ -31,5 +32,6 @@ i2s@ff890000 {
 	dma-names = "tx", "rx";
 	clock-names = "i2s_hclk", "i2s_clk";
 	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+	rockchip,playback-channels = <8>;
 	rockchip,capture-channels = <2>;
 };
-- 
2.3.6
