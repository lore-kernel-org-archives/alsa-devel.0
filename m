From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 29/30] ALSA: oxfw: Add support for
	capture/playback MIDI messages
Date: Sat, 29 Nov 2014 00:59:38 +0900
Message-ID: <1417190379-4172-30-git-send-email-o-takashi@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 227AE2604F4
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 16:59:53 +0100 (CET)
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

This commit adds MIDI functionality with an assumption of 'if the device
has MIDI comformant data channels in its stream formation, the device has
one MIDI port'.

When no streams have already started, MIDI functionality starts stream
with current sampling rate.

When MIDI functionality has already starts some streams and PCM
functionality is going to start streams at different sampling rate,
this driver stops streams once and changes sampling rate, then restarts
streams for both PCM/MIDI substreams.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile      |   2 +-
 sound/firewire/oxfw/oxfw-midi.c   | 191 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw-stream.c |   4 +
 sound/firewire/oxfw/oxfw.c        |   5 +
 sound/firewire/oxfw/oxfw.h        |   7 ++
 5 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/oxfw/oxfw-midi.c

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index e9297c6..3904a30 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,3 +1,3 @@
 snd-oxfw-objs := oxfw-command.o oxfw-stream.o oxfw-control.o oxfw-pcm.o \
-		 oxfw-proc.o oxfw.o
+		 oxfw-proc.o oxfw-midi.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-midi.c
new file mode 100644
index 0000000..334b11d
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -0,0 +1,191 @@
+/*
+ * oxfw_midi.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2014 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "oxfw.h"
+
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+	int err;
+
+	mutex_lock(&oxfw->mutex);
+
+	oxfw->capture_substreams++;
+	err = snd_oxfw_stream_start_simplex(oxfw, &oxfw->tx_stream, 0, 0);
+
+	mutex_unlock(&oxfw->mutex);
+
+	return err;
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+	int err;
+
+	mutex_lock(&oxfw->mutex);
+
+	oxfw->playback_substreams++;
+	err = snd_oxfw_stream_start_simplex(oxfw, &oxfw->rx_stream, 0, 0);
+
+	mutex_unlock(&oxfw->mutex);
+
+	return err;
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+
+	mutex_lock(&oxfw->mutex);
+
+	oxfw->capture_substreams--;
+	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->tx_stream);
+
+	mutex_unlock(&oxfw->mutex);
+
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+
+	mutex_lock(&oxfw->mutex);
+
+	oxfw->playback_substreams--;
+	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->rx_stream);
+
+	mutex_unlock(&oxfw->mutex);
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
+	struct snd_oxfw_stream_formation formation;
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_str *str;
+	u8 *format;
+	int i, err;
+
+	/* If its stream has MIDI conformant data channel, add one MIDI port */
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		format = oxfw->tx_stream_formats[i];
+		if (format != NULL) {
+			err = snd_oxfw_stream_parse_format(format, &formation);
+			if (err >= 0 && formation.midi > 0)
+				oxfw->midi_input_ports = 1;
+		}
+
+		format = oxfw->rx_stream_formats[i];
+		if (format != NULL) {
+			err = snd_oxfw_stream_parse_format(format, &formation);
+			if (err >= 0 && formation.midi > 0)
+				oxfw->midi_output_ports = 1;
+		}
+	}
+	if ((oxfw->midi_input_ports == 0) && (oxfw->midi_output_ports == 0))
+		return 0;
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
+				    &midi_capture_ops);
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
+				    &midi_playback_ops);
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
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 1d15428..a38b3c3 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -282,6 +282,10 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
 	err = snd_oxfw_stream_get_current_formation(oxfw, dir, &formation);
 	if (err < 0)
 		goto end;
+	if (rate == 0)
+		rate = formation.rate;
+	if (pcm_channels == 0)
+		pcm_channels = formation.pcm;
 
 	if ((formation.rate != rate) || (formation.pcm != pcm_channels)) {
 		if (opposite != NULL) {
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 75634fc..1cd1954 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -154,6 +154,7 @@ static int oxfw_probe(struct fw_unit *unit,
 	mutex_init(&oxfw->mutex);
 	oxfw->unit = unit;
 	oxfw->device_info = (const struct device_info *)id->driver_data;
+	spin_lock_init(&oxfw->lock);
 
 	err = snd_oxfw_stream_discover(oxfw);
 	if (err < 0)
@@ -175,6 +176,10 @@ static int oxfw_probe(struct fw_unit *unit,
 
 	snd_oxfw_proc_init(oxfw);
 
+	err = snd_oxfw_create_midi(oxfw);
+	if (err < 0)
+		goto error;
+
 	err = snd_oxfw_stream_init_simplex(oxfw, &oxfw->rx_stream);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index aace2e6..14dc84b 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -19,6 +19,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -42,6 +43,7 @@ struct snd_oxfw {
 	struct fw_unit *unit;
 	const struct device_info *device_info;
 	struct mutex mutex;
+	spinlock_t lock;
 
 	bool has_output;
 	u8 *tx_stream_formats[SND_OXFW_STREAM_FORMAT_ENTRIES];
@@ -54,6 +56,9 @@ struct snd_oxfw {
 	unsigned int capture_substreams;
 	unsigned int playback_substreams;
 
+	unsigned int midi_input_ports;
+	unsigned int midi_output_ports;
+
 	bool mute;
 	s16 volume[6];
 	s16 volume_min;
@@ -123,3 +128,5 @@ int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
 int snd_oxfw_create_mixer(struct snd_oxfw *oxfw);
 
 void snd_oxfw_proc_init(struct snd_oxfw *oxfw);
+
+int snd_oxfw_create_midi(struct snd_oxfw *oxfw);
-- 
2.1.0
