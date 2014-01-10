From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/13] speakers: Split control functionality to
	a new file
Date: Sat, 11 Jan 2014 00:29:26 +0900
Message-ID: <1389367775-21360-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 49929261589
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:29:52 +0100 (CET)
In-Reply-To: <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

To make it easy to work in followed commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/speakers/Makefile           |   3 +-
 sound/firewire/speakers/speakers.c         | 277 +---------------------------
 sound/firewire/speakers/speakers.h         |   2 +
 sound/firewire/speakers/speakers_control.c | 283 +++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+), 277 deletions(-)
 create mode 100644 sound/firewire/speakers/speakers_control.c

diff --git a/sound/firewire/speakers/Makefile b/sound/firewire/speakers/Makefile
index a970ccf..8ee55ee 100644
--- a/sound/firewire/speakers/Makefile
+++ b/sound/firewire/speakers/Makefile
@@ -1,2 +1,3 @@
-snd-firewire-speakers-objs := speakers_stream.o speakers_pcm.o speakers.o
+snd-firewire-speakers-objs := speakers_stream.o speakers_pcm.o speakers_control.o \
+			      speakers.o
 obj-m += snd-firewire-speakers.o
diff --git a/sound/firewire/speakers/speakers.c b/sound/firewire/speakers/speakers.c
index 20bba46..187377e 100644
--- a/sound/firewire/speakers/speakers.c
+++ b/sound/firewire/speakers/speakers.c
@@ -24,281 +24,6 @@ MODULE_DESCRIPTION("FireWire speakers driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 
-enum control_action { CTL_READ, CTL_WRITE };
-enum control_attribute {
-	CTL_MIN		= 0x02,
-	CTL_MAX		= 0x03,
-	CTL_CURRENT	= 0x10,
-};
-
-static int fwspk_mute_command(struct fwspk *fwspk, bool *value,
-			      enum control_action action)
-{
-	u8 *buf;
-	u8 response_ok;
-	int err;
-
-	buf = kmalloc(11, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (action == CTL_READ) {
-		buf[0] = 0x01;		/* AV/C, STATUS */
-		response_ok = 0x0c;	/*       STABLE */
-	} else {
-		buf[0] = 0x00;		/* AV/C, CONTROL */
-		response_ok = 0x09;	/*       ACCEPTED */
-	}
-	buf[1] = 0x08;			/* audio unit 0 */
-	buf[2] = 0xb8;			/* FUNCTION BLOCK */
-	buf[3] = 0x81;			/* function block type: feature */
-	buf[4] = fwspk->device_info->mute_fb_id; /* function block ID */
-	buf[5] = 0x10;			/* control attribute: current */
-	buf[6] = 0x02;			/* selector length */
-	buf[7] = 0x00;			/* audio channel number */
-	buf[8] = 0x01;			/* control selector: mute */
-	buf[9] = 0x01;			/* control data length */
-	if (action == CTL_READ)
-		buf[10] = 0xff;
-	else
-		buf[10] = *value ? 0x70 : 0x60;
-
-	err = fcp_avc_transaction(fwspk->unit, buf, 11, buf, 11, 0x3fe);
-	if (err < 0)
-		goto error;
-	if (err < 11) {
-		dev_err(&fwspk->unit->device, "short FCP response\n");
-		err = -EIO;
-		goto error;
-	}
-	if (buf[0] != response_ok) {
-		dev_err(&fwspk->unit->device, "mute command failed\n");
-		err = -EIO;
-		goto error;
-	}
-	if (action == CTL_READ)
-		*value = buf[10] == 0x70;
-
-	err = 0;
-
-error:
-	kfree(buf);
-
-	return err;
-}
-
-static int fwspk_volume_command(struct fwspk *fwspk, s16 *value,
-				unsigned int channel,
-				enum control_attribute attribute,
-				enum control_action action)
-{
-	u8 *buf;
-	u8 response_ok;
-	int err;
-
-	buf = kmalloc(12, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (action == CTL_READ) {
-		buf[0] = 0x01;		/* AV/C, STATUS */
-		response_ok = 0x0c;	/*       STABLE */
-	} else {
-		buf[0] = 0x00;		/* AV/C, CONTROL */
-		response_ok = 0x09;	/*       ACCEPTED */
-	}
-	buf[1] = 0x08;			/* audio unit 0 */
-	buf[2] = 0xb8;			/* FUNCTION BLOCK */
-	buf[3] = 0x81;			/* function block type: feature */
-	buf[4] = fwspk->device_info->volume_fb_id; /* function block ID */
-	buf[5] = attribute;		/* control attribute */
-	buf[6] = 0x02;			/* selector length */
-	buf[7] = channel;		/* audio channel number */
-	buf[8] = 0x02;			/* control selector: volume */
-	buf[9] = 0x02;			/* control data length */
-	if (action == CTL_READ) {
-		buf[10] = 0xff;
-		buf[11] = 0xff;
-	} else {
-		buf[10] = *value >> 8;
-		buf[11] = *value;
-	}
-
-	err = fcp_avc_transaction(fwspk->unit, buf, 12, buf, 12, 0x3fe);
-	if (err < 0)
-		goto error;
-	if (err < 12) {
-		dev_err(&fwspk->unit->device, "short FCP response\n");
-		err = -EIO;
-		goto error;
-	}
-	if (buf[0] != response_ok) {
-		dev_err(&fwspk->unit->device, "volume command failed\n");
-		err = -EIO;
-		goto error;
-	}
-	if (action == CTL_READ)
-		*value = (buf[10] << 8) | buf[11];
-
-	err = 0;
-
-error:
-	kfree(buf);
-
-	return err;
-}
-
-static int fwspk_mute_get(struct snd_kcontrol *control,
-			  struct snd_ctl_elem_value *value)
-{
-	struct fwspk *fwspk = control->private_data;
-
-	value->value.integer.value[0] = !fwspk->mute;
-
-	return 0;
-}
-
-static int fwspk_mute_put(struct snd_kcontrol *control,
-			  struct snd_ctl_elem_value *value)
-{
-	struct fwspk *fwspk = control->private_data;
-	bool mute;
-	int err;
-
-	mute = !value->value.integer.value[0];
-
-	if (mute == fwspk->mute)
-		return 0;
-
-	err = fwspk_mute_command(fwspk, &mute, CTL_WRITE);
-	if (err < 0)
-		return err;
-	fwspk->mute = mute;
-
-	return 1;
-}
-
-static int fwspk_volume_info(struct snd_kcontrol *control,
-			     struct snd_ctl_elem_info *info)
-{
-	struct fwspk *fwspk = control->private_data;
-
-	info->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	info->count = fwspk->device_info->mixer_channels;
-	info->value.integer.min = fwspk->volume_min;
-	info->value.integer.max = fwspk->volume_max;
-
-	return 0;
-}
-
-static const u8 channel_map[6] = { 0, 1, 4, 5, 2, 3 };
-
-static int fwspk_volume_get(struct snd_kcontrol *control,
-			    struct snd_ctl_elem_value *value)
-{
-	struct fwspk *fwspk = control->private_data;
-	unsigned int i;
-
-	for (i = 0; i < fwspk->device_info->mixer_channels; ++i)
-		value->value.integer.value[channel_map[i]] = fwspk->volume[i];
-
-	return 0;
-}
-
-static int fwspk_volume_put(struct snd_kcontrol *control,
-			  struct snd_ctl_elem_value *value)
-{
-	struct fwspk *fwspk = control->private_data;
-	unsigned int i, changed_channels;
-	bool equal_values = true;
-	s16 volume;
-	int err;
-
-	for (i = 0; i < fwspk->device_info->mixer_channels; ++i) {
-		if (value->value.integer.value[i] < fwspk->volume_min ||
-		    value->value.integer.value[i] > fwspk->volume_max)
-			return -EINVAL;
-		if (value->value.integer.value[i] !=
-		    value->value.integer.value[0])
-			equal_values = false;
-	}
-
-	changed_channels = 0;
-	for (i = 0; i < fwspk->device_info->mixer_channels; ++i)
-		if (value->value.integer.value[channel_map[i]] !=
-							fwspk->volume[i])
-			changed_channels |= 1 << (i + 1);
-
-	if (equal_values && changed_channels != 0)
-		changed_channels = 1 << 0;
-
-	for (i = 0; i <= fwspk->device_info->mixer_channels; ++i) {
-		volume = value->value.integer.value[channel_map[i ? i - 1 : 0]];
-		if (changed_channels & (1 << i)) {
-			err = fwspk_volume_command(fwspk, &volume, i,
-						   CTL_CURRENT, CTL_WRITE);
-			if (err < 0)
-				return err;
-		}
-		if (i > 0)
-			fwspk->volume[i - 1] = volume;
-	}
-
-	return changed_channels != 0;
-}
-
-static int fwspk_create_mixer(struct fwspk *fwspk)
-{
-	static const struct snd_kcontrol_new controls[] = {
-		{
-			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-			.name = "PCM Playback Switch",
-			.info = snd_ctl_boolean_mono_info,
-			.get = fwspk_mute_get,
-			.put = fwspk_mute_put,
-		},
-		{
-			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-			.name = "PCM Playback Volume",
-			.info = fwspk_volume_info,
-			.get = fwspk_volume_get,
-			.put = fwspk_volume_put,
-		},
-	};
-	unsigned int i, first_ch;
-	int err;
-
-	err = fwspk_volume_command(fwspk, &fwspk->volume_min,
-				   0, CTL_MIN, CTL_READ);
-	if (err < 0)
-		return err;
-	err = fwspk_volume_command(fwspk, &fwspk->volume_max,
-				   0, CTL_MAX, CTL_READ);
-	if (err < 0)
-		return err;
-
-	err = fwspk_mute_command(fwspk, &fwspk->mute, CTL_READ);
-	if (err < 0)
-		return err;
-
-	first_ch = fwspk->device_info->mixer_channels == 1 ? 0 : 1;
-	for (i = 0; i < fwspk->device_info->mixer_channels; ++i) {
-		err = fwspk_volume_command(fwspk, &fwspk->volume[i],
-					   first_ch + i, CTL_CURRENT, CTL_READ);
-		if (err < 0)
-			return err;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(controls); ++i) {
-		err = snd_ctl_add(fwspk->card,
-				  snd_ctl_new1(&controls[i], fwspk));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
 static u32 fwspk_read_firmware_version(struct fw_unit *unit)
 {
 	__be32 data;
@@ -360,7 +85,7 @@ static int fwspk_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto err_card;
 
-	err = fwspk_create_mixer(fwspk);
+	err = snd_fwspk_create_mixer(fwspk);
 	if (err < 0)
 		goto err_card;
 
diff --git a/sound/firewire/speakers/speakers.h b/sound/firewire/speakers/speakers.h
index 379196d..c921714 100644
--- a/sound/firewire/speakers/speakers.h
+++ b/sound/firewire/speakers/speakers.h
@@ -55,5 +55,7 @@ void snd_fwspk_stream_update(struct fwspk *fwspk);
 
 int snd_fwspk_create_pcm(struct fwspk *fwspk);
 
+int snd_fwspk_create_mixer(struct fwspk *fwspk);
+
 int firewave_constraints(struct snd_pcm_runtime *runtime);
 int lacie_speakers_constraints(struct snd_pcm_runtime *runtime);
diff --git a/sound/firewire/speakers/speakers_control.c b/sound/firewire/speakers/speakers_control.c
new file mode 100644
index 0000000..450632e
--- /dev/null
+++ b/sound/firewire/speakers/speakers_control.c
@@ -0,0 +1,283 @@
+/*
+ * speakers_control.c - a part of OXFW970/971-based speakers driver
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "speakers.h"
+
+enum control_action { CTL_READ, CTL_WRITE };
+enum control_attribute {
+	CTL_MIN		= 0x02,
+	CTL_MAX		= 0x03,
+	CTL_CURRENT	= 0x10,
+};
+
+static int fwspk_mute_command(struct fwspk *fwspk, bool *value,
+			      enum control_action action)
+{
+	u8 *buf;
+	u8 response_ok;
+	int err;
+
+	buf = kmalloc(11, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (action == CTL_READ) {
+		buf[0] = 0x01;		/* AV/C, STATUS */
+		response_ok = 0x0c;	/*       STABLE */
+	} else {
+		buf[0] = 0x00;		/* AV/C, CONTROL */
+		response_ok = 0x09;	/*       ACCEPTED */
+	}
+	buf[1] = 0x08;			/* audio unit 0 */
+	buf[2] = 0xb8;			/* FUNCTION BLOCK */
+	buf[3] = 0x81;			/* function block type: feature */
+	buf[4] = fwspk->device_info->mute_fb_id; /* function block ID */
+	buf[5] = 0x10;			/* control attribute: current */
+	buf[6] = 0x02;			/* selector length */
+	buf[7] = 0x00;			/* audio channel number */
+	buf[8] = 0x01;			/* control selector: mute */
+	buf[9] = 0x01;			/* control data length */
+	if (action == CTL_READ)
+		buf[10] = 0xff;
+	else
+		buf[10] = *value ? 0x70 : 0x60;
+
+	err = fcp_avc_transaction(fwspk->unit, buf, 11, buf, 11, 0x3fe);
+	if (err < 0)
+		goto error;
+	if (err < 11) {
+		dev_err(&fwspk->unit->device, "short FCP response\n");
+		err = -EIO;
+		goto error;
+	}
+	if (buf[0] != response_ok) {
+		dev_err(&fwspk->unit->device, "mute command failed\n");
+		err = -EIO;
+		goto error;
+	}
+	if (action == CTL_READ)
+		*value = buf[10] == 0x70;
+
+	err = 0;
+
+error:
+	kfree(buf);
+
+	return err;
+}
+
+static int fwspk_volume_command(struct fwspk *fwspk, s16 *value,
+				unsigned int channel,
+				enum control_attribute attribute,
+				enum control_action action)
+{
+	u8 *buf;
+	u8 response_ok;
+	int err;
+
+	buf = kmalloc(12, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (action == CTL_READ) {
+		buf[0] = 0x01;		/* AV/C, STATUS */
+		response_ok = 0x0c;	/*       STABLE */
+	} else {
+		buf[0] = 0x00;		/* AV/C, CONTROL */
+		response_ok = 0x09;	/*       ACCEPTED */
+	}
+	buf[1] = 0x08;			/* audio unit 0 */
+	buf[2] = 0xb8;			/* FUNCTION BLOCK */
+	buf[3] = 0x81;			/* function block type: feature */
+	buf[4] = fwspk->device_info->volume_fb_id; /* function block ID */
+	buf[5] = attribute;		/* control attribute */
+	buf[6] = 0x02;			/* selector length */
+	buf[7] = channel;		/* audio channel number */
+	buf[8] = 0x02;			/* control selector: volume */
+	buf[9] = 0x02;			/* control data length */
+	if (action == CTL_READ) {
+		buf[10] = 0xff;
+		buf[11] = 0xff;
+	} else {
+		buf[10] = *value >> 8;
+		buf[11] = *value;
+	}
+
+	err = fcp_avc_transaction(fwspk->unit, buf, 12, buf, 12, 0x3fe);
+	if (err < 0)
+		goto error;
+	if (err < 12) {
+		dev_err(&fwspk->unit->device, "short FCP response\n");
+		err = -EIO;
+		goto error;
+	}
+	if (buf[0] != response_ok) {
+		dev_err(&fwspk->unit->device, "volume command failed\n");
+		err = -EIO;
+		goto error;
+	}
+	if (action == CTL_READ)
+		*value = (buf[10] << 8) | buf[11];
+
+	err = 0;
+
+error:
+	kfree(buf);
+
+	return err;
+}
+
+static int fwspk_mute_get(struct snd_kcontrol *control,
+			  struct snd_ctl_elem_value *value)
+{
+	struct fwspk *fwspk = control->private_data;
+
+	value->value.integer.value[0] = !fwspk->mute;
+
+	return 0;
+}
+
+static int fwspk_mute_put(struct snd_kcontrol *control,
+			  struct snd_ctl_elem_value *value)
+{
+	struct fwspk *fwspk = control->private_data;
+	bool mute;
+	int err;
+
+	mute = !value->value.integer.value[0];
+
+	if (mute == fwspk->mute)
+		return 0;
+
+	err = fwspk_mute_command(fwspk, &mute, CTL_WRITE);
+	if (err < 0)
+		return err;
+	fwspk->mute = mute;
+
+	return 1;
+}
+
+static int fwspk_volume_info(struct snd_kcontrol *control,
+			     struct snd_ctl_elem_info *info)
+{
+	struct fwspk *fwspk = control->private_data;
+
+	info->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	info->count = fwspk->device_info->mixer_channels;
+	info->value.integer.min = fwspk->volume_min;
+	info->value.integer.max = fwspk->volume_max;
+
+	return 0;
+}
+
+static const u8 channel_map[6] = { 0, 1, 4, 5, 2, 3 };
+
+static int fwspk_volume_get(struct snd_kcontrol *control,
+			    struct snd_ctl_elem_value *value)
+{
+	struct fwspk *fwspk = control->private_data;
+	unsigned int i;
+
+	for (i = 0; i < fwspk->device_info->mixer_channels; ++i)
+		value->value.integer.value[channel_map[i]] = fwspk->volume[i];
+
+	return 0;
+}
+
+static int fwspk_volume_put(struct snd_kcontrol *control,
+			  struct snd_ctl_elem_value *value)
+{
+	struct fwspk *fwspk = control->private_data;
+	unsigned int i, changed_channels;
+	bool equal_values = true;
+	s16 volume;
+	int err;
+
+	for (i = 0; i < fwspk->device_info->mixer_channels; ++i) {
+		if (value->value.integer.value[i] < fwspk->volume_min ||
+		    value->value.integer.value[i] > fwspk->volume_max)
+			return -EINVAL;
+		if (value->value.integer.value[i] !=
+		    value->value.integer.value[0])
+			equal_values = false;
+	}
+
+	changed_channels = 0;
+	for (i = 0; i < fwspk->device_info->mixer_channels; ++i)
+		if (value->value.integer.value[channel_map[i]] !=
+							fwspk->volume[i])
+			changed_channels |= 1 << (i + 1);
+
+	if (equal_values && changed_channels != 0)
+		changed_channels = 1 << 0;
+
+	for (i = 0; i <= fwspk->device_info->mixer_channels; ++i) {
+		volume = value->value.integer.value[channel_map[i ? i - 1 : 0]];
+		if (changed_channels & (1 << i)) {
+			err = fwspk_volume_command(fwspk, &volume, i,
+						   CTL_CURRENT, CTL_WRITE);
+			if (err < 0)
+				return err;
+		}
+		if (i > 0)
+			fwspk->volume[i - 1] = volume;
+	}
+
+	return changed_channels != 0;
+}
+
+int snd_fwspk_create_mixer(struct fwspk *fwspk)
+{
+	static const struct snd_kcontrol_new controls[] = {
+		{
+			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+			.name = "PCM Playback Switch",
+			.info = snd_ctl_boolean_mono_info,
+			.get = fwspk_mute_get,
+			.put = fwspk_mute_put,
+		},
+		{
+			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+			.name = "PCM Playback Volume",
+			.info = fwspk_volume_info,
+			.get = fwspk_volume_get,
+			.put = fwspk_volume_put,
+		},
+	};
+	unsigned int i, first_ch;
+	int err;
+
+	err = fwspk_volume_command(fwspk, &fwspk->volume_min,
+				   0, CTL_MIN, CTL_READ);
+	if (err < 0)
+		return err;
+	err = fwspk_volume_command(fwspk, &fwspk->volume_max,
+				   0, CTL_MAX, CTL_READ);
+	if (err < 0)
+		return err;
+
+	err = fwspk_mute_command(fwspk, &fwspk->mute, CTL_READ);
+	if (err < 0)
+		return err;
+
+	first_ch = fwspk->device_info->mixer_channels == 1 ? 0 : 1;
+	for (i = 0; i < fwspk->device_info->mixer_channels; ++i) {
+		err = fwspk_volume_command(fwspk, &fwspk->volume[i],
+					   first_ch + i, CTL_CURRENT, CTL_READ);
+		if (err < 0)
+			return err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(controls); ++i) {
+		err = snd_ctl_add(fwspk->card,
+				  snd_ctl_new1(&controls[i], fwspk));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
-- 
1.8.3.2
