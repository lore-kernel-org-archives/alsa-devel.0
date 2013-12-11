From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/8] fireworks: Add PCM interface
Date: Wed, 11 Dec 2013 18:15:57 +0900
Message-ID: <1386753359-12458-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id BF2BA261ADE
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 10:16:38 +0100 (CET)
In-Reply-To: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit adds a functionality to capture/playback PCM samples.

When AMDTP stream is already running for PCM or the source of clock is not
internal, available sampling rate is limited at current one.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/Makefile           |   2 +-
 sound/firewire/fireworks/fireworks.c        |   4 +
 sound/firewire/fireworks/fireworks.h        |   4 +
 sound/firewire/fireworks/fireworks_pcm.c    | 450 ++++++++++++++++++++++++++++
 sound/firewire/fireworks/fireworks_stream.c |  23 --
 5 files changed, 459 insertions(+), 24 deletions(-)
 create mode 100644 sound/firewire/fireworks/fireworks_pcm.c

diff --git a/sound/firewire/fireworks/Makefile b/sound/firewire/fireworks/Makefile
index 6594bcc..a92876d 100644
--- a/sound/firewire/fireworks/Makefile
+++ b/sound/firewire/fireworks/Makefile
@@ -1,4 +1,4 @@
 snd-fireworks-objs := fireworks_transaction.o fireworks_command.o \
 		      fireworks_stream.o fireworks_proc.o fireworks.o \
-		      fireworks_midi.o fireworks.o
+		      fireworks_midi.o fireworks_pcm.o fireworks.o
 obj-m += snd-fireworks.o
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index dff7d24..0ae669c 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -223,6 +223,10 @@ efw_probe(struct fw_unit *unit,
 			goto error;
 	}
 
+	err = snd_efw_create_pcm_devices(efw);
+	if (err < 0)
+		goto error;
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0)
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 0f892a8..2dc7008 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -33,6 +33,7 @@
 #include <sound/pcm.h>
 #include <sound/info.h>
 #include <sound/rawmidi.h>
+#include <sound/pcm_params.h>
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
@@ -209,6 +210,9 @@ void snd_efw_proc_init(struct snd_efw *efw);
 
 int snd_efw_create_midi_devices(struct snd_efw *efw);
 
+int snd_efw_create_pcm_devices(struct snd_efw *efw);
+int snd_efw_get_multiplier_mode(int sampling_rate);
+
 #define SND_EFW_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
new file mode 100644
index 0000000..4f25a78
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -0,0 +1,450 @@
+/*
+ * fireworks_pcm.c - a part of driver for Fireworks based devices
+ *
+ * Copyright (c) 2009-2010 Clemens Ladisch
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ *
+ * This driver is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2.
+ *
+ * This driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "./fireworks.h"
+
+/*
+ * NOTE:
+ * Fireworks changes its AMDTP channels for PCM data according to its sampling
+ * rate. There are three modes. Here _XX is either _rx or _tx.
+ *  0:  32.0- 48.0 kHz then snd_efw_hwinfo.amdtp_XX_pcm_channels applied
+ *  1:  88.2- 96.0 kHz then snd_efw_hwinfo.amdtp_XX_pcm_channels_2x applied
+ *  2: 176.4-192.0 kHz then snd_efw_hwinfo.amdtp_XX_pcm_channels_4x applied
+ *
+ * The number of PCM channels for analog input and output are always fixed but
+ * the number of PCM channels for digital input and output are differed.
+ *
+ * Additionally, according to "AudioFire Owner's Manual Version 2.2", in some
+ * model, the number of PCM channels for digital input has more restriction
+ * depending on which digital interface is selected.
+ *  - S/PDIF coaxial and optical	: use input 1-2
+ *  - ADAT optical at 32.0-48.0 kHz	: use input 1-8
+ *  - ADAT optical at 88.2-96.0 kHz	: use input 1-4 (S/MUX format)
+ *
+ * The data in AMDTP channels for blank PCM channels are zero.
+ */
+static unsigned int freq_table[] = {
+	/* multiplier mode 0 */
+	[0] = 32000,
+	[1] = 44100,
+	[2] = 48000,
+	/* multiplier mode 1 */
+	[3] = 88200,
+	[4] = 96000,
+	/* multiplier mode 2 */
+	[5] = 176400,
+	[6] = 192000,
+};
+
+static inline int
+get_multiplier_mode_with_index(int index)
+{
+	return ((int)index - 1) / 2;
+}
+
+int snd_efw_get_multiplier_mode(int sampling_rate)
+{
+	int i;
+	for (i = 0; i < sizeof(freq_table); i++)
+		if (freq_table[i] == sampling_rate)
+			return get_multiplier_mode_with_index(i);
+
+	return -1;
+}
+
+static int
+hw_rule_rate(struct snd_pcm_hw_params *params,
+	     struct snd_pcm_hw_rule *rule,
+	     struct snd_efw *efw, unsigned int *channels)
+{
+	struct snd_interval *r =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	const struct snd_interval *c =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int rate_bit;
+	int mode, i;
+
+	for (i = 0; i < ARRAY_SIZE(freq_table); i++) {
+		/* skip unsupported sampling rate */
+		rate_bit = snd_pcm_rate_to_rate_bit(freq_table[i]);
+		if (!(efw->supported_sampling_rate & rate_bit))
+			continue;
+
+		mode = get_multiplier_mode_with_index(i);
+		if (!snd_interval_test(c, channels[mode]))
+			continue;
+
+		t.min = min(t.min, freq_table[i]);
+		t.max = max(t.max, freq_table[i]);
+
+	}
+
+	return snd_interval_refine(r, &t);
+}
+
+static int
+hw_rule_channels(struct snd_pcm_hw_params *params,
+		 struct snd_pcm_hw_rule *rule,
+		 struct snd_efw *efw, unsigned int *channels)
+{
+	struct snd_interval *c =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	const struct snd_interval *r =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+
+	unsigned int rate_bit;
+	int mode, i;
+
+	for (i = 0; i < ARRAY_SIZE(freq_table); i++) {
+		/* skip unsupported sampling rate */
+		rate_bit = snd_pcm_rate_to_rate_bit(freq_table[i]);
+		if (!(efw->supported_sampling_rate & rate_bit))
+			continue;
+
+		mode = get_multiplier_mode_with_index(i);
+		if (!snd_interval_test(r, freq_table[i]))
+			continue;
+
+		t.min = min(t.min, channels[mode]);
+		t.max = max(t.max, channels[mode]);
+
+	}
+
+	return snd_interval_refine(c, &t);
+}
+
+static int
+hw_rule_capture_rate(struct snd_pcm_hw_params *params,
+		     struct snd_pcm_hw_rule *rule)
+{
+	struct snd_efw *efw = rule->private;
+	return hw_rule_rate(params, rule, efw,
+				efw->pcm_capture_channels);
+}
+
+static int
+hw_rule_playback_rate(struct snd_pcm_hw_params *params,
+		      struct snd_pcm_hw_rule *rule)
+{
+	struct snd_efw *efw = rule->private;
+	return hw_rule_rate(params, rule, efw,
+				efw->pcm_playback_channels);
+}
+
+static int
+hw_rule_capture_channels(struct snd_pcm_hw_params *params,
+			 struct snd_pcm_hw_rule *rule)
+{
+	struct snd_efw *efw = rule->private;
+	return hw_rule_channels(params, rule, efw,
+				efw->pcm_capture_channels);
+}
+
+static int
+hw_rule_playback_channels(struct snd_pcm_hw_params *params,
+			  struct snd_pcm_hw_rule *rule)
+{
+	struct snd_efw *efw = rule->private;
+	return hw_rule_channels(params, rule, efw,
+				efw->pcm_playback_channels);
+}
+
+static int
+pcm_init_hw_params(struct snd_efw *efw,
+		   struct snd_pcm_substream *substream)
+{
+	unsigned int *pcm_channels;
+	unsigned int rate_bit;
+	int mode, i;
+	int err;
+
+	struct snd_pcm_hardware hardware = {
+		.info = SNDRV_PCM_INFO_MMAP |
+			SNDRV_PCM_INFO_BATCH |
+			SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_SYNC_START |
+			SNDRV_PCM_INFO_FIFO_IN_FRAMES |
+			SNDRV_PCM_INFO_JOINT_DUPLEX |
+			/* for Open Sound System compatibility */
+			SNDRV_PCM_INFO_MMAP_VALID |
+			SNDRV_PCM_INFO_BLOCK_TRANSFER,
+		.rates = efw->supported_sampling_rate,
+		.rate_min = UINT_MAX,
+		.rate_max = 0,
+		.channels_min = UINT_MAX,
+		.channels_max = 0,
+		.buffer_bytes_max = 1024 * 1024 * 1024,
+		.period_bytes_min = 256,
+		.period_bytes_max = 1024 * 1024 * 1024 / 2,
+		.periods_min = 2,
+		.periods_max = 32,
+		.fifo_size = 0,
+	};
+
+	substream->runtime->hw = hardware;
+	substream->runtime->delay = substream->runtime->hw.fifo_size;
+
+	/* add rule between channels and sampling rate */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
+		snd_pcm_hw_rule_add(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_CHANNELS,
+				hw_rule_capture_channels, efw,
+				SNDRV_PCM_HW_PARAM_RATE, -1);
+		snd_pcm_hw_rule_add(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE,
+				hw_rule_capture_rate, efw,
+				SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+		pcm_channels = efw->pcm_capture_channels;
+	} else {
+		substream->runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		snd_pcm_hw_rule_add(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_CHANNELS,
+				hw_rule_playback_channels, efw,
+				SNDRV_PCM_HW_PARAM_RATE, -1);
+		snd_pcm_hw_rule_add(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE,
+				hw_rule_playback_rate, efw,
+				SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+		pcm_channels = efw->pcm_playback_channels;
+	}
+
+	/* limitation for min/max sampling rate */
+	snd_pcm_limit_hw_rates(substream->runtime);
+
+	/* limitation for the number of channels */
+	for (i = 0; i < ARRAY_SIZE(freq_table); i++) {
+		/* skip unsupported sampling rate */
+		rate_bit = snd_pcm_rate_to_rate_bit(freq_table[i]);
+		if (!(efw->supported_sampling_rate & rate_bit))
+			continue;
+
+		mode = get_multiplier_mode_with_index(i);
+		if (pcm_channels[mode] == 0)
+			continue;
+		substream->runtime->hw.channels_min =
+			min(substream->runtime->hw.channels_min,
+				pcm_channels[mode]);
+		substream->runtime->hw.channels_max =
+			max(substream->runtime->hw.channels_max,
+				pcm_channels[mode]);
+	}
+
+	/* AM824 in IEC 61883-6 can deliver 24bit data */
+	err = snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * AMDTP functionality in firewire-lib require periods to be aligned to
+	 * 16 bit, or 24bit inner 32bit.
+	 */
+	err = snd_pcm_hw_constraint_step(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
+	if (err < 0)
+		goto end;
+
+	/* time for period constraint */
+	err = snd_pcm_hw_constraint_minmax(substream->runtime,
+					SNDRV_PCM_HW_PARAM_PERIOD_TIME,
+					500, UINT_MAX);
+end:
+	return err;
+}
+
+static int pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_efw *efw = substream->private_data;
+	int sampling_rate;
+	unsigned int clock_source;
+	int err;
+
+	err = pcm_init_hw_params(efw, substream);
+	if (err < 0)
+		goto end;
+
+	err = snd_efw_command_get_clock_source(efw, &clock_source);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * When source of clock is not internal or any PCM stream are running,
+	 * the available sampling rate is limited at current sampling rate.
+	 */
+	if ((clock_source != SND_EFW_CLOCK_SOURCE_INTERNAL) ||
+	    amdtp_stream_pcm_running(&efw->tx_stream) ||
+	    amdtp_stream_pcm_running(&efw->rx_stream)) {
+		err = snd_efw_command_get_sampling_rate(efw, &sampling_rate);
+		if (err < 0)
+			goto end;
+		substream->runtime->hw.rate_min = sampling_rate;
+		substream->runtime->hw.rate_max = sampling_rate;
+	}
+
+	snd_pcm_set_sync(substream);
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
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
+
+static int pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_efw *efw = substream->private_data;
+
+	snd_efw_stream_stop_duplex(efw);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int pcm_capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_efw *efw = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	err = snd_efw_stream_start_duplex(efw, &efw->tx_stream, runtime->rate);
+	if (err < 0)
+		goto end;
+
+	amdtp_stream_set_pcm_format(&efw->tx_stream, runtime->format);
+	amdtp_stream_pcm_prepare(&efw->tx_stream);
+end:
+	return err;
+}
+static int pcm_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_efw *efw = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	err = snd_efw_stream_start_duplex(efw, &efw->rx_stream, runtime->rate);
+	if (err < 0)
+		goto end;
+
+	amdtp_stream_set_pcm_format(&efw->rx_stream, runtime->format);
+	amdtp_stream_pcm_prepare(&efw->rx_stream);
+end:
+	return err;
+}
+
+static int pcm_capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_efw *efw = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&efw->tx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&efw->tx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+static int pcm_playback_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_efw *efw = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&efw->rx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&efw->rx_stream, NULL);
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
+	struct snd_efw *efw = sbstrm->private_data;
+	return amdtp_stream_pcm_pointer(&efw->tx_stream);
+}
+static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
+{
+	struct snd_efw *efw = sbstrm->private_data;
+	return amdtp_stream_pcm_pointer(&efw->rx_stream);
+}
+
+static struct snd_pcm_ops pcm_capture_ops = {
+	.open		= pcm_open,
+	.close		= pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= pcm_hw_params,
+	.hw_free	= pcm_hw_free,
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
+	.hw_params	= pcm_hw_params,
+	.hw_free	= pcm_hw_free,
+	.prepare	= pcm_playback_prepare,
+	.trigger	= pcm_playback_trigger,
+	.pointer	= pcm_playback_pointer,
+	.page		= snd_pcm_lib_get_vmalloc_page,
+	.mmap		= snd_pcm_lib_mmap_vmalloc,
+};
+
+int snd_efw_create_pcm_devices(struct snd_efw *efw)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(efw->card, efw->card->driver, 0, 1, 1, &pcm);
+	if (err < 0)
+		goto end;
+
+	pcm->private_data = efw;
+	snprintf(pcm->name, sizeof(pcm->name), "%s PCM", efw->card->shortname);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &pcm_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pcm_capture_ops);
+
+end:
+	return err;
+}
+
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index f0764538..5fd2a12 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -17,29 +17,6 @@
  */
 #include "./fireworks.h"
 
-static unsigned int freq_table[] = {
-	/* multiplier mode 0 */
-	[0] = 32000,
-	[1] = 44100,
-	[2] = 48000,
-	/* multiplier mode 1 */
-	[3] = 88200,
-	[4] = 96000,
-	/* multiplier mode 2 */
-	[5] = 176400,
-	[6] = 192000,
-};
-
-int snd_efw_get_multiplier_mode(int sampling_rate)
-{
-	unsigned int i;
-	for (i = 0; i < sizeof(freq_table); i++)
-		if (freq_table[i] == sampling_rate)
-			return (i - 1) / 2;
-
-	return -1;
-}
-
 static int
 init_stream(struct snd_efw *efw, struct amdtp_stream *stream)
 {
-- 
1.8.3.2
