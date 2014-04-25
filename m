From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 21/49] fireworks: Add connection and stream management
Date: Fri, 25 Apr 2014 22:45:02 +0900
Message-ID: <1398433530-13136-22-git-send-email-o-takashi@sakamocchi.jp>
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

Fireworks manages connections by CMP and can transmit/receive AMDTP streams
with a few quirks. This commit adds functionality to start/stop the streams.

Major Fireworks products don't support 'SYT-Match' clock source mode, except
for AudioFire12/8(till 2009 July) with firmware version 1.0. Already in
previous commit, this driver don't support such old firmwares. So this commit
adds support for non 'SYT-Match' clock source modes.

I note that this driver has a short gap for MIDI streams when starting PCM
stream. When AMDTP streams are running only for MIDI data and PCM data is
going to be joined at different sampling rate, then AMDTP streams are
stopped once and started again after changing sampling rate.

Unfortunately, Fireworks is not fully compliant to IEC 61883-1/6. Some commits
following to this commit add these quirks.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/Makefile           |   3 +-
 sound/firewire/fireworks/fireworks.c        |  64 ++++-
 sound/firewire/fireworks/fireworks.h        |  27 +++
 sound/firewire/fireworks/fireworks_stream.c | 349 ++++++++++++++++++++++++++++
 4 files changed, 441 insertions(+), 2 deletions(-)
 create mode 100644 sound/firewire/fireworks/fireworks_stream.c

diff --git a/sound/firewire/fireworks/Makefile b/sound/firewire/fireworks/Makefile
index a6ce214..1bccb65 100644
--- a/sound/firewire/fireworks/Makefile
+++ b/sound/firewire/fireworks/Makefile
@@ -1,2 +1,3 @@
-snd-fireworks-objs := fireworks_transaction.o fireworks_command.o fireworks.o
+snd-fireworks-objs := fireworks_transaction.o fireworks_command.o \
+		      fireworks_stream.o fireworks.o
 obj-m += snd-fireworks.o
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 6fa3a5d..307fb2f 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -98,6 +98,57 @@ get_hardware_info(struct snd_efw *efw)
 
 	if (hwinfo->flags & BIT(FLAG_RESP_ADDR_CHANGABLE))
 		efw->resp_addr_changable = true;
+
+	efw->supported_sampling_rate = 0;
+	if ((hwinfo->min_sample_rate <= 22050)
+	 && (22050 <= hwinfo->max_sample_rate))
+		efw->supported_sampling_rate |= SNDRV_PCM_RATE_22050;
+	if ((hwinfo->min_sample_rate <= 32000)
+	 && (32000 <= hwinfo->max_sample_rate))
+		efw->supported_sampling_rate |= SNDRV_PCM_RATE_32000;
+	if ((hwinfo->min_sample_rate <= 44100)
+	 && (44100 <= hwinfo->max_sample_rate))
+		efw->supported_sampling_rate |= SNDRV_PCM_RATE_44100;
+	if ((hwinfo->min_sample_rate <= 48000)
+	 && (48000 <= hwinfo->max_sample_rate))
+		efw->supported_sampling_rate |= SNDRV_PCM_RATE_48000;
+	if ((hwinfo->min_sample_rate <= 88200)
+	 && (88200 <= hwinfo->max_sample_rate))
+		efw->supported_sampling_rate |= SNDRV_PCM_RATE_88200;
+	if ((hwinfo->min_sample_rate <= 96000)
+	 && (96000 <= hwinfo->max_sample_rate))
+		efw->supported_sampling_rate |= SNDRV_PCM_RATE_96000;
+	if ((hwinfo->min_sample_rate <= 176400)
+	 && (176400 <= hwinfo->max_sample_rate))
+		efw->supported_sampling_rate |= SNDRV_PCM_RATE_176400;
+	if ((hwinfo->min_sample_rate <= 192000)
+	 && (192000 <= hwinfo->max_sample_rate))
+		efw->supported_sampling_rate |= SNDRV_PCM_RATE_192000;
+
+	/* the number of MIDI ports, not of MIDI conformant data channels */
+	if (hwinfo->midi_out_ports > SND_EFW_MAX_MIDI_OUT_PORTS ||
+	    hwinfo->midi_in_ports > SND_EFW_MAX_MIDI_IN_PORTS) {
+		err = -EIO;
+		goto end;
+	}
+	efw->midi_out_ports = hwinfo->midi_out_ports;
+	efw->midi_in_ports = hwinfo->midi_in_ports;
+
+	if (hwinfo->amdtp_tx_pcm_channels    > AMDTP_MAX_CHANNELS_FOR_PCM ||
+	    hwinfo->amdtp_tx_pcm_channels_2x > AMDTP_MAX_CHANNELS_FOR_PCM ||
+	    hwinfo->amdtp_tx_pcm_channels_4x > AMDTP_MAX_CHANNELS_FOR_PCM ||
+	    hwinfo->amdtp_rx_pcm_channels    > AMDTP_MAX_CHANNELS_FOR_PCM ||
+	    hwinfo->amdtp_rx_pcm_channels_2x > AMDTP_MAX_CHANNELS_FOR_PCM ||
+	    hwinfo->amdtp_rx_pcm_channels_4x > AMDTP_MAX_CHANNELS_FOR_PCM) {
+		err = -ENOSYS;
+		goto end;
+	}
+	efw->pcm_capture_channels[0] = hwinfo->amdtp_tx_pcm_channels;
+	efw->pcm_capture_channels[1] = hwinfo->amdtp_tx_pcm_channels_2x;
+	efw->pcm_capture_channels[2] = hwinfo->amdtp_tx_pcm_channels_4x;
+	efw->pcm_playback_channels[0] = hwinfo->amdtp_rx_pcm_channels;
+	efw->pcm_playback_channels[1] = hwinfo->amdtp_rx_pcm_channels_2x;
+	efw->pcm_playback_channels[2] = hwinfo->amdtp_rx_pcm_channels_4x;
 end:
 	kfree(hwinfo);
 	return err;
@@ -155,10 +206,16 @@ efw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	err = snd_card_register(card);
+	err = snd_efw_stream_init_duplex(efw);
 	if (err < 0)
 		goto error;
 
+	err = snd_card_register(card);
+	if (err < 0) {
+		snd_efw_stream_destroy_duplex(efw);
+		goto error;
+	}
+
 	dev_set_drvdata(&unit->device, efw);
 end:
 	mutex_unlock(&devices_mutex);
@@ -172,12 +229,17 @@ error:
 static void efw_update(struct fw_unit *unit)
 {
 	struct snd_efw *efw = dev_get_drvdata(&unit->device);
+
 	snd_efw_transaction_bus_reset(efw->unit);
+	snd_efw_stream_update_duplex(efw);
 }
 
 static void efw_remove(struct fw_unit *unit)
 {
 	struct snd_efw *efw = dev_get_drvdata(&unit->device);
+
+	snd_efw_stream_destroy_duplex(efw);
+
 	snd_card_disconnect(efw->card);
 	snd_card_free_when_closed(efw->card);
 }
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index e999802..ce511be 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -22,9 +22,15 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 
+#include "../packets-buffer.h"
+#include "../iso-resources.h"
+#include "../amdtp.h"
 #include "../cmp.h"
 #include "../lib.h"
 
+#define SND_EFW_MAX_MIDI_OUT_PORTS	2
+#define SND_EFW_MAX_MIDI_IN_PORTS	2
+
 #define SND_EFW_MULTIPLIER_MODES	3
 #define HWINFO_NAME_SIZE_BYTES		32
 #define HWINFO_MAX_CAPS_GROUPS		8
@@ -54,6 +60,21 @@ struct snd_efw {
 	/* for transaction */
 	u32 seqnum;
 	bool resp_addr_changable;
+
+	unsigned int midi_in_ports;
+	unsigned int midi_out_ports;
+
+	unsigned int supported_sampling_rate;
+	unsigned int pcm_capture_channels[SND_EFW_MULTIPLIER_MODES];
+	unsigned int pcm_playback_channels[SND_EFW_MULTIPLIER_MODES];
+
+	struct amdtp_stream *master;
+	struct amdtp_stream tx_stream;
+	struct amdtp_stream rx_stream;
+	struct cmp_connection out_conn;
+	struct cmp_connection in_conn;
+	atomic_t capture_substreams;
+	atomic_t playback_substreams;
 };
 
 struct snd_efw_transaction {
@@ -156,6 +177,12 @@ int snd_efw_command_get_clock_source(struct snd_efw *efw,
 int snd_efw_command_get_sampling_rate(struct snd_efw *efw, unsigned int *rate);
 int snd_efw_command_set_sampling_rate(struct snd_efw *efw, unsigned int rate);
 
+int snd_efw_stream_init_duplex(struct snd_efw *efw);
+int snd_efw_stream_start_duplex(struct snd_efw *efw, int sampling_rate);
+void snd_efw_stream_stop_duplex(struct snd_efw *efw);
+void snd_efw_stream_update_duplex(struct snd_efw *efw);
+void snd_efw_stream_destroy_duplex(struct snd_efw *efw);
+
 #define SND_EFW_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
new file mode 100644
index 0000000..ec62aa6
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -0,0 +1,349 @@
+/*
+ * fireworks_stream.c - a part of driver for Fireworks based devices
+ *
+ * Copyright (c) 2013-2014 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+#include "./fireworks.h"
+
+#define CALLBACK_TIMEOUT	100
+
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
+static inline unsigned int
+get_multiplier_mode_with_index(unsigned int index)
+{
+	return ((int)index - 1) / 2;
+}
+
+int snd_efw_get_multiplier_mode(unsigned int sampling_rate, unsigned int *mode)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(freq_table); i++) {
+		if (freq_table[i] == sampling_rate) {
+			*mode = get_multiplier_mode_with_index(i);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int
+init_stream(struct snd_efw *efw, struct amdtp_stream *stream)
+{
+	struct cmp_connection *conn;
+	enum cmp_direction c_dir;
+	enum amdtp_stream_direction s_dir;
+	int err;
+
+	if (stream == &efw->tx_stream) {
+		conn = &efw->out_conn;
+		c_dir = CMP_OUTPUT;
+		s_dir = AMDTP_IN_STREAM;
+	} else {
+		conn = &efw->in_conn;
+		c_dir = CMP_INPUT;
+		s_dir = AMDTP_OUT_STREAM;
+	}
+
+	err = cmp_connection_init(conn, efw->unit, c_dir, 0);
+	if (err < 0)
+		goto end;
+
+	err = amdtp_stream_init(stream, efw->unit, s_dir, CIP_BLOCKING);
+	if (err < 0) {
+		amdtp_stream_destroy(stream);
+		cmp_connection_destroy(conn);
+	}
+end:
+	return err;
+}
+
+static void
+stop_stream(struct snd_efw *efw, struct amdtp_stream *stream)
+{
+	amdtp_stream_pcm_abort(stream);
+	amdtp_stream_stop(stream);
+
+	if (stream == &efw->tx_stream)
+		cmp_connection_break(&efw->out_conn);
+	else
+		cmp_connection_break(&efw->in_conn);
+}
+
+static int
+start_stream(struct snd_efw *efw, struct amdtp_stream *stream,
+	     unsigned int sampling_rate)
+{
+	struct cmp_connection *conn;
+	unsigned int mode, pcm_channels, midi_ports;
+	int err;
+
+	err = snd_efw_get_multiplier_mode(sampling_rate, &mode);
+	if (err < 0)
+		goto end;
+	if (stream == &efw->tx_stream) {
+		conn = &efw->out_conn;
+		pcm_channels = efw->pcm_capture_channels[mode];
+		midi_ports = efw->midi_out_ports;
+	} else {
+		conn = &efw->in_conn;
+		pcm_channels = efw->pcm_playback_channels[mode];
+		midi_ports = efw->midi_in_ports;
+	}
+
+	amdtp_stream_set_parameters(stream, sampling_rate,
+				    pcm_channels, midi_ports);
+
+	/*  establish connection via CMP */
+	err = cmp_connection_establish(conn,
+				amdtp_stream_get_max_payload(stream));
+	if (err < 0)
+		goto end;
+
+	/* start amdtp stream */
+	err = amdtp_stream_start(stream,
+				 conn->resources.channel,
+				 conn->speed);
+	if (err < 0) {
+		stop_stream(efw, stream);
+		goto end;
+	}
+
+	/* wait first callback */
+	if (!amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT)) {
+		stop_stream(efw, stream);
+		err = -ETIMEDOUT;
+	}
+end:
+	return err;
+}
+
+static void
+destroy_stream(struct snd_efw *efw, struct amdtp_stream *stream)
+{
+	stop_stream(efw, stream);
+
+	amdtp_stream_destroy(stream);
+
+	if (stream == &efw->tx_stream)
+		cmp_connection_destroy(&efw->out_conn);
+	else
+		cmp_connection_destroy(&efw->in_conn);
+}
+
+static int
+get_sync_mode(struct snd_efw *efw, enum cip_flags *sync_mode)
+{
+	enum snd_efw_clock_source clock_source;
+	int err;
+
+	err = snd_efw_command_get_clock_source(efw, &clock_source);
+	if (err < 0)
+		return err;
+
+	if (clock_source == SND_EFW_CLOCK_SOURCE_SYTMATCH)
+		return -ENOSYS;
+
+	*sync_mode = CIP_SYNC_TO_DEVICE;
+	return 0;
+}
+
+static int
+check_connection_used_by_others(struct snd_efw *efw, struct amdtp_stream *s)
+{
+	struct cmp_connection *conn;
+	bool used;
+	int err;
+
+	if (s == &efw->tx_stream)
+		conn = &efw->out_conn;
+	else
+		conn = &efw->in_conn;
+
+	err = cmp_connection_check_used(conn, &used);
+	if ((err >= 0) && used && !amdtp_stream_running(s)) {
+		dev_err(&efw->unit->device,
+			"Connection established by others: %cPCR[%d]\n",
+			(conn->direction == CMP_OUTPUT) ? 'o' : 'i',
+			conn->pcr_index);
+		err = -EBUSY;
+	}
+
+	return err;
+}
+
+int snd_efw_stream_init_duplex(struct snd_efw *efw)
+{
+	int err;
+
+	err = init_stream(efw, &efw->tx_stream);
+	if (err < 0)
+		goto end;
+
+	err = init_stream(efw, &efw->rx_stream);
+	if (err < 0) {
+		destroy_stream(efw, &efw->tx_stream);
+		goto end;
+	}
+
+	/* set IEC61883 compliant mode (actually not fully compliant...) */
+	err = snd_efw_command_set_tx_mode(efw, SND_EFW_TRANSPORT_MODE_IEC61883);
+	if (err < 0) {
+		destroy_stream(efw, &efw->tx_stream);
+		destroy_stream(efw, &efw->rx_stream);
+	}
+end:
+	return err;
+}
+
+int snd_efw_stream_start_duplex(struct snd_efw *efw, int rate)
+{
+	struct amdtp_stream *master, *slave;
+	atomic_t *slave_substreams;
+	enum cip_flags sync_mode;
+	unsigned int curr_rate;
+	int err = 0;
+
+	mutex_lock(&efw->mutex);
+
+	/* Need no substreams */
+	if ((atomic_read(&efw->playback_substreams) == 0) &&
+	    (atomic_read(&efw->capture_substreams)  == 0))
+		goto end;
+
+	err = get_sync_mode(efw, &sync_mode);
+	if (err < 0)
+		goto end;
+	if (sync_mode == CIP_SYNC_TO_DEVICE) {
+		master = &efw->tx_stream;
+		slave  = &efw->rx_stream;
+		slave_substreams  = &efw->playback_substreams;
+	} else {
+		master = &efw->rx_stream;
+		slave  = &efw->tx_stream;
+		slave_substreams = &efw->capture_substreams;
+	}
+
+	/*
+	 * Considering JACK/FFADO streaming:
+	 * TODO: This can be removed hwdep functionality becomes popular.
+	 */
+	err = check_connection_used_by_others(efw, master);
+	if (err < 0)
+		goto end;
+
+	/* packet queueing error */
+	if (amdtp_streaming_error(slave))
+		stop_stream(efw, slave);
+	if (amdtp_streaming_error(master))
+		stop_stream(efw, master);
+
+	/* stop streams if rate is different */
+	err = snd_efw_command_get_sampling_rate(efw, &curr_rate);
+	if (err < 0)
+		goto end;
+	if (rate == 0)
+		rate = curr_rate;
+	if (rate != curr_rate) {
+		stop_stream(efw, slave);
+		stop_stream(efw, master);
+	}
+
+	/* master should be always running */
+	if (!amdtp_stream_running(master)) {
+		amdtp_stream_set_sync(sync_mode, master, slave);
+		efw->master = master;
+
+		err = snd_efw_command_set_sampling_rate(efw, rate);
+		if (err < 0)
+			goto end;
+
+		err = start_stream(efw, master, rate);
+		if (err < 0) {
+			dev_err(&efw->unit->device,
+				"fail to start AMDTP master stream:%d\n", err);
+			goto end;
+		}
+	}
+
+	/* start slave if needed */
+	if (atomic_read(slave_substreams) > 0 && !amdtp_stream_running(slave)) {
+		err = start_stream(efw, slave, rate);
+		if (err < 0) {
+			dev_err(&efw->unit->device,
+				"fail to start AMDTP slave stream:%d\n", err);
+			stop_stream(efw, master);
+		}
+	}
+end:
+	mutex_unlock(&efw->mutex);
+	return err;
+}
+
+void snd_efw_stream_stop_duplex(struct snd_efw *efw)
+{
+	struct amdtp_stream *master, *slave;
+	atomic_t *master_substreams, *slave_substreams;
+
+	mutex_lock(&efw->mutex);
+
+	if (efw->master == &efw->rx_stream) {
+		slave  = &efw->tx_stream;
+		master = &efw->rx_stream;
+		slave_substreams  = &efw->capture_substreams;
+		master_substreams = &efw->playback_substreams;
+	} else {
+		slave  = &efw->rx_stream;
+		master = &efw->tx_stream;
+		slave_substreams  = &efw->playback_substreams;
+		master_substreams = &efw->capture_substreams;
+	}
+
+	if (atomic_read(slave_substreams) == 0) {
+		stop_stream(efw, slave);
+
+		if (atomic_read(master_substreams) == 0)
+			stop_stream(efw, master);
+	}
+
+	mutex_unlock(&efw->mutex);
+}
+
+void snd_efw_stream_update_duplex(struct snd_efw *efw)
+{
+	if ((cmp_connection_update(&efw->out_conn) < 0) ||
+	    (cmp_connection_update(&efw->in_conn) < 0)) {
+		mutex_lock(&efw->mutex);
+		stop_stream(efw, &efw->rx_stream);
+		stop_stream(efw, &efw->tx_stream);
+		mutex_unlock(&efw->mutex);
+	} else {
+		amdtp_stream_update(&efw->rx_stream);
+		amdtp_stream_update(&efw->tx_stream);
+	}
+}
+
+void snd_efw_stream_destroy_duplex(struct snd_efw *efw)
+{
+	mutex_lock(&efw->mutex);
+
+	destroy_stream(efw, &efw->rx_stream);
+	destroy_stream(efw, &efw->tx_stream);
+
+	mutex_unlock(&efw->mutex);
+}
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
