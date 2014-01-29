From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 50/52] oxfw: Add support for capture/playback
	MIDI messages
Date: Wed, 29 Jan 2014 23:49:35 +0900
Message-ID: <1391006977-11572-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E3BC2617AA
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2014 15:49:44 +0100 (CET)
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

I assume that 'if the device has MIDI comformant data channels in its
stream formation, the device has one MIDI port'. With this assumption,
this driver create MIDI devices.

When no streams have already started, MIDI functionality starts stream
with current sampling rate.

When MIDI functionality has already starts some streams and PCM
functionality is going to start streams at different sampling rate,
this driver stops streams once and changes sampling rate, then restarts
streams.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig            |   1 +
 sound/firewire/oxfw/Makefile      |   2 +-
 sound/firewire/oxfw/oxfw.c        |   7 ++
 sound/firewire/oxfw/oxfw.h        |   9 +++
 sound/firewire/oxfw/oxfw_midi.c   | 160 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw_stream.c |  57 ++++++++++++--
 6 files changed, 227 insertions(+), 9 deletions(-)
 create mode 100644 sound/firewire/oxfw/oxfw_midi.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index ff9448a..c0e1701 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -30,6 +30,7 @@ config SND_OXFW
 	tristate "Oxford OXFW970/971 chipset support"
 	select SND_PCM
 	select SND_FIREWIRE_LIB
+	select SND_RAWMIDI
 	help
 	  Say Y here to include support for Firewire devices based on
 	  Oxford Semiconductor OXFW970/971 chipset.
diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 4ee2c97..5f65270 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,3 +1,3 @@
 snd-oxfw-objs := oxfw_command.o oxfw_stream.o oxfw_control.o oxfw_proc.o \
-		 oxfw_pcm.o oxfw.o
+		 oxfw_midi.o oxfw_pcm.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index fad85f0..d094ba4 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -110,6 +110,7 @@ static int oxfw_probe(struct fw_unit *unit,
 	oxfw->unit = unit;
 	oxfw->device_info = (const struct device_info *)id->driver_data;
 	mutex_init(&oxfw->mutex);
+	spin_lock_init(&oxfw->lock);
 
 	if (oxfw->device_info == &griffin_firewave)
 		err = firewave_stream_discover(oxfw);
@@ -140,6 +141,12 @@ static int oxfw_probe(struct fw_unit *unit,
 
 	snd_oxfw_proc_init(oxfw);
 
+	if ((oxfw->midi_input_ports > 0) || (oxfw->midi_output_ports > 0)) {
+		err = snd_oxfw_create_midi(oxfw);
+		if (err < 0)
+			goto err_card;
+	}
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0)
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 3765f89..5f24bbb 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -19,6 +19,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -45,6 +46,7 @@ struct snd_oxfw {
 	struct fw_unit *unit;
 	const struct device_info *device_info;
 	struct mutex mutex;
+	spinlock_t lock;
 
 	struct snd_oxfw_stream_formation
 		tx_stream_formations[SND_OXFW_STREAM_TABLE_ENTRIES];
@@ -54,6 +56,11 @@ struct snd_oxfw {
 	struct cmp_connection in_conn;
 	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
+	unsigned int tx_midi_substreams;
+	unsigned int rx_midi_substreams;
+
+	unsigned int midi_input_ports;
+	unsigned int midi_output_ports;
 
 	bool mute;
 	s16 volume[6];
@@ -122,3 +129,5 @@ int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
 int snd_oxfw_create_mixer(struct snd_oxfw *oxfw);
 
 void snd_oxfw_proc_init(struct snd_oxfw *oxfw);
+
+int snd_oxfw_create_midi(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_midi.c b/sound/firewire/oxfw/oxfw_midi.c
new file mode 100644
index 0000000..0801c5e
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw_midi.c
@@ -0,0 +1,160 @@
+/*
+ * oxfw_midi.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "oxfw.h"
+
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+	int err = 0;
+
+	oxfw->tx_midi_substreams++;
+	if (!amdtp_stream_running(&oxfw->tx_stream))
+		err = snd_oxfw_stream_start(oxfw, &oxfw->tx_stream, 0);
+
+	return err;
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+	int err = 0;
+
+	oxfw->rx_midi_substreams++;
+	if (!amdtp_stream_running(&oxfw->rx_stream))
+		err = snd_oxfw_stream_start(oxfw, &oxfw->rx_stream, 0);
+
+	return err;
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+
+	if (--oxfw->tx_midi_substreams == 0)
+		snd_oxfw_stream_stop(oxfw, &oxfw->tx_stream);
+
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+
+	if (--oxfw->rx_midi_substreams == 0)
+		snd_oxfw_stream_stop(oxfw, &oxfw->rx_stream);
+
+	return 0;
+}
+
+static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_oxfw *oxfw = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&oxfw->lock, flags);
+
+	if (up)
+		amdtp_stream_midi_trigger(&oxfw->tx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&oxfw->tx_stream,
+					  substrm->number, NULL);
+
+	spin_unlock_irqrestore(&oxfw->lock, flags);
+
+	return;
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_oxfw *oxfw = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&oxfw->lock, flags);
+
+	if (up)
+		amdtp_stream_midi_trigger(&oxfw->rx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&oxfw->rx_stream,
+					  substrm->number, NULL);
+
+	spin_unlock_irqrestore(&oxfw->lock, flags);
+
+	return;
+}
+
+static struct snd_rawmidi_ops midi_capture_ops = {
+	.open		= midi_capture_open,
+	.close		= midi_capture_close,
+	.trigger	= midi_capture_trigger,
+};
+
+static struct snd_rawmidi_ops midi_playback_ops = {
+	.open		= midi_playback_open,
+	.close		= midi_playback_close,
+	.trigger	= midi_playback_trigger,
+};
+
+static void set_midi_substream_names(struct snd_oxfw *oxfw,
+				     struct snd_rawmidi_str *str)
+{
+	struct snd_rawmidi_substream *subs;
+
+	list_for_each_entry(subs, &str->substreams, list) {
+		snprintf(subs->name, sizeof(subs->name),
+			 "%s MIDI %d",
+			 oxfw->card->shortname, subs->number + 1);
+	}
+}
+
+int snd_oxfw_create_midi(struct snd_oxfw *oxfw)
+{
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_str *str;
+	int err;
+
+	/* create midi ports */
+	err = snd_rawmidi_new(oxfw->card, oxfw->card->driver, 0,
+			      oxfw->midi_output_ports, oxfw->midi_input_ports,
+			      &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+		 "%s MIDI", oxfw->card->shortname);
+	rmidi->private_data = oxfw;
+
+	if (oxfw->midi_input_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+					&midi_capture_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
+
+		set_midi_substream_names(oxfw, str);
+	}
+
+	if (oxfw->midi_output_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+					&midi_playback_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+
+		set_midi_substream_names(oxfw, str);
+	}
+
+	if ((oxfw->midi_output_ports > 0) && (oxfw->midi_input_ports > 0))
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	return 0;
+}
diff --git a/sound/firewire/oxfw/oxfw_stream.c b/sound/firewire/oxfw/oxfw_stream.c
index d4f019c..f3d2ca3 100644
--- a/sound/firewire/oxfw/oxfw_stream.c
+++ b/sound/firewire/oxfw/oxfw_stream.c
@@ -105,6 +105,17 @@ end:
 	return err;
 }
 
+static void stop_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
+{
+	if (amdtp_stream_running(stream))
+		amdtp_stream_stop(stream);
+
+	if (stream == &oxfw->tx_stream)
+		cmp_connection_break(&oxfw->out_conn);
+	else
+		cmp_connection_break(&oxfw->in_conn);
+}
+
 static int start_stream(struct snd_oxfw *oxfw,
 			struct amdtp_stream *stream, unsigned int rate)
 {
@@ -156,7 +167,7 @@ static int start_stream(struct snd_oxfw *oxfw,
 	/* Wait first callback */
 	err = amdtp_stream_wait_callback(stream, CALLBACK_TIMEOUT);
 	if (err < 0)
-		snd_oxfw_stream_stop(oxfw, stream);
+		stop_stream(oxfw, stream);
 end:
 	return err;
 }
@@ -204,12 +215,14 @@ int snd_oxfw_stream_start(struct snd_oxfw *oxfw,
 
 	/* packet queueing error */
 	if (amdtp_streaming_error(stream))
-		snd_oxfw_stream_stop(oxfw, stream);
+		stop_stream(oxfw, stream);
 
 	/* stop streams if rate is different */
 	err = snd_oxfw_stream_get_rate(oxfw, &curr_rate);
 	if (err < 0)
 		goto end;
+	if (rate == 0)
+		rate = curr_rate;
 	if (curr_rate != rate) {
 		/* get opposite stream */
 		if (stream == &oxfw->tx_stream)
@@ -217,13 +230,27 @@ int snd_oxfw_stream_start(struct snd_oxfw *oxfw,
 		else
 			opposite = &oxfw->tx_stream;
 
+		/* Stop streams safely */
 		err = check_connection_used_by_others(oxfw, opposite);
 		if (err < 0)
 			goto end;
+		if (!amdtp_stream_running(opposite))
+			opposite = NULL;
+		if (opposite)
+			stop_stream(oxfw, opposite);
+		if (amdtp_stream_running(stream))
+			stop_stream(oxfw, stream);
 
 		err = snd_oxfw_stream_set_rate(oxfw, rate);
 		if (err < 0)
 			goto end;
+
+		/* Start opposite stream as soon as possible */
+		if (opposite) {
+			err = start_stream(oxfw, opposite, rate);
+			if (err < 0)
+				goto end;
+		}
 	}
 
 	if (!amdtp_stream_running(stream))
@@ -235,13 +262,16 @@ end:
 
 void snd_oxfw_stream_stop(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 {
-	if (amdtp_stream_running(stream))
-		amdtp_stream_stop(stream);
+	unsigned int midi_substreams;
 
 	if (stream == &oxfw->tx_stream)
-		cmp_connection_break(&oxfw->out_conn);
+		midi_substreams = oxfw->tx_midi_substreams;
 	else
-		cmp_connection_break(&oxfw->in_conn);
+		midi_substreams = oxfw->rx_midi_substreams;
+
+	if (!amdtp_stream_pcm_running(stream) &&
+	    (midi_substreams == 0))
+		stop_stream(oxfw, stream);
 }
 
 void snd_oxfw_stream_destroy(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
@@ -249,7 +279,7 @@ void snd_oxfw_stream_destroy(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 	amdtp_stream_pcm_abort(stream);
 
 	mutex_lock(&oxfw->mutex);
-	snd_oxfw_stream_stop(oxfw, stream);
+	stop_stream(oxfw, stream);
 	if (stream == &oxfw->tx_stream)
 		cmp_connection_destroy(&oxfw->out_conn);
 	else
@@ -269,7 +299,7 @@ void snd_oxfw_stream_update(struct snd_oxfw *oxfw, struct amdtp_stream *stream)
 	if (cmp_connection_update(conn) < 0) {
 		amdtp_stream_pcm_abort(stream);
 		mutex_lock(&oxfw->mutex);
-		snd_oxfw_stream_stop(oxfw, stream);
+		stop_stream(oxfw, stream);
 		mutex_unlock(&oxfw->mutex);
 	} else {
 		amdtp_stream_update(stream);
@@ -464,6 +494,7 @@ end:
 int snd_oxfw_stream_discover(struct snd_oxfw *oxfw)
 {
 	u8 plugs[AVC_PLUG_INFO_BUF_COUNT];
+	unsigned int i;
 	int err;
 
 	/* the number of plugs for isoc in/out, ext in/out  */
@@ -482,6 +513,16 @@ int snd_oxfw_stream_discover(struct snd_oxfw *oxfw)
 
 	/* use iPCR[0] */
 	err = fill_stream_formations(oxfw, AVC_GENERAL_PLUG_DIR_IN, 0);
+	if (err < 0)
+		goto end;
+
+	/* if its stream has MIDI conformant data channel, add one MIDI port */
+	for (i = 0; i < SND_OXFW_STREAM_TABLE_ENTRIES; i++) {
+		if (oxfw->tx_stream_formations[i].midi > 0)
+			oxfw->midi_input_ports = 1;
+		else if (oxfw->rx_stream_formations[i].midi > 0)
+			oxfw->midi_output_ports = 1;
+	}
 end:
 	return err;
 }
-- 
1.8.3.2
