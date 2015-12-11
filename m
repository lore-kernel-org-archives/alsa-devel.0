From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH] ASoC: wm8974: set cache type for regmap
Date: Fri, 11 Dec 2015 11:27:08 +0000
Message-ID: <1449833229-3301-1-git-send-email-mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Attempting to use this codec driver triggers a BUG() in regcache_sync()
since no cache type is set.  The register map of this device is fairly
small and has few holes so a flat cache is suitable.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 sound/soc/codecs/wm8974.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 45ba828..c284c7b 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -574,6 +574,7 @@ static const struct regmap_config wm8974_regmap = {
 	.max_register = WM8974_MONOMIX,
 	.reg_defaults = wm8974_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm8974_reg_defaults),
+	.cache_type = REGCACHE_FLAT,
 };
 
 static int wm8974_probe(struct snd_soc_codec *codec)
-- 
2.6.3
