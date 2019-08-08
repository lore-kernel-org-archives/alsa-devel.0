From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: tscs454: remove unused variable 'PLL_48K_RATE'
Date: Thu, 8 Aug 2019 11:25:52 +0800
Message-ID: <20190808032552.45360-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: steven.eckhoff.opensource@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

The global variable 'PLL_48K_RATE' is never used
so just remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/tscs454.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index 93d84e5..c3587af 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -22,7 +22,6 @@
 
 #include "tscs454.h"
 
-static const unsigned int PLL_48K_RATE = (48000 * 256);
 static const unsigned int PLL_44_1K_RATE = (44100 * 256);
 
 #define COEFF_SIZE 3
-- 
2.7.4
