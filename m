From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFT v2 2/6] ASoC: core: Add helpers for codec DAI
	probe & remove
Date: Fri, 21 Mar 2014 16:27:26 +0100
Message-ID: <1395415650-20045-3-git-send-email-bcousson@baylibre.com>
References: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D1DA265373
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 16:28:22 +0100 (CET)
Received: by mail-wi0-f178.google.com with SMTP id bs8so623469wib.17
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:28:22 -0700 (PDT)
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

Add helper functions for codec DAI probe and remove in
preparation for DAI-multicodec support.

No functional change.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
[fparent@baylibre.com: Adapt to 3.14+]
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 sound/soc/soc-core.c | 74 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ab65137..1bcc446 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1010,21 +1010,10 @@ static void soc_remove_codec(struct snd_soc_codec *codec)
 	module_put(codec->dev->driver->owner);
 }
 
-static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
+static void soc_remove_codec_dai(struct snd_soc_dai *codec_dai, int order)
 {
-	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
 	int err;
 
-	/* unregister the rtd device */
-	if (rtd->dev_registered) {
-		device_remove_file(rtd->dev, &dev_attr_pmdown_time);
-		device_remove_file(rtd->dev, &dev_attr_codec_reg);
-		device_unregister(rtd->dev);
-		rtd->dev_registered = 0;
-	}
-
-	/* remove the CODEC DAI */
 	if (codec_dai && codec_dai->probed &&
 			codec_dai->driver->remove_order == order) {
 		if (codec_dai->driver->remove) {
@@ -1037,6 +1026,24 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 		codec_dai->probed = 0;
 		list_del(&codec_dai->card_list);
 	}
+}
+
+static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
+{
+	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
+	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
+	int err;
+
+	/* unregister the rtd device */
+	if (rtd->dev_registered) {
+		device_remove_file(rtd->dev, &dev_attr_pmdown_time);
+		device_remove_file(rtd->dev, &dev_attr_codec_reg);
+		device_unregister(rtd->dev);
+		rtd->dev_registered = 0;
+	}
+
+	/* remove the CODEC DAI */
+	soc_remove_codec_dai(codec_dai, order);
 
 	/* remove the cpu_dai */
 	if (cpu_dai && cpu_dai->probed &&
@@ -1386,6 +1393,31 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 	return 0;
 }
 
+static int soc_probe_codec_dai(struct snd_soc_card *card,
+			       struct snd_soc_dai *codec_dai,
+			       int order)
+{
+	int ret;
+
+	if (!codec_dai->probed && codec_dai->driver->probe_order == order) {
+		if (codec_dai->driver->probe) {
+			ret = codec_dai->driver->probe(codec_dai);
+			if (ret < 0) {
+				dev_err(codec_dai->dev,
+					"ASoC: failed to probe CODEC DAI %s: %d\n",
+					codec_dai->name, ret);
+				return ret;
+			}
+		}
+
+		/* mark codec_dai as probed and add to card dai list */
+		codec_dai->probed = 1;
+		list_add(&codec_dai->card_list, &card->dai_dev_list);
+	}
+
+	return 0;
+}
+
 static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
@@ -1435,21 +1467,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	}
 
 	/* probe the CODEC DAI */
-	if (!codec_dai->probed && codec_dai->driver->probe_order == order) {
-		if (codec_dai->driver->probe) {
-			ret = codec_dai->driver->probe(codec_dai);
-			if (ret < 0) {
-				dev_err(codec_dai->dev,
-					"ASoC: failed to probe CODEC DAI %s: %d\n",
-					codec_dai->name, ret);
-				return ret;
-			}
-		}
-
-		/* mark codec_dai as probed and add to card dai list */
-		codec_dai->probed = 1;
-		list_add(&codec_dai->card_list, &card->dai_dev_list);
-	}
+	ret = soc_probe_codec_dai(card, codec_dai, order);
+	if (ret)
+		return ret;
 
 	/* complete DAI probe during last probe */
 	if (order != SND_SOC_COMP_ORDER_LAST)
-- 
1.8.3.2
