From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 13/37] ALSA: firewire-digi00x: add MIDI
	functionality
Date: Sat, 11 Jul 2015 23:12:24 +0900
Message-ID: <1436623968-10780-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 42B78260581
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:05 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, Damien Zammit <damien@zamaudio.com>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds MIDI functionality to transfer/receive MIDI messages.

Digi 002/003 console also has a set of MIDI port for physical control.
These ports are added in later commits.

Cc: Damien Zammit <damien@zamaudio.com>
Cc: Robin Gareus <robin@gareus.org>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/Makefile       |   2 +-
 sound/firewire/digi00x/digi00x-midi.c | 149 ++++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c      |   5 ++
 sound/firewire/digi00x/digi00x.h      |   2 +
 4 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/digi00x/digi00x-midi.c

diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index 629ae16..0aea9dd 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-digi00x-objs := amdtp-dot.o digi00x-stream.o digi00x-proc.o \
-			     digi00x-pcm.o digi00x.o
+			     digi00x-pcm.o digi00x-midi.o digi00x.o
 obj-m += snd-firewire-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
new file mode 100644
index 0000000..09489fc
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
+	dg00x->substreams_counter++;
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
+	dg00x->substreams_counter++;
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
+	dg00x->substreams_counter--;
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
+	dg00x->substreams_counter--;
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
+		amdtp_dot_midi_trigger(&dg00x->tx_stream,
+				       substrm->number - 1, substrm);
+	else
+		amdtp_dot_midi_trigger(&dg00x->tx_stream,
+				       substrm->number - 1, NULL);
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
+				       substrm->number - 1, substrm);
+	else
+		amdtp_dot_midi_trigger(&dg00x->rx_stream,
+				       substrm->number - 1, NULL);
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
+			 dg00x->card->shortname, subs->number);
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
+			      3, 2, &rmidi);
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
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index 0db2024..0aa036c 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -74,6 +74,7 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	dg00x->unit = fw_unit_get(unit);
 
 	mutex_init(&dg00x->mutex);
+	spin_lock_init(&dg00x->lock);
 
 	err = name_card(dg00x);
 	if (err < 0)
@@ -89,6 +90,10 @@ static int snd_dg00x_probe(struct fw_unit *unit,
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
index 07dce7d..df6d39c 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -34,6 +34,7 @@ struct snd_dg00x {
 	struct fw_unit *unit;
 
 	struct mutex mutex;
+	spinlock_t lock;
 
 	struct amdtp_stream tx_stream;
 	struct fw_iso_resources tx_resources;
@@ -124,4 +125,5 @@ void snd_dg00x_proc_init(struct snd_dg00x *dg00x);
 
 int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x);
 
+int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x);
 #endif
-- 
2.1.4
