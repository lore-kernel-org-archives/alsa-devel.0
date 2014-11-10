From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/11] ASoC: ac97: Drop delayed device
	registration
Date: Mon, 10 Nov 2014 22:41:50 +0100
Message-ID: <1415655713-29842-9-git-send-email-lars@metafoo.de>
References: <1415655713-29842-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-111.synserver.de (smtp-out-111.synserver.de
 [212.40.185.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7468D261A68
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 22:49:05 +0100 (CET)
In-Reply-To: <1415655713-29842-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Sangbeom Kim <sbkim73@samsung.com>, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We have all the information and dependencies we need to initialize and
register the device available in snd_soc_new_ac97_codec(). So there is no
need to delay the device registration until after the card itself as been
registered.

This makes the code significantly simpler and also makes it possible to use
the AC'97 device in the CODECs probe function. The later will be required to
be able to convert the AC'97 CODEC drivers to regmap.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  10 -----
 sound/soc/soc-ac97.c | 118 ++++++---------------------------------------------
 sound/soc/soc-core.c |   4 --
 3 files changed, 14 insertions(+), 118 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f12efc3..2a3da45 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -506,15 +506,7 @@ int snd_soc_set_ac97_ops_of_reset(struct snd_ac97_bus_ops *ops,
 		struct platform_device *pdev);
 
 extern struct snd_ac97_bus_ops *soc_ac97_ops;
-
-int snd_soc_ac97_register_dai_links(struct snd_soc_card *card);
 #else
-
-static inline int snd_soc_ac97_register_dai_links(struct snd_soc_card *card)
-{
-	return 0;
-}
-
 static inline int snd_soc_set_ac97_ops_of_reset(struct snd_ac97_bus_ops *ops,
 	struct platform_device *pdev)
 {
@@ -801,8 +793,6 @@ struct snd_soc_codec {
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
 	unsigned int cache_bypass:1; /* Suppress access to the cache */
 	unsigned int suspended:1; /* Codec is in suspend PM state */
-	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
-	unsigned int ac97_created:1; /* Codec has been created by SoC */
 	unsigned int cache_init:1; /* codec cache has been initialized */
 
 	/* codec IO */
diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index f2ed77b..920d76c 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -42,80 +42,6 @@ static struct snd_ac97_bus soc_ac97_bus = {
 	.ops = NULL, /* Gets initialized in snd_soc_set_ac97_ops() */
 };
 
-/* register ac97 codec to bus */
-static int soc_register_ac97_codec(struct snd_soc_codec *codec,
-	struct snd_soc_dai *codec_dai)
-{
-	int ret;
-
-	/* Only instantiate AC97 if not already done by the adaptor
-	 * for the generic AC97 subsystem.
-	 */
-	if (!codec_dai->driver->ac97_control || codec->ac97_registered)
-		return 0;
-
-	/*
-	 * It is possible that the AC97 device is already registered to
-	 * the device subsystem. This happens when the device is created
-	 * via snd_ac97_mixer(). Currently only SoC codec that does so
-	 * is the generic AC97 glue but others migh emerge.
-	 *
-	 * In those cases we don't try to register the device again.
-	 */
-	if (!codec->ac97_created)
-		return 0;
-
-	codec->ac97->dev.bus = &ac97_bus_type;
-	codec->ac97->dev.parent = codec->component.card->dev;
-
-	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
-		     codec->component.card->snd_card->number, 0,
-		     codec->component.name);
-	ret = device_add(&codec->ac97->dev);
-	if (ret < 0) {
-		dev_err(codec->dev, "ASoC: AC97 device register failed: %d\n",
-			ret);
-		return ret;
-	}
-	codec->ac97_registered = 1;
-
-	return 0;
-}
-
-static void soc_unregister_ac97_codec(struct snd_soc_codec *codec)
-{
-	if (!codec->ac97_registered)
-		return;
-	device_del(&codec->ac97->dev);
-	codec->ac97_registered = 0;
-}
-
-static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
-{
-	int i, ret;
-
-	for (i = 0; i < rtd->num_codecs; i++) {
-		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
-
-		ret = soc_register_ac97_codec(codec_dai->codec, codec_dai);
-		if (ret) {
-			while (--i >= 0)
-				soc_unregister_ac97_codec(codec_dai->codec);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static void soc_unregister_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
-{
-	int i;
-
-	for (i = 0; i < rtd->num_codecs; i++)
-		soc_unregister_ac97_codec(rtd->codec_dais[i]->codec);
-}
-
 static void soc_ac97_device_release(struct device *dev)
 {
 	kfree(to_ac97_t(dev));
@@ -129,22 +55,28 @@ static void soc_ac97_device_release(struct device *dev)
  */
 int snd_soc_new_ac97_codec(struct snd_soc_codec *codec)
 {
+	int ret;
+
 	codec->ac97 = kzalloc(sizeof(struct snd_ac97), GFP_KERNEL);
 	if (codec->ac97 == NULL)
 		return -ENOMEM;
 
 	codec->ac97->bus = &soc_ac97_bus;
 	codec->ac97->num = 0;
+
+	codec->ac97->dev.bus = &ac97_bus_type;
+	codec->ac97->dev.parent = codec->component.card->dev;
 	codec->ac97->dev.release = soc_ac97_device_release;
 
-	/*
-	 * Mark the AC97 device to be created by us. This way we ensure that the
-	 * device will be registered with the device subsystem later on.
-	 */
-	codec->ac97_created = 1;
-	device_initialize(&codec->ac97->dev);
+	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
+		     codec->component.card->snd_card->number, 0,
+		     codec->component.name);
+
+	ret = device_register(&codec->ac97->dev);
+	if (ret)
+		put_device(&codec->ac97->dev);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
 
@@ -156,11 +88,10 @@ EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
  */
 void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
 {
-	soc_unregister_ac97_codec(codec);
+	device_del(&codec->ac97->dev);
 	codec->ac97->bus = NULL;
 	put_device(&codec->ac97->dev);
 	codec->ac97 = NULL;
-	codec->ac97_created = 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_free_ac97_codec);
 
@@ -321,24 +252,3 @@ int snd_soc_set_ac97_ops_of_reset(struct snd_ac97_bus_ops *ops,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_set_ac97_ops_of_reset);
-
-int snd_soc_ac97_register_dai_links(struct snd_soc_card *card)
-{
-	int i;
-	int ret;
-
-	/* register any AC97 codecs */
-	for (i = 0; i < card->num_rtd; i++) {
-		ret = soc_register_ac97_dai_link(&card->rtd[i]);
-		if (ret < 0)
-			goto err;
-	}
-
-	return 0;
-err:
-	dev_err(card->dev,
-		"ASoC: failed to register AC97: %d\n", ret);
-	while (--i >= 0)
-		soc_unregister_ac97_dai_link(&card->rtd[i]);
-	return ret;
-}
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7b21be5..e3618bc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1636,10 +1636,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		goto probe_aux_dev_err;
 	}
 
-	ret = snd_soc_ac97_register_dai_links(card);
-	if (ret < 0)
-		goto probe_aux_dev_err;
-
 	card->instantiated = 1;
 	snd_soc_dapm_sync(&card->dapm);
 	mutex_unlock(&card->mutex);
-- 
1.8.0
