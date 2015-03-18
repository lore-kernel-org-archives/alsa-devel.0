From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/7] ALSA: hda - Move a part of hda_codec stuff
	into hdac_device
Date: Wed, 18 Mar 2015 16:16:33 +0100
Message-ID: <1426691797-17178-4-git-send-email-tiwai@suse.de>
References: <1426691797-17178-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1428F265139
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 16:16:42 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id ABA68ABFB
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

Now some codes and functionalities of hda_codec struct are moved to
hdac_device struct.  A few basic attributes like the codec address,
vendor ID number, FG numbers, etc are moved to hdac_device, and they
are accessed like codec->core.addr.  The basic verb exec functions are
moved, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h         |  66 ++++++
 sound/hda/Makefile              |   2 +-
 sound/hda/hdac_device.c         | 471 ++++++++++++++++++++++++++++++++++++++++
 sound/hda/local.h               |  19 ++
 sound/pci/hda/hda_auto_parser.c |  33 ++-
 sound/pci/hda/hda_beep.c        |   4 +-
 sound/pci/hda/hda_bind.c        |  95 ++------
 sound/pci/hda/hda_codec.c       | 396 +++++----------------------------
 sound/pci/hda/hda_codec.h       |  43 +---
 sound/pci/hda/hda_generic.c     |  25 +--
 sound/pci/hda/hda_local.h       |  15 +-
 sound/pci/hda/hda_proc.c        |  42 ++--
 sound/pci/hda/hda_sysfs.c       |  58 ++---
 sound/pci/hda/local.h           |  39 ++++
 sound/pci/hda/patch_analog.c    |   2 +-
 sound/pci/hda/patch_ca0132.c    |   6 +-
 sound/pci/hda/patch_conexant.c  |  16 +-
 sound/pci/hda/patch_hdmi.c      |  20 +-
 sound/pci/hda/patch_realtek.c   |  78 +++----
 sound/pci/hda/patch_si3054.c    |   6 +-
 sound/pci/hda/patch_sigmatel.c  |  84 +++----
 sound/pci/hda/patch_via.c       |  23 +-
 sound/pci/hda/thinkpad_helper.c |   2 +-
 23 files changed, 880 insertions(+), 665 deletions(-)
 create mode 100644 sound/hda/hdac_device.c
 create mode 100644 sound/hda/local.h
 create mode 100644 sound/pci/hda/local.h

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 848ab6e68099..b81b4bec6f05 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -8,6 +8,9 @@
 #include <linux/device.h>
 #include <sound/hda_verbs.h>
 
+/* codec node id */
+typedef u16 hda_nid_t;
+
 struct hdac_bus;
 struct hdac_device;
 struct hdac_driver;
@@ -26,6 +29,30 @@ struct hdac_device {
 	struct hdac_bus *bus;
 	unsigned int addr;		/* codec address */
 	struct list_head list;		/* list point for bus codec_list */
+
+	hda_nid_t afg;			/* AFG node id */
+	hda_nid_t mfg;			/* MFG node id */
+
+	/* ids */
+	unsigned int vendor_id;
+	unsigned int subsystem_id;
+	unsigned int revision_id;
+	unsigned int afg_function_id;
+	unsigned int mfg_function_id;
+	unsigned int afg_unsol:1;
+	unsigned int mfg_unsol:1;
+
+	unsigned int power_caps;	/* FG power caps */
+
+	const char *vendor_name;	/* codec vendor name */
+	const char *chip_name;		/* codec chip name */
+
+	/* widgets */
+	unsigned int num_nodes;
+	hda_nid_t start_nid, end_nid;
+
+	/* misc flags */
+	atomic_t in_pm;		/* suspend/resume being performed */
 };
 
 /* device/driver type used for matching */
@@ -34,8 +61,37 @@ enum {
 	HDA_DEV_LEGACY,
 };
 
+/* direction */
+enum {
+	HDA_INPUT, HDA_OUTPUT
+};
+
 #define dev_to_hdac_dev(_dev)	container_of(_dev, struct hdac_device, dev)
 
+int snd_hdac_device_init(struct hdac_device *dev, struct hdac_bus *bus,
+			 const char *name, unsigned int addr);
+void snd_hdac_device_exit(struct hdac_device *dev);
+
+int snd_hdac_refresh_widgets(struct hdac_device *codec);
+
+unsigned int snd_hdac_make_cmd(struct hdac_device *codec, hda_nid_t nid,
+			       unsigned int verb, unsigned int parm);
+int snd_hdac_read(struct hdac_device *codec, hda_nid_t nid,
+		  unsigned int verb, unsigned int parm, unsigned int *res);
+int snd_hdac_read_parm(struct hdac_device *codec, hda_nid_t nid, int parm);
+int snd_hdac_get_connections(struct hdac_device *codec, hda_nid_t nid,
+			     hda_nid_t *conn_list, int max_conns);
+int snd_hdac_get_sub_nodes(struct hdac_device *codec, hda_nid_t nid,
+			   hda_nid_t *start_id);
+
+#ifdef CONFIG_PM
+void snd_hdac_power_up(struct hdac_device *codec);
+void snd_hdac_power_down(struct hdac_device *codec);
+#else
+static inline void snd_hdac_power_up(struct hdac_device *codec) {}
+static inline void snd_hdac_power_down(struct hdac_device *codec) {}
+#endif
+
 /*
  * HD-audio codec base driver
  */
@@ -100,4 +156,14 @@ int snd_hdac_bus_add_device(struct hdac_bus *bus, struct hdac_device *codec);
 void snd_hdac_bus_remove_device(struct hdac_bus *bus,
 				struct hdac_device *codec);
 
+static inline void snd_hdac_codec_link_up(struct hdac_device *codec)
+{
+	set_bit(codec->addr, &codec->bus->codec_powered);
+}
+
+static inline void snd_hdac_codec_link_down(struct hdac_device *codec)
+{
+	clear_bit(codec->addr, &codec->bus->codec_powered);
+}
+
 #endif /* __SOUND_HDAUDIO_H */
diff --git a/sound/hda/Makefile b/sound/hda/Makefile
index 828680b282fa..3c7625e595cf 100644
--- a/sound/hda/Makefile
+++ b/sound/hda/Makefile
@@ -1,3 +1,3 @@
-snd-hda-core-objs := hda_bus_type.o hdac_bus.o
+snd-hda-core-objs := hda_bus_type.o hdac_bus.o hdac_device.o
 
 obj-$(CONFIG_SND_HDA_CORE) += snd-hda-core.o
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
new file mode 100644
index 000000000000..a3f52ad4de37
--- /dev/null
+++ b/sound/hda/hdac_device.c
@@ -0,0 +1,471 @@
+/*
+ * HD-audio codec core device
+ */
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/pm_runtime.h>
+#include <sound/hdaudio.h>
+#include "local.h"
+
+static void setup_fg_nodes(struct hdac_device *codec);
+static int get_codec_vendor_name(struct hdac_device *codec);
+
+static void default_release(struct device *dev)
+{
+	snd_hdac_device_exit(container_of(dev, struct hdac_device, dev));
+}
+
+/**
+ * snd_hdac_device_init - initialize the HD-audio codec base device
+ * @codec: device to initialize
+ * @bus: but to attach
+ * @name: device name string
+ * @addr: codec address
+ *
+ * Returns zero for success or a negative error code.
+ *
+ * This function increments the runtime PM counter and marks it active.
+ * The caller needs to turn it off appropriately later.
+ *
+ * The caller needs to set the device's release op properly by itself.
+ */
+int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
+			 const char *name, unsigned int addr)
+{
+	struct device *dev;
+	hda_nid_t fg;
+	int err;
+
+	dev = &codec->dev;
+	device_initialize(dev);
+	dev->parent = bus->dev;
+	dev->bus = &snd_hda_bus_type;
+	dev->release = default_release;
+	dev_set_name(dev, "%s", name);
+	device_enable_async_suspend(dev);
+
+	codec->bus = bus;
+	codec->addr = addr;
+	codec->type = HDA_DEV_CORE;
+	pm_runtime_set_active(&codec->dev);
+	pm_runtime_get_noresume(&codec->dev);
+	atomic_set(&codec->in_pm, 0);
+
+	err = snd_hdac_bus_add_device(bus, codec);
+	if (err < 0)
+		goto error;
+
+	/* fill parameters */
+	codec->vendor_id = snd_hdac_read_parm(codec, AC_NODE_ROOT,
+					      AC_PAR_VENDOR_ID);
+	if (codec->vendor_id == -1) {
+		/* read again, hopefully the access method was corrected
+		 * in the last read...
+		 */
+		codec->vendor_id = snd_hdac_read_parm(codec, AC_NODE_ROOT,
+						      AC_PAR_VENDOR_ID);
+	}
+
+	codec->subsystem_id = snd_hdac_read_parm(codec, AC_NODE_ROOT,
+						 AC_PAR_SUBSYSTEM_ID);
+	codec->revision_id = snd_hdac_read_parm(codec, AC_NODE_ROOT,
+						AC_PAR_REV_ID);
+
+	setup_fg_nodes(codec);
+	if (!codec->afg && !codec->mfg) {
+		dev_err(dev, "no AFG or MFG node found\n");
+		err = -ENODEV;
+		goto error;
+	}
+
+	fg = codec->afg ? codec->afg : codec->mfg;
+
+	err = snd_hdac_refresh_widgets(codec);
+	if (err < 0)
+		goto error;
+
+	codec->power_caps = snd_hdac_read_parm(codec, fg, AC_PAR_POWER_STATE);
+	/* reread ssid if not set by parameter */
+	if (codec->subsystem_id == -1)
+		snd_hdac_read(codec, fg, AC_VERB_GET_SUBSYSTEM_ID, 0,
+			      &codec->subsystem_id);
+
+	err = get_codec_vendor_name(codec);
+	if (err < 0)
+		goto error;
+
+	codec->chip_name = kasprintf(GFP_KERNEL, "ID %x",
+				     codec->vendor_id & 0xffff);
+	if (!codec->chip_name) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	return 0;
+
+ error:
+	pm_runtime_put_noidle(&codec->dev);
+	put_device(&codec->dev);
+	return err;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_device_init);
+
+/**
+ * snd_hdac_device_exit - clean up the HD-audio codec base device
+ * @codec: device to clean up
+ */
+void snd_hdac_device_exit(struct hdac_device *codec)
+{
+	/* pm_runtime_put_noidle(&codec->dev); */
+	snd_hdac_bus_remove_device(codec->bus, codec);
+	kfree(codec->vendor_name);
+	kfree(codec->chip_name);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_device_exit);
+
+/**
+ * snd_hdac_make_cmd - compose a 32bit command word to be sent to the
+ *	HD-audio controller
+ * @codec: the codec object
+ * @nid: NID to encode
+ * @verb: verb to encode
+ * @parm: parameter to encode
+ *
+ * Return an encoded command verb or -1 for error.
+ */
+unsigned int snd_hdac_make_cmd(struct hdac_device *codec, hda_nid_t nid,
+			       unsigned int verb, unsigned int parm)
+{
+	u32 val, addr;
+
+	addr = codec->addr;
+	if ((addr & ~0xf) || (nid & ~0x7f) ||
+	    (verb & ~0xfff) || (parm & ~0xffff)) {
+		dev_err(&codec->dev, "out of range cmd %x:%x:%x:%x\n",
+			addr, nid, verb, parm);
+		return -1;
+	}
+
+	val = addr << 28;
+	val |= (u32)nid << 20;
+	val |= verb << 8;
+	val |= parm;
+	return val;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_make_cmd);
+
+/**
+ * snd_hdac_read - execute a verb
+ * @codec: the codec object
+ * @nid: NID to execute a verb
+ * @verb: verb to execute
+ * @parm: parameter for a verb
+ * @res: the pointer to store the result, NULL if running async
+ *
+ * Returns zero if successful, or a negative error code.
+ */
+int snd_hdac_read(struct hdac_device *codec, hda_nid_t nid,
+		  unsigned int verb, unsigned int parm, unsigned int *res)
+{
+	unsigned int cmd = snd_hdac_make_cmd(codec, nid, verb, parm);
+
+	return snd_hdac_bus_exec_verb(codec->bus, codec->addr, cmd, res);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_read);
+
+/**
+ * snd_hdac_read_parm - read a codec parameter
+ * @codec: the codec object
+ * @nid: NID to read a parameter
+ * @parm: parameter to read
+ *
+ * Returns -1 for error.  If you need to distinguish the error more
+ * strictly, use snd_hdac_read() directly.
+ */
+int snd_hdac_read_parm(struct hdac_device *codec, hda_nid_t nid, int parm)
+{
+	int val;
+
+	if (snd_hdac_read(codec, nid, AC_VERB_PARAMETERS, parm, &val))
+		return -1;
+	return val;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_read_parm);
+
+/**
+ * snd_hdac_get_sub_nodes - get start NID and number of subtree nodes
+ * @codec: the codec object
+ * @nid: NID to inspect
+ * @start_id: the pointer to store the starting NID
+ *
+ * Returns the number of subtree nodes or zero if not found.
+ */
+int snd_hdac_get_sub_nodes(struct hdac_device *codec, hda_nid_t nid,
+			   hda_nid_t *start_id)
+{
+	unsigned int parm;
+
+	parm = snd_hdac_read_parm(codec, nid, AC_PAR_NODE_COUNT);
+	if (parm == -1) {
+		*start_id = 0;
+		return 0;
+	}
+	*start_id = (parm >> 16) & 0x7fff;
+	return (int)(parm & 0x7fff);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_get_sub_nodes);
+
+/*
+ * look for an AFG and MFG nodes
+ */
+static void setup_fg_nodes(struct hdac_device *codec)
+{
+	int i, total_nodes, function_id;
+	hda_nid_t nid;
+
+	total_nodes = snd_hdac_get_sub_nodes(codec, AC_NODE_ROOT, &nid);
+	for (i = 0; i < total_nodes; i++, nid++) {
+		function_id = snd_hdac_read_parm(codec, nid,
+						 AC_PAR_FUNCTION_TYPE);
+		switch (function_id & 0xff) {
+		case AC_GRP_AUDIO_FUNCTION:
+			codec->afg = nid;
+			codec->afg_function_id = function_id & 0xff;
+			codec->afg_unsol = (function_id >> 8) & 1;
+			break;
+		case AC_GRP_MODEM_FUNCTION:
+			codec->mfg = nid;
+			codec->mfg_function_id = function_id & 0xff;
+			codec->mfg_unsol = (function_id >> 8) & 1;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+/**
+ * snd_hdac_refresh_widgets - Reset the widget start/end nodes
+ * @codec: the codec object
+ */
+int snd_hdac_refresh_widgets(struct hdac_device *codec)
+{
+	hda_nid_t start_nid;
+	int nums;
+
+	nums = snd_hdac_get_sub_nodes(codec, codec->afg, &start_nid);
+	if (!start_nid || nums <= 0 || nums >= 0xff) {
+		dev_err(&codec->dev, "cannot read sub nodes for FG 0x%02x\n",
+			codec->afg);
+		return -EINVAL;
+	}
+
+	codec->num_nodes = nums;
+	codec->start_nid = start_nid;
+	codec->end_nid = start_nid + nums;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_refresh_widgets);
+
+/* return CONNLIST_LEN parameter of the given widget */
+static unsigned int get_num_conns(struct hdac_device *codec, hda_nid_t nid)
+{
+	unsigned int wcaps = get_wcaps(codec, nid);
+	unsigned int parm;
+
+	if (!(wcaps & AC_WCAP_CONN_LIST) &&
+	    get_wcaps_type(wcaps) != AC_WID_VOL_KNB)
+		return 0;
+
+	parm = snd_hdac_read_parm(codec, nid, AC_PAR_CONNLIST_LEN);
+	if (parm == -1)
+		parm = 0;
+	return parm;
+}
+
+/**
+ * snd_hdac_get_connections - get a widget connection list
+ * @codec: the codec object
+ * @nid: NID
+ * @conn_list: the array to store the results, can be NULL
+ * @max_conns: the max size of the given array
+ *
+ * Returns the number of connected widgets, zero for no connection, or a
+ * negative error code.  When the number of elements don't fit with the
+ * given array size, it returns -ENOSPC.
+ *
+ * When @conn_list is NULL, it just checks the number of connections.
+ */
+int snd_hdac_get_connections(struct hdac_device *codec, hda_nid_t nid,
+			     hda_nid_t *conn_list, int max_conns)
+{
+	unsigned int parm;
+	int i, conn_len, conns, err;
+	unsigned int shift, num_elems, mask;
+	hda_nid_t prev_nid;
+	int null_count = 0;
+
+	parm = get_num_conns(codec, nid);
+	if (!parm)
+		return 0;
+
+	if (parm & AC_CLIST_LONG) {
+		/* long form */
+		shift = 16;
+		num_elems = 2;
+	} else {
+		/* short form */
+		shift = 8;
+		num_elems = 4;
+	}
+	conn_len = parm & AC_CLIST_LENGTH;
+	mask = (1 << (shift-1)) - 1;
+
+	if (!conn_len)
+		return 0; /* no connection */
+
+	if (conn_len == 1) {
+		/* single connection */
+		err = snd_hdac_read(codec, nid, AC_VERB_GET_CONNECT_LIST, 0,
+				    &parm);
+		if (err < 0)
+			return err;
+		if (conn_list)
+			conn_list[0] = parm & mask;
+		return 1;
+	}
+
+	/* multi connection */
+	conns = 0;
+	prev_nid = 0;
+	for (i = 0; i < conn_len; i++) {
+		int range_val;
+		hda_nid_t val, n;
+
+		if (i % num_elems == 0) {
+			err = snd_hdac_read(codec, nid,
+					    AC_VERB_GET_CONNECT_LIST, i,
+					    &parm);
+			if (err < 0)
+				return -EIO;
+		}
+		range_val = !!(parm & (1 << (shift-1))); /* ranges */
+		val = parm & mask;
+		if (val == 0 && null_count++) {  /* no second chance */
+			dev_dbg(&codec->dev,
+				"invalid CONNECT_LIST verb %x[%i]:%x\n",
+				nid, i, parm);
+			return 0;
+		}
+		parm >>= shift;
+		if (range_val) {
+			/* ranges between the previous and this one */
+			if (!prev_nid || prev_nid >= val) {
+				dev_warn(&codec->dev,
+					 "invalid dep_range_val %x:%x\n",
+					 prev_nid, val);
+				continue;
+			}
+			for (n = prev_nid + 1; n <= val; n++) {
+				if (conn_list) {
+					if (conns >= max_conns)
+						return -ENOSPC;
+					conn_list[conns] = n;
+				}
+				conns++;
+			}
+		} else {
+			if (conn_list) {
+				if (conns >= max_conns)
+					return -ENOSPC;
+				conn_list[conns] = val;
+			}
+			conns++;
+		}
+		prev_nid = val;
+	}
+	return conns;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_get_connections);
+
+#ifdef CONFIG_PM
+/**
+ * snd_hdac_power_up - increment the runtime pm counter
+ * @codec: the codec object
+ */
+void snd_hdac_power_up(struct hdac_device *codec)
+{
+	struct device *dev = &codec->dev;
+
+	if (atomic_read(&codec->in_pm))
+		return;
+	pm_runtime_get_sync(dev);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_power_up);
+
+/**
+ * snd_hdac_power_up - decrement the runtime pm counter
+ * @codec: the codec object
+ */
+void snd_hdac_power_down(struct hdac_device *codec)
+{
+	struct device *dev = &codec->dev;
+
+	if (atomic_read(&codec->in_pm))
+		return;
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_power_down);
+#endif
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
+/* store the codec vendor name */
+static int get_codec_vendor_name(struct hdac_device *codec)
+{
+	const struct hda_vendor_id *c;
+	u16 vendor_id = codec->vendor_id >> 16;
+
+	for (c = hda_vendor_ids; c->id; c++) {
+		if (c->id == vendor_id) {
+			codec->vendor_name = kstrdup(c->name, GFP_KERNEL);
+			return codec->vendor_name ? 0 : -ENOMEM;
+		}
+	}
+
+	codec->vendor_name = kasprintf(GFP_KERNEL, "Generic %04x", vendor_id);
+	return codec->vendor_name ? 0 : -ENOMEM;
+}
diff --git a/sound/hda/local.h b/sound/hda/local.h
new file mode 100644
index 000000000000..a077d1f656f6
--- /dev/null
+++ b/sound/hda/local.h
@@ -0,0 +1,19 @@
+/*
+ * Local helper macros and functions for HD-audio core drivers
+ */
+
+#ifndef __HDAC_LOCAL_H
+#define __HDAC_LOCAL_H
+
+#define get_wcaps(codec, nid) \
+	snd_hdac_read_parm(codec, nid, AC_PAR_AUDIO_WIDGET_CAP)
+
+/* get the widget type from widget capability bits */
+static inline int get_wcaps_type(unsigned int wcaps)
+{
+	if (!wcaps)
+		return -1; /* invalid type */
+	return (wcaps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
+}
+
+#endif /* __HDAC_LOCAL_H */
diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 3f8706bb3d16..03b7399bb7f0 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -172,7 +172,7 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 			     const hda_nid_t *ignore_nids,
 			     unsigned int cond_flags)
 {
-	hda_nid_t nid, end_nid;
+	hda_nid_t nid;
 	short seq, assoc_line_out;
 	struct auto_out_pin line_out[ARRAY_SIZE(cfg->line_out_pins)];
 	struct auto_out_pin speaker_out[ARRAY_SIZE(cfg->speaker_pins)];
@@ -189,8 +189,7 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 	memset(hp_out, 0, sizeof(hp_out));
 	assoc_line_out = 0;
 
-	end_nid = codec->start_nid + codec->num_nodes;
-	for (nid = codec->start_nid; nid < end_nid; nid++) {
+	for_each_hda_codec_node(nid, codec) {
 		unsigned int wid_caps = get_wcaps(codec, nid);
 		unsigned int wid_type = get_wcaps_type(wid_caps);
 		unsigned int def_conf;
@@ -410,7 +409,7 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 	 * debug prints of the parsed results
 	 */
 	codec_info(codec, "autoconfig for %s: line_outs=%d (0x%x/0x%x/0x%x/0x%x/0x%x) type:%s\n",
-		   codec->chip_name, cfg->line_outs, cfg->line_out_pins[0],
+		   codec->core.chip_name, cfg->line_outs, cfg->line_out_pins[0],
 		   cfg->line_out_pins[1], cfg->line_out_pins[2],
 		   cfg->line_out_pins[3], cfg->line_out_pins[4],
 		   cfg->line_out_type == AUTO_PIN_HP_OUT ? "hp" :
@@ -836,33 +835,33 @@ static void apply_fixup(struct hda_codec *codec, int id, int action, int depth)
 			if (action != HDA_FIXUP_ACT_PRE_PROBE || !fix->v.pins)
 				break;
 			codec_dbg(codec, "%s: Apply pincfg for %s\n",
-				    codec->chip_name, modelname);
+				    codec->core.chip_name, modelname);
 			snd_hda_apply_pincfgs(codec, fix->v.pins);
 			break;
 		case HDA_FIXUP_VERBS:
 			if (action != HDA_FIXUP_ACT_PROBE || !fix->v.verbs)
 				break;
 			codec_dbg(codec, "%s: Apply fix-verbs for %s\n",
-				    codec->chip_name, modelname);
+				    codec->core.chip_name, modelname);
 			snd_hda_add_verbs(codec, fix->v.verbs);
 			break;
 		case HDA_FIXUP_FUNC:
 			if (!fix->v.func)
 				break;
 			codec_dbg(codec, "%s: Apply fix-func for %s\n",
-				    codec->chip_name, modelname);
+				    codec->core.chip_name, modelname);
 			fix->v.func(codec, fix, action);
 			break;
 		case HDA_FIXUP_PINCTLS:
 			if (action != HDA_FIXUP_ACT_PROBE || !fix->v.pins)
 				break;
 			codec_dbg(codec, "%s: Apply pinctl for %s\n",
-				    codec->chip_name, modelname);
+				    codec->core.chip_name, modelname);
 			set_pin_targets(codec, fix->v.pins);
 			break;
 		default:
 			codec_err(codec, "%s: Invalid fixup type %d\n",
-				   codec->chip_name, fix->type);
+				   codec->core.chip_name, fix->type);
 			break;
 		}
 		if (!fix->chained || fix->chained_before)
@@ -912,16 +911,16 @@ void snd_hda_pick_pin_fixup(struct hda_codec *codec,
 		return;
 
 	for (pq = pin_quirk; pq->subvendor; pq++) {
-		if ((codec->subsystem_id & 0xffff0000) != (pq->subvendor << 16))
+		if ((codec->core.subsystem_id & 0xffff0000) != (pq->subvendor << 16))
 			continue;
-		if (codec->vendor_id != pq->codec)
+		if (codec->core.vendor_id != pq->codec)
 			continue;
 		if (pin_config_match(codec, pq->pins)) {
 			codec->fixup_id = pq->value;
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 			codec->fixup_name = pq->name;
 			codec_dbg(codec, "%s: picked fixup %s (pin match)\n",
-				  codec->chip_name, codec->fixup_name);
+				  codec->core.chip_name, codec->fixup_name);
 #endif
 			codec->fixup_list = fixlist;
 			return;
@@ -963,7 +962,7 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 		codec->fixup_name = NULL;
 		codec->fixup_id = HDA_FIXUP_ID_NO_FIXUP;
 		codec_dbg(codec, "%s: picked no fixup (nofixup specified)\n",
-			  codec->chip_name);
+			  codec->core.chip_name);
 		return;
 	}
 
@@ -974,7 +973,7 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 				codec->fixup_name = models->name;
 				codec->fixup_list = fixlist;
 				codec_dbg(codec, "%s: picked fixup %s (model specified)\n",
-					  codec->chip_name, codec->fixup_name);
+					  codec->core.chip_name, codec->fixup_name);
 				return;
 			}
 			models++;
@@ -987,7 +986,7 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 			name = q->name;
 			codec_dbg(codec, "%s: picked fixup %s (PCI SSID%s)\n",
-				  codec->chip_name, name, q->subdevice_mask ? "" : " - vendor generic");
+				  codec->core.chip_name, name, q->subdevice_mask ? "" : " - vendor generic");
 #endif
 		}
 	}
@@ -996,12 +995,12 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 			unsigned int vendorid =
 				q->subdevice | (q->subvendor << 16);
 			unsigned int mask = 0xffff0000 | q->subdevice_mask;
-			if ((codec->subsystem_id & mask) == (vendorid & mask)) {
+			if ((codec->core.subsystem_id & mask) == (vendorid & mask)) {
 				id = q->value;
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 				name = q->name;
 				codec_dbg(codec, "%s: picked fixup %s (codec SSID)\n",
-					  codec->chip_name, name);
+					  codec->core.chip_name, name);
 #endif
 				break;
 			}
diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 4cdac3a71cae..3364dc0fdeab 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -165,8 +165,8 @@ static int snd_hda_do_attach(struct hda_beep *beep)
 	input_dev->id.bustype = BUS_PCI;
 	input_dev->dev.parent = &codec->card->card_dev;
 
-	input_dev->id.vendor = codec->vendor_id >> 16;
-	input_dev->id.product = codec->vendor_id & 0xffff;
+	input_dev->id.vendor = codec->core.vendor_id >> 16;
+	input_dev->id.product = codec->core.vendor_id & 0xffff;
 	input_dev->id.version = 0x01;
 
 	input_dev->evbit[0] = BIT_MASK(EV_SND);
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 0b9ea70c546b..ad276a9771db 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -14,36 +14,6 @@
 #include "hda_codec.h"
 #include "hda_local.h"
 
-/* codec vendor labels */
-struct hda_vendor_id {
-	unsigned int id;
-	const char *name;
-};
-
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
 /*
  * find a matching codec preset
  */
@@ -54,19 +24,19 @@ static int hda_codec_match(struct hdac_device *dev, struct hdac_driver *drv)
 		container_of(drv, struct hda_codec_driver, core);
 	const struct hda_codec_preset *preset;
 	/* check probe_id instead of vendor_id if set */
-	u32 id = codec->probe_id ? codec->probe_id : codec->vendor_id;
+	u32 id = codec->probe_id ? codec->probe_id : codec->core.vendor_id;
 
 	for (preset = driver->preset; preset->id; preset++) {
 		u32 mask = preset->mask;
 
-		if (preset->afg && preset->afg != codec->afg)
+		if (preset->afg && preset->afg != codec->core.afg)
 			continue;
-		if (preset->mfg && preset->mfg != codec->mfg)
+		if (preset->mfg && preset->mfg != codec->core.mfg)
 			continue;
 		if (!mask)
 			mask = ~0;
 		if (preset->id == (id & mask) &&
-		    (!preset->rev || preset->rev == codec->revision_id)) {
+		    (!preset->rev || preset->rev == codec->core.revision_id)) {
 			codec->preset = preset;
 			return 1;
 		}
@@ -86,15 +56,11 @@ static void hda_codec_unsol_event(struct hdac_device *dev, unsigned int ev)
 /* reset the codec name from the preset */
 static int codec_refresh_name(struct hda_codec *codec, const char *name)
 {
-	char tmp[16];
-
-	kfree(codec->chip_name);
-	if (!name) {
-		sprintf(tmp, "ID %x", codec->vendor_id & 0xffff);
-		name = tmp;
+	if (name) {
+		kfree(codec->core.chip_name);
+		codec->core.chip_name = kstrdup(name, GFP_KERNEL);
 	}
-	codec->chip_name = kstrdup(name, GFP_KERNEL);
-	return codec->chip_name ? 0 : -ENOMEM;
+	return codec->core.chip_name ? 0 : -ENOMEM;
 }
 
 static int hda_codec_driver_probe(struct device *dev)
@@ -192,48 +158,23 @@ static inline bool codec_probed(struct hda_codec *codec)
 static void codec_bind_module(struct hda_codec *codec)
 {
 #ifdef MODULE
-	request_module("snd-hda-codec-id:%08x", codec->vendor_id);
+	request_module("snd-hda-codec-id:%08x", codec->core.vendor_id);
 	if (codec_probed(codec))
 		return;
 	request_module("snd-hda-codec-id:%04x*",
-		       (codec->vendor_id >> 16) & 0xffff);
+		       (codec->core.vendor_id >> 16) & 0xffff);
 	if (codec_probed(codec))
 		return;
 #endif
 }
 
-/* store the codec vendor name */
-static int get_codec_vendor_name(struct hda_codec *codec)
-{
-	const struct hda_vendor_id *c;
-	const char *vendor = NULL;
-	u16 vendor_id = codec->vendor_id >> 16;
-	char tmp[16];
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
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
 /* if all audio out widgets are digital, let's assume the codec as a HDMI/DP */
 static bool is_likely_hdmi_codec(struct hda_codec *codec)
 {
-	hda_nid_t nid = codec->start_nid;
-	int i;
+	hda_nid_t nid;
 
-	for (i = 0; i < codec->num_nodes; i++, nid++) {
+	for_each_hda_codec_node(nid, codec) {
 		unsigned int wcaps = get_wcaps(codec, nid);
 		switch (get_wcaps_type(wcaps)) {
 		case AC_WID_AUD_IN:
@@ -294,12 +235,6 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 {
 	int err;
 
-	if (!codec->vendor_name) {
-		err = get_codec_vendor_name(codec);
-		if (err < 0)
-			return err;
-	}
-
 	if (is_generic_config(codec))
 		codec->probe_id = HDA_CODEC_ID_GENERIC;
 	else
@@ -320,10 +255,10 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 	}
 
 	/* audio codec should override the mixer name */
-	if (codec->afg || !*codec->card->mixername)
+	if (codec->core.afg || !*codec->card->mixername)
 		snprintf(codec->card->mixername,
-			 sizeof(codec->card->mixername),
-			 "%s %s", codec->vendor_name, codec->chip_name);
+			 sizeof(codec->card->mixername), "%s %s",
+			 codec->core.vendor_name, codec->core.chip_name);
 	return 0;
 
  error:
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index f96bff37c787..ddfc0fbbee23 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -40,7 +40,7 @@
 #include <sound/hda_hwdep.h>
 
 #ifdef CONFIG_PM
-#define codec_in_pm(codec)	atomic_read(&(codec)->in_pm)
+#define codec_in_pm(codec)	atomic_read(&(codec)->core.in_pm)
 #define hda_codec_is_power_on(codec) \
 	(!pm_runtime_suspended(hda_codec_dev(codec)))
 #else
@@ -48,6 +48,11 @@
 #define hda_codec_is_power_on(codec)	1
 #endif
 
+#define codec_has_epss(codec) \
+	((codec)->core.power_caps & AC_PWRST_EPSS)
+#define codec_has_clkstop(codec) \
+	((codec)->core.power_caps & AC_PWRST_CLKSTOP)
+
 /**
  * snd_hda_get_jack_location - Give a location string of the jack
  * @cfg: pin default config value
@@ -119,30 +124,6 @@ const char *snd_hda_get_jack_type(u32 cfg)
 EXPORT_SYMBOL_GPL(snd_hda_get_jack_type);
 
 /*
- * Compose a 32bit command word to be sent to the HD-audio controller
- */
-static inline unsigned int
-make_codec_cmd(struct hda_codec *codec, hda_nid_t nid, int flags,
-	       unsigned int verb, unsigned int parm)
-{
-	unsigned int addr = codec->core.addr;
-	u32 val;
-
-	if ((addr & ~0xf) || (nid & ~0x7f) ||
-	    (verb & ~0xfff) || (parm & ~0xffff)) {
-		codec_err(codec, "hda-codec: out of range cmd %x:%x:%x:%x\n",
-			  addr, nid, verb, parm);
-		return ~0;
-	}
-
-	val = (u32)addr << 28;
-	val |= (u32)nid << 20;
-	val |= verb << 8;
-	val |= parm;
-	return val;
-}
-
-/*
  * Send and receive a verb
  */
 static int codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
@@ -194,7 +175,7 @@ unsigned int snd_hda_codec_read(struct hda_codec *codec, hda_nid_t nid,
 				int flags,
 				unsigned int verb, unsigned int parm)
 {
-	unsigned cmd = make_codec_cmd(codec, nid, flags, verb, parm);
+	unsigned int cmd = snd_hdac_make_cmd(&codec->core, nid, verb, parm);
 	unsigned int res;
 	if (codec_exec_verb(codec, cmd, flags, &res))
 		return -1;
@@ -217,7 +198,7 @@ EXPORT_SYMBOL_GPL(snd_hda_codec_read);
 int snd_hda_codec_write(struct hda_codec *codec, hda_nid_t nid, int flags,
 			unsigned int verb, unsigned int parm)
 {
-	unsigned int cmd = make_codec_cmd(codec, nid, flags, verb, parm);
+	unsigned int cmd = snd_hdac_make_cmd(&codec->core, nid, verb, parm);
 	return codec_exec_verb(codec, cmd, flags, NULL);
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_write);
@@ -237,30 +218,6 @@ void snd_hda_sequence_write(struct hda_codec *codec, const struct hda_verb *seq)
 }
 EXPORT_SYMBOL_GPL(snd_hda_sequence_write);
 
-/**
- * snd_hda_get_sub_nodes - get the range of sub nodes
- * @codec: the HDA codec
- * @nid: NID to parse
- * @start_id: the pointer to store the start NID
- *
- * Parse the NID and store the start NID of its sub-nodes.
- * Returns the number of sub-nodes.
- */
-int snd_hda_get_sub_nodes(struct hda_codec *codec, hda_nid_t nid,
-			  hda_nid_t *start_id)
-{
-	unsigned int parm;
-
-	parm = snd_hda_param_read(codec, nid, AC_PAR_NODE_COUNT);
-	if (parm == -1) {
-		*start_id = 0;
-		return 0;
-	}
-	*start_id = (parm >> 16) & 0x7fff;
-	return (int)(parm & 0x7fff);
-}
-EXPORT_SYMBOL_GPL(snd_hda_get_sub_nodes);
-
 /* connection list element */
 struct hda_conn_list {
 	struct list_head list;
@@ -401,128 +358,6 @@ int snd_hda_get_connections(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_get_connections);
 
-/* return CONNLIST_LEN parameter of the given widget */
-static unsigned int get_num_conns(struct hda_codec *codec, hda_nid_t nid)
-{
-	unsigned int wcaps = get_wcaps(codec, nid);
-	unsigned int parm;
-
-	if (!(wcaps & AC_WCAP_CONN_LIST) &&
-	    get_wcaps_type(wcaps) != AC_WID_VOL_KNB)
-		return 0;
-
-	parm = snd_hda_param_read(codec, nid, AC_PAR_CONNLIST_LEN);
-	if (parm == -1)
-		parm = 0;
-	return parm;
-}
-
-int snd_hda_get_num_raw_conns(struct hda_codec *codec, hda_nid_t nid)
-{
-	return snd_hda_get_raw_connections(codec, nid, NULL, 0);
-}
-
-/**
- * snd_hda_get_raw_connections - copy connection list without cache
- * @codec: the HDA codec
- * @nid: NID to parse
- * @conn_list: connection list array
- * @max_conns: max. number of connections to store
- *
- * Like snd_hda_get_connections(), copy the connection list but without
- * checking through the connection-list cache.
- * Currently called only from hda_proc.c, so not exported.
- */
-int snd_hda_get_raw_connections(struct hda_codec *codec, hda_nid_t nid,
-				hda_nid_t *conn_list, int max_conns)
-{
-	unsigned int parm;
-	int i, conn_len, conns;
-	unsigned int shift, num_elems, mask;
-	hda_nid_t prev_nid;
-	int null_count = 0;
-
-	parm = get_num_conns(codec, nid);
-	if (!parm)
-		return 0;
-
-	if (parm & AC_CLIST_LONG) {
-		/* long form */
-		shift = 16;
-		num_elems = 2;
-	} else {
-		/* short form */
-		shift = 8;
-		num_elems = 4;
-	}
-	conn_len = parm & AC_CLIST_LENGTH;
-	mask = (1 << (shift-1)) - 1;
-
-	if (!conn_len)
-		return 0; /* no connection */
-
-	if (conn_len == 1) {
-		/* single connection */
-		parm = snd_hda_codec_read(codec, nid, 0,
-					  AC_VERB_GET_CONNECT_LIST, 0);
-		if (parm == -1 && codec->bus->rirb_error)
-			return -EIO;
-		if (conn_list)
-			conn_list[0] = parm & mask;
-		return 1;
-	}
-
-	/* multi connection */
-	conns = 0;
-	prev_nid = 0;
-	for (i = 0; i < conn_len; i++) {
-		int range_val;
-		hda_nid_t val, n;
-
-		if (i % num_elems == 0) {
-			parm = snd_hda_codec_read(codec, nid, 0,
-						  AC_VERB_GET_CONNECT_LIST, i);
-			if (parm == -1 && codec->bus->rirb_error)
-				return -EIO;
-		}
-		range_val = !!(parm & (1 << (shift-1))); /* ranges */
-		val = parm & mask;
-		if (val == 0 && null_count++) {  /* no second chance */
-			codec_dbg(codec,
-				  "invalid CONNECT_LIST verb %x[%i]:%x\n",
-				    nid, i, parm);
-			return 0;
-		}
-		parm >>= shift;
-		if (range_val) {
-			/* ranges between the previous and this one */
-			if (!prev_nid || prev_nid >= val) {
-				codec_warn(codec,
-					   "invalid dep_range_val %x:%x\n",
-					   prev_nid, val);
-				continue;
-			}
-			for (n = prev_nid + 1; n <= val; n++) {
-				if (conn_list) {
-					if (conns >= max_conns)
-						return -ENOSPC;
-					conn_list[conns] = n;
-				}
-				conns++;
-			}
-		} else {
-			if (conn_list) {
-				if (conns >= max_conns)
-					return -ENOSPC;
-				conn_list[conns] = val;
-			}
-			conns++;
-		}
-		prev_nid = val;
-	}
-	return conns;
-}
-
 /**
  * snd_hda_override_conn_list - add/modify the connection-list to cache
  * @codec: the HDA codec
@@ -738,35 +573,6 @@ int snd_hda_bus_new(struct snd_card *card,
 EXPORT_SYMBOL_GPL(snd_hda_bus_new);
 
 /*
- * look for an AFG and MFG nodes
- */
-static void setup_fg_nodes(struct hda_codec *codec)
-{
-	int i, total_nodes, function_id;
-	hda_nid_t nid;
-
-	total_nodes = snd_hda_get_sub_nodes(codec, AC_NODE_ROOT, &nid);
-	for (i = 0; i < total_nodes; i++, nid++) {
-		function_id = snd_hda_param_read(codec, nid,
-						AC_PAR_FUNCTION_TYPE);
-		switch (function_id & 0xff) {
-		case AC_GRP_AUDIO_FUNCTION:
-			codec->afg = nid;
-			codec->afg_function_id = function_id & 0xff;
-			codec->afg_unsol = (function_id >> 8) & 1;
-			break;
-		case AC_GRP_MODEM_FUNCTION:
-			codec->mfg = nid;
-			codec->mfg_function_id = function_id & 0xff;
-			codec->mfg_unsol = (function_id >> 8) & 1;
-			break;
-		default:
-			break;
-		}
-	}
-}
-
-/*
  * read widget caps for each widget and store in cache
  */
 static int read_widget_caps(struct hda_codec *codec, hda_nid_t fg_node)
@@ -774,13 +580,11 @@ static int read_widget_caps(struct hda_codec *codec, hda_nid_t fg_node)
 	int i;
 	hda_nid_t nid;
 
-	codec->num_nodes = snd_hda_get_sub_nodes(codec, fg_node,
-						 &codec->start_nid);
-	codec->wcaps = kmalloc(codec->num_nodes * 4, GFP_KERNEL);
+	codec->wcaps = kmalloc(codec->core.num_nodes * 4, GFP_KERNEL);
 	if (!codec->wcaps)
 		return -ENOMEM;
-	nid = codec->start_nid;
-	for (i = 0; i < codec->num_nodes; i++, nid++)
+	nid = codec->core.start_nid;
+	for (i = 0; i < codec->core.num_nodes; i++, nid++)
 		codec->wcaps[i] = snd_hda_param_read(codec, nid,
 						     AC_PAR_AUDIO_WIDGET_CAP);
 	return 0;
@@ -789,10 +593,9 @@ static int read_widget_caps(struct hda_codec *codec, hda_nid_t fg_node)
 /* read all pin default configurations and save codec->init_pins */
 static int read_pin_defaults(struct hda_codec *codec)
 {
-	int i;
-	hda_nid_t nid = codec->start_nid;
+	hda_nid_t nid;
 
-	for (i = 0; i < codec->num_nodes; i++, nid++) {
+	for_each_hda_codec_node(nid, codec) {
 		struct hda_pincfg *pin;
 		unsigned int wcaps = get_wcaps(codec, nid);
 		unsigned int wid_type = get_wcaps_type(wcaps);
@@ -1136,9 +939,6 @@ void snd_hda_codec_cleanup_for_unbind(struct hda_codec *codec)
 	remove_conn_list(codec);
 }
 
-static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec,
-				hda_nid_t fg, unsigned int power_state);
-
 static unsigned int hda_set_power_state(struct hda_codec *codec,
 				unsigned int power_state);
 
@@ -1178,12 +978,10 @@ static void snd_hda_codec_dev_release(struct device *dev)
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
 	free_init_pincfgs(codec);
-	snd_hdac_bus_remove_device(&codec->bus->core, &codec->core);
+	snd_hdac_device_exit(&codec->core);
 	snd_hda_sysfs_clear(codec);
 	free_hda_cache(&codec->amp_cache);
 	free_hda_cache(&codec->cmd_cache);
-	kfree(codec->vendor_name);
-	kfree(codec->chip_name);
 	kfree(codec->modelname);
 	kfree(codec->wcaps);
 	kfree(codec);
@@ -1201,7 +999,6 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 		      unsigned int codec_addr, struct hda_codec **codecp)
 {
 	struct hda_codec *codec;
-	struct device *dev;
 	char component[31];
 	hda_nid_t fg;
 	int err;
@@ -1220,19 +1017,16 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	if (!codec)
 		return -ENOMEM;
 
-	codec->core.bus = &bus->core;
-	codec->core.addr = codec_addr;
-	codec->core.type = HDA_DEV_LEGACY;
+	sprintf(component, "hdaudioC%dD%d", card->number, codec_addr);
+	err = snd_hdac_device_init(&codec->core, &bus->core, component,
+				   codec_addr);
+	if (err < 0) {
+		kfree(codec);
+		return err;
+	}
 
-	dev = hda_codec_dev(codec);
-	device_initialize(dev);
-	dev->parent = bus->core.dev;
-	dev->bus = &snd_hda_bus_type;
-	dev->release = snd_hda_codec_dev_release;
-	dev->groups = snd_hda_dev_attr_groups;
-	dev_set_name(dev, "hdaudioC%dD%d", card->number, codec_addr);
-	dev_set_drvdata(dev, codec); /* for sysfs */
-	device_enable_async_suspend(dev);
+	codec->core.dev.release = snd_hda_codec_dev_release;
+	codec->core.type = HDA_DEV_LEGACY;
 
 	codec->bus = bus;
 	codec->card = card;
@@ -1258,12 +1052,6 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	codec->fixup_id = HDA_FIXUP_ID_NOT_SET;
 
 #ifdef CONFIG_PM
-	/* snd_hda_codec_new() marks the codec as power-up, and leave it as is.
-	 * it's powered down later in snd_hda_codec_dev_register().
-	 */
-	set_bit(codec->core.addr, &bus->core.codec_powered);
-	pm_runtime_set_active(hda_codec_dev(codec));
-	pm_runtime_get_noresume(hda_codec_dev(codec));
 	codec->power_jiffies = jiffies;
 #endif
 
@@ -1277,31 +1065,7 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 		}
 	}
 
-	err = snd_hdac_bus_add_device(&bus->core, &codec->core);
-	if (err < 0)
-		goto error;
-
-	codec->vendor_id = snd_hda_param_read(codec, AC_NODE_ROOT,
-					      AC_PAR_VENDOR_ID);
-	if (codec->vendor_id == -1)
-		/* read again, hopefully the access method was corrected
-		 * in the last read...
-		 */
-		codec->vendor_id = snd_hda_param_read(codec, AC_NODE_ROOT,
-						      AC_PAR_VENDOR_ID);
-	codec->subsystem_id = snd_hda_param_read(codec, AC_NODE_ROOT,
-						 AC_PAR_SUBSYSTEM_ID);
-	codec->revision_id = snd_hda_param_read(codec, AC_NODE_ROOT,
-						AC_PAR_REV_ID);
-
-	setup_fg_nodes(codec);
-	if (!codec->afg && !codec->mfg) {
-		codec_err(codec, "no AFG or MFG node found\n");
-		err = -ENODEV;
-		goto error;
-	}
-
-	fg = codec->afg ? codec->afg : codec->mfg;
+	fg = codec->core.afg ? codec->core.afg : codec->core.mfg;
 	err = read_widget_caps(codec, fg);
 	if (err < 0)
 		goto error;
@@ -1309,19 +1073,6 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	if (err < 0)
 		goto error;
 
-	if (!codec->subsystem_id) {
-		codec->subsystem_id =
-			snd_hda_codec_read(codec, fg, 0,
-					   AC_VERB_GET_SUBSYSTEM_ID, 0);
-	}
-
-#ifdef CONFIG_PM
-	codec->d3_stop_clk = snd_hda_codec_get_supported_ps(codec, fg,
-					AC_PWRST_CLKSTOP);
-#endif
-	codec->epss = snd_hda_codec_get_supported_ps(codec, fg,
-					AC_PWRST_EPSS);
-
 	/* power-up all before initialization */
 	hda_set_power_state(codec, AC_PWRST_D0);
 
@@ -1329,8 +1080,8 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 
 	snd_hda_create_hwdep(codec);
 
-	sprintf(component, "HDA:%08x,%08x,%08x", codec->vendor_id,
-		codec->subsystem_id, codec->revision_id);
+	sprintf(component, "HDA:%08x,%08x,%08x", codec->core.vendor_id,
+		codec->core.subsystem_id, codec->core.revision_id);
 	snd_component_add(card, component);
 
 	err = snd_device_new(card, SNDRV_DEV_CODEC, codec, &dev_ops);
@@ -1342,6 +1093,7 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	return 0;
 
  error:
+	pm_runtime_put_noidle(hda_codec_dev(codec));
 	put_device(hda_codec_dev(codec));
 	return err;
 }
@@ -1359,11 +1111,15 @@ int snd_hda_codec_update_widgets(struct hda_codec *codec)
 	hda_nid_t fg;
 	int err;
 
+	err = snd_hdac_refresh_widgets(&codec->core);
+	if (err < 0)
+		return err;
+
 	/* Assume the function group node does not change,
 	 * only the widget nodes may change.
 	 */
 	kfree(codec->wcaps);
-	fg = codec->afg ? codec->afg : codec->mfg;
+	fg = codec->core.afg ? codec->core.afg : codec->core.mfg;
 	err = read_widget_caps(codec, fg);
 	if (err < 0)
 		return err;
@@ -1663,7 +1419,7 @@ static unsigned int read_amp_cap(struct hda_codec *codec, hda_nid_t nid,
 				 int direction)
 {
 	if (!(get_wcaps(codec, nid) & AC_WCAP_AMP_OVRD))
-		nid = codec->afg;
+		nid = codec->core.afg;
 	return snd_hda_param_read(codec, nid,
 				  direction == HDA_OUTPUT ?
 				  AC_PAR_AMP_OUT_CAP : AC_PAR_AMP_IN_CAP);
@@ -3664,10 +3420,9 @@ EXPORT_SYMBOL_GPL(snd_hda_codec_flush_cache);
 void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
 				    unsigned int power_state)
 {
-	hda_nid_t nid = codec->start_nid;
-	int i;
+	hda_nid_t nid;
 
-	for (i = 0; i < codec->num_nodes; i++, nid++) {
+	for_each_hda_codec_node(nid, codec) {
 		unsigned int wcaps = get_wcaps(codec, nid);
 		unsigned int state = power_state;
 		if (!(wcaps & AC_WCAP_POWER))
@@ -3684,22 +3439,6 @@ void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
 EXPORT_SYMBOL_GPL(snd_hda_codec_set_power_to_all);
 
 /*
- *  supported power states check
- */
-static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec, hda_nid_t fg,
-				unsigned int power_state)
-{
-	int sup = snd_hda_param_read(codec, fg, AC_PAR_POWER_STATE);
-
-	if (sup == -1)
-		return false;
-	if (sup & power_state)
-		return true;
-	else
-		return false;
-}
-
-/*
  * wait until the state is reached, returns the current state
  */
 static unsigned int hda_sync_power_state(struct hda_codec *codec,
@@ -3738,7 +3477,7 @@ unsigned int snd_hda_codec_eapd_power_filter(struct hda_codec *codec,
 					     hda_nid_t nid,
 					     unsigned int power_state)
 {
-	if (nid == codec->afg || nid == codec->mfg)
+	if (nid == codec->core.afg || nid == codec->core.mfg)
 		return power_state;
 	if (power_state == AC_PWRST_D3 &&
 	    get_wcaps_type(get_wcaps(codec, nid)) == AC_WID_PIN &&
@@ -3758,7 +3497,7 @@ EXPORT_SYMBOL_GPL(snd_hda_codec_eapd_power_filter);
 static unsigned int hda_set_power_state(struct hda_codec *codec,
 					unsigned int power_state)
 {
-	hda_nid_t fg = codec->afg ? codec->afg : codec->mfg;
+	hda_nid_t fg = codec->core.afg ? codec->core.afg : codec->core.mfg;
 	int count;
 	unsigned int state;
 	int flags = 0;
@@ -3766,7 +3505,7 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 	/* this delay seems necessary to avoid click noise at power-down */
 	if (power_state == AC_PWRST_D3) {
 		if (codec->depop_delay < 0)
-			msleep(codec->epss ? 10 : 100);
+			msleep(codec_has_epss(codec) ? 10 : 100);
 		else if (codec->depop_delay > 0)
 			msleep(codec->depop_delay);
 		flags = HDA_RW_NO_RESPONSE_FALLBACK;
@@ -3800,14 +3539,13 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
  */
 static void sync_power_up_states(struct hda_codec *codec)
 {
-	hda_nid_t nid = codec->start_nid;
-	int i;
+	hda_nid_t nid;
 
 	/* don't care if no filter is used */
 	if (!codec->power_filter)
 		return;
 
-	for (i = 0; i < codec->num_nodes; i++, nid++) {
+	for_each_hda_codec_node(nid, codec) {
 		unsigned int wcaps = get_wcaps(codec, nid);
 		unsigned int target;
 		if (!(wcaps & AC_WCAP_POWER))
@@ -3858,14 +3596,14 @@ static unsigned int hda_call_codec_suspend(struct hda_codec *codec)
 {
 	unsigned int state;
 
-	atomic_inc(&codec->in_pm);
+	atomic_inc(&codec->core.in_pm);
 
 	if (codec->patch_ops.suspend)
 		codec->patch_ops.suspend(codec);
 	hda_cleanup_all_streams(codec);
 	state = hda_set_power_state(codec, AC_PWRST_D3);
 	update_power_acct(codec, true);
-	atomic_dec(&codec->in_pm);
+	atomic_dec(&codec->core.in_pm);
 	return state;
 }
 
@@ -3890,7 +3628,7 @@ static void hda_mark_cmd_cache_dirty(struct hda_codec *codec)
  */
 static void hda_call_codec_resume(struct hda_codec *codec)
 {
-	atomic_inc(&codec->in_pm);
+	atomic_inc(&codec->core.in_pm);
 
 	hda_mark_cmd_cache_dirty(codec);
 
@@ -3913,7 +3651,7 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 		hda_jackpoll_work(&codec->jackpoll_work.work);
 	else
 		snd_hda_jack_report_sync(codec);
-	atomic_dec(&codec->in_pm);
+	atomic_dec(&codec->core.in_pm);
 }
 
 static int hda_codec_runtime_suspend(struct device *dev)
@@ -3926,8 +3664,9 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	list_for_each_entry(pcm, &codec->pcm_list_head, list)
 		snd_pcm_suspend_all(pcm->pcm);
 	state = hda_call_codec_suspend(codec);
-	if (codec->d3_stop_clk && codec->epss && (state & AC_PWRST_CLK_STOP_OK))
-		clear_bit(codec->core.addr, &codec->bus->core.codec_powered);
+	if (codec_has_clkstop(codec) && codec_has_epss(codec) &&
+	    (state & AC_PWRST_CLK_STOP_OK))
+		snd_hdac_codec_link_down(&codec->core);
 	return 0;
 }
 
@@ -3935,7 +3674,7 @@ static int hda_codec_runtime_resume(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
-	set_bit(codec->core.addr, &codec->bus->core.codec_powered);
+	snd_hdac_codec_link_up(&codec->core);
 	hda_call_codec_resume(codec);
 	pm_runtime_mark_last_busy(dev);
 	return 0;
@@ -4129,11 +3868,11 @@ static unsigned int get_pcm_param(struct hda_codec *codec, hda_nid_t nid,
 				  int dir)
 {
 	unsigned int val = 0;
-	if (nid != codec->afg &&
+	if (nid != codec->core.afg &&
 	    (get_wcaps(codec, nid) & AC_WCAP_FORMAT_OVRD))
 		val = snd_hda_param_read(codec, nid, AC_PAR_PCM);
 	if (!val || val == -1)
-		val = snd_hda_param_read(codec, codec->afg, AC_PAR_PCM);
+		val = snd_hda_param_read(codec, codec->core.afg, AC_PAR_PCM);
 	if (!val || val == -1)
 		return 0;
 	return val;
@@ -4150,7 +3889,7 @@ static unsigned int get_stream_param(struct hda_codec *codec, hda_nid_t nid,
 {
 	unsigned int streams = snd_hda_param_read(codec, nid, AC_PAR_STREAM);
 	if (!streams || streams == -1)
-		streams = snd_hda_param_read(codec, codec->afg, AC_PAR_STREAM);
+		streams = snd_hda_param_read(codec, codec->core.afg, AC_PAR_STREAM);
 	if (!streams || streams == -1)
 		return 0;
 	return streams;
@@ -4632,39 +4371,6 @@ int snd_hda_add_new_ctls(struct hda_codec *codec,
 EXPORT_SYMBOL_GPL(snd_hda_add_new_ctls);
 
 #ifdef CONFIG_PM
-/**
- * snd_hda_power_up - Power-up the codec
- * @codec: HD-audio codec
- *
- * Increment the usage counter and resume the device if not done yet.
- */
-void snd_hda_power_up(struct hda_codec *codec)
-{
-	struct device *dev = hda_codec_dev(codec);
-
-	if (codec_in_pm(codec))
-		return;
-	pm_runtime_get_sync(dev);
-}
-EXPORT_SYMBOL_GPL(snd_hda_power_up);
-
-/**
- * snd_hda_power_down - Power-down the codec
- * @codec: HD-audio codec
- *
- * Decrement the usage counter and schedules the autosuspend if none used.
- */
-void snd_hda_power_down(struct hda_codec *codec)
-{
-	struct device *dev = hda_codec_dev(codec);
-
-	if (codec_in_pm(codec))
-		return;
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
-}
-EXPORT_SYMBOL_GPL(snd_hda_power_down);
-
 static void codec_set_power_save(struct hda_codec *codec, int delay)
 {
 	struct device *dev = hda_codec_dev(codec);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 7ebad1bf29bc..6266fa8dafc2 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -261,24 +261,10 @@ struct hda_codec {
 	struct hda_bus *bus;
 	struct snd_card *card;
 	unsigned int addr;	/* codec addr*/
-
-	hda_nid_t afg;	/* AFG node id */
-	hda_nid_t mfg;	/* MFG node id */
-
-	/* ids */
-	u8 afg_function_id;
-	u8 mfg_function_id;
-	u8 afg_unsol;
-	u8 mfg_unsol;
-	u32 vendor_id;
-	u32 subsystem_id;
-	u32 revision_id;
 	u32 probe_id; /* overridden id for probing */
 
 	/* detected preset */
 	const struct hda_codec_preset *preset;
-	const char *vendor_name;	/* codec vendor name */
-	const char *chip_name;		/* codec chip name */
 	const char *modelname;	/* model name for preset */
 
 	/* set by patch */
@@ -295,8 +281,6 @@ struct hda_codec {
 	unsigned int beep_mode;
 
 	/* widget capabilities cache */
-	unsigned int num_nodes;
-	hda_nid_t start_nid;
 	u32 *wcaps;
 
 	struct snd_array mixers;	/* list of assigned mixer elements */
@@ -347,14 +331,11 @@ struct hda_codec {
 	unsigned int inv_eapd:1; /* broken h/w: inverted EAPD control */
 	unsigned int inv_jack_detect:1;	/* broken h/w: inverted detection bit */
 	unsigned int pcm_format_first:1; /* PCM format must be set first */
-	unsigned int epss:1;		/* supporting EPSS? */
 	unsigned int cached_write:1;	/* write only to caches */
 	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
 	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
 	unsigned int power_mgmt:1; /* advanced PM for each widget */
 #ifdef CONFIG_PM
-	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
-	atomic_t in_pm;		/* suspend/resume being performed */
 	unsigned long power_on_acct;
 	unsigned long power_off_acct;
 	unsigned long power_jiffies;
@@ -395,11 +376,6 @@ struct hda_codec {
 #define list_for_each_codec(c, bus) \
 	list_for_each_entry(c, &(bus)->core.codec_list, core.list)
 
-/* direction */
-enum {
-	HDA_INPUT, HDA_OUTPUT
-};
-
 /* snd_hda_codec_read/write optional flags */
 #define HDA_RW_NO_RESPONSE_FALLBACK	(1 << 0)
 
@@ -422,8 +398,8 @@ int snd_hda_codec_write(struct hda_codec *codec, hda_nid_t nid, int flags,
 			unsigned int verb, unsigned int parm);
 #define snd_hda_param_read(codec, nid, param) \
 	snd_hda_codec_read(codec, nid, 0, AC_VERB_PARAMETERS, param)
-int snd_hda_get_sub_nodes(struct hda_codec *codec, hda_nid_t nid,
-			  hda_nid_t *start_id);
+#define snd_hda_get_sub_nodes(codec, nid, start_nid) \
+	snd_hdac_get_sub_nodes(&(codec)->core, nid, start_nid)
 int snd_hda_get_connections(struct hda_codec *codec, hda_nid_t nid,
 			    hda_nid_t *conn_list, int max_conns);
 static inline int
@@ -431,9 +407,12 @@ snd_hda_get_num_conns(struct hda_codec *codec, hda_nid_t nid)
 {
 	return snd_hda_get_connections(codec, nid, NULL, 0);
 }
-int snd_hda_get_num_raw_conns(struct hda_codec *codec, hda_nid_t nid);
-int snd_hda_get_raw_connections(struct hda_codec *codec, hda_nid_t nid,
-			    hda_nid_t *conn_list, int max_conns);
+
+#define snd_hda_get_raw_connections(codec, nid, list, max_conns) \
+	snd_hdac_get_connections(&(codec)->core, nid, list, max_conns)
+#define snd_hda_get_num_raw_conns(codec, nid) \
+	snd_hdac_get_connections(&(codec)->core, nid, NULL, 0);
+
 int snd_hda_get_conn_list(struct hda_codec *codec, hda_nid_t nid,
 			  const hda_nid_t **listp);
 int snd_hda_override_conn_list(struct hda_codec *codec, hda_nid_t nid, int nums,
@@ -582,14 +561,12 @@ const char *snd_hda_get_jack_location(u32 cfg);
 /*
  * power saving
  */
+#define snd_hda_power_up(codec)		snd_hdac_power_up(&(codec)->core)
+#define snd_hda_power_down(codec)	snd_hdac_power_down(&(codec)->core)
 #ifdef CONFIG_PM
-void snd_hda_power_up(struct hda_codec *codec);
-void snd_hda_power_down(struct hda_codec *codec);
 void snd_hda_set_power_save(struct hda_bus *bus, int delay);
 void snd_hda_update_power_acct(struct hda_codec *codec);
 #else
-static inline void snd_hda_power_up(struct hda_codec *codec) {}
-static inline void snd_hda_power_down(struct hda_codec *codec) {}
 static inline void snd_hda_set_power_save(struct hda_bus *bus, int delay) {}
 #endif
 
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index d7ca388651da..23a3f076a36f 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -654,7 +654,7 @@ static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
 	int type = get_wcaps_type(get_wcaps(codec, nid));
 	int i, n;
 
-	if (nid == codec->afg)
+	if (nid == codec->core.afg)
 		return true;
 
 	for (n = 0; n < spec->paths.used; n++) {
@@ -832,7 +832,7 @@ static hda_nid_t path_power_update(struct hda_codec *codec,
 
 	for (i = 0; i < path->depth; i++) {
 		nid = path->path[i];
-		if (nid == codec->afg)
+		if (nid == codec->core.afg)
 			continue;
 		if (!allow_powerdown || is_active_nid_for_any(codec, nid))
 			state = AC_PWRST_D0;
@@ -1897,12 +1897,11 @@ static void debug_show_configs(struct hda_codec *codec,
 static void fill_all_dac_nids(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	int i;
-	hda_nid_t nid = codec->start_nid;
+	hda_nid_t nid;
 
 	spec->num_all_dacs = 0;
 	memset(spec->all_dacs, 0, sizeof(spec->all_dacs));
-	for (i = 0; i < codec->num_nodes; i++, nid++) {
+	for_each_hda_codec_node(nid, codec) {
 		if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_AUD_OUT)
 			continue;
 		if (spec->num_all_dacs >= ARRAY_SIZE(spec->all_dacs)) {
@@ -3067,10 +3066,9 @@ static int fill_adc_nids(struct hda_codec *codec)
 	hda_nid_t nid;
 	hda_nid_t *adc_nids = spec->adc_nids;
 	int max_nums = ARRAY_SIZE(spec->adc_nids);
-	int i, nums = 0;
+	int nums = 0;
 
-	nid = codec->start_nid;
-	for (i = 0; i < codec->num_nodes; i++, nid++) {
+	for_each_hda_codec_node(nid, codec) {
 		unsigned int caps = get_wcaps(codec, nid);
 		int type = get_wcaps_type(caps);
 
@@ -3864,8 +3862,7 @@ static void parse_digital(struct hda_codec *codec)
 
 	if (spec->autocfg.dig_in_pin) {
 		pin = spec->autocfg.dig_in_pin;
-		dig_nid = codec->start_nid;
-		for (i = 0; i < codec->num_nodes; i++, dig_nid++) {
+		for_each_hda_codec_node(dig_nid, codec) {
 			unsigned int wcaps = get_wcaps(codec, dig_nid);
 			if (get_wcaps_type(wcaps) != AC_WID_AUD_IN)
 				continue;
@@ -4683,7 +4680,7 @@ unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
 						  hda_nid_t nid,
 						  unsigned int power_state)
 {
-	if (power_state != AC_PWRST_D0 || nid == codec->afg)
+	if (power_state != AC_PWRST_D0 || nid == codec->core.afg)
 		return power_state;
 	if (get_wcaps_type(get_wcaps(codec, nid)) >= AC_WID_POWER)
 		return power_state;
@@ -5455,7 +5452,7 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 
 	fill_pcm_stream_name(spec->stream_name_analog,
 			     sizeof(spec->stream_name_analog),
-			     " Analog", codec->chip_name);
+			     " Analog", codec->core.chip_name);
 	info = snd_hda_codec_pcm_new(codec, "%s", spec->stream_name_analog);
 	if (!info)
 		return -ENOMEM;
@@ -5486,7 +5483,7 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
 		fill_pcm_stream_name(spec->stream_name_digital,
 				     sizeof(spec->stream_name_digital),
-				     " Digital", codec->chip_name);
+				     " Digital", codec->core.chip_name);
 		info = snd_hda_codec_pcm_new(codec, "%s",
 					     spec->stream_name_digital);
 		if (!info)
@@ -5521,7 +5518,7 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 	if (spec->alt_dac_nid || have_multi_adcs) {
 		fill_pcm_stream_name(spec->stream_name_alt_analog,
 				     sizeof(spec->stream_name_alt_analog),
-			     " Alt Analog", codec->chip_name);
+			     " Alt Analog", codec->core.chip_name);
 		info = snd_hda_codec_pcm_new(codec, "%s",
 					     spec->stream_name_alt_analog);
 		if (!info)
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 1d001647fc47..e0db30c66e5f 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -515,15 +515,18 @@ int snd_hda_codec_get_pin_target(struct hda_codec *codec, hda_nid_t nid);
 int snd_hda_codec_set_pin_target(struct hda_codec *codec, hda_nid_t nid,
 				 unsigned int val);
 
+#define for_each_hda_codec_node(nid, codec) \
+	for ((nid) = (codec)->core.start_nid; (nid) < (codec)->core.end_nid; (nid)++)
+
 /*
  * get widget capabilities
  */
 static inline u32 get_wcaps(struct hda_codec *codec, hda_nid_t nid)
 {
-	if (nid < codec->start_nid ||
-	    nid >= codec->start_nid + codec->num_nodes)
+	if (nid < codec->core.start_nid ||
+	    nid >= codec->core.start_nid + codec->core.num_nodes)
 		return 0;
-	return codec->wcaps[nid - codec->start_nid];
+	return codec->wcaps[nid - codec->core.start_nid];
 }
 
 /* get the widget type from widget capability bits */
@@ -547,9 +550,9 @@ static inline unsigned int get_wcaps_channels(u32 wcaps)
 static inline void snd_hda_override_wcaps(struct hda_codec *codec,
 					  hda_nid_t nid, u32 val)
 {
-	if (nid >= codec->start_nid &&
-	    nid < codec->start_nid + codec->num_nodes)
-		codec->wcaps[nid - codec->start_nid] = val;
+	if (nid >= codec->core.start_nid &&
+	    nid < codec->core.start_nid + codec->core.num_nodes)
+		codec->wcaps[nid - codec->core.start_nid] = val;
 }
 
 u32 query_amp_caps(struct hda_codec *codec, hda_nid_t nid, int direction);
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index dacfe74a2a1f..a4f5a30f1d41 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -289,7 +289,7 @@ static void print_pin_caps(struct snd_info_buffer *buffer,
 		snd_iprintf(buffer, " Balanced");
 	if (caps & AC_PINCAP_HDMI) {
 		/* Realtek uses this bit as a different meaning */
-		if ((codec->vendor_id >> 16) == 0x10ec)
+		if ((codec->core.vendor_id >> 16) == 0x10ec)
 			snd_iprintf(buffer, " R/L");
 		else {
 			if (caps & AC_PINCAP_HBR)
@@ -597,7 +597,7 @@ static void print_gpio(struct snd_info_buffer *buffer,
 		       struct hda_codec *codec, hda_nid_t nid)
 {
 	unsigned int gpio =
-		snd_hda_param_read(codec, codec->afg, AC_PAR_GPIO_CAP);
+		snd_hda_param_read(codec, codec->core.afg, AC_PAR_GPIO_CAP);
 	unsigned int enable, direction, wake, unsol, sticky, data;
 	int i, max;
 	snd_iprintf(buffer, "GPIO: io=%d, o=%d, i=%d, "
@@ -667,13 +667,9 @@ static void print_device_list(struct snd_info_buffer *buffer,
 	}
 }
 
-static void print_codec_info(struct snd_info_entry *entry,
-			     struct snd_info_buffer *buffer)
+static void print_codec_core_info(struct hdac_device *codec,
+				  struct snd_info_buffer *buffer)
 {
-	struct hda_codec *codec = entry->private_data;
-	hda_nid_t nid;
-	int i, nodes;
-
 	snd_iprintf(buffer, "Codec: ");
 	if (codec->vendor_name && codec->chip_name)
 		snd_iprintf(buffer, "%s %s\n",
@@ -695,29 +691,39 @@ static void print_codec_info(struct snd_info_entry *entry,
 		snd_iprintf(buffer, "Modem Function Group: 0x%x\n", codec->mfg);
 	else
 		snd_iprintf(buffer, "No Modem Function Group found\n");
+}
+
+static void print_codec_info(struct snd_info_entry *entry,
+			     struct snd_info_buffer *buffer)
+{
+	struct hda_codec *codec = entry->private_data;
+	hda_nid_t nid, fg;
+	int i, nodes;
 
-	if (! codec->afg)
+	print_codec_core_info(&codec->core, buffer);
+	fg = codec->core.afg;
+	if (!fg)
 		return;
 	snd_hda_power_up(codec);
 	snd_iprintf(buffer, "Default PCM:\n");
-	print_pcm_caps(buffer, codec, codec->afg);
+	print_pcm_caps(buffer, codec, fg);
 	snd_iprintf(buffer, "Default Amp-In caps: ");
-	print_amp_caps(buffer, codec, codec->afg, HDA_INPUT);
+	print_amp_caps(buffer, codec, fg, HDA_INPUT);
 	snd_iprintf(buffer, "Default Amp-Out caps: ");
-	print_amp_caps(buffer, codec, codec->afg, HDA_OUTPUT);
-	snd_iprintf(buffer, "State of AFG node 0x%02x:\n", codec->afg);
-	print_power_state(buffer, codec, codec->afg);
+	print_amp_caps(buffer, codec, fg, HDA_OUTPUT);
+	snd_iprintf(buffer, "State of AFG node 0x%02x:\n", fg);
+	print_power_state(buffer, codec, fg);
 
-	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid);
+	nodes = snd_hda_get_sub_nodes(codec, fg, &nid);
 	if (! nid || nodes < 0) {
 		snd_iprintf(buffer, "Invalid AFG subtree\n");
 		snd_hda_power_down(codec);
 		return;
 	}
 
-	print_gpio(buffer, codec, codec->afg);
+	print_gpio(buffer, codec, fg);
 	if (codec->proc_widget_hook)
-		codec->proc_widget_hook(buffer, codec, codec->afg);
+		codec->proc_widget_hook(buffer, codec, fg);
 
 	for (i = 0; i < nodes; i++, nid++) {
 		unsigned int wid_caps =
@@ -860,7 +866,7 @@ int snd_hda_codec_proc_new(struct hda_codec *codec)
 	struct snd_info_entry *entry;
 	int err;
 
-	snprintf(name, sizeof(name), "codec#%d", codec->addr);
+	snprintf(name, sizeof(name), "codec#%d", codec->core.addr);
 	err = snd_card_proc_new(codec->card, name, &entry);
 	if (err < 0)
 		return err;
diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index 3b5ed1108f9f..a6e3d9b511ab 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -48,33 +48,33 @@ static DEVICE_ATTR_RO(power_on_acct);
 static DEVICE_ATTR_RO(power_off_acct);
 #endif /* CONFIG_PM */
 
-#define CODEC_INFO_SHOW(type)					\
+#define CODEC_INFO_SHOW(type, field)				\
 static ssize_t type##_show(struct device *dev,			\
 			   struct device_attribute *attr,	\
 			   char *buf)				\
 {								\
 	struct hda_codec *codec = dev_get_drvdata(dev);		\
-	return sprintf(buf, "0x%x\n", codec->type);		\
+	return sprintf(buf, "0x%x\n", codec->field);		\
 }
 
-#define CODEC_INFO_STR_SHOW(type)				\
+#define CODEC_INFO_STR_SHOW(type, field)			\
 static ssize_t type##_show(struct device *dev,			\
 			     struct device_attribute *attr,	\
 					char *buf)		\
 {								\
 	struct hda_codec *codec = dev_get_drvdata(dev);		\
 	return sprintf(buf, "%s\n",				\
-		       codec->type ? codec->type : "");		\
+		       codec->field ? codec->field : "");	\
 }
 
-CODEC_INFO_SHOW(vendor_id);
-CODEC_INFO_SHOW(subsystem_id);
-CODEC_INFO_SHOW(revision_id);
-CODEC_INFO_SHOW(afg);
-CODEC_INFO_SHOW(mfg);
-CODEC_INFO_STR_SHOW(vendor_name);
-CODEC_INFO_STR_SHOW(chip_name);
-CODEC_INFO_STR_SHOW(modelname);
+CODEC_INFO_SHOW(vendor_id, core.vendor_id);
+CODEC_INFO_SHOW(subsystem_id, core.subsystem_id);
+CODEC_INFO_SHOW(revision_id, core.revision_id);
+CODEC_INFO_SHOW(afg, core.afg);
+CODEC_INFO_SHOW(mfg, core.mfg);
+CODEC_INFO_STR_SHOW(vendor_name, core.vendor_name);
+CODEC_INFO_STR_SHOW(chip_name, core.chip_name);
+CODEC_INFO_STR_SHOW(modelname, modelname);
 
 static ssize_t pin_configs_show(struct hda_codec *codec,
 				struct snd_array *list,
@@ -170,7 +170,7 @@ static char *kstrndup_noeol(const char *src, size_t len)
 	return s;
 }
 
-#define CODEC_INFO_STORE(type)					\
+#define CODEC_INFO_STORE(type, field)				\
 static ssize_t type##_store(struct device *dev,			\
 			    struct device_attribute *attr,	\
 			    const char *buf, size_t count)	\
@@ -180,11 +180,11 @@ static ssize_t type##_store(struct device *dev,			\
 	int err = kstrtoul(buf, 0, &val);			\
 	if (err < 0)						\
 		return err;					\
-	codec->type = val;					\
+	codec->field = val;					\
 	return count;						\
 }
 
-#define CODEC_INFO_STR_STORE(type)				\
+#define CODEC_INFO_STR_STORE(type, field)			\
 static ssize_t type##_store(struct device *dev,			\
 			    struct device_attribute *attr,	\
 			    const char *buf, size_t count)	\
@@ -193,17 +193,17 @@ static ssize_t type##_store(struct device *dev,			\
 	char *s = kstrndup_noeol(buf, 64);			\
 	if (!s)							\
 		return -ENOMEM;					\
-	kfree(codec->type);					\
-	codec->type = s;					\
+	kfree(codec->field);					\
+	codec->field = s;					\
 	return count;						\
 }
 
-CODEC_INFO_STORE(vendor_id);
-CODEC_INFO_STORE(subsystem_id);
-CODEC_INFO_STORE(revision_id);
-CODEC_INFO_STR_STORE(vendor_name);
-CODEC_INFO_STR_STORE(chip_name);
-CODEC_INFO_STR_STORE(modelname);
+CODEC_INFO_STORE(vendor_id, core.vendor_id);
+CODEC_INFO_STORE(subsystem_id, core.subsystem_id);
+CODEC_INFO_STORE(revision_id, core.revision_id);
+CODEC_INFO_STR_STORE(vendor_name, core.vendor_name);
+CODEC_INFO_STR_STORE(chip_name, core.chip_name);
+CODEC_INFO_STR_STORE(modelname, modelname);
 
 #define CODEC_ACTION_STORE(type)				\
 static ssize_t type##_store(struct device *dev,			\
@@ -553,9 +553,9 @@ static void parse_codec_mode(char *buf, struct hda_bus *bus,
 	*codecp = NULL;
 	if (sscanf(buf, "%i %i %i", &vendorid, &subid, &caddr) == 3) {
 		list_for_each_codec(codec, bus) {
-			if ((vendorid <= 0 || codec->vendor_id == vendorid) &&
-			    (subid <= 0 || codec->subsystem_id == subid) &&
-			    codec->addr == caddr) {
+			if ((vendorid <= 0 || codec->core.vendor_id == vendorid) &&
+			    (subid <= 0 || codec->core.subsystem_id == subid) &&
+			    codec->core.addr == caddr) {
 				*codecp = codec;
 				break;
 			}
@@ -595,8 +595,8 @@ static void parse_model_mode(char *buf, struct hda_bus *bus,
 static void parse_chip_name_mode(char *buf, struct hda_bus *bus,
 				 struct hda_codec **codecp)
 {
-	kfree((*codecp)->chip_name);
-	(*codecp)->chip_name = kstrdup(buf, GFP_KERNEL);
+	kfree((*codecp)->core.chip_name);
+	(*codecp)->core.chip_name = kstrdup(buf, GFP_KERNEL);
 }
 
 #define DEFINE_PARSE_ID_MODE(name) \
@@ -605,7 +605,7 @@ static void parse_##name##_mode(char *buf, struct hda_bus *bus, \
 { \
 	unsigned long val; \
 	if (!kstrtoul(buf, 0, &val)) \
-		(*codecp)->name = val; \
+		(*codecp)->core.name = val; \
 }
 
 DEFINE_PARSE_ID_MODE(vendor_id);
diff --git a/sound/pci/hda/local.h b/sound/pci/hda/local.h
new file mode 100644
index 000000000000..28cb7f98982e
--- /dev/null
+++ b/sound/pci/hda/local.h
@@ -0,0 +1,39 @@
+/*
+ */
+
+#ifndef __HDAC_LOCAL_H
+#define __HDAC_LOCAL_H
+
+int hdac_read_parm(struct hdac_device *codec, hda_nid_t nid, int parm);
+
+#define get_wcaps(codec, nid) \
+	hdac_read_parm(codec, nid, AC_PAR_AUDIO_WIDGET_CAP)
+/* get the widget type from widget capability bits */
+static inline int get_wcaps_type(unsigned int wcaps)
+{
+	if (!wcaps)
+		return -1; /* invalid type */
+	return (wcaps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
+}
+
+#define get_pin_caps(codec, nid) \
+	hdac_read_parm(codec, nid, AC_PAR_PIN_CAP)
+
+static inline
+unsigned int get_pin_cfg(struct hdac_device *codec, hda_nid_t nid)
+{
+	unsigned int val;
+
+	if (snd_hdac_read(codec, nid, AC_VERB_GET_CONFIG_DEFAULT, 0, &val))
+		return -1;
+	return val;
+}
+
+#define get_amp_caps(codec, nid, dir) \
+	hdac_read_parm(codec, nid, (dir) == HDA_OUTPUT ? \
+		       AC_PAR_AMP_OUT_CAP : AC_PAR_AMP_IN_CAP)
+
+#define get_power_caps(codec, nid) \
+	hdac_read_parm(codec, nid, AC_PAR_POWER_STATE)
+
+#endif /* __HDAC_LOCAL_H */
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index af4c7be86c27..2278e83234b5 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -99,7 +99,7 @@ static void ad198x_power_eapd_write(struct hda_codec *codec, hda_nid_t front,
 static void ad198x_power_eapd(struct hda_codec *codec)
 {
 	/* We currently only handle front, HP */
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x11d41882:
 	case 0x11d4882a:
 	case 0x11d41884:
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 72d20652df50..5aff35a09fd4 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4243,13 +4243,9 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 	int i;
-	hda_nid_t nid;
 
 	codec_dbg(codec, "ca0132_refresh_widget_caps.\n");
-	nid = codec->start_nid;
-	for (i = 0; i < codec->num_nodes; i++, nid++)
-		codec->wcaps[i] = snd_hda_param_read(codec, nid,
-						     AC_PAR_AUDIO_WIDGET_CAP);
+	snd_hda_codec_update_widgets(codec);
 
 	for (i = 0; i < spec->multiout.num_dacs; i++)
 		refresh_amp_caps(codec, spec->dacs[i], HDA_OUTPUT);
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 142a6cf786da..1e21f9fbd54b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -103,10 +103,9 @@ static int add_beep_ctls(struct hda_codec *codec)
 static void cx_auto_parse_beep(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
-	hda_nid_t nid, end_nid;
+	hda_nid_t nid;
 
-	end_nid = codec->start_nid + codec->num_nodes;
-	for (nid = codec->start_nid; nid < end_nid; nid++)
+	for_each_hda_codec_node(nid, codec)
 		if (get_wcaps_type(get_wcaps(codec, nid)) == AC_WID_BEEP) {
 			set_beep_amp(spec, nid, 0, HDA_OUTPUT);
 			break;
@@ -120,10 +119,9 @@ static void cx_auto_parse_beep(struct hda_codec *codec)
 static void cx_auto_parse_eapd(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
-	hda_nid_t nid, end_nid;
+	hda_nid_t nid;
 
-	end_nid = codec->start_nid + codec->num_nodes;
-	for (nid = codec->start_nid; nid < end_nid; nid++) {
+	for_each_hda_codec_node(nid, codec) {
 		if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_PIN)
 			continue;
 		if (!(snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_EAPD))
@@ -848,7 +846,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	struct conexant_spec *spec;
 	int err;
 
-	codec_info(codec, "%s: BIOS auto-probing.\n", codec->chip_name);
+	codec_info(codec, "%s: BIOS auto-probing.\n", codec->core.chip_name);
 
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
@@ -862,7 +860,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	if (spec->dynamic_eapd)
 		spec->gen.vmaster_mute.hook = cx_auto_vmaster_hook;
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x14f15045:
 		codec->single_adc_amp = 1;
 		spec->gen.mixer_nid = 0x17;
@@ -896,7 +894,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	 * others may use EAPD really as an amp switch, so it might be
 	 * not good to expose it blindly.
 	 */
-	switch (codec->subsystem_id >> 16) {
+	switch (codec->core.subsystem_id >> 16) {
 	case 0x103c:
 		spec->gen.vmaster_mute_enum = 1;
 		break;
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 7e9ff7b16e56..35d92a8a99ce 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -45,14 +45,14 @@ static bool static_hdmi_pcm;
 module_param(static_hdmi_pcm, bool, 0644);
 MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 
-#define is_haswell(codec)  ((codec)->vendor_id == 0x80862807)
-#define is_broadwell(codec)    ((codec)->vendor_id == 0x80862808)
-#define is_skylake(codec) ((codec)->vendor_id == 0x80862809)
+#define is_haswell(codec)  ((codec)->core.vendor_id == 0x80862807)
+#define is_broadwell(codec)    ((codec)->core.vendor_id == 0x80862808)
+#define is_skylake(codec) ((codec)->core.vendor_id == 0x80862809)
 #define is_haswell_plus(codec) (is_haswell(codec) || is_broadwell(codec) \
 					|| is_skylake(codec))
 
-#define is_valleyview(codec) ((codec)->vendor_id == 0x80862882)
-#define is_cherryview(codec) ((codec)->vendor_id == 0x80862883)
+#define is_valleyview(codec) ((codec)->core.vendor_id == 0x80862882)
+#define is_cherryview(codec) ((codec)->core.vendor_id == 0x80862883)
 #define is_valleyview_plus(codec) (is_valleyview(codec) || is_cherryview(codec))
 
 struct hdmi_spec_per_cvt {
@@ -1391,13 +1391,12 @@ static void intel_not_share_assigned_cvt(struct hda_codec *codec,
 			hda_nid_t pin_nid, int mux_idx)
 {
 	struct hdmi_spec *spec = codec->spec;
-	hda_nid_t nid, end_nid;
+	hda_nid_t nid;
 	int cvt_idx, curr;
 	struct hdmi_spec_per_cvt *per_cvt;
 
 	/* configure all pins, including "no physical connection" ones */
-	end_nid = codec->start_nid + codec->num_nodes;
-	for (nid = codec->start_nid; nid < end_nid; nid++) {
+	for_each_hda_codec_node(nid, codec) {
 		unsigned int wid_caps = get_wcaps(codec, nid);
 		unsigned int wid_type = get_wcaps_type(wid_caps);
 
@@ -1728,7 +1727,7 @@ static int hdmi_parse_codec(struct hda_codec *codec)
 	hda_nid_t nid;
 	int i, nodes;
 
-	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid);
+	nodes = snd_hda_get_sub_nodes(codec, codec->core.afg, &nid);
 	if (!nid || nodes < 0) {
 		codec_warn(codec, "HDMI: failed to get afg sub nodes\n");
 		return -EINVAL;
@@ -2928,7 +2927,8 @@ static int patch_nvhdmi(struct hda_codec *codec)
  */
 
 #define is_amdhdmi_rev3_or_later(codec) \
-	((codec)->vendor_id == 0x1002aa01 && ((codec)->revision_id & 0xff00) >= 0x0300)
+	((codec)->core.vendor_id == 0x1002aa01 && \
+	 ((codec)->core.revision_id & 0xff00) >= 0x0300)
 #define has_amd_full_remap_support(codec) is_amdhdmi_rev3_or_later(codec)
 
 /* ATI/AMD specific HDA pin verbs, see the AMD HDA Verbs specification */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 124eacf67fc4..eee4532ab5f6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -299,7 +299,7 @@ static void alc_fill_eapd_coef(struct hda_codec *codec)
 
 	coef = alc_get_coef0(codec);
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x10ec0262:
 		alc_update_coef_idx(codec, 0x7, 0, 1<<5);
 		break;
@@ -432,7 +432,7 @@ static void alc_auto_init_amp(struct hda_codec *codec, int type)
 		snd_hda_sequence_write(codec, alc_gpio3_init_verbs);
 		break;
 	case ALC_INIT_DEFAULT:
-		switch (codec->vendor_id) {
+		switch (codec->core.vendor_id) {
 		case 0x10ec0260:
 			alc_update_coefex_idx(codec, 0x1a, 7, 0, 0x2010);
 			break;
@@ -498,18 +498,18 @@ static int alc_auto_parse_customize_define(struct hda_codec *codec)
 
 	if (!codec->bus->pci)
 		return -1;
-	ass = codec->subsystem_id & 0xffff;
+	ass = codec->core.subsystem_id & 0xffff;
 	if (ass != codec->bus->pci->subsystem_device && (ass & 1))
 		goto do_sku;
 
 	nid = 0x1d;
-	if (codec->vendor_id == 0x10ec0260)
+	if (codec->core.vendor_id == 0x10ec0260)
 		nid = 0x17;
 	ass = snd_hda_codec_get_pincfg(codec, nid);
 
 	if (!(ass & 1)) {
 		codec_info(codec, "%s: SKU not ready 0x%08x\n",
-			   codec->chip_name, ass);
+			   codec->core.chip_name, ass);
 		return -1;
 	}
 
@@ -585,7 +585,7 @@ static int alc_subsystem_id(struct hda_codec *codec, const hda_nid_t *ports)
 		goto do_sku;
 	}
 
-	ass = codec->subsystem_id & 0xffff;
+	ass = codec->core.subsystem_id & 0xffff;
 	if (codec->bus->pci &&
 	    ass != codec->bus->pci->subsystem_device && (ass & 1))
 		goto do_sku;
@@ -600,7 +600,7 @@ static int alc_subsystem_id(struct hda_codec *codec, const hda_nid_t *ports)
 	 * 0		: override
 	*/
 	nid = 0x1d;
-	if (codec->vendor_id == 0x10ec0260)
+	if (codec->core.vendor_id == 0x10ec0260)
 		nid = 0x17;
 	ass = snd_hda_codec_get_pincfg(codec, nid);
 	codec_dbg(codec,
@@ -621,7 +621,7 @@ static int alc_subsystem_id(struct hda_codec *codec, const hda_nid_t *ports)
 		return 0;
 do_sku:
 	codec_dbg(codec, "realtek: Enabling init ASM_ID=0x%04x CODEC_ID=%08x\n",
-		   ass & 0xffff, codec->vendor_id);
+		   ass & 0xffff, codec->core.vendor_id);
 	/*
 	 * 0 : override
 	 * 1 :	Swap Jack
@@ -826,9 +826,9 @@ static const struct hda_codec_ops alc_patch_ops = {
 /* replace the codec chip_name with the given string */
 static int alc_codec_rename(struct hda_codec *codec, const char *name)
 {
-	kfree(codec->chip_name);
-	codec->chip_name = kstrdup(name, GFP_KERNEL);
-	if (!codec->chip_name) {
+	kfree(codec->core.chip_name);
+	codec->core.chip_name = kstrdup(name, GFP_KERNEL);
+	if (!codec->core.chip_name) {
 		alc_free(codec);
 		return -ENOMEM;
 	}
@@ -904,7 +904,7 @@ static int alc_codec_rename_from_preset(struct hda_codec *codec)
 	const struct alc_codec_rename_pci_table *q;
 
 	for (p = rename_tbl; p->vendor_id; p++) {
-		if (p->vendor_id != codec->vendor_id)
+		if (p->vendor_id != codec->core.vendor_id)
 			continue;
 		if ((alc_get_coef0(codec) & p->coef_mask) == p->coef_bits)
 			return alc_codec_rename(codec, p->name);
@@ -913,7 +913,7 @@ static int alc_codec_rename_from_preset(struct hda_codec *codec)
 	if (!codec->bus->pci)
 		return 0;
 	for (q = rename_pci_tbl; q->codec_vendor_id; q++) {
-		if (q->codec_vendor_id != codec->vendor_id)
+		if (q->codec_vendor_id != codec->core.vendor_id)
 			continue;
 		if (q->pci_subvendor != codec->bus->pci->subsystem_vendor)
 			continue;
@@ -1785,7 +1785,7 @@ static void alc882_gpio_mute(struct hda_codec *codec, int pin, int muted)
 {
 	unsigned int gpiostate, gpiomask, gpiodir;
 
-	gpiostate = snd_hda_codec_read(codec, codec->afg, 0,
+	gpiostate = snd_hda_codec_read(codec, codec->core.afg, 0,
 				       AC_VERB_GET_GPIO_DATA, 0);
 
 	if (!muted)
@@ -1793,23 +1793,23 @@ static void alc882_gpio_mute(struct hda_codec *codec, int pin, int muted)
 	else
 		gpiostate &= ~(1 << pin);
 
-	gpiomask = snd_hda_codec_read(codec, codec->afg, 0,
+	gpiomask = snd_hda_codec_read(codec, codec->core.afg, 0,
 				      AC_VERB_GET_GPIO_MASK, 0);
 	gpiomask |= (1 << pin);
 
-	gpiodir = snd_hda_codec_read(codec, codec->afg, 0,
+	gpiodir = snd_hda_codec_read(codec, codec->core.afg, 0,
 				     AC_VERB_GET_GPIO_DIRECTION, 0);
 	gpiodir |= (1 << pin);
 
 
-	snd_hda_codec_write(codec, codec->afg, 0,
+	snd_hda_codec_write(codec, codec->core.afg, 0,
 			    AC_VERB_SET_GPIO_MASK, gpiomask);
-	snd_hda_codec_write(codec, codec->afg, 0,
+	snd_hda_codec_write(codec, codec->core.afg, 0,
 			    AC_VERB_SET_GPIO_DIRECTION, gpiodir);
 
 	msleep(1);
 
-	snd_hda_codec_write(codec, codec->afg, 0,
+	snd_hda_codec_write(codec, codec->core.afg, 0,
 			    AC_VERB_SET_GPIO_DATA, gpiostate);
 }
 
@@ -2269,7 +2269,7 @@ static int patch_alc882(struct hda_codec *codec)
 
 	spec = codec->spec;
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x10ec0882:
 	case 0x10ec0885:
 	case 0x10ec0900:
@@ -3067,7 +3067,7 @@ static int alc269_resume(struct hda_codec *codec)
 	 * in the driver.
 	 */
 	if (spec->gpio_led)
-		snd_hda_codec_write(codec, codec->afg, 0, AC_VERB_SET_GPIO_DATA,
+		snd_hda_codec_write(codec, codec->core.afg, 0, AC_VERB_SET_GPIO_DATA,
 			    spec->gpio_led);
 
 	if (spec->has_alc5505_dsp)
@@ -3112,8 +3112,8 @@ static void alc271_fixup_dmic(struct hda_codec *codec,
 	};
 	unsigned int cfg;
 
-	if (strcmp(codec->chip_name, "ALC271X") &&
-	    strcmp(codec->chip_name, "ALC269VB"))
+	if (strcmp(codec->core.chip_name, "ALC271X") &&
+	    strcmp(codec->core.chip_name, "ALC269VB"))
 		return;
 	cfg = snd_hda_codec_get_pincfg(codec, 0x12);
 	if (get_defcfg_connect(cfg) == AC_JACK_PORT_FIXED)
@@ -3479,9 +3479,9 @@ static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
 		}
 
 		snd_hda_add_verbs(codec, gpio_init);
-		snd_hda_codec_write_cache(codec, codec->afg, 0,
+		snd_hda_codec_write_cache(codec, codec->core.afg, 0,
 					  AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x04);
-		snd_hda_jack_detect_enable_callback(codec, codec->afg,
+		snd_hda_jack_detect_enable_callback(codec, codec->core.afg,
 						    gpio2_mic_hotkey_event);
 
 		spec->gen.vmaster_mute.hook = alc_fixup_gpio_mute_hook;
@@ -3564,7 +3564,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 		{}
 	};
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x10ec0255:
 		alc_process_coef_fw(codec, coef0255);
 		break;
@@ -3619,7 +3619,7 @@ static void alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
 		{}
 	};
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x10ec0255:
 		alc_write_coef_idx(codec, 0x45, 0xc489);
 		snd_hda_set_pin_ctl_cache(codec, hp_pin, 0);
@@ -3688,7 +3688,7 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 		{}
 	};
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x10ec0255:
 		alc_process_coef_fw(codec, coef0255);
 		break;
@@ -3742,7 +3742,7 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 		{}
 	};
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x10ec0255:
 		alc_process_coef_fw(codec, coef0255);
 		break;
@@ -3796,7 +3796,7 @@ static void alc_headset_mode_omtp(struct hda_codec *codec)
 		{}
 	};
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x10ec0255:
 		alc_process_coef_fw(codec, coef0255);
 		break;
@@ -3841,7 +3841,7 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 		{}
 	};
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x10ec0255:
 		alc_process_coef_fw(codec, coef0255);
 		msleep(300);
@@ -4078,7 +4078,7 @@ static unsigned int alc_power_filter_xps13(struct hda_codec *codec,
 
 	/* Avoid pop noises when headphones are plugged in */
 	if (spec->gen.hp_jack_present)
-		if (nid == codec->afg || nid == 0x02 || nid == 0x15)
+		if (nid == codec->core.afg || nid == 0x02 || nid == 0x15)
 			return AC_PWRST_D0;
 	return power_state;
 }
@@ -5428,7 +5428,7 @@ static int patch_alc269(struct hda_codec *codec)
 	if (has_cdefine_beep(codec))
 		spec->gen.beep_nid = 0x01;
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x10ec0269:
 		spec->codec_variant = ALC269_TYPE_ALC269VA;
 		switch (alc_get_coef0(codec) & 0x00f0) {
@@ -5772,9 +5772,9 @@ static int alc662_parse_auto_config(struct hda_codec *codec)
 	static const hda_nid_t alc662_ssids[] = { 0x15, 0x1b, 0x14, 0 };
 	const hda_nid_t *ssids;
 
-	if (codec->vendor_id == 0x10ec0272 || codec->vendor_id == 0x10ec0663 ||
-	    codec->vendor_id == 0x10ec0665 || codec->vendor_id == 0x10ec0670 ||
-	    codec->vendor_id == 0x10ec0671)
+	if (codec->core.vendor_id == 0x10ec0272 || codec->core.vendor_id == 0x10ec0663 ||
+	    codec->core.vendor_id == 0x10ec0665 || codec->core.vendor_id == 0x10ec0670 ||
+	    codec->core.vendor_id == 0x10ec0671)
 		ssids = alc663_ssids;
 	else
 		ssids = alc662_ssids;
@@ -5819,7 +5819,7 @@ static unsigned int gpio_led_power_filter(struct hda_codec *codec,
 					  unsigned int power_state)
 {
 	struct alc_spec *spec = codec->spec;
-	if (nid == codec->afg && power_state == AC_PWRST_D3 && spec->gpio_led)
+	if (nid == codec->core.afg && power_state == AC_PWRST_D3 && spec->gpio_led)
 		return AC_PWRST_D0;
 	return power_state;
 }
@@ -6317,7 +6317,7 @@ static int patch_alc662(struct hda_codec *codec)
 
 	alc_fix_pll_init(codec, 0x20, 0x04, 15);
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x10ec0668:
 		spec->init_hook = alc668_restore_default_value;
 		break;
@@ -6347,7 +6347,7 @@ static int patch_alc662(struct hda_codec *codec)
 		goto error;
 
 	if (!spec->gen.no_analog && spec->gen.beep_nid) {
-		switch (codec->vendor_id) {
+		switch (codec->core.vendor_id) {
 		case 0x10ec0662:
 			set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
 			break;
diff --git a/sound/pci/hda/patch_si3054.c b/sound/pci/hda/patch_si3054.c
index df243134baa8..49b4868797a5 100644
--- a/sound/pci/hda/patch_si3054.c
+++ b/sound/pci/hda/patch_si3054.c
@@ -205,8 +205,8 @@ static int si3054_build_pcms(struct hda_codec *codec)
 		return -ENOMEM;
 	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = si3054_pcm;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE]  = si3054_pcm;
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = codec->mfg;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = codec->mfg;
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = codec->core.mfg;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = codec->core.mfg;
 	info->pcm_type = HDA_PCM_TYPE_MODEM;
 	return 0;
 }
@@ -223,7 +223,7 @@ static int si3054_init(struct hda_codec *codec)
 	u16 val;
 
 	snd_hda_codec_write(codec, AC_NODE_ROOT, 0, AC_VERB_SET_CODEC_RESET, 0);
-	snd_hda_codec_write(codec, codec->mfg, 0, AC_VERB_SET_STREAM_FORMAT, 0);
+	snd_hda_codec_write(codec, codec->core.mfg, 0, AC_VERB_SET_STREAM_FORMAT, 0);
 	SET_REG(codec, SI3054_LINE_RATE, 9600);
 	SET_REG(codec, SI3054_LINE_LEVEL, SI3054_DTAG_MASK|SI3054_ATAG_MASK);
 	SET_REG(codec, SI3054_EXTENDED_MID, 0);
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 86b944a6b0ed..7983d350ed65 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -299,32 +299,33 @@ static void stac_gpio_set(struct hda_codec *codec, unsigned int mask,
 			  unsigned int dir_mask, unsigned int data)
 {
 	unsigned int gpiostate, gpiomask, gpiodir;
+	hda_nid_t fg = codec->core.afg;
 
 	codec_dbg(codec, "%s msk %x dir %x gpio %x\n", __func__, mask, dir_mask, data);
 
-	gpiostate = snd_hda_codec_read(codec, codec->afg, 0,
+	gpiostate = snd_hda_codec_read(codec, fg, 0,
 				       AC_VERB_GET_GPIO_DATA, 0);
 	gpiostate = (gpiostate & ~dir_mask) | (data & dir_mask);
 
-	gpiomask = snd_hda_codec_read(codec, codec->afg, 0,
+	gpiomask = snd_hda_codec_read(codec, fg, 0,
 				      AC_VERB_GET_GPIO_MASK, 0);
 	gpiomask |= mask;
 
-	gpiodir = snd_hda_codec_read(codec, codec->afg, 0,
+	gpiodir = snd_hda_codec_read(codec, fg, 0,
 				     AC_VERB_GET_GPIO_DIRECTION, 0);
 	gpiodir |= dir_mask;
 
 	/* Configure GPIOx as CMOS */
-	snd_hda_codec_write(codec, codec->afg, 0, 0x7e7, 0);
+	snd_hda_codec_write(codec, fg, 0, 0x7e7, 0);
 
-	snd_hda_codec_write(codec, codec->afg, 0,
+	snd_hda_codec_write(codec, fg, 0,
 			    AC_VERB_SET_GPIO_MASK, gpiomask);
-	snd_hda_codec_read(codec, codec->afg, 0,
+	snd_hda_codec_read(codec, fg, 0,
 			   AC_VERB_SET_GPIO_DIRECTION, gpiodir); /* sync */
 
 	msleep(1);
 
-	snd_hda_codec_read(codec, codec->afg, 0,
+	snd_hda_codec_read(codec, fg, 0,
 			   AC_VERB_SET_GPIO_DATA, gpiostate); /* sync */
 }
 
@@ -387,7 +388,7 @@ static unsigned int stac_vref_led_power_filter(struct hda_codec *codec,
 					       hda_nid_t nid,
 					       unsigned int power_state)
 {
-	if (nid == codec->afg && power_state == AC_PWRST_D3)
+	if (nid == codec->core.afg && power_state == AC_PWRST_D3)
 		return AC_PWRST_D1;
 	return snd_hda_gen_path_power_filter(codec, nid, power_state);
 }
@@ -432,7 +433,7 @@ static void stac_update_outputs(struct hda_codec *codec)
 
 	if (spec->gpio_mute)
 		spec->gen.master_mute =
-			!(snd_hda_codec_read(codec, codec->afg, 0,
+			!(snd_hda_codec_read(codec, codec->core.afg, 0,
 				AC_VERB_GET_GPIO_DATA, 0) & spec->gpio_mute);
 
 	snd_hda_gen_update_outputs(codec);
@@ -476,7 +477,7 @@ static void stac_toggle_power_map(struct hda_codec *codec, hda_nid_t nid,
 	if (val != spec->power_map_bits) {
 		spec->power_map_bits = val;
 		if (do_write)
-			snd_hda_codec_write(codec, codec->afg, 0,
+			snd_hda_codec_write(codec, codec->core.afg, 0,
 					    AC_VERB_IDT_SET_POWER_MAP, val);
 	}
 }
@@ -508,7 +509,8 @@ static void jack_update_power(struct hda_codec *codec,
 				      false);
 	}
 
-	snd_hda_codec_write(codec, codec->afg, 0, AC_VERB_IDT_SET_POWER_MAP,
+	snd_hda_codec_write(codec, codec->core.afg, 0,
+			    AC_VERB_IDT_SET_POWER_MAP,
 			    spec->power_map_bits);
 }
 
@@ -517,10 +519,10 @@ static void stac_vref_event(struct hda_codec *codec,
 {
 	unsigned int data;
 
-	data = snd_hda_codec_read(codec, codec->afg, 0,
+	data = snd_hda_codec_read(codec, codec->core.afg, 0,
 				  AC_VERB_GET_GPIO_DATA, 0);
 	/* toggle VREF state based on GPIOx status */
-	snd_hda_codec_write(codec, codec->afg, 0, 0x7e0,
+	snd_hda_codec_write(codec, codec->core.afg, 0, 0x7e0,
 			    !!(data & (1 << event->private_data)));
 }
 
@@ -622,7 +624,7 @@ static int stac_aloopback_put(struct snd_kcontrol *kcontrol,
 	/* Only return the bits defined by the shift value of the
 	 * first two bytes of the mask
 	 */
-	dac_mode = snd_hda_codec_read(codec, codec->afg, 0,
+	dac_mode = snd_hda_codec_read(codec, codec->core.afg, 0,
 				      kcontrol->private_value & 0xFFFF, 0x0);
 	dac_mode >>= spec->aloopback_shift;
 
@@ -634,7 +636,7 @@ static int stac_aloopback_put(struct snd_kcontrol *kcontrol,
 		dac_mode &= ~idx_val;
 	}
 
-	snd_hda_codec_write_cache(codec, codec->afg, 0,
+	snd_hda_codec_write_cache(codec, codec->core.afg, 0,
 		kcontrol->private_value >> 16, dac_mode);
 
 	return 1;
@@ -658,11 +660,11 @@ static int stac_aloopback_put(struct snd_kcontrol *kcontrol,
 /* check whether it's a HP laptop with a docking port */
 static bool hp_bnb2011_with_dock(struct hda_codec *codec)
 {
-	if (codec->vendor_id != 0x111d7605 &&
-	    codec->vendor_id != 0x111d76d1)
+	if (codec->core.vendor_id != 0x111d7605 &&
+	    codec->core.vendor_id != 0x111d76d1)
 		return false;
 
-	switch (codec->subsystem_id) {
+	switch (codec->core.subsystem_id) {
 	case 0x103c1618:
 	case 0x103c1619:
 	case 0x103c161a:
@@ -733,7 +735,7 @@ static void set_hp_led_gpio(struct hda_codec *codec)
 	if (spec->gpio_led)
 		return;
 
-	gpio = snd_hda_param_read(codec, codec->afg, AC_PAR_GPIO_CAP);
+	gpio = snd_hda_param_read(codec, codec->core.afg, AC_PAR_GPIO_CAP);
 	gpio &= AC_GPIO_IO_COUNT;
 	if (gpio > 3)
 		spec->gpio_led = 0x08; /* GPIO 3 */
@@ -777,7 +779,7 @@ static int find_mute_led_cfg(struct hda_codec *codec, int default_polarity)
 			   &spec->gpio_led_polarity,
 			   &spec->gpio_led) == 2) {
 			unsigned int max_gpio;
-			max_gpio = snd_hda_param_read(codec, codec->afg,
+			max_gpio = snd_hda_param_read(codec, codec->core.afg,
 						      AC_PAR_GPIO_CAP);
 			max_gpio &= AC_GPIO_IO_COUNT;
 			if (spec->gpio_led < max_gpio)
@@ -807,7 +809,7 @@ static int find_mute_led_cfg(struct hda_codec *codec, int default_polarity)
 	 * we statically set the GPIO - if not a B-series system
 	 * and default polarity is provided
 	 */
-	if (!hp_blike_system(codec->subsystem_id) &&
+	if (!hp_blike_system(codec->core.subsystem_id) &&
 	    (default_polarity == 0 || default_polarity == 1)) {
 		set_hp_led_gpio(codec);
 		spec->gpio_led_polarity = default_polarity;
@@ -2134,7 +2136,7 @@ static void stac92hd83xxx_fixup_hp_mic_led(struct hda_codec *codec,
 		spec->mic_mute_led_gpio = 0x08; /* GPIO3 */
 #ifdef CONFIG_PM
 		/* resetting controller clears GPIO, so we need to keep on */
-		codec->d3_stop_clk = 0;
+		codec->core.power_caps &= ~AC_PWRST_CLKSTOP;
 #endif
 	}
 }
@@ -3031,9 +3033,9 @@ static void stac92hd71bxx_fixup_hp_m4(struct hda_codec *codec,
 		return;
 
 	/* Enable VREF power saving on GPIO1 detect */
-	snd_hda_codec_write_cache(codec, codec->afg, 0,
+	snd_hda_codec_write_cache(codec, codec->core.afg, 0,
 				  AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x02);
-	jack = snd_hda_jack_detect_enable_callback(codec, codec->afg,
+	jack = snd_hda_jack_detect_enable_callback(codec, codec->core.afg,
 						   stac_vref_event);
 	if (!IS_ERR(jack))
 		jack->private_data = 0x02;
@@ -3093,7 +3095,7 @@ static void stac92hd71bxx_fixup_hp(struct hda_codec *codec,
 	if (action != HDA_FIXUP_ACT_PRE_PROBE)
 		return;
 
-	if (hp_blike_system(codec->subsystem_id)) {
+	if (hp_blike_system(codec->core.subsystem_id)) {
 		unsigned int pin_cfg = snd_hda_codec_get_pincfg(codec, 0x0f);
 		if (get_defcfg_device(pin_cfg) == AC_JACK_LINE_OUT ||
 			get_defcfg_device(pin_cfg) == AC_JACK_SPEAKER  ||
@@ -3792,7 +3794,7 @@ static void stac927x_fixup_dell_dmic(struct hda_codec *codec,
 	if (action != HDA_FIXUP_ACT_PRE_PROBE)
 		return;
 
-	if (codec->subsystem_id != 0x1028022f) {
+	if (codec->core.subsystem_id != 0x1028022f) {
 		/* GPIO2 High = Enable EAPD */
 		spec->eapd_mask = spec->gpio_mask = 0x04;
 		spec->gpio_dir = spec->gpio_data = 0x04;
@@ -4053,9 +4055,9 @@ static void stac9205_fixup_dell_m43(struct hda_codec *codec,
 		snd_hda_apply_pincfgs(codec, dell_9205_m43_pin_configs);
 
 		/* Enable unsol response for GPIO4/Dock HP connection */
-		snd_hda_codec_write_cache(codec, codec->afg, 0,
+		snd_hda_codec_write_cache(codec, codec->core.afg, 0,
 			AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x10);
-		jack = snd_hda_jack_detect_enable_callback(codec, codec->afg,
+		jack = snd_hda_jack_detect_enable_callback(codec, codec->core.afg,
 							   stac_vref_event);
 		if (!IS_ERR(jack))
 			jack->private_data = 0x01;
@@ -4296,7 +4298,7 @@ static int stac_init(struct hda_codec *codec)
 
 	/* sync the power-map */
 	if (spec->num_pwrs)
-		snd_hda_codec_write(codec, codec->afg, 0,
+		snd_hda_codec_write(codec, codec->core.afg, 0,
 				    AC_VERB_IDT_SET_POWER_MAP,
 				    spec->power_map_bits);
 
@@ -4332,7 +4334,7 @@ static void stac_shutup(struct hda_codec *codec)
 static void stac92hd_proc_hook(struct snd_info_buffer *buffer,
 			       struct hda_codec *codec, hda_nid_t nid)
 {
-	if (nid == codec->afg)
+	if (nid == codec->core.afg)
 		snd_iprintf(buffer, "Power-Map: 0x%02x\n", 
 			    snd_hda_codec_read(codec, nid, 0,
 					       AC_VERB_IDT_GET_POWER_MAP, 0));
@@ -4343,7 +4345,7 @@ static void analog_loop_proc_hook(struct snd_info_buffer *buffer,
 				  unsigned int verb)
 {
 	snd_iprintf(buffer, "Analog Loopback: 0x%02x\n",
-		    snd_hda_codec_read(codec, codec->afg, 0, verb, 0));
+		    snd_hda_codec_read(codec, codec->core.afg, 0, verb, 0));
 }
 
 /* stac92hd71bxx, stac92hd73xx */
@@ -4351,21 +4353,21 @@ static void stac92hd7x_proc_hook(struct snd_info_buffer *buffer,
 				 struct hda_codec *codec, hda_nid_t nid)
 {
 	stac92hd_proc_hook(buffer, codec, nid);
-	if (nid == codec->afg)
+	if (nid == codec->core.afg)
 		analog_loop_proc_hook(buffer, codec, 0xfa0);
 }
 
 static void stac9205_proc_hook(struct snd_info_buffer *buffer,
 			       struct hda_codec *codec, hda_nid_t nid)
 {
-	if (nid == codec->afg)
+	if (nid == codec->core.afg)
 		analog_loop_proc_hook(buffer, codec, 0xfe0);
 }
 
 static void stac927x_proc_hook(struct snd_info_buffer *buffer,
 			       struct hda_codec *codec, hda_nid_t nid)
 {
-	if (nid == codec->afg)
+	if (nid == codec->core.afg)
 		analog_loop_proc_hook(buffer, codec, 0xfeb);
 }
 #else
@@ -4591,7 +4593,8 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
-	codec->epss = 0; /* longer delay needed for D3 */
+	/* longer delay needed for D3 */
+	codec->core.power_caps &= ~AC_PWRST_EPSS;
 
 	spec = codec->spec;
 	codec->power_mgmt = 1;
@@ -4641,7 +4644,8 @@ static int patch_stac92hd95(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
-	codec->epss = 0; /* longer delay needed for D3 */
+	/* longer delay needed for D3 */
+	codec->core.power_caps &= ~AC_PWRST_EPSS;
 
 	spec = codec->spec;
 	codec->power_mgmt = 1;
@@ -4700,14 +4704,14 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 	spec->gpio_dir = 0x01;
 	spec->gpio_data = 0x01;
 
-	switch (codec->vendor_id) {
+	switch (codec->core.vendor_id) {
 	case 0x111d76b6: /* 4 Port without Analog Mixer */
 	case 0x111d76b7:
 		unmute_init++;
 		break;
 	case 0x111d7608: /* 5 Port with Analog Mixer */
-		if ((codec->revision_id & 0xf) == 0 ||
-		    (codec->revision_id & 0xf) == 1)
+		if ((codec->core.revision_id & 0xf) == 0 ||
+		    (codec->core.revision_id & 0xf) == 1)
 			spec->stream_delay = 40; /* 40 milliseconds */
 
 		/* disable VSW */
@@ -4716,7 +4720,7 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 		snd_hda_codec_set_pincfg(codec, 0x19, 0x40f000f3);
 		break;
 	case 0x111d7603: /* 6 Port with Analog Mixer */
-		if ((codec->revision_id & 0xf) == 1)
+		if ((codec->core.revision_id & 0xf) == 1)
 			spec->stream_delay = 40; /* 40 milliseconds */
 
 		break;
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index d5d1dca4f11b..c36649c1f48d 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -140,7 +140,7 @@ static struct via_spec *via_new_spec(struct hda_codec *codec)
 
 static enum VIA_HDA_CODEC get_codec_type(struct hda_codec *codec)
 {
-	u32 vendor_id = codec->vendor_id;
+	u32 vendor_id = codec->core.vendor_id;
 	u16 ven_id = vendor_id >> 16;
 	u16 dev_id = vendor_id & 0xffff;
 	enum VIA_HDA_CODEC codec_type;
@@ -335,7 +335,7 @@ static void __analog_low_current_mode(struct hda_codec *codec, bool force)
 		return;		/* other codecs are not supported */
 	}
 	/* send verb */
-	snd_hda_codec_write(codec, codec->afg, 0, verb, parm);
+	snd_hda_codec_write(codec, codec->core.afg, 0, verb, parm);
 }
 
 static void analog_low_current_mode(struct hda_codec *codec)
@@ -558,7 +558,7 @@ static int vt1708_build_pcms(struct hda_codec *codec)
 	int i, err;
 
 	err = snd_hda_gen_build_pcms(codec);
-	if (err < 0 || codec->vendor_id != 0x11061708)
+	if (err < 0 || codec->core.vendor_id != 0x11061708)
 		return err;
 
 	/* We got noisy outputs on the right channel on VT1708 when
@@ -714,19 +714,19 @@ static int patch_vt1708S(struct hda_codec *codec)
 
 	/* correct names for VT1708BCE */
 	if (get_codec_type(codec) == VT1708BCE)	{
-		kfree(codec->chip_name);
-		codec->chip_name = kstrdup("VT1708BCE", GFP_KERNEL);
+		kfree(codec->core.chip_name);
+		codec->core.chip_name = kstrdup("VT1708BCE", GFP_KERNEL);
 		snprintf(codec->card->mixername,
 			 sizeof(codec->card->mixername),
-			 "%s %s", codec->vendor_name, codec->chip_name);
+			 "%s %s", codec->core.vendor_name, codec->core.chip_name);
 	}
 	/* correct names for VT1705 */
-	if (codec->vendor_id == 0x11064397)	{
-		kfree(codec->chip_name);
-		codec->chip_name = kstrdup("VT1705", GFP_KERNEL);
+	if (codec->core.vendor_id == 0x11064397) {
+		kfree(codec->core.chip_name);
+		codec->core.chip_name = kstrdup("VT1705", GFP_KERNEL);
 		snprintf(codec->card->mixername,
 			 sizeof(codec->card->mixername),
-			 "%s %s", codec->vendor_name, codec->chip_name);
+			 "%s %s", codec->core.vendor_name, codec->core.chip_name);
 	}
 
 	/* automatic parse from the BIOS config */
@@ -815,8 +815,7 @@ static int add_secret_dac_path(struct hda_codec *codec)
 	}
 
 	/* find the primary DAC and add to the connection list */
-	nid = codec->start_nid;
-	for (i = 0; i < codec->num_nodes; i++, nid++) {
+	for_each_hda_codec_node(nid, codec) {
 		unsigned int caps = get_wcaps(codec, nid);
 		if (get_wcaps_type(caps) == AC_WID_AUD_OUT &&
 		    !(caps & AC_WCAP_DIGITAL)) {
diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helper.c
index 6ba0b5517c40..0a4ad5feb82e 100644
--- a/sound/pci/hda/thinkpad_helper.c
+++ b/sound/pci/hda/thinkpad_helper.c
@@ -21,7 +21,7 @@ static acpi_status acpi_check_cb(acpi_handle handle, u32 lvl, void *context,
 static bool is_thinkpad(struct hda_codec *codec)
 {
 	bool found = false;
-	if (codec->subsystem_id >> 16 != 0x17aa)
+	if (codec->core.subsystem_id >> 16 != 0x17aa)
 		return false;
 	if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb, &found, NULL)) && found)
 		return true;
-- 
2.3.3
