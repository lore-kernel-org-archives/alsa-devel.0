From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/7] ASoC: ac97: Add support for resetting
	device before registration
Date: Tue, 21 Jul 2015 21:53:01 +0200
Message-ID: <1437508386-13828-3-git-send-email-lars@metafoo.de>
References: <1437508386-13828-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-102.synserver.de (smtp-out-102.synserver.de
 [212.40.185.102])
 by alsa0.perex.cz (Postfix) with ESMTP id EF04D265128
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 21:53:20 +0200 (CEST)
In-Reply-To: <1437508386-13828-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

AC97 devices need to be initially reset before they can be used. Currently
each driver does this on its own.

Add support for resetting the device to core in snd_soc_new_ac97_codec().
If the caller supplies a device ID and device ID mask the function will
reset the device and verify that it has the correct ID, if it does not a
error is returned.

This will allow to remove custom code with similar functionality from
individual drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h         |  3 ++-
 sound/soc/codecs/ad1980.c   |  2 +-
 sound/soc/codecs/stac9766.c |  2 +-
 sound/soc/soc-ac97.c        | 30 +++++++++++++++++++++++++-----
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index add5097..4cef20e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -526,7 +526,8 @@ int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned int reg,
 
 #ifdef CONFIG_SND_SOC_AC97_BUS
 struct snd_ac97 *snd_soc_alloc_ac97_codec(struct snd_soc_codec *codec);
-struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec);
+struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
+	unsigned int id, unsigned int id_mask);
 void snd_soc_free_ac97_codec(struct snd_ac97 *ac97);
 
 int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops);
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 3cc69a6..d9cb81d 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -240,7 +240,7 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 	u16 vendor_id2;
 	u16 ext_status;
 
-	ac97 = snd_soc_new_ac97_codec(codec);
+	ac97 = snd_soc_new_ac97_codec(codec, 0, 0);
 	if (IS_ERR(ac97)) {
 		ret = PTR_ERR(ac97);
 		dev_err(codec->dev, "Failed to register AC97 codec: %d\n", ret);
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index ed4cca7..c602830 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -332,7 +332,7 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 	struct snd_ac97 *ac97;
 	int ret = 0;
 
-	ac97 = snd_soc_new_ac97_codec(codec);
+	ac97 = snd_soc_new_ac97_codec(codec, 0, 0);
 	if (IS_ERR(ac97))
 		return PTR_ERR(ac97);
 
diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index 08d7259..d40efc9 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -85,10 +85,19 @@ EXPORT_SYMBOL(snd_soc_alloc_ac97_codec);
 /**
  * snd_soc_new_ac97_codec - initailise AC97 device
  * @codec: audio codec
+ * @id: The expected device ID
+ * @id_mask: Mask that is applied to the device ID before comparing with @id
  *
  * Initialises AC97 codec resources for use by ad-hoc devices only.
+ *
+ * If @id is not 0 this function will reset the device, then read the ID from
+ * the device and check if it matches the expected ID. If it doesn't match an
+ * error will be returned and device will not be registered.
+ *
+ * Returns: A PTR_ERR() on failure or a valid snd_ac97 struct on success.
  */
-struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec)
+struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
+	unsigned int id, unsigned int id_mask)
 {
 	struct snd_ac97 *ac97;
 	int ret;
@@ -97,13 +106,24 @@ struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec)
 	if (IS_ERR(ac97))
 		return ac97;
 
-	ret = device_add(&ac97->dev);
-	if (ret) {
-		put_device(&ac97->dev);
-		return ERR_PTR(ret);
+	if (id) {
+		ret = snd_ac97_reset(ac97, false, id, id_mask);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to reset AC97 device: %d\n",
+				ret);
+			goto err_put_device;
+		}
 	}
 
+	ret = device_add(&ac97->dev);
+	if (ret)
+		goto err_put_device;
+
 	return ac97;
+
+err_put_device:
+	put_device(&ac97->dev);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
 
-- 
2.1.4
