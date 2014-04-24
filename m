From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFT v3 1/3] ASoC: core: Add helpers for dai link and
	aux dev init
Date: Thu, 24 Apr 2014 14:01:44 +0200
Message-ID: <1398340906-5017-2-git-send-email-bcousson@baylibre.com>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 3523626524C
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 14:02:22 +0200 (CEST)
Received: by mail-wg0-f52.google.com with SMTP id b13so948751wgh.35
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 05:02:22 -0700 (PDT)
In-Reply-To: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
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
 sound/soc/soc-core.c | 67 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 980da92..f18112a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1266,6 +1266,63 @@ static void rtd_release(struct device *dev)
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
@@ -1280,26 +1337,20 @@ static int soc_post_component_init(struct snd_soc_card *card,
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
 
-	/* do machine specific initialization */
-	if (!dailess && dai_link->init)
-		ret = dai_link->init(rtd);
-	else if (dailess && aux_dev->init)
-		ret = aux_dev->init(&codec->dapm);
 	if (ret < 0) {
 		dev_err(card->dev, "ASoC: failed to init %s: %d\n", name, ret);
 		return ret;
 	}
 
 	/* register the rtd device */
-	rtd->codec = codec;
-
 	rtd->dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	if (!rtd->dev)
 		return -ENOMEM;
-- 
1.8.3.2
