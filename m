From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH] ASoC: rockchip: add bindings for i2s
Date: Mon, 31 Jul 2017 09:47:51 +0800
Message-ID: <1501465671-22863-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 31F72266CE1
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 03:48:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, broonie@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch add bindings for rk3036/rk3228/rk3328/rk3366 i2s.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 206aba1..b208a75 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -7,8 +7,12 @@ Required properties:
 
 - compatible: should be one of the following:
    - "rockchip,rk3066-i2s": for rk3066
+   - "rockchip,rk3036-i2s", "rockchip,rk3066-i2s": for rk3036
    - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
+   - "rockchip,rk3228-i2s", "rockchip,rk3066-i2s": for rk3228
    - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
+   - "rockchip,rk3328-i2s", "rockchip,rk3066-i2s": for rk3328
+   - "rockchip,rk3366-i2s", "rockchip,rk3066-i2s": for rk3366
    - "rockchip,rk3368-i2s", "rockchip,rk3066-i2s": for rk3368
    - "rockchip,rk3399-i2s", "rockchip,rk3066-i2s": for rk3399
 - reg: physical base address of the controller and length of memory mapped
-- 
2.7.4
