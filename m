From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ASoC: tlv320aic3x: Mark the RESET register
	as volatile
Date: Fri, 23 Dec 2016 11:21:10 +0200
Message-ID: <20161223092112.7992-2-peter.ujfalusi@ti.com>
References: <20161223092112.7992-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id E52E2266949
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 10:21:06 +0100 (CET)
In-Reply-To: <20161223092112.7992-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jarkko.nikula@bitmer.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

The RESET register only have one self clearing bit and it should not be
cached. If it is cached, when we sync the registers back to the chip we
will initiate a software reset as well, which is not desirable.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 216f74084c6a..7b6924e19021 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -126,6 +126,16 @@ static const struct reg_default aic3x_reg[] = {
 	{ 108, 0x00 }, { 109, 0x00 },
 };
 
+static bool aic3x_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AIC3X_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct regmap_config aic3x_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -133,6 +143,9 @@ static const struct regmap_config aic3x_regmap = {
 	.max_register = DAC_ICC_ADJ,
 	.reg_defaults = aic3x_reg,
 	.num_reg_defaults = ARRAY_SIZE(aic3x_reg),
+
+	.volatile_reg = aic3x_volatile_reg,
+
 	.cache_type = REGCACHE_RBTREE,
 };
 
-- 
2.11.0
