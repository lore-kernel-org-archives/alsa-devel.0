From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: Move EXPORT_SYMBOL() in appropriate
	places
Date: Thu, 27 Feb 2014 16:03:48 +0100
Message-ID: <1393513428-27697-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 45E15265894
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 16:03:48 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EE17575015
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 15:03:47 +0000 (UTC)
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

Just a cleanup to follow the standard coding style.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/hwdep.c   |  3 +--
 sound/core/rawmidi.c | 35 +++++++++++++++++------------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index d6eb3ef3e3c7..69459e5f712e 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -395,6 +395,7 @@ int snd_hwdep_new(struct snd_card *card, char *id, int device,
 		*rhwdep = hwdep;
 	return 0;
 }
+EXPORT_SYMBOL(snd_hwdep_new);
 
 static int snd_hwdep_free(struct snd_hwdep *hwdep)
 {
@@ -567,5 +568,3 @@ static void __exit alsa_hwdep_exit(void)
 
 module_init(alsa_hwdep_init)
 module_exit(alsa_hwdep_exit)
-
-EXPORT_SYMBOL(snd_hwdep_new);
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 801c86133937..6fc71a4c8a51 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -172,6 +172,7 @@ int snd_rawmidi_drop_output(struct snd_rawmidi_substream *substream)
 	spin_unlock_irqrestore(&runtime->lock, flags);
 	return 0;
 }
+EXPORT_SYMBOL(snd_rawmidi_drop_output);
 
 int snd_rawmidi_drain_output(struct snd_rawmidi_substream *substream)
 {
@@ -203,6 +204,7 @@ int snd_rawmidi_drain_output(struct snd_rawmidi_substream *substream)
 	}
 	return err;
 }
+EXPORT_SYMBOL(snd_rawmidi_drain_output);
 
 int snd_rawmidi_drain_input(struct snd_rawmidi_substream *substream)
 {
@@ -217,6 +219,7 @@ int snd_rawmidi_drain_input(struct snd_rawmidi_substream *substream)
 	spin_unlock_irqrestore(&runtime->lock, flags);
 	return 0;
 }
+EXPORT_SYMBOL(snd_rawmidi_drain_input);
 
 /* look for an available substream for the given stream direction;
  * if a specific subdevice is given, try to assign it
@@ -354,6 +357,7 @@ int snd_rawmidi_kernel_open(struct snd_card *card, int device, int subdevice,
 		module_put(rmidi->card->module);
 	return err;
 }
+EXPORT_SYMBOL(snd_rawmidi_kernel_open);
 
 static int snd_rawmidi_open(struct inode *inode, struct file *file)
 {
@@ -532,6 +536,7 @@ int snd_rawmidi_kernel_release(struct snd_rawmidi_file *rfile)
 	module_put(rmidi->card->module);
 	return 0;
 }
+EXPORT_SYMBOL(snd_rawmidi_kernel_release);
 
 static int snd_rawmidi_release(struct inode *inode, struct file *file)
 {
@@ -608,6 +613,7 @@ int snd_rawmidi_info_select(struct snd_card *card, struct snd_rawmidi_info *info
 	}
 	return -ENXIO;
 }
+EXPORT_SYMBOL(snd_rawmidi_info_select);
 
 static int snd_rawmidi_info_select_user(struct snd_card *card,
 					struct snd_rawmidi_info __user *_info)
@@ -655,6 +661,7 @@ int snd_rawmidi_output_params(struct snd_rawmidi_substream *substream,
 	substream->active_sensing = !params->no_active_sensing;
 	return 0;
 }
+EXPORT_SYMBOL(snd_rawmidi_output_params);
 
 int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 			     struct snd_rawmidi_params * params)
@@ -680,6 +687,7 @@ int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 	runtime->avail_min = params->avail_min;
 	return 0;
 }
+EXPORT_SYMBOL(snd_rawmidi_input_params);
 
 static int snd_rawmidi_output_status(struct snd_rawmidi_substream *substream,
 				     struct snd_rawmidi_status * status)
@@ -935,6 +943,7 @@ int snd_rawmidi_receive(struct snd_rawmidi_substream *substream,
 	spin_unlock_irqrestore(&runtime->lock, flags);
 	return result;
 }
+EXPORT_SYMBOL(snd_rawmidi_receive);
 
 static long snd_rawmidi_kernel_read1(struct snd_rawmidi_substream *substream,
 				     unsigned char __user *userbuf,
@@ -977,6 +986,7 @@ long snd_rawmidi_kernel_read(struct snd_rawmidi_substream *substream,
 	snd_rawmidi_input_trigger(substream, 1);
 	return snd_rawmidi_kernel_read1(substream, NULL/*userbuf*/, buf, count);
 }
+EXPORT_SYMBOL(snd_rawmidi_kernel_read);
 
 static ssize_t snd_rawmidi_read(struct file *file, char __user *buf, size_t count,
 				loff_t *offset)
@@ -1052,6 +1062,7 @@ int snd_rawmidi_transmit_empty(struct snd_rawmidi_substream *substream)
 	spin_unlock_irqrestore(&runtime->lock, flags);
 	return result;		
 }
+EXPORT_SYMBOL(snd_rawmidi_transmit_empty);
 
 /**
  * snd_rawmidi_transmit_peek - copy data from the internal buffer
@@ -1108,6 +1119,7 @@ int snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
 	spin_unlock_irqrestore(&runtime->lock, flags);
 	return result;
 }
+EXPORT_SYMBOL(snd_rawmidi_transmit_peek);
 
 /**
  * snd_rawmidi_transmit_ack - acknowledge the transmission
@@ -1143,6 +1155,7 @@ int snd_rawmidi_transmit_ack(struct snd_rawmidi_substream *substream, int count)
 	spin_unlock_irqrestore(&runtime->lock, flags);
 	return count;
 }
+EXPORT_SYMBOL(snd_rawmidi_transmit_ack);
 
 /**
  * snd_rawmidi_transmit - copy from the buffer to the device
@@ -1164,6 +1177,7 @@ int snd_rawmidi_transmit(struct snd_rawmidi_substream *substream,
 		return count;
 	return snd_rawmidi_transmit_ack(substream, count);
 }
+EXPORT_SYMBOL(snd_rawmidi_transmit);
 
 static long snd_rawmidi_kernel_write1(struct snd_rawmidi_substream *substream,
 				      const unsigned char __user *userbuf,
@@ -1225,6 +1239,7 @@ long snd_rawmidi_kernel_write(struct snd_rawmidi_substream *substream,
 {
 	return snd_rawmidi_kernel_write1(substream, NULL, buf, count);
 }
+EXPORT_SYMBOL(snd_rawmidi_kernel_write);
 
 static ssize_t snd_rawmidi_write(struct file *file, const char __user *buf,
 				 size_t count, loff_t *offset)
@@ -1504,6 +1519,7 @@ int snd_rawmidi_new(struct snd_card *card, char *id, int device,
 		*rrawmidi = rmidi;
 	return 0;
 }
+EXPORT_SYMBOL(snd_rawmidi_new);
 
 static void snd_rawmidi_free_substreams(struct snd_rawmidi_str *stream)
 {
@@ -1687,6 +1703,7 @@ void snd_rawmidi_set_ops(struct snd_rawmidi *rmidi, int stream,
 	list_for_each_entry(substream, &rmidi->streams[stream].substreams, list)
 		substream->ops = ops;
 }
+EXPORT_SYMBOL(snd_rawmidi_set_ops);
 
 /*
  *  ENTRY functions
@@ -1725,21 +1742,3 @@ static void __exit alsa_rawmidi_exit(void)
 
 module_init(alsa_rawmidi_init)
 module_exit(alsa_rawmidi_exit)
-
-EXPORT_SYMBOL(snd_rawmidi_output_params);
-EXPORT_SYMBOL(snd_rawmidi_input_params);
-EXPORT_SYMBOL(snd_rawmidi_drop_output);
-EXPORT_SYMBOL(snd_rawmidi_drain_output);
-EXPORT_SYMBOL(snd_rawmidi_drain_input);
-EXPORT_SYMBOL(snd_rawmidi_receive);
-EXPORT_SYMBOL(snd_rawmidi_transmit_empty);
-EXPORT_SYMBOL(snd_rawmidi_transmit_peek);
-EXPORT_SYMBOL(snd_rawmidi_transmit_ack);
-EXPORT_SYMBOL(snd_rawmidi_transmit);
-EXPORT_SYMBOL(snd_rawmidi_new);
-EXPORT_SYMBOL(snd_rawmidi_set_ops);
-EXPORT_SYMBOL(snd_rawmidi_info_select);
-EXPORT_SYMBOL(snd_rawmidi_kernel_open);
-EXPORT_SYMBOL(snd_rawmidi_kernel_release);
-EXPORT_SYMBOL(snd_rawmidi_kernel_read);
-EXPORT_SYMBOL(snd_rawmidi_kernel_write);
-- 
1.9.0
