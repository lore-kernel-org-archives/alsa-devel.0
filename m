From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 05/12] ASoC: rockchip: pdm: change dma burst to 8
Date: Thu,  4 Apr 2019 11:48:11 +0800
Message-ID: <1554349691-23450-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, broonie@kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch decreases the transfer bursts to avoid the fifo overrun.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index abbb6d7..c50494b 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -24,7 +24,7 @@
 
 #include "rockchip_pdm.h"
 
-#define PDM_DMA_BURST_SIZE	(16) /* size * width: 16*4 = 64 bytes */
+#define PDM_DMA_BURST_SIZE	(8) /* size * width: 8*4 = 32 bytes */
 
 struct rk_pdm_dev {
 	struct device *dev;
-- 
2.7.4
