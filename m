From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH v2] ALSA: PCM - Add PCM creation API for
	internal PCMs.
Date: Wed,  8 Feb 2012 20:33:31 +0000
Message-ID: <1328733211-3234-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with SMTP id 65001103FB7
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 21:35:27 +0100 (CET)
Received: by mail-wi0-f179.google.com with SMTP id hj6so737595wib.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2012 12:35:24 -0800 (PST)
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
PCMs and internal PCMs. The regular PCMs will be used for all IO with userspace
however the internal PCMs will be used by the driver to route digital audio
through numerous back end DAI links (with potentially a DSP providing different
hw_params, DAI formats based on the regular front end PCM params) to devices
like CODECs, MODEMs, Bluetooth, FM, DMICs, etc

This patch adds a new snd_pcm_new_internal() API call to create the internal PCM
without device nodes or procfs. It also adds adds a new internal flag to snd_pcm.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
Changes since V1
 - Renamed to Internal PCM instead of Dynamic PCM wrt ALSA.
 - Removed similar PCM creation code and use flag for procfs/device creation.

 include/sound/pcm.h |    4 ++
 sound/core/pcm.c    |  100 +++++++++++++++++++++++++++++++++++---------------
 2 files changed, 74 insertions(+), 30 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 0cf91b2..b33993f 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -454,6 +454,7 @@ struct snd_pcm {
 	void *private_data;
 	void (*private_free) (struct snd_pcm *pcm);
 	struct device *dev; /* actual hw device this belongs to */
+	bool internal; /* pcm is for internal use only */
 #if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
 	struct snd_pcm_oss oss;
 #endif
@@ -475,6 +476,9 @@ extern const struct file_operations snd_pcm_f_ops[2];
 int snd_pcm_new(struct snd_card *card, const char *id, int device,
 		int playback_count, int capture_count,
 		struct snd_pcm **rpcm);
+int snd_pcm_new_internal(struct snd_card *card, const char *id, int device,
+		int playback_count, int capture_count,
+		struct snd_pcm ** rpcm);
 int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count);
 
 int snd_pcm_notify(struct snd_pcm_notify *notify, int nfree);
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 8928ca87..138122e 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -650,7 +650,7 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 	pstr->stream = stream;
 	pstr->pcm = pcm;
 	pstr->substream_count = substream_count;
-	if (substream_count > 0) {
+	if (substream_count > 0 && !pcm->internal) {
 		err = snd_pcm_stream_proc_init(pstr);
 		if (err < 0) {
 			snd_printk(KERN_ERR "Error in snd_pcm_stream_proc_init\n");
@@ -674,15 +674,18 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 			pstr->substream = substream;
 		else
 			prev->next = substream;
-		err = snd_pcm_substream_proc_init(substream);
-		if (err < 0) {
-			snd_printk(KERN_ERR "Error in snd_pcm_stream_proc_init\n");
-			if (prev == NULL)
-				pstr->substream = NULL;
-			else
-				prev->next = NULL;
-			kfree(substream);
-			return err;
+
+		if (!pcm->internal) {
+			err = snd_pcm_substream_proc_init(substream);
+			if (err < 0) {
+				snd_printk(KERN_ERR "Error in snd_pcm_stream_proc_init\n");
+				if (prev == NULL)
+					pstr->substream = NULL;
+				else
+					prev->next = NULL;
+				kfree(substream);
+				return err;
+			}
 		}
 		substream->group = &substream->self_group;
 		spin_lock_init(&substream->self_group.lock);
@@ -696,25 +699,9 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 
 EXPORT_SYMBOL(snd_pcm_new_stream);
 
-/**
- * snd_pcm_new - create a new PCM instance
- * @card: the card instance
- * @id: the id string
- * @device: the device index (zero based)
- * @playback_count: the number of substreams for playback
- * @capture_count: the number of substreams for capture
- * @rpcm: the pointer to store the new pcm instance
- *
- * Creates a new PCM instance.
- *
- * The pcm operators have to be set afterwards to the new instance
- * via snd_pcm_set_ops().
- *
- * Returns zero if successful, or a negative error code on failure.
- */
-int snd_pcm_new(struct snd_card *card, const char *id, int device,
-		int playback_count, int capture_count,
-	        struct snd_pcm ** rpcm)
+static int _snd_pcm_new(struct snd_card *card, const char *id, int device,
+		int playback_count, int capture_count, bool internal,
+		struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -735,6 +722,7 @@ int snd_pcm_new(struct snd_card *card, const char *id, int device,
 	}
 	pcm->card = card;
 	pcm->device = device;
+	pcm->internal = internal;
 	if (id)
 		strlcpy(pcm->id, id, sizeof(pcm->id));
 	if ((err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_PLAYBACK, playback_count)) < 0) {
@@ -756,8 +744,60 @@ int snd_pcm_new(struct snd_card *card, const char *id, int device,
 	return 0;
 }
 
+/**
+ * snd_pcm_new - create a new PCM instance
+ * @card: the card instance
+ * @id: the id string
+ * @device: the device index (zero based)
+ * @playback_count: the number of substreams for playback
+ * @capture_count: the number of substreams for capture
+ * @rpcm: the pointer to store the new pcm instance
+ *
+ * Creates a new PCM instance.
+ *
+ * The pcm operators have to be set afterwards to the new instance
+ * via snd_pcm_set_ops().
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ */
+int snd_pcm_new(struct snd_card *card, const char *id, int device,
+		int playback_count, int capture_count, struct snd_pcm ** rpcm)
+{
+	return _snd_pcm_new(card, id, device, playback_count, capture_count,
+			false, rpcm);
+}
 EXPORT_SYMBOL(snd_pcm_new);
 
+/**
+ * snd_pcm_new_internal - create a new internal PCM instance
+ * @card: the card instance
+ * @id: the id string
+ * @device: the device index (zero based - shared with normal PCMs)
+ * @playback_count: the number of substreams for playback
+ * @capture_count: the number of substreams for capture
+ * @rpcm: the pointer to store the new pcm instance
+ *
+ * Creates a new internal PCM instance with no userspace device or procfs
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
+int snd_pcm_new_internal(struct snd_card *card, const char *id, int device,
+	int playback_count, int capture_count,
+	struct snd_pcm ** rpcm)
+{
+	return _snd_pcm_new(card, id, device, playback_count, capture_count,
+			true, rpcm);
+}
+
+EXPORT_SYMBOL(snd_pcm_new_internal);
+
 static void snd_pcm_free_stream(struct snd_pcm_str * pstr)
 {
 	struct snd_pcm_substream *substream, *substream_next;
@@ -994,7 +1034,7 @@ static int snd_pcm_dev_register(struct snd_device *device)
 	}
 	for (cidx = 0; cidx < 2; cidx++) {
 		int devtype = -1;
-		if (pcm->streams[cidx].substream == NULL)
+		if (pcm->streams[cidx].substream == NULL || pcm->internal)
 			continue;
 		switch (cidx) {
 		case SNDRV_PCM_STREAM_PLAYBACK:
-- 
1.7.5.4
