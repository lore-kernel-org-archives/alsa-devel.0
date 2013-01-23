From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2000: Lock state machine updates
Date: Thu, 24 Jan 2013 00:02:40 +0800
Message-ID: <1358956960-5326-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 41FC026531C
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2013 17:03:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Need to ensure we don't get confused by simultaneous updates.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2000.c |   31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 655f43e..4d809ab 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -77,6 +77,8 @@ struct wm2000_priv {
 
 	int anc_download_size;
 	char *anc_download;
+
+	struct mutex lock;
 };
 
 static int wm2000_write(struct i2c_client *i2c, unsigned int reg,
@@ -614,13 +616,20 @@ static int wm2000_anc_mode_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 	int anc_active = ucontrol->value.enumerated.item[0];
+	int ret;
 
 	if (anc_active > 1)
 		return -EINVAL;
 
+	mutex_lock(&wm2000->lock);
+
 	wm2000->anc_active = anc_active;
 
-	return wm2000_anc_set_mode(wm2000);
+	ret = wm2000_anc_set_mode(wm2000);
+
+	mutex_unlock(&wm2000->lock);
+
+	return ret;
 }
 
 static int wm2000_speaker_get(struct snd_kcontrol *kcontrol,
@@ -640,13 +649,20 @@ static int wm2000_speaker_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 	int val = ucontrol->value.enumerated.item[0];
+	int ret;
 
 	if (val > 1)
 		return -EINVAL;
 
+	mutex_lock(&wm2000->lock);
+
 	wm2000->spk_ena = val;
 
-	return wm2000_anc_set_mode(wm2000);
+	ret = wm2000_anc_set_mode(wm2000);
+
+	mutex_unlock(&wm2000->lock);
+
+	return ret;
 }
 
 static const struct snd_kcontrol_new wm2000_controls[] = {
@@ -663,6 +679,9 @@ static int wm2000_anc_power_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+	int ret;
+
+	mutex_lock(&wm2000->lock);
 
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		wm2000->anc_eng_ena = 1;
@@ -670,7 +689,11 @@ static int wm2000_anc_power_event(struct snd_soc_dapm_widget *w,
 	if (SND_SOC_DAPM_EVENT_OFF(event))
 		wm2000->anc_eng_ena = 0;
 
-	return wm2000_anc_set_mode(wm2000);
+	ret = wm2000_anc_set_mode(wm2000);
+
+	mutex_unlock(&wm2000->lock);
+
+	return ret;
 }
 
 static const struct snd_soc_dapm_widget wm2000_dapm_widgets[] = {
@@ -800,6 +823,8 @@ static int wm2000_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 	}
 
+	mutex_init(&wm2000->lock);
+
 	dev_set_drvdata(&i2c->dev, wm2000);
 
 	wm2000->regmap = devm_regmap_init_i2c(i2c, &wm2000_regmap);
-- 
1.7.10.4
