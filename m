From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/14] ALSA: compress: Embed struct device
Date: Mon,  2 Feb 2015 11:24:36 +0100
Message-ID: <1422872678-4815-13-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 79C83260513
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 119CFAD85
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:40 +0000 (UTC)
In-Reply-To: <1422872678-4815-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Like previous patches, this one embeds the struct device into struct
snd_compr.  As the dev field wasn't used beforehand, it's reused as
the new device struct.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/compress_driver.h |  4 ++--
 sound/core/compress_offload.c   | 24 +++++++++++++++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 396e8f73670a..1d0593b52573 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -134,7 +134,7 @@ struct snd_compr_ops {
 /**
  * struct snd_compr: Compressed device
  * @name: DSP device name
- * @dev: Device pointer
+ * @dev: associated device instance
  * @ops: pointer to DSP callbacks
  * @private_data: pointer to DSP pvt data
  * @card: sound card pointer
@@ -144,7 +144,7 @@ struct snd_compr_ops {
  */
 struct snd_compr {
 	const char *name;
-	struct device *dev;
+	struct device dev;
 	struct snd_compr_ops *ops;
 	void *private_data;
 	struct snd_card *card;
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 89028fab64fd..cb58c3f7f80c 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -868,12 +868,13 @@ static int snd_compress_dev_register(struct snd_device *device)
 		return -EBADFD;
 	compr = device->device_data;
 
-	sprintf(str, "comprC%iD%i", compr->card->number, compr->device);
 	pr_debug("reg %s for device %s, direction %d\n", str, compr->name,
 			compr->direction);
 	/* register compressed device */
-	ret = snd_register_device(SNDRV_DEVICE_TYPE_COMPRESS, compr->card,
-			compr->device, &snd_compr_file_ops, compr, str);
+	ret = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_COMPRESS,
+					  compr->card, compr->device,
+					  &snd_compr_file_ops, compr,
+					  &compr->dev, NULL, NULL);
 	if (ret < 0) {
 		pr_err("snd_register_device failed\n %d", ret);
 		return ret;
@@ -892,6 +893,15 @@ static int snd_compress_dev_disconnect(struct snd_device *device)
 	return 0;
 }
 
+static int snd_compress_dev_free(struct snd_device *device)
+{
+	struct snd_compr *compr;
+
+	compr = device->device_data;
+	put_device(&compr->dev);
+	return 0;
+}
+
 /*
  * snd_compress_new: create new compress device
  * @card: sound card pointer
@@ -903,7 +913,7 @@ int snd_compress_new(struct snd_card *card, int device,
 			int dirn, struct snd_compr *compr)
 {
 	static struct snd_device_ops ops = {
-		.dev_free = NULL,
+		.dev_free = snd_compress_dev_free,
 		.dev_register = snd_compress_dev_register,
 		.dev_disconnect = snd_compress_dev_disconnect,
 	};
@@ -911,6 +921,10 @@ int snd_compress_new(struct snd_card *card, int device,
 	compr->card = card;
 	compr->device = device;
 	compr->direction = dirn;
+
+	snd_device_initialize(&compr->dev, card);
+	dev_set_name(&compr->dev, "comprC%iD%i", card->number, device);
+
 	return snd_device_new(card, SNDRV_DEV_COMPRESS, compr, &ops);
 }
 EXPORT_SYMBOL_GPL(snd_compress_new);
@@ -948,7 +962,7 @@ int snd_compress_register(struct snd_compr *device)
 {
 	int retval;
 
-	if (device->name == NULL || device->dev == NULL || device->ops == NULL)
+	if (device->name == NULL || device->ops == NULL)
 		return -EINVAL;
 
 	pr_debug("Registering compressed device %s\n", device->name);
-- 
2.2.2
