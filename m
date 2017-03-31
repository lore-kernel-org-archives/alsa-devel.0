From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/14] ALSA: fireface: add support for PCM
	functionality
Date: Fri, 31 Mar 2017 22:06:10 +0900
Message-ID: <20170331130612.18331-13-o-takashi@sakamocchi.jp>
References: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 68D9D267236
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:06:25 +0200 (CEST)
In-Reply-To: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds PCM functionality to transmit/receive PCM frames on
isochronous packet streaming. This commit enables userspace applications
to start/stop packet streaming via ALSA PCM interface.

Sampling rate requested by applications is used as sampling transmission
frequency of IEC 61883-1/6packet streaming. As I described in followed
commits, units in this series manages sampling clock frequency
independently of sampling transmission frequency, and they supports
resampling between their packet streaming/data block processing layer and
sampling data processing layer. This commit take this driver to utilize
these features for usability.

When internal clock is selected as source signal of sampling clock, this
driver allows user space applications to start PCM substreams at any rate
which packet streaming engine supports as sampling transmission frequency.
In this case, this driver expects units to perform resampling PCM frames
for rx/tx packets when sampling clock frequency and sampling transmission
frequency are mismatched. This is for daily use cases.

When any external clock is selected as the source signal, this driver
gets configured sampling rate from units, then restricts available
sampling rate to the rate for PCM applications. This is for studio use
cases.

Models in this series supports 64.0/128.0 kHz of sampling rate, however
these frequencies are not supported by IEC 61883-6 as sampling transmission
frequency. Therefore, packet streaming engine of ALSA firewire stack can't
handle them. When units are configured to use any external clock as source
signal of sampling clock and one of these unsupported rate is configured
as rate of the sampling clock, this driver returns EIO to user space
applications.

Anyway, this driver doesn't voluntarily configure parameters of sampling
clock. It's better for users to work with appropriate user space
implementations to configure the parameters in advance of usage.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile |   2 +-
 sound/firewire/fireface/ff-pcm.c | 395 +++++++++++++++++++++++++++++++++++++++
 sound/firewire/fireface/ff.c     |   4 +
 sound/firewire/fireface/ff.h     |   4 +
 4 files changed, 404 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireface/ff-pcm.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index b772fdc..e626938 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,3 +1,3 @@
 snd-fireface-objs := ff.o ff-transaction.o ff-midi.o ff-proc.o amdtp-ff.o \
-		     ff-stream.o
+		     ff-stream.o ff-pcm.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
new file mode 100644
index 0000000..d282467
--- /dev/null
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -0,0 +1,395 @@
+/*
+ * ff-pcm.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "ff.h"
+
+static inline unsigned int get_multiplier_mode_with_index(unsigned int index)
+{
+	return ((int)index - 1) / 2;
+}
+
+static int hw_rule_rate(struct snd_pcm_hw_params *params,
+			struct snd_pcm_hw_rule *rule)
+{
+	const unsigned int *pcm_channels = rule->private;
+	struct snd_interval *r =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	const struct snd_interval *c =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int i, mode;
+
+	for (i = 0; i < ARRAY_SIZE(amdtp_rate_table); i++) {
+		mode = get_multiplier_mode_with_index(i);
+		if (!snd_interval_test(c, pcm_channels[mode]))
+			continue;
+
+		t.min = min(t.min, amdtp_rate_table[i]);
+		t.max = max(t.max, amdtp_rate_table[i]);
+	}
+
+	return snd_interval_refine(r, &t);
+}
+
+static int hw_rule_channels(struct snd_pcm_hw_params *params,
+			    struct snd_pcm_hw_rule *rule)
+{
+	const unsigned int *pcm_channels = rule->private;
+	struct snd_interval *c =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	const struct snd_interval *r =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int i, mode;
+
+	for (i = 0; i < ARRAY_SIZE(amdtp_rate_table); i++) {
+		mode = get_multiplier_mode_with_index(i);
+		if (!snd_interval_test(r, amdtp_rate_table[i]))
+			continue;
+
+		t.min = min(t.min, pcm_channels[mode]);
+		t.max = max(t.max, pcm_channels[mode]);
+	}
+
+	return snd_interval_refine(c, &t);
+}
+
+static void limit_channels_and_rates(struct snd_pcm_hardware *hw,
+				     const unsigned int *pcm_channels)
+{
+	unsigned int mode;
+	unsigned int rate, channels;
+	int i;
+
+	hw->channels_min = UINT_MAX;
+	hw->channels_max = 0;
+	hw->rate_min = UINT_MAX;
+	hw->rate_max = 0;
+
+	for (i = 0; i < ARRAY_SIZE(amdtp_rate_table); i++) {
+		mode = get_multiplier_mode_with_index(i);
+
+		channels = pcm_channels[mode];
+		if (pcm_channels[mode] == 0)
+			continue;
+		hw->channels_min = min(hw->channels_min, channels);
+		hw->channels_max = max(hw->channels_max, channels);
+
+		rate = amdtp_rate_table[i];
+		hw->rates |= snd_pcm_rate_to_rate_bit(rate);
+		hw->rate_min = min(hw->rate_min, rate);
+		hw->rate_max = max(hw->rate_max, rate);
+	}
+}
+
+static void limit_period_and_buffer(struct snd_pcm_hardware *hw)
+{
+	hw->periods_min = 2;		/* SNDRV_PCM_INFO_BATCH */
+	hw->periods_max = UINT_MAX;
+
+	hw->period_bytes_min = 4 * hw->channels_max;	/* bytes for a frame */
+
+	/* Just to prevent from allocating much pages. */
+	hw->period_bytes_max = hw->period_bytes_min * 2048;
+	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
+}
+
+static int pcm_init_hw_params(struct snd_ff *ff,
+			      struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct amdtp_stream *s;
+	const unsigned int *pcm_channels;
+	int err;
+
+	runtime->hw.info = SNDRV_PCM_INFO_BATCH |
+			   SNDRV_PCM_INFO_BLOCK_TRANSFER |
+			   SNDRV_PCM_INFO_INTERLEAVED |
+			   SNDRV_PCM_INFO_JOINT_DUPLEX |
+			   SNDRV_PCM_INFO_MMAP |
+			   SNDRV_PCM_INFO_MMAP_VALID;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
+		s = &ff->tx_stream;
+		pcm_channels = ff->spec->pcm_capture_channels;
+	} else {
+		runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
+		s = &ff->rx_stream;
+		pcm_channels = ff->spec->pcm_playback_channels;
+	}
+
+	/* limit rates */
+	limit_channels_and_rates(&runtime->hw, pcm_channels);
+	limit_period_and_buffer(&runtime->hw);
+
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  hw_rule_channels, (void *)pcm_channels,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  hw_rule_rate, (void *)pcm_channels,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (err < 0)
+		return err;
+
+	return amdtp_ff_add_pcm_hw_constraints(s, runtime);
+}
+
+static int pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_ff *ff = substream->private_data;
+	unsigned int rate;
+	enum snd_ff_clock_src src;
+	int i, err;
+
+	err = pcm_init_hw_params(ff, substream);
+	if (err < 0)
+		return err;
+
+	err = ff->spec->protocol->get_clock(ff, &rate, &src);
+	if (err < 0)
+		return err;
+
+	if (src != SND_FF_CLOCK_SRC_INTERNAL) {
+		for (i = 0; i < CIP_SFC_COUNT; ++i) {
+			if (amdtp_rate_table[i] == rate)
+				break;
+		}
+		/*
+		 * The unit is configured at sampling frequency which packet
+		 * streaming engine can't support.
+		 */
+		if (i >= CIP_SFC_COUNT)
+			return -EIO;
+
+		substream->runtime->hw.rate_min = rate;
+		substream->runtime->hw.rate_max = rate;
+	} else {
+		if (amdtp_stream_pcm_running(&ff->rx_stream) ||
+		    amdtp_stream_pcm_running(&ff->tx_stream)) {
+			rate = amdtp_rate_table[ff->rx_stream.sfc];
+			substream->runtime->hw.rate_min = rate;
+			substream->runtime->hw.rate_max = rate;
+		}
+	}
+
+	snd_pcm_set_sync(substream);
+
+	return 0;
+}
+
+static int pcm_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_ff *ff = substream->private_data;
+	int err;
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&ff->mutex);
+		ff->substreams_counter++;
+		mutex_unlock(&ff->mutex);
+	}
+
+	return 0;
+}
+
+static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_ff *ff = substream->private_data;
+	int err;
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&ff->mutex);
+		ff->substreams_counter++;
+		mutex_unlock(&ff->mutex);
+	}
+
+	return 0;
+}
+
+static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_ff *ff = substream->private_data;
+
+	mutex_lock(&ff->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		ff->substreams_counter--;
+
+	snd_ff_stream_stop_duplex(ff);
+
+	mutex_unlock(&ff->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_ff *ff = substream->private_data;
+
+	mutex_lock(&ff->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		ff->substreams_counter--;
+
+	snd_ff_stream_stop_duplex(ff);
+
+	mutex_unlock(&ff->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int pcm_capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_ff *ff = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	mutex_lock(&ff->mutex);
+
+	err = snd_ff_stream_start_duplex(ff, runtime->rate);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&ff->tx_stream);
+
+	mutex_unlock(&ff->mutex);
+
+	return err;
+}
+
+static int pcm_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_ff *ff = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	mutex_lock(&ff->mutex);
+
+	err = snd_ff_stream_start_duplex(ff, runtime->rate);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&ff->rx_stream);
+
+	mutex_unlock(&ff->mutex);
+
+	return err;
+}
+
+static int pcm_capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_ff *ff = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&ff->tx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&ff->tx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int pcm_playback_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_ff *ff = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&ff->rx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&ff->rx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t pcm_capture_pointer(struct snd_pcm_substream *sbstrm)
+{
+	struct snd_ff *ff = sbstrm->private_data;
+
+	return amdtp_stream_pcm_pointer(&ff->tx_stream);
+}
+
+static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
+{
+	struct snd_ff *ff = sbstrm->private_data;
+
+	return amdtp_stream_pcm_pointer(&ff->rx_stream);
+}
+
+static struct snd_pcm_ops pcm_capture_ops = {
+	.open		= pcm_open,
+	.close		= pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= pcm_capture_hw_params,
+	.hw_free	= pcm_capture_hw_free,
+	.prepare	= pcm_capture_prepare,
+	.trigger	= pcm_capture_trigger,
+	.pointer	= pcm_capture_pointer,
+	.page		= snd_pcm_lib_get_vmalloc_page,
+};
+
+static struct snd_pcm_ops pcm_playback_ops = {
+	.open		= pcm_open,
+	.close		= pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= pcm_playback_hw_params,
+	.hw_free	= pcm_playback_hw_free,
+	.prepare	= pcm_playback_prepare,
+	.trigger	= pcm_playback_trigger,
+	.pointer	= pcm_playback_pointer,
+	.page		= snd_pcm_lib_get_vmalloc_page,
+	.mmap		= snd_pcm_lib_mmap_vmalloc,
+};
+
+int snd_ff_create_pcm_devices(struct snd_ff *ff)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(ff->card, ff->card->driver, 0, 1, 1, &pcm);
+	if (err < 0)
+		return err;
+
+	pcm->private_data = ff;
+	snprintf(pcm->name, sizeof(pcm->name),
+		 "%s PCM", ff->card->shortname);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &pcm_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pcm_capture_ops);
+
+	return 0;
+}
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 6bdbebd..ff62d16 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -72,6 +72,10 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
+	err = snd_ff_create_pcm_devices(ff);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(ff->card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 6599c11..0d5228c 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -21,6 +21,8 @@
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/rawmidi.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 
 #include "../lib.h"
 #include "../amdtp-stream.h"
@@ -124,4 +126,6 @@ void snd_ff_proc_init(struct snd_ff *ff);
 
 int snd_ff_create_midi_devices(struct snd_ff *ff);
 
+int snd_ff_create_pcm_devices(struct snd_ff *ff);
+
 #endif
-- 
2.9.3
