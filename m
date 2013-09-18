From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: mc13783: Use regmap directly from
	ASoC
Date: Wed, 18 Sep 2013 19:06:27 +0100
Message-ID: <1379527587-14567-3-git-send-email-broonie@kernel.org>
References: <1379527587-14567-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C6A052610A4
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 20:06:54 +0200 (CEST)
In-Reply-To: <1379527587-14567-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Marc Reilly <marc@cpdesign.com.au>, u.kleine-koenig@pengutronix.de
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

As part of a push to remove the register I/O functionality from ASoC (since
it is now duplicated in the regmap API) convert the mc13783 driver to use
regmap directly.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/mc13783.c | 55 ++++++++--------------------------------------
 1 file changed, 9 insertions(+), 46 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 4d3c8fd..eedbf05 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -30,16 +30,10 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/soc-dapm.h>
+#include <linux/regmap.h>
 
 #include "mc13783.h"
 
-#define MC13783_AUDIO_RX0	36
-#define MC13783_AUDIO_RX1	37
-#define MC13783_AUDIO_TX	38
-#define MC13783_SSI_NETWORK	39
-#define MC13783_AUDIO_CODEC	40
-#define MC13783_AUDIO_DAC	41
-
 #define AUDIO_RX0_ALSPEN		(1 << 5)
 #define AUDIO_RX0_ALSPSEL		(1 << 7)
 #define AUDIO_RX0_ADDCDC		(1 << 21)
@@ -95,41 +89,12 @@
 
 struct mc13783_priv {
 	struct mc13xxx *mc13xxx;
+	struct regmap *regmap;
 
 	enum mc13783_ssi_port adc_ssi_port;
 	enum mc13783_ssi_port dac_ssi_port;
 };
 
-static unsigned int mc13783_read(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
-	unsigned int value = 0;
-
-	mc13xxx_lock(priv->mc13xxx);
-
-	mc13xxx_reg_read(priv->mc13xxx, reg, &value);
-
-	mc13xxx_unlock(priv->mc13xxx);
-
-	return value;
-}
-
-static int mc13783_write(struct snd_soc_codec *codec,
-	unsigned int reg, unsigned int value)
-{
-	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	mc13xxx_lock(priv->mc13xxx);
-
-	ret = mc13xxx_reg_write(priv->mc13xxx, reg, value);
-
-	mc13xxx_unlock(priv->mc13xxx);
-
-	return ret;
-}
-
 /* Mapping between sample rates and register value */
 static unsigned int mc13783_rates[] = {
 	8000, 11025, 12000, 16000,
@@ -583,8 +548,14 @@ static struct snd_kcontrol_new mc13783_control_list[] = {
 static int mc13783_probe(struct snd_soc_codec *codec)
 {
 	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
-	mc13xxx_lock(priv->mc13xxx);
+	codec->control_data = dev_get_regmap(codec->dev->parent, NULL);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 24, SND_SOC_REGMAP);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
 
 	/* these are the reset values */
 	mc13xxx_reg_write(priv->mc13xxx, MC13783_AUDIO_RX0, 0x25893);
@@ -608,8 +579,6 @@ static int mc13783_probe(struct snd_soc_codec *codec)
 		mc13xxx_reg_rmw(priv->mc13xxx, MC13783_AUDIO_DAC,
 				0, AUDIO_SSI_SEL);
 
-	mc13xxx_unlock(priv->mc13xxx);
-
 	return 0;
 }
 
@@ -617,13 +586,9 @@ static int mc13783_remove(struct snd_soc_codec *codec)
 {
 	struct mc13783_priv *priv = snd_soc_codec_get_drvdata(codec);
 
-	mc13xxx_lock(priv->mc13xxx);
-
 	/* Make sure VAUDIOON is off */
 	mc13xxx_reg_rmw(priv->mc13xxx, MC13783_AUDIO_RX0, 0x3, 0);
 
-	mc13xxx_unlock(priv->mc13xxx);
-
 	return 0;
 }
 
@@ -713,8 +678,6 @@ static struct snd_soc_dai_driver mc13783_dai_sync[] = {
 static struct snd_soc_codec_driver soc_codec_dev_mc13783 = {
 	.probe		= mc13783_probe,
 	.remove		= mc13783_remove,
-	.read		= mc13783_read,
-	.write		= mc13783_write,
 	.controls	= mc13783_control_list,
 	.num_controls	= ARRAY_SIZE(mc13783_control_list),
 	.dapm_widgets	= mc13783_dapm_widgets,
-- 
1.8.4.rc3
