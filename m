From: Pawel MOLL <pawel.moll@st.com>
Subject: Re: [PATCH 1/1] ALSA: Fix limit of 8
	PCM	devices	in	SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE
Date: Wed, 30 Jul 2008 12:46:40 +0100
Message-ID: <1217418400.29863.64.camel@bri1004.bri.st.com>
References: <1217349266.29863.40.camel@bri1004.bri.st.com>
	<s5hd4kv4ql4.wl%tiwai@suse.de>
	<1217414748.29863.60.camel@bri1004.bri.st.com>
	<s5h8wvj4ov0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h8wvj4ov0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA: Fix limit of 8 PCM devices in SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE

When compiled with CONFIG_SND_DYNAMIC_MINORS the ALSA core is fine
to have more than 8 PCM devices per card, except one place - the
SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE ioctl, which will not enumerate
devices > 7. This patch fixes the issue, changing the devices list
organisation.

Instead of adding new device to the tail, the list is now kept always
ordered (by card number, then device number). Thus, during enumeration,
it is easy to discover the fact that there is no more given card's
devices.

Additionally the device field of struct snd_pcm had to be changed to int,
as its "unsignednity" caused a lot of problems when comparing it to
potentially negative signed values. (-1 is 0xffffffff or even more then ;-)

Signed-off-by: Pawel Moll <pawel.moll@st.com>

diff --git a/include/sound/minors.h b/include/sound/minors.h
index 46bcd20..a81798a 100644
--- a/include/sound/minors.h
+++ b/include/sound/minors.h
@@ -21,6 +21,8 @@
  *
  */
 
+#define SNDRV_OS_MINORS			256
+
 #define SNDRV_MINOR_DEVICES		32
 #define SNDRV_MINOR_CARD(minor)		((minor) >> 5)
 #define SNDRV_MINOR_DEVICE(minor)	((minor) & 0x001f)
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 51d58cc..5dd8ea4 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -25,6 +25,7 @@
 
 #include <sound/asound.h>
 #include <sound/memalloc.h>
+#include <sound/minors.h>
 #include <linux/poll.h>
 #include <linux/mm.h>
 #include <linux/bitops.h>
@@ -84,7 +85,11 @@ struct snd_pcm_ops {
  *
  */
 
-#define SNDRV_PCM_DEVICES		8
+#if defined(CONFIG_SND_DYNAMIC_MINORS)
+#define SNDRV_PCM_DEVICES	(SNDRV_OS_MINORS-2)
+#else
+#define SNDRV_PCM_DEVICES	8
+#endif
 
 #define SNDRV_PCM_IOCTL1_FALSE		((void *)0)
 #define SNDRV_PCM_IOCTL1_TRUE		((void *)1)
@@ -416,7 +421,7 @@ struct snd_pcm_str {
 struct snd_pcm {
 	struct snd_card *card;
 	struct list_head list;
-	unsigned int device;	/* device number */
+	int device; /* device number */
 	unsigned int info_flags;
 	unsigned short dev_class;
 	unsigned short dev_subclass;
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 9dd9bc7..4c6facb 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -42,7 +42,7 @@ static int snd_pcm_dev_free(struct snd_device *device);
 static int snd_pcm_dev_register(struct snd_device *device);
 static int snd_pcm_dev_disconnect(struct snd_device *device);
 
-static struct snd_pcm *snd_pcm_search(struct snd_card *card, int device)
+static struct snd_pcm *snd_pcm_get(struct snd_card *card, int device)
 {
 	struct snd_pcm *pcm;
 
@@ -53,6 +53,37 @@ static struct snd_pcm *snd_pcm_search(struct snd_card *card, int device)
 	return NULL;
 }
 
+static int snd_pcm_next(struct snd_card *card, int device)
+{
+	struct snd_pcm *pcm;
+
+	list_for_each_entry(pcm, &snd_pcm_devices, list) {
+		if (pcm->card == card && pcm->device > device)
+			return pcm->device;
+		else if (pcm->card->number > card->number)
+			return -1;
+	}
+	return -1;
+}
+
+static int snd_pcm_add(struct snd_pcm *newpcm)
+{
+	struct snd_pcm *pcm;
+
+	list_for_each_entry(pcm, &snd_pcm_devices, list) {
+		if (pcm->card == newpcm->card && pcm->device == newpcm->device)
+			return -EBUSY;
+		if (pcm->card->number > newpcm->card->number ||
+				(pcm->card == newpcm->card &&
+				pcm->device > newpcm->device)) {
+			list_add(&newpcm->list, pcm->list.prev);
+			return 0;
+		}
+	}
+	list_add_tail(&newpcm->list, &snd_pcm_devices);
+	return 0;
+}
+
 static int snd_pcm_control_ioctl(struct snd_card *card,
 				 struct snd_ctl_file *control,
 				 unsigned int cmd, unsigned long arg)
@@ -65,14 +96,7 @@ static int snd_pcm_control_ioctl(struct snd_card *card,
 			if (get_user(device, (int __user *)arg))
 				return -EFAULT;
 			mutex_lock(&register_mutex);
-			device = device < 0 ? 0 : device + 1;
-			while (device < SNDRV_PCM_DEVICES) {
-				if (snd_pcm_search(card, device))
-					break;
-				device++;
-			}
-			if (device == SNDRV_PCM_DEVICES)
-				device = -1;
+			device = snd_pcm_next(card, device);
 			mutex_unlock(&register_mutex);
 			if (put_user(device, (int __user *)arg))
 				return -EFAULT;
@@ -98,7 +122,7 @@ static int snd_pcm_control_ioctl(struct snd_card *card,
 			if (get_user(subdevice, &info->subdevice))
 				return -EFAULT;
 			mutex_lock(&register_mutex);
-			pcm = snd_pcm_search(card, device);
+			pcm = snd_pcm_get(card, device);
 			if (pcm == NULL) {
 				err = -ENXIO;
 				goto _error;
@@ -931,11 +955,11 @@ static int snd_pcm_dev_register(struct snd_device *device)
 
 	snd_assert(pcm != NULL && device != NULL, return -ENXIO);
 	mutex_lock(&register_mutex);
-	if (snd_pcm_search(pcm->card, pcm->device)) {
+	err = snd_pcm_add(pcm);
+	if (err) {
 		mutex_unlock(&register_mutex);
-		return -EBUSY;
+		return err;
 	}
-	list_add_tail(&pcm->list, &snd_pcm_devices);
 	for (cidx = 0; cidx < 2; cidx++) {
 		int devtype = -1;
 		if (pcm->streams[cidx].substream == NULL)
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 1003ae3..838dd9e 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -34,8 +34,6 @@
 #include <linux/kmod.h>
 #include <linux/mutex.h>
 
-#define SNDRV_OS_MINORS 256
-
 static int major = CONFIG_SND_MAJOR;
 int snd_major;
 EXPORT_SYMBOL(snd_major);
