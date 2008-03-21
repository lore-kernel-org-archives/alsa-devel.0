From: Daniel Jacobowitz <drow@false.org>
Subject: Re: [RFC] [Patch 1/2] Add virtual master control
Date: Fri, 21 Mar 2008 15:08:55 -0400
Message-ID: <20080321190855.GA24510@caradoc.them.org>
References: <s5hprx12x6x.wl%tiwai@suse.de> <s5hlk7p2wvm.wl%tiwai@suse.de>
	<20080130151909.GA11068@caradoc.them.org>
	<s5hprvj2v1w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nan.false.org (NaN.false.org [208.75.86.248])
	by alsa0.perex.cz (Postfix) with ESMTP id A666C2440F
	for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2008 20:08:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hprvj2v1w.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 30, 2008 at 04:27:07PM +0100, Takashi Iwai wrote:
> Because HD-audio is the only user, so far.  I don't want to expand the
> core stuff (and kconfig) unless really needed.

I said I'd want this for ice1724 / vt1616, and I finally got time to
do it.  What do you think of this patch?  I'm happily using it.

From: Daniel Jacobowitz <dan@codesourcery.com>

Move VMASTER from HDA out to core, and enable it for VT1616.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

diff --git a/include/sound/control.h b/include/sound/control.h
index e79baa6..3dc1291 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -169,4 +169,11 @@ int snd_ctl_boolean_mono_info(struct snd_kcontrol *kcontrol,
 int snd_ctl_boolean_stereo_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo);
 
+/*
+ * virtual master control
+ */
+struct snd_kcontrol *snd_ctl_make_virtual_master(char *name,
+						 const unsigned int *tlv);
+int snd_ctl_add_slave(struct snd_kcontrol *master, struct snd_kcontrol *slave);
+		      
 #endif	/* __SOUND_CONTROL_H */
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 829ca38..b0528c4 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -16,6 +16,9 @@ config SND_RAWMIDI
 	tristate
 	depends on SND
 
+config SND_VMASTER
+       bool
+
 config SND_SEQUENCER
 	tristate "Sequencer support"
 	depends on SND
diff --git a/sound/core/Makefile b/sound/core/Makefile
index 267039a..da8e685 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -6,6 +6,7 @@
 snd-y     := sound.o init.o memory.o info.o control.o misc.o device.o
 snd-$(CONFIG_ISA_DMA_API) += isadma.o
 snd-$(CONFIG_SND_OSSEMUL) += sound_oss.o info_oss.o
+snd-$(CONFIG_SND_VMASTER) += vmaster.o
 
 snd-pcm-objs := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
 		pcm_memory.o
diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
new file mode 100644
index 0000000..7cfd8b8
--- /dev/null
+++ b/sound/core/vmaster.c
@@ -0,0 +1,368 @@
+/*
+ * Virtual master and slave controls
+ *
+ *  Copyright (c) 2008 by Takashi Iwai <tiwai@suse.de>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License as
+ *  published by the Free Software Foundation, version 2.
+ *
+ */
+
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/control.h>
+
+/*
+ * a subset of information returned via ctl info callback
+ */
+struct link_ctl_info {
+	int type;		/* value type */
+	int count;		/* item count */
+	int min_val, max_val;	/* min, max values */
+};
+
+/*
+ * link master - this contains a list of slave controls that are
+ * identical types, i.e. info returns the same value type and value
+ * ranges, but may have different number of counts.
+ *
+ * The master control is so far only mono volume/switch for simplicity.
+ * The same value will be applied to all slaves.
+ */
+struct link_master {
+	struct list_head slaves;
+	struct link_ctl_info info;
+	int val;		/* the master value */
+};
+
+/*
+ * link slave - this contains a slave control element
+ *
+ * It fakes the control callbacsk with additional attenuation by the
+ * master control.  A slave may have either one or two channels.
+ */
+
+struct link_slave {
+	struct list_head list;
+	struct link_master *master;
+	struct link_ctl_info info;
+	int vals[2];		/* current values */
+	struct snd_kcontrol slave; /* the copy of original control entry */
+};
+
+/* get the slave ctl info and save the initial values */
+static int slave_init(struct link_slave *slave)
+{
+	struct snd_ctl_elem_info *uinfo;
+	struct snd_ctl_elem_value *uctl;
+	int err, ch;
+
+	if (slave->info.count)
+		return 0; /* already initialized */
+
+	uinfo = kmalloc(sizeof(*uinfo), GFP_KERNEL);
+	if (!uinfo)
+		return -ENOMEM;
+	uinfo->id = slave->slave.id;
+	err = slave->slave.info(&slave->slave, uinfo);
+	if (err < 0) {
+		kfree(uinfo);
+		return err;
+	}
+	slave->info.type = uinfo->type;
+	slave->info.count = uinfo->count;
+	if (slave->info.count > 2  ||
+	    (slave->info.type != SNDRV_CTL_ELEM_TYPE_INTEGER &&
+	     slave->info.type != SNDRV_CTL_ELEM_TYPE_BOOLEAN)) {
+		snd_printk(KERN_ERR "invalid slave element\n");
+		kfree(uinfo);
+		return -EINVAL;
+	}
+	slave->info.min_val = uinfo->value.integer.min;
+	slave->info.max_val = uinfo->value.integer.max;
+	kfree(uinfo);
+
+	uctl = kmalloc(sizeof(*uctl), GFP_KERNEL);
+	if (!uctl)
+		return -ENOMEM;
+	uctl->id = slave->slave.id;
+	err = slave->slave.get(&slave->slave, uctl);
+	for (ch = 0; ch < slave->info.count; ch++)
+		slave->vals[ch] = uctl->value.integer.value[ch];
+	kfree(uctl);
+	return 0;
+}
+
+/* initialize master volume */
+static int master_init(struct link_master *master)
+{
+	struct link_slave *slave;
+
+	if (master->info.count)
+		return 0; /* already initialized */
+
+	list_for_each_entry(slave, &master->slaves, list) {
+		int err = slave_init(slave);
+		if (err < 0)
+			return err;
+		master->info = slave->info;
+		master->info.count = 1; /* always mono */
+		/* set full volume as default (= no attenuation) */
+		master->val = master->info.max_val;
+		return 0;
+	}
+	return -ENOENT;
+}
+
+static int slave_get_val(struct link_slave *slave,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	int err, ch;
+
+	err = slave_init(slave);
+	if (err < 0)
+		return err;
+	for (ch = 0; ch < slave->info.count; ch++)
+		ucontrol->value.integer.value[ch] = slave->vals[ch];
+	return 0;
+}
+
+static int slave_put_val(struct link_slave *slave,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	int err, ch, vol;
+
+	err = master_init(slave->master);
+	if (err < 0)
+		return err;
+
+	switch (slave->info.type) {
+	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
+		for (ch = 0; ch < slave->info.count; ch++)
+			ucontrol->value.integer.value[ch] &=
+				!!slave->master->val;
+		break;
+	case SNDRV_CTL_ELEM_TYPE_INTEGER:
+		for (ch = 0; ch < slave->info.count; ch++) {
+			/* max master volume is supposed to be 0 dB */
+			vol = ucontrol->value.integer.value[ch];
+			vol += slave->master->val - slave->master->info.max_val;
+			if (vol < slave->info.min_val)
+				vol = slave->info.min_val;
+			else if (vol > slave->info.max_val)
+				vol = slave->info.max_val;
+			ucontrol->value.integer.value[ch] = vol;
+		}
+		break;
+	}
+	return slave->slave.put(&slave->slave, ucontrol);
+}
+
+/*
+ * ctl callbacks for slaves
+ */
+static int slave_info(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_info *uinfo)
+{
+	struct link_slave *slave = snd_kcontrol_chip(kcontrol);
+	return slave->slave.info(&slave->slave, uinfo);
+}
+
+static int slave_get(struct snd_kcontrol *kcontrol,
+		     struct snd_ctl_elem_value *ucontrol)
+{
+	struct link_slave *slave = snd_kcontrol_chip(kcontrol);
+	return slave_get_val(slave, ucontrol);
+}
+
+static int slave_put(struct snd_kcontrol *kcontrol,
+		     struct snd_ctl_elem_value *ucontrol)
+{
+	struct link_slave *slave = snd_kcontrol_chip(kcontrol);
+	int err, ch, changed = 0;
+
+	err = slave_init(slave);
+	if (err < 0)
+		return err;
+	for (ch = 0; ch < slave->info.count; ch++) {
+		if (slave->vals[ch] != ucontrol->value.integer.value[ch]) {
+			changed = 1;
+			slave->vals[ch] = ucontrol->value.integer.value[ch];
+		}
+	}
+	if (!changed)
+		return 0;
+	return slave_put_val(slave, ucontrol);
+}
+
+static int slave_tlv_cmd(struct snd_kcontrol *kcontrol,
+			 int op_flag, unsigned int size,
+			 unsigned int __user *tlv)
+{
+	struct link_slave *slave = snd_kcontrol_chip(kcontrol);
+	/* FIXME: this assumes that the max volume is 0 dB */
+	return slave->slave.tlv.c(&slave->slave, op_flag, size, tlv);
+}
+
+static void slave_free(struct snd_kcontrol *kcontrol)
+{
+	struct link_slave *slave = snd_kcontrol_chip(kcontrol);
+	if (slave->slave.private_free)
+		slave->slave.private_free(&slave->slave);
+	if (slave->master)
+		list_del(&slave->list);
+	kfree(slave);
+}
+
+/*
+ * Add a slave control to the group with the given master control
+ *
+ * All slaves must be the same type (returning the same information
+ * via info callback).  The fucntion doesn't check it, so it's your
+ * responsibility.
+ *
+ * Also, some additional limitations:
+ * - at most two channels
+ * - logarithmic volume control (dB level), no linear volume
+ * - master can only attenuate the volume, no gain
+ */
+int snd_ctl_add_slave(struct snd_kcontrol *master, struct snd_kcontrol *slave)
+{
+	struct link_master *master_link = snd_kcontrol_chip(master);
+	struct link_slave *srec;
+
+	srec = kzalloc(sizeof(*srec) +
+		       slave->count * sizeof(*slave->vd), GFP_KERNEL);
+	if (!srec)
+		return -ENOMEM;
+	srec->slave = *slave;
+	memcpy(srec->slave.vd, slave->vd, slave->count * sizeof(*slave->vd));
+	srec->master = master_link;
+
+	/* override callbacks */
+	slave->info = slave_info;
+	slave->get = slave_get;
+	slave->put = slave_put;
+	if (slave->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK)
+		slave->tlv.c = slave_tlv_cmd;
+	slave->private_data = srec;
+	slave->private_free = slave_free;
+
+	list_add_tail(&srec->list, &master_link->slaves);
+	return 0;
+}
+
+EXPORT_SYMBOL(snd_ctl_add_slave);
+
+/*
+ * ctl callbacks for master controls
+ */
+static int master_info(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_info *uinfo)
+{
+	struct link_master *master = snd_kcontrol_chip(kcontrol);
+	int ret;
+
+	ret = master_init(master);
+	if (ret < 0)
+		return ret;
+	uinfo->type = master->info.type;
+	uinfo->count = master->info.count;
+	uinfo->value.integer.min = master->info.min_val;
+	uinfo->value.integer.max = master->info.max_val;
+	return 0;
+}
+
+static int master_get(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct link_master *master = snd_kcontrol_chip(kcontrol);
+	int err = master_init(master);
+	if (err < 0)
+		return err;
+	ucontrol->value.integer.value[0] = master->val;
+	return 0;
+}
+
+static int master_put(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct link_master *master = snd_kcontrol_chip(kcontrol);
+	struct link_slave *slave;
+	struct snd_ctl_elem_value *uval;
+	int err, old_val;
+
+	err = master_init(master);
+	if (err < 0)
+		return err;
+	old_val = master->val;
+	if (ucontrol->value.integer.value[0] == old_val)
+		return 0;
+
+	uval = kmalloc(sizeof(*uval), GFP_KERNEL);
+	if (!uval)
+		return -ENOMEM;
+	list_for_each_entry(slave, &master->slaves, list) {
+		master->val = old_val;
+		uval->id = slave->slave.id;
+		slave_get_val(slave, uval);
+		master->val = ucontrol->value.integer.value[0];
+		slave_put_val(slave, uval);
+	}
+	kfree(uval);
+	return 1;
+}
+
+static void master_free(struct snd_kcontrol *kcontrol)
+{
+	struct link_master *master = snd_kcontrol_chip(kcontrol);
+	struct link_slave *slave;
+
+	list_for_each_entry(slave, &master->slaves, list)
+		slave->master = NULL;
+	kfree(master);
+}
+
+
+/*
+ * Create a virtual master control with the given name
+ */
+struct snd_kcontrol *snd_ctl_make_virtual_master(char *name,
+						 const unsigned int *tlv)
+{
+	struct link_master *master;
+	struct snd_kcontrol *kctl;
+	struct snd_kcontrol_new knew;
+
+	memset(&knew, 0, sizeof(knew));
+	knew.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	knew.name = name;
+	knew.info = master_info;
+
+	master = kzalloc(sizeof(*master), GFP_KERNEL);
+	if (!master)
+		return NULL;
+	INIT_LIST_HEAD(&master->slaves);
+
+	kctl = snd_ctl_new1(&knew, master);
+	if (!kctl) {
+		kfree(master);
+		return NULL;
+	}
+	/* override some callbacks */
+	kctl->info = master_info;
+	kctl->get = master_get;
+	kctl->put = master_put;
+	kctl->private_free = master_free;
+
+	/* additional (constant) TLV read */
+	if (tlv) {
+		/* FIXME: this assumes that the max volume is 0 dB */
+		kctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_TLV_READ;
+		kctl->tlv.p = tlv;
+	}
+	return kctl;
+}
+
+EXPORT_SYMBOL(snd_ctl_make_virtual_master);
diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 75d4fe0..154e0ae 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -27,6 +27,7 @@ config SND_AC97_CODEC
 	tristate
 	select SND_PCM
 	select AC97_BUS
+	select SND_VMASTER
 
 config SND_DUMMY
 	tristate "Dummy (/dev/null) soundcard"
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 812085d..48296d9 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -517,6 +517,7 @@ config SND_HDA_INTEL
 	tristate "Intel HD Audio"
 	depends on SND
 	select SND_PCM
+	select SND_VMASTER
 	help
 	  Say Y here to include support for Intel "High Definition
 	  Audio" (Azalia) motherboard devices.
diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index 50c637e..2019602 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -3312,8 +3312,66 @@ AC97_SINGLE("Downmix LFE and Center to Front", 0x5a, 12, 1, 0),
 AC97_SINGLE("Downmix Surround to Front", 0x5a, 11, 1, 0),
 };
 
+static const char *slave_vols_vt1616[] = {
+	"Front Playback Volume",
+	"Surround Playback Volume",
+	"Center Playback Volume",
+	"LFE Playback Volume",
+	NULL
+};
+
+static const char *slave_sws_vt1616[] = {
+	"Front Playback Switch",
+	"Surround Playback Switch",
+	"Center Playback Switch",
+	"LFE Playback Switch",
+	NULL
+};
+
+/* find a mixer control element with the given name */
+static struct snd_kcontrol *snd_ac97_find_mixer_ctl(struct snd_ac97 *ac97,
+						    const char *name)
+{
+	struct snd_ctl_elem_id id;
+	memset(&id, 0, sizeof(id));
+	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	strcpy(id.name, name);
+	return snd_ctl_find_id(ac97->bus->card, &id);
+}
+
+/* create a virtual master control and add slaves */
+int snd_ac97_add_vmaster(struct snd_ac97 *ac97, char *name,
+			 const unsigned int *tlv, const char **slaves)
+{
+	struct snd_kcontrol *kctl;
+	const char **s;
+	int err;
+
+	kctl = snd_ctl_make_virtual_master(name, tlv);
+	if (!kctl)
+		return -ENOMEM;
+	err = snd_ctl_add(ac97->bus->card, kctl);
+	if (err < 0)
+		return err;
+	
+	for (s = slaves; *s; s++) {
+		struct snd_kcontrol *sctl;
+
+		sctl = snd_ac97_find_mixer_ctl(ac97, *s);
+		if (!sctl) {
+			snd_printdd("Cannot find slave %s, skipped\n", *s);
+			continue;
+		}
+		err = snd_ctl_add_slave(kctl, sctl);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
 static int patch_vt1616_specific(struct snd_ac97 * ac97)
 {
+	struct snd_kcontrol *kctl;
 	int err;
 
 	if (snd_ac97_try_bit(ac97, 0x5a, 9))
@@ -3321,6 +3379,24 @@ static int patch_vt1616_specific(struct snd_ac97 * ac97)
 			return err;
 	if ((err = patch_build_controls(ac97, &snd_ac97_controls_vt1616[1], ARRAY_SIZE(snd_ac97_controls_vt1616) - 1)) < 0)
 		return err;
+
+	/* There is already a misnamed master switch.  Rename it.  */
+	kctl = snd_ac97_find_mixer_ctl(ac97, "Master Playback Volume");
+	if (!kctl)
+		return -EINVAL;
+
+	snd_ac97_rename_vol_ctl(ac97, "Master Playback", "Front Playback");
+
+	err = snd_ac97_add_vmaster(ac97, "Master Playback Volume",
+				   kctl->tlv.p, slave_vols_vt1616);
+	if (err < 0)
+		return err;
+
+	err = snd_ac97_add_vmaster(ac97, "Master Playback Switch",
+				   NULL, slave_sws_vt1616);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 9e0d8a1..ab0c726 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -2,7 +2,7 @@ snd-hda-intel-y := hda_intel.o
 # since snd-hda-intel is the only driver using hda-codec,
 # merge it into a single module although it was originally
 # designed to be individual modules
-snd-hda-intel-y += hda_codec.o vmaster.o
+snd-hda-intel-y += hda_codec.o
 snd-hda-intel-$(CONFIG_PROC_FS) += hda_proc.o
 snd-hda-intel-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
 snd-hda-intel-$(CONFIG_SND_HDA_GENERIC) += hda_generic.o
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index ad0014a..5a859d8 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -407,11 +407,4 @@ int snd_hda_check_amp_list_power(struct hda_codec *codec,
 				 hda_nid_t nid);
 #endif /* CONFIG_SND_HDA_POWER_SAVE */
 
-/*
- * virtual master control
- */
-struct snd_kcontrol *snd_ctl_make_virtual_master(char *name,
-						 const unsigned int *tlv);
-int snd_ctl_add_slave(struct snd_kcontrol *master, struct snd_kcontrol *slave);
-		      
 #endif /* __SOUND_HDA_LOCAL_H */
diff --git a/sound/pci/hda/vmaster.c b/sound/pci/hda/vmaster.c
deleted file mode 100644
index 2da49d2..0000000
--- a/sound/pci/hda/vmaster.c
+++ /dev/null
@@ -1,364 +0,0 @@
-/*
- * Virtual master and slave controls
- *
- *  Copyright (c) 2008 by Takashi Iwai <tiwai@suse.de>
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License as
- *  published by the Free Software Foundation, version 2.
- *
- */
-
-#include <linux/slab.h>
-#include <sound/core.h>
-#include <sound/control.h>
-
-/*
- * a subset of information returned via ctl info callback
- */
-struct link_ctl_info {
-	int type;		/* value type */
-	int count;		/* item count */
-	int min_val, max_val;	/* min, max values */
-};
-
-/*
- * link master - this contains a list of slave controls that are
- * identical types, i.e. info returns the same value type and value
- * ranges, but may have different number of counts.
- *
- * The master control is so far only mono volume/switch for simplicity.
- * The same value will be applied to all slaves.
- */
-struct link_master {
-	struct list_head slaves;
-	struct link_ctl_info info;
-	int val;		/* the master value */
-};
-
-/*
- * link slave - this contains a slave control element
- *
- * It fakes the control callbacsk with additional attenuation by the
- * master control.  A slave may have either one or two channels.
- */
-
-struct link_slave {
-	struct list_head list;
-	struct link_master *master;
-	struct link_ctl_info info;
-	int vals[2];		/* current values */
-	struct snd_kcontrol slave; /* the copy of original control entry */
-};
-
-/* get the slave ctl info and save the initial values */
-static int slave_init(struct link_slave *slave)
-{
-	struct snd_ctl_elem_info *uinfo;
-	struct snd_ctl_elem_value *uctl;
-	int err, ch;
-
-	if (slave->info.count)
-		return 0; /* already initialized */
-
-	uinfo = kmalloc(sizeof(*uinfo), GFP_KERNEL);
-	if (!uinfo)
-		return -ENOMEM;
-	uinfo->id = slave->slave.id;
-	err = slave->slave.info(&slave->slave, uinfo);
-	if (err < 0) {
-		kfree(uinfo);
-		return err;
-	}
-	slave->info.type = uinfo->type;
-	slave->info.count = uinfo->count;
-	if (slave->info.count > 2  ||
-	    (slave->info.type != SNDRV_CTL_ELEM_TYPE_INTEGER &&
-	     slave->info.type != SNDRV_CTL_ELEM_TYPE_BOOLEAN)) {
-		snd_printk(KERN_ERR "invalid slave element\n");
-		kfree(uinfo);
-		return -EINVAL;
-	}
-	slave->info.min_val = uinfo->value.integer.min;
-	slave->info.max_val = uinfo->value.integer.max;
-	kfree(uinfo);
-
-	uctl = kmalloc(sizeof(*uctl), GFP_KERNEL);
-	if (!uctl)
-		return -ENOMEM;
-	uctl->id = slave->slave.id;
-	err = slave->slave.get(&slave->slave, uctl);
-	for (ch = 0; ch < slave->info.count; ch++)
-		slave->vals[ch] = uctl->value.integer.value[ch];
-	kfree(uctl);
-	return 0;
-}
-
-/* initialize master volume */
-static int master_init(struct link_master *master)
-{
-	struct link_slave *slave;
-
-	if (master->info.count)
-		return 0; /* already initialized */
-
-	list_for_each_entry(slave, &master->slaves, list) {
-		int err = slave_init(slave);
-		if (err < 0)
-			return err;
-		master->info = slave->info;
-		master->info.count = 1; /* always mono */
-		/* set full volume as default (= no attenuation) */
-		master->val = master->info.max_val;
-		return 0;
-	}
-	return -ENOENT;
-}
-
-static int slave_get_val(struct link_slave *slave,
-			 struct snd_ctl_elem_value *ucontrol)
-{
-	int err, ch;
-
-	err = slave_init(slave);
-	if (err < 0)
-		return err;
-	for (ch = 0; ch < slave->info.count; ch++)
-		ucontrol->value.integer.value[ch] = slave->vals[ch];
-	return 0;
-}
-
-static int slave_put_val(struct link_slave *slave,
-			 struct snd_ctl_elem_value *ucontrol)
-{
-	int err, ch, vol;
-
-	err = master_init(slave->master);
-	if (err < 0)
-		return err;
-
-	switch (slave->info.type) {
-	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
-		for (ch = 0; ch < slave->info.count; ch++)
-			ucontrol->value.integer.value[ch] &=
-				!!slave->master->val;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_INTEGER:
-		for (ch = 0; ch < slave->info.count; ch++) {
-			/* max master volume is supposed to be 0 dB */
-			vol = ucontrol->value.integer.value[ch];
-			vol += slave->master->val - slave->master->info.max_val;
-			if (vol < slave->info.min_val)
-				vol = slave->info.min_val;
-			else if (vol > slave->info.max_val)
-				vol = slave->info.max_val;
-			ucontrol->value.integer.value[ch] = vol;
-		}
-		break;
-	}
-	return slave->slave.put(&slave->slave, ucontrol);
-}
-
-/*
- * ctl callbacks for slaves
- */
-static int slave_info(struct snd_kcontrol *kcontrol,
-		      struct snd_ctl_elem_info *uinfo)
-{
-	struct link_slave *slave = snd_kcontrol_chip(kcontrol);
-	return slave->slave.info(&slave->slave, uinfo);
-}
-
-static int slave_get(struct snd_kcontrol *kcontrol,
-		     struct snd_ctl_elem_value *ucontrol)
-{
-	struct link_slave *slave = snd_kcontrol_chip(kcontrol);
-	return slave_get_val(slave, ucontrol);
-}
-
-static int slave_put(struct snd_kcontrol *kcontrol,
-		     struct snd_ctl_elem_value *ucontrol)
-{
-	struct link_slave *slave = snd_kcontrol_chip(kcontrol);
-	int err, ch, changed = 0;
-
-	err = slave_init(slave);
-	if (err < 0)
-		return err;
-	for (ch = 0; ch < slave->info.count; ch++) {
-		if (slave->vals[ch] != ucontrol->value.integer.value[ch]) {
-			changed = 1;
-			slave->vals[ch] = ucontrol->value.integer.value[ch];
-		}
-	}
-	if (!changed)
-		return 0;
-	return slave_put_val(slave, ucontrol);
-}
-
-static int slave_tlv_cmd(struct snd_kcontrol *kcontrol,
-			 int op_flag, unsigned int size,
-			 unsigned int __user *tlv)
-{
-	struct link_slave *slave = snd_kcontrol_chip(kcontrol);
-	/* FIXME: this assumes that the max volume is 0 dB */
-	return slave->slave.tlv.c(&slave->slave, op_flag, size, tlv);
-}
-
-static void slave_free(struct snd_kcontrol *kcontrol)
-{
-	struct link_slave *slave = snd_kcontrol_chip(kcontrol);
-	if (slave->slave.private_free)
-		slave->slave.private_free(&slave->slave);
-	if (slave->master)
-		list_del(&slave->list);
-	kfree(slave);
-}
-
-/*
- * Add a slave control to the group with the given master control
- *
- * All slaves must be the same type (returning the same information
- * via info callback).  The fucntion doesn't check it, so it's your
- * responsibility.
- *
- * Also, some additional limitations:
- * - at most two channels
- * - logarithmic volume control (dB level), no linear volume
- * - master can only attenuate the volume, no gain
- */
-int snd_ctl_add_slave(struct snd_kcontrol *master, struct snd_kcontrol *slave)
-{
-	struct link_master *master_link = snd_kcontrol_chip(master);
-	struct link_slave *srec;
-
-	srec = kzalloc(sizeof(*srec) +
-		       slave->count * sizeof(*slave->vd), GFP_KERNEL);
-	if (!srec)
-		return -ENOMEM;
-	srec->slave = *slave;
-	memcpy(srec->slave.vd, slave->vd, slave->count * sizeof(*slave->vd));
-	srec->master = master_link;
-
-	/* override callbacks */
-	slave->info = slave_info;
-	slave->get = slave_get;
-	slave->put = slave_put;
-	if (slave->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK)
-		slave->tlv.c = slave_tlv_cmd;
-	slave->private_data = srec;
-	slave->private_free = slave_free;
-
-	list_add_tail(&srec->list, &master_link->slaves);
-	return 0;
-}
-
-/*
- * ctl callbacks for master controls
- */
-static int master_info(struct snd_kcontrol *kcontrol,
-		      struct snd_ctl_elem_info *uinfo)
-{
-	struct link_master *master = snd_kcontrol_chip(kcontrol);
-	int ret;
-
-	ret = master_init(master);
-	if (ret < 0)
-		return ret;
-	uinfo->type = master->info.type;
-	uinfo->count = master->info.count;
-	uinfo->value.integer.min = master->info.min_val;
-	uinfo->value.integer.max = master->info.max_val;
-	return 0;
-}
-
-static int master_get(struct snd_kcontrol *kcontrol,
-		      struct snd_ctl_elem_value *ucontrol)
-{
-	struct link_master *master = snd_kcontrol_chip(kcontrol);
-	int err = master_init(master);
-	if (err < 0)
-		return err;
-	ucontrol->value.integer.value[0] = master->val;
-	return 0;
-}
-
-static int master_put(struct snd_kcontrol *kcontrol,
-		      struct snd_ctl_elem_value *ucontrol)
-{
-	struct link_master *master = snd_kcontrol_chip(kcontrol);
-	struct link_slave *slave;
-	struct snd_ctl_elem_value *uval;
-	int err, old_val;
-
-	err = master_init(master);
-	if (err < 0)
-		return err;
-	old_val = master->val;
-	if (ucontrol->value.integer.value[0] == old_val)
-		return 0;
-
-	uval = kmalloc(sizeof(*uval), GFP_KERNEL);
-	if (!uval)
-		return -ENOMEM;
-	list_for_each_entry(slave, &master->slaves, list) {
-		master->val = old_val;
-		uval->id = slave->slave.id;
-		slave_get_val(slave, uval);
-		master->val = ucontrol->value.integer.value[0];
-		slave_put_val(slave, uval);
-	}
-	kfree(uval);
-	return 1;
-}
-
-static void master_free(struct snd_kcontrol *kcontrol)
-{
-	struct link_master *master = snd_kcontrol_chip(kcontrol);
-	struct link_slave *slave;
-
-	list_for_each_entry(slave, &master->slaves, list)
-		slave->master = NULL;
-	kfree(master);
-}
-
-
-/*
- * Create a virtual master control with the given name
- */
-struct snd_kcontrol *snd_ctl_make_virtual_master(char *name,
-						 const unsigned int *tlv)
-{
-	struct link_master *master;
-	struct snd_kcontrol *kctl;
-	struct snd_kcontrol_new knew;
-
-	memset(&knew, 0, sizeof(knew));
-	knew.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	knew.name = name;
-	knew.info = master_info;
-
-	master = kzalloc(sizeof(*master), GFP_KERNEL);
-	if (!master)
-		return NULL;
-	INIT_LIST_HEAD(&master->slaves);
-
-	kctl = snd_ctl_new1(&knew, master);
-	if (!kctl) {
-		kfree(master);
-		return NULL;
-	}
-	/* override some callbacks */
-	kctl->info = master_info;
-	kctl->get = master_get;
-	kctl->put = master_put;
-	kctl->private_free = master_free;
-
-	/* additional (constant) TLV read */
-	if (tlv) {
-		/* FIXME: this assumes that the max volume is 0 dB */
-		kctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_TLV_READ;
-		kctl->tlv.p = tlv;
-	}
-	return kctl;
-}

-- 
Daniel Jacobowitz
CodeSourcery
