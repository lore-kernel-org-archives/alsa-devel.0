From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] ASoC: Mediatek: MT8183: DA7219: fix build error
Date: Wed,  3 Apr 2019 08:55:47 +0200
Message-ID: <20190403065547.19382-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
List-Id: alsa-devel@alsa-project.org

When building CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=m the following
errro pops up:

../sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c: In function ‘mt8183_da7219_max98357_dev_probe’:
../sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c:413:13: error: ‘struct snd_soc_dai_link’ has no member named ‘platform’; did you mean ‘platforms’?
   dai_link->platform = NULL;
             ^~~~~~~~
             platforms

Rework to use 'dai_link->platforms' instead of 'dai_link->platform'.

Fixes: ebbddc75bbe8 ("ASoC: Mediatek: MT8183: Add machine driver with DA7219")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 93536659a859..1e7e8aed8707 100644
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
2.20.1
