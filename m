From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFT v2 5/6] ASoC: core: Add helpers for dai link and
	aux dev init
Date: Fri, 21 Mar 2014 16:27:29 +0100
Message-ID: <1395415650-20045-6-git-send-email-bcousson@baylibre.com>
References: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EE3A26546B
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 16:28:26 +0100 (CET)
Received: by mail-wi0-f180.google.com with SMTP id hn9so626330wib.7
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:28:26 -0700 (PDT)
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

Separate DAI link and aux dev initialization in preparation for
DAI multicodec support.
Since aux dev will remain using single codecs but DAI links
will be able to support multiple codecs.

No functional change.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
[fparent@baylibre.com: Adapt to 3.14+]
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 sound/soc/soc-core.c | 74 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 76fdf43..cfa481e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1268,6 +1268,63 @@ static void rtd_release(struct device *dev)
 	kfree(dev);
 }
 
+static int soc_aux_dev_init(struct snd_soc_card *card,
+			    struct snd_soc_codec *codec,
+			    int num)
+{
+	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
+	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
+	const char *temp;
+	int ret;
+
+	rtd->card = card;
+
+	temp = codec->name_prefix;
+	codec->name_prefix = NULL;
+
+	/* do machine specific initialization */
+	if (aux_dev->init) {
+		ret = aux_dev->init(&codec->dapm);
+		if (ret < 0)
+			return ret;
+	}
+
+	codec->name_prefix = temp;
+
+	rtd->codec = codec;
+
+	return 0;
+}
+
+static int soc_dai_link_init(struct snd_soc_card *card,
+			     struct snd_soc_codec *codec,
+			     int num)
+{
+	struct snd_soc_dai_link *dai_link =  &card->dai_link[num];
+	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
+	const char *temp;
+	int ret;
+
+	rtd->card = card;
+
+	/* machine controls, routes and widgets are not prefixed */
+	temp = codec->name_prefix;
+	codec->name_prefix = NULL;
+
+	/* do machine specific initialization */
+	if (dai_link->init) {
+		ret = dai_link->init(rtd);
+		if (ret < 0)
+			return ret;
+	}
+
+	codec->name_prefix = temp;
+
+	rtd->codec = codec;
+
+	return 0;
+}
+
 static int soc_post_component_init(struct snd_soc_card *card,
 				   struct snd_soc_codec *codec,
 				   int num, int dailess)
@@ -1275,38 +1332,27 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link = NULL;
 	struct snd_soc_aux_dev *aux_dev = NULL;
 	struct snd_soc_pcm_runtime *rtd;
-	const char *temp, *name;
+	const char *name;
 	int ret = 0;
 
 	if (!dailess) {
 		dai_link = &card->dai_link[num];
 		rtd = &card->rtd[num];
 		name = dai_link->name;
+		ret = soc_dai_link_init(card, codec, num);
 	} else {
 		aux_dev = &card->aux_dev[num];
 		rtd = &card->rtd_aux[num];
 		name = aux_dev->name;
+		ret = soc_aux_dev_init(card, codec, num);
 	}
-	rtd->card = card;
-
-	/* machine controls, routes and widgets are not prefixed */
-	temp = codec->name_prefix;
-	codec->name_prefix = NULL;
 
-	/* do machine specific initialization */
-	if (!dailess && dai_link->init)
-		ret = dai_link->init(rtd);
-	else if (dailess && aux_dev->init)
-		ret = aux_dev->init(&codec->dapm);
 	if (ret < 0) {
 		dev_err(card->dev, "ASoC: failed to init %s: %d\n", name, ret);
 		return ret;
 	}
-	codec->name_prefix = temp;
 
 	/* register the rtd device */
-	rtd->codec = codec;
-
 	rtd->dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	if (!rtd->dev)
 		return -ENOMEM;
-- 
1.8.3.2
