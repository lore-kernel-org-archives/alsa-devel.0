From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: adav80x: Remove .read_flag_mask setting
 from adav80x_regmap_config
Date: Fri, 14 Aug 2015 17:54:07 +0800
Message-ID: <1439546047.5150.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B38F2650F5
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 11:54:12 +0200 (CEST)
Received: by pdrg1 with SMTP id g1so29747384pdr.2
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 02:54:11 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Don't set .read_flag_mask for adav803, it's for adav801 only.

Fixes: 0c2d69645628 ("ASoC: adav80x: Split SPI and I2C code into different modules")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/adav80x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index 88fd37c..198c924 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -865,7 +865,6 @@ const struct regmap_config adav80x_regmap_config = {
 	.val_bits = 8,
 	.pad_bits = 1,
 	.reg_bits = 7,
-	.read_flag_mask = 0x01,
 
 	.max_register = ADAV80X_PLL_OUTE,
 
-- 
2.1.0
