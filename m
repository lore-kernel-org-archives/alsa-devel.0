From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: adau1977: Fix truncation warning on 64
	bit architectures
Date: Fri,  1 Aug 2014 17:19:39 +0100
Message-ID: <1406909979-12990-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D2A6926568E
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 19:24:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Negating ADAU1977_BLOCK_POWER_SAI_LDO_EN creates an unsigned long constant
with all bits set which on 64 bit architectures needs to be truncated to
an unsigned int, generating a warning. Add an explicit cast since we know
this is OK.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/adau1977.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index fd55da7..70ab357 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -968,7 +968,7 @@ int adau1977_probe(struct device *dev, struct regmap *regmap,
 	if (adau1977->dvdd_reg)
 		power_off_mask = ~0;
 	else
-		power_off_mask = ~ADAU1977_BLOCK_POWER_SAI_LDO_EN;
+		power_off_mask = (unsigned int)~ADAU1977_BLOCK_POWER_SAI_LDO_EN;
 
 	ret = regmap_update_bits(adau1977->regmap, ADAU1977_REG_BLOCK_POWER_SAI,
 				power_off_mask, 0x00);
-- 
2.0.0
