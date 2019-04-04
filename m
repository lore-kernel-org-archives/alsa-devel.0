From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 08/12] ASoC: rockchip: pdm: add compatible for rk1808
Date: Thu,  4 Apr 2019 11:54:30 +0800
Message-ID: <1554350070-24078-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, broonie@kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support for rk1808, the pdm controller
is the same as rk3308.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 4f93a74..3e1c5fd 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -457,6 +457,8 @@ static const struct of_device_id rockchip_pdm_match[] = {
 	{ .compatible = "rockchip,pdm", },
 	{ .compatible = "rockchip,px30-pdm",
 	  .data = (void *)RK_PDM_RK3308 },
+	{ .compatible = "rockchip,rk1808-pdm",
+	  .data = (void *)RK_PDM_RK3308 },
 	{ .compatible = "rockchip,rk3308-pdm",
 	  .data = (void *)RK_PDM_RK3308 },
 	{},
-- 
2.7.4
