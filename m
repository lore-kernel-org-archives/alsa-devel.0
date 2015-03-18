From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/7] ALSA: hda - Fix possible runtime PM
	refcount unbalance
Date: Wed, 18 Mar 2015 16:16:36 +0100
Message-ID: <1426691797-17178-7-git-send-email-tiwai@suse.de>
References: <1426691797-17178-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 18F0A265142
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 16:16:42 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B9B37AD6A
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 15:16:40 +0000 (UTC)
In-Reply-To: <1426691797-17178-1-git-send-email-tiwai@suse.de>
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

When the driver is unloaded before the codec is bound, it still keeps
the runtime PM refcount up, and results in the unbalance.  This patch
covers these cases by introducing a flag indicating the runtime PM
initialization and handling the codec registration procedure more
properly.  It also fixes the missing input beep device as a gratis,
too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_device.c   |  3 +--
 sound/pci/hda/hda_bind.c  |  1 +
 sound/pci/hda/hda_codec.c | 30 ++++++++++++++++++++++--------
 sound/pci/hda/hda_codec.h |  1 +
 sound/pci/hda/hda_local.h |  1 +
 5 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index aaece36247e7..6e8ee1d6974a 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -109,7 +109,6 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
 	return 0;
 
  error:
-	pm_runtime_put_noidle(&codec->dev);
 	put_device(&codec->dev);
 	return err;
 }
@@ -121,7 +120,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_init);
  */
 void snd_hdac_device_exit(struct hdac_device *codec)
 {
-	/* pm_runtime_put_noidle(&codec->dev); */
+	pm_runtime_put_noidle(&codec->dev);
 	snd_hdac_bus_remove_device(codec->bus, codec);
 	kfree(codec->vendor_name);
 	kfree(codec->chip_name);
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 130f672e6f37..7b269c3237e3 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -95,6 +95,7 @@ static int hda_codec_driver_probe(struct device *dev)
 		err = snd_card_register(codec->card);
 		if (err < 0)
 			goto error_module;
+		snd_hda_codec_register(codec);
 	}
 
 	return 0;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 36483f7dd3ce..145cae7903b6 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -912,6 +912,13 @@ static void codec_release_pcms(struct hda_codec *codec)
 
 void snd_hda_codec_cleanup_for_unbind(struct hda_codec *codec)
 {
+	if (codec->registered) {
+		/* pm_runtime_put() is called in snd_hdac_device_exit() */
+		pm_runtime_get_noresume(hda_codec_dev(codec));
+		pm_runtime_disable(hda_codec_dev(codec));
+		codec->registered = 0;
+	}
+
 	cancel_delayed_work_sync(&codec->jackpoll_work);
 	if (!codec->in_freeing)
 		snd_hda_ctls_clear(codec);
@@ -943,15 +950,23 @@ void snd_hda_codec_cleanup_for_unbind(struct hda_codec *codec)
 static unsigned int hda_set_power_state(struct hda_codec *codec,
 				unsigned int power_state);
 
-static int snd_hda_codec_dev_register(struct snd_device *device)
+/* also called from hda_bind.c */
+void snd_hda_codec_register(struct hda_codec *codec)
 {
-	struct hda_codec *codec = device->device_data;
-
-	snd_hda_register_beep_device(codec);
-	if (device_is_registered(hda_codec_dev(codec)))
+	if (codec->registered)
+		return;
+	if (device_is_registered(hda_codec_dev(codec))) {
+		snd_hda_register_beep_device(codec);
 		pm_runtime_enable(hda_codec_dev(codec));
-	/* it was powered up in snd_hda_codec_new(), now all done */
-	snd_hda_power_down(codec);
+		/* it was powered up in snd_hda_codec_new(), now all done */
+		snd_hda_power_down(codec);
+		codec->registered = 1;
+	}
+}
+
+static int snd_hda_codec_dev_register(struct snd_device *device)
+{
+	snd_hda_codec_register(device->device_data);
 	return 0;
 }
 
@@ -1094,7 +1109,6 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	return 0;
 
  error:
-	pm_runtime_put_noidle(hda_codec_dev(codec));
 	put_device(hda_codec_dev(codec));
 	return err;
 }
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 6266fa8dafc2..06f8c8a8f3ff 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -314,6 +314,7 @@ struct hda_codec {
 
 	/* misc flags */
 	unsigned int in_freeing:1; /* being released */
+	unsigned int registered:1; /* codec was registered */
 	unsigned int spdif_status_reset :1; /* needs to toggle SPDIF for each
 					     * status change
 					     * (e.g. Realtek codecs)
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index e0db30c66e5f..8a83775e0e27 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -150,6 +150,7 @@ int __snd_hda_add_vmaster(struct hda_codec *codec, char *name,
 #define snd_hda_add_vmaster(codec, name, tlv, slaves, suffix) \
 	__snd_hda_add_vmaster(codec, name, tlv, slaves, suffix, true, NULL)
 int snd_hda_codec_reset(struct hda_codec *codec);
+void snd_hda_codec_register(struct hda_codec *codec);
 void snd_hda_codec_cleanup_for_unbind(struct hda_codec *codec);
 
 enum {
-- 
2.3.3
