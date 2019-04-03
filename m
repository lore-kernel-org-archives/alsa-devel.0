From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] ASoC: Mediatek: MT8183: TS3A227: fix build error
Date: Wed,  3 Apr 2019 05:05:01 +0200
Message-ID: <20190403030501.25140-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
List-Id: alsa-devel@alsa-project.org

When building CONFIG_SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=m the
following error pops up:

../sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c: In function ‘mt8183_mt6358_ts3a227_max98357_dev_probe’:
../sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c:325:13: error: ‘struct snd_soc_dai_link’ has no member named ‘platform’; did you mean ‘platforms’?
   dai_link->platform = NULL;
             ^~~~~~~~
             platforms

Rework to use 'dai_link->platforms' instead of 'dai_link->platform'.

Fixes: 11c0269017b2 ("ASoC: Mediatek: MT8183: Add machine driver with TS3A227")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 2da56232a9e1..a50c6af5c945 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -322,7 +322,7 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 		 * the "platform" will not null when probe is trying
 		 * again. It's not expected normally.
 		 */
-		dai_link->platform = NULL;
+		dai_link->platforms = NULL;
 
 		if (dai_link->platform_name)
 			continue;
-- 
2.20.1
