From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 07/12] dt-bindings: sound: rockchip: add compatible for rk3308/px30
Date: Thu,  4 Apr 2019 11:53:15 +0800
Message-ID: <1554349995-23944-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, broonie@kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch adds bindings for rk3308/px30.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 Documentation/devicetree/bindings/sound/rockchip,pdm.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
index 47f164f..3e0eb73 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
@@ -3,6 +3,8 @@
 Required properties:
 
 - compatible: "rockchip,pdm"
+  - "rockchip,px30-pdm"
+  - "rockchip,rk3308-pdm"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - dmas: DMA specifiers for rx dma. See the DMA client binding,
@@ -12,6 +14,8 @@ Required properties:
 - clock-names: should contain following:
    - "pdm_hclk": clock for PDM BUS
    - "pdm_clk" : clock for PDM controller
+- resets: a list of phandle + reset-specifer paris, one for each entry in reset-names.
+- reset-names: reset names, should include "pdm-m".
 - pinctrl-names: Must contain a "default" entry.
 - pinctrl-N: One property must exist for each entry in
 	     pinctrl-names. See ../pinctrl/pinctrl-bindings.txt
-- 
2.7.4
