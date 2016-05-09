From: John Keeping <john@metanate.com>
Subject: [PATCH 4/9] ASoC: es8328: Use single R/W for regmap
Date: Mon,  9 May 2016 12:24:32 +0100
Message-ID: <20160509112437.8924-5-john@metanate.com>
References: <20160509112437.8924-1-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509112437.8924-1-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

The chip only supports single reads and writes.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/codecs/es8328.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 63e82628222c..d580300d9220 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -713,6 +713,7 @@ const struct regmap_config es8328_regmap_config = {
 	.val_bits	= 8,
 	.max_register	= ES8328_REG_MAX,
 	.cache_type	= REGCACHE_RBTREE,
+	.use_single_rw	= true,
 };
 EXPORT_SYMBOL_GPL(es8328_regmap_config);
 
-- 
2.8.0.rc4.238.g874082a
