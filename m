From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/10] ALSA: hda - Bind codecs via standard bus
Date: Thu, 26 Feb 2015 18:00:17 +0100
Message-ID: <1424970025-8082-3-git-send-email-tiwai@suse.de>
References: <1424970025-8082-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ADE92261B31
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 18:00:31 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 62C2AADCA
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 17:00:31 +0000 (UTC)
In-Reply-To: <1424970025-8082-1-git-send-email-tiwai@suse.de>
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

Now we create the standard HD-audio bus (/sys/bus/hdaudio), and bind
the codec driver with the codec device over there.  This is the first
step of the whole transition so that the changes to each codec driver
are kept as minimal as possible.

Each codec driver needs to register hda_codec_driver struct containing
the currently existing preset via the new helper macro
module_hda_codec_driver().  The old hda_codec_preset_list is replaced
with this infrastructure.  The generic parsers (for HDMI and other)
are also included in the preset with the special IDs to bind
uniquely.

In HD-audio core side, the device binding code is split to
hda_bind.c.  It provides the snd_hda_bus_type implementation to match
the codec driver with the given codec vendor ID.  It also manages the
module auto-loading by itself like before: when the matching isn't
found, it tries to probe the corresponding codec modules, and finally
falls back to the generic drivers.  (The special ID mentioned above is
set at this stage.)

The only visible change to outside is that the hdaudio sysfs entry now
appears in /sys/bus/devices, not as a sound class device.

More works to move the suspend/resume and remove ops will be
(hopefully) done in later patches.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Makefile         |   2 +-
 sound/pci/hda/hda_bind.c       | 320 +++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_codec.c      | 307 +++------------------------------------
 sound/pci/hda/hda_codec.h      |  27 ++--
 sound/pci/hda/hda_generic.c    |  18 ++-
 sound/pci/hda/hda_local.h      |  18 ++-
 sound/pci/hda/patch_analog.c   |  16 +--
 sound/pci/hda/patch_ca0110.c   |  16 +--
 sound/pci/hda/patch_ca0132.c   |  16 +--
 sound/pci/hda/patch_cirrus.c   |  16 +--
 sound/pci/hda/patch_cmedia.c   |  16 +--
 sound/pci/hda/patch_conexant.c |  16 +--
 sound/pci/hda/patch_hdmi.c     |  27 +---
 sound/pci/hda/patch_realtek.c  |  16 +--
 sound/pci/hda/patch_si3054.c   |  16 +--
 sound/pci/hda/patch_sigmatel.c |  16 +--
 sound/pci/hda/patch_via.c      |  16 +--
 17 files changed, 401 insertions(+), 478 deletions(-)
 create mode 100644 sound/pci/hda/hda_bind.c

diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 194f30935e77..96caaebfc19d 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -4,7 +4,7 @@ snd-hda-tegra-objs := hda_tegra.o
 # for haswell power well
 snd-hda-intel-$(CONFIG_SND_HDA_I915) +=	hda_i915.o
 
-snd-hda-codec-y := hda_codec.o hda_jack.o hda_auto_parser.o hda_sysfs.o
+snd-hda-codec-y := hda_bind.o hda_codec.o hda_jack.o hda_auto_parser.o hda_sysfs.o
 snd-hda-codec-$(CONFIG_PROC_FS) += hda_proc.o
 snd-hda-codec-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
 snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
new file mode 100644
index 000000000000..adf6b475dee1
--- /dev/null
+++ b/sound/pci/hda/hda_bind.c
@@ -0,0 +1,320 @@
+/*
+ * HD-audio codec driver binding
+ * Copyright (c) Takashi Iwai <tiwai@suse.de>
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/export.h>
+#include <sound/core.h>
+#include "hda_codec.h"
+#include "hda_local.h"
+
+/* codec vendor labels */
+struct hda_vendor_id {
+	unsigned int id;
+	const char *name;
+};
+
+static struct hda_vendor_id hda_vendor_ids[] = {
+	{ 0x1002, "ATI" },
+	{ 0x1013, "Cirrus Logic" },
+	{ 0x1057, "Motorola" },
+	{ 0x1095, "Silicon Image" },
+	{ 0x10de, "Nvidia" },
+	{ 0x10ec, "Realtek" },
+	{ 0x1102, "Creative" },
+	{ 0x1106, "VIA" },
+	{ 0x111d, "IDT" },
+	{ 0x11c1, "LSI" },
+	{ 0x11d4, "Analog Devices" },
+	{ 0x13f6, "C-Media" },
+	{ 0x14f1, "Conexant" },
+	{ 0x17e8, "Chrontel" },
+	{ 0x1854, "LG" },
+	{ 0x1aec, "Wolfson Microelectronics" },
+	{ 0x1af4, "QEMU" },
+	{ 0x434d, "C-Media" },
+	{ 0x8086, "Intel" },
+	{ 0x8384, "SigmaTel" },
+	{} /* terminator */
+};
+
+/*
+ * find a matching codec preset
+ */
+static int hda_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct hda_codec *codec = container_of(dev, struct hda_codec, dev);
+	struct hda_codec_driver *driver =
+		container_of(drv, struct hda_codec_driver, driver);
+	const struct hda_codec_preset *preset;
+	/* check probe_id instead of vendor_id if set */
+	u32 id = codec->probe_id ? codec->probe_id : codec->vendor_id;
+
+	for (preset = driver->preset; preset->id; preset++) {
+		u32 mask = preset->mask;
+
+		if (preset->afg && preset->afg != codec->afg)
+			continue;
+		if (preset->mfg && preset->mfg != codec->mfg)
+			continue;
+		if (!mask)
+			mask = ~0;
+		if (preset->id == (id & mask) &&
+		    (!preset->rev || preset->rev == codec->revision_id)) {
+			codec->preset = preset;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/* reset the codec name from the preset */
+static int codec_refresh_name(struct hda_codec *codec, const char *name)
+{
+	char tmp[16];
+
+	kfree(codec->chip_name);
+	if (!name) {
+		sprintf(tmp, "ID %x", codec->vendor_id & 0xffff);
+		name = tmp;
+	}
+	codec->chip_name = kstrdup(name, GFP_KERNEL);
+	return codec->chip_name ? 0 : -ENOMEM;
+}
+
+static int hda_codec_driver_probe(struct device *dev)
+{
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+	struct module *owner = dev->driver->owner;
+	int err;
+
+	if (WARN_ON(!codec->preset))
+		return -EINVAL;
+
+	err = codec_refresh_name(codec, codec->preset->name);
+	if (err < 0)
+		goto error;
+
+	if (!try_module_get(owner)) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	err = codec->preset->patch(codec);
+	if (err < 0) {
+		module_put(owner);
+		goto error;
+	}
+
+	return 0;
+
+ error:
+	codec->preset = NULL;
+	memset(&codec->patch_ops, 0, sizeof(codec->patch_ops));
+	return err;
+}
+
+static int hda_codec_driver_remove(struct device *dev)
+{
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+
+	if (codec->patch_ops.free)
+		codec->patch_ops.free(codec);
+	codec->preset = NULL;
+	memset(&codec->patch_ops, 0, sizeof(codec->patch_ops));
+	module_put(dev->driver->owner);
+	return 0;
+}
+
+int __hda_codec_driver_register(struct hda_codec_driver *drv, const char *name,
+			       struct module *owner)
+{
+	drv->driver.name = name;
+	drv->driver.owner = owner;
+	drv->driver.bus = &snd_hda_bus_type;
+	drv->driver.probe = hda_codec_driver_probe;
+	drv->driver.remove = hda_codec_driver_remove;
+	/* TODO: PM and others */
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(__hda_codec_driver_register);
+
+void hda_codec_driver_unregister(struct hda_codec_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(hda_codec_driver_unregister);
+
+static inline bool codec_probed(struct hda_codec *codec)
+{
+	return device_attach(hda_codec_dev(codec)) > 0 && codec->preset;
+}
+
+/* try to auto-load and bind the codec module */
+static void codec_bind_module(struct hda_codec *codec)
+{
+#ifdef MODULE
+	request_module("snd-hda-codec-id:%08x", codec->vendor_id);
+	if (codec_probed(codec))
+		return;
+	request_module("snd-hda-codec-id:%04x*",
+		       (codec->vendor_id >> 16) & 0xffff);
+	if (codec_probed(codec))
+		return;
+#endif
+}
+
+/* store the codec vendor name */
+static int get_codec_vendor_name(struct hda_codec *codec)
+{
+	const struct hda_vendor_id *c;
+	const char *vendor = NULL;
+	u16 vendor_id = codec->vendor_id >> 16;
+	char tmp[16];
+
+	for (c = hda_vendor_ids; c->id; c++) {
+		if (c->id == vendor_id) {
+			vendor = c->name;
+			break;
+		}
+	}
+	if (!vendor) {
+		sprintf(tmp, "Generic %04x", vendor_id);
+		vendor = tmp;
+	}
+	codec->vendor_name = kstrdup(vendor, GFP_KERNEL);
+	if (!codec->vendor_name)
+		return -ENOMEM;
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
+/* if all audio out widgets are digital, let's assume the codec as a HDMI/DP */
+static bool is_likely_hdmi_codec(struct hda_codec *codec)
+{
+	hda_nid_t nid = codec->start_nid;
+	int i;
+
+	for (i = 0; i < codec->num_nodes; i++, nid++) {
+		unsigned int wcaps = get_wcaps(codec, nid);
+		switch (get_wcaps_type(wcaps)) {
+		case AC_WID_AUD_IN:
+			return false; /* HDMI parser supports only HDMI out */
+		case AC_WID_AUD_OUT:
+			if (!(wcaps & AC_WCAP_DIGITAL))
+				return false;
+			break;
+		}
+	}
+	return true;
+}
+#else
+/* no HDMI codec parser support */
+#define is_likely_hdmi_codec(codec)	false
+#endif /* CONFIG_SND_HDA_CODEC_HDMI */
+
+static int codec_bind_generic(struct hda_codec *codec)
+{
+	if (codec->probe_id)
+		return -ENODEV;
+
+	if (is_likely_hdmi_codec(codec)) {
+		codec->probe_id = HDA_CODEC_ID_GENERIC_HDMI;
+#if IS_MODULE(CONFIG_SND_HDA_CODEC_HDMI)
+		request_module("snd-hda-codec-hdmi");
+#endif
+		if (codec_probed(codec))
+			return 0;
+	}
+
+	codec->probe_id = HDA_CODEC_ID_GENERIC;
+#if IS_MODULE(CONFIG_SND_HDA_GENERIC)
+	request_module("snd-hda-codec-generic");
+#endif
+	if (codec_probed(codec))
+		return 0;
+	return -ENODEV;
+}
+
+#if IS_ENABLED(CONFIG_SND_HDA_GENERIC)
+#define is_generic_config(codec) \
+	(codec->modelname && !strcmp(codec->modelname, "generic"))
+#else
+#define is_generic_config(codec)	0
+#endif
+
+/**
+ * snd_hda_codec_configure - (Re-)configure the HD-audio codec
+ * @codec: the HDA codec
+ *
+ * Start parsing of the given codec tree and (re-)initialize the whole
+ * patch instance.
+ *
+ * Returns 0 if successful or a negative error code.
+ */
+int snd_hda_codec_configure(struct hda_codec *codec)
+{
+	int err;
+
+	if (!codec->vendor_name) {
+		err = get_codec_vendor_name(codec);
+		if (err < 0)
+			return err;
+	}
+
+	if (is_generic_config(codec))
+		codec->probe_id = HDA_CODEC_ID_GENERIC;
+	else
+		codec->probe_id = 0;
+
+	err = device_add(hda_codec_dev(codec));
+	if (err < 0)
+		return err;
+
+	if (!codec->preset)
+		codec_bind_module(codec);
+	if (!codec->preset) {
+		err = codec_bind_generic(codec);
+		if (err < 0) {
+			codec_err(codec, "Unable to bind the codec\n");
+			goto error;
+		}
+	}
+
+	/* audio codec should override the mixer name */
+	if (codec->afg || !*codec->bus->card->mixername)
+		snprintf(codec->bus->card->mixername,
+			 sizeof(codec->bus->card->mixername),
+			 "%s %s", codec->vendor_name, codec->chip_name);
+	return 0;
+
+ error:
+	device_del(hda_codec_dev(codec));
+	return err;
+}
+EXPORT_SYMBOL_GPL(snd_hda_codec_configure);
+
+/*
+ * bus registration
+ */
+struct bus_type snd_hda_bus_type = {
+	.name = "hdaudio",
+	.match = hda_bus_match,
+};
+
+static int __init hda_codec_init(void)
+{
+	return bus_register(&snd_hda_bus_type);
+}
+
+static void __exit hda_codec_exit(void)
+{
+	bus_unregister(&snd_hda_bus_type);
+}
+
+module_init(hda_codec_init);
+module_exit(hda_codec_exit);
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 5e755eb6f19a..61c8174e8013 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -40,69 +40,6 @@
 #define CREATE_TRACE_POINTS
 #include "hda_trace.h"
 
-/*
- * vendor / preset table
- */
-
-struct hda_vendor_id {
-	unsigned int id;
-	const char *name;
-};
-
-/* codec vendor labels */
-static struct hda_vendor_id hda_vendor_ids[] = {
-	{ 0x1002, "ATI" },
-	{ 0x1013, "Cirrus Logic" },
-	{ 0x1057, "Motorola" },
-	{ 0x1095, "Silicon Image" },
-	{ 0x10de, "Nvidia" },
-	{ 0x10ec, "Realtek" },
-	{ 0x1102, "Creative" },
-	{ 0x1106, "VIA" },
-	{ 0x111d, "IDT" },
-	{ 0x11c1, "LSI" },
-	{ 0x11d4, "Analog Devices" },
-	{ 0x13f6, "C-Media" },
-	{ 0x14f1, "Conexant" },
-	{ 0x17e8, "Chrontel" },
-	{ 0x1854, "LG" },
-	{ 0x1aec, "Wolfson Microelectronics" },
-	{ 0x1af4, "QEMU" },
-	{ 0x434d, "C-Media" },
-	{ 0x8086, "Intel" },
-	{ 0x8384, "SigmaTel" },
-	{} /* terminator */
-};
-
-static DEFINE_MUTEX(preset_mutex);
-static LIST_HEAD(hda_preset_tables);
-
-/**
- * snd_hda_add_codec_preset - Add a codec preset to the chain
- * @preset: codec preset table to add
- */
-int snd_hda_add_codec_preset(struct hda_codec_preset_list *preset)
-{
-	mutex_lock(&preset_mutex);
-	list_add_tail(&preset->list, &hda_preset_tables);
-	mutex_unlock(&preset_mutex);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hda_add_codec_preset);
-
-/**
- * snd_hda_delete_codec_preset - Delete a codec preset from the chain
- * @preset: codec preset table to delete
- */
-int snd_hda_delete_codec_preset(struct hda_codec_preset_list *preset)
-{
-	mutex_lock(&preset_mutex);
-	list_del(&preset->list);
-	mutex_unlock(&preset_mutex);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hda_delete_codec_preset);
-
 #ifdef CONFIG_PM
 #define codec_in_pm(codec)	((codec)->in_pm)
 static void hda_power_work(struct work_struct *work);
@@ -885,111 +822,6 @@ int snd_hda_bus_new(struct snd_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_hda_bus_new);
 
-#if IS_ENABLED(CONFIG_SND_HDA_GENERIC)
-#define is_generic_config(codec) \
-	(codec->modelname && !strcmp(codec->modelname, "generic"))
-#else
-#define is_generic_config(codec)	0
-#endif
-
-#ifdef MODULE
-#define HDA_MODREQ_MAX_COUNT	2	/* two request_modules()'s */
-#else
-#define HDA_MODREQ_MAX_COUNT	0	/* all presets are statically linked */
-#endif
-
-/*
- * find a matching codec preset
- */
-static const struct hda_codec_preset *
-find_codec_preset(struct hda_codec *codec)
-{
-	struct hda_codec_preset_list *tbl;
-	const struct hda_codec_preset *preset;
-	unsigned int mod_requested = 0;
-
- again:
-	mutex_lock(&preset_mutex);
-	list_for_each_entry(tbl, &hda_preset_tables, list) {
-		if (!try_module_get(tbl->owner)) {
-			codec_err(codec, "cannot module_get\n");
-			continue;
-		}
-		for (preset = tbl->preset; preset->id; preset++) {
-			u32 mask = preset->mask;
-			if (preset->afg && preset->afg != codec->afg)
-				continue;
-			if (preset->mfg && preset->mfg != codec->mfg)
-				continue;
-			if (!mask)
-				mask = ~0;
-			if (preset->id == (codec->vendor_id & mask) &&
-			    (!preset->rev ||
-			     preset->rev == codec->revision_id)) {
-				mutex_unlock(&preset_mutex);
-				codec->owner = tbl->owner;
-				return preset;
-			}
-		}
-		module_put(tbl->owner);
-	}
-	mutex_unlock(&preset_mutex);
-
-	if (mod_requested < HDA_MODREQ_MAX_COUNT) {
-		if (!mod_requested)
-			request_module("snd-hda-codec-id:%08x",
-				       codec->vendor_id);
-		else
-			request_module("snd-hda-codec-id:%04x*",
-				       (codec->vendor_id >> 16) & 0xffff);
-		mod_requested++;
-		goto again;
-	}
-	return NULL;
-}
-
-/*
- * get_codec_name - store the codec name
- */
-static int get_codec_name(struct hda_codec *codec)
-{
-	const struct hda_vendor_id *c;
-	const char *vendor = NULL;
-	u16 vendor_id = codec->vendor_id >> 16;
-	char tmp[16];
-
-	if (codec->vendor_name)
-		goto get_chip_name;
-
-	for (c = hda_vendor_ids; c->id; c++) {
-		if (c->id == vendor_id) {
-			vendor = c->name;
-			break;
-		}
-	}
-	if (!vendor) {
-		sprintf(tmp, "Generic %04x", vendor_id);
-		vendor = tmp;
-	}
-	codec->vendor_name = kstrdup(vendor, GFP_KERNEL);
-	if (!codec->vendor_name)
-		return -ENOMEM;
-
- get_chip_name:
-	if (codec->chip_name)
-		return 0;
-
-	if (codec->preset && codec->preset->name)
-		codec->chip_name = kstrdup(codec->preset->name, GFP_KERNEL);
-	else {
-		sprintf(tmp, "ID %x", codec->vendor_id & 0xffff);
-		codec->chip_name = kstrdup(tmp, GFP_KERNEL);
-	}
-	if (!codec->chip_name)
-		return -ENOMEM;
-	return 0;
-}
-
 /*
  * look for an AFG and MFG nodes
  */
@@ -1301,20 +1133,6 @@ get_hda_cvt_setup(struct hda_codec *codec, hda_nid_t nid)
 }
 
 /*
- * Dynamic symbol binding for the codec parsers
- */
-
-#define load_parser(codec, sym) \
-	((codec)->parser = (int (*)(struct hda_codec *))symbol_request(sym))
-
-static void unload_parser(struct hda_codec *codec)
-{
-	if (codec->parser)
-		symbol_put_addr(codec->parser);
-	codec->parser = NULL;
-}
-
-/*
  * codec destructor
  */
 static void snd_hda_codec_free(struct hda_codec *codec)
@@ -1322,6 +1140,8 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	if (!codec)
 		return;
 	cancel_delayed_work_sync(&codec->jackpoll_work);
+	if (device_is_registered(hda_codec_dev(codec)))
+		device_del(hda_codec_dev(codec));
 	snd_hda_jack_tbl_clear(codec);
 	free_init_pincfgs(codec);
 #ifdef CONFIG_PM
@@ -1335,12 +1155,8 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	snd_array_free(&codec->spdif_out);
 	remove_conn_list(codec);
 	codec->bus->caddr_tbl[codec->addr] = NULL;
-	if (codec->patch_ops.free)
-		codec->patch_ops.free(codec);
 	hda_call_pm_notify(codec, false); /* cancel leftover refcounts */
 	snd_hda_sysfs_clear(codec);
-	unload_parser(codec);
-	module_put(codec->owner);
 	free_hda_cache(&codec->amp_cache);
 	free_hda_cache(&codec->cmd_cache);
 	kfree(codec->vendor_name);
@@ -1348,7 +1164,7 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	kfree(codec->modelname);
 	kfree(codec->wcaps);
 	codec->bus->num_codecs--;
-	put_device(&codec->dev);
+	put_device(hda_codec_dev(codec));
 }
 
 static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec,
@@ -1360,10 +1176,7 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 static int snd_hda_codec_dev_register(struct snd_device *device)
 {
 	struct hda_codec *codec = device->device_data;
-	int err = device_add(&codec->dev);
 
-	if (err < 0)
-		return err;
 	snd_hda_register_beep_device(codec);
 	return 0;
 }
@@ -1373,7 +1186,6 @@ static int snd_hda_codec_dev_disconnect(struct snd_device *device)
 	struct hda_codec *codec = device->device_data;
 
 	snd_hda_detach_beep_device(codec);
-	device_del(&codec->dev);
 	return 0;
 }
 
@@ -1386,7 +1198,7 @@ static int snd_hda_codec_dev_free(struct snd_device *device)
 /* just free the container */
 static void snd_hda_codec_dev_release(struct device *dev)
 {
-	kfree(container_of(dev, struct hda_codec, dev));
+	kfree(dev_to_hda_codec(dev));
 }
 
 /**
@@ -1402,6 +1214,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
 				struct hda_codec **codecp)
 {
 	struct hda_codec *codec;
+	struct device *dev;
 	char component[31];
 	hda_nid_t fg;
 	int err;
@@ -1429,14 +1242,14 @@ int snd_hda_codec_new(struct hda_bus *bus,
 		return -ENOMEM;
 	}
 
-	device_initialize(&codec->dev);
-	codec->dev.parent = &bus->card->card_dev;
-	codec->dev.class = sound_class;
-	codec->dev.release = snd_hda_codec_dev_release;
-	codec->dev.groups = snd_hda_dev_attr_groups;
-	dev_set_name(&codec->dev, "hdaudioC%dD%d", bus->card->number,
-		     codec_addr);
-	dev_set_drvdata(&codec->dev, codec); /* for sysfs */
+	dev = hda_codec_dev(codec);
+	device_initialize(dev);
+	dev->parent = bus->card->dev;
+	dev->bus = &snd_hda_bus_type;
+	dev->release = snd_hda_codec_dev_release;
+	dev->groups = snd_hda_dev_attr_groups;
+	dev_set_name(dev, "hdaudioC%dD%d", bus->card->number, codec_addr);
+	dev_set_drvdata(dev, codec); /* for sysfs */
 
 	codec->bus = bus;
 	codec->addr = codec_addr;
@@ -1587,92 +1400,6 @@ int snd_hda_codec_update_widgets(struct hda_codec *codec)
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_update_widgets);
 
-
-#if IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
-/* if all audio out widgets are digital, let's assume the codec as a HDMI/DP */
-static bool is_likely_hdmi_codec(struct hda_codec *codec)
-{
-	hda_nid_t nid = codec->start_nid;
-	int i;
-
-	for (i = 0; i < codec->num_nodes; i++, nid++) {
-		unsigned int wcaps = get_wcaps(codec, nid);
-		switch (get_wcaps_type(wcaps)) {
-		case AC_WID_AUD_IN:
-			return false; /* HDMI parser supports only HDMI out */
-		case AC_WID_AUD_OUT:
-			if (!(wcaps & AC_WCAP_DIGITAL))
-				return false;
-			break;
-		}
-	}
-	return true;
-}
-#else
-/* no HDMI codec parser support */
-#define is_likely_hdmi_codec(codec)	false
-#endif /* CONFIG_SND_HDA_CODEC_HDMI */
-
-/**
- * snd_hda_codec_configure - (Re-)configure the HD-audio codec
- * @codec: the HDA codec
- *
- * Start parsing of the given codec tree and (re-)initialize the whole
- * patch instance.
- *
- * Returns 0 if successful or a negative error code.
- */
-int snd_hda_codec_configure(struct hda_codec *codec)
-{
-	int (*patch)(struct hda_codec *) = NULL;
-	int err;
-
-	codec->preset = find_codec_preset(codec);
-	if (!codec->vendor_name || !codec->chip_name) {
-		err = get_codec_name(codec);
-		if (err < 0)
-			return err;
-	}
-
-	if (!is_generic_config(codec) && codec->preset)
-		patch = codec->preset->patch;
-	if (!patch) {
-		unload_parser(codec); /* to be sure */
-		if (is_likely_hdmi_codec(codec)) {
-#if IS_MODULE(CONFIG_SND_HDA_CODEC_HDMI)
-			patch = load_parser(codec, snd_hda_parse_hdmi_codec);
-#elif IS_BUILTIN(CONFIG_SND_HDA_CODEC_HDMI)
-			patch = snd_hda_parse_hdmi_codec;
-#endif
-		}
-		if (!patch) {
-#if IS_MODULE(CONFIG_SND_HDA_GENERIC)
-			patch = load_parser(codec, snd_hda_parse_generic_codec);
-#elif IS_BUILTIN(CONFIG_SND_HDA_GENERIC)
-			patch = snd_hda_parse_generic_codec;
-#endif
-		}
-		if (!patch) {
-			codec_err(codec, "No codec parser is available\n");
-			return -ENODEV;
-		}
-	}
-
-	err = patch(codec);
-	if (err < 0) {
-		unload_parser(codec);
-		return err;
-	}
-
-	/* audio codec should override the mixer name */
-	if (codec->afg || !*codec->bus->card->mixername)
-		snprintf(codec->bus->card->mixername,
-			 sizeof(codec->bus->card->mixername),
-			 "%s %s", codec->vendor_name, codec->chip_name);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hda_codec_configure);
-
 /* update the stream-id if changed */
 static void update_pcm_stream_id(struct hda_codec *codec,
 				 struct hda_cvt_setup *p, hda_nid_t nid,
@@ -2739,8 +2466,9 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 		}
 	}
 	snd_hda_detach_beep_device(codec);
-	if (codec->patch_ops.free)
-		codec->patch_ops.free(codec);
+	if (device_is_registered(hda_codec_dev(codec)))
+		device_del(hda_codec_dev(codec));
+
 	memset(&codec->patch_ops, 0, sizeof(codec->patch_ops));
 	snd_hda_jack_tbl_clear(codec);
 	codec->proc_widget_hook = NULL;
@@ -2759,9 +2487,6 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 	codec->preset = NULL;
 	codec->slave_dig_outs = NULL;
 	codec->spdif_status_reset = 0;
-	unload_parser(codec);
-	module_put(codec->owner);
-	codec->owner = NULL;
 
 	/* allow device access again */
 	snd_hda_unlock_devices(bus);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 96421a3b32cd..3d42717e0e65 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -174,15 +174,22 @@ struct hda_codec_preset {
 	int (*patch)(struct hda_codec *codec);
 };
 	
-struct hda_codec_preset_list {
+#define HDA_CODEC_ID_GENERIC_HDMI	0x00000101
+#define HDA_CODEC_ID_GENERIC		0x00000201
+
+struct hda_codec_driver {
+	struct device_driver driver;
 	const struct hda_codec_preset *preset;
-	struct module *owner;
-	struct list_head list;
 };
 
-/* initial hook */
-int snd_hda_add_codec_preset(struct hda_codec_preset_list *preset);
-int snd_hda_delete_codec_preset(struct hda_codec_preset_list *preset);
+int __hda_codec_driver_register(struct hda_codec_driver *drv, const char *name,
+			       struct module *owner);
+#define hda_codec_driver_register(drv) \
+	__hda_codec_driver_register(drv, KBUILD_MODNAME, THIS_MODULE)
+void hda_codec_driver_unregister(struct hda_codec_driver *drv);
+#define module_hda_codec_driver(drv) \
+	module_driver(drv, hda_codec_driver_register, \
+		      hda_codec_driver_unregister)
 
 /* ops set by the preset patch */
 struct hda_codec_ops {
@@ -286,11 +293,10 @@ struct hda_codec {
 	u32 vendor_id;
 	u32 subsystem_id;
 	u32 revision_id;
+	u32 probe_id; /* overridden id for probing */
 
 	/* detected preset */
 	const struct hda_codec_preset *preset;
-	struct module *owner;
-	int (*parser)(struct hda_codec *codec);
 	const char *vendor_name;	/* codec vendor name */
 	const char *chip_name;		/* codec chip name */
 	const char *modelname;	/* model name for preset */
@@ -408,6 +414,11 @@ struct hda_codec {
 	struct snd_array verbs;
 };
 
+#define dev_to_hda_codec(_dev)	container_of(_dev, struct hda_codec, dev)
+#define hda_codec_dev(_dev)	(&(_dev)->dev)
+
+extern struct bus_type snd_hda_bus_type;
+
 /* direction */
 enum {
 	HDA_INPUT, HDA_OUTPUT
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b680b4ec6331..947d1a50f384 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5493,13 +5493,11 @@ static const struct hda_codec_ops generic_patch_ops = {
 #endif
 };
 
-/**
+/*
  * snd_hda_parse_generic_codec - Generic codec parser
  * @codec: the HDA codec
- *
- * This should be called from the HDA codec core.
  */
-int snd_hda_parse_generic_codec(struct hda_codec *codec)
+static int snd_hda_parse_generic_codec(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec;
 	int err;
@@ -5525,7 +5523,17 @@ error:
 	snd_hda_gen_free(codec);
 	return err;
 }
-EXPORT_SYMBOL_GPL(snd_hda_parse_generic_codec);
+
+static const struct hda_codec_preset snd_hda_preset_generic[] = {
+	{ .id = HDA_CODEC_ID_GENERIC, .patch = snd_hda_parse_generic_codec },
+	{} /* terminator */
+};
+
+static struct hda_codec_driver generic_driver = {
+	.preset = snd_hda_preset_generic,
+};
+
+module_hda_codec_driver(generic_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic HD-audio codec parser");
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 49c08a7278c4..2f7d9646a41d 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -351,12 +351,6 @@ int snd_hda_multi_out_analog_cleanup(struct hda_codec *codec,
 				     struct hda_multi_out *mout);
 
 /*
- * generic codec parser
- */
-int snd_hda_parse_generic_codec(struct hda_codec *codec);
-int snd_hda_parse_hdmi_codec(struct hda_codec *codec);
-
-/*
  * generic proc interface
  */
 #ifdef CONFIG_PROC_FS
@@ -783,9 +777,13 @@ void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen);
 
 /*
  */
-#define codec_err(codec, fmt, args...) dev_err(&(codec)->dev, fmt, ##args)
-#define codec_warn(codec, fmt, args...) dev_warn(&(codec)->dev, fmt, ##args)
-#define codec_info(codec, fmt, args...) dev_info(&(codec)->dev, fmt, ##args)
-#define codec_dbg(codec, fmt, args...) dev_dbg(&(codec)->dev, fmt, ##args)
+#define codec_err(codec, fmt, args...) \
+	dev_err(hda_codec_dev(codec), fmt, ##args)
+#define codec_warn(codec, fmt, args...) \
+	dev_warn(hda_codec_dev(codec), fmt, ##args)
+#define codec_info(codec, fmt, args...) \
+	dev_info(hda_codec_dev(codec), fmt, ##args)
+#define codec_dbg(codec, fmt, args...) \
+	dev_dbg(hda_codec_dev(codec), fmt, ##args)
 
 #endif /* __SOUND_HDA_LOCAL_H */
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index d285904cdb64..af4c7be86c27 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -1194,20 +1194,8 @@ MODULE_ALIAS("snd-hda-codec-id:11d4*");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Analog Devices HD-audio codec");
 
-static struct hda_codec_preset_list analog_list = {
+static struct hda_codec_driver analog_driver = {
 	.preset = snd_hda_preset_analog,
-	.owner = THIS_MODULE,
 };
 
-static int __init patch_analog_init(void)
-{
-	return snd_hda_add_codec_preset(&analog_list);
-}
-
-static void __exit patch_analog_exit(void)
-{
-	snd_hda_delete_codec_preset(&analog_list);
-}
-
-module_init(patch_analog_init)
-module_exit(patch_analog_exit)
+module_hda_codec_driver(analog_driver);
diff --git a/sound/pci/hda/patch_ca0110.c b/sound/pci/hda/patch_ca0110.c
index 5e65999e0d8e..447302695195 100644
--- a/sound/pci/hda/patch_ca0110.c
+++ b/sound/pci/hda/patch_ca0110.c
@@ -98,20 +98,8 @@ MODULE_ALIAS("snd-hda-codec-id:1102000d");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Creative CA0110-IBG HD-audio codec");
 
-static struct hda_codec_preset_list ca0110_list = {
+static struct hda_codec_driver ca0110_driver = {
 	.preset = snd_hda_preset_ca0110,
-	.owner = THIS_MODULE,
 };
 
-static int __init patch_ca0110_init(void)
-{
-	return snd_hda_add_codec_preset(&ca0110_list);
-}
-
-static void __exit patch_ca0110_exit(void)
-{
-	snd_hda_delete_codec_preset(&ca0110_list);
-}
-
-module_init(patch_ca0110_init)
-module_exit(patch_ca0110_exit)
+module_hda_codec_driver(ca0110_driver);
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index e0383eea9880..81991b4134cd 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4702,20 +4702,8 @@ MODULE_ALIAS("snd-hda-codec-id:11020011");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Creative Sound Core3D codec");
 
-static struct hda_codec_preset_list ca0132_list = {
+static struct hda_codec_driver ca0132_driver = {
 	.preset = snd_hda_preset_ca0132,
-	.owner = THIS_MODULE,
 };
 
-static int __init patch_ca0132_init(void)
-{
-	return snd_hda_add_codec_preset(&ca0132_list);
-}
-
-static void __exit patch_ca0132_exit(void)
-{
-	snd_hda_delete_codec_preset(&ca0132_list);
-}
-
-module_init(patch_ca0132_init)
-module_exit(patch_ca0132_exit)
+module_hda_codec_driver(ca0132_driver);
diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 1589c9bcce3e..1af133933bc0 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -1219,20 +1219,8 @@ MODULE_ALIAS("snd-hda-codec-id:10134213");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cirrus Logic HD-audio codec");
 
-static struct hda_codec_preset_list cirrus_list = {
+static struct hda_codec_driver cirrus_driver = {
 	.preset = snd_hda_preset_cirrus,
-	.owner = THIS_MODULE,
 };
 
-static int __init patch_cirrus_init(void)
-{
-	return snd_hda_add_codec_preset(&cirrus_list);
-}
-
-static void __exit patch_cirrus_exit(void)
-{
-	snd_hda_delete_codec_preset(&cirrus_list);
-}
-
-module_init(patch_cirrus_init)
-module_exit(patch_cirrus_exit)
+module_hda_codec_driver(cirrus_driver);
diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index c895a8f21192..617d9012e78a 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -137,20 +137,8 @@ MODULE_ALIAS("snd-hda-codec-id:434d4980");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("C-Media HD-audio codec");
 
-static struct hda_codec_preset_list cmedia_list = {
+static struct hda_codec_driver cmedia_driver = {
 	.preset = snd_hda_preset_cmedia,
-	.owner = THIS_MODULE,
 };
 
-static int __init patch_cmedia_init(void)
-{
-	return snd_hda_add_codec_preset(&cmedia_list);
-}
-
-static void __exit patch_cmedia_exit(void)
-{
-	snd_hda_delete_codec_preset(&cmedia_list);
-}
-
-module_init(patch_cmedia_init)
-module_exit(patch_cmedia_exit)
+module_hda_codec_driver(cmedia_driver);
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index fd3ed18670e9..15a0a7d38c35 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1007,20 +1007,8 @@ MODULE_ALIAS("snd-hda-codec-id:14f151d7");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Conexant HD-audio codec");
 
-static struct hda_codec_preset_list conexant_list = {
+static struct hda_codec_driver conexant_driver = {
 	.preset = snd_hda_preset_conexant,
-	.owner = THIS_MODULE,
 };
 
-static int __init patch_conexant_init(void)
-{
-	return snd_hda_add_codec_preset(&conexant_list);
-}
-
-static void __exit patch_conexant_exit(void)
-{
-	snd_hda_delete_codec_preset(&conexant_list);
-}
-
-module_init(patch_conexant_init)
-module_exit(patch_conexant_exit)
+module_hda_codec_driver(conexant_driver);
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index b422e406a9cb..f1812aabd63e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3301,15 +3301,6 @@ static int patch_via_hdmi(struct hda_codec *codec)
 }
 
 /*
- * called from hda_codec.c for generic HDMI support
- */
-int snd_hda_parse_hdmi_codec(struct hda_codec *codec)
-{
-	return patch_generic_hdmi(codec);
-}
-EXPORT_SYMBOL_GPL(snd_hda_parse_hdmi_codec);
-
-/*
  * patch entries
  */
 static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
@@ -3373,6 +3364,8 @@ static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
 { .id = 0x80862882, .name = "Valleyview2 HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862883, .name = "Braswell HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x808629fb, .name = "Crestline HDMI",	.patch = patch_generic_hdmi },
+/* special ID for generic HDMI */
+{ .id = HDA_CODEC_ID_GENERIC_HDMI, .patch = patch_generic_hdmi },
 {} /* terminator */
 };
 
@@ -3442,20 +3435,8 @@ MODULE_ALIAS("snd-hda-codec-intelhdmi");
 MODULE_ALIAS("snd-hda-codec-nvhdmi");
 MODULE_ALIAS("snd-hda-codec-atihdmi");
 
-static struct hda_codec_preset_list intel_list = {
+static struct hda_codec_driver hdmi_driver = {
 	.preset = snd_hda_preset_hdmi,
-	.owner = THIS_MODULE,
 };
 
-static int __init patch_hdmi_init(void)
-{
-	return snd_hda_add_codec_preset(&intel_list);
-}
-
-static void __exit patch_hdmi_exit(void)
-{
-	snd_hda_delete_codec_preset(&intel_list);
-}
-
-module_init(patch_hdmi_init)
-module_exit(patch_hdmi_exit)
+module_hda_codec_driver(hdmi_driver);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b2b24a8b3dac..70808f92276a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6514,20 +6514,8 @@ MODULE_ALIAS("snd-hda-codec-id:10ec*");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek HD-audio codec");
 
-static struct hda_codec_preset_list realtek_list = {
+static struct hda_codec_driver realtek_driver = {
 	.preset = snd_hda_preset_realtek,
-	.owner = THIS_MODULE,
 };
 
-static int __init patch_realtek_init(void)
-{
-	return snd_hda_add_codec_preset(&realtek_list);
-}
-
-static void __exit patch_realtek_exit(void)
-{
-	snd_hda_delete_codec_preset(&realtek_list);
-}
-
-module_init(patch_realtek_init)
-module_exit(patch_realtek_exit)
+module_hda_codec_driver(realtek_driver);
diff --git a/sound/pci/hda/patch_si3054.c b/sound/pci/hda/patch_si3054.c
index 3208ad69583e..38a477333321 100644
--- a/sound/pci/hda/patch_si3054.c
+++ b/sound/pci/hda/patch_si3054.c
@@ -319,20 +319,8 @@ MODULE_ALIAS("snd-hda-codec-id:18540018");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Si3054 HD-audio modem codec");
 
-static struct hda_codec_preset_list si3054_list = {
+static struct hda_codec_driver si3054_driver = {
 	.preset = snd_hda_preset_si3054,
-	.owner = THIS_MODULE,
 };
 
-static int __init patch_si3054_init(void)
-{
-	return snd_hda_add_codec_preset(&si3054_list);
-}
-
-static void __exit patch_si3054_exit(void)
-{
-	snd_hda_delete_codec_preset(&si3054_list);
-}
-
-module_init(patch_si3054_init)
-module_exit(patch_si3054_exit)
+module_hda_codec_driver(si3054_driver);
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 87eff3173ce9..6a2163056216 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -5091,20 +5091,8 @@ MODULE_ALIAS("snd-hda-codec-id:111d*");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IDT/Sigmatel HD-audio codec");
 
-static struct hda_codec_preset_list sigmatel_list = {
+static struct hda_codec_driver sigmatel_driver = {
 	.preset = snd_hda_preset_sigmatel,
-	.owner = THIS_MODULE,
 };
 
-static int __init patch_sigmatel_init(void)
-{
-	return snd_hda_add_codec_preset(&sigmatel_list);
-}
-
-static void __exit patch_sigmatel_exit(void)
-{
-	snd_hda_delete_codec_preset(&sigmatel_list);
-}
-
-module_init(patch_sigmatel_init)
-module_exit(patch_sigmatel_exit)
+module_hda_codec_driver(sigmatel_driver);
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 3de6d3d779c9..2045f33b1ace 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1884,23 +1884,11 @@ static const struct hda_codec_preset snd_hda_preset_via[] = {
 
 MODULE_ALIAS("snd-hda-codec-id:1106*");
 
-static struct hda_codec_preset_list via_list = {
+static struct hda_codec_driver via_driver = {
 	.preset = snd_hda_preset_via,
-	.owner = THIS_MODULE,
 };
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("VIA HD-audio codec");
 
-static int __init patch_via_init(void)
-{
-	return snd_hda_add_codec_preset(&via_list);
-}
-
-static void __exit patch_via_exit(void)
-{
-	snd_hda_delete_codec_preset(&via_list);
-}
-
-module_init(patch_via_init)
-module_exit(patch_via_exit)
+module_hda_codec_driver(via_driver);
-- 
2.3.0
