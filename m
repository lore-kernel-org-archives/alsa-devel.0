From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: wm8731: Drop wm8731_writeable
	function
Date: Sat, 01 Aug 2015 10:03:42 +0800
Message-ID: <1438394622.6442.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 1074B2615FC
 for <alsa-devel@alsa-project.org>; Sat,  1 Aug 2015 04:03:50 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so49331326pac.3
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2015 19:03:48 -0700 (PDT)
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
implementation of wm8731_writeable(), so just drop implementation for
.writeable_reg callback.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm8731.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index c862232..ace8645 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -79,11 +79,6 @@ static bool wm8731_volatile(struct device *dev, unsigned int reg)
 	return reg == WM8731_RESET;
 }
 
-static bool wm8731_writeable(struct device *dev, unsigned int reg)
-{
-	return reg <= WM8731_RESET;
-}
-
 #define wm8731_reset(m)	regmap_write(m, WM8731_RESET, 0)
 
 static const char *wm8731_input_select[] = {"Line In", "Mic"};
@@ -655,7 +650,6 @@ static const struct regmap_config wm8731_regmap = {
 
 	.max_register = WM8731_RESET,
 	.volatile_reg = wm8731_volatile,
-	.writeable_reg = wm8731_writeable,
 
 	.cache_type = REGCACHE_RBTREE,
 	.reg_defaults = wm8731_reg_defaults,
-- 
2.1.0
