From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] ASoC: adau17x1: Mark DSP parameter memory
	as readable and precious
Date: Wed, 19 Nov 2014 18:29:03 +0100
Message-ID: <1416418148-14803-2-git-send-email-lars@metafoo.de>
References: <1416418148-14803-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-042.synserver.de (smtp-out-042.synserver.de
 [212.40.185.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 0861F2605DA
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 18:29:09 +0100 (CET)
In-Reply-To: <1416418148-14803-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

To be able to read back data from the DSP parameter memory the register
range needs to be marked as readable. At the same time we do not want them
to e.g. appear in debugfs output so mark them as precious as well.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1761.c |  1 +
 sound/soc/codecs/adau1781.c |  1 +
 sound/soc/codecs/adau17x1.c | 14 ++++++++++++++
 sound/soc/codecs/adau17x1.h |  1 +
 4 files changed, 17 insertions(+)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 16093dc..d4c0fd7 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -799,6 +799,7 @@ const struct regmap_config adau1761_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(adau1761_reg_defaults),
 	.readable_reg = adau1761_readable_register,
 	.volatile_reg = adau17x1_volatile_register,
+	.precious_reg = adau17x1_precious_register,
 	.cache_type = REGCACHE_RBTREE,
 };
 EXPORT_SYMBOL_GPL(adau1761_regmap_config);
diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index aa6a37c..c4dab80 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -488,6 +488,7 @@ const struct regmap_config adau1781_regmap_config = {
 	.num_reg_defaults	= ARRAY_SIZE(adau1781_reg_defaults),
 	.readable_reg		= adau1781_readable_register,
 	.volatile_reg		= adau17x1_volatile_register,
+	.precious_reg		= adau17x1_precious_register,
 	.cache_type		= REGCACHE_RBTREE,
 };
 EXPORT_SYMBOL_GPL(adau1781_regmap_config);
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 427ad77..c56420c 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -688,8 +688,22 @@ int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(adau17x1_set_micbias_voltage);
 
+bool adau17x1_precious_register(struct device *dev, unsigned int reg)
+{
+	/* SigmaDSP parameter memory */
+	if (reg < 0x400)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(adau17x1_precious_register);
+
 bool adau17x1_readable_register(struct device *dev, unsigned int reg)
 {
+	/* SigmaDSP parameter memory */
+	if (reg < 0x400)
+		return true;
+
 	switch (reg) {
 	case ADAU17X1_CLOCK_CONTROL:
 	case ADAU17X1_PLL_CONTROL:
diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
index e4a557f..870cd32 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -52,6 +52,7 @@ int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
 	enum adau17x1_micbias_voltage micbias);
 bool adau17x1_readable_register(struct device *dev, unsigned int reg);
 bool adau17x1_volatile_register(struct device *dev, unsigned int reg);
+bool adau17x1_precious_register(struct device *dev, unsigned int reg);
 int adau17x1_resume(struct snd_soc_codec *codec);
 
 extern const struct snd_soc_dai_ops adau17x1_dai_ops;
-- 
1.8.0
