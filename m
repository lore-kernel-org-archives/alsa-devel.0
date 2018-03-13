From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7219: clkdev_drop usage depends on CONFIG_COMMON_CLK
Date: Tue, 13 Mar 2018 09:07:54 +0000
Message-ID: <20180313090755.030AA3FBD3@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fixes: ASoC: da7219: Add common clock usage for providing DAI clks

clkdev_drop usage in the codec remove function should be dependent
on if CONFIG_COMMON_CLK is defined for the platform, otherwise it
can cause build failures for platforms that do not support this.
The clkdev_* functions are still defined for those platforms, in
headers and source but the functions are not linked in.

This patch resolves this issue, so clkdev_drop is only used if
CONFIG_COMMON_CLK is defined.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 4412159..08f55d7 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1966,8 +1966,10 @@ static void da7219_remove(struct snd_soc_component *component)
 
 	da7219_aad_exit(component);
 
+#ifdef CONFIG_COMMON_CLK
 	if (da7219->dai_clks_lookup)
 		clkdev_drop(da7219->dai_clks_lookup);
+#endif
 
 	/* Supplies */
 	regulator_bulk_disable(DA7219_NUM_SUPPLIES, da7219->supplies);
-- 
1.9.1
