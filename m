From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/6] firewire-digi00x: add support for MIDI
	ports corresponding to isochronous packet streaming
Date: Sun, 11 Oct 2015 12:30:16 +0900
Message-ID: <1444534219-31718-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EC252605DD
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 05:30:30 +0200 (CEST)
In-Reply-To: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds MIDI functionality to capture/playback MIDI messages
from/to physical MIDI ports. These messages are transferred in isochronous
packets.

When no substreams request AMDTP streams to run, this driver starts the
streams at current sampling rate. When other substreams start at different
sampling rate, the streams are stopped temporarily, then start again at
requested sampling rate. This operation can generate missing MIDI bytes,
thus it's preferable to start PCM substreams at favorite sampling rate in
advance.

Digi 002/003 console also has a set of MIDI port for physical controls.
These ports are added in later commits.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/Makefile         |   2 +-
 sound/firewire/digi00x/digi00x-midi.c   | 131 ++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-stream.c |   2 +
 sound/firewire/digi00x/digi00x.c        |   4 +
 sound/firewire/digi00x/digi00x.h        |   2 +
 5 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/digi00x/digi00x-midi.c

diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index 28e3d13..1123e68 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,4 +1,4 @@
 snd-firewire-digi00x-objs := amdtp-dot.o digi00x-stream.o digi00x-proc.o \
 			     digi00x-pcm.o digi00x-hwdep.o \
-			     digi00x-transaction.o digi00x.o
+			     digi00x-transaction.o digi00x-midi.o digi00x.o
 obj-$(CONFIG_SND_FIREWIRE_DIGI00X) += snd-firewire-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
new file mode 100644
index 0000000..4e258ac
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -0,0 +1,131 @@
+/*
+ * digi00x-midi.h - a part of driver for Digidesign Digi 002/003 family
+ *
+ * Copyright (c) 2014-2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "digi00x.h"
+
+static int midi_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->rmidi->private_data;
+	int err;
+
+	err = snd_dg00x_stream_lock_try(dg00x);
+	if (err < 0)
+		return err;
+
+	mutex_lock(&dg00x->mutex);
+	dg00x->substreams_counter++;
+	err = snd_dg00x_stream_start_duplex(dg00x, 0);
+	mutex_unlock(&dg00x->mutex);
+	if (err < 0)
+		snd_dg00x_stream_lock_release(dg00x);
+
+	return err;
+}
+
+static int midi_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->rmidi->private_data;
+
+	mutex_lock(&dg00x->mutex);
+	dg00x->substreams_counter--;
+	snd_dg00x_stream_stop_duplex(dg00x);
+	mutex_unlock(&dg00x->mutex);
+
+	snd_dg00x_stream_lock_release(dg00x);
+	return 0;
+}
+
+static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_dg00x *dg00x = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dg00x->lock, flags);
+
+	if (up)
+		amdtp_dot_midi_trigger(&dg00x->tx_stream,
+				       substrm->number, substrm);
+	else
+		amdtp_dot_midi_trigger(&dg00x->tx_stream,
+				       substrm->number, NULL);
+
+	spin_unlock_irqrestore(&dg00x->lock, flags);
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_dg00x *dg00x = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dg00x->lock, flags);
+
+	if (up)
+		amdtp_dot_midi_trigger(&dg00x->rx_stream,
+				       substrm->number, substrm);
+	else
+		amdtp_dot_midi_trigger(&dg00x->rx_stream,
+				       substrm->number, NULL);
+
+	spin_unlock_irqrestore(&dg00x->lock, flags);
+}
+
+static struct snd_rawmidi_ops midi_capture_ops = {
+	.open		= midi_open,
+	.close		= midi_close,
+	.trigger	= midi_capture_trigger,
+};
+
+static struct snd_rawmidi_ops midi_playback_ops = {
+	.open		= midi_open,
+	.close		= midi_close,
+	.trigger	= midi_playback_trigger,
+};
+
+static void set_midi_substream_names(struct snd_dg00x *dg00x,
+				     struct snd_rawmidi_str *str)
+{
+	struct snd_rawmidi_substream *subs;
+
+	list_for_each_entry(subs, &str->substreams, list) {
+		snprintf(subs->name, sizeof(subs->name),
+			 "%s MIDI %d",
+			 dg00x->card->shortname, subs->number + 1);
+	}
+}
+
+int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x)
+{
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_str *str;
+	int err;
+
+	err = snd_rawmidi_new(dg00x->card, dg00x->card->driver, 0,
+			      DOT_MIDI_OUT_PORTS, DOT_MIDI_IN_PORTS, &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+		 "%s MIDI", dg00x->card->shortname);
+	rmidi->private_data = dg00x;
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+			    &midi_capture_ops);
+	str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
+	set_midi_substream_names(dg00x, str);
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+			    &midi_playback_ops);
+	str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+	set_midi_substream_names(dg00x, str);
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	return 0;
+}
diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index e9be162..4d3b4eb 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -285,6 +285,8 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x, unsigned int rate)
 	err = snd_dg00x_stream_get_local_rate(dg00x, &curr_rate);
 	if (err < 0)
 		goto error;
+	if (rate == 0)
+		rate = curr_rate;
 	if (curr_rate != rate ||
 	    amdtp_streaming_error(&dg00x->tx_stream) ||
 	    amdtp_streaming_error(&dg00x->rx_stream)) {
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index 34937a2..bbe3be7 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -90,6 +90,10 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_dg00x_create_midi_devices(dg00x);
+	if (err < 0)
+		goto error;
+
 	err = snd_dg00x_create_hwdep_device(dg00x);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 88df67b..89494d0 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -147,5 +147,7 @@ void snd_dg00x_proc_init(struct snd_dg00x *dg00x);
 
 int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x);
 
+int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x);
+
 int snd_dg00x_create_hwdep_device(struct snd_dg00x *dg00x);
 #endif
-- 
2.1.4
