From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 19/30] ALSA: oxfw: Split PCM functionality to a
	new file
Date: Sat, 29 Nov 2014 00:59:28 +0900
Message-ID: <1417190379-4172-20-git-send-email-o-takashi@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 7830D2604E8
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 16:59:52 +0100 (CET)
In-Reply-To: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
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

This is a help for works in followed patches.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile   |   2 +-
 sound/firewire/oxfw/oxfw-pcm.c | 249 +++++++++++++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw.c     | 240 +--------------------------------------
 sound/firewire/oxfw/oxfw.h     |   4 +
 4 files changed, 255 insertions(+), 240 deletions(-)
 create mode 100644 sound/firewire/oxfw/oxfw-pcm.c

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index e15c4c0..7fb4d09 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,2 +1,2 @@
-snd-oxfw-objs := oxfw-stream.o oxfw.o
+snd-oxfw-objs := oxfw-stream.o oxfw-pcm.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
new file mode 100644
index 0000000..d39f17a
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -0,0 +1,249 @@
+/*
+ * oxfw_pcm.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "oxfw.h"
+
+static int firewave_rate_constraint(struct snd_pcm_hw_params *params,
+				    struct snd_pcm_hw_rule *rule)
+{
+	static unsigned int stereo_rates[] = { 48000, 96000 };
+	struct snd_interval *channels =
+			hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval *rate =
+			hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+
+	/* two channels work only at 48/96 kHz */
+	if (snd_interval_max(channels) < 6)
+		return snd_interval_list(rate, 2, stereo_rates, 0);
+	return 0;
+}
+
+static int firewave_channels_constraint(struct snd_pcm_hw_params *params,
+					struct snd_pcm_hw_rule *rule)
+{
+	static const struct snd_interval all_channels = { .min = 6, .max = 6 };
+	struct snd_interval *rate =
+			hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels =
+			hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	/* 32/44.1 kHz work only with all six channels */
+	if (snd_interval_max(rate) < 48000)
+		return snd_interval_refine(channels, &all_channels);
+	return 0;
+}
+
+int firewave_constraints(struct snd_pcm_runtime *runtime)
+{
+	static unsigned int channels_list[] = { 2, 6 };
+	static struct snd_pcm_hw_constraint_list channels_list_constraint = {
+		.count = 2,
+		.list = channels_list,
+	};
+	int err;
+
+	runtime->hw.rates = SNDRV_PCM_RATE_32000 |
+			    SNDRV_PCM_RATE_44100 |
+			    SNDRV_PCM_RATE_48000 |
+			    SNDRV_PCM_RATE_96000;
+	runtime->hw.channels_max = 6;
+
+	err = snd_pcm_hw_constraint_list(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_CHANNELS,
+					 &channels_list_constraint);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  firewave_rate_constraint, NULL,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  firewave_channels_constraint, NULL,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int lacie_speakers_constraints(struct snd_pcm_runtime *runtime)
+{
+	runtime->hw.rates = SNDRV_PCM_RATE_32000 |
+			    SNDRV_PCM_RATE_44100 |
+			    SNDRV_PCM_RATE_48000 |
+			    SNDRV_PCM_RATE_88200 |
+			    SNDRV_PCM_RATE_96000;
+
+	return 0;
+}
+
+static int pcm_open(struct snd_pcm_substream *substream)
+{
+	static const struct snd_pcm_hardware hardware = {
+		.info = SNDRV_PCM_INFO_MMAP |
+			SNDRV_PCM_INFO_MMAP_VALID |
+			SNDRV_PCM_INFO_BATCH |
+			SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_BLOCK_TRANSFER,
+		.formats = AMDTP_OUT_PCM_FORMAT_BITS,
+		.channels_min = 2,
+		.channels_max = 2,
+		.buffer_bytes_max = 4 * 1024 * 1024,
+		.period_bytes_min = 1,
+		.period_bytes_max = UINT_MAX,
+		.periods_min = 1,
+		.periods_max = UINT_MAX,
+	};
+	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	bool used;
+	int err;
+
+	err = cmp_connection_check_used(&oxfw->in_conn, &used);
+	if ((err < 0) || used)
+		goto end;
+
+	runtime->hw = hardware;
+
+	err = oxfw->device_info->pcm_constraints(runtime);
+	if (err < 0)
+		goto end;
+	err = snd_pcm_limit_hw_rates(runtime);
+	if (err < 0)
+		goto end;
+
+	err = amdtp_stream_add_pcm_hw_constraints(&oxfw->rx_stream, runtime);
+end:
+	return err;
+}
+
+static int pcm_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int pcm_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	int err;
+
+	mutex_lock(&oxfw->mutex);
+
+	snd_oxfw_stream_stop_simplex(oxfw);
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		goto error;
+
+	amdtp_stream_set_parameters(&oxfw->rx_stream,
+				    params_rate(hw_params),
+				    params_channels(hw_params),
+				    0);
+
+	amdtp_stream_set_pcm_format(&oxfw->rx_stream,
+				    params_format(hw_params));
+
+	err = avc_general_set_sig_fmt(oxfw->unit, params_rate(hw_params),
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	if (err < 0) {
+		dev_err(&oxfw->unit->device, "failed to set sample rate\n");
+		goto err_buffer;
+	}
+
+	return 0;
+
+err_buffer:
+	snd_pcm_lib_free_vmalloc_buffer(substream);
+error:
+	mutex_unlock(&oxfw->mutex);
+	return err;
+}
+
+static int pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+
+	mutex_lock(&oxfw->mutex);
+	snd_oxfw_stream_stop_simplex(oxfw);
+	mutex_unlock(&oxfw->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	int err;
+
+	mutex_lock(&oxfw->mutex);
+
+	snd_oxfw_stream_stop_simplex(oxfw);
+
+	err = snd_oxfw_stream_start_simplex(oxfw);
+	if (err < 0)
+		goto end;
+
+	amdtp_stream_pcm_prepare(&oxfw->rx_stream);
+end:
+	mutex_unlock(&oxfw->mutex);
+	return err;
+}
+
+static int pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+	struct snd_pcm_substream *pcm;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		pcm = substream;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		pcm = NULL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	amdtp_stream_pcm_trigger(&oxfw->rx_stream, pcm);
+	return 0;
+}
+
+static snd_pcm_uframes_t pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->private_data;
+
+	return amdtp_stream_pcm_pointer(&oxfw->rx_stream);
+}
+
+int snd_oxfw_create_pcm(struct snd_oxfw *oxfw)
+{
+	static struct snd_pcm_ops ops = {
+		.open      = pcm_open,
+		.close     = pcm_close,
+		.ioctl     = snd_pcm_lib_ioctl,
+		.hw_params = pcm_hw_params,
+		.hw_free   = pcm_hw_free,
+		.prepare   = pcm_prepare,
+		.trigger   = pcm_trigger,
+		.pointer   = pcm_pointer,
+		.page      = snd_pcm_lib_get_vmalloc_page,
+		.mmap      = snd_pcm_lib_mmap_vmalloc,
+	};
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(oxfw->card, oxfw->card->driver, 0, 1, 0, &pcm);
+	if (err < 0)
+		return err;
+	pcm->private_data = oxfw;
+	strcpy(pcm->name, oxfw->card->shortname);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &ops);
+	return 0;
+}
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 4055667..24bb6df 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -25,244 +25,6 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("snd-firewire-speakers");
 
-static int firewave_rate_constraint(struct snd_pcm_hw_params *params,
-				    struct snd_pcm_hw_rule *rule)
-{
-	static unsigned int stereo_rates[] = { 48000, 96000 };
-	struct snd_interval *channels =
-			hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct snd_interval *rate =
-			hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
-
-	/* two channels work only at 48/96 kHz */
-	if (snd_interval_max(channels) < 6)
-		return snd_interval_list(rate, 2, stereo_rates, 0);
-	return 0;
-}
-
-static int firewave_channels_constraint(struct snd_pcm_hw_params *params,
-					struct snd_pcm_hw_rule *rule)
-{
-	static const struct snd_interval all_channels = { .min = 6, .max = 6 };
-	struct snd_interval *rate =
-			hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *channels =
-			hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-
-	/* 32/44.1 kHz work only with all six channels */
-	if (snd_interval_max(rate) < 48000)
-		return snd_interval_refine(channels, &all_channels);
-	return 0;
-}
-
-static int firewave_constraints(struct snd_pcm_runtime *runtime)
-{
-	static unsigned int channels_list[] = { 2, 6 };
-	static struct snd_pcm_hw_constraint_list channels_list_constraint = {
-		.count = 2,
-		.list = channels_list,
-	};
-	int err;
-
-	runtime->hw.rates = SNDRV_PCM_RATE_32000 |
-			    SNDRV_PCM_RATE_44100 |
-			    SNDRV_PCM_RATE_48000 |
-			    SNDRV_PCM_RATE_96000;
-	runtime->hw.channels_max = 6;
-
-	err = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_CHANNELS,
-					 &channels_list_constraint);
-	if (err < 0)
-		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				  firewave_rate_constraint, NULL,
-				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
-	if (err < 0)
-		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-				  firewave_channels_constraint, NULL,
-				  SNDRV_PCM_HW_PARAM_RATE, -1);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-static int lacie_speakers_constraints(struct snd_pcm_runtime *runtime)
-{
-	runtime->hw.rates = SNDRV_PCM_RATE_32000 |
-			    SNDRV_PCM_RATE_44100 |
-			    SNDRV_PCM_RATE_48000 |
-			    SNDRV_PCM_RATE_88200 |
-			    SNDRV_PCM_RATE_96000;
-
-	return 0;
-}
-
-static int oxfw_open(struct snd_pcm_substream *substream)
-{
-	static const struct snd_pcm_hardware hardware = {
-		.info = SNDRV_PCM_INFO_MMAP |
-			SNDRV_PCM_INFO_MMAP_VALID |
-			SNDRV_PCM_INFO_BATCH |
-			SNDRV_PCM_INFO_INTERLEAVED |
-			SNDRV_PCM_INFO_BLOCK_TRANSFER,
-		.formats = AMDTP_OUT_PCM_FORMAT_BITS,
-		.channels_min = 2,
-		.channels_max = 2,
-		.buffer_bytes_max = 4 * 1024 * 1024,
-		.period_bytes_min = 1,
-		.period_bytes_max = UINT_MAX,
-		.periods_min = 1,
-		.periods_max = UINT_MAX,
-	};
-	struct snd_oxfw *oxfw = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-
-	runtime->hw = hardware;
-
-	err = oxfw->device_info->pcm_constraints(runtime);
-	if (err < 0)
-		return err;
-	err = snd_pcm_limit_hw_rates(runtime);
-	if (err < 0)
-		return err;
-
-	err = amdtp_stream_add_pcm_hw_constraints(&oxfw->rx_stream, runtime);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-static int oxfw_close(struct snd_pcm_substream *substream)
-{
-	return 0;
-}
-
-static int oxfw_hw_params(struct snd_pcm_substream *substream,
-			   struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_oxfw *oxfw = substream->private_data;
-	int err;
-
-	mutex_lock(&oxfw->mutex);
-
-	snd_oxfw_stream_stop_simplex(oxfw);
-
-	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
-					       params_buffer_bytes(hw_params));
-	if (err < 0)
-		goto error;
-
-	amdtp_stream_set_parameters(&oxfw->rx_stream,
-				    params_rate(hw_params),
-				    params_channels(hw_params),
-				    0);
-
-	amdtp_stream_set_pcm_format(&oxfw->rx_stream,
-				    params_format(hw_params));
-
-	err = avc_general_set_sig_fmt(oxfw->unit, params_rate(hw_params),
-				      AVC_GENERAL_PLUG_DIR_IN, 0);
-	if (err < 0) {
-		dev_err(&oxfw->unit->device, "failed to set sample rate\n");
-		goto err_buffer;
-	}
-
-	return 0;
-
-err_buffer:
-	snd_pcm_lib_free_vmalloc_buffer(substream);
-error:
-	mutex_unlock(&oxfw->mutex);
-	return err;
-}
-
-static int oxfw_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_oxfw *oxfw = substream->private_data;
-
-	mutex_lock(&oxfw->mutex);
-	snd_oxfw_stream_stop_simplex(oxfw);
-	mutex_unlock(&oxfw->mutex);
-
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
-}
-
-static int oxfw_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_oxfw *oxfw = substream->private_data;
-	int err;
-
-	mutex_lock(&oxfw->mutex);
-
-	snd_oxfw_stream_stop_simplex(oxfw);
-
-	err = snd_oxfw_stream_start_simplex(oxfw);
-	if (err < 0)
-		goto end;
-
-	amdtp_stream_pcm_prepare(&oxfw->rx_stream);
-end:
-	mutex_unlock(&oxfw->mutex);
-	return err;
-}
-
-static int oxfw_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct snd_oxfw *oxfw = substream->private_data;
-	struct snd_pcm_substream *pcm;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		pcm = substream;
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-		pcm = NULL;
-		break;
-	default:
-		return -EINVAL;
-	}
-	amdtp_stream_pcm_trigger(&oxfw->rx_stream, pcm);
-	return 0;
-}
-
-static snd_pcm_uframes_t oxfw_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_oxfw *oxfw = substream->private_data;
-
-	return amdtp_stream_pcm_pointer(&oxfw->rx_stream);
-}
-
-static int oxfw_create_pcm(struct snd_oxfw *oxfw)
-{
-	static struct snd_pcm_ops ops = {
-		.open      = oxfw_open,
-		.close     = oxfw_close,
-		.ioctl     = snd_pcm_lib_ioctl,
-		.hw_params = oxfw_hw_params,
-		.hw_free   = oxfw_hw_free,
-		.prepare   = oxfw_prepare,
-		.trigger   = oxfw_trigger,
-		.pointer   = oxfw_pointer,
-		.page      = snd_pcm_lib_get_vmalloc_page,
-		.mmap      = snd_pcm_lib_mmap_vmalloc,
-	};
-	struct snd_pcm *pcm;
-	int err;
-
-	err = snd_pcm_new(oxfw->card, "OXFW", 0, 1, 0, &pcm);
-	if (err < 0)
-		return err;
-	pcm->private_data = oxfw;
-	strcpy(pcm->name, oxfw->device_info->short_name);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &ops);
-	return 0;
-}
-
 enum control_action { CTL_READ, CTL_WRITE };
 enum control_attribute {
 	CTL_MIN		= 0x02,
@@ -587,7 +349,7 @@ static int oxfw_probe(struct fw_unit *unit,
 		 dev_name(&unit->device), 100 << fw_dev->max_speed);
 	strcpy(card->mixername, "OXFW");
 
-	err = oxfw_create_pcm(oxfw);
+	err = snd_oxfw_create_pcm(oxfw);
 	if (err < 0)
 		goto error;
 
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index e5836e0..1196db8 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -54,3 +54,7 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw);
+
+int firewave_constraints(struct snd_pcm_runtime *runtime);
+int lacie_speakers_constraints(struct snd_pcm_runtime *runtime);
+int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
-- 
2.1.0
