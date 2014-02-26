From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/10] ALSA: hda - Create own device struct for
	each codec
Date: Wed, 26 Feb 2014 07:47:29 +0100
Message-ID: <1393397252-11690-8-git-send-email-tiwai@suse.de>
References: <1393397252-11690-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DD2A26567B
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 07:47:38 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EF2DB75026
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 06:47:37 +0000 (UTC)
In-Reply-To: <1393397252-11690-1-git-send-email-tiwai@suse.de>
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

As the HD-audio is treated individually in each codec driver, it's
more convenient to assign an own struct device to each codec object.
Then we'll be able to use dev_err() more easily for each codec, for
example.

For achieving it, this patch just creates an object "hdaudioCxDy".
It belongs to sound class instead of creating a new bus, just for
simplicity, at this stage.  No pm ops is implemented in the device
struct level but currently it's merely a container.  The PCM and hwdep
devices are now children of this codec device.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 36 +++++++++++++++++++++++++++++++++---
 sound/pci/hda/hda_codec.h |  1 +
 sound/pci/hda/hda_hwdep.c |  3 +++
 sound/pci/hda/hda_intel.c |  2 ++
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 5ea1156954ab..98baf5674a63 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1368,7 +1368,7 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	kfree(codec->modelname);
 	kfree(codec->wcaps);
 	codec->bus->num_codecs--;
-	kfree(codec);
+	put_device(&codec->dev);
 }
 
 static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec,
@@ -1377,12 +1377,33 @@ static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec,
 static unsigned int hda_set_power_state(struct hda_codec *codec,
 				unsigned int power_state);
 
+static int snd_hda_codec_dev_register(struct snd_device *device)
+{
+	struct hda_codec *codec = device->device_data;
+
+	return device_add(&codec->dev);
+}
+
+static int snd_hda_codec_dev_disconnect(struct snd_device *device)
+{
+	struct hda_codec *codec = device->device_data;
+
+	device_del(&codec->dev);
+	return 0;
+}
+
 static int snd_hda_codec_dev_free(struct snd_device *device)
 {
 	snd_hda_codec_free(device->device_data);
 	return 0;
 }
 
+/* just free the container */
+static void snd_hda_codec_dev_release(struct device *dev)
+{
+	kfree(container_of(dev, struct hda_codec, dev));
+}
+
 /**
  * snd_hda_codec_new - create a HDA codec
  * @bus: the bus to assign
@@ -1400,6 +1421,8 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	hda_nid_t fg;
 	int err;
 	static struct snd_device_ops dev_ops = {
+		.dev_register = snd_hda_codec_dev_register,
+		.dev_disconnect = snd_hda_codec_dev_disconnect,
 		.dev_free = snd_hda_codec_dev_free,
 	};
 
@@ -1420,6 +1443,13 @@ int snd_hda_codec_new(struct hda_bus *bus,
 		return -ENOMEM;
 	}
 
+	device_initialize(&codec->dev);
+	codec->dev.parent = &bus->card->card_dev;
+	codec->dev.class = sound_class;
+	codec->dev.release = snd_hda_codec_dev_release;
+	dev_set_name(&codec->dev, "hdaudioC%dD%d", bus->card->number,
+		     codec_addr);
+
 	codec->bus = bus;
 	codec->addr = codec_addr;
 	mutex_init(&codec->spdif_mutex);
@@ -1453,8 +1483,8 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	if (codec->bus->modelname) {
 		codec->modelname = kstrdup(codec->bus->modelname, GFP_KERNEL);
 		if (!codec->modelname) {
-			snd_hda_codec_free(codec);
-			return -ENODEV;
+			err = -ENODEV;
+			goto error;
 		}
 	}
 
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index ab2a444ba501..4d9dd2b70f4a 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -271,6 +271,7 @@ struct hda_pcm {
 
 /* codec information */
 struct hda_codec {
+	struct device dev;
 	struct hda_bus *bus;
 	unsigned int addr;	/* codec addr*/
 	struct list_head list;	/* list point */
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 0fada0f8cfe8..896d116ca951 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -155,6 +155,9 @@ int snd_hda_create_hwdep(struct hda_codec *codec)
 	snd_array_init(&codec->hints, sizeof(struct hda_hint), 32);
 	snd_array_init(&codec->user_pins, sizeof(struct hda_pincfg), 16);
 
+	/* link to codec */
+	hwdep->dev = &codec->dev;
+
 	return 0;
 }
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0870f5f3ed1c..459f54da8d6b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2663,6 +2663,8 @@ azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
 					      snd_dma_pci_data(chip->pci),
 					      size, MAX_PREALLOC_SIZE);
+	/* link to codec */
+	pcm->dev = &codec->dev;
 	return 0;
 }
 
-- 
1.9.0
