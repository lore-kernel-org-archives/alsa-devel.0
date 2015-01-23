From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: Add support for allocating AC'97
	device before registering it
Date: Fri, 23 Jan 2015 16:21:36 +0100
Message-ID: <1422026497-23180-2-git-send-email-lars@metafoo.de>
References: <1422026497-23180-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-206.synserver.de
 [212.40.185.206])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E8ED265675
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:59:14 +0100 (CET)
In-Reply-To: <1422026497-23180-1-git-send-email-lars@metafoo.de>
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

In some cases it is necessary to before additional operations after the
device has been initialized and before the device is registered. This can
for example be resetting the device.

This patch introduces a new function snd_soc_alloc_ac97_codec() which is
similar to snd_soc_new_ac97_codec() except that it does not register the
device. Any users of snd_soc_alloc_ac97_codec() are responsible for calling
device_add() manually.

Fixes: 6794f709b712 ("ASoC: ac97: Drop delayed device registration")
Reported-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-ac97.c | 36 ++++++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index edd4a0a..0d1ade1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -501,6 +501,7 @@ int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned int reg,
 				unsigned int mask, unsigned int value);
 
 #ifdef CONFIG_SND_SOC_AC97_BUS
+struct snd_ac97 *snd_soc_alloc_ac97_codec(struct snd_soc_codec *codec);
 struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec);
 void snd_soc_free_ac97_codec(struct snd_ac97 *ac97);
 
diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index 2e10e9a..a3611e1 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -48,15 +48,18 @@ static void soc_ac97_device_release(struct device *dev)
 }
 
 /**
- * snd_soc_new_ac97_codec - initailise AC97 device
- * @codec: audio codec
+ * snd_soc_alloc_ac97_codec() - Allocate new a AC'97 device
+ * @codec: The CODEC for which to create the AC'97 device
  *
- * Initialises AC97 codec resources for use by ad-hoc devices only.
+ * Allocated a new snd_ac97 device and intializes it, but does not yet register
+ * it. The caller is responsible to either call device_add(&ac97->dev) to
+ * register the device, or to call put_device(&ac97->dev) to free the device.
+ *
+ * Returns: A snd_ac97 device or a PTR_ERR in case of an error.
  */
-struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec)
+struct snd_ac97 *snd_soc_alloc_ac97_codec(struct snd_soc_codec *codec)
 {
 	struct snd_ac97 *ac97;
-	int ret;
 
 	ac97 = kzalloc(sizeof(struct snd_ac97), GFP_KERNEL);
 	if (ac97 == NULL)
@@ -73,7 +76,28 @@ struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec)
 		     codec->component.card->snd_card->number, 0,
 		     codec->component.name);
 
-	ret = device_register(&ac97->dev);
+	device_initialize(&ac97->dev);
+
+	return ac97;
+}
+EXPORT_SYMBOL(snd_soc_alloc_ac97_codec);
+
+/**
+ * snd_soc_new_ac97_codec - initailise AC97 device
+ * @codec: audio codec
+ *
+ * Initialises AC97 codec resources for use by ad-hoc devices only.
+ */
+struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec)
+{
+	struct snd_ac97 *ac97;
+	int ret;
+
+	ac97 = snd_soc_alloc_ac97_codec(codec);
+	if (IS_ERR(ac97))
+		return ac97;
+
+	ret = device_add(&ac97->dev);
 	if (ret) {
 		put_device(&ac97->dev);
 		return ERR_PTR(ret);
-- 
1.8.0
