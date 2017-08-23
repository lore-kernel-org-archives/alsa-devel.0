From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH v2 05/10] ASoC: rockchip: Remove unnecessary function call
Date: Wed, 23 Aug 2017 05:20:06 -0700
Message-ID: <3ec36b8e2a98a6080bdbbc800aa190000acae104.1503484313.git.dolinux.peng@gmail.com>
References: <cover.1503484313.git.dolinux.peng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503484313.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

The work of the function platform_set_drvdata is done by
devm_snd_soc_register_card.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/rockchip/rk3288_hdmi_analog.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index dbc53e48c52c..cf5bbd8b6ebc 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -266,13 +266,9 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev,
 			"Soc register card failed %d\n", ret);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, card);
 
 	return ret;
 }
-- 
2.14.1
