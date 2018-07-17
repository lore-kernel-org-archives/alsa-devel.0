From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: rawmidi: Simplify error paths
Date: Tue, 17 Jul 2018 23:19:47 +0200
Message-ID: <20180717211949.689-3-tiwai@suse.de>
References: <20180717211949.689-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EE2B2677BC
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 23:19:51 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1C565AD70
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 21:19:51 +0000 (UTC)
In-Reply-To: <20180717211949.689-1-tiwai@suse.de>
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

Apply the standard idiom: rewrite the multiple unlocks in error paths
in the goto-error-and-single-unlock way.

Just a code refactoring, and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/rawmidi.c | 76 +++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 14dec13ecde9..6b24c2d2dae6 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -338,22 +338,20 @@ int snd_rawmidi_kernel_open(struct snd_card *card, int device, int subdevice,
 			    int mode, struct snd_rawmidi_file *rfile)
 {
 	struct snd_rawmidi *rmidi;
-	int err;
+	int err = 0;
 
 	if (snd_BUG_ON(!rfile))
 		return -EINVAL;
 
 	mutex_lock(&register_mutex);
 	rmidi = snd_rawmidi_search(card, device);
-	if (rmidi == NULL) {
-		mutex_unlock(&register_mutex);
-		return -ENODEV;
-	}
-	if (!try_module_get(rmidi->card->module)) {
-		mutex_unlock(&register_mutex);
-		return -ENXIO;
-	}
+	if (!rmidi)
+		err = -ENODEV;
+	else if (!try_module_get(rmidi->card->module))
+		err = -ENXIO;
 	mutex_unlock(&register_mutex);
+	if (err < 0)
+		return err;
 
 	mutex_lock(&rmidi->open_mutex);
 	err = rawmidi_open_priv(rmidi, subdevice, mode, rfile);
@@ -1581,26 +1579,25 @@ int snd_rawmidi_new(struct snd_card *card, char *id, int device,
 					   &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT],
 					   SNDRV_RAWMIDI_STREAM_INPUT,
 					   input_count);
-	if (err < 0) {
-		snd_rawmidi_free(rmidi);
-		return err;
-	}
+	if (err < 0)
+		goto error;
 	err = snd_rawmidi_alloc_substreams(rmidi,
 					   &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT],
 					   SNDRV_RAWMIDI_STREAM_OUTPUT,
 					   output_count);
-	if (err < 0) {
-		snd_rawmidi_free(rmidi);
-		return err;
-	}
+	if (err < 0)
+		goto error;
 	err = snd_device_new(card, SNDRV_DEV_RAWMIDI, rmidi, &ops);
-	if (err < 0) {
-		snd_rawmidi_free(rmidi);
-		return err;
-	}
+	if (err < 0)
+		goto error;
+
 	if (rrawmidi)
 		*rrawmidi = rmidi;
 	return 0;
+
+ error:
+	snd_rawmidi_free(rmidi);
+	return err;
 }
 EXPORT_SYMBOL(snd_rawmidi_new);
 
@@ -1660,30 +1657,27 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 
 	if (rmidi->device >= SNDRV_RAWMIDI_DEVICES)
 		return -ENOMEM;
+	err = 0;
 	mutex_lock(&register_mutex);
-	if (snd_rawmidi_search(rmidi->card, rmidi->device)) {
-		mutex_unlock(&register_mutex);
-		return -EBUSY;
-	}
-	list_add_tail(&rmidi->list, &snd_rawmidi_devices);
+	if (snd_rawmidi_search(rmidi->card, rmidi->device))
+		err = -EBUSY;
+	else
+		list_add_tail(&rmidi->list, &snd_rawmidi_devices);
 	mutex_unlock(&register_mutex);
+	if (err < 0)
+		return err;
+
 	err = snd_register_device(SNDRV_DEVICE_TYPE_RAWMIDI,
 				  rmidi->card, rmidi->device,
 				  &snd_rawmidi_f_ops, rmidi, &rmidi->dev);
 	if (err < 0) {
 		rmidi_err(rmidi, "unable to register\n");
-		mutex_lock(&register_mutex);
-		list_del(&rmidi->list);
-		mutex_unlock(&register_mutex);
-		return err;
+		goto error;
 	}
-	if (rmidi->ops && rmidi->ops->dev_register &&
-	    (err = rmidi->ops->dev_register(rmidi)) < 0) {
-		snd_unregister_device(&rmidi->dev);
-		mutex_lock(&register_mutex);
-		list_del(&rmidi->list);
-		mutex_unlock(&register_mutex);
-		return err;
+	if (rmidi->ops && rmidi->ops->dev_register) {
+		err = rmidi->ops->dev_register(rmidi);
+		if (err < 0)
+			goto error_unregister;
 	}
 #ifdef CONFIG_SND_OSSEMUL
 	rmidi->ossreg = 0;
@@ -1735,6 +1729,14 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 	}
 #endif
 	return 0;
+
+ error_unregister:
+	snd_unregister_device(&rmidi->dev);
+ error:
+	mutex_lock(&register_mutex);
+	list_del(&rmidi->list);
+	mutex_unlock(&register_mutex);
+	return err;
 }
 
 static int snd_rawmidi_dev_disconnect(struct snd_device *device)
-- 
2.18.0
