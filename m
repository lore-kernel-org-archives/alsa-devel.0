From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/14] ALSA: rawmidi: Embed struct device
Date: Mon,  2 Feb 2015 11:24:31 +0100
Message-ID: <1422872678-4815-8-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 71EA92604FF
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C9FC1ACF8
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:39 +0000 (UTC)
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

Like previous patches, this changes the device management for rawmidi,
embedding the struct device into struct snd_rawmidi.  The required
change is more or less same as hwdep device.

The currently unused dev field is reused as the new embedded struct
field now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/rawmidi.h |  4 +++-
 sound/core/rawmidi.c    | 24 +++++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index 311dafe6cc4b..f6cbef78db62 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -28,6 +28,7 @@
 #include <linux/wait.h>
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
+#include <linux/device.h>
 
 #if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
 #include <sound/seq_device.h>
@@ -139,7 +140,8 @@ struct snd_rawmidi {
 	struct mutex open_mutex;
 	wait_queue_head_t open_wait;
 
-	struct snd_info_entry *dev;
+	struct device dev;
+
 	struct snd_info_entry *proc_entry;
 
 #if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index be18162c380f..932396c81035 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1443,6 +1443,11 @@ static int snd_rawmidi_alloc_substreams(struct snd_rawmidi *rmidi,
 	return 0;
 }
 
+static void release_rawmidi_device(struct device *dev)
+{
+	kfree(container_of(dev, struct snd_rawmidi, dev));
+}
+
 /**
  * snd_rawmidi_new - create a rawmidi instance
  * @card: the card instance
@@ -1487,6 +1492,11 @@ int snd_rawmidi_new(struct snd_card *card, char *id, int device,
 
 	if (id != NULL)
 		strlcpy(rmidi->id, id, sizeof(rmidi->id));
+
+	snd_device_initialize(&rmidi->dev, card);
+	rmidi->dev.release = release_rawmidi_device;
+	dev_set_name(&rmidi->dev, "midiC%iD%i", card->number, device);
+
 	if ((err = snd_rawmidi_alloc_substreams(rmidi,
 						&rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT],
 						SNDRV_RAWMIDI_STREAM_INPUT,
@@ -1538,7 +1548,7 @@ static int snd_rawmidi_free(struct snd_rawmidi *rmidi)
 	snd_rawmidi_free_substreams(&rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT]);
 	if (rmidi->private_free)
 		rmidi->private_free(rmidi);
-	kfree(rmidi);
+	put_device(&rmidi->dev);
 	return 0;
 }
 
@@ -1571,12 +1581,12 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 		return -EBUSY;
 	}
 	list_add_tail(&rmidi->list, &snd_rawmidi_devices);
-	sprintf(name, "midiC%iD%i", rmidi->card->number, rmidi->device);
-	if ((err = snd_register_device(SNDRV_DEVICE_TYPE_RAWMIDI,
-				       rmidi->card, rmidi->device,
-				       &snd_rawmidi_f_ops, rmidi, name)) < 0) {
-		rmidi_err(rmidi, "unable to register rawmidi device %i:%i\n",
-			  rmidi->card->number, rmidi->device);
+	err = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_RAWMIDI,
+					  rmidi->card, rmidi->device,
+					  &snd_rawmidi_f_ops, rmidi,
+					  &rmidi->dev, NULL, NULL);
+	if (err < 0) {
+		rmidi_err(rmidi, "unable to register\n");
 		list_del(&rmidi->list);
 		mutex_unlock(&register_mutex);
 		return err;
-- 
2.2.2
