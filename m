From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: pcm: Don't add internal PCMs to PCM
	device list
Date: Fri, 20 Feb 2015 17:23:26 +0100
Message-ID: <1424449408-22376-3-git-send-email-tiwai@suse.de>
References: <1424449408-22376-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ECFE726058B
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 17:23:31 +0100 (CET)
In-Reply-To: <1424449408-22376-1-git-send-email-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

An internal PCM object shouldn't be added to the PCM device list, as
it's never accessed directly from the user-space, and it has no proc
or any similar accesses.  Currently, it's excluded in snd_pcm_get()
and snd_pcm_next(), but it's easier not to add such an object to the
list.

Actually, the whole snd_pcm_dev_register() can be skipped for an
internal PCM.  So this patch changes the code there, but also
addresses the uninitialized list_head access.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 89206e9c3578..92bbb5143b83 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -49,8 +49,6 @@ static struct snd_pcm *snd_pcm_get(struct snd_card *card, int device)
 	struct snd_pcm *pcm;
 
 	list_for_each_entry(pcm, &snd_pcm_devices, list) {
-		if (pcm->internal)
-			continue;
 		if (pcm->card == card && pcm->device == device)
 			return pcm;
 	}
@@ -62,8 +60,6 @@ static int snd_pcm_next(struct snd_card *card, int device)
 	struct snd_pcm *pcm;
 
 	list_for_each_entry(pcm, &snd_pcm_devices, list) {
-		if (pcm->internal)
-			continue;
 		if (pcm->card == card && pcm->device > device)
 			return pcm->device;
 		else if (pcm->card->number > card->number)
@@ -76,6 +72,9 @@ static int snd_pcm_add(struct snd_pcm *newpcm)
 {
 	struct snd_pcm *pcm;
 
+	if (newpcm->internal)
+		return 0;
+
 	list_for_each_entry(pcm, &snd_pcm_devices, list) {
 		if (pcm->card == newpcm->card && pcm->device == newpcm->device)
 			return -EBUSY;
@@ -782,6 +781,9 @@ static int _snd_pcm_new(struct snd_card *card, const char *id, int device,
 	pcm->card = card;
 	pcm->device = device;
 	pcm->internal = internal;
+	mutex_init(&pcm->open_mutex);
+	init_waitqueue_head(&pcm->open_wait);
+	INIT_LIST_HEAD(&pcm->list);
 	if (id)
 		strlcpy(pcm->id, id, sizeof(pcm->id));
 	if ((err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_PLAYBACK, playback_count)) < 0) {
@@ -792,8 +794,6 @@ static int _snd_pcm_new(struct snd_card *card, const char *id, int device,
 		snd_pcm_free(pcm);
 		return err;
 	}
-	mutex_init(&pcm->open_mutex);
-	init_waitqueue_head(&pcm->open_wait);
 	if ((err = snd_device_new(card, SNDRV_DEV_PCM, pcm, &ops)) < 0) {
 		snd_pcm_free(pcm);
 		return err;
@@ -1075,15 +1075,16 @@ static int snd_pcm_dev_register(struct snd_device *device)
 	if (snd_BUG_ON(!device || !device->device_data))
 		return -ENXIO;
 	pcm = device->device_data;
+	if (pcm->internal)
+		return 0;
+
 	mutex_lock(&register_mutex);
 	err = snd_pcm_add(pcm);
-	if (err) {
-		mutex_unlock(&register_mutex);
-		return err;
-	}
+	if (err)
+		goto unlock;
 	for (cidx = 0; cidx < 2; cidx++) {
 		int devtype = -1;
-		if (pcm->streams[cidx].substream == NULL || pcm->internal)
+		if (pcm->streams[cidx].substream == NULL)
 			continue;
 		switch (cidx) {
 		case SNDRV_PCM_STREAM_PLAYBACK:
@@ -1098,9 +1099,8 @@ static int snd_pcm_dev_register(struct snd_device *device)
 					  &snd_pcm_f_ops[cidx], pcm,
 					  &pcm->streams[cidx].dev);
 		if (err < 0) {
-			list_del(&pcm->list);
-			mutex_unlock(&register_mutex);
-			return err;
+			list_del_init(&pcm->list);
+			goto unlock;
 		}
 
 		for (substream = pcm->streams[cidx].substream; substream; substream = substream->next)
@@ -1110,8 +1110,9 @@ static int snd_pcm_dev_register(struct snd_device *device)
 	list_for_each_entry(notify, &snd_pcm_notify_list, list)
 		notify->n_register(pcm);
 
+ unlock:
 	mutex_unlock(&register_mutex);
-	return 0;
+	return err;
 }
 
 static int snd_pcm_dev_disconnect(struct snd_device *device)
-- 
2.3.0
