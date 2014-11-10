From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/11] ASoC: Properly handle AC'97 device
	lifetime management
Date: Mon, 10 Nov 2014 22:41:45 +0100
Message-ID: <1415655713-29842-4-git-send-email-lars@metafoo.de>
References: <1415655713-29842-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-111.synserver.de (smtp-out-111.synserver.de
 [212.40.185.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B0C29261ACD
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 22:42:18 +0100 (CET)
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

The memory that a struct device is contained in must not be freed except
from within the device's release callback. The ASoC code currently does not
adhere to this rule for the AC'97 device. This patch fixes it by moving the
freeing of the AC'97 to the release callback and splitting up the
registration and unregistration of the device into separate steps for
getting/putting the reference to the device and adding/removing it to the
device hierarchy.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 397d00a..076dd36 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -501,13 +501,10 @@ EXPORT_SYMBOL_GPL(snd_soc_get_pcm_runtime);
 static int soc_ac97_dev_unregister(struct snd_soc_codec *codec)
 {
 	if (codec->ac97->dev.bus)
-		device_unregister(&codec->ac97->dev);
+		device_del(&codec->ac97->dev);
 	return 0;
 }
 
-/* stop no dev release warning */
-static void soc_ac97_device_release(struct device *dev){}
-
 /* register ac97 codec to bus */
 static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 {
@@ -515,12 +512,11 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 
 	codec->ac97->dev.bus = &ac97_bus_type;
 	codec->ac97->dev.parent = codec->component.card->dev;
-	codec->ac97->dev.release = soc_ac97_device_release;
 
 	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
 		     codec->component.card->snd_card->number, 0,
 		     codec->component.name);
-	err = device_register(&codec->ac97->dev);
+	err = device_add(&codec->ac97->dev);
 	if (err < 0) {
 		dev_err(codec->dev, "ASoC: Can't register ac97 bus\n");
 		codec->ac97->dev.bus = NULL;
@@ -1913,6 +1909,11 @@ static struct platform_driver soc_driver = {
 	.remove		= soc_remove,
 };
 
+static void soc_ac97_device_release(struct device *dev)
+{
+	kfree(to_ac97_t(dev));
+}
+
 /**
  * snd_soc_new_ac97_codec - initailise AC97 device
  * @codec: audio codec
@@ -1937,12 +1938,14 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 
 	codec->ac97->bus->ops = ops;
 	codec->ac97->num = num;
+	codec->ac97->dev.release = soc_ac97_device_release;
 
 	/*
 	 * Mark the AC97 device to be created by us. This way we ensure that the
 	 * device will be registered with the device subsystem later on.
 	 */
 	codec->ac97_created = 1;
+	device_initialize(&codec->ac97->dev);
 
 	return 0;
 }
@@ -2117,7 +2120,8 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
 	soc_unregister_ac97_codec(codec);
 #endif
 	kfree(codec->ac97->bus);
-	kfree(codec->ac97);
+	codec->ac97->bus = NULL;
+	put_device(&codec->ac97->dev);
 	codec->ac97 = NULL;
 	codec->ac97_created = 0;
 }
-- 
1.8.0
