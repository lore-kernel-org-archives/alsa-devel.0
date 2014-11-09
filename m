From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] ASoC: max98095: Move mutex to the driver
	level
Date: Sun,  9 Nov 2014 17:00:58 +0100
Message-ID: <1415548864-27203-3-git-send-email-lars@metafoo.de>
References: <1415548864-27203-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-182.synserver.de
 [212.40.185.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D88026054F
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 17:01:04 +0100 (CET)
In-Reply-To: <1415548864-27203-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org

The max98095 uses the snd_soc_codec mutex to protect against concurrent
access in some of its control put handlers. Move this mutex to the driver
level so we can eventually remove the snd_soc_codec mutex.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98095.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 0ee6797..01f3cc9 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -16,6 +16,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/clk.h>
+#include <linux/mutex.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -57,6 +58,7 @@ struct max98095_priv {
 	unsigned int mic2pre;
 	struct snd_soc_jack *headphone_jack;
 	struct snd_soc_jack *mic_jack;
+	struct mutex lock;
 };
 
 static const struct reg_default max98095_reg_def[] = {
@@ -1803,7 +1805,7 @@ static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
 	regsave = snd_soc_read(codec, M98095_088_CFG_LEVEL);
 	snd_soc_update_bits(codec, M98095_088_CFG_LEVEL, regmask, 0);
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&max98095->lock);
 	snd_soc_update_bits(codec, M98095_00F_HOST_CFG, M98095_SEG, M98095_SEG);
 	m98095_eq_band(codec, channel, 0, coef_set->band1);
 	m98095_eq_band(codec, channel, 1, coef_set->band2);
@@ -1811,7 +1813,7 @@ static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
 	m98095_eq_band(codec, channel, 3, coef_set->band4);
 	m98095_eq_band(codec, channel, 4, coef_set->band5);
 	snd_soc_update_bits(codec, M98095_00F_HOST_CFG, M98095_SEG, 0);
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&max98095->lock);
 
 	/* Restore the original on/off state */
 	snd_soc_update_bits(codec, M98095_088_CFG_LEVEL, regmask, regsave);
@@ -1957,12 +1959,12 @@ static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
 	regsave = snd_soc_read(codec, M98095_088_CFG_LEVEL);
 	snd_soc_update_bits(codec, M98095_088_CFG_LEVEL, regmask, 0);
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&max98095->lock);
 	snd_soc_update_bits(codec, M98095_00F_HOST_CFG, M98095_SEG, M98095_SEG);
 	m98095_biquad_band(codec, channel, 0, coef_set->band1);
 	m98095_biquad_band(codec, channel, 1, coef_set->band2);
 	snd_soc_update_bits(codec, M98095_00F_HOST_CFG, M98095_SEG, 0);
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&max98095->lock);
 
 	/* Restore the original on/off state */
 	snd_soc_update_bits(codec, M98095_088_CFG_LEVEL, regmask, regsave);
@@ -2395,6 +2397,8 @@ static int max98095_i2c_probe(struct i2c_client *i2c,
 	if (max98095 == NULL)
 		return -ENOMEM;
 
+	mutex_init(&max98095->lock);
+
 	max98095->regmap = devm_regmap_init_i2c(i2c, &max98095_regmap);
 	if (IS_ERR(max98095->regmap)) {
 		ret = PTR_ERR(max98095->regmap);
-- 
1.8.0
