From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ac97: Add support for resetting device
	before registration" to the asoc tree
Date: Thu, 23 Jul 2015 17:34:10 +0100
Message-ID: <E1ZIJRi-0001Qp-Lt@debutante>
References: <1437508386-13828-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4421265831
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 18:34:17 +0200 (CEST)
In-Reply-To: <1437508386-13828-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ac97: Add support for resetting device before registration

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7361fbeaeaab5282bbfc88f1f6fe4cf034f7623c Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 21 Jul 2015 21:53:01 +0200
Subject: [PATCH] ASoC: ac97: Add support for resetting device before
 registration

AC97 devices need to be initially reset before they can be used. Currently
each driver does this on its own.

Add support for resetting the device to core in snd_soc_new_ac97_codec().
If the caller supplies a device ID and device ID mask the function will
reset the device and verify that it has the correct ID, if it does not a
error is returned.

This will allow to remove custom code with similar functionality from
individual drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h         |  3 ++-
 sound/soc/codecs/ad1980.c   |  2 +-
 sound/soc/codecs/stac9766.c |  2 +-
 sound/soc/soc-ac97.c        | 30 +++++++++++++++++++++++++-----
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 93df8bf9d54a..42d144a4b7ba 100644
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
index 3cc69a626454..d9cb81dd64b5 100644
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
index ed4cca7f6779..c6028300c0ac 100644
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
index 08d7259bbaab..d40efc9fe0a9 100644
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
