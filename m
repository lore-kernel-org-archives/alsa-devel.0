From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/11] ALSA: digi00x: add PCM functionality
Date: Mon, 30 Mar 2015 00:05:24 +0900
Message-ID: <1427641531-9047-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 87DD7260499
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 17:05:43 +0200 (CEST)
In-Reply-To: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

As long as seeing Digi 002, any PCM samples are transferred or received
in Multi Bit Linear Audio data channel as AM824 format data. Actually,
the label is always 0x40, thus 24 bit sample is just supported.

But Windows driver transmit 16 bit samples in 0x40 label channel. This is
out of IEC 61883-6. Furthermore, these channels includes some multiplexed
bit pattern.

This commit adds PCM functionality to transmit/receive PCM samples with
current ALSA AMDTP engine, thus PCM playback substream causes noisy sound.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/Makefile      |   2 +-
 sound/firewire/digi00x/digi00x-pcm.c | 330 +++++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c     |   4 +
 sound/firewire/digi00x/digi00x.h     |   4 +
 4 files changed, 339 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/digi00x/digi00x-pcm.c

diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index aaec823..f2ed472 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,2 +1,2 @@
-snd-digi00x-objs := digi00x.o digi00x-stream.o digi00x-proc.o
+snd-digi00x-objs := digi00x.o digi00x-stream.o digi00x-proc.o digi00x-pcm.o
 obj-m += snd-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-pcm.c b/sound/firewire/digi00x/digi00x-pcm.c
new file mode 100644
index 0000000..33db601
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-pcm.c
@@ -0,0 +1,330 @@
+/*
+ * digi00x-pcm.c - a part of driver for Digidesign Digi 002/003 family
+ *
+ * Copyright (c) 2014-2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "digi00x.h"
+
+static int hw_rule_rate(struct snd_pcm_hw_params *params,
+			struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *r =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	const struct snd_interval *c =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1,
+	};
+	unsigned int i;
+
+	for (i = 0; i < SND_DG00X_RATE_COUNT; i++) {
+		if (!snd_interval_test(c,
+				       snd_dg00x_stream_mbla_data_channels[i]))
+			continue;
+
+		t.min = min(t.min, snd_dg00x_stream_rates[i]);
+		t.max = max(t.max, snd_dg00x_stream_rates[i]);
+	}
+
+	return snd_interval_refine(r, &t);
+}
+
+static int hw_rule_channels(struct snd_pcm_hw_params *params,
+			    struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *c =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	const struct snd_interval *r =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval t = {
+		.min = UINT_MAX, .max = 0, .integer = 1,
+	};
+	unsigned int i;
+
+	for (i = 0; i < SND_DG00X_RATE_COUNT; i++) {
+		if (!snd_interval_test(r, snd_dg00x_stream_rates[i]))
+			continue;
+
+		t.min = min(t.min, snd_dg00x_stream_mbla_data_channels[i]);
+		t.max = max(t.max, snd_dg00x_stream_mbla_data_channels[i]);
+	}
+
+	return snd_interval_refine(c, &t);
+}
+
+static int pcm_init_hw_params(struct snd_dg00x *dg00x,
+			      struct snd_pcm_substream *substream)
+{
+	static const struct snd_pcm_hardware hardware = {
+		.info = SNDRV_PCM_INFO_BATCH |
+			SNDRV_PCM_INFO_BLOCK_TRANSFER |
+			SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_JOINT_DUPLEX |
+			SNDRV_PCM_INFO_MMAP |
+			SNDRV_PCM_INFO_MMAP_VALID,
+		.rates = SNDRV_PCM_RATE_44100 |
+			 SNDRV_PCM_RATE_48000 |
+			 SNDRV_PCM_RATE_88200 |
+			 SNDRV_PCM_RATE_96000,
+		.rate_min = 44100,
+		.rate_max = 96000,
+		.channels_min = 10,
+		.channels_max = 18,
+		.period_bytes_min = 4 * 18,
+		.period_bytes_max = 4 * 18 * 2048,
+		.buffer_bytes_max = 4 * 18 * 2048 * 2,
+		.periods_min = 2,
+		.periods_max = UINT_MAX,
+	};
+	struct amdtp_stream *s;
+	int err;
+
+	substream->runtime->hw = hardware;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		substream->runtime->hw.formats = AMDTP_IN_PCM_FORMAT_BITS;
+		s = &dg00x->tx_stream;
+	} else {
+		substream->runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		s = &dg00x->rx_stream;
+	}
+
+	err = snd_pcm_hw_rule_add(substream->runtime, 0,
+				  SNDRV_PCM_HW_PARAM_CHANNELS,
+				  hw_rule_channels, NULL,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		goto end;
+
+	err = snd_pcm_hw_rule_add(substream->runtime, 0,
+				  SNDRV_PCM_HW_PARAM_RATE,
+				  hw_rule_rate, NULL,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (err < 0)
+		goto end;
+
+	err = amdtp_stream_add_pcm_hw_constraints(s, substream->runtime);
+end:
+	return err;
+}
+
+static int pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->private_data;
+	enum snd_dg00x_clock clock;
+	unsigned int rate;
+	int err;
+
+	err = pcm_init_hw_params(dg00x, substream);
+	if (err < 0)
+		return err;
+
+	err = snd_dg00x_stream_get_clock(dg00x, &clock);
+	if ((clock != SND_DG00X_CLOCK_INTERNAL) |
+	    amdtp_stream_pcm_running(&dg00x->rx_stream) |
+	    amdtp_stream_pcm_running(&dg00x->tx_stream)) {
+		err = snd_dg00x_stream_get_rate(dg00x, &rate);
+		if (err < 0)
+			return err;
+		substream->runtime->hw.rate_min = rate;
+		substream->runtime->hw.rate_max = rate;
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
+	struct snd_dg00x *dg00x = substream->private_data;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&dg00x->mutex);
+		dg00x->capture_substreams++;
+		mutex_unlock(&dg00x->mutex);
+	}
+	amdtp_stream_set_pcm_format(&dg00x->tx_stream,
+				    params_format(hw_params));
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
+static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_dg00x *dg00x = substream->private_data;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&dg00x->mutex);
+		dg00x->playback_substreams++;
+		mutex_unlock(&dg00x->mutex);
+	}
+	amdtp_stream_set_pcm_format(&dg00x->rx_stream,
+				    params_format(hw_params));
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
+
+static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->private_data;
+
+	mutex_lock(&dg00x->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		dg00x->capture_substreams--;
+
+	snd_dg00x_stream_stop_duplex(dg00x);
+
+	mutex_unlock(&dg00x->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->private_data;
+
+	mutex_lock(&dg00x->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		dg00x->playback_substreams--;
+
+	snd_dg00x_stream_stop_duplex(dg00x);
+
+	mutex_unlock(&dg00x->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int pcm_capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	mutex_lock(&dg00x->mutex);
+
+	err = snd_dg00x_stream_start_duplex(dg00x, runtime->rate);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&dg00x->tx_stream);
+
+	mutex_unlock(&dg00x->mutex);
+
+	return err;
+}
+static int pcm_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	mutex_lock(&dg00x->mutex);
+
+	err = snd_dg00x_stream_start_duplex(dg00x, runtime->rate);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&dg00x->rx_stream);
+
+	mutex_unlock(&dg00x->mutex);
+
+	return err;
+}
+
+static int pcm_capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_dg00x *dg00x = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&dg00x->tx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&dg00x->tx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+static int pcm_playback_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_dg00x *dg00x = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&dg00x->rx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&dg00x->rx_stream, NULL);
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
+	struct snd_dg00x *dg00x = sbstrm->private_data;
+
+	return amdtp_stream_pcm_pointer(&dg00x->tx_stream);
+}
+static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
+{
+	struct snd_dg00x *dg00x = sbstrm->private_data;
+
+	return amdtp_stream_pcm_pointer(&dg00x->rx_stream);
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
+int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(dg00x->card, dg00x->card->driver, 0, 1, 1, &pcm);
+	if (err < 0)
+		return err;
+
+	pcm->private_data = dg00x;
+	snprintf(pcm->name, sizeof(pcm->name),
+		 "%s PCM", dg00x->card->shortname);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &pcm_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pcm_capture_ops);
+
+	return 0;
+}
+
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index d9c9e14..493437a 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -86,6 +86,10 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 
 	snd_dg00x_proc_init(dg00x);
 
+	err = snd_dg00x_create_pcm_devices(dg00x);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index a16a535..318b1b5 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -21,6 +21,8 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 
 #include "../lib.h"
 #include "../packets-buffer.h"
@@ -107,4 +109,6 @@ void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x);
 
 void snd_dg00x_proc_init(struct snd_dg00x *dg00x);
+
+int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x);
 #endif
-- 
2.1.0
