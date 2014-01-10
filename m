From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/13] speakers: Split PCM functionality to a
	new file
Date: Sat, 11 Jan 2014 00:29:25 +0900
Message-ID: <1389367775-21360-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 18AE9261603
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:29:51 +0100 (CET)
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
 sound/firewire/speakers/Makefile       |   2 +-
 sound/firewire/speakers/speakers.c     | 248 +------------------------------
 sound/firewire/speakers/speakers.h     |   5 +
 sound/firewire/speakers/speakers_pcm.c | 259 +++++++++++++++++++++++++++++++++
 4 files changed, 266 insertions(+), 248 deletions(-)
 create mode 100644 sound/firewire/speakers/speakers_pcm.c

diff --git a/sound/firewire/speakers/Makefile b/sound/firewire/speakers/Makefile
index f46ae1d..a970ccf 100644
--- a/sound/firewire/speakers/Makefile
+++ b/sound/firewire/speakers/Makefile
@@ -1,2 +1,2 @@
-snd-firewire-speakers-objs := speakers_stream.o speakers.o
+snd-firewire-speakers-objs := speakers_stream.o speakers_pcm.o speakers.o
 obj-m += snd-firewire-speakers.o
diff --git a/sound/firewire/speakers/speakers.c b/sound/firewire/speakers/speakers.c
index 47d3cc0..20bba46 100644
--- a/sound/firewire/speakers/speakers.c
+++ b/sound/firewire/speakers/speakers.c
@@ -24,252 +24,6 @@ MODULE_DESCRIPTION("FireWire speakers driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 
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
-static int fwspk_open(struct snd_pcm_substream *substream)
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
-	struct fwspk *fwspk = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int err;
-
-	runtime->hw = hardware;
-
-	err = fwspk->device_info->pcm_constraints(runtime);
-	if (err < 0)
-		return err;
-	err = snd_pcm_limit_hw_rates(runtime);
-	if (err < 0)
-		return err;
-
-	err = snd_pcm_hw_constraint_minmax(runtime,
-					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
-					   5000, UINT_MAX);
-	if (err < 0)
-		return err;
-
-	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-static int fwspk_close(struct snd_pcm_substream *substream)
-{
-	return 0;
-}
-
-static int fwspk_hw_params(struct snd_pcm_substream *substream,
-			   struct snd_pcm_hw_params *hw_params)
-{
-	struct fwspk *fwspk = substream->private_data;
-	int err;
-
-	mutex_lock(&fwspk->mutex);
-	snd_fwspk_stream_stop(fwspk);
-	mutex_unlock(&fwspk->mutex);
-
-	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
-					       params_buffer_bytes(hw_params));
-	if (err < 0)
-		goto error;
-
-	amdtp_stream_set_parameters(&fwspk->rx_stream,
-				    params_rate(hw_params),
-				    params_channels(hw_params),
-				    0);
-
-	amdtp_stream_set_pcm_format(&fwspk->rx_stream,
-				    params_format(hw_params));
-
-	err = avc_general_set_sig_fmt(fwspk->unit, params_rate(hw_params),
-				      AVC_GENERAL_PLUG_DIR_IN, 0);
-	if (err < 0)
-		goto err_buffer;
-	if (err != 0x09 /* ACCEPTED */) {
-		dev_err(&fwspk->unit->device, "failed to set sample rate\n");
-		err = -EIO;
-		goto error;
-	}
-
-	return 0;
-
-err_buffer:
-	snd_pcm_lib_free_vmalloc_buffer(substream);
-error:
-	return err;
-}
-
-static int fwspk_hw_free(struct snd_pcm_substream *substream)
-{
-	struct fwspk *fwspk = substream->private_data;
-
-	mutex_lock(&fwspk->mutex);
-	snd_fwspk_stream_stop(fwspk);
-	mutex_unlock(&fwspk->mutex);
-
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
-}
-
-static int fwspk_prepare(struct snd_pcm_substream *substream)
-{
-	struct fwspk *fwspk = substream->private_data;
-	int err;
-
-	mutex_lock(&fwspk->mutex);
-
-	snd_fwspk_stream_stop(fwspk);
-
-	err = snd_fwspk_stream_start(fwspk);
-	if (err < 0)
-		goto end;
-
-	amdtp_stream_pcm_prepare(&fwspk->rx_stream);
-end:
-	mutex_unlock(&fwspk->mutex);
-	return err;
-}
-
-static int fwspk_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct fwspk *fwspk = substream->private_data;
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
-	amdtp_stream_pcm_trigger(&fwspk->rx_stream, pcm);
-	return 0;
-}
-
-static snd_pcm_uframes_t fwspk_pointer(struct snd_pcm_substream *substream)
-{
-	struct fwspk *fwspk = substream->private_data;
-
-	return amdtp_stream_pcm_pointer(&fwspk->rx_stream);
-}
-
-static int fwspk_create_pcm(struct fwspk *fwspk)
-{
-	static struct snd_pcm_ops ops = {
-		.open      = fwspk_open,
-		.close     = fwspk_close,
-		.ioctl     = snd_pcm_lib_ioctl,
-		.hw_params = fwspk_hw_params,
-		.hw_free   = fwspk_hw_free,
-		.prepare   = fwspk_prepare,
-		.trigger   = fwspk_trigger,
-		.pointer   = fwspk_pointer,
-		.page      = snd_pcm_lib_get_vmalloc_page,
-		.mmap      = snd_pcm_lib_mmap_vmalloc,
-	};
-	struct snd_pcm *pcm;
-	int err;
-
-	err = snd_pcm_new(fwspk->card, "OXFW970", 0, 1, 0, &pcm);
-	if (err < 0)
-		return err;
-	pcm->private_data = fwspk;
-	strcpy(pcm->name, fwspk->device_info->short_name);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &ops);
-	return 0;
-}
-
 enum control_action { CTL_READ, CTL_WRITE };
 enum control_attribute {
 	CTL_MIN		= 0x02,
@@ -602,7 +356,7 @@ static int fwspk_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto err_card;
 
-	err = fwspk_create_pcm(fwspk);
+	err = snd_fwspk_create_pcm(fwspk);
 	if (err < 0)
 		goto err_card;
 
diff --git a/sound/firewire/speakers/speakers.h b/sound/firewire/speakers/speakers.h
index d322b8b..379196d 100644
--- a/sound/firewire/speakers/speakers.h
+++ b/sound/firewire/speakers/speakers.h
@@ -52,3 +52,8 @@ int snd_fwspk_stream_start(struct fwspk *fwspk);
 void snd_fwspk_stream_stop(struct fwspk *fwspk);
 void snd_fwspk_stream_destroy(struct fwspk *fwspk);
 void snd_fwspk_stream_update(struct fwspk *fwspk);
+
+int snd_fwspk_create_pcm(struct fwspk *fwspk);
+
+int firewave_constraints(struct snd_pcm_runtime *runtime);
+int lacie_speakers_constraints(struct snd_pcm_runtime *runtime);
diff --git a/sound/firewire/speakers/speakers_pcm.c b/sound/firewire/speakers/speakers_pcm.c
new file mode 100644
index 0000000..8fa437f
--- /dev/null
+++ b/sound/firewire/speakers/speakers_pcm.c
@@ -0,0 +1,259 @@
+/*
+ * speakers_pcm.c - a part of OXFW970/971-based speakers driver
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "speakers.h"
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
+static int fwspk_open(struct snd_pcm_substream *substream)
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
+	struct fwspk *fwspk = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	bool used;
+	int err;
+
+	err = cmp_connection_check_used(&fwspk->in_conn, &used);
+	if ((err < 0) || used)
+		goto end;
+
+	runtime->hw = hardware;
+
+	err = fwspk->device_info->pcm_constraints(runtime);
+	if (err < 0)
+		goto end;
+	err = snd_pcm_limit_hw_rates(runtime);
+	if (err < 0)
+		goto end;
+
+	err = snd_pcm_hw_constraint_minmax(runtime,
+					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
+					   5000, UINT_MAX);
+	if (err < 0)
+		goto end;
+
+	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	if (err < 0)
+		goto end;
+end:
+	return err;
+}
+
+static int fwspk_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int fwspk_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *hw_params)
+{
+	struct fwspk *fwspk = substream->private_data;
+	int err;
+
+	mutex_lock(&fwspk->mutex);
+	snd_fwspk_stream_stop(fwspk);
+	mutex_unlock(&fwspk->mutex);
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		goto error;
+
+	amdtp_stream_set_parameters(&fwspk->rx_stream,
+				    params_rate(hw_params),
+				    params_channels(hw_params),
+				    0);
+
+	amdtp_stream_set_pcm_format(&fwspk->rx_stream,
+				    params_format(hw_params));
+
+	err = avc_general_set_sig_fmt(fwspk->unit, params_rate(hw_params),
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	if (err < 0)
+		goto err_buffer;
+	if (err != 0x09 /* ACCEPTED */) {
+		dev_err(&fwspk->unit->device, "failed to set sample rate\n");
+		err = -EIO;
+		goto error;
+	}
+
+	return 0;
+
+err_buffer:
+	snd_pcm_lib_free_vmalloc_buffer(substream);
+error:
+	return err;
+}
+
+static int fwspk_hw_free(struct snd_pcm_substream *substream)
+{
+	struct fwspk *fwspk = substream->private_data;
+
+	mutex_lock(&fwspk->mutex);
+	snd_fwspk_stream_stop(fwspk);
+	mutex_unlock(&fwspk->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int fwspk_prepare(struct snd_pcm_substream *substream)
+{
+	struct fwspk *fwspk = substream->private_data;
+	int err;
+
+	mutex_lock(&fwspk->mutex);
+
+	snd_fwspk_stream_stop(fwspk);
+
+	err = snd_fwspk_stream_start(fwspk);
+	if (err < 0)
+		goto end;
+
+	amdtp_stream_pcm_prepare(&fwspk->rx_stream);
+end:
+	mutex_unlock(&fwspk->mutex);
+	return err;
+}
+
+static int fwspk_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct fwspk *fwspk = substream->private_data;
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
+	amdtp_stream_pcm_trigger(&fwspk->rx_stream, pcm);
+	return 0;
+}
+
+static snd_pcm_uframes_t fwspk_pointer(struct snd_pcm_substream *substream)
+{
+	struct fwspk *fwspk = substream->private_data;
+
+	return amdtp_stream_pcm_pointer(&fwspk->rx_stream);
+}
+
+int snd_fwspk_create_pcm(struct fwspk *fwspk)
+{
+	static struct snd_pcm_ops ops = {
+		.open      = fwspk_open,
+		.close     = fwspk_close,
+		.ioctl     = snd_pcm_lib_ioctl,
+		.hw_params = fwspk_hw_params,
+		.hw_free   = fwspk_hw_free,
+		.prepare   = fwspk_prepare,
+		.trigger   = fwspk_trigger,
+		.pointer   = fwspk_pointer,
+		.page      = snd_pcm_lib_get_vmalloc_page,
+		.mmap      = snd_pcm_lib_mmap_vmalloc,
+	};
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(fwspk->card, fwspk->card->driver, 0, 1, 0, &pcm);
+	if (err < 0)
+		return err;
+	pcm->private_data = fwspk;
+	strcpy(pcm->name, fwspk->card->shortname);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &ops);
+	return 0;
+}
-- 
1.8.3.2
