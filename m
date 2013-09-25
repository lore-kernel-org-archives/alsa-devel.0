From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: tlv320aic32x4: Move GPIO acquisition
	to I2C probe
Date: Wed, 25 Sep 2013 11:45:53 +0100
Message-ID: <1380105954-16787-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 45C69261AFE
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 12:47:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This is more idiomatic and interacts better with deferred probe.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 2ed57d4..cf70bf8 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -617,16 +617,11 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 {
 	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
 	u32 tmp_reg;
-	int ret;
 
 	codec->hw_write = (hw_write_t) i2c_master_send;
 	codec->control_data = aic32x4->control_data;
 
 	if (aic32x4->rstn_gpio >= 0) {
-		ret = devm_gpio_request_one(codec->dev, aic32x4->rstn_gpio,
-				GPIOF_OUT_INIT_LOW, "tlv320aic32x4 rstn");
-		if (ret != 0)
-			return ret;
 		ndelay(10);
 		gpio_set_value(aic32x4->rstn_gpio, 1);
 	}
@@ -735,6 +730,13 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 		aic32x4->rstn_gpio = -1;
 	}
 
+	if (aic32x4->rstn_gpio >= 0) {
+		ret = devm_gpio_request_one(&i2c->dev, aic32x4->rstn_gpio,
+				GPIOF_OUT_INIT_LOW, "tlv320aic32x4 rstn");
+		if (ret != 0)
+			return ret;
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_aic32x4, &aic32x4_dai, 1);
 	return ret;
-- 
1.8.4.rc3
