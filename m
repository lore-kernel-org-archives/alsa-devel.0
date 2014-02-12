From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/10] ALSA: rawmidi: Use standard printk
	helpers
Date: Wed, 12 Feb 2014 12:33:07 +0100
Message-ID: <1392204792-12655-6-git-send-email-tiwai@suse.de>
References: <1392204792-12655-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C56326528D
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 12:33:18 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E783EAC5B
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:33:17 +0000 (UTC)
In-Reply-To: <1392204792-12655-1-git-send-email-tiwai@suse.de>
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

Use dev_err() & co as much as possible.  If not available (no device
assigned at the calling point), use pr_xxx() helpers instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/rawmidi.c | 49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index f6c12a2b019c..801c86133937 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -56,6 +56,13 @@ static int snd_rawmidi_dev_disconnect(struct snd_device *device);
 static LIST_HEAD(snd_rawmidi_devices);
 static DEFINE_MUTEX(register_mutex);
 
+#define rmidi_err(rmidi, fmt, args...) \
+	dev_err((rmidi)->card->dev, fmt, ##args)
+#define rmidi_warn(rmidi, fmt, args...) \
+	dev_warn((rmidi)->card->dev, fmt, ##args)
+#define rmidi_dbg(rmidi, fmt, args...) \
+	dev_dbg((rmidi)->card->dev, fmt, ##args)
+
 static struct snd_rawmidi *snd_rawmidi_search(struct snd_card *card, int device)
 {
 	struct snd_rawmidi *rawmidi;
@@ -180,7 +187,9 @@ int snd_rawmidi_drain_output(struct snd_rawmidi_substream *substream)
 	if (signal_pending(current))
 		err = -ERESTARTSYS;
 	if (runtime->avail < runtime->buffer_size && !timeout) {
-		snd_printk(KERN_WARNING "rawmidi drain error (avail = %li, buffer_size = %li)\n", (long)runtime->avail, (long)runtime->buffer_size);
+		rmidi_warn(substream->rmidi,
+			   "rawmidi drain error (avail = %li, buffer_size = %li)\n",
+			   (long)runtime->avail, (long)runtime->buffer_size);
 		err = -EIO;
 	}
 	runtime->drain = 0;
@@ -802,10 +811,9 @@ static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long
 			return -EINVAL;
 		}
 	}
-#ifdef CONFIG_SND_DEBUG
 	default:
-		snd_printk(KERN_WARNING "rawmidi: unknown command = 0x%x\n", cmd);
-#endif
+		rmidi_dbg(rfile->rmidi,
+			  "rawmidi: unknown command = 0x%x\n", cmd);
 	}
 	return -ENOTTY;
 }
@@ -875,7 +883,8 @@ int snd_rawmidi_receive(struct snd_rawmidi_substream *substream,
 	if (!substream->opened)
 		return -EBADFD;
 	if (runtime->buffer == NULL) {
-		snd_printd("snd_rawmidi_receive: input is not active!!!\n");
+		rmidi_dbg(substream->rmidi,
+			  "snd_rawmidi_receive: input is not active!!!\n");
 		return -EINVAL;
 	}
 	spin_lock_irqsave(&runtime->lock, flags);
@@ -1034,7 +1043,8 @@ int snd_rawmidi_transmit_empty(struct snd_rawmidi_substream *substream)
 	unsigned long flags;
 
 	if (runtime->buffer == NULL) {
-		snd_printd("snd_rawmidi_transmit_empty: output is not active!!!\n");
+		rmidi_dbg(substream->rmidi,
+			  "snd_rawmidi_transmit_empty: output is not active!!!\n");
 		return 1;
 	}
 	spin_lock_irqsave(&runtime->lock, flags);
@@ -1065,7 +1075,8 @@ int snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 
 	if (runtime->buffer == NULL) {
-		snd_printd("snd_rawmidi_transmit_peek: output is not active!!!\n");
+		rmidi_dbg(substream->rmidi,
+			  "snd_rawmidi_transmit_peek: output is not active!!!\n");
 		return -EINVAL;
 	}
 	result = 0;
@@ -1115,7 +1126,8 @@ int snd_rawmidi_transmit_ack(struct snd_rawmidi_substream *substream, int count)
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 
 	if (runtime->buffer == NULL) {
-		snd_printd("snd_rawmidi_transmit_ack: output is not active!!!\n");
+		rmidi_dbg(substream->rmidi,
+			  "snd_rawmidi_transmit_ack: output is not active!!!\n");
 		return -EINVAL;
 	}
 	spin_lock_irqsave(&runtime->lock, flags);
@@ -1413,7 +1425,7 @@ static int snd_rawmidi_alloc_substreams(struct snd_rawmidi *rmidi,
 	for (idx = 0; idx < count; idx++) {
 		substream = kzalloc(sizeof(*substream), GFP_KERNEL);
 		if (substream == NULL) {
-			snd_printk(KERN_ERR "rawmidi: cannot allocate substream\n");
+			rmidi_err(rmidi, "rawmidi: cannot allocate substream\n");
 			return -ENOMEM;
 		}
 		substream->stream = direction;
@@ -1458,7 +1470,7 @@ int snd_rawmidi_new(struct snd_card *card, char *id, int device,
 		*rrawmidi = NULL;
 	rmidi = kzalloc(sizeof(*rmidi), GFP_KERNEL);
 	if (rmidi == NULL) {
-		snd_printk(KERN_ERR "rawmidi: cannot allocate\n");
+		dev_err(card->dev, "rawmidi: cannot allocate\n");
 		return -ENOMEM;
 	}
 	rmidi->card = card;
@@ -1557,7 +1569,8 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 	if ((err = snd_register_device(SNDRV_DEVICE_TYPE_RAWMIDI,
 				       rmidi->card, rmidi->device,
 				       &snd_rawmidi_f_ops, rmidi, name)) < 0) {
-		snd_printk(KERN_ERR "unable to register rawmidi device %i:%i\n", rmidi->card->number, rmidi->device);
+		rmidi_err(rmidi, "unable to register rawmidi device %i:%i\n",
+			  rmidi->card->number, rmidi->device);
 		list_del(&rmidi->list);
 		mutex_unlock(&register_mutex);
 		return err;
@@ -1575,7 +1588,9 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 		if (snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_MIDI,
 					    rmidi->card, 0, &snd_rawmidi_f_ops,
 					    rmidi) < 0) {
-			snd_printk(KERN_ERR "unable to register OSS rawmidi device %i:%i\n", rmidi->card->number, 0);
+			rmidi_err(rmidi,
+				  "unable to register OSS rawmidi device %i:%i\n",
+				  rmidi->card->number, 0);
 		} else {
 			rmidi->ossreg++;
 #ifdef SNDRV_OSS_INFO_DEV_MIDI
@@ -1587,7 +1602,9 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 		if (snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_MIDI,
 					    rmidi->card, 1, &snd_rawmidi_f_ops,
 					    rmidi) < 0) {
-			snd_printk(KERN_ERR "unable to register OSS rawmidi device %i:%i\n", rmidi->card->number, 1);
+			rmidi_err(rmidi,
+				  "unable to register OSS rawmidi device %i:%i\n",
+				  rmidi->card->number, 1);
 		} else {
 			rmidi->ossreg++;
 		}
@@ -1685,11 +1702,13 @@ static int __init alsa_rawmidi_init(void)
 	/* check device map table */
 	for (i = 0; i < SNDRV_CARDS; i++) {
 		if (midi_map[i] < 0 || midi_map[i] >= SNDRV_RAWMIDI_DEVICES) {
-			snd_printk(KERN_ERR "invalid midi_map[%d] = %d\n", i, midi_map[i]);
+			pr_err("ALSA: rawmidi: invalid midi_map[%d] = %d\n",
+			       i, midi_map[i]);
 			midi_map[i] = 0;
 		}
 		if (amidi_map[i] < 0 || amidi_map[i] >= SNDRV_RAWMIDI_DEVICES) {
-			snd_printk(KERN_ERR "invalid amidi_map[%d] = %d\n", i, amidi_map[i]);
+			pr_err("ALSA: rawmidi: invalid amidi_map[%d] = %d\n",
+			       i, amidi_map[i]);
 			amidi_map[i] = 1;
 		}
 	}
-- 
1.8.5.2
