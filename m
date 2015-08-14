From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: wm8741: Drop misleading readable_reg
 callback implementation
Date: Fri, 14 Aug 2015 17:58:01 +0800
Message-ID: <1439546281.5150.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id BB90D265152
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 11:58:06 +0200 (CEST)
Received: by pdbfa8 with SMTP id fa8so29668719pdb.1
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 02:58:04 -0700 (PDT)
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

regmap_readable() returns false if map->format.format_write is set.
For .reg_bits = 7, .val_bits = 9, setting,
  map->format.format_write = regmap_format_7_9_write;

Even current code has implemented map->readable_reg, regmap_readable()
still returns false anyway. Thus drop the misleading readable_reg callback
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm8741.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 9723e44..de42c03 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -61,25 +61,6 @@ static const struct reg_default wm8741_reg_defaults[] = {
 	{ 32, 0x0002 },     /* R32 - ADDITONAL_CONTROL_1 */
 };
 
-static bool wm8741_readable(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case WM8741_DACLLSB_ATTENUATION:
-	case WM8741_DACLMSB_ATTENUATION:
-	case WM8741_DACRLSB_ATTENUATION:
-	case WM8741_DACRMSB_ATTENUATION:
-	case WM8741_VOLUME_CONTROL:
-	case WM8741_FORMAT_CONTROL:
-	case WM8741_FILTER_CONTROL:
-	case WM8741_MODE_CONTROL_1:
-	case WM8741_MODE_CONTROL_2:
-	case WM8741_ADDITIONAL_CONTROL_1:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static int wm8741_reset(struct snd_soc_codec *codec)
 {
 	return snd_soc_write(codec, WM8741_RESET, 0);
@@ -541,8 +522,6 @@ static const struct regmap_config wm8741_regmap = {
 	.reg_defaults = wm8741_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm8741_reg_defaults),
 	.cache_type = REGCACHE_RBTREE,
-
-	.readable_reg = wm8741_readable,
 };
 
 static int wm8741_set_pdata(struct device *dev, struct wm8741_priv *wm8741)
-- 
2.1.0
