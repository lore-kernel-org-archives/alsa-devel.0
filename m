From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 24/25] ALSA: firewire-tascam: add MIDI
	functionality
Date: Thu, 13 Aug 2015 09:20:20 +0900
Message-ID: <1439425221-30826-25-git-send-email-o-takashi@sakamocchi.jp>
References: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DE18261629
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 02:20:38 +0200 (CEST)
In-Reply-To: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit adds MIDI functionality to transfer/receive MIDI messages.

Console models supports virtual MIDI ports additional to physical MIDI
ports. Once physical controls are assigned to the virtual MIDI ports,
userspace applications can receive/transmit MIDI messages from/to the
MIDI ports. Additionally, without assignment, physical controls can
transmit control events in isochronous packets. This messages are
supported in later commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/Makefile      |   3 +-
 sound/firewire/tascam/tascam-midi.c | 162 ++++++++++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.c      |   4 +
 sound/firewire/tascam/tascam.h      |   3 +
 4 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/tascam/tascam-midi.c

diff --git a/sound/firewire/tascam/Makefile b/sound/firewire/tascam/Makefile
index 1f39e02..fcfe125 100644
--- a/sound/firewire/tascam/Makefile
+++ b/sound/firewire/tascam/Makefile
@@ -1,3 +1,4 @@
 snd-firewire-tascam-objs := tascam-proc.o amdtp-tascam.o tascam-stream.o \
-			    tascam-pcm.o tascam-transaction.o tascam.o
+			    tascam-pcm.o tascam-transaction.o tascam-midi.o \
+			    tascam.o
 obj-m += snd-firewire-tascam.o
diff --git a/sound/firewire/tascam/tascam-midi.c b/sound/firewire/tascam/tascam-midi.c
new file mode 100644
index 0000000..f0344b3
--- /dev/null
+++ b/sound/firewire/tascam/tascam-midi.c
@@ -0,0 +1,162 @@
+/*
+ * tascam-midi.c - a part of driver for TASCAM FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "tascam.h"
+
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	/* TODO: pick up hardware control messages as MIDI? */
+	if (substream->pstr->substream_count == substream->number)
+		return -1;
+
+	return 0;
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_tscm *tscm = substream->rmidi->private_data;
+
+	/* Initialize internal status. */
+	tscm->running_status[substream->number] = 0;
+	tscm->on_sysex[substream->number] = 0;
+	return 0;
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *substream)
+{
+	/* TODO: pick up hardware control messages as MIDI? */
+	if (substream->pstr->substream_count == substream->number)
+		return -1;
+
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_tscm *tscm = substream->rmidi->private_data;
+
+	snd_fw_async_midi_port_finish(&tscm->out_ports[substream->number]);
+
+	return 0;
+}
+
+static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_tscm *tscm = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tscm->lock, flags);
+
+	/* TODO: pick up hardware control messages as MIDI? */
+	if (substrm->pstr->substream_count == substrm->number) {
+		return;
+	} else {
+		if (up)
+			tscm->tx_midi_substreams[substrm->number] = substrm;
+		else
+			tscm->tx_midi_substreams[substrm->number] = NULL;
+	}
+
+	spin_unlock_irqrestore(&tscm->lock, flags);
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_tscm *tscm = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tscm->lock, flags);
+
+	if (up)
+		snd_fw_async_midi_port_run(&tscm->out_ports[substrm->number],
+					   substrm);
+
+	spin_unlock_irqrestore(&tscm->lock, flags);
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
+int snd_tscm_create_midi_devices(struct snd_tscm *tscm)
+{
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_str *stream;
+	unsigned in_ports, out_ports;
+	struct snd_rawmidi_substream *subs;
+	int err;
+
+	in_ports = tscm->spec->midi_capture_ports;
+	out_ports = tscm->spec->midi_playback_ports;
+
+	/* Controllers have additional 3 ports for output. */
+	if (tscm->spec->is_controller)
+		in_ports += 3;
+
+	err = snd_rawmidi_new(tscm->card, tscm->card->driver, 0,
+			      out_ports, in_ports, &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+		 "%s MIDI", tscm->card->shortname);
+	rmidi->private_data = tscm;
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+			    &midi_capture_ops);
+	stream = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
+
+	/* Set port names for MIDI input. */
+	list_for_each_entry(subs, &stream->substreams, list) {
+		if (subs->number < tscm->spec->midi_capture_ports) {
+			/* Hardware MIDI ports. */
+			snprintf(subs->name, sizeof(subs->name),
+				 "%s MIDI %d",
+				 tscm->card->shortname, subs->number + 1);
+		} else if (subs->number < tscm->spec->midi_capture_ports + 2) {
+			/* Virtual MIDI ports. */
+			snprintf(subs->name, sizeof(subs->name),
+				 "%s virtual MIDI %d",
+				 tscm->card->shortname,
+				 subs->number -
+					tscm->spec->midi_capture_ports + 1);
+		} else if (tscm->spec->is_controller) {
+			/* Hardware controls. */
+			snprintf(subs->name, sizeof(subs->name),
+				 "%s control", tscm->card->shortname);
+		}
+	}
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+			    &midi_playback_ops);
+	stream = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+
+	/* Set port names for MIDI ourput. */
+	list_for_each_entry(subs, &stream->substreams, list) {
+		if (subs->number < tscm->spec->midi_capture_ports) {
+			/* Hardware MIDI ports only. */
+			snprintf(subs->name, sizeof(subs->name),
+				 "%s MIDI %d",
+				 tscm->card->shortname, subs->number + 1);
+		}
+	}
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	return 0;
+}
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index 5e770e5..99622e1 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -140,6 +140,10 @@ static int snd_tscm_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_tscm_create_midi_devices(tscm);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 920bf30..0c0b753 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -46,6 +46,7 @@ struct snd_tscm {
 	struct fw_unit *unit;
 
 	struct mutex mutex;
+	spinlock_t lock;
 
 	struct snd_tscm_spec *spec;
 
@@ -123,3 +124,5 @@ void snd_tscm_transaction_unregister(struct snd_tscm *tscm);
 void snd_tscm_proc_init(struct snd_tscm *tscm);
 
 int snd_tscm_create_pcm_devices(struct snd_tscm *tscm);
+
+int snd_tscm_create_midi_devices(struct snd_tscm *tscm);
-- 
2.1.4
