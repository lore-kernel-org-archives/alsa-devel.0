From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/11] ASoC: ac97: Use static ac97_bus
Date: Mon, 10 Nov 2014 22:41:47 +0100
Message-ID: <1415655713-29842-6-git-send-email-lars@metafoo.de>
References: <1415655713-29842-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-111.synserver.de (smtp-out-111.synserver.de
 [212.40.185.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 378CA261AD0
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

We always pass soc_ac97_ops to snd_soc_new_ac97_codec(). So instead of
allocating a snd_ac97_bus in snd_soc_new_ac97_codec() just use a static one
that gets initialized when snd_soc_set_ac97_ops() is called.

Also drop the device number parameter from snd_soc_new_ac97_codec(). We
currently only support one device per bus and all drivers pass 0 for the
device number. And if we should ever support multiple devices per bus it
wouldn't be up to individual AC'97 device drivers to pick their number, but
rather either the AC'97 adapter driver or the core code will assign them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h         |  3 +--
 sound/soc/codecs/ad1980.c   |  2 +-
 sound/soc/codecs/stac9766.c |  2 +-
 sound/soc/codecs/wm9705.c   |  2 +-
 sound/soc/codecs/wm9712.c   |  2 +-
 sound/soc/codecs/wm9713.c   |  2 +-
 sound/soc/soc-ac97.c        | 22 ++++++++--------------
 7 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 49daf3d..84cb12c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -498,8 +498,7 @@ int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned int reg,
 				unsigned int mask, unsigned int value);
 
 #ifdef CONFIG_SND_SOC_AC97_BUS
-int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
-	struct snd_ac97_bus_ops *ops, int num);
+int snd_soc_new_ac97_codec(struct snd_soc_codec *codec);
 void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
 
 int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops);
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 9ed4e12..f71cc21 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -220,7 +220,7 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 	u16 vendor_id2;
 	u16 ext_status;
 
-	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to register AC97 codec\n");
 		return ret;
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 6c62d29..6d5bff6 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -329,7 +329,7 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
-	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec);
 	if (ret < 0)
 		goto codec_err;
 
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 1650195..2cb8a31 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -337,7 +337,7 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
-	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to register AC97 codec\n");
 		return ret;
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 3fad37e..6b36223 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -666,7 +666,7 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
-	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to register AC97 codec\n");
 		return ret;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 998e4c7..2071df7 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1219,7 +1219,7 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0, reg;
 
-	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
+	ret = snd_soc_new_ac97_codec(codec);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index da7b031..dbfca7e 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -38,6 +38,10 @@ struct snd_ac97_reset_cfg {
 	int gpio_reset;
 };
 
+static struct snd_ac97_bus soc_ac97_bus = {
+	.ops = NULL, /* Gets initialized in snd_soc_set_ac97_ops() */
+};
+
 /* unregister ac97 codec */
 static int soc_ac97_dev_unregister(struct snd_soc_codec *codec)
 {
@@ -140,27 +144,17 @@ static void soc_ac97_device_release(struct device *dev)
 /**
  * snd_soc_new_ac97_codec - initailise AC97 device
  * @codec: audio codec
- * @ops: AC97 bus operations
- * @num: AC97 codec number
  *
  * Initialises AC97 codec resources for use by ad-hoc devices only.
  */
-int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
-	struct snd_ac97_bus_ops *ops, int num)
+int snd_soc_new_ac97_codec(struct snd_soc_codec *codec)
 {
 	codec->ac97 = kzalloc(sizeof(struct snd_ac97), GFP_KERNEL);
 	if (codec->ac97 == NULL)
 		return -ENOMEM;
 
-	codec->ac97->bus = kzalloc(sizeof(struct snd_ac97_bus), GFP_KERNEL);
-	if (codec->ac97->bus == NULL) {
-		kfree(codec->ac97);
-		codec->ac97 = NULL;
-		return -ENOMEM;
-	}
-
-	codec->ac97->bus->ops = ops;
-	codec->ac97->num = num;
+	codec->ac97->bus = &soc_ac97_bus;
+	codec->ac97->num = 0;
 	codec->ac97->dev.release = soc_ac97_device_release;
 
 	/*
@@ -183,7 +177,6 @@ EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
 void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
 {
 	soc_unregister_ac97_codec(codec);
-	kfree(codec->ac97->bus);
 	codec->ac97->bus = NULL;
 	put_device(&codec->ac97->dev);
 	codec->ac97 = NULL;
@@ -314,6 +307,7 @@ int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops)
 		return -EBUSY;
 
 	soc_ac97_ops = ops;
+	soc_ac97_bus.ops = ops;
 
 	return 0;
 }
-- 
1.8.0
