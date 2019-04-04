From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: pdm: change dma burst to 8" to the asoc tree
Date: Thu,  4 Apr 2019 15:16:59 +0700 (+07)
Message-ID: <20190404081700.07830441D3C@finisterre.ee.mobilebroadband>
References: <1554349691-23450-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554349691-23450-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>, heiko@sntech.debroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: pdm: change dma burst to 8

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

>From 86a7b6ffd90095d81d9fa0d8b48955b7c83b2e2f Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:48:11 +0800
Subject: [PATCH] ASoC: rockchip: pdm: change dma burst to 8

This patch decreases the transfer bursts to avoid the fifo overrun.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 8a2e3bbce3a1..d0b403a0e27b 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -24,7 +24,7 @@
 
 #include "rockchip_pdm.h"
 
-#define PDM_DMA_BURST_SIZE	(16) /* size * width: 16*4 = 64 bytes */
+#define PDM_DMA_BURST_SIZE	(8) /* size * width: 8*4 = 32 bytes */
 
 struct rk_pdm_dev {
 	struct device *dev;
-- 
2.20.1
