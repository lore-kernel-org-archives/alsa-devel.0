From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/10] ALSA: hda - Manage each codec instance
	individually
Date: Wed, 26 Feb 2014 07:47:28 +0100
Message-ID: <1393397252-11690-7-git-send-email-tiwai@suse.de>
References: <1393397252-11690-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 601CB26559F
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 07:47:38 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EC70475025
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

Now each snd_hda_codec instance is managed via the device chain, the
registration and release are done by its callback instead of calling
from bus.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 51360d916e6b..5ea1156954ab 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -821,35 +821,35 @@ static int init_unsol_queue(struct hda_bus *bus)
 /*
  * destructor
  */
-static void snd_hda_codec_free(struct hda_codec *codec);
-
-static int snd_hda_bus_free(struct hda_bus *bus)
+static void snd_hda_bus_free(struct hda_bus *bus)
 {
-	struct hda_codec *codec, *n;
-
 	if (!bus)
-		return 0;
+		return;
+
+	WARN_ON(!list_empty(&bus->codec_list));
 	if (bus->workq)
 		flush_workqueue(bus->workq);
 	if (bus->unsol)
 		kfree(bus->unsol);
-	list_for_each_entry_safe(codec, n, &bus->codec_list, list) {
-		snd_hda_codec_free(codec);
-	}
 	if (bus->ops.private_free)
 		bus->ops.private_free(bus);
 	if (bus->workq)
 		destroy_workqueue(bus->workq);
 
 	kfree(bus);
-	return 0;
 }
 
 static int snd_hda_bus_dev_free(struct snd_device *device)
 {
+	snd_hda_bus_free(device->device_data);
+	return 0;
+}
+
+static int snd_hda_bus_dev_disconnect(struct snd_device *device)
+{
 	struct hda_bus *bus = device->device_data;
 	bus->shutdown = 1;
-	return snd_hda_bus_free(bus);
+	return 0;
 }
 
 /**
@@ -867,6 +867,7 @@ int snd_hda_bus_new(struct snd_card *card,
 	struct hda_bus *bus;
 	int err;
 	static struct snd_device_ops dev_ops = {
+		.dev_disconnect = snd_hda_bus_dev_disconnect,
 		.dev_free = snd_hda_bus_dev_free,
 	};
 
@@ -1376,6 +1377,12 @@ static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec,
 static unsigned int hda_set_power_state(struct hda_codec *codec,
 				unsigned int power_state);
 
+static int snd_hda_codec_dev_free(struct snd_device *device)
+{
+	snd_hda_codec_free(device->device_data);
+	return 0;
+}
+
 /**
  * snd_hda_codec_new - create a HDA codec
  * @bus: the bus to assign
@@ -1392,6 +1399,9 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	char component[31];
 	hda_nid_t fg;
 	int err;
+	static struct snd_device_ops dev_ops = {
+		.dev_free = snd_hda_codec_dev_free,
+	};
 
 	if (snd_BUG_ON(!bus))
 		return -EINVAL;
@@ -1512,6 +1522,10 @@ int snd_hda_codec_new(struct hda_bus *bus,
 		codec->subsystem_id, codec->revision_id);
 	snd_component_add(codec->bus->card, component);
 
+	err = snd_device_new(bus->card, SNDRV_DEV_CODEC, codec, &dev_ops);
+	if (err < 0)
+		goto error;
+
 	if (codecp)
 		*codecp = codec;
 	return 0;
-- 
1.9.0
