From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv5 8/9] ASOC: wm8971: use regcache_sync to
	replace snd_soc_cache_sync
Date: Fri, 24 Oct 2014 14:00:34 +0800
Message-ID: <1414130435-14183-8-git-send-email-xavier.hsu@linaro.org>
References: <1414130435-14183-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id D4A4926049E
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 08:01:15 +0200 (CEST)
In-Reply-To: <1414130435-14183-1-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: Xavier Hsu <xavier.hsu@linaro.org>, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 sound/soc/codecs/wm8971.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 85314fb..751cd44 100755
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -38,6 +38,7 @@
 
 /* codec private data */
 struct wm8971_priv {
+	struct regmap *regmap;
 	/* MCLK */
 	unsigned int sysclk;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
@@ -720,6 +721,7 @@ static int wm8971_mute(struct snd_soc_dai *dai, int mute)
 static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 	u16 pwr_reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
 
 	switch (level) {
@@ -731,7 +733,7 @@ static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8971->regmap);
 
 		/* mute dac and set vmid to 500k, enable VREF */
 		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x0140);
@@ -865,7 +867,6 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8971_priv *wm8971;
-	struct regmap *regmap;
 	int ret;
 
 	wm8971 = devm_kzalloc(&i2c->dev, sizeof(struct wm8971_priv),
@@ -875,9 +876,9 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 
 	mutex_init(&wm8971->deemph_mutex);
 
-	regmap = devm_regmap_init_i2c(i2c, &wm8971_regmap);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	wm8971->regmap = devm_regmap_init_i2c(i2c, &wm8971_regmap);
+	if (IS_ERR(wm8971->regmap))
+		return PTR_ERR(wm8971->regmap);
 
 	i2c_set_clientdata(i2c, wm8971);
 
-- 
1.7.9.5
