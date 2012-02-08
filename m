From: Liam Girdwood <lrg@ti.com>
Subject: [RFC/PATCH] ALSA: PCM - Add PCM creation API for ASoC
	dynamic PCMs.
Date: Wed,  8 Feb 2012 11:55:37 +0000
Message-ID: <1328702137-9552-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
	[74.125.149.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C82C103E2F
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 12:55:58 +0100 (CET)
Received: by mail-wi0-f178.google.com with SMTP id hm14so337348wib.9
	for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2012 03:55:45 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The new ASoC dynamic PCM core needs to create PCMs and substreams that are
for use by internal ASoC drivers only and not visible to userspace for
direct IO. These new PCMs are similar to regular PCMs expect they have no
device nodes or procfs entries. The ASoC component drivers use them in exactly
the same way as regular PCMs for PCM and DAI operations.

The intention is that a dynamic PCM based driver will register both regular
PCMs and dynamic PCMs. The regular PCMs will be used for all IO with userspace
however the dynamic PCMs will be used by the driver to route digital audio
through numerous back end DAI links (with potentially a DSP providing different
hw_params, DAI formats based on the regular front end PCM params) to devices
like CODECs, MODEMs, Bluetooth, FM, DMICs, etc

This patch adds a new snd_pcm_new_dynamic() API call to create the dynamic PCM
without device nodes or procfs. It also adds snd_pcm_new_stream_dynamic() and
snd_pcm_dev_register_dynamic() which are used to create the dynamic PCM.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/pcm.h |    3 +
 sound/core/pcm.c    |  145 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 0 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 0cf91b2..1597f89 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -475,6 +475,9 @@ extern const struct file_operations snd_pcm_f_ops[2];
 int snd_pcm_new(struct snd_card *card, const char *id, int device,
 		int playback_count, int capture_count,
 		struct snd_pcm **rpcm);
+int snd_pcm_new_dynamic(struct snd_card *card, const char *id, int device,
+		int playback_count, int capture_count,
+		struct snd_pcm ** rpcm);
 int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count);
 
 int snd_pcm_notify(struct snd_pcm_notify *notify, int nfree);
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 8928ca87..8e2a429 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -41,6 +41,7 @@ static DEFINE_MUTEX(register_mutex);
 static int snd_pcm_free(struct snd_pcm *pcm);
 static int snd_pcm_dev_free(struct snd_device *device);
 static int snd_pcm_dev_register(struct snd_device *device);
+static int snd_pcm_dev_register_dynamic(struct snd_device *device);
 static int snd_pcm_dev_disconnect(struct snd_device *device);
 
 static struct snd_pcm *snd_pcm_get(struct snd_card *card, int device)
@@ -697,6 +698,60 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 EXPORT_SYMBOL(snd_pcm_new_stream);
 
 /**
+ * snd_pcm_new_stream_dynamic - create a new dynamic PCM stream
+ * @pcm: the pcm instance
+ * @stream: the stream direction, SNDRV_PCM_STREAM_XXX
+ * @substream_count: the number of substreams
+ *
+ * Creates a new dynamic stream for the pcm. Dynamic PCM streams have no procfs
+ * entries or device entries and are hence not directly controllable by
+ * userspace.
+ * The corresponding stream on the pcm must have been empty before
+ * calling this, i.e. zero must be given to the argument of
+ * snd_pcm_new().
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ */
+static int snd_pcm_new_stream_dynamic(struct snd_pcm *pcm, int stream,
+	int substream_count)
+{
+	int idx;
+	struct snd_pcm_str *pstr = &pcm->streams[stream];
+	struct snd_pcm_substream *substream, *prev;
+
+	pstr->stream = stream;
+	pstr->pcm = pcm;
+	pstr->substream_count = substream_count;
+
+	prev = NULL;
+	for (idx = 0, prev = NULL; idx < substream_count; idx++) {
+		substream = kzalloc(sizeof(*substream), GFP_KERNEL);
+		if (substream == NULL) {
+			snd_printk(KERN_ERR "Cannot allocate BE PCM substream\n");
+			return -ENOMEM;
+		}
+		substream->pcm = pcm;
+		substream->pstr = pstr;
+		substream->number = idx;
+		substream->stream = stream;
+		sprintf(substream->name, "subdevice #%i", idx);
+		substream->buffer_bytes_max = UINT_MAX;
+		if (prev == NULL)
+			pstr->substream = substream;
+		else
+			prev->next = substream;
+
+		substream->group = &substream->self_group;
+		spin_lock_init(&substream->self_group.lock);
+		INIT_LIST_HEAD(&substream->self_group.substreams);
+		list_add_tail(&substream->link_list, &substream->self_group.substreams);
+		atomic_set(&substream->mmap_count, 0);
+		prev = substream;
+	}
+	return 0;
+}
+
+/**
  * snd_pcm_new - create a new PCM instance
  * @card: the card instance
  * @id: the id string
@@ -735,6 +790,7 @@ int snd_pcm_new(struct snd_card *card, const char *id, int device,
 	}
 	pcm->card = card;
 	pcm->device = device;
+
 	if (id)
 		strlcpy(pcm->id, id, sizeof(pcm->id));
 	if ((err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_PLAYBACK, playback_count)) < 0) {
@@ -758,6 +814,72 @@ int snd_pcm_new(struct snd_card *card, const char *id, int device,
 
 EXPORT_SYMBOL(snd_pcm_new);
 
+/**
+ * snd_pcm_new_dynamic - create a new dynamic PCM instance for ASoC BE DAI link
+ * @card: the card instance
+ * @id: the id string
+ * @device: the device index (zero based - shared with normal PCMs)
+ * @playback_count: the number of substreams for playback
+ * @capture_count: the number of substreams for capture
+ * @rpcm: the pointer to store the new pcm instance
+ *
+ * Creates a new dynamic PCM instance with no userspace device or procfs
+ * entries. This is used by ASoC Back End PCMs in order to create a PCM that
+ * will only be used internally by kernel drivers. i.e. it cannot be opened
+ * by userspace. It provides existing ASoC components drivers with a substream
+ * and access to any private data.
+ *
+ * The pcm operators have to be set afterwards to the new instance
+ * via snd_pcm_set_ops().
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ */
+int snd_pcm_new_dynamic(struct snd_card *card, const char *id, int device,
+	int playback_count, int capture_count,
+	struct snd_pcm ** rpcm)
+{
+	struct snd_pcm *pcm;
+	int err;
+	static struct snd_device_ops ops = {
+		.dev_free = snd_pcm_dev_free,
+		.dev_register =	snd_pcm_dev_register_dynamic,
+		.dev_disconnect = snd_pcm_dev_disconnect,
+	};
+
+	if (snd_BUG_ON(!card))
+		return -ENXIO;
+	if (rpcm)
+		*rpcm = NULL;
+	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
+	if (pcm == NULL) {
+		snd_printk(KERN_ERR "Cannot allocate dynamic PCM\n");
+		return -ENOMEM;
+	}
+	pcm->card = card;
+	pcm->device = device;
+
+	if (id)
+		strlcpy(pcm->id, id, sizeof(pcm->id));
+	if ((err = snd_pcm_new_stream_dynamic(pcm, SNDRV_PCM_STREAM_PLAYBACK, playback_count)) < 0) {
+		snd_pcm_free(pcm);
+		return err;
+	}
+	if ((err = snd_pcm_new_stream_dynamic(pcm, SNDRV_PCM_STREAM_CAPTURE, capture_count)) < 0) {
+		snd_pcm_free(pcm);
+		return err;
+	}
+
+	if ((err = snd_device_new(card, SNDRV_DEV_PCM, pcm, &ops)) < 0) {
+		snd_pcm_free(pcm);
+		return err;
+	}
+	if (rpcm)
+		*rpcm = pcm;
+	return 0;
+}
+
+EXPORT_SYMBOL(snd_pcm_new_dynamic);
+
 static void snd_pcm_free_stream(struct snd_pcm_str * pstr)
 {
 	struct snd_pcm_substream *substream, *substream_next;
@@ -1035,6 +1157,29 @@ static int snd_pcm_dev_register(struct snd_device *device)
 	return 0;
 }
 
+static int snd_pcm_dev_register_dynamic(struct snd_device *device)
+{
+	int err;
+	struct snd_pcm_notify *notify;
+	struct snd_pcm *pcm;
+
+	if (snd_BUG_ON(!device || !device->device_data))
+		return -ENXIO;
+	pcm = device->device_data;
+	mutex_lock(&register_mutex);
+	err = snd_pcm_add(pcm);
+	if (err) {
+		mutex_unlock(&register_mutex);
+		return err;
+	}
+
+	list_for_each_entry(notify, &snd_pcm_notify_list, list)
+		notify->n_register(pcm);
+
+	mutex_unlock(&register_mutex);
+	return 0;
+}
+
 static int snd_pcm_dev_disconnect(struct snd_device *device)
 {
 	struct snd_pcm *pcm = device->device_data;
-- 
1.7.5.4
