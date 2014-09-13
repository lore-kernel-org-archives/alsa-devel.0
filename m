From: Jianqun <jay.xu@rock-chips.com>
Subject: [PATCH 5/5] ASoC: rockchip-i2s: enable "hclk" for rockchip I2S controller
Date: Sat, 13 Sep 2014 08:43:13 +0800
Message-ID: <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: huangtao@rock-chips.com, cf@rock-chips.com, Jianqun <jay.xu@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

As "hclk" is used for rockchip I2S controller, driver must to enable
it in probe.

Tested on RK3288 with max98090.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 6595383..033487c 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -423,6 +423,11 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Can't retrieve i2s bus clock\n");
 		return PTR_ERR(i2s->hclk);
 	}
+	ret = clk_prepare_enable(i2s->hclk);
+	if (ret) {
+		dev_err(i2s->dev, "hclock enable failed %d\n", ret);
+		return ret;
+	}
 
 	i2s->mclk = devm_clk_get(&pdev->dev, "i2s_clk");
 	if (IS_ERR(i2s->mclk)) {
-- 
1.9.1
