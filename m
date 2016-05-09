From: John Keeping <john@metanate.com>
Subject: [PATCH 3/9] ASoC: es8328: Fix mask for VMIDSEL
Date: Mon,  9 May 2016 12:24:31 +0100
Message-ID: <20160509112437.8924-4-john@metanate.com>
References: <20160509112437.8924-1-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509112437.8924-1-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

This is always used along with ES8328_CONTROL1_ENREF so there is no
change in the generated code as a result of this fix.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/codecs/es8328.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8328.h b/sound/soc/codecs/es8328.h
index 5a4af014e516..8bc79fff0218 100644
--- a/sound/soc/codecs/es8328.h
+++ b/sound/soc/codecs/es8328.h
@@ -22,7 +22,7 @@ int es8328_probe(struct device *dev, struct regmap *regmap);
 #define ES8328_CONTROL1_VMIDSEL_50k (1 << 0)
 #define ES8328_CONTROL1_VMIDSEL_500k (2 << 0)
 #define ES8328_CONTROL1_VMIDSEL_5k (3 << 0)
-#define ES8328_CONTROL1_VMIDSEL_MASK (7 << 0)
+#define ES8328_CONTROL1_VMIDSEL_MASK (3 << 0)
 #define ES8328_CONTROL1_ENREF (1 << 2)
 #define ES8328_CONTROL1_SEQEN (1 << 3)
 #define ES8328_CONTROL1_SAMEFS (1 << 4)
-- 
2.8.0.rc4.238.g874082a
