From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: sound: rockchip: add compatible for rk3308/px30" to the asoc tree
Date: Thu,  4 Apr 2019 15:16:43 +0700 (+07)
Message-ID: <20190404081643.E1230441D3E@finisterre.ee.mobilebroadband>
References: <1554349995-23944-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554349995-23944-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>, heiko@sntech.debroonie@kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: sound: rockchip: add compatible for rk3308/px30

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6bfff707985fff14fa79c851e53f9630e76a4860 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:53:15 +0800
Subject: [PATCH] dt-bindings: sound: rockchip: add compatible for rk3308/px30

This patch adds bindings for rk3308/px30.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip,pdm.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
index 47f164fbd1d7..3e0eb7354ba6 100644
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
2.20.1
