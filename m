From: Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH] ASoC: rockchip: i2s:  applys rate symmetry for CPU DAI
Date: Thu,  8 Jan 2015 10:49:59 +0800
Message-ID: <1420685399-24142-1-git-send-email-jay.xu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, heiko@sntech.de, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, sonnyrao@chromium.org
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Jianqun Xu <jay.xu@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch applys rate symmetry for rockchip i2s DAI.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 59aeec4..abd7cdd 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -339,6 +339,7 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
 			    SNDRV_PCM_FMTBIT_S24_LE),
 	},
 	.ops = &rockchip_i2s_dai_ops,
+	.symmetric_rates = 1,
 };
 
 static const struct snd_soc_component_driver rockchip_i2s_component = {
-- 
1.9.1
