From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: two jacks for hp and mic
Date: Fri, 14 Nov 2014 14:25:37 +0800
Message-ID: <1415946337-2752-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 756DE2664CF
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 07:26:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Some OS need headphone and microphone to be separated.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 17 ++++++++---------
 sound/soc/codecs/rt5645.h |  5 +++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 82d705a..31b5b1a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2203,8 +2203,7 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int rt5645_jack_detect(struct snd_soc_codec *codec,
-	struct snd_soc_jack *jack)
+static int rt5645_jack_detect(struct snd_soc_codec *codec)
 {
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 	int gpio_state, jack_type = 0;
@@ -2247,19 +2246,19 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec,
 		snd_soc_dapm_sync(&codec->dapm);
 	}
 
-	snd_soc_jack_report(rt5645->jack, jack_type, SND_JACK_HEADSET);
-
+	snd_soc_jack_report(rt5645->hp_jack, jack_type, SND_JACK_HEADPHONE);
+	snd_soc_jack_report(rt5645->mic_jack, jack_type, SND_JACK_MICROPHONE);
 	return 0;
 }
 
 int rt5645_set_jack_detect(struct snd_soc_codec *codec,
-	struct snd_soc_jack *jack)
+	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack)
 {
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
-	rt5645->jack = jack;
-
-	rt5645_jack_detect(codec, rt5645->jack);
+	rt5645->hp_jack = hp_jack;
+	rt5645->mic_jack = mic_jack;
+	rt5645_jack_detect(codec);
 
 	return 0;
 }
@@ -2270,7 +2269,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 	struct rt5645_priv *rt5645 =
 		container_of(work, struct rt5645_priv, jack_detect_work.work);
 
-	rt5645_jack_detect(rt5645->codec, rt5645->jack);
+	rt5645_jack_detect(rt5645->codec);
 }
 
 static irqreturn_t rt5645_irq(int irq, void *data)
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 196daf0..c72220a 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2173,7 +2173,8 @@ struct rt5645_priv {
 	struct rt5645_platform_data pdata;
 	struct regmap *regmap;
 	struct i2c_client *i2c;
-	struct snd_soc_jack *jack;
+	struct snd_soc_jack *hp_jack;
+	struct snd_soc_jack *mic_jack;
 	struct delayed_work jack_detect_work;
 
 	int sysclk;
@@ -2188,6 +2189,6 @@ struct rt5645_priv {
 };
 
 int rt5645_set_jack_detect(struct snd_soc_codec *codec,
-	struct snd_soc_jack *jack);
+	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack);
 
 #endif /* __RT5645_H__ */
-- 
1.8.1.1.439.g50a6b54
