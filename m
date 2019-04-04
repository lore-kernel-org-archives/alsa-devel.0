From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: pdm: add compatible for rk1808" to the asoc tree
Date: Thu,  4 Apr 2019 15:16:40 +0700 (+07)
Message-ID: <20190404081640.D7D3E441D3C@finisterre.ee.mobilebroadband>
References: <1554350070-24078-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554350070-24078-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>, heiko@sntech.debroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: pdm: add compatible for rk1808

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

>From 717d97879b346d56fc47a6e3fe0ad44fea9949b2 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:54:30 +0800
Subject: [PATCH] ASoC: rockchip: pdm: add compatible for rk1808

This patch adds support for rk1808, the pdm controller
is the same as rk3308.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 4f93a7454e85..3e1c5fd5b32b 100644
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
2.20.1
