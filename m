From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/24] ALSA: Drop unused name argument in
	snd_register_oss_device()
Date: Wed, 12 Feb 2014 11:35:17 +0100
Message-ID: <1392201340-27113-2-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AE2EB262610
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7BFB0AB5F
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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

The last argument, name, of snd_oss_register_device() is nowhere
referred in the function in the current code.  Let's drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h                | 3 +--
 include/sound/hwdep.h               | 1 -
 sound/core/hwdep.c                  | 3 +--
 sound/core/oss/mixer_oss.c          | 8 +++-----
 sound/core/oss/pcm_oss.c            | 4 +---
 sound/core/rawmidi.c                | 4 ++--
 sound/core/seq/oss/seq_oss.c        | 6 ++----
 sound/core/seq/oss/seq_oss_device.h | 1 -
 sound/core/sound_oss.c              | 3 +--
 sound/drivers/opl3/opl3_lib.c       | 4 +---
 10 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 2a14f1f02d4f..d0cee2c8c04f 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -249,8 +249,7 @@ int snd_add_device_sysfs_file(int type, struct snd_card *card, int dev,
 
 #ifdef CONFIG_SND_OSSEMUL
 int snd_register_oss_device(int type, struct snd_card *card, int dev,
-			    const struct file_operations *f_ops, void *private_data,
-			    const char *name);
+			    const struct file_operations *f_ops, void *private_data);
 int snd_unregister_oss_device(int type, struct snd_card *card, int dev);
 void *snd_lookup_oss_minor_data(unsigned int minor, int type);
 #endif
diff --git a/include/sound/hwdep.h b/include/sound/hwdep.h
index 8c05e47a4090..6233eb092d0a 100644
--- a/include/sound/hwdep.h
+++ b/include/sound/hwdep.h
@@ -60,7 +60,6 @@ struct snd_hwdep {
 	int iface;
 
 #ifdef CONFIG_SND_OSSEMUL
-	char oss_dev[32];
 	int oss_type;
 	int ossreg;
 #endif
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index d105073298cb..0f73f6951110 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -442,8 +442,7 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 		} else {
 			if (snd_register_oss_device(hwdep->oss_type,
 						    hwdep->card, hwdep->device,
-						    &snd_hwdep_f_ops, hwdep,
-						    hwdep->oss_dev) < 0) {
+						    &snd_hwdep_f_ops, hwdep) < 0) {
 				snd_printk(KERN_ERR "unable to register OSS compatibility device %i:%i\n",
 					   hwdep->card->number, hwdep->device);
 			} else
diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index e8a1d18774b2..fcb810142a49 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -1343,18 +1343,15 @@ static int snd_mixer_oss_notify_handler(struct snd_card *card, int cmd)
 	struct snd_mixer_oss *mixer;
 
 	if (cmd == SND_MIXER_OSS_NOTIFY_REGISTER) {
-		char name[128];
 		int idx, err;
 
 		mixer = kcalloc(2, sizeof(*mixer), GFP_KERNEL);
 		if (mixer == NULL)
 			return -ENOMEM;
 		mutex_init(&mixer->reg_mutex);
-		sprintf(name, "mixer%i%i", card->number, 0);
 		if ((err = snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_MIXER,
 						   card, 0,
-						   &snd_mixer_oss_f_ops, card,
-						   name)) < 0) {
+						   &snd_mixer_oss_f_ops, card)) < 0) {
 			snd_printk(KERN_ERR "unable to register OSS mixer device %i:%i\n",
 				   card->number, 0);
 			kfree(mixer);
@@ -1365,7 +1362,8 @@ static int snd_mixer_oss_notify_handler(struct snd_card *card, int cmd)
 		if (*card->mixername)
 			strlcpy(mixer->name, card->mixername, sizeof(mixer->name));
 		else
-			strlcpy(mixer->name, name, sizeof(mixer->name));
+			snprintf(mixer->name, sizeof(mixer->name),
+				 "mixer%i", card->number);
 #ifdef SNDRV_OSS_INFO_DEV_MIXERS
 		snd_oss_info_register(SNDRV_OSS_INFO_DEV_MIXERS,
 				      card->number,
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 4c1cc51772e6..c89349372385 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -3007,11 +3007,9 @@ static const struct file_operations snd_pcm_oss_f_reg =
 
 static void register_oss_dsp(struct snd_pcm *pcm, int index)
 {
-	char name[128];
-	sprintf(name, "dsp%i%i", pcm->card->number, pcm->device);
 	if (snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_PCM,
 				    pcm->card, index, &snd_pcm_oss_f_reg,
-				    pcm, name) < 0) {
+				    pcm) < 0) {
 		snd_printk(KERN_ERR "unable to register OSS PCM device %i:%i\n",
 			   pcm->card->number, pcm->device);
 	}
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index f016be72b100..f6c12a2b019c 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1574,7 +1574,7 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 	if ((int)rmidi->device == midi_map[rmidi->card->number]) {
 		if (snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_MIDI,
 					    rmidi->card, 0, &snd_rawmidi_f_ops,
-					    rmidi, name) < 0) {
+					    rmidi) < 0) {
 			snd_printk(KERN_ERR "unable to register OSS rawmidi device %i:%i\n", rmidi->card->number, 0);
 		} else {
 			rmidi->ossreg++;
@@ -1586,7 +1586,7 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 	if ((int)rmidi->device == amidi_map[rmidi->card->number]) {
 		if (snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_MIDI,
 					    rmidi->card, 1, &snd_rawmidi_f_ops,
-					    rmidi, name) < 0) {
+					    rmidi) < 0) {
 			snd_printk(KERN_ERR "unable to register OSS rawmidi device %i:%i\n", rmidi->card->number, 1);
 		} else {
 			rmidi->ossreg++;
diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
index 8d4d5e853efe..fef2d8275d0a 100644
--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -231,16 +231,14 @@ register_device(void)
 	mutex_lock(&register_mutex);
 	if ((rc = snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_SEQUENCER,
 					  NULL, 0,
-					  &seq_oss_f_ops, NULL,
-					  SNDRV_SEQ_OSS_DEVNAME)) < 0) {
+					  &seq_oss_f_ops, NULL)) < 0) {
 		snd_printk(KERN_ERR "can't register device seq\n");
 		mutex_unlock(&register_mutex);
 		return rc;
 	}
 	if ((rc = snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_MUSIC,
 					  NULL, 0,
-					  &seq_oss_f_ops, NULL,
-					  SNDRV_SEQ_OSS_DEVNAME)) < 0) {
+					  &seq_oss_f_ops, NULL)) < 0) {
 		snd_printk(KERN_ERR "can't register device music\n");
 		snd_unregister_oss_device(SNDRV_OSS_DEVICE_TYPE_SEQUENCER, NULL, 0);
 		mutex_unlock(&register_mutex);
diff --git a/sound/core/seq/oss/seq_oss_device.h b/sound/core/seq/oss/seq_oss_device.h
index c0154a959d55..07e3ea133b56 100644
--- a/sound/core/seq/oss/seq_oss_device.h
+++ b/sound/core/seq/oss/seq_oss_device.h
@@ -46,7 +46,6 @@
 #define SNDRV_SEQ_OSS_VERSION_STR	"0.1.8"
 
 /* device and proc interface name */
-#define SNDRV_SEQ_OSS_DEVNAME		"seq_oss"
 #define SNDRV_SEQ_OSS_PROCNAME		"oss"
 
 
diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c
index 5391c5e139ef..b19184d45f19 100644
--- a/sound/core/sound_oss.c
+++ b/sound/core/sound_oss.c
@@ -105,8 +105,7 @@ static int snd_oss_kernel_minor(int type, struct snd_card *card, int dev)
 }
 
 int snd_register_oss_device(int type, struct snd_card *card, int dev,
-			    const struct file_operations *f_ops, void *private_data,
-			    const char *name)
+			    const struct file_operations *f_ops, void *private_data)
 {
 	int minor = snd_oss_kernel_minor(type, card, dev);
 	int minor_unit;
diff --git a/sound/drivers/opl3/opl3_lib.c b/sound/drivers/opl3/opl3_lib.c
index 33d9a857a262..f66af5884c40 100644
--- a/sound/drivers/opl3/opl3_lib.c
+++ b/sound/drivers/opl3/opl3_lib.c
@@ -501,10 +501,8 @@ int snd_opl3_hwdep_new(struct snd_opl3 * opl3,
 	hw->private_data = opl3;
 	hw->exclusive = 1;
 #ifdef CONFIG_SND_OSSEMUL
-	if (device == 0) {
+	if (device == 0)
 		hw->oss_type = SNDRV_OSS_DEVICE_TYPE_DMFM;
-		sprintf(hw->oss_dev, "dmfm%i", card->number);
-	}
 #endif
 	strcpy(hw->name, hw->id);
 	switch (opl3->hardware & OPL3_HW_MASK) {
-- 
1.8.5.2
