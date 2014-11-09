From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] ASoC: wm5102: Move ultrasonic response
	settings lock to the driver level
Date: Sun,  9 Nov 2014 17:00:59 +0100
Message-ID: <1415548864-27203-4-git-send-email-lars@metafoo.de>
References: <1415548864-27203-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-182.synserver.de
 [212.40.185.182])
 by alsa0.perex.cz (Postfix) with ESMTP id AF791260550
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 17:01:05 +0100 (CET)
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

The wm5102 driver currently uses the snd_soc_codec mutex to protect its
ultrasonic response settings from concurrent access. This patch moves this
lock to the driver level. This will allow us to eventually remove the
snd_soc_codec mutex.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/mfd/arizona/core.h |  1 +
 sound/soc/codecs/arizona.c       |  4 ++--
 sound/soc/codecs/wm5102.c        | 16 ++++++++--------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/mfd/arizona/core.h b/include/linux/mfd/arizona/core.h
index f34723f..910e3aa 100644
--- a/include/linux/mfd/arizona/core.h
+++ b/include/linux/mfd/arizona/core.h
@@ -141,6 +141,7 @@ struct arizona {
 
 	uint16_t dac_comp_coeff;
 	uint8_t dac_comp_enabled;
+	struct mutex dac_comp_lock;
 };
 
 int arizona_clk32k_enable(struct arizona *arizona);
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 0c05e7a..730636c 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1164,13 +1164,13 @@ static void arizona_wm5102_set_dac_comp(struct snd_soc_codec *codec,
 		{ 0x80, 0x0 },
 	};
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&arizona->dac_comp_lock);
 
 	dac_comp[1].def = arizona->dac_comp_coeff;
 	if (rate >= 176400)
 		dac_comp[2].def = arizona->dac_comp_enabled;
 
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&arizona->dac_comp_lock);
 
 	regmap_multi_reg_write(arizona->regmap,
 			       dac_comp,
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index f602349..1f75534 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -619,10 +619,10 @@ static int wm5102_out_comp_coeff_get(struct snd_kcontrol *kcontrol,
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
 	uint16_t data;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&arizona->dac_comp_lock);
 	data = cpu_to_be16(arizona->dac_comp_coeff);
 	memcpy(ucontrol->value.bytes.data, &data, sizeof(data));
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&arizona->dac_comp_lock);
 
 	return 0;
 }
@@ -633,11 +633,11 @@ static int wm5102_out_comp_coeff_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&arizona->dac_comp_lock);
 	memcpy(&arizona->dac_comp_coeff, ucontrol->value.bytes.data,
 	       sizeof(arizona->dac_comp_coeff));
 	arizona->dac_comp_coeff = be16_to_cpu(arizona->dac_comp_coeff);
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&arizona->dac_comp_lock);
 
 	return 0;
 }
@@ -648,9 +648,9 @@ static int wm5102_out_comp_switch_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&arizona->dac_comp_lock);
 	ucontrol->value.integer.value[0] = arizona->dac_comp_enabled;
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&arizona->dac_comp_lock);
 
 	return 0;
 }
@@ -661,9 +661,9 @@ static int wm5102_out_comp_switch_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&arizona->dac_comp_lock);
 	arizona->dac_comp_enabled = ucontrol->value.integer.value[0];
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&arizona->dac_comp_lock);
 
 	return 0;
 }
-- 
1.8.0
