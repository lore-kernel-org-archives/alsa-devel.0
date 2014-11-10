From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/11] ASoC: ac97: Merge soc_ac97_dev_{un,
	}register()/soc_{un, }register_ac97_codec()
Date: Mon, 10 Nov 2014 22:41:48 +0100
Message-ID: <1415655713-29842-7-git-send-email-lars@metafoo.de>
References: <1415655713-29842-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-111.synserver.de (smtp-out-111.synserver.de
 [212.40.185.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0490B261AD8
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 22:42:22 +0100 (CET)
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

soc_{un,}register_ac97_codec() is just a simple wrapper around
soc_ac97_dev_{un,}register(). There is no need to split these up into two
different sets of functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-ac97.c | 80 ++++++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 50 deletions(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index dbfca7e..b5d23c9 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -42,18 +42,28 @@ static struct snd_ac97_bus soc_ac97_bus = {
 	.ops = NULL, /* Gets initialized in snd_soc_set_ac97_ops() */
 };
 
-/* unregister ac97 codec */
-static int soc_ac97_dev_unregister(struct snd_soc_codec *codec)
-{
-	if (codec->ac97->dev.bus)
-		device_del(&codec->ac97->dev);
-	return 0;
-}
-
 /* register ac97 codec to bus */
-static int soc_ac97_dev_register(struct snd_soc_codec *codec)
+static int soc_register_ac97_codec(struct snd_soc_codec *codec,
+	struct snd_soc_dai *codec_dai)
 {
-	int err;
+	int ret;
+
+	/* Only instantiate AC97 if not already done by the adaptor
+	 * for the generic AC97 subsystem.
+	 */
+	if (!codec_dai->driver->ac97_control || codec->ac97_registered)
+		return 0;
+
+	/*
+	 * It is possible that the AC97 device is already registered to
+	 * the device subsystem. This happens when the device is created
+	 * via snd_ac97_mixer(). Currently only SoC codec that does so
+	 * is the generic AC97 glue but others migh emerge.
+	 *
+	 * In those cases we don't try to register the device again.
+	 */
+	if (!codec->ac97_created)
+		return 0;
 
 	codec->ac97->dev.bus = &ac97_bus_type;
 	codec->ac97->dev.parent = codec->component.card->dev;
@@ -61,53 +71,23 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
 		     codec->component.card->snd_card->number, 0,
 		     codec->component.name);
-	err = device_add(&codec->ac97->dev);
-	if (err < 0) {
-		dev_err(codec->dev, "ASoC: Can't register ac97 bus\n");
-		codec->ac97->dev.bus = NULL;
-		return err;
+	ret = device_add(&codec->ac97->dev);
+	if (ret < 0) {
+		dev_err(codec->dev, "ASoC: AC97 device register failed: %d\n",
+			ret);
+		return ret;
 	}
-	return 0;
-}
-
-static int soc_register_ac97_codec(struct snd_soc_codec *codec,
-				   struct snd_soc_dai *codec_dai)
-{
-	int ret;
+	codec->ac97_registered = 1;
 
-	/* Only instantiate AC97 if not already done by the adaptor
-	 * for the generic AC97 subsystem.
-	 */
-	if (codec_dai->driver->ac97_control && !codec->ac97_registered) {
-		/*
-		 * It is possible that the AC97 device is already registered to
-		 * the device subsystem. This happens when the device is created
-		 * via snd_ac97_mixer(). Currently only SoC codec that does so
-		 * is the generic AC97 glue but others migh emerge.
-		 *
-		 * In those cases we don't try to register the device again.
-		 */
-		if (!codec->ac97_created)
-			return 0;
-
-		ret = soc_ac97_dev_register(codec);
-		if (ret < 0) {
-			dev_err(codec->dev,
-				"ASoC: AC97 device register failed: %d\n", ret);
-			return ret;
-		}
-
-		codec->ac97_registered = 1;
-	}
 	return 0;
 }
 
 static void soc_unregister_ac97_codec(struct snd_soc_codec *codec)
 {
-	if (codec->ac97_registered) {
-		soc_ac97_dev_unregister(codec);
-		codec->ac97_registered = 0;
-	}
+	if (!codec->ac97_registered)
+		return;
+	device_del(&codec->ac97->dev);
+	codec->ac97_registered = 0;
 }
 
 static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
-- 
1.8.0
