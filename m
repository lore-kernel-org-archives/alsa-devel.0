From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH v2] ASoC: Mediatek: MT8183: Fix build error in mt8183_da7219_max98357_dev_probe
Date: Wed, 3 Apr 2019 12:15:52 +0800
Message-ID: <20190403041552.13968-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, shunli.wang@mediatek.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

From: YueHaibing <yuehaibing@huawei.com>

When building CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=m
gcc warn this:

sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c: In function mt8183_da7219_max98357_dev_probe:
sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c:413:13: error: struct snd_soc_dai_link has no member named platform; did you mean platforms?
   dai_link->platform = NULL;
             ^~~~~~~~
             platforms

use 'dai_link->platforms' instead of 'dai_link->platform'.

Fixes: 11c0269017b2 ("ASoC: Mediatek: MT8183: Add machine driver with TS3A227")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: use correct build log
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 9353665..1e7e8ae 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -410,7 +410,7 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
 		 * the "platform" will not null when probe is trying
 		 * again. It's not expected normally.
 		 */
-		dai_link->platform = NULL;
+		dai_link->platforms = NULL;
 
 		if (dai_link->platform_name)
 			continue;
-- 
2.7.0
