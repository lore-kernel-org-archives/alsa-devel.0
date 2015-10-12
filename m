From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: firewire-tascam: add support for
	MIDI functionality
Date: Mon, 12 Oct 2015 19:10:23 +0900
Message-ID: <1444644625-30189-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FF0B2610B1
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 12:10:30 +0200 (CEST)
In-Reply-To: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
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

In former commits, this driver got functionalities to transfer/receive
MIDI messages to/from TASCAM FireWire series.

This commit adds some ALSA MIDI ports to enable userspace applications
to use the functionalities.

I note that this commit doesn't support virtual MIDI ports which console
models support. A physical controls can be assigned to a certain MIDI
ports including physical and virtual. But the way is not clear.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/Makefile      |   2 +-
 sound/firewire/tascam/tascam-midi.c | 135 ++++++++++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.c      |   4 ++
 sound/firewire/tascam/tascam.h      |   2 +
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/tascam/tascam-midi.c

diff --git a/sound/firewire/tascam/Makefile b/sound/firewire/tascam/Makefile
index a1f9fe7..0fc955d 100644
--- a/sound/firewire/tascam/Makefile
+++ b/sound/firewire/tascam/Makefile
@@ -1,4 +1,4 @@
 snd-firewire-tascam-objs := tascam-proc.o amdtp-tascam.o tascam-stream.o \
 			    tascam-pcm.o tascam-hwdep.o tascam-transaction.o \
-			    tascam.o
+			    tascam-midi.o tascam.o
 obj-$(CONFIG_SND_FIREWIRE_TASCAM) += snd-firewire-tascam.o
diff --git a/sound/firewire/tascam/tascam-midi.c b/sound/firewire/tascam/tascam-midi.c
new file mode 100644
index 0000000..41f8420
--- /dev/null
+++ b/sound/firewire/tascam/tascam-midi.c
@@ -0,0 +1,135 @@
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
+	/* Do nothing. */
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
+	/* Do nothing. */
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
+	if (up)
+		tscm->tx_midi_substreams[substrm->number] = substrm;
+	else
+		tscm->tx_midi_substreams[substrm->number] = NULL;
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
+	struct snd_rawmidi_substream *subs;
+	int err;
+
+	err = snd_rawmidi_new(tscm->card, tscm->card->driver, 0,
+			      tscm->spec->midi_playback_ports,
+			      tscm->spec->midi_capture_ports,
+			      &rmidi);
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
+		/* TODO: support virtual MIDI ports. */
+		if (subs->number < tscm->spec->midi_capture_ports) {
+			/* Hardware MIDI ports. */
+			snprintf(subs->name, sizeof(subs->name),
+				 "%s MIDI %d",
+				 tscm->card->shortname, subs->number + 1);
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
+		if (subs->number < tscm->spec->midi_playback_ports) {
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
index de9e8df..dc07e3e 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -132,6 +132,10 @@ static int snd_tscm_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_tscm_create_midi_devices(tscm);
+	if (err < 0)
+		goto error;
+
 	err = snd_tscm_create_hwdep_device(tscm);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index c2f0c74..b86bb7f 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -138,6 +138,8 @@ void snd_tscm_proc_init(struct snd_tscm *tscm);
 
 int snd_tscm_create_pcm_devices(struct snd_tscm *tscm);
 
+int snd_tscm_create_midi_devices(struct snd_tscm *tscm);
+
 int snd_tscm_create_hwdep_device(struct snd_tscm *tscm);
 
 #endif
-- 
2.1.4
