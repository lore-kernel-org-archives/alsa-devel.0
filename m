From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] fireface: add support for MIDI
	functionality
Date: Sun,  6 Dec 2015 22:23:44 +0900
Message-ID: <1449408224-13955-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id F286B265379
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 14:23:49 +0100 (CET)
In-Reply-To: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
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

In previous commit, fireface driver supports transaction functionality.
This commit adds MIDI functionality for userspace.

Userspace applications can always disable this functionality by sending
invalid values to 0x0000801003f4 and 0x00008010051c in write transactions.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile        |   2 +-
 sound/firewire/fireface/fireface-midi.c | 129 ++++++++++++++++++++++++++++++++
 sound/firewire/fireface/fireface.c      |   4 +
 sound/firewire/fireface/fireface.h      |   2 +
 4 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireface/fireface-midi.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index aa52e41..2174b4b 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,2 +1,2 @@
-snd-fireface-objs := fireface.o fireface-transaction.o
+snd-fireface-objs := fireface.o fireface-transaction.o fireface-midi.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/fireface-midi.c b/sound/firewire/fireface/fireface-midi.c
new file mode 100644
index 0000000..0c0f99f
--- /dev/null
+++ b/sound/firewire/fireface/fireface-midi.c
@@ -0,0 +1,129 @@
+/*
+ * fireface-midi.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2016 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "fireface.h"
+
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	/* Do nothing. */
+	return 0;
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_ff *ff = substream->rmidi->private_data;
+
+	/* Initialize internal status. */
+	ff->running_status[substream->number] = 0;
+	ff->rx_midi_error[substream->number] = false;
+
+	ACCESS_ONCE(ff->rx_midi_substreams[substream->number]) = substream;
+
+	return 0;
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *substream)
+{
+	/* Do nothing. */
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_ff *ff = substream->rmidi->private_data;
+
+	cancel_work_sync(&ff->rx_midi_work[substream->number]);
+	ACCESS_ONCE(ff->rx_midi_substreams[substream->number]) = NULL;
+
+	return 0;
+}
+
+static void midi_capture_trigger(struct snd_rawmidi_substream *substream,
+				 int up)
+{
+	struct snd_ff *ff = substream->rmidi->private_data;
+
+	spin_lock(&ff->lock);
+
+	if (up)
+		ACCESS_ONCE(ff->tx_midi_substreams[substream->number]) =
+								substream;
+	else
+		ACCESS_ONCE(ff->tx_midi_substreams[substream->number]) = NULL;
+
+	spin_unlock(&ff->lock);
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *substream,
+				  int up)
+{
+	struct snd_ff *ff = substream->rmidi->private_data;
+
+	spin_lock(&ff->lock);
+
+	if (up || !ff->rx_midi_error[substream->number])
+		schedule_work(&ff->rx_midi_work[substream->number]);
+
+	spin_unlock(&ff->lock);
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
+static void set_midi_substream_names(struct snd_rawmidi_str *stream,
+				     const char *const name)
+{
+	struct snd_rawmidi_substream *substream;
+
+	list_for_each_entry(substream, &stream->substreams, list) {
+		snprintf(substream->name, sizeof(substream->name),
+			 "%s MIDI %d", name, substream->number + 1);
+	}
+}
+
+int snd_ff_create_midi_devices(struct snd_ff *ff)
+{
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_str *stream;
+	int err;
+
+	err = snd_rawmidi_new(ff->card, ff->card->driver, 0,
+			      SND_FF_OUT_MIDI_PORTS, SND_FF_IN_MIDI_PORTS,
+			      &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+		 "%s MIDI", ff->card->shortname);
+	rmidi->private_data = ff;
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+			    &midi_capture_ops);
+	stream = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
+	set_midi_substream_names(stream, ff->card->shortname);
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+			    &midi_playback_ops);
+	stream = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+	set_midi_substream_names(stream, ff->card->shortname);
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	return 0;
+}
diff --git a/sound/firewire/fireface/fireface.c b/sound/firewire/fireface/fireface.c
index d9cfac2..1d0eb86f 100644
--- a/sound/firewire/fireface/fireface.c
+++ b/sound/firewire/fireface/fireface.c
@@ -80,6 +80,10 @@ static int snd_ff_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_ff_create_midi_devices(ff);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/fireface/fireface.h b/sound/firewire/fireface/fireface.h
index 914472a..017bbb5 100644
--- a/sound/firewire/fireface/fireface.h
+++ b/sound/firewire/fireface/fireface.h
@@ -68,4 +68,6 @@ int snd_ff_transaction_register(struct snd_ff *ff);
 int snd_ff_transaction_reregister(struct snd_ff *ff);
 void snd_ff_transaction_unregister(struct snd_ff *ff);
 
+int snd_ff_create_midi_devices(struct snd_ff *ff);
+
 #endif
-- 
2.5.0
