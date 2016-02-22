From: "jianqun.xu" <jay.xu@rock-chips.com>
Subject: [PATCH] ASoC: rockchip: add bindings for rk3399 i2s
Date: Mon, 22 Feb 2016 16:32:05 +0800
Message-ID: <1456129925-24569-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F68C260789
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 09:34:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, sugar.zhang@rock-chips.com
Cc: huangtao@rock-chips.com, alsa-devel@alsa-project.org, davidriley@chromium.org, linux-kernel@vger.kernel.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, smbarber@chromium.org, jay.xu@rock-chips.com
List-Id: alsa-devel@alsa-project.org

From: Jianqun Xu <jay.xu@rock-chips.com>

Add devicetree bindings for i2s controller found on rk3399
processors from rockchip.

It's helpful to add full set of compatible strings for serials
of Rockchip SoCs (rk3066, rk3188, rk3288, rk3399).

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 1 +
 sound/soc/rockchip/rockchip_i2s.c                        | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index b7f3a93..6e86d8a 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -9,6 +9,7 @@ Required properties:
    - "rockchip,rk3066-i2s": for rk3066
    - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
    - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
+   - "rockchip,rk3399-i2s", "rockchip,rk3066-i2s": for rk3399
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 6561c4c..531a6d2 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -575,6 +575,9 @@ static int rockchip_i2s_remove(struct platform_device *pdev)
 
 static const struct of_device_id rockchip_i2s_match[] = {
 	{ .compatible = "rockchip,rk3066-i2s", },
+	{ .compatible = "rockchip,rk3188-i2s", },
+	{ .compatible = "rockchip,rk3288-i2s", },
+	{ .compatible = "rockchip,rk3399-i2s", },
 	{},
 };
 
-- 
1.9.1
