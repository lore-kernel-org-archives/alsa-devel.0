From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/13] ALSA: fireface: add support for MIDI
	functionality
Date: Sat, 11 Feb 2017 23:25:02 +0900
Message-ID: <20170211142509.4795-7-o-takashi@sakamocchi.jp>
References: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id B1089266AF8
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

In previous commit, fireface driver supports unique transaction for MIDI
feature. This commit adds MIDI functionality for userspace.

As I wrote in a followed commit, user space applications have some request
from this driver. It should not touch a register to which units transmit
MIDI messages. It should configure a register in which MIDI transmission
is controlled.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile  |   2 +-
 sound/firewire/fireface/ff-midi.c | 131 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/fireface/ff.c      |   5 ++
 sound/firewire/fireface/ff.h      |   3 +
 4 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireface/ff-midi.c

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index 864aacc..8e465e4 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,2 +1,2 @@
-snd-fireface-objs := ff.o ff-transaction.o
+snd-fireface-objs := ff.o ff-transaction.o ff-midi.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/ff-midi.c b/sound/firewire/fireface/ff-midi.c
new file mode 100644
index 0000000..29ee0a7
--- /dev/null
+++ b/sound/firewire/fireface/ff-midi.c
@@ -0,0 +1,131 @@
+/*
+ * ff-midi.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "ff.h"
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
+	unsigned long flags;
+
+	spin_lock_irqsave(&ff->lock, flags);
+
+	if (up)
+		ACCESS_ONCE(ff->tx_midi_substreams[substream->number]) =
+								substream;
+	else
+		ACCESS_ONCE(ff->tx_midi_substreams[substream->number]) = NULL;
+
+	spin_unlock_irqrestore(&ff->lock, flags);
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *substream,
+				  int up)
+{
+	struct snd_ff *ff = substream->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ff->lock, flags);
+
+	if (up || !ff->rx_midi_error[substream->number])
+		schedule_work(&ff->rx_midi_work[substream->number]);
+
+	spin_unlock_irqrestore(&ff->lock, flags);
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
+			      ff->spec->midi_out_ports, ff->spec->midi_in_ports,
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
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 4db630f..11d76b3 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -61,6 +61,10 @@ static void do_registration(struct work_struct *work)
 
 	name_card(ff);
 
+	err = snd_ff_create_midi_devices(ff);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(ff->card);
 	if (err < 0)
 		goto error;
@@ -91,6 +95,7 @@ static int snd_ff_probe(struct fw_unit *unit,
 	dev_set_drvdata(&unit->device, ff);
 
 	mutex_init(&ff->mutex);
+	spin_lock_init(&ff->lock);
 
 	ff->spec = (const struct snd_ff_spec *)entry->driver_data;
 
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index bac2e58..2944bde 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -47,6 +47,7 @@ struct snd_ff {
 	struct snd_card *card;
 	struct fw_unit *unit;
 	struct mutex mutex;
+	spinlock_t lock;
 
 	bool registered;
 	struct delayed_work dwork;
@@ -98,4 +99,6 @@ int snd_ff_transaction_register(struct snd_ff *ff);
 int snd_ff_transaction_reregister(struct snd_ff *ff);
 void snd_ff_transaction_unregister(struct snd_ff *ff);
 
+int snd_ff_create_midi_devices(struct snd_ff *ff);
+
 #endif
-- 
2.9.3
