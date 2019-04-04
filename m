From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 09/12] dt-bindings: sound: add compatible for rk1808
Date: Thu,  4 Apr 2019 11:55:45 +0800
Message-ID: <1554350145-24198-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, broonie@kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch adds bindings for rk1808 soc.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 Documentation/devicetree/bindings/sound/rockchip,pdm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
index 3e0eb73..98572a2 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
@@ -4,6 +4,7 @@ Required properties:
 
 - compatible: "rockchip,pdm"
   - "rockchip,px30-pdm"
+  - "rockchip,rk1808-pdm"
   - "rockchip,rk3308-pdm"
 - reg: physical base address of the controller and length of memory mapped
   region.
-- 
2.7.4
