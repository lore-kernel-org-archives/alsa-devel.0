From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: wm8753: Drop wm8753_writeable
	function
Date: Sat, 01 Aug 2015 10:04:52 +0800
Message-ID: <1438394692.6442.2.camel@ingics.com>
References: <1438394622.6442.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 158CF2615FC
 for <alsa-devel@alsa-project.org>; Sat,  1 Aug 2015 04:04:58 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so49344073pac.3
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2015 19:04:57 -0700 (PDT)
In-Reply-To: <1438394622.6442.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When .max_register is set and .writeable_reg is not implement, registers
between 0 and .max_register are writeable. This is the same as current
implementation of wm8753_writeable(), so just drop implementation for
.writeable_reg callback.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm8753.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index b5e50ff..ab1b6b8 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -138,11 +138,6 @@ static bool wm8753_volatile(struct device *dev, unsigned int reg)
 	return reg == WM8753_RESET;
 }
 
-static bool wm8753_writeable(struct device *dev, unsigned int reg)
-{
-	return reg <= WM8753_ADCTL2;
-}
-
 /* codec private data */
 struct wm8753_priv {
 	struct regmap *regmap;
@@ -1510,7 +1505,6 @@ static const struct regmap_config wm8753_regmap = {
 	.val_bits = 9,
 
 	.max_register = WM8753_ADCTL2,
-	.writeable_reg = wm8753_writeable,
 	.volatile_reg = wm8753_volatile,
 
 	.cache_type = REGCACHE_RBTREE,
-- 
2.1.0
