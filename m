From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 38/49] bebob: Add PCM interface
Date: Fri, 25 Apr 2014 22:45:19 +0900
Message-ID: <1398433530-13136-39-git-send-email-o-takashi@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds a functionality to capture/playback PCM samples.

When AMDTP stream is already running for PCM or the source of clock is not
internal, available sampling rate is limited at current one.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig           |   1 +
 sound/firewire/bebob/Makefile    |   1 +
 sound/firewire/bebob/bebob.c     |   4 +
 sound/firewire/bebob/bebob.h     |   4 +
 sound/firewire/bebob/bebob_pcm.c | 369 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 379 insertions(+)
 create mode 100644 sound/firewire/bebob/bebob_pcm.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 708d3c8..d55fd5f 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -83,6 +83,7 @@ config SND_BEBOB
 	tristate "BridgeCo DM1000/DM1100/DM1500 with BeBoB firmware"
 	select SND_FIREWIRE_LIB
 	select SND_RAWMIDI
+	select SND_PCM
         help
 	 Say Y here to include support for FireWire devices based
 	 on BridgeCo DM1000/DM1100/DM1500 with BeBoB firmware:
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 1e39e59..533718a 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,3 +1,4 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_midi.o \
+		  bebob_pcm.o \
 		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 383df9a..dbd12c3 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -171,6 +171,10 @@ bebob_probe(struct fw_unit *unit,
 			goto error;
 	}
 
+	err = snd_bebob_create_pcm_devices(bebob);
+	if (err < 0)
+		goto error;
+
 	err = snd_bebob_stream_init_duplex(bebob);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 0d53cff..b41bb91 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -22,6 +22,8 @@
 #include <sound/initval.h>
 #include <sound/info.h>
 #include <sound/rawmidi.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -177,6 +179,8 @@ void snd_bebob_proc_init(struct snd_bebob *bebob);
 
 int snd_bebob_create_midi_devices(struct snd_bebob *bebob);
 
+int snd_bebob_create_pcm_devices(struct snd_bebob *bebob);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
new file mode 100644
index 0000000..7474309
--- /dev/null
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -0,0 +1,369 @@
+/*
+ * bebob_pcm.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013-2014 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./bebob.h"
+
+static int
+hw_rule_rate(struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
+{
+	struct snd_bebob_stream_formation *formations = rule->private;
+	struct snd_interval *r =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	const struct snd_interval *c =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int i;
+
+	for (i = 0; i < SND_BEBOB_STRM_FMT_ENTRIES; i++) {
+		/* entry is invalid */
+		if (formations[i].pcm == 0)
+			continue;
+
+		if (!snd_interval_test(c, formations[i].pcm))
+			continue;
+
+		t.min = min(t.min, snd_bebob_rate_table[i]);
+		t.max = max(t.max, snd_bebob_rate_table[i]);
+
+	}
+	return snd_interval_refine(r, &t);
+}
+
+static int
+hw_rule_channels(struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
+{
+	struct snd_bebob_stream_formation *formations = rule->private;
+	struct snd_interval *c =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	const struct snd_interval *r =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+
+	unsigned int i;
+
+	for (i = 0; i < SND_BEBOB_STRM_FMT_ENTRIES; i++) {
+		/* entry is invalid */
+		if (formations[i].pcm == 0)
+			continue;
+
+		if (!snd_interval_test(r, snd_bebob_rate_table[i]))
+			continue;
+
+		t.min = min(t.min, formations[i].pcm);
+		t.max = max(t.max, formations[i].pcm);
+	}
+
+	return snd_interval_refine(c, &t);
+}
+
+static void
+limit_channels_and_rates(struct snd_pcm_hardware *hw,
+			 struct snd_bebob_stream_formation *formations)
+{
+	unsigned int i;
+
+	hw->channels_min = UINT_MAX;
+	hw->channels_max = 0;
+
+	hw->rate_min = UINT_MAX;
+	hw->rate_max = 0;
+	hw->rates = 0;
+
+	for (i = 0; i < SND_BEBOB_STRM_FMT_ENTRIES; i++) {
+		/* entry has no PCM channels */
+		if (formations[i].pcm == 0)
+			continue;
+
+		hw->channels_min = min(hw->channels_min, formations[i].pcm);
+		hw->channels_max = max(hw->channels_max, formations[i].pcm);
+
+		hw->rate_min = min(hw->rate_min, snd_bebob_rate_table[i]);
+		hw->rate_max = max(hw->rate_max, snd_bebob_rate_table[i]);
+		hw->rates |= snd_pcm_rate_to_rate_bit(snd_bebob_rate_table[i]);
+	}
+}
+
+static void
+limit_period_and_buffer(struct snd_pcm_hardware *hw)
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
+static int
+pcm_init_hw_params(struct snd_bebob *bebob,
+		   struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct amdtp_stream *s;
+	struct snd_bebob_stream_formation *formations;
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
+		runtime->hw.formats = AMDTP_IN_PCM_FORMAT_BITS;
+		s = &bebob->tx_stream;
+		formations = bebob->tx_stream_formations;
+	} else {
+		runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		s = &bebob->rx_stream;
+		formations = bebob->rx_stream_formations;
+	}
+
+	limit_channels_and_rates(&runtime->hw, formations);
+	limit_period_and_buffer(&runtime->hw);
+
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  hw_rule_channels, formations,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		goto end;
+
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  hw_rule_rate, formations,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (err < 0)
+		goto end;
+
+	err = amdtp_stream_add_pcm_hw_constraints(s, runtime);
+end:
+	return err;
+}
+
+static int
+pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_bebob *bebob = substream->private_data;
+	unsigned int sampling_rate;
+	bool internal;
+	int err;
+
+	err = pcm_init_hw_params(bebob, substream);
+	if (err < 0)
+		goto end;
+
+	err = snd_bebob_stream_check_internal_clock(bebob, &internal);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * When source of clock is internal or any PCM stream are running,
+	 * the available sampling rate is limited at current sampling rate.
+	 */
+	if (!internal ||
+	    amdtp_stream_pcm_running(&bebob->tx_stream) ||
+	    amdtp_stream_pcm_running(&bebob->rx_stream)) {
+		err = snd_bebob_stream_get_rate(bebob, &sampling_rate);
+		if (err < 0) {
+			dev_err(&bebob->unit->device,
+				"fail to get sampling rate: %d\n", err);
+			goto end;
+		}
+
+		substream->runtime->hw.rate_min = sampling_rate;
+		substream->runtime->hw.rate_max = sampling_rate;
+	}
+
+	snd_pcm_set_sync(substream);
+
+end:
+	return err;
+}
+
+static int
+pcm_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int
+pcm_capture_hw_params(struct snd_pcm_substream *substream,
+		      struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_bebob *bebob = substream->private_data;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		atomic_inc(&bebob->capture_substreams);
+	amdtp_stream_set_pcm_format(&bebob->tx_stream,
+				    params_format(hw_params));
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
+static int
+pcm_playback_hw_params(struct snd_pcm_substream *substream,
+		       struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_bebob *bebob = substream->private_data;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		atomic_inc(&bebob->playback_substreams);
+	amdtp_stream_set_pcm_format(&bebob->rx_stream,
+				    params_format(hw_params));
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
+
+static int
+pcm_capture_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_bebob *bebob = substream->private_data;
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		atomic_dec(&bebob->capture_substreams);
+
+	snd_bebob_stream_stop_duplex(bebob);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+static int
+pcm_playback_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_bebob *bebob = substream->private_data;
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		atomic_dec(&bebob->playback_substreams);
+
+	snd_bebob_stream_stop_duplex(bebob);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int
+pcm_capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_bebob *bebob = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	err = snd_bebob_stream_start_duplex(bebob, runtime->rate);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&bebob->tx_stream);
+
+	return err;
+}
+static int
+pcm_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_bebob *bebob = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	err = snd_bebob_stream_start_duplex(bebob, runtime->rate);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&bebob->rx_stream);
+
+	return err;
+}
+
+static int
+pcm_capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_bebob *bebob = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&bebob->tx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&bebob->tx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+static int
+pcm_playback_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_bebob *bebob = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&bebob->rx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&bebob->rx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t
+pcm_capture_pointer(struct snd_pcm_substream *sbstrm)
+{
+	struct snd_bebob *bebob = sbstrm->private_data;
+	return amdtp_stream_pcm_pointer(&bebob->tx_stream);
+}
+static snd_pcm_uframes_t
+pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
+{
+	struct snd_bebob *bebob = sbstrm->private_data;
+	return amdtp_stream_pcm_pointer(&bebob->rx_stream);
+}
+
+static const struct snd_pcm_ops pcm_capture_ops = {
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
+static const struct snd_pcm_ops pcm_playback_ops = {
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
+int snd_bebob_create_pcm_devices(struct snd_bebob *bebob)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(bebob->card, bebob->card->driver, 0, 1, 1, &pcm);
+	if (err < 0)
+		goto end;
+
+	pcm->private_data = bebob;
+	snprintf(pcm->name, sizeof(pcm->name),
+		 "%s PCM", bebob->card->shortname);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &pcm_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pcm_capture_ops);
+end:
+	return err;
+}
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
