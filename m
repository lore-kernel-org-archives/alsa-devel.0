From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v5 3/5] ASoC: dapm: Add support for DAI
	multicodec
Date: Fri,  4 Jul 2014 18:07:53 +0200
Message-ID: <1404490075-24997-4-git-send-email-bcousson@baylibre.com>
References: <1404490075-24997-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id A2E37265A13
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 18:09:32 +0200 (CEST)
Received: by mail-wg0-f47.google.com with SMTP id a1so54817wgh.18
 for <alsa-devel@alsa-project.org>; Fri, 04 Jul 2014 09:09:32 -0700 (PDT)
In-Reply-To: <1404490075-24997-1-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Add multicodec support in soc-dapm.c

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 67 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4bf08cf..5c63c3b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2084,12 +2084,8 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mixer_update_power);
 
-/* show dapm widget status in sys fs */
-static ssize_t dapm_widget_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static ssize_t dapm_widget_show_codec(struct snd_soc_codec *codec, char *buf)
 {
-	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
-	struct snd_soc_codec *codec =rtd->codec;
 	struct snd_soc_dapm_widget *w;
 	int count = 0;
 	char *state = "not set";
@@ -2142,6 +2138,21 @@ static ssize_t dapm_widget_show(struct device *dev,
 	return count;
 }
 
+/* show dapm widget status in sys fs */
+static ssize_t dapm_widget_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
+	int i, count = 0;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_codec *codec = rtd->codec_dais[i]->codec;
+		count += dapm_widget_show_codec(codec, buf + count);
+	}
+
+	return count;
+}
+
 static DEVICE_ATTR(dapm_widget, 0444, dapm_widget_show, NULL);
 
 int snd_soc_dapm_sys_add(struct device *dev)
@@ -3395,25 +3406,18 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 	return 0;
 }
 
-void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
+static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
+					  struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_pcm_runtime *rtd = card->rtd;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dapm_widget *sink, *source;
-	struct snd_soc_dai *cpu_dai, *codec_dai;
+	struct snd_soc_dapm_route r;
 	int i;
 
-	/* for each BE DAI link... */
-	for (i = 0; i < card->num_rtd; i++) {
-		rtd = &card->rtd[i];
-		cpu_dai = rtd->cpu_dai;
-		codec_dai = rtd->codec_dai;
+	memset(&r, 0, sizeof(r));
 
-		/*
-		 * dynamic FE links have no fixed DAI mapping.
-		 * CODEC<->CODEC links have no direct connection.
-		 */
-		if (rtd->dai_link->dynamic || rtd->dai_link->params)
-			continue;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
 
 		/* there is no point in connecting BE DAI links with dummies */
 		if (snd_soc_dai_is_dummy(codec_dai) ||
@@ -3475,11 +3479,34 @@ static void soc_dapm_dai_stream_event(struct snd_soc_dai *dai, int stream,
 	}
 }
 
+void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd = card->rtd;
+	int i;
+
+	/* for each BE DAI link... */
+	for (i = 0; i < card->num_rtd; i++) {
+		rtd = &card->rtd[i];
+
+		/*
+		 * dynamic FE links have no fixed DAI mapping.
+		 * CODEC<->CODEC links have no direct connection.
+		 */
+		if (rtd->dai_link->dynamic || rtd->dai_link->params)
+			continue;
+
+		dapm_connect_dai_link_widgets(card, rtd);
+	}
+}
+
 static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 	int event)
 {
+	int i;
+
 	soc_dapm_dai_stream_event(rtd->cpu_dai, stream, event);
-	soc_dapm_dai_stream_event(rtd->codec_dai, stream, event);
+	for (i = 0; i < rtd->num_codecs; i++)
+		soc_dapm_dai_stream_event(rtd->codec_dais[i], stream, event);
 
 	dapm_power_widgets(rtd->card, event);
 }
-- 
1.9.1
