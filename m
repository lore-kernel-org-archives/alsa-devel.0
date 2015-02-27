From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/7] ALSA: hda - Add regmap support
Date: Fri, 27 Feb 2015 22:28:16 +0100
Message-ID: <1425072502-3204-2-git-send-email-tiwai@suse.de>
References: <1425072502-3204-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CB712265176
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:28:27 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 56184ABE8
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 21:28:27 +0000 (UTC)
In-Reply-To: <1425072502-3204-1-git-send-email-tiwai@suse.de>
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

This patch adds an infrastructure to support regmap-based verb
accesses.  Because o the asymmetric nature of HD-audio verbs,
especially the amp verbs, we need to translate the verbs as a sort of
pseudo registers to be mapped uniquely in regmap.

In this patch, a pseudo register is built from the NID, the
AC_VERB_GET_* and 8bit parameters, i.e. almost in the form to be sent
to HD-audio bus but without codec address field.  OTOH, for writing,
the same pseudo register is translated to AC_VERB_SET_* automatically.
The AC_VERB_SET_AMP_* verb is re-encoded from the corresponding
AC_VERB_GET_AMP_* verb and parameter at writing.

Some verbs has a single command for read but multiple for writes.  A
write for such a verb is split automatically to multiple verbs.

The patch provides also a few handy helper functions.  They are
designed to be accessible even without regmap.  When no regmap is set
up (e.g. before the codec device instantiation), the direct hardware
access is used.  Also, it tries to avoid the unnecessary power-up.
The power up/down sequence is performed only on demand.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig      |   1 +
 sound/pci/hda/Makefile     |   3 +-
 sound/pci/hda/hda_bind.c   |   6 +
 sound/pci/hda/hda_codec.c  |   8 +-
 sound/pci/hda/hda_codec.h  |   6 +
 sound/pci/hda/hda_regmap.c | 375 +++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_regmap.h |  36 +++++
 7 files changed, 430 insertions(+), 5 deletions(-)
 create mode 100644 sound/pci/hda/hda_regmap.c
 create mode 100644 sound/pci/hda/hda_regmap.h

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 7f0f2c5a4e97..eda62d9fb2ea 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -5,6 +5,7 @@ config SND_HDA
 	select SND_PCM
 	select SND_VMASTER
 	select SND_KCTL_JACK
+	select REGMAP
 
 config SND_HDA_INTEL
 	tristate "HD Audio PCI"
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 96caaebfc19d..1f2c626c4ae6 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -4,7 +4,8 @@ snd-hda-tegra-objs := hda_tegra.o
 # for haswell power well
 snd-hda-intel-$(CONFIG_SND_HDA_I915) +=	hda_i915.o
 
-snd-hda-codec-y := hda_bind.o hda_codec.o hda_jack.o hda_auto_parser.o hda_sysfs.o
+snd-hda-codec-y := hda_bind.o hda_codec.o hda_jack.o hda_auto_parser.o hda_sysfs.o \
+	hda_regmap.o
 snd-hda-codec-$(CONFIG_PROC_FS) += hda_proc.o
 snd-hda-codec-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
 snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index ce2dd7b0dc07..8be97ffe10b2 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -11,6 +11,7 @@
 #include <linux/pm.h>
 #include <sound/core.h>
 #include "hda_codec.h"
+#include "hda_regmap.h"
 #include "hda_local.h"
 
 /* codec vendor labels */
@@ -105,6 +106,9 @@ static int hda_codec_driver_probe(struct device *dev)
 		goto error;
 	}
 
+	err = snd_hda_regmap_init(codec);
+	if (err < 0)
+		goto error;
 	err = codec->preset->patch(codec);
 	if (err < 0) {
 		module_put(owner);
@@ -116,6 +120,7 @@ static int hda_codec_driver_probe(struct device *dev)
  error:
 	codec->preset = NULL;
 	memset(&codec->patch_ops, 0, sizeof(codec->patch_ops));
+	snd_hda_regmap_exit(codec);
 	return err;
 }
 
@@ -127,6 +132,7 @@ static int hda_codec_driver_remove(struct device *dev)
 		codec->patch_ops.free(codec);
 	codec->preset = NULL;
 	memset(&codec->patch_ops, 0, sizeof(codec->patch_ops));
+	snd_hda_regmap_exit(codec);
 	module_put(dev->driver->owner);
 	return 0;
 }
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index db86b446743c..0fd71131193a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -147,8 +147,8 @@ make_codec_cmd(struct hda_codec *codec, hda_nid_t nid, int flags,
 /*
  * Send and receive a verb
  */
-static int codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
-			   int flags, unsigned int *res)
+int snd_hda_codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
+			    int flags, unsigned int *res)
 {
 	struct hda_bus *bus = codec->bus;
 	int err;
@@ -211,7 +211,7 @@ unsigned int snd_hda_codec_read(struct hda_codec *codec, hda_nid_t nid,
 {
 	unsigned cmd = make_codec_cmd(codec, nid, flags, verb, parm);
 	unsigned int res;
-	if (codec_exec_verb(codec, cmd, flags, &res))
+	if (snd_hda_codec_exec_verb(codec, cmd, flags, &res))
 		return -1;
 	return res;
 }
@@ -234,7 +234,7 @@ int snd_hda_codec_write(struct hda_codec *codec, hda_nid_t nid, int flags,
 {
 	unsigned int cmd = make_codec_cmd(codec, nid, flags, verb, parm);
 	unsigned int res;
-	return codec_exec_verb(codec, cmd, flags,
+	return snd_hda_codec_exec_verb(codec, cmd, flags,
 			       codec->bus->sync_write ? &res : NULL);
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_write);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 457fc589eb46..3be4e1040036 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -21,6 +21,7 @@
 #ifndef __SOUND_HDA_CODEC_H
 #define __SOUND_HDA_CODEC_H
 
+#include <linux/regmap.h>
 #include <sound/info.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
@@ -401,6 +402,9 @@ struct hda_codec {
 
 	/* additional init verbs */
 	struct snd_array verbs;
+
+	/* regmap */
+	struct regmap *regmap;
 };
 
 #define dev_to_hda_codec(_dev)	container_of(_dev, struct hda_codec, dev)
@@ -428,6 +432,8 @@ int snd_hda_codec_update_widgets(struct hda_codec *codec);
 /*
  * low level functions
  */
+int snd_hda_codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
+			    int flags, unsigned int *res);
 unsigned int snd_hda_codec_read(struct hda_codec *codec, hda_nid_t nid,
 				int flags,
 				unsigned int verb, unsigned int parm);
diff --git a/sound/pci/hda/hda_regmap.c b/sound/pci/hda/hda_regmap.c
new file mode 100644
index 000000000000..715d770901b5
--- /dev/null
+++ b/sound/pci/hda/hda_regmap.c
@@ -0,0 +1,375 @@
+/*
+ * Regmap support for HD-audio verbs
+ *
+ * A virtual register is translated to one or more hda verbs for write,
+ * vice versa for read.
+ *
+ * A few limitations:
+ * - Provided for not all verbs but only subset standard non-volatile verbs.
+ * - For reading, only AC_VERB_GET_* variants can be used.
+ * - For writing, mapped to the *corresponding* AC_VERB_SET_* variants,
+ *   so can't handle asymmetric verbs for read and write
+ */
+
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/export.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <sound/core.h>
+#include "hda_codec.h"
+#include "hda_regmap.h"
+
+#ifdef CONFIG_PM
+#define codec_is_running(codec)				\
+	(atomic_read(&(codec)->in_pm) ||		\
+	 !pm_runtime_suspended(hda_codec_dev(codec)))
+#else
+#define codec_is_running(codec)		true
+#endif
+
+#define get_verb(reg)	(((reg) >> 8) & 0xfff)
+
+static bool hda_writeable_reg(struct device *dev, unsigned int reg)
+{
+	unsigned int verb = get_verb(reg);
+
+	switch (verb & 0xf00) {
+	case AC_VERB_GET_STREAM_FORMAT:
+	case AC_VERB_GET_AMP_GAIN_MUTE:
+		return true;
+	case 0xf00:
+		break;
+	default:
+		return false;
+	}
+
+	switch (verb) {
+	case AC_VERB_GET_CONNECT_SEL:
+	case AC_VERB_GET_SDI_SELECT:
+	case AC_VERB_GET_CONV:
+	case AC_VERB_GET_PIN_WIDGET_CONTROL:
+	case AC_VERB_GET_UNSOLICITED_RESPONSE: /* only as SET_UNSOLICITED_ENABLE */
+	case AC_VERB_GET_BEEP_CONTROL:
+	case AC_VERB_GET_EAPD_BTLENABLE:
+	case AC_VERB_GET_DIGI_CONVERT_1:
+	case AC_VERB_GET_DIGI_CONVERT_2: /* only for beep control */
+	case AC_VERB_GET_VOLUME_KNOB_CONTROL:
+	case AC_VERB_GET_CONFIG_DEFAULT:
+	case AC_VERB_GET_GPIO_MASK:
+	case AC_VERB_GET_GPIO_DIRECTION:
+	case AC_VERB_GET_GPIO_DATA: /* not for volatile read */
+	case AC_VERB_GET_GPIO_UNSOLICITED_RSP_MASK:
+	case AC_VERB_GET_CVT_CHAN_COUNT:
+		return true;
+	}
+
+	return false;
+}
+
+static bool hda_readable_reg(struct device *dev, unsigned int reg)
+{
+	unsigned int verb = get_verb(reg);
+
+	switch (verb) {
+	case AC_VERB_PARAMETERS:
+	case AC_VERB_GET_CONNECT_LIST:
+	case AC_VERB_GET_SUBSYSTEM_ID:
+		return true;
+	}
+
+	return hda_writeable_reg(dev, reg);
+}
+
+static int hda_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct hda_codec *codec = context;
+
+	if (!codec_is_running(codec))
+		return -EAGAIN;
+
+	reg |= (codec->addr << 28);
+	if (snd_hda_codec_exec_verb(codec, reg, 0, val) < 0)
+		return -EIO;
+	return 0;
+}
+
+static int hda_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct hda_codec *codec = context;
+	unsigned int verb;
+	int i, bytes;
+
+	if (!codec_is_running(codec))
+		return 0; /* skip the h/w write, it'll be synced later */
+
+	reg &= ~0x00080000U; /* drop GET bit */
+	reg |= (codec->addr << 28);
+	verb = get_verb(reg);
+
+	switch (verb & 0xf00) {
+	case AC_VERB_SET_AMP_GAIN_MUTE:
+		verb = AC_VERB_SET_AMP_GAIN_MUTE;
+		if (reg & AC_AMP_GET_LEFT)
+			verb |= AC_AMP_SET_LEFT >> 8;
+		else
+			verb |= AC_AMP_SET_RIGHT >> 8;
+		if (reg & AC_AMP_GET_OUTPUT) {
+			verb |= AC_AMP_SET_OUTPUT >> 8;
+		} else {
+			verb |= AC_AMP_SET_INPUT >> 8;
+			verb |= reg & 0xf;
+		}
+		break;
+	}
+
+	switch (verb) {
+	case AC_VERB_SET_DIGI_CONVERT_1:
+		bytes = 2;
+		break;
+	case AC_VERB_SET_CONFIG_DEFAULT_BYTES_0:
+		bytes = 4;
+		break;
+	default:
+		bytes = 1;
+		break;
+	}
+
+	for (i = 0; i < bytes; i++) {
+		reg &= ~0xfffff;
+		reg |= (verb + i) << 8 | ((val >> (8 * i)) & 0xff);
+		if (snd_hda_codec_exec_verb(codec, reg, 0, NULL) < 0)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static const struct regmap_config hda_regmap_cfg = {
+	.name = "hdaudio",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.max_register = 0xfffffff,
+	.writeable_reg = hda_writeable_reg,
+	.readable_reg = hda_readable_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const struct regmap_bus hda_regmap_bus = {
+	.reg_read = hda_reg_read,
+	.reg_write = hda_reg_write,
+};
+
+int snd_hda_regmap_init(struct hda_codec *codec)
+{
+	struct regmap *regmap;
+
+	regmap = regmap_init(hda_codec_dev(codec), &hda_regmap_bus,
+			     codec, &hda_regmap_cfg);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+	codec->regmap = regmap;
+	return 0;
+}
+
+void snd_hda_regmap_exit(struct hda_codec *codec)
+{
+	if (codec->regmap) {
+		regmap_exit(codec->regmap);
+		codec->regmap = NULL;
+	}
+}
+
+/*
+ * helper functions
+ */
+
+/* write a pseudo-register value (w/o power sequence) */
+int snd_hda_reg_raw_write(struct hda_codec *codec, unsigned int reg,
+			  unsigned int val)
+{
+	if (!codec->regmap)
+		return hda_reg_write(codec, reg, val);
+	else
+		return regmap_write(codec->regmap, reg, val);
+}
+
+static int reg_raw_read(struct hda_codec *codec, unsigned int reg,
+			     unsigned int *val)
+{
+	if (!codec->regmap)
+		return hda_reg_read(codec, reg, val);
+	else
+		return regmap_read(codec->regmap, reg, val);
+}
+
+/* read a pseudo-register value;
+ * this function powers up the codec if necessary
+ */
+int snd_hda_reg_raw_read(struct hda_codec *codec, unsigned int reg,
+			 unsigned int *val)
+{
+	int err;
+
+	err = reg_raw_read(codec, reg, val);
+	if (err == -EAGAIN) {
+		snd_hda_power_up(codec);
+		err = reg_raw_read(codec, reg, val);
+		snd_hda_power_down(codec);
+	}
+	return err;
+}
+
+/* update a pseudo-register value;
+ * this function powers up the codec if necessary
+ */
+int snd_hda_reg_raw_update(struct hda_codec *codec, unsigned int reg,
+			   unsigned int mask, unsigned int val)
+{
+	unsigned int orig;
+	int err;
+
+	err = snd_hda_reg_raw_read(codec, reg, &orig);
+	if (err < 0)
+		return err;
+	if ((orig & mask) == val)
+		return 0;
+	orig &= ~mask;
+	orig |= val;
+	err = snd_hda_reg_raw_write(codec, reg, val);
+	if (err < 0)
+		return err;
+	return 1;
+}
+
+static inline unsigned int encode_reg(hda_nid_t nid, unsigned int verb)
+{
+	verb |= 0x800;
+	if (snd_BUG_ON((verb & 0xf00) == AC_VERB_GET_AMP_GAIN_MUTE))
+		verb = 0;
+	verb = (verb << 8) | (nid << 20);
+	return verb;
+}
+
+/**
+ * snd_hda_regmap_write - Write a verb with caching
+ * @nid: codec NID
+ * @reg: verb to write
+ * @val: value to write
+ *
+ * This function doesn't power up the codec but only updates cache
+ * if the device is suspended.  Wrap with snd_hda_power_up() and
+ * snd_hda_power_down() accordingly in the caller side if necessary.
+ *
+ * For writing an amp value, use snd_hda_regmap_amp_update().
+ */
+int snd_hda_regmap_write(struct hda_codec *codec, hda_nid_t nid,
+			 unsigned int verb, unsigned int val)
+{
+	return snd_hda_reg_raw_write(codec, encode_reg(nid, verb), val);
+}
+EXPORT_SYMBOL_GPL(snd_hda_regmap_write);
+
+/**
+ * snd_hda_regmap_update_bits - Update a verb value with caching
+ * @nid: codec NID
+ * @verb: verb to update
+ * @mask: bit mask to update
+ * @val: value to update
+ *
+ * This function doesn't always power up the codec but only updates cache
+ * if the device is suspended.  Wrap with snd_hda_power_up() and
+ * snd_hda_power_down() accordingly in the caller side if necessary.
+ *
+ * For updating an amp value, use snd_hda_regmap_amp_update().
+ */
+int snd_hda_regmap_update_bits(struct hda_codec *codec, hda_nid_t nid,
+			       unsigned int verb, unsigned int mask,
+			       unsigned int val)
+{
+	return snd_hda_reg_raw_update(codec, encode_reg(nid, verb), mask, val);
+}
+EXPORT_SYMBOL_GPL(snd_hda_regmap_update_bits);
+
+/**
+ * snd_hda_regmap_read - Read a verb with caching
+ * @nid: codec NID
+ * @verb: verb to read
+ * @val: pointer to store the value
+ *
+ * For reading an amp value, use snd_hda_regmap_get_amp().
+ */
+int snd_hda_regmap_read(struct hda_codec *codec, hda_nid_t nid,
+			unsigned int verb, unsigned int *val)
+{
+	return snd_hda_reg_raw_read(codec, encode_reg(nid, verb), val);
+}
+EXPORT_SYMBOL_GPL(snd_hda_regmap_read);
+
+/* encode to a pseudo-register from amp attributes */
+static inline unsigned int encode_amp(hda_nid_t nid, int ch, int dir, int idx)
+{
+	unsigned int val;
+
+	val = (nid << 20) | (AC_VERB_GET_AMP_GAIN_MUTE << 8);
+	if (ch)
+		val |= AC_AMP_GET_RIGHT;
+	else
+		val |= AC_AMP_GET_LEFT;
+	if (dir == HDA_OUTPUT)
+		val |= AC_AMP_GET_OUTPUT;
+	else
+		val |= AC_AMP_GET_INPUT;
+	val |= idx;
+	return val;
+}
+
+/**
+ * snd_hda_regmap_get_amp - Read AMP value
+ * @codec: HD-audio codec
+ * @nid: NID to read the AMP value
+ * @ch: channel (left=0 or right=1)
+ * @direction: #HDA_INPUT or #HDA_OUTPUT
+ * @index: the index value (only for input direction)
+ * @val: the pointer to store the value
+ *
+ * Read AMP value.  The volume is between 0 to 0x7f, 0x80 = mute bit.
+ * Returns the value or a negative error.
+ */
+int snd_hda_regmap_amp_get(struct hda_codec *codec, hda_nid_t nid,
+			   int ch, int dir, int idx)
+{
+	int err, val;
+
+	err = snd_hda_reg_raw_read(codec,
+				   encode_amp(nid, ch, dir, idx), &val);
+	return err < 0 ? err : val;
+}
+EXPORT_SYMBOL_GPL(snd_hda_regmap_amp_get);
+
+/**
+ * snd_hda_regmap_amp_update - update the AMP value
+ * @codec: HD-audio codec
+ * @nid: NID to read the AMP value
+ * @ch: channel (left=0 or right=1)
+ * @direction: #HDA_INPUT or #HDA_OUTPUT
+ * @idx: the index value (only for input direction)
+ * @mask: bit mask to set
+ * @val: the bits value to set
+ *
+ * Update the AMP value with a bit mask.
+ * Returns 0 if the value is unchanged, 1 if changed, or a negative error.
+ *
+ * This function doesn't always power up the codec but only updates cache
+ * if the device is suspended.  Wrap with snd_hda_power_up() and
+ * snd_hda_power_down() accordingly in the caller side if necessary.
+ */
+int snd_hda_regmap_amp_update(struct hda_codec *codec, hda_nid_t nid,
+			      int ch, int dir, int idx, int mask, int val)
+{
+	return snd_hda_reg_raw_update(codec,
+				      encode_amp(nid, ch, dir, idx),
+				      mask, val);
+}
+EXPORT_SYMBOL_GPL(snd_hda_regmap_amp_update);
diff --git a/sound/pci/hda/hda_regmap.h b/sound/pci/hda/hda_regmap.h
new file mode 100644
index 000000000000..7d4b8be58975
--- /dev/null
+++ b/sound/pci/hda/hda_regmap.h
@@ -0,0 +1,36 @@
+/*
+ * HD-audio regmap helpers
+ */
+
+#ifndef __HDA_REGMAP_H
+#define __HDA_REGMAP_H
+
+#include <linux/regmap.h>
+#include <sound/core.h>
+#include <sound/hda_verbs.h>
+#include "hda_codec.h"
+
+int snd_hda_regmap_init(struct hda_codec *codec);
+void snd_hda_regmap_exit(struct hda_codec *codec);
+
+int snd_hda_regmap_write(struct hda_codec *codec, hda_nid_t nid,
+			 unsigned int verb, unsigned int val);
+int snd_hda_regmap_update_bits(struct hda_codec *codec, hda_nid_t nid,
+			       unsigned int verb, unsigned int mask,
+			       unsigned int val);
+int snd_hda_regmap_read(struct hda_codec *codec, hda_nid_t nid,
+			unsigned int verb, unsigned int *val);
+
+int snd_hda_regmap_amp_get(struct hda_codec *codec, hda_nid_t nid,
+			   int ch, int dir, int idx);
+int snd_hda_regmap_amp_update(struct hda_codec *codec, hda_nid_t nid,
+			      int ch, int dir, int idx, int mask, int val);
+
+int snd_hda_reg_raw_read(struct hda_codec *codec, unsigned int reg,
+			 unsigned int *val);
+int snd_hda_reg_raw_write(struct hda_codec *codec, unsigned int reg,
+			  unsigned int val);
+int snd_hda_reg_raw_update(struct hda_codec *codec, unsigned int reg,
+			   unsigned int mask, unsigned int val);
+
+#endif /* __HDA_REGMAP_H */
-- 
2.3.0
