From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/9] ALSA: hda - Add card field to hda_codec
	struct
Date: Fri, 27 Feb 2015 23:55:37 +0100
Message-ID: <1425077744-4553-3-git-send-email-tiwai@suse.de>
References: <1425077744-4553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C2E6426519B
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 23:55:46 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5F95DABA2
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:55:46 +0000 (UTC)
In-Reply-To: <1425077744-4553-1-git-send-email-tiwai@suse.de>
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

Allow the codec object to have an individual card pointer.  Not only
this simplifies the redirections in many places, also this will allow
us to make each codec assigned to a different card object.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c       |  4 ++--
 sound/pci/hda/hda_bind.c       |  6 +++---
 sound/pci/hda/hda_codec.c      | 30 +++++++++++++++---------------
 sound/pci/hda/hda_codec.h      |  5 +++--
 sound/pci/hda/hda_controller.c |  2 +-
 sound/pci/hda/hda_hwdep.c      |  2 +-
 sound/pci/hda/hda_jack.c       |  8 ++++----
 sound/pci/hda/hda_proc.c       |  2 +-
 sound/pci/hda/hda_sysfs.c      |  2 +-
 sound/pci/hda/hda_trace.h      |  4 ++--
 sound/pci/hda/patch_ca0132.c   |  2 +-
 sound/pci/hda/patch_hdmi.c     |  6 +++---
 sound/pci/hda/patch_via.c      |  8 ++++----
 13 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 45a3d7ae6f56..9054dfab583f 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -160,7 +160,7 @@ static int snd_hda_do_attach(struct hda_beep *beep)
 	input_dev->name = "HDA Digital PCBeep";
 	input_dev->phys = beep->phys;
 	input_dev->id.bustype = BUS_PCI;
-	input_dev->dev.parent = &codec->bus->card->card_dev;
+	input_dev->dev.parent = &codec->card->card_dev;
 
 	input_dev->id.vendor = codec->vendor_id >> 16;
 	input_dev->id.product = codec->vendor_id & 0xffff;
@@ -224,7 +224,7 @@ int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 	if (beep == NULL)
 		return -ENOMEM;
 	snprintf(beep->phys, sizeof(beep->phys),
-		"card%d/codec#%d/beep0", codec->bus->card->number, codec->addr);
+		"card%d/codec#%d/beep0", codec->card->number, codec->addr);
 	/* enable linear scale */
 	snd_hda_regmap_write(codec, nid, AC_VERB_SET_DIGI_CONVERT_2, 0x01);
 
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 8be97ffe10b2..d0d5aead3746 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -293,9 +293,9 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 	}
 
 	/* audio codec should override the mixer name */
-	if (codec->afg || !*codec->bus->card->mixername)
-		snprintf(codec->bus->card->mixername,
-			 sizeof(codec->bus->card->mixername),
+	if (codec->afg || !*codec->card->mixername)
+		snprintf(codec->card->mixername,
+			 sizeof(codec->card->mixername),
 			 "%s %s", codec->vendor_name, codec->chip_name);
 	return 0;
 
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index a6e49e446f8d..9f7d22f4f9f9 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1208,9 +1208,8 @@ static void snd_hda_codec_dev_release(struct device *dev)
  *
  * Returns 0 if successful, or a negative error code.
  */
-int snd_hda_codec_new(struct hda_bus *bus,
-				unsigned int codec_addr,
-				struct hda_codec **codecp)
+int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
+		      unsigned int codec_addr, struct hda_codec **codecp)
 {
 	struct hda_codec *codec;
 	struct device *dev;
@@ -1229,7 +1228,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
 		return -EINVAL;
 
 	if (bus->caddr_tbl[codec_addr]) {
-		dev_err(bus->card->dev,
+		dev_err(card->dev,
 			"address 0x%x is already occupied\n",
 			codec_addr);
 		return -EBUSY;
@@ -1237,21 +1236,22 @@ int snd_hda_codec_new(struct hda_bus *bus,
 
 	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
 	if (codec == NULL) {
-		dev_err(bus->card->dev, "can't allocate struct hda_codec\n");
+		dev_err(card->dev, "can't allocate struct hda_codec\n");
 		return -ENOMEM;
 	}
 
 	dev = hda_codec_dev(codec);
 	device_initialize(dev);
-	dev->parent = bus->card->dev;
+	dev->parent = card->dev;
 	dev->bus = &snd_hda_bus_type;
 	dev->release = snd_hda_codec_dev_release;
 	dev->groups = snd_hda_dev_attr_groups;
-	dev_set_name(dev, "hdaudioC%dD%d", bus->card->number, codec_addr);
+	dev_set_name(dev, "hdaudioC%dD%d", card->number, codec_addr);
 	dev_set_drvdata(dev, codec); /* for sysfs */
 	device_enable_async_suspend(dev);
 
 	codec->bus = bus;
+	codec->card = card;
 	codec->addr = codec_addr;
 	mutex_init(&codec->spdif_mutex);
 	mutex_init(&codec->control_mutex);
@@ -1309,7 +1309,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
 
 	setup_fg_nodes(codec);
 	if (!codec->afg && !codec->mfg) {
-		dev_err(bus->card->dev, "no AFG or MFG node found\n");
+		dev_err(card->dev, "no AFG or MFG node found\n");
 		err = -ENODEV;
 		goto error;
 	}
@@ -1317,7 +1317,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	fg = codec->afg ? codec->afg : codec->mfg;
 	err = read_widget_caps(codec, fg);
 	if (err < 0) {
-		dev_err(bus->card->dev, "cannot malloc\n");
+		dev_err(card->dev, "cannot malloc\n");
 		goto error;
 	}
 	err = read_pin_defaults(codec);
@@ -1346,9 +1346,9 @@ int snd_hda_codec_new(struct hda_bus *bus,
 
 	sprintf(component, "HDA:%08x,%08x,%08x", codec->vendor_id,
 		codec->subsystem_id, codec->revision_id);
-	snd_component_add(codec->bus->card, component);
+	snd_component_add(card, component);
 
-	err = snd_device_new(bus->card, SNDRV_DEV_CODEC, codec, &dev_ops);
+	err = snd_device_new(card, SNDRV_DEV_CODEC, codec, &dev_ops);
 	if (err < 0)
 		goto error;
 
@@ -1956,7 +1956,7 @@ find_mixer_ctl(struct hda_codec *codec, const char *name, int dev, int idx)
 	if (snd_BUG_ON(strlen(name) >= sizeof(id.name)))
 		return NULL;
 	strcpy(id.name, name);
-	return snd_ctl_find_id(codec->bus->card, &id);
+	return snd_ctl_find_id(codec->card, &id);
 }
 
 /**
@@ -2020,7 +2020,7 @@ int snd_hda_ctl_add(struct hda_codec *codec, hda_nid_t nid,
 		nid = kctl->id.subdevice & 0xffff;
 	if (kctl->id.subdevice & (HDA_SUBDEV_NID_FLAG|HDA_SUBDEV_AMP_FLAG))
 		kctl->id.subdevice = 0;
-	err = snd_ctl_add(codec->bus->card, kctl);
+	err = snd_ctl_add(codec->card, kctl);
 	if (err < 0)
 		return err;
 	item = snd_array_new(&codec->mixers);
@@ -2073,7 +2073,7 @@ void snd_hda_ctls_clear(struct hda_codec *codec)
 	int i;
 	struct hda_nid_item *items = codec->mixers.list;
 	for (i = 0; i < codec->mixers.used; i++)
-		snd_ctl_remove(codec->bus->card, items[i].kctl);
+		snd_ctl_remove(codec->card, items[i].kctl);
 	snd_array_free(&codec->mixers);
 	snd_array_free(&codec->nids);
 }
@@ -2146,7 +2146,7 @@ EXPORT_SYMBOL_GPL(snd_hda_unlock_devices);
 int snd_hda_codec_reset(struct hda_codec *codec)
 {
 	struct hda_bus *bus = codec->bus;
-	struct snd_card *card = bus->card;
+	struct snd_card *card = codec->card;
 	int i;
 
 	if (snd_hda_lock_devices(bus) < 0)
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index fff3603bfff5..1fb25cddf819 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -256,6 +256,7 @@ struct hda_pcm {
 struct hda_codec {
 	struct device dev;
 	struct hda_bus *bus;
+	struct snd_card *card;
 	unsigned int addr;	/* codec addr*/
 	struct list_head list;	/* list point */
 
@@ -403,8 +404,8 @@ enum {
  * constructors
  */
 int snd_hda_bus_new(struct snd_card *card, struct hda_bus **busp);
-int snd_hda_codec_new(struct hda_bus *bus, unsigned int codec_addr,
-		      struct hda_codec **codecp);
+int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
+		      unsigned int codec_addr, struct hda_codec **codecp);
 int snd_hda_codec_configure(struct hda_codec *codec);
 int snd_hda_codec_update_widgets(struct hda_codec *codec);
 
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 1695f0e2bd9d..f50863a5159d 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1898,7 +1898,7 @@ int azx_probe_codecs(struct azx *chip, unsigned int max_slots)
 	for (c = 0; c < max_slots; c++) {
 		if ((chip->codec_mask & (1 << c)) & chip->codec_probe_mask) {
 			struct hda_codec *codec;
-			err = snd_hda_codec_new(bus, c, &codec);
+			err = snd_hda_codec_new(bus, bus->card, c, &codec);
 			if (err < 0)
 				continue;
 			codec->jackpoll_interval = get_jackpoll_interval(chip);
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 125f3420fa6a..57df06e76968 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -101,7 +101,7 @@ int snd_hda_create_hwdep(struct hda_codec *codec)
 	int err;
 
 	sprintf(hwname, "HDA Codec %d", codec->addr);
-	err = snd_hwdep_new(codec->bus->card, hwname, codec->addr, &hwdep);
+	err = snd_hwdep_new(codec->card, hwname, codec->addr, &hwdep);
 	if (err < 0)
 		return err;
 	codec->hwdep = hwdep;
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 2e933783c83f..897ab7db31e2 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -135,7 +135,7 @@ void snd_hda_jack_tbl_clear(struct hda_codec *codec)
 #ifdef CONFIG_SND_HDA_INPUT_JACK
 		/* free jack instances manually when clearing/reconfiguring */
 		if (!codec->bus->shutdown && jack->jack)
-			snd_device_free(codec->bus->card, jack->jack);
+			snd_device_free(codec->card, jack->jack);
 #endif
 		for (cb = jack->callback; cb; cb = next) {
 			next = cb->next;
@@ -340,7 +340,7 @@ void snd_hda_jack_report_sync(struct hda_codec *codec)
 			if (!jack->kctl || jack->block_report)
 				continue;
 			state = get_jack_plug_state(jack->pin_sense);
-			snd_kctl_jack_report(codec->bus->card, jack->kctl, state);
+			snd_kctl_jack_report(codec->card, jack->kctl, state);
 #ifdef CONFIG_SND_HDA_INPUT_JACK
 			if (jack->jack)
 				snd_jack_report(jack->jack,
@@ -412,11 +412,11 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 	jack->phantom_jack = !!phantom_jack;
 
 	state = snd_hda_jack_detect(codec, nid);
-	snd_kctl_jack_report(codec->bus->card, kctl, state);
+	snd_kctl_jack_report(codec->card, kctl, state);
 #ifdef CONFIG_SND_HDA_INPUT_JACK
 	if (!phantom_jack) {
 		jack->type = get_input_jack_type(codec, nid);
-		err = snd_jack_new(codec->bus->card, name, jack->type,
+		err = snd_jack_new(codec->card, name, jack->type,
 				   &jack->jack);
 		if (err < 0)
 			return err;
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index ce5a6da83419..cc32b878ae2e 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -839,7 +839,7 @@ int snd_hda_codec_proc_new(struct hda_codec *codec)
 	int err;
 
 	snprintf(name, sizeof(name), "codec#%d", codec->addr);
-	err = snd_card_proc_new(codec->bus->card, name, &entry);
+	err = snd_card_proc_new(codec->card, name, &entry);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index ccc962a1699f..e13c75d67847 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -149,7 +149,7 @@ static int reconfig_codec(struct hda_codec *codec)
 	err = snd_hda_codec_build_controls(codec);
 	if (err < 0)
 		goto error;
-	err = snd_card_register(codec->bus->card);
+	err = snd_card_register(codec->card);
  error:
 	snd_hda_power_down(codec);
 	return err;
diff --git a/sound/pci/hda/hda_trace.h b/sound/pci/hda/hda_trace.h
index c0e1c7d24dbe..7fedfa862419 100644
--- a/sound/pci/hda/hda_trace.h
+++ b/sound/pci/hda/hda_trace.h
@@ -23,7 +23,7 @@ DECLARE_EVENT_CLASS(hda_cmd,
 	),
 
 	TP_fast_assign(
-		__entry->card = (codec)->bus->card->number;
+		__entry->card = (codec)->card->number;
 		__entry->addr = (codec)->addr;
 		__entry->val = (val);
 	),
@@ -71,7 +71,7 @@ DECLARE_EVENT_CLASS(hda_power,
 	),
 
 	TP_fast_assign(
-		__entry->card = (codec)->bus->card->number;
+		__entry->card = (codec)->card->number;
 		__entry->addr = (codec)->addr;
 	),
 
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 81991b4134cd..ced3e82d9e23 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4352,7 +4352,7 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
 	const struct dsp_image_seg *dsp_os_image;
 	const struct firmware *fw_entry;
 
-	if (request_firmware(&fw_entry, EFX_FILE, codec->bus->card->dev) != 0)
+	if (request_firmware(&fw_entry, EFX_FILE, codec->card->dev) != 0)
 		return false;
 
 	dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 78f8c2ed86f9..8f40b7d864c0 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -579,7 +579,7 @@ static int eld_proc_new(struct hdmi_spec_per_pin *per_pin, int index)
 	int err;
 
 	snprintf(name, sizeof(name), "eld#%d.%d", codec->addr, index);
-	err = snd_card_proc_new(codec->bus->card, name, &entry);
+	err = snd_card_proc_new(codec->card, name, &entry);
 	if (err < 0)
 		return err;
 
@@ -594,7 +594,7 @@ static int eld_proc_new(struct hdmi_spec_per_pin *per_pin, int index)
 static void eld_proc_free(struct hdmi_spec_per_pin *per_pin)
 {
 	if (!per_pin->codec->bus->shutdown && per_pin->proc_entry) {
-		snd_device_free(per_pin->codec->bus->card, per_pin->proc_entry);
+		snd_device_free(per_pin->codec->card, per_pin->proc_entry);
 		per_pin->proc_entry = NULL;
 	}
 }
@@ -1622,7 +1622,7 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	}
 
 	if (eld_changed)
-		snd_ctl_notify(codec->bus->card,
+		snd_ctl_notify(codec->card,
 			       SNDRV_CTL_EVENT_MASK_VALUE | SNDRV_CTL_EVENT_MASK_INFO,
 			       &per_pin->eld_ctl->id);
  unlock:
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 2045f33b1ace..57ad503ff940 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -907,16 +907,16 @@ static int patch_vt1708S(struct hda_codec *codec)
 	if (get_codec_type(codec) == VT1708BCE)	{
 		kfree(codec->chip_name);
 		codec->chip_name = kstrdup("VT1708BCE", GFP_KERNEL);
-		snprintf(codec->bus->card->mixername,
-			 sizeof(codec->bus->card->mixername),
+		snprintf(codec->card->mixername,
+			 sizeof(codec->card->mixername),
 			 "%s %s", codec->vendor_name, codec->chip_name);
 	}
 	/* correct names for VT1705 */
 	if (codec->vendor_id == 0x11064397)	{
 		kfree(codec->chip_name);
 		codec->chip_name = kstrdup("VT1705", GFP_KERNEL);
-		snprintf(codec->bus->card->mixername,
-			 sizeof(codec->bus->card->mixername),
+		snprintf(codec->card->mixername,
+			 sizeof(codec->card->mixername),
 			 "%s %s", codec->vendor_name, codec->chip_name);
 	}
 
-- 
2.3.0
