From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFT v2 1/6] ASoC: core: Add helpers for codec and
	codec_dai search
Date: Fri, 21 Mar 2014 16:27:25 +0100
Message-ID: <1395415650-20045-2-git-send-email-bcousson@baylibre.com>
References: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id B05882610A7
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 16:28:01 +0100 (CET)
Received: by mail-wg0-f52.google.com with SMTP id k14so1735309wgh.35
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:28:01 -0700 (PDT)
In-Reply-To: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
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
Cc: Fabien Parent <fparent@baylibre.com>, alsa-devel@alsa-project.org, lars@metafoo.de, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

Add dedicated helpers for codec and codec_dai search in preparation
for DAI-multicodec. It will help reducing the extra indentation
that will be introduced by the iteration over multiple codecs.

Previous implementation unnecessarily kept searching for a matching
codec in the remaining register codecs even if it was already found.

Fix that by returning in case of matching.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
[fparent@baylibre.com: Adapt to 3.14+]
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 sound/soc/soc-core.c | 79 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b322cf2..ab65137 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -854,14 +854,47 @@ EXPORT_SYMBOL_GPL(snd_soc_resume);
 static const struct snd_soc_dai_ops null_dai_ops = {
 };
 
+static struct snd_soc_codec *soc_find_codec(const struct device_node *codec_of_node,
+					    const char *codec_name)
+{
+	struct snd_soc_codec *codec;
+
+	list_for_each_entry(codec, &codec_list, list) {
+		if (codec_of_node) {
+			if (codec->dev->of_node != codec_of_node)
+				continue;
+		} else {
+			if (strcmp(codec->name, codec_name))
+				continue;
+		}
+
+		return codec;
+	}
+
+	return NULL;
+}
+
+static struct snd_soc_dai *soc_find_codec_dai(struct snd_soc_codec *codec,
+					      const char *codec_dai_name)
+{
+	struct snd_soc_dai *codec_dai;
+
+	list_for_each_entry(codec_dai, &codec->component.dai_list, list) {
+		if (!strcmp(codec_dai->name, codec_dai_name)) {
+			return codec_dai;
+		}
+	}
+
+	return NULL;
+}
+
 static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_component *component;
-	struct snd_soc_codec *codec;
 	struct snd_soc_platform *platform;
-	struct snd_soc_dai *codec_dai, *cpu_dai;
+	struct snd_soc_dai *cpu_dai;
 	const char *platform_name;
 
 	dev_dbg(card->dev, "ASoC: binding %s at idx %d\n", dai_link->name, num);
@@ -889,42 +922,24 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		return -EPROBE_DEFER;
 	}
 
-	/* Find CODEC from registered CODECs */
-	list_for_each_entry(codec, &codec_list, list) {
-		if (dai_link->codec_of_node) {
-			if (codec->dev->of_node != dai_link->codec_of_node)
-				continue;
-		} else {
-			if (strcmp(codec->name, dai_link->codec_name))
-				continue;
-		}
-
-		rtd->codec = codec;
-
-		/*
-		 * CODEC found, so find CODEC DAI from registered DAIs from
-		 * this CODEC
-		 */
-		list_for_each_entry(codec_dai, &codec->component.dai_list, list) {
-			if (!strcmp(codec_dai->name, dai_link->codec_dai_name)) {
-				rtd->codec_dai = codec_dai;
-				break;
-			}
-		}
-
-		if (!rtd->codec_dai) {
-			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
-				dai_link->codec_dai_name);
-			return -EPROBE_DEFER;
-		}
-	}
-
+	/* Find CODEC from registered list */
+	rtd->codec = soc_find_codec(dai_link->codec_of_node,
+				    dai_link->codec_name);
 	if (!rtd->codec) {
 		dev_err(card->dev, "ASoC: CODEC %s not registered\n",
 			dai_link->codec_name);
 		return -EPROBE_DEFER;
 	}
 
+	/* Find CODEC DAI from registered list */
+	rtd->codec_dai = soc_find_codec_dai(rtd->codec,
+					    dai_link->codec_dai_name);
+	if (!rtd->codec_dai) {
+		dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
+			dai_link->codec_dai_name);
+		return -EPROBE_DEFER;
+	}
+
 	/* if there's no platform we match on the empty platform */
 	platform_name = dai_link->platform_name;
 	if (!platform_name && !dai_link->platform_of_node)
-- 
1.8.3.2
