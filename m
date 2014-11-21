From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: adau17x1: Mark DSP parameter memory
	as readable and precious
Date: Fri, 21 Nov 2014 18:53:51 +0100
Message-ID: <1416592432-29132-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-173.synserver.de (smtp-out-173.synserver.de
 [212.40.185.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 724C5260694
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 18:54:01 +0100 (CET)
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
index 109fd78..a1baeee 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -798,6 +798,7 @@ const struct regmap_config adau1761_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(adau1761_reg_defaults),
 	.readable_reg = adau1761_readable_register,
 	.volatile_reg = adau17x1_volatile_register,
+	.precious_reg = adau17x1_precious_register,
 	.cache_type = REGCACHE_RBTREE,
 };
 EXPORT_SYMBOL_GPL(adau1761_regmap_config);
diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index 17966b6..35581f4 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -472,6 +472,7 @@ const struct regmap_config adau1781_regmap_config = {
 	.num_reg_defaults	= ARRAY_SIZE(adau1781_reg_defaults),
 	.readable_reg		= adau1781_readable_register,
 	.volatile_reg		= adau17x1_volatile_register,
+	.precious_reg		= adau17x1_precious_register,
 	.cache_type		= REGCACHE_RBTREE,
 };
 EXPORT_SYMBOL_GPL(adau1781_regmap_config);
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index d49bc7e..fa2e690 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -707,8 +707,22 @@ int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
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
index 6861aa3..e13583e 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -56,6 +56,7 @@ int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
 	enum adau17x1_micbias_voltage micbias);
 bool adau17x1_readable_register(struct device *dev, unsigned int reg);
 bool adau17x1_volatile_register(struct device *dev, unsigned int reg);
+bool adau17x1_precious_register(struct device *dev, unsigned int reg);
 int adau17x1_resume(struct snd_soc_codec *codec);
 
 extern const struct snd_soc_dai_ops adau17x1_dai_ops;
-- 
1.8.0
