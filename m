From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Use standard device registration
	for beep
Date: Tue, 29 Jan 2019 19:57:47 +0100
Message-ID: <20190129185747.19547-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A0DD92674A3
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 19:57:51 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DD92AB655
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 18:57:50 +0000 (UTC)
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

Currently the registration and free of beep input device was done
manually from the register and the disconnect callbacks of the
assigned codec object.  This seems working in most cases, but this may
be a cause of some races at probe.  Moreover, due to these manual
calls, the total code became unnecessarily lengthy.

This patch rewrites the beep registration code to follow the standard
sound device object style.  This allows us reducing the code, in
addition to avoiding the nested device registration calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c  | 151 ++++++++++++++++++++++------------------------
 sound/pci/hda/hda_beep.h  |   5 --
 sound/pci/hda/hda_codec.c |  10 ---
 3 files changed, 72 insertions(+), 94 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 066b5b59c4d7..b7d9160ed868 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -127,44 +127,6 @@ static void turn_off_beep(struct hda_beep *beep)
 	}
 }
 
-static void snd_hda_do_detach(struct hda_beep *beep)
-{
-	if (beep->registered)
-		input_unregister_device(beep->dev);
-	else
-		input_free_device(beep->dev);
-	beep->dev = NULL;
-	turn_off_beep(beep);
-}
-
-static int snd_hda_do_attach(struct hda_beep *beep)
-{
-	struct input_dev *input_dev;
-	struct hda_codec *codec = beep->codec;
-
-	input_dev = input_allocate_device();
-	if (!input_dev)
-		return -ENOMEM;
-
-	/* setup digital beep device */
-	input_dev->name = "HDA Digital PCBeep";
-	input_dev->phys = beep->phys;
-	input_dev->id.bustype = BUS_PCI;
-	input_dev->dev.parent = &codec->card->card_dev;
-
-	input_dev->id.vendor = codec->core.vendor_id >> 16;
-	input_dev->id.product = codec->core.vendor_id & 0xffff;
-	input_dev->id.version = 0x01;
-
-	input_dev->evbit[0] = BIT_MASK(EV_SND);
-	input_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
-	input_dev->event = snd_hda_beep_event;
-	input_set_drvdata(input_dev, beep);
-
-	beep->dev = input_dev;
-	return 0;
-}
-
 /**
  * snd_hda_enable_beep_device - Turn on/off beep sound
  * @codec: the HDA codec
@@ -186,6 +148,38 @@ int snd_hda_enable_beep_device(struct hda_codec *codec, int enable)
 }
 EXPORT_SYMBOL_GPL(snd_hda_enable_beep_device);
 
+static int beep_dev_register(struct snd_device *device)
+{
+	struct hda_beep *beep = device->device_data;
+	int err;
+
+	err = input_register_device(beep->dev);
+	if (!err)
+		beep->registered = true;
+	return err;
+}
+
+static int beep_dev_disconnect(struct snd_device *device)
+{
+	struct hda_beep *beep = device->device_data;
+
+	if (beep->registered)
+		input_unregister_device(beep->dev);
+	else
+		input_free_device(beep->dev);
+	turn_off_beep(beep);
+	return 0;
+}
+
+static int beep_dev_free(struct snd_device *device)
+{
+	struct hda_beep *beep = device->device_data;
+
+	beep->codec->beep = NULL;
+	kfree(beep);
+	return 0;
+}
+
 /**
  * snd_hda_attach_beep_device - Attach a beep input device
  * @codec: the HDA codec
@@ -194,14 +188,16 @@ EXPORT_SYMBOL_GPL(snd_hda_enable_beep_device);
  * Attach a beep object to the given widget.  If beep hint is turned off
  * explicitly or beep_mode of the codec is turned off, this doesn't nothing.
  *
- * The attached beep device has to be registered via
- * snd_hda_register_beep_device() and released via snd_hda_detach_beep_device()
- * appropriately.
- *
  * Currently, only one beep device is allowed to each codec.
  */
 int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 {
+	static struct snd_device_ops ops = {
+		.dev_register = beep_dev_register,
+		.dev_disconnect = beep_dev_disconnect,
+		.dev_free = beep_dev_free,
+	};
+	struct input_dev *input_dev;
 	struct hda_beep *beep;
 	int err;
 
@@ -226,14 +222,41 @@ int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 	INIT_WORK(&beep->beep_work, &snd_hda_generate_beep);
 	mutex_init(&beep->mutex);
 
-	err = snd_hda_do_attach(beep);
-	if (err < 0) {
-		kfree(beep);
-		codec->beep = NULL;
-		return err;
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		err = -ENOMEM;
+		goto err_free;
 	}
 
+	/* setup digital beep device */
+	input_dev->name = "HDA Digital PCBeep";
+	input_dev->phys = beep->phys;
+	input_dev->id.bustype = BUS_PCI;
+	input_dev->dev.parent = &codec->card->card_dev;
+
+	input_dev->id.vendor = codec->core.vendor_id >> 16;
+	input_dev->id.product = codec->core.vendor_id & 0xffff;
+	input_dev->id.version = 0x01;
+
+	input_dev->evbit[0] = BIT_MASK(EV_SND);
+	input_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
+	input_dev->event = snd_hda_beep_event;
+	input_set_drvdata(input_dev, beep);
+
+	beep->dev = input_dev;
+
+	err = snd_device_new(codec->card, SNDRV_DEV_JACK, beep, &ops);
+	if (err < 0)
+		goto err_input;
+
 	return 0;
+
+ err_input:
+	input_free_device(beep->dev);
+ err_free:
+	kfree(beep);
+	codec->beep = NULL;
+	return err;
 }
 EXPORT_SYMBOL_GPL(snd_hda_attach_beep_device);
 
@@ -243,41 +266,11 @@ EXPORT_SYMBOL_GPL(snd_hda_attach_beep_device);
  */
 void snd_hda_detach_beep_device(struct hda_codec *codec)
 {
-	struct hda_beep *beep = codec->beep;
-	if (beep) {
-		if (beep->dev)
-			snd_hda_do_detach(beep);
-		codec->beep = NULL;
-		kfree(beep);
-	}
+	if (!codec->bus->shutdown && codec->beep)
+		snd_device_free(codec->card, codec->beep);
 }
 EXPORT_SYMBOL_GPL(snd_hda_detach_beep_device);
 
-/**
- * snd_hda_register_beep_device - Register the beep device
- * @codec: the HDA codec
- */
-int snd_hda_register_beep_device(struct hda_codec *codec)
-{
-	struct hda_beep *beep = codec->beep;
-	int err;
-
-	if (!beep || !beep->dev)
-		return 0;
-
-	err = input_register_device(beep->dev);
-	if (err < 0) {
-		codec_err(codec, "hda_beep: unable to register input device\n");
-		input_free_device(beep->dev);
-		codec->beep = NULL;
-		kfree(beep);
-		return err;
-	}
-	beep->registered = true;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hda_register_beep_device);
-
 static bool ctl_has_mute(struct snd_kcontrol *kcontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
diff --git a/sound/pci/hda/hda_beep.h b/sound/pci/hda/hda_beep.h
index f1457c6b3969..a25358a4807a 100644
--- a/sound/pci/hda/hda_beep.h
+++ b/sound/pci/hda/hda_beep.h
@@ -34,7 +34,6 @@ struct hda_beep {
 int snd_hda_enable_beep_device(struct hda_codec *codec, int enable);
 int snd_hda_attach_beep_device(struct hda_codec *codec, int nid);
 void snd_hda_detach_beep_device(struct hda_codec *codec);
-int snd_hda_register_beep_device(struct hda_codec *codec);
 #else
 static inline int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 {
@@ -43,9 +42,5 @@ static inline int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 static inline void snd_hda_detach_beep_device(struct hda_codec *codec)
 {
 }
-static inline int snd_hda_register_beep_device(struct hda_codec *codec)
-{
-	return 0;
-}
 #endif
 #endif
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index dc7b342f00ef..5f2005098a60 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -813,7 +813,6 @@ void snd_hda_codec_register(struct hda_codec *codec)
 	if (codec->registered)
 		return;
 	if (device_is_registered(hda_codec_dev(codec))) {
-		snd_hda_register_beep_device(codec);
 		codec_display_power(codec, true);
 		pm_runtime_enable(hda_codec_dev(codec));
 		/* it was powered up in snd_hda_codec_new(), now all done */
@@ -828,14 +827,6 @@ static int snd_hda_codec_dev_register(struct snd_device *device)
 	return 0;
 }
 
-static int snd_hda_codec_dev_disconnect(struct snd_device *device)
-{
-	struct hda_codec *codec = device->device_data;
-
-	snd_hda_detach_beep_device(codec);
-	return 0;
-}
-
 static int snd_hda_codec_dev_free(struct snd_device *device)
 {
 	struct hda_codec *codec = device->device_data;
@@ -921,7 +912,6 @@ int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
 	int err;
 	static struct snd_device_ops dev_ops = {
 		.dev_register = snd_hda_codec_dev_register,
-		.dev_disconnect = snd_hda_codec_dev_disconnect,
 		.dev_free = snd_hda_codec_dev_free,
 	};
 
-- 
2.16.4
