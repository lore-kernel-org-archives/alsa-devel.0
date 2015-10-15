From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - consolidate chip rename
	functions
Date: Thu, 15 Oct 2015 14:14:15 +0200
Message-ID: <1444911256-23738-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 96E5B260464
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 14:14:17 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 36311AAD1
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 12:14:16 +0000 (UTC)
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

A few multiple codec drivers do renaming the chip_name string but all
these are open-coded and some of them have even no error check.  Let's
make common helpers to do it properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h       |  1 +
 sound/hda/hdac_device.c       | 22 ++++++++++++++++++++++
 sound/pci/hda/hda_bind.c      | 35 +++++++++++++++++++++++------------
 sound/pci/hda/hda_codec.h     |  2 ++
 sound/pci/hda/hda_sysfs.c     |  3 +--
 sound/pci/hda/patch_realtek.c | 12 +-----------
 sound/pci/hda/patch_via.c     | 18 ++++--------------
 7 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 26e956f4b7c6..49df61c7afdc 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -117,6 +117,7 @@ int snd_hdac_device_init(struct hdac_device *dev, struct hdac_bus *bus,
 void snd_hdac_device_exit(struct hdac_device *dev);
 int snd_hdac_device_register(struct hdac_device *codec);
 void snd_hdac_device_unregister(struct hdac_device *codec);
+int snd_hdac_device_set_chip_name(struct hdac_device *codec, const char *name);
 
 int snd_hdac_refresh_widgets(struct hdac_device *codec);
 int snd_hdac_refresh_widget_sysfs(struct hdac_device *codec);
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index b3b0ad289df1..4b06b26cee06 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -164,6 +164,28 @@ void snd_hdac_device_unregister(struct hdac_device *codec)
 EXPORT_SYMBOL_GPL(snd_hdac_device_unregister);
 
 /**
+ * snd_hdac_device_set_chip_name - set/update the codec name
+ * @codec: the HDAC device
+ * @name: name string to set
+ *
+ * Returns 0 if the name is set or updated, or a negative error code.
+ */
+int snd_hdac_device_set_chip_name(struct hdac_device *codec, const char *name)
+{
+	char *newname;
+
+	if (!name)
+		return 0;
+	newname = kstrdup(name, GFP_KERNEL);
+	if (!newname)
+		return -ENOMEM;
+	kfree(codec->chip_name);
+	codec->chip_name = newname;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_device_set_chip_name);
+
+/**
  * snd_hdac_make_cmd - compose a 32bit command word to be sent to the
  *	HD-audio controller
  * @codec: the codec object
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index d5ac25cc7fee..ef6b8f836a87 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -45,15 +45,31 @@ static void hda_codec_unsol_event(struct hdac_device *dev, unsigned int ev)
 		codec->patch_ops.unsol_event(codec, ev);
 }
 
-/* reset the codec name from the preset */
-static int codec_refresh_name(struct hda_codec *codec, const char *name)
+/**
+ * snd_hda_codec_set_name - set the codec name
+ * @codec: the HDA codec
+ * @name: name string to set
+ */
+int snd_hda_codec_set_name(struct hda_codec *codec, const char *name)
 {
-	if (name) {
-		kfree(codec->core.chip_name);
-		codec->core.chip_name = kstrdup(name, GFP_KERNEL);
+	int err;
+
+	if (!name)
+		return 0;
+	err = snd_hdac_device_set_chip_name(&codec->core, name);
+	if (err < 0)
+		return err;
+
+	/* update the mixer name */
+	if (!*codec->card->mixername) {
+		snprintf(codec->card->mixername,
+			 sizeof(codec->card->mixername), "%s %s",
+			 codec->core.vendor_name, codec->core.chip_name);
 	}
-	return codec->core.chip_name ? 0 : -ENOMEM;
+
+	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_hda_codec_set_name);
 
 static int hda_codec_driver_probe(struct device *dev)
 {
@@ -64,7 +80,7 @@ static int hda_codec_driver_probe(struct device *dev)
 	if (WARN_ON(!codec->preset))
 		return -EINVAL;
 
-	err = codec_refresh_name(codec, codec->preset->name);
+	err = snd_hda_codec_set_name(codec, codec->preset->name);
 	if (err < 0)
 		goto error;
 	err = snd_hdac_regmap_init(&codec->core);
@@ -251,11 +267,6 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 		}
 	}
 
-	/* audio codec should override the mixer name */
-	if (codec->core.afg || !*codec->card->mixername)
-		snprintf(codec->card->mixername,
-			 sizeof(codec->card->mixername), "%s %s",
-			 codec->core.vendor_name, codec->core.chip_name);
 	return 0;
 
  error:
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 95991e463abb..b6d937784afa 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -463,6 +463,8 @@ void snd_hda_unlock_devices(struct hda_bus *bus);
 void snd_hda_bus_reset(struct hda_bus *bus);
 void snd_hda_bus_reset_codecs(struct hda_bus *bus);
 
+int snd_hda_codec_set_name(struct hda_codec *codec, const char *name);
+
 /*
  * power management
  */
diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index a6e3d9b511ab..64e0d1d81ca5 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -595,8 +595,7 @@ static void parse_model_mode(char *buf, struct hda_bus *bus,
 static void parse_chip_name_mode(char *buf, struct hda_bus *bus,
 				 struct hda_codec **codecp)
 {
-	kfree((*codecp)->core.chip_name);
-	(*codecp)->core.chip_name = kstrdup(buf, GFP_KERNEL);
+	snd_hda_codec_set_name(*codecp, buf);
 }
 
 #define DEFINE_PARSE_ID_MODE(name) \
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 16b8dcba5c12..e1ffb0202ebc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -822,17 +822,7 @@ static const struct hda_codec_ops alc_patch_ops = {
 };
 
 
-/* replace the codec chip_name with the given string */
-static int alc_codec_rename(struct hda_codec *codec, const char *name)
-{
-	kfree(codec->core.chip_name);
-	codec->core.chip_name = kstrdup(name, GFP_KERNEL);
-	if (!codec->core.chip_name) {
-		alc_free(codec);
-		return -ENOMEM;
-	}
-	return 0;
-}
+#define alc_codec_rename(codec, name) snd_hda_codec_set_name(codec, name)
 
 /*
  * Rename codecs appropriately from COEF value or subvendor id
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index da5366405eda..d714a57e9460 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -785,21 +785,11 @@ static int patch_vt1708S(struct hda_codec *codec)
 	override_mic_boost(codec, 0x1e, 0, 3, 40);
 
 	/* correct names for VT1708BCE */
-	if (get_codec_type(codec) == VT1708BCE)	{
-		kfree(codec->core.chip_name);
-		codec->core.chip_name = kstrdup("VT1708BCE", GFP_KERNEL);
-		snprintf(codec->card->mixername,
-			 sizeof(codec->card->mixername),
-			 "%s %s", codec->core.vendor_name, codec->core.chip_name);
-	}
+	if (get_codec_type(codec) == VT1708BCE)
+		snd_hda_codec_set_name(codec, "VT1708BCE");
 	/* correct names for VT1705 */
-	if (codec->core.vendor_id == 0x11064397) {
-		kfree(codec->core.chip_name);
-		codec->core.chip_name = kstrdup("VT1705", GFP_KERNEL);
-		snprintf(codec->card->mixername,
-			 sizeof(codec->card->mixername),
-			 "%s %s", codec->core.vendor_name, codec->core.chip_name);
-	}
+	if (codec->core.vendor_id == 0x11064397)
+		snd_hda_codec_set_name(codec, "VT1705");
 
 	/* automatic parse from the BIOS config */
 	err = via_parse_auto_config(codec);
-- 
2.6.1
