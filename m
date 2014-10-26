From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/29] ALSA: speakers: Rename to oxfw and
	rename some members
Date: Sun, 26 Oct 2014 22:03:16 +0900
Message-ID: <1414328610-12729-16-git-send-email-o-takashi@sakamocchi.jp>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id D33342606F1
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 14:04:01 +0100 (CET)
In-Reply-To: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit renames 'firewire-speakers' to 'oxfw' to enhance support for
devices which based on OXFW970/971. A line for MODULE_ALIAS is added.

Additionally, to help for works in followed paches, some members
in private structure are renamed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                |  12 +-
 sound/firewire/Makefile               |   4 +-
 sound/firewire/{speakers.c => oxfw.c} | 341 +++++++++++++++++-----------------
 3 files changed, 180 insertions(+), 177 deletions(-)
 rename sound/firewire/{speakers.c => oxfw.c} (61%)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 860e21c..0932860 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -23,15 +23,17 @@ config SND_DICE
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-dice.
 
-config SND_FIREWIRE_SPEAKERS
-	tristate "FireWire speakers"
+config SND_OXFW
+	tristate "Oxford Semiconductor FW970/971 chipset support"
 	select SND_FIREWIRE_LIB
 	help
-	  Say Y here to include support for the Griffin FireWave Surround
-	  and the LaCie FireWire Speakers.
+	  Say Y here to include support for FireWire devices based on
+	  Oxford Semiconductor FW970/971 chipset.
+	   * Griffin Firewave
+	   * LaCie Firewire Speakers
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called snd-firewire-speakers.
+	  will be called snd-oxfw.
 
 config SND_ISIGHT
 	tristate "Apple iSight microphone"
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index c50761c..021b877 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -1,13 +1,13 @@
 snd-firewire-lib-objs := lib.o iso-resources.o packets-buffer.o \
 			 fcp.o cmp.o amdtp.o
-snd-firewire-speakers-objs := speakers.o
+snd-oxfw-objs := oxfw.o
 snd-isight-objs := isight.o
 snd-scs1x-objs := scs1x.o
 
 obj-$(CONFIG_SND_FIREWIRE_LIB) += snd-firewire-lib.o
 obj-$(CONFIG_SND_DICE) += dice/
-obj-$(CONFIG_SND_FIREWIRE_SPEAKERS) += snd-firewire-speakers.o
 obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
 obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
 obj-$(CONFIG_SND_FIREWORKS) += fireworks/
 obj-$(CONFIG_SND_BEBOB) += bebob/
+obj-$(CONFIG_SND_OXFW) += snd-oxfw.o
diff --git a/sound/firewire/speakers.c b/sound/firewire/oxfw.c
similarity index 61%
rename from sound/firewire/speakers.c
rename to sound/firewire/oxfw.c
index 768d40d..b7498e9 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/oxfw.c
@@ -1,5 +1,5 @@
 /*
- * OXFW970-based speakers driver
+ * oxfw.c - a part of driver for OXFW970/971 based devices
  *
  * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
  * Licensed under the terms of the GNU General Public License, version 2.
@@ -45,22 +45,23 @@ struct device_info {
 	u8 volume_fb_id;
 };
 
-struct fwspk {
+struct snd_oxfw {
 	struct snd_card *card;
 	struct fw_unit *unit;
 	const struct device_info *device_info;
 	struct mutex mutex;
-	struct cmp_connection connection;
-	struct amdtp_stream stream;
+	struct cmp_connection in_conn;
+	struct amdtp_stream rx_stream;
 	bool mute;
 	s16 volume[6];
 	s16 volume_min;
 	s16 volume_max;
 };
 
-MODULE_DESCRIPTION("FireWire speakers driver");
+MODULE_DESCRIPTION("Oxford Semiconductor FW970/971 driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("snd-firewire-speakers");
 
 static int firewave_rate_constraint(struct snd_pcm_hw_params *params,
 				    struct snd_pcm_hw_rule *rule)
@@ -137,7 +138,7 @@ static int lacie_speakers_constraints(struct snd_pcm_runtime *runtime)
 	return 0;
 }
 
-static int fwspk_open(struct snd_pcm_substream *substream)
+static int oxfw_open(struct snd_pcm_substream *substream)
 {
 	static const struct snd_pcm_hardware hardware = {
 		.info = SNDRV_PCM_INFO_MMAP |
@@ -154,66 +155,66 @@ static int fwspk_open(struct snd_pcm_substream *substream)
 		.periods_min = 1,
 		.periods_max = UINT_MAX,
 	};
-	struct fwspk *fwspk = substream->private_data;
+	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
 
 	runtime->hw = hardware;
 
-	err = fwspk->device_info->pcm_constraints(runtime);
+	err = oxfw->device_info->pcm_constraints(runtime);
 	if (err < 0)
 		return err;
 	err = snd_pcm_limit_hw_rates(runtime);
 	if (err < 0)
 		return err;
 
-	err = amdtp_stream_add_pcm_hw_constraints(&fwspk->stream, runtime);
+	err = amdtp_stream_add_pcm_hw_constraints(&oxfw->rx_stream, runtime);
 	if (err < 0)
 		return err;
 
 	return 0;
 }
 
-static int fwspk_close(struct snd_pcm_substream *substream)
+static int oxfw_close(struct snd_pcm_substream *substream)
 {
 	return 0;
 }
 
-static void fwspk_stop_stream(struct fwspk *fwspk)
+static void oxfw_stop_stream(struct snd_oxfw *oxfw)
 {
-	if (amdtp_stream_running(&fwspk->stream)) {
-		amdtp_stream_stop(&fwspk->stream);
-		cmp_connection_break(&fwspk->connection);
+	if (amdtp_stream_running(&oxfw->rx_stream)) {
+		amdtp_stream_stop(&oxfw->rx_stream);
+		cmp_connection_break(&oxfw->in_conn);
 	}
 }
 
-static int fwspk_hw_params(struct snd_pcm_substream *substream,
+static int oxfw_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *hw_params)
 {
-	struct fwspk *fwspk = substream->private_data;
+	struct snd_oxfw *oxfw = substream->private_data;
 	int err;
 
-	mutex_lock(&fwspk->mutex);
-	fwspk_stop_stream(fwspk);
-	mutex_unlock(&fwspk->mutex);
+	mutex_lock(&oxfw->mutex);
+	oxfw_stop_stream(oxfw);
+	mutex_unlock(&oxfw->mutex);
 
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
 					       params_buffer_bytes(hw_params));
 	if (err < 0)
 		goto error;
 
-	amdtp_stream_set_parameters(&fwspk->stream,
+	amdtp_stream_set_parameters(&oxfw->rx_stream,
 				    params_rate(hw_params),
 				    params_channels(hw_params),
 				    0);
 
-	amdtp_stream_set_pcm_format(&fwspk->stream,
+	amdtp_stream_set_pcm_format(&oxfw->rx_stream,
 				    params_format(hw_params));
 
-	err = avc_general_set_sig_fmt(fwspk->unit, params_rate(hw_params),
+	err = avc_general_set_sig_fmt(oxfw->unit, params_rate(hw_params),
 				      AVC_GENERAL_PLUG_DIR_IN, 0);
 	if (err < 0) {
-		dev_err(&fwspk->unit->device, "failed to set sample rate\n");
+		dev_err(&oxfw->unit->device, "failed to set sample rate\n");
 		goto err_buffer;
 	}
 
@@ -225,57 +226,57 @@ error:
 	return err;
 }
 
-static int fwspk_hw_free(struct snd_pcm_substream *substream)
+static int oxfw_hw_free(struct snd_pcm_substream *substream)
 {
-	struct fwspk *fwspk = substream->private_data;
+	struct snd_oxfw *oxfw = substream->private_data;
 
-	mutex_lock(&fwspk->mutex);
-	fwspk_stop_stream(fwspk);
-	mutex_unlock(&fwspk->mutex);
+	mutex_lock(&oxfw->mutex);
+	oxfw_stop_stream(oxfw);
+	mutex_unlock(&oxfw->mutex);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
 
-static int fwspk_prepare(struct snd_pcm_substream *substream)
+static int oxfw_prepare(struct snd_pcm_substream *substream)
 {
-	struct fwspk *fwspk = substream->private_data;
+	struct snd_oxfw *oxfw = substream->private_data;
 	int err;
 
-	mutex_lock(&fwspk->mutex);
+	mutex_lock(&oxfw->mutex);
 
-	if (amdtp_streaming_error(&fwspk->stream))
-		fwspk_stop_stream(fwspk);
+	if (amdtp_streaming_error(&oxfw->rx_stream))
+		oxfw_stop_stream(oxfw);
 
-	if (!amdtp_stream_running(&fwspk->stream)) {
-		err = cmp_connection_establish(&fwspk->connection,
-			amdtp_stream_get_max_payload(&fwspk->stream));
+	if (!amdtp_stream_running(&oxfw->rx_stream)) {
+		err = cmp_connection_establish(&oxfw->in_conn,
+			amdtp_stream_get_max_payload(&oxfw->rx_stream));
 		if (err < 0)
 			goto err_mutex;
 
-		err = amdtp_stream_start(&fwspk->stream,
-					 fwspk->connection.resources.channel,
-					 fwspk->connection.speed);
+		err = amdtp_stream_start(&oxfw->rx_stream,
+					 oxfw->in_conn.resources.channel,
+					 oxfw->in_conn.speed);
 		if (err < 0)
 			goto err_connection;
 	}
 
-	mutex_unlock(&fwspk->mutex);
+	mutex_unlock(&oxfw->mutex);
 
-	amdtp_stream_pcm_prepare(&fwspk->stream);
+	amdtp_stream_pcm_prepare(&oxfw->rx_stream);
 
 	return 0;
 
 err_connection:
-	cmp_connection_break(&fwspk->connection);
+	cmp_connection_break(&oxfw->in_conn);
 err_mutex:
-	mutex_unlock(&fwspk->mutex);
+	mutex_unlock(&oxfw->mutex);
 
 	return err;
 }
 
-static int fwspk_trigger(struct snd_pcm_substream *substream, int cmd)
+static int oxfw_trigger(struct snd_pcm_substream *substream, int cmd)
 {
-	struct fwspk *fwspk = substream->private_data;
+	struct snd_oxfw *oxfw = substream->private_data;
 	struct snd_pcm_substream *pcm;
 
 	switch (cmd) {
@@ -288,39 +289,39 @@ static int fwspk_trigger(struct snd_pcm_substream *substream, int cmd)
 	default:
 		return -EINVAL;
 	}
-	amdtp_stream_pcm_trigger(&fwspk->stream, pcm);
+	amdtp_stream_pcm_trigger(&oxfw->rx_stream, pcm);
 	return 0;
 }
 
-static snd_pcm_uframes_t fwspk_pointer(struct snd_pcm_substream *substream)
+static snd_pcm_uframes_t oxfw_pointer(struct snd_pcm_substream *substream)
 {
-	struct fwspk *fwspk = substream->private_data;
+	struct snd_oxfw *oxfw = substream->private_data;
 
-	return amdtp_stream_pcm_pointer(&fwspk->stream);
+	return amdtp_stream_pcm_pointer(&oxfw->rx_stream);
 }
 
-static int fwspk_create_pcm(struct fwspk *fwspk)
+static int oxfw_create_pcm(struct snd_oxfw *oxfw)
 {
 	static struct snd_pcm_ops ops = {
-		.open      = fwspk_open,
-		.close     = fwspk_close,
+		.open      = oxfw_open,
+		.close     = oxfw_close,
 		.ioctl     = snd_pcm_lib_ioctl,
-		.hw_params = fwspk_hw_params,
-		.hw_free   = fwspk_hw_free,
-		.prepare   = fwspk_prepare,
-		.trigger   = fwspk_trigger,
-		.pointer   = fwspk_pointer,
+		.hw_params = oxfw_hw_params,
+		.hw_free   = oxfw_hw_free,
+		.prepare   = oxfw_prepare,
+		.trigger   = oxfw_trigger,
+		.pointer   = oxfw_pointer,
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
 	struct snd_pcm *pcm;
 	int err;
 
-	err = snd_pcm_new(fwspk->card, "OXFW970", 0, 1, 0, &pcm);
+	err = snd_pcm_new(oxfw->card, "OXFW", 0, 1, 0, &pcm);
 	if (err < 0)
 		return err;
-	pcm->private_data = fwspk;
-	strcpy(pcm->name, fwspk->device_info->short_name);
+	pcm->private_data = oxfw;
+	strcpy(pcm->name, oxfw->device_info->short_name);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &ops);
 	return 0;
 }
@@ -332,7 +333,7 @@ enum control_attribute {
 	CTL_CURRENT	= 0x10,
 };
 
-static int fwspk_mute_command(struct fwspk *fwspk, bool *value,
+static int oxfw_mute_command(struct snd_oxfw *oxfw, bool *value,
 			      enum control_action action)
 {
 	u8 *buf;
@@ -353,7 +354,7 @@ static int fwspk_mute_command(struct fwspk *fwspk, bool *value,
 	buf[1] = 0x08;			/* audio unit 0 */
 	buf[2] = 0xb8;			/* FUNCTION BLOCK */
 	buf[3] = 0x81;			/* function block type: feature */
-	buf[4] = fwspk->device_info->mute_fb_id; /* function block ID */
+	buf[4] = oxfw->device_info->mute_fb_id; /* function block ID */
 	buf[5] = 0x10;			/* control attribute: current */
 	buf[6] = 0x02;			/* selector length */
 	buf[7] = 0x00;			/* audio channel number */
@@ -364,16 +365,16 @@ static int fwspk_mute_command(struct fwspk *fwspk, bool *value,
 	else
 		buf[10] = *value ? 0x70 : 0x60;
 
-	err = fcp_avc_transaction(fwspk->unit, buf, 11, buf, 11, 0x3fe);
+	err = fcp_avc_transaction(oxfw->unit, buf, 11, buf, 11, 0x3fe);
 	if (err < 0)
 		goto error;
 	if (err < 11) {
-		dev_err(&fwspk->unit->device, "short FCP response\n");
+		dev_err(&oxfw->unit->device, "short FCP response\n");
 		err = -EIO;
 		goto error;
 	}
 	if (buf[0] != response_ok) {
-		dev_err(&fwspk->unit->device, "mute command failed\n");
+		dev_err(&oxfw->unit->device, "mute command failed\n");
 		err = -EIO;
 		goto error;
 	}
@@ -388,7 +389,7 @@ error:
 	return err;
 }
 
-static int fwspk_volume_command(struct fwspk *fwspk, s16 *value,
+static int oxfw_volume_command(struct snd_oxfw *oxfw, s16 *value,
 				unsigned int channel,
 				enum control_attribute attribute,
 				enum control_action action)
@@ -411,7 +412,7 @@ static int fwspk_volume_command(struct fwspk *fwspk, s16 *value,
 	buf[1] = 0x08;			/* audio unit 0 */
 	buf[2] = 0xb8;			/* FUNCTION BLOCK */
 	buf[3] = 0x81;			/* function block type: feature */
-	buf[4] = fwspk->device_info->volume_fb_id; /* function block ID */
+	buf[4] = oxfw->device_info->volume_fb_id; /* function block ID */
 	buf[5] = attribute;		/* control attribute */
 	buf[6] = 0x02;			/* selector length */
 	buf[7] = channel;		/* audio channel number */
@@ -425,16 +426,16 @@ static int fwspk_volume_command(struct fwspk *fwspk, s16 *value,
 		buf[11] = *value;
 	}
 
-	err = fcp_avc_transaction(fwspk->unit, buf, 12, buf, 12, 0x3fe);
+	err = fcp_avc_transaction(oxfw->unit, buf, 12, buf, 12, 0x3fe);
 	if (err < 0)
 		goto error;
 	if (err < 12) {
-		dev_err(&fwspk->unit->device, "short FCP response\n");
+		dev_err(&oxfw->unit->device, "short FCP response\n");
 		err = -EIO;
 		goto error;
 	}
 	if (buf[0] != response_ok) {
-		dev_err(&fwspk->unit->device, "volume command failed\n");
+		dev_err(&oxfw->unit->device, "volume command failed\n");
 		err = -EIO;
 		goto error;
 	}
@@ -449,75 +450,75 @@ error:
 	return err;
 }
 
-static int fwspk_mute_get(struct snd_kcontrol *control,
+static int oxfw_mute_get(struct snd_kcontrol *control,
 			  struct snd_ctl_elem_value *value)
 {
-	struct fwspk *fwspk = control->private_data;
+	struct snd_oxfw *oxfw = control->private_data;
 
-	value->value.integer.value[0] = !fwspk->mute;
+	value->value.integer.value[0] = !oxfw->mute;
 
 	return 0;
 }
 
-static int fwspk_mute_put(struct snd_kcontrol *control,
+static int oxfw_mute_put(struct snd_kcontrol *control,
 			  struct snd_ctl_elem_value *value)
 {
-	struct fwspk *fwspk = control->private_data;
+	struct snd_oxfw *oxfw = control->private_data;
 	bool mute;
 	int err;
 
 	mute = !value->value.integer.value[0];
 
-	if (mute == fwspk->mute)
+	if (mute == oxfw->mute)
 		return 0;
 
-	err = fwspk_mute_command(fwspk, &mute, CTL_WRITE);
+	err = oxfw_mute_command(oxfw, &mute, CTL_WRITE);
 	if (err < 0)
 		return err;
-	fwspk->mute = mute;
+	oxfw->mute = mute;
 
 	return 1;
 }
 
-static int fwspk_volume_info(struct snd_kcontrol *control,
+static int oxfw_volume_info(struct snd_kcontrol *control,
 			     struct snd_ctl_elem_info *info)
 {
-	struct fwspk *fwspk = control->private_data;
+	struct snd_oxfw *oxfw = control->private_data;
 
 	info->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	info->count = fwspk->device_info->mixer_channels;
-	info->value.integer.min = fwspk->volume_min;
-	info->value.integer.max = fwspk->volume_max;
+	info->count = oxfw->device_info->mixer_channels;
+	info->value.integer.min = oxfw->volume_min;
+	info->value.integer.max = oxfw->volume_max;
 
 	return 0;
 }
 
 static const u8 channel_map[6] = { 0, 1, 4, 5, 2, 3 };
 
-static int fwspk_volume_get(struct snd_kcontrol *control,
+static int oxfw_volume_get(struct snd_kcontrol *control,
 			    struct snd_ctl_elem_value *value)
 {
-	struct fwspk *fwspk = control->private_data;
+	struct snd_oxfw *oxfw = control->private_data;
 	unsigned int i;
 
-	for (i = 0; i < fwspk->device_info->mixer_channels; ++i)
-		value->value.integer.value[channel_map[i]] = fwspk->volume[i];
+	for (i = 0; i < oxfw->device_info->mixer_channels; ++i)
+		value->value.integer.value[channel_map[i]] = oxfw->volume[i];
 
 	return 0;
 }
 
-static int fwspk_volume_put(struct snd_kcontrol *control,
+static int oxfw_volume_put(struct snd_kcontrol *control,
 			  struct snd_ctl_elem_value *value)
 {
-	struct fwspk *fwspk = control->private_data;
+	struct snd_oxfw *oxfw = control->private_data;
 	unsigned int i, changed_channels;
 	bool equal_values = true;
 	s16 volume;
 	int err;
 
-	for (i = 0; i < fwspk->device_info->mixer_channels; ++i) {
-		if (value->value.integer.value[i] < fwspk->volume_min ||
-		    value->value.integer.value[i] > fwspk->volume_max)
+	for (i = 0; i < oxfw->device_info->mixer_channels; ++i) {
+		if (value->value.integer.value[i] < oxfw->volume_min ||
+		    value->value.integer.value[i] > oxfw->volume_max)
 			return -EINVAL;
 		if (value->value.integer.value[i] !=
 		    value->value.integer.value[0])
@@ -525,74 +526,74 @@ static int fwspk_volume_put(struct snd_kcontrol *control,
 	}
 
 	changed_channels = 0;
-	for (i = 0; i < fwspk->device_info->mixer_channels; ++i)
+	for (i = 0; i < oxfw->device_info->mixer_channels; ++i)
 		if (value->value.integer.value[channel_map[i]] !=
-							fwspk->volume[i])
+							oxfw->volume[i])
 			changed_channels |= 1 << (i + 1);
 
 	if (equal_values && changed_channels != 0)
 		changed_channels = 1 << 0;
 
-	for (i = 0; i <= fwspk->device_info->mixer_channels; ++i) {
+	for (i = 0; i <= oxfw->device_info->mixer_channels; ++i) {
 		volume = value->value.integer.value[channel_map[i ? i - 1 : 0]];
 		if (changed_channels & (1 << i)) {
-			err = fwspk_volume_command(fwspk, &volume, i,
+			err = oxfw_volume_command(oxfw, &volume, i,
 						   CTL_CURRENT, CTL_WRITE);
 			if (err < 0)
 				return err;
 		}
 		if (i > 0)
-			fwspk->volume[i - 1] = volume;
+			oxfw->volume[i - 1] = volume;
 	}
 
 	return changed_channels != 0;
 }
 
-static int fwspk_create_mixer(struct fwspk *fwspk)
+static int oxfw_create_mixer(struct snd_oxfw *oxfw)
 {
 	static const struct snd_kcontrol_new controls[] = {
 		{
 			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 			.name = "PCM Playback Switch",
 			.info = snd_ctl_boolean_mono_info,
-			.get = fwspk_mute_get,
-			.put = fwspk_mute_put,
+			.get = oxfw_mute_get,
+			.put = oxfw_mute_put,
 		},
 		{
 			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 			.name = "PCM Playback Volume",
-			.info = fwspk_volume_info,
-			.get = fwspk_volume_get,
-			.put = fwspk_volume_put,
+			.info = oxfw_volume_info,
+			.get = oxfw_volume_get,
+			.put = oxfw_volume_put,
 		},
 	};
 	unsigned int i, first_ch;
 	int err;
 
-	err = fwspk_volume_command(fwspk, &fwspk->volume_min,
+	err = oxfw_volume_command(oxfw, &oxfw->volume_min,
 				   0, CTL_MIN, CTL_READ);
 	if (err < 0)
 		return err;
-	err = fwspk_volume_command(fwspk, &fwspk->volume_max,
+	err = oxfw_volume_command(oxfw, &oxfw->volume_max,
 				   0, CTL_MAX, CTL_READ);
 	if (err < 0)
 		return err;
 
-	err = fwspk_mute_command(fwspk, &fwspk->mute, CTL_READ);
+	err = oxfw_mute_command(oxfw, &oxfw->mute, CTL_READ);
 	if (err < 0)
 		return err;
 
-	first_ch = fwspk->device_info->mixer_channels == 1 ? 0 : 1;
-	for (i = 0; i < fwspk->device_info->mixer_channels; ++i) {
-		err = fwspk_volume_command(fwspk, &fwspk->volume[i],
+	first_ch = oxfw->device_info->mixer_channels == 1 ? 0 : 1;
+	for (i = 0; i < oxfw->device_info->mixer_channels; ++i) {
+		err = oxfw_volume_command(oxfw, &oxfw->volume[i],
 					   first_ch + i, CTL_CURRENT, CTL_READ);
 		if (err < 0)
 			return err;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(controls); ++i) {
-		err = snd_ctl_add(fwspk->card,
-				  snd_ctl_new1(&controls[i], fwspk));
+		err = snd_ctl_add(oxfw->card,
+				  snd_ctl_new1(&controls[i], oxfw));
 		if (err < 0)
 			return err;
 	}
@@ -600,7 +601,7 @@ static int fwspk_create_mixer(struct fwspk *fwspk)
 	return 0;
 }
 
-static u32 fwspk_read_firmware_version(struct fw_unit *unit)
+static u32 oxfw_read_firmware_version(struct fw_unit *unit)
 {
 	__be32 data;
 	int err;
@@ -610,63 +611,63 @@ static u32 fwspk_read_firmware_version(struct fw_unit *unit)
 	return err >= 0 ? be32_to_cpu(data) : 0;
 }
 
-static void fwspk_card_free(struct snd_card *card)
+static void oxfw_card_free(struct snd_card *card)
 {
-	struct fwspk *fwspk = card->private_data;
+	struct snd_oxfw *oxfw = card->private_data;
 
-	amdtp_stream_destroy(&fwspk->stream);
-	cmp_connection_destroy(&fwspk->connection);
-	fw_unit_put(fwspk->unit);
-	mutex_destroy(&fwspk->mutex);
+	amdtp_stream_destroy(&oxfw->rx_stream);
+	cmp_connection_destroy(&oxfw->in_conn);
+	fw_unit_put(oxfw->unit);
+	mutex_destroy(&oxfw->mutex);
 }
 
-static int fwspk_probe(struct fw_unit *unit,
+static int oxfw_probe(struct fw_unit *unit,
 		       const struct ieee1394_device_id *id)
 {
 	struct fw_device *fw_dev = fw_parent_device(unit);
 	struct snd_card *card;
-	struct fwspk *fwspk;
+	struct snd_oxfw *oxfw;
 	u32 firmware;
 	int err;
 
 	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
-			   sizeof(*fwspk), &card);
+			   sizeof(*oxfw), &card);
 	if (err < 0)
 		return err;
 
-	fwspk = card->private_data;
-	fwspk->card = card;
-	mutex_init(&fwspk->mutex);
-	fwspk->unit = fw_unit_get(unit);
-	fwspk->device_info = (const struct device_info *)id->driver_data;
+	oxfw = card->private_data;
+	oxfw->card = card;
+	mutex_init(&oxfw->mutex);
+	oxfw->unit = fw_unit_get(unit);
+	oxfw->device_info = (const struct device_info *)id->driver_data;
 
-	err = cmp_connection_init(&fwspk->connection, unit, CMP_INPUT, 0);
+	err = cmp_connection_init(&oxfw->in_conn, unit, CMP_INPUT, 0);
 	if (err < 0)
 		goto err_unit;
 
-	err = amdtp_stream_init(&fwspk->stream, unit, AMDTP_OUT_STREAM,
+	err = amdtp_stream_init(&oxfw->rx_stream, unit, AMDTP_OUT_STREAM,
 				CIP_NONBLOCKING);
 	if (err < 0)
 		goto err_connection;
 
-	card->private_free = fwspk_card_free;
+	card->private_free = oxfw_card_free;
 
-	strcpy(card->driver, fwspk->device_info->driver_name);
-	strcpy(card->shortname, fwspk->device_info->short_name);
-	firmware = fwspk_read_firmware_version(unit);
+	strcpy(card->driver, oxfw->device_info->driver_name);
+	strcpy(card->shortname, oxfw->device_info->short_name);
+	firmware = oxfw_read_firmware_version(unit);
 	snprintf(card->longname, sizeof(card->longname),
 		 "%s (OXFW%x %04x), GUID %08x%08x at %s, S%d",
-		 fwspk->device_info->long_name,
+		 oxfw->device_info->long_name,
 		 firmware >> 20, firmware & 0xffff,
 		 fw_dev->config_rom[3], fw_dev->config_rom[4],
 		 dev_name(&unit->device), 100 << fw_dev->max_speed);
-	strcpy(card->mixername, "OXFW970");
+	strcpy(card->mixername, "OXFW");
 
-	err = fwspk_create_pcm(fwspk);
+	err = oxfw_create_pcm(oxfw);
 	if (err < 0)
 		goto error;
 
-	err = fwspk_create_mixer(fwspk);
+	err = oxfw_create_mixer(oxfw);
 	if (err < 0)
 		goto error;
 
@@ -674,49 +675,49 @@ static int fwspk_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	dev_set_drvdata(&unit->device, fwspk);
+	dev_set_drvdata(&unit->device, oxfw);
 
 	return 0;
 
 err_connection:
-	cmp_connection_destroy(&fwspk->connection);
+	cmp_connection_destroy(&oxfw->in_conn);
 err_unit:
-	fw_unit_put(fwspk->unit);
-	mutex_destroy(&fwspk->mutex);
+	fw_unit_put(oxfw->unit);
+	mutex_destroy(&oxfw->mutex);
 error:
 	snd_card_free(card);
 	return err;
 }
 
-static void fwspk_bus_reset(struct fw_unit *unit)
+static void oxfw_bus_reset(struct fw_unit *unit)
 {
-	struct fwspk *fwspk = dev_get_drvdata(&unit->device);
+	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
-	fcp_bus_reset(fwspk->unit);
+	fcp_bus_reset(oxfw->unit);
 
-	if (cmp_connection_update(&fwspk->connection) < 0) {
-		amdtp_stream_pcm_abort(&fwspk->stream);
-		mutex_lock(&fwspk->mutex);
-		fwspk_stop_stream(fwspk);
-		mutex_unlock(&fwspk->mutex);
+	if (cmp_connection_update(&oxfw->in_conn) < 0) {
+		amdtp_stream_pcm_abort(&oxfw->rx_stream);
+		mutex_lock(&oxfw->mutex);
+		oxfw_stop_stream(oxfw);
+		mutex_unlock(&oxfw->mutex);
 		return;
 	}
 
-	amdtp_stream_update(&fwspk->stream);
+	amdtp_stream_update(&oxfw->rx_stream);
 }
 
-static void fwspk_remove(struct fw_unit *unit)
+static void oxfw_remove(struct fw_unit *unit)
 {
-	struct fwspk *fwspk = dev_get_drvdata(&unit->device);
+	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
-	amdtp_stream_pcm_abort(&fwspk->stream);
-	snd_card_disconnect(fwspk->card);
+	amdtp_stream_pcm_abort(&oxfw->rx_stream);
+	snd_card_disconnect(oxfw->card);
 
-	mutex_lock(&fwspk->mutex);
-	fwspk_stop_stream(fwspk);
-	mutex_unlock(&fwspk->mutex);
+	mutex_lock(&oxfw->mutex);
+	oxfw_stop_stream(oxfw);
+	mutex_unlock(&oxfw->mutex);
 
-	snd_card_free_when_closed(fwspk->card);
+	snd_card_free_when_closed(oxfw->card);
 }
 
 static const struct device_info griffin_firewave = {
@@ -739,7 +740,7 @@ static const struct device_info lacie_speakers = {
 	.volume_fb_id = 0x01,
 };
 
-static const struct ieee1394_device_id fwspk_id_table[] = {
+static const struct ieee1394_device_id oxfw_id_table[] = {
 	{
 		.match_flags  = IEEE1394_MATCH_VENDOR_ID |
 				IEEE1394_MATCH_MODEL_ID |
@@ -764,29 +765,29 @@ static const struct ieee1394_device_id fwspk_id_table[] = {
 	},
 	{ }
 };
-MODULE_DEVICE_TABLE(ieee1394, fwspk_id_table);
+MODULE_DEVICE_TABLE(ieee1394, oxfw_id_table);
 
-static struct fw_driver fwspk_driver = {
+static struct fw_driver oxfw_driver = {
 	.driver   = {
 		.owner	= THIS_MODULE,
 		.name	= KBUILD_MODNAME,
 		.bus	= &fw_bus_type,
 	},
-	.probe    = fwspk_probe,
-	.update   = fwspk_bus_reset,
-	.remove   = fwspk_remove,
-	.id_table = fwspk_id_table,
+	.probe    = oxfw_probe,
+	.update   = oxfw_bus_reset,
+	.remove   = oxfw_remove,
+	.id_table = oxfw_id_table,
 };
 
-static int __init alsa_fwspk_init(void)
+static int __init snd_oxfw_init(void)
 {
-	return driver_register(&fwspk_driver.driver);
+	return driver_register(&oxfw_driver.driver);
 }
 
-static void __exit alsa_fwspk_exit(void)
+static void __exit snd_oxfw_exit(void)
 {
-	driver_unregister(&fwspk_driver.driver);
+	driver_unregister(&oxfw_driver.driver);
 }
 
-module_init(alsa_fwspk_init);
-module_exit(alsa_fwspk_exit);
+module_init(snd_oxfw_init);
+module_exit(snd_oxfw_exit);
-- 
1.9.1
