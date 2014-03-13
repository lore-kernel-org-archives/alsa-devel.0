From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: tlv320aic31xx: Staticise non-exported
	symbols
Date: Thu, 13 Mar 2014 17:48:20 +0000
Message-ID: <1394732900-17182-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 383A7265373
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 18:48:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index dcdc5751048f..d3517a919776 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -129,7 +129,7 @@ static const struct regmap_range_cfg aic31xx_ranges[] = {
 	},
 };
 
-struct regmap_config aic31xx_i2c_regmap = {
+static const struct regmap_config aic31xx_i2c_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.writeable_reg = aic31xx_writeable,
@@ -321,9 +321,9 @@ static const struct snd_kcontrol_new ldac_in_control =
 static const struct snd_kcontrol_new rdac_in_control =
 	SOC_DAPM_ENUM("DAC Right Input", rdac_in_enum);
 
-int aic31xx_wait_bits(struct aic31xx_priv *aic31xx, unsigned int reg,
-		      unsigned int mask, unsigned int wbits, int sleep,
-		      int count)
+static int aic31xx_wait_bits(struct aic31xx_priv *aic31xx, unsigned int reg,
+			     unsigned int mask, unsigned int wbits, int sleep,
+			     int count)
 {
 	unsigned int bits;
 	int counter = count;
@@ -1177,7 +1177,7 @@ static void aic31xx_pdata_from_of(struct aic31xx_priv *aic31xx)
 }
 #endif /* CONFIG_OF */
 
-void aic31xx_device_init(struct aic31xx_priv *aic31xx)
+static void aic31xx_device_init(struct aic31xx_priv *aic31xx)
 {
 	int ret, i;
 
-- 
1.9.0
