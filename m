From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/11] ALSA: digi00x: add MIDI functionality
Date: Mon, 16 Mar 2015 01:01:03 +0900
Message-ID: <1426435269-17059-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id F1648260870
 for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2015 17:01:20 +0100 (CET)
In-Reply-To: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, robin@gareus.org, damien@zamaudio.com
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Digi 002/003 uses AM824 format data to transfer MIDI messages. It's a
first data channel in each data block of CIP packet.

This commit adds MIDI functionality to transfer/receive MIDI messages
in the first data channel, with AMDTP functionality ALSA firewire stack
gives. But the device handles these MIDI message in disorder because
Digi 002/003 are not conformant to MMA/AMEI RP-027 or IEC 61883-6:2005.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/Makefile         |   3 +-
 sound/firewire/digi00x/digi00x-midi.c   | 149 ++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-stream.c |   3 +
 sound/firewire/digi00x/digi00x.c        |   4 +
 sound/firewire/digi00x/digi00x.h        |   3 +
 5 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/digi00x/digi00x-midi.c

diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index f2ed472..8ae72b9 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,2 +1,3 @@
-snd-digi00x-objs := digi00x.o digi00x-stream.o digi00x-proc.o digi00x-pcm.o
+snd-digi00x-objs := digi00x.o digi00x-stream.o digi00x-proc.o digi00x-pcm.o \
+		    digi00x-midi.o
 obj-m += snd-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
new file mode 100644
index 0000000..9936c40
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -0,0 +1,149 @@
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
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->rmidi->private_data;
+	int err;
+
+	mutex_lock(&dg00x->mutex);
+	dg00x->capture_substreams++;
+	err = snd_dg00x_stream_start_duplex(dg00x, 0);
+	mutex_unlock(&dg00x->mutex);
+
+	return err;
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->rmidi->private_data;
+	int err;
+
+	mutex_lock(&dg00x->mutex);
+	dg00x->playback_substreams++;
+	err = snd_dg00x_stream_start_duplex(dg00x, 0);
+	mutex_unlock(&dg00x->mutex);
+
+	return err;
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->rmidi->private_data;
+
+	mutex_lock(&dg00x->mutex);
+	dg00x->capture_substreams--;
+	snd_dg00x_stream_stop_duplex(dg00x);
+	mutex_unlock(&dg00x->mutex);
+
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->rmidi->private_data;
+
+	mutex_lock(&dg00x->mutex);
+	dg00x->playback_substreams--;
+	snd_dg00x_stream_stop_duplex(dg00x);
+	mutex_unlock(&dg00x->mutex);
+
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
+		amdtp_stream_midi_trigger(&dg00x->tx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&dg00x->tx_stream,
+					  substrm->number, NULL);
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
+		amdtp_stream_midi_trigger(&dg00x->rx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&dg00x->rx_stream,
+					  substrm->number, NULL);
+
+	spin_unlock_irqrestore(&dg00x->lock, flags);
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
+			      1, 2, &rmidi);
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
index 75f67b5..26b6885 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -260,6 +260,9 @@ int snd_dg00x_stream_start_duplex(struct snd_dg00x *dg00x, unsigned int rate)
 	err = snd_dg00x_stream_get_rate(dg00x, &curr_rate);
 	if (err < 0)
 		goto error;
+	/* For MIDI substreams. */
+	if (rate == 0)
+		rate = curr_rate;
 	if ((curr_rate != rate) |
 	    amdtp_streaming_error(&dg00x->tx_stream) |
 	    amdtp_streaming_error(&dg00x->rx_stream)) {
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index 493437a..5b678ec 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -90,6 +90,10 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_dg00x_create_midi_devices(dg00x);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 754486a..b41a418 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -23,6 +23,7 @@
 #include <sound/info.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/rawmidi.h>
 
 #include "../lib.h"
 #include "../packets-buffer.h"
@@ -88,4 +89,6 @@ void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_proc_init(struct snd_dg00x *dg00x);
 
 int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x);
+
+int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x);
 #endif
-- 
2.1.0
