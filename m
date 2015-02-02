From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/14] ALSA: pcm: Embed struct device
Date: Mon,  2 Feb 2015 11:24:30 +0100
Message-ID: <1422872678-4815-7-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CC9E2604F2
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C3E82AB0E
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

Like previous patches, at this time we embed the struct device into
PCM object.  However, this needs a bit more caution: struct snd_pcm
doesn't own one device but two, for both playback and capture!  Thus
not struct snd_pcm but struct snd_pcm_str object contains the device.

Along with this change, pcm->dev field is dropped for avoiding
confusion.  It was meant to point to a non-standard parent.  But,
since now we can touch each struct device directly, we can manipulate
the parent field easily there, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h                     |  2 +-
 sound/aoa/soundbus/i2sbus/pcm.c         |  5 ++++-
 sound/core/pcm.c                        | 38 +++++++++++++--------------------
 sound/pci/hda/hda_controller.c          |  3 ++-
 sound/soc/intel/sst-mfld-platform-pcm.c |  1 -
 5 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index b429b73e875e..735bd0cc7347 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -449,6 +449,7 @@ struct snd_pcm_str {
 #endif
 #endif
 	struct snd_kcontrol *chmap_kctl; /* channel-mapping controls */
+	struct device dev;
 };
 
 struct snd_pcm {
@@ -465,7 +466,6 @@ struct snd_pcm {
 	wait_queue_head_t open_wait;
 	void *private_data;
 	void (*private_free) (struct snd_pcm *pcm);
-	struct device *dev; /* actual hw device this belongs to */
 	bool internal; /* pcm is for internal use only */
 	bool nonatomic; /* whole PCM operations are in non-atomic context */
 #if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index 7b74a4ba75f8..a02b7b8d3532 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -968,7 +968,6 @@ i2sbus_attach_codec(struct soundbus_dev *dev, struct snd_card *card,
 			printk(KERN_DEBUG "i2sbus: failed to create pcm\n");
 			goto out_put_ci_module;
 		}
-		dev->pcm->dev = &dev->ofdev.dev;
 	}
 
 	/* ALSA yet again sucks.
@@ -988,6 +987,8 @@ i2sbus_attach_codec(struct soundbus_dev *dev, struct snd_card *card,
 			goto out_put_ci_module;
 		snd_pcm_set_ops(dev->pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				&i2sbus_playback_ops);
+		dev->pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].dev.parent =
+			&dev->ofdev.dev;
 		i2sdev->out.created = 1;
 	}
 
@@ -1003,6 +1004,8 @@ i2sbus_attach_codec(struct soundbus_dev *dev, struct snd_card *card,
 			goto out_put_ci_module;
 		snd_pcm_set_ops(dev->pcm, SNDRV_PCM_STREAM_CAPTURE,
 				&i2sbus_record_ops);
+		dev->pcm->streams[SNDRV_PCM_STREAM_CAPTURE].dev.parent =
+			&dev->ofdev.dev;
 		i2sdev->in.created = 1;
 	}
 
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 1b7c473720fa..4d5120f7a8ab 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -673,6 +673,8 @@ static inline int snd_pcm_substream_proc_init(struct snd_pcm_substream *substrea
 static inline int snd_pcm_substream_proc_done(struct snd_pcm_substream *substream) { return 0; }
 #endif /* CONFIG_SND_VERBOSE_PROCFS */
 
+static const struct attribute_group *pcm_dev_attr_groups[];
+
 /**
  * snd_pcm_new_stream - create a new PCM stream
  * @pcm: the pcm instance
@@ -698,7 +700,15 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 	pstr->stream = stream;
 	pstr->pcm = pcm;
 	pstr->substream_count = substream_count;
-	if (substream_count > 0 && !pcm->internal) {
+	if (!substream_count)
+		return 0;
+
+	snd_device_initialize(&pstr->dev, pcm->card);
+	pstr->dev.groups = pcm_dev_attr_groups;
+	dev_set_name(&pstr->dev, "pcmC%iD%i%c", pcm->card->number, pcm->device,
+		     stream == SNDRV_PCM_STREAM_PLAYBACK ? 'p' : 'c');
+
+	if (!pcm->internal) {
 		err = snd_pcm_stream_proc_init(pstr);
 		if (err < 0) {
 			pcm_err(pcm, "Error in snd_pcm_stream_proc_init\n");
@@ -868,6 +878,8 @@ static void snd_pcm_free_stream(struct snd_pcm_str * pstr)
 		kfree(setup);
 	}
 #endif
+	if (pstr->substream_count)
+		put_device(&pstr->dev);
 }
 
 static int snd_pcm_free(struct snd_pcm *pcm)
@@ -1069,9 +1081,7 @@ static int snd_pcm_dev_register(struct snd_device *device)
 	int cidx, err;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_notify *notify;
-	char str[16];
 	struct snd_pcm *pcm;
-	struct device *dev;
 
 	if (snd_BUG_ON(!device || !device->device_data))
 		return -ENXIO;
@@ -1088,42 +1098,24 @@ static int snd_pcm_dev_register(struct snd_device *device)
 			continue;
 		switch (cidx) {
 		case SNDRV_PCM_STREAM_PLAYBACK:
-			sprintf(str, "pcmC%iD%ip", pcm->card->number, pcm->device);
 			devtype = SNDRV_DEVICE_TYPE_PCM_PLAYBACK;
 			break;
 		case SNDRV_PCM_STREAM_CAPTURE:
-			sprintf(str, "pcmC%iD%ic", pcm->card->number, pcm->device);
 			devtype = SNDRV_DEVICE_TYPE_PCM_CAPTURE;
 			break;
 		}
-		/* device pointer to use, pcm->dev takes precedence if
-		 * it is assigned, otherwise fall back to card's device
-		 * if possible */
-		dev = pcm->dev;
-		if (!dev)
-			dev = snd_card_get_device_link(pcm->card);
 		/* register pcm */
 		err = snd_register_device_for_dev(devtype, pcm->card,
 						  pcm->device,
 						  &snd_pcm_f_ops[cidx],
-						  pcm, NULL, dev, str);
+						  pcm, &pcm->streams[cidx].dev,
+						  NULL, NULL);
 		if (err < 0) {
 			list_del(&pcm->list);
 			mutex_unlock(&register_mutex);
 			return err;
 		}
 
-		dev = snd_get_device(devtype, pcm->card, pcm->device);
-		if (dev) {
-			err = sysfs_create_groups(&dev->kobj,
-						  pcm_dev_attr_groups);
-			if (err < 0)
-				dev_warn(dev,
-					 "pcm %d:%d: cannot create sysfs groups\n",
-					 pcm->card->number, pcm->device);
-			put_device(dev);
-		}
-
 		for (substream = pcm->streams[cidx].substream; substream; substream = substream->next)
 			snd_pcm_timer_init(substream);
 	}
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 0cfc9c8c4b4e..712ec5ceba46 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -939,7 +939,8 @@ static int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
 					      chip->card->dev,
 					      size, MAX_PREALLOC_SIZE);
 	/* link to codec */
-	pcm->dev = &codec->dev;
+	for (s = 0; s < 2; s++)
+		pcm->streams[s].dev.parent = &codec->dev;
 	return 0;
 }
 
diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index a1a8d9d91539..2d80c4e12997 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -645,7 +645,6 @@ static struct snd_pcm_ops sst_platform_ops = {
 
 static void sst_pcm_free(struct snd_pcm *pcm)
 {
-	dev_dbg(pcm->dev, "sst_pcm_free called\n");
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
-- 
2.2.2
