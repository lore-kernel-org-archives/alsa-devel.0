From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/13] ALSA: fireface: add stream management
	functionality
Date: Sat, 11 Feb 2017 23:25:06 +0900
Message-ID: <20170211142509.4795-11-o-takashi@sakamocchi.jp>
References: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 1DC76266C6E
 for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2017 15:25:17 +0100 (CET)
In-Reply-To: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
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

As long as investigating Fireface 400, there're three modes depending
on sampling transmission frequency. The number of data channels in each
data block is different depending on the mode. The set of available
data channels for each mode might be different for each protocol and
model.

The length of registers for the number of isochronous channel is just
three bits, therefore 0-7ch are available.

When bus reset occurs on IEEE 1394 bus, the device discontinues to
transmit packets. This commit aborts PCM substreams at bus reset handler.

This commit adds management functionality for the above pacekt streaming.

The device manages its sampling clock independently of sampling
transmission frequency against IEC 61883-6. Thus, it's a lower cost to
change the sampling transmission frequency, while data fetch between
streaming layer and DSP require larger buffer for resampling. As a result,
device latency might tend to be larger than ASICs for IEC 61883-1/6 such
as DM1000/DM1100/DM1500 (BeBoB), DiceII/TCD2210/TCD2220/TCD3070 and
OXFW970/971.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile    |   3 +-
 sound/firewire/fireface/ff-stream.c | 243 ++++++++++++++++++++++++++++++++++++
 sound/firewire/fireface/ff.c        |   9 ++
 sound/firewire/fireface/ff.h        |  13 ++
 4 files changed, 267 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireface/ff-stream.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index e06e9da..b772fdc 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,2 +1,3 @@
-snd-fireface-objs := ff.o ff-transaction.o ff-midi.o ff-proc.o amdtp-ff.o
+snd-fireface-objs := ff.o ff-transaction.o ff-midi.o ff-proc.o amdtp-ff.o \
+		     ff-stream.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
new file mode 100644
index 0000000..0ef6177
--- /dev/null
+++ b/sound/firewire/fireface/ff-stream.c
@@ -0,0 +1,243 @@
+/*
+ * ff-stream.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "ff.h"
+
+#define CALLBACK_TIMEOUT_MS	200
+
+static int get_rate_mode(unsigned int rate, unsigned int *mode)
+{
+	int i;
+
+	for (i = 0; i < CIP_SFC_COUNT; i++) {
+		if (amdtp_rate_table[i] == rate)
+			break;
+	}
+
+	if (i == CIP_SFC_COUNT)
+		return -EINVAL;
+
+	*mode = ((int)i - 1) / 2;
+
+	return 0;
+}
+
+/*
+ * Fireface 400 manages isochronous channel number in 3 bit field. Therefore,
+ * we can allocate between 0 and 7 channel.
+ */
+static int keep_resources(struct snd_ff *ff, unsigned int rate)
+{
+	int mode;
+	int err;
+
+	err = get_rate_mode(rate, &mode);
+	if (err < 0)
+		return err;
+
+	/* Keep resources for in-stream. */
+	err = amdtp_ff_set_parameters(&ff->tx_stream, rate,
+				      ff->spec->pcm_capture_channels[mode]);
+	if (err < 0)
+		return err;
+	ff->tx_resources.channels_mask = 0x00000000000000ffuLL;
+	err = fw_iso_resources_allocate(&ff->tx_resources,
+			amdtp_stream_get_max_payload(&ff->tx_stream),
+			fw_parent_device(ff->unit)->max_speed);
+	if (err < 0)
+		return err;
+
+	/* Keep resources for out-stream. */
+	err = amdtp_ff_set_parameters(&ff->rx_stream, rate,
+				      ff->spec->pcm_playback_channels[mode]);
+	if (err < 0)
+		return err;
+	ff->rx_resources.channels_mask = 0x00000000000000ffuLL;
+	err = fw_iso_resources_allocate(&ff->rx_resources,
+			amdtp_stream_get_max_payload(&ff->rx_stream),
+			fw_parent_device(ff->unit)->max_speed);
+	if (err < 0)
+		fw_iso_resources_free(&ff->tx_resources);
+
+	return err;
+}
+
+static void release_resources(struct snd_ff *ff)
+{
+	fw_iso_resources_free(&ff->tx_resources);
+	fw_iso_resources_free(&ff->rx_resources);
+}
+
+static inline void finish_session(struct snd_ff *ff)
+{
+	ff->spec->protocol->finish_session(ff);
+	ff->spec->protocol->switch_fetching_mode(ff, false);
+}
+
+static int init_stream(struct snd_ff *ff, enum amdtp_stream_direction dir)
+{
+	int err;
+	struct fw_iso_resources *resources;
+	struct amdtp_stream *stream;
+
+	if (dir == AMDTP_IN_STREAM) {
+		resources = &ff->tx_resources;
+		stream = &ff->tx_stream;
+	} else {
+		resources = &ff->rx_resources;
+		stream = &ff->rx_stream;
+	}
+
+	err = fw_iso_resources_init(resources, ff->unit);
+	if (err < 0)
+		return err;
+
+	err = amdtp_ff_init(stream, ff->unit, dir);
+	if (err < 0)
+		fw_iso_resources_destroy(resources);
+
+	return err;
+}
+
+static void destroy_stream(struct snd_ff *ff, enum amdtp_stream_direction dir)
+{
+	if (dir == AMDTP_IN_STREAM) {
+		amdtp_stream_destroy(&ff->tx_stream);
+		fw_iso_resources_destroy(&ff->tx_resources);
+	} else {
+		amdtp_stream_destroy(&ff->rx_stream);
+		fw_iso_resources_destroy(&ff->rx_resources);
+	}
+}
+
+int snd_ff_stream_init_duplex(struct snd_ff *ff)
+{
+	int err;
+
+	err = init_stream(ff, AMDTP_OUT_STREAM);
+	if (err < 0)
+		goto end;
+
+	err = init_stream(ff, AMDTP_IN_STREAM);
+	if (err < 0)
+		destroy_stream(ff, AMDTP_OUT_STREAM);
+end:
+	return err;
+}
+
+/*
+ * This function should be called before starting streams or after stopping
+ * streams.
+ */
+void snd_ff_stream_destroy_duplex(struct snd_ff *ff)
+{
+	destroy_stream(ff, AMDTP_IN_STREAM);
+	destroy_stream(ff, AMDTP_OUT_STREAM);
+}
+
+int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
+{
+	unsigned int curr_rate;
+	enum snd_ff_clock_src src;
+	int err;
+
+	if (ff->substreams_counter == 0)
+		return 0;
+
+	err = ff->spec->protocol->get_clock(ff, &curr_rate, &src);
+	if (err < 0)
+		return err;
+	if (curr_rate != rate ||
+	    amdtp_streaming_error(&ff->tx_stream) ||
+	    amdtp_streaming_error(&ff->rx_stream)) {
+		finish_session(ff);
+
+		amdtp_stream_stop(&ff->tx_stream);
+		amdtp_stream_stop(&ff->rx_stream);
+
+		release_resources(ff);
+	}
+
+	/*
+	 * Regardless of current source of clock signal, drivers transfer some
+	 * packets. Then, the device transfers packets.
+	 */
+	if (!amdtp_stream_running(&ff->rx_stream)) {
+		err = keep_resources(ff, rate);
+		if (err < 0)
+			goto error;
+
+		err = ff->spec->protocol->begin_session(ff, rate);
+		if (err < 0)
+			goto error;
+
+		err = amdtp_stream_start(&ff->rx_stream,
+					 ff->rx_resources.channel,
+					 fw_parent_device(ff->unit)->max_speed);
+		if (err < 0)
+			goto error;
+
+		if (!amdtp_stream_wait_callback(&ff->rx_stream,
+						CALLBACK_TIMEOUT_MS)) {
+			err = -ETIMEDOUT;
+			goto error;
+		}
+
+		err = ff->spec->protocol->switch_fetching_mode(ff, true);
+		if (err < 0)
+			goto error;
+	}
+
+	if (!amdtp_stream_running(&ff->tx_stream)) {
+		err = amdtp_stream_start(&ff->tx_stream,
+					 ff->tx_resources.channel,
+					 fw_parent_device(ff->unit)->max_speed);
+		if (err < 0)
+			goto error;
+
+		if (!amdtp_stream_wait_callback(&ff->tx_stream,
+						CALLBACK_TIMEOUT_MS)) {
+			err = -ETIMEDOUT;
+			goto error;
+		}
+	}
+
+	return 0;
+error:
+	amdtp_stream_stop(&ff->tx_stream);
+	amdtp_stream_stop(&ff->rx_stream);
+
+	finish_session(ff);
+	release_resources(ff);
+
+	return err;
+}
+
+void snd_ff_stream_stop_duplex(struct snd_ff *ff)
+{
+	if (ff->substreams_counter > 0)
+		return;
+
+	amdtp_stream_stop(&ff->tx_stream);
+	amdtp_stream_stop(&ff->rx_stream);
+	finish_session(ff);
+	release_resources(ff);
+}
+
+void snd_ff_stream_update_duplex(struct snd_ff *ff)
+{
+	/* The device discontinue to transfer packets.  */
+	amdtp_stream_pcm_abort(&ff->tx_stream);
+	amdtp_stream_stop(&ff->tx_stream);
+
+	amdtp_stream_pcm_abort(&ff->rx_stream);
+	amdtp_stream_stop(&ff->rx_stream);
+
+	fw_iso_resources_update(&ff->tx_resources);
+	fw_iso_resources_update(&ff->rx_resources);
+}
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 22e7bcb..6bdbebd 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -29,6 +29,7 @@ static void name_card(struct snd_ff *ff)
 
 static void ff_free(struct snd_ff *ff)
 {
+	snd_ff_stream_destroy_duplex(ff);
 	snd_ff_transaction_unregister(ff);
 
 	fw_unit_put(ff->unit);
@@ -61,6 +62,10 @@ static void do_registration(struct work_struct *work)
 
 	name_card(ff);
 
+	err = snd_ff_stream_init_duplex(ff);
+	if (err < 0)
+		goto error;
+
 	snd_ff_proc_init(ff);
 
 	err = snd_ff_create_midi_devices(ff);
@@ -78,6 +83,7 @@ static void do_registration(struct work_struct *work)
 	return;
 error:
 	snd_ff_transaction_unregister(ff);
+	snd_ff_stream_destroy_duplex(ff);
 	snd_card_free(ff->card);
 	dev_info(&ff->unit->device,
 		 "Sound card registration failed: %d\n", err);
@@ -117,6 +123,9 @@ static void snd_ff_update(struct fw_unit *unit)
 		snd_fw_schedule_registration(unit, &ff->dwork);
 
 	snd_ff_transaction_reregister(ff);
+
+	if (ff->registered)
+		snd_ff_stream_update_duplex(ff);
 }
 
 static void snd_ff_remove(struct fw_unit *unit)
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index fa7242f..6599c11 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -24,6 +24,7 @@
 
 #include "../lib.h"
 #include "../amdtp-stream.h"
+#include "../iso-resources.h"
 
 #define SND_FF_STREAM_MODES		3
 
@@ -68,6 +69,12 @@ struct snd_ff {
 	ktime_t next_ktime[SND_FF_OUT_MIDI_PORTS];
 	bool rx_midi_error[SND_FF_OUT_MIDI_PORTS];
 	unsigned int rx_bytes[SND_FF_OUT_MIDI_PORTS];
+
+	unsigned int substreams_counter;
+	struct amdtp_stream tx_stream;
+	struct amdtp_stream rx_stream;
+	struct fw_iso_resources tx_resources;
+	struct fw_iso_resources rx_resources;
 };
 
 enum snd_ff_clock_src {
@@ -107,6 +114,12 @@ int amdtp_ff_add_pcm_hw_constraints(struct amdtp_stream *s,
 int amdtp_ff_init(struct amdtp_stream *s, struct fw_unit *unit,
 		  enum amdtp_stream_direction dir);
 
+int snd_ff_stream_init_duplex(struct snd_ff *ff);
+void snd_ff_stream_destroy_duplex(struct snd_ff *ff);
+int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate);
+void snd_ff_stream_stop_duplex(struct snd_ff *ff);
+void snd_ff_stream_update_duplex(struct snd_ff *ff);
+
 void snd_ff_proc_init(struct snd_ff *ff);
 
 int snd_ff_create_midi_devices(struct snd_ff *ff);
-- 
2.9.3
