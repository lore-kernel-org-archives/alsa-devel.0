From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFT v2 4/6] ASoC: core: Add function for ac97 codec
	registration
Date: Fri, 21 Mar 2014 16:27:28 +0100
Message-ID: <1395415650-20045-5-git-send-email-bcousson@baylibre.com>
References: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 05A27265461
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 16:28:24 +0100 (CET)
Received: by mail-wi0-f182.google.com with SMTP id d1so624326wiv.15
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:28:24 -0700 (PDT)
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

Add codec registration specific function in preparation
for DAI-multicodec support.

No functional change.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
[fparent@baylibre.com: Adapt to 3.14+]
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 sound/soc/soc-core.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1debe3d..76fdf43 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1557,14 +1557,15 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 }
 
 #ifdef CONFIG_SND_SOC_AC97_BUS
-static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
+static int soc_register_ac97_codec(struct snd_soc_codec *codec,
+				   struct snd_soc_dai *codec_dai)
 {
 	int ret;
 
 	/* Only instantiate AC97 if not already done by the adaptor
 	 * for the generic AC97 subsystem.
 	 */
-	if (rtd->codec_dai->driver->ac97_control && !rtd->codec->ac97_registered) {
+	if (codec_dai->driver->ac97_control && !codec->ac97_registered) {
 		/*
 		 * It is possible that the AC97 device is already registered to
 		 * the device subsystem. This happens when the device is created
@@ -1573,28 +1574,38 @@ static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 		 *
 		 * In those cases we don't try to register the device again.
 		 */
-		if (!rtd->codec->ac97_created)
+		if (!codec->ac97_created)
 			return 0;
 
-		ret = soc_ac97_dev_register(rtd->codec);
+		ret = soc_ac97_dev_register(codec);
 		if (ret < 0) {
-			dev_err(rtd->codec->dev,
+			dev_err(codec->dev,
 				"ASoC: AC97 device register failed: %d\n", ret);
 			return ret;
 		}
 
-		rtd->codec->ac97_registered = 1;
+		codec->ac97_registered = 1;
 	}
 	return 0;
 }
 
-static void soc_unregister_ac97_dai_link(struct snd_soc_codec *codec)
+static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
+{
+	return soc_register_ac97_codec(rtd->codec, rtd->codec_dai);
+}
+
+static void soc_unregister_ac97_codec(struct snd_soc_codec *codec)
 {
 	if (codec->ac97_registered) {
 		soc_ac97_dev_unregister(codec);
 		codec->ac97_registered = 0;
 	}
 }
+
+static void soc_unregister_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
+{
+	soc_unregister_ac97_codec(rtd->codec);
+}
 #endif
 
 static int soc_check_aux_dev(struct snd_soc_card *card, int num)
@@ -1894,7 +1905,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 			dev_err(card->dev,
 				"ASoC: failed to register AC97: %d\n", ret);
 			while (--i >= 0)
-				soc_unregister_ac97_dai_link(card->rtd[i].codec);
+				soc_unregister_ac97_dai_link(&card->rtd[i]);
 			goto probe_aux_dev_err;
 		}
 	}
@@ -2330,7 +2341,7 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
 {
 	mutex_lock(&codec->mutex);
 #ifdef CONFIG_SND_SOC_AC97_BUS
-	soc_unregister_ac97_dai_link(codec);
+	soc_unregister_ac97_codec(codec);
 #endif
 	kfree(codec->ac97->bus);
 	kfree(codec->ac97);
-- 
1.8.3.2
