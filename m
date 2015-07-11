From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 36/37] ALSA: firewire-motu: add MIDI
	functionality
Date: Sat, 11 Jul 2015 23:12:47 +0900
Message-ID: <1436623968-10780-37-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D1FD2605C4
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:07 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

MOTU FireWire series uses isochronous packets to transfer MIDI messages.

This commit adds MIDI functionality to transfer/receive MIDI messages.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/Makefile    |   2 +-
 sound/firewire/motu/motu-midi.c | 143 ++++++++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.c      |   5 ++
 sound/firewire/motu/motu.h      |   3 +
 sound/firewire/tascam/tascam.c  |   1 +
 5 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/motu/motu-midi.c

diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index c1c9888..e8055b9 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-motu-objs := amdtp-motu.o motu-stream.o motu-transaction.o \
-			  motu-proc.o motu-pcm.o motu.o
+			  motu-proc.o motu-pcm.o motu-midi.o motu.o
 obj-m += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-midi.c b/sound/firewire/motu/motu-midi.c
new file mode 100644
index 0000000..ab40fb2
--- /dev/null
+++ b/sound/firewire/motu/motu-midi.c
@@ -0,0 +1,143 @@
+/*
+ * motu-miti.h - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+#include "motu.h"
+
+static int midi_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_motu *motu = substream->rmidi->private_data;
+	int err;
+
+	mutex_lock(&motu->mutex);
+
+	motu->substreams_counter++;
+	err = snd_motu_stream_start_duplex(motu, 0);
+
+	mutex_unlock(&motu->mutex);
+
+	return err;
+}
+
+static int midi_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_motu *motu = substream->rmidi->private_data;
+
+	mutex_lock(&motu->mutex);
+
+	motu->substreams_counter--;
+	snd_motu_stream_stop_duplex(motu);
+
+	mutex_unlock(&motu->mutex);
+
+	return 0;
+}
+
+static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_motu *motu = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&motu->lock, flags);
+
+	if (up)
+		amdtp_motu_midi_trigger(&motu->tx_stream, substrm->number,
+					substrm);
+	else
+		amdtp_motu_midi_trigger(&motu->tx_stream, substrm->number,
+					NULL);
+
+	spin_unlock_irqrestore(&motu->lock, flags);
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_motu *motu = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&motu->lock, flags);
+
+	if (up)
+		amdtp_motu_midi_trigger(&motu->rx_stream, substrm->number,
+					substrm);
+	else
+		amdtp_motu_midi_trigger(&motu->rx_stream, substrm->number,
+					NULL);
+
+	spin_unlock_irqrestore(&motu->lock, flags);
+}
+
+static struct snd_rawmidi_ops capture_ops = {
+	.open		= midi_open,
+	.close		= midi_close,
+	.trigger	= midi_capture_trigger,
+};
+
+static struct snd_rawmidi_ops playback_ops = {
+	.open		= midi_open,
+	.close		= midi_close,
+	.trigger	= midi_playback_trigger,
+};
+
+static void set_midi_substream_names(struct snd_motu *motu,
+				     struct snd_rawmidi_str *str)
+{
+	struct snd_rawmidi_substream *subs;
+
+	list_for_each_entry(subs, &str->substreams, list) {
+		snprintf(subs->name, sizeof(subs->name),
+			 "%s MIDI %d", motu->card->shortname, subs->number + 1);
+	}
+}
+
+int snd_motu_create_midi_devices(struct snd_motu *motu)
+{
+	struct snd_motu_spec *spec = motu->spec;
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_str *str;
+	int err;
+
+	if (spec->tx_midi_ports + spec->rx_midi_ports == 0)
+		return 0;
+
+	/* create midi ports */
+	err = snd_rawmidi_new(motu->card, motu->card->driver, 0,
+			      spec->rx_midi_ports, spec->tx_midi_ports,
+			      &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+		 "%s MIDI", motu->card->shortname);
+	rmidi->private_data = motu;
+
+	if (spec->tx_midi_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+				    &capture_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
+
+		set_midi_substream_names(motu, str);
+	}
+
+	if (spec->rx_midi_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+				    &playback_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+
+		set_midi_substream_names(motu, str);
+	}
+
+	if (spec->tx_midi_ports > 0 && spec->rx_midi_ports)
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	return 0;
+}
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 5deb592..6c539ed 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -65,6 +65,7 @@ static int motu_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	card->private_free = motu_card_free;
 
 	mutex_init(&motu->mutex);
+	spin_lock_init(&motu->lock);
 
 	name_card(motu);
 
@@ -82,6 +83,10 @@ static int motu_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	if (err < 0)
 		goto error;
 
+	err = snd_motu_create_midi_devices(motu);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 50c19a5..7ca8542 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -47,6 +47,7 @@ struct snd_motu {
 	struct fw_unit *unit;
 
 	struct mutex mutex;
+	spinlock_t lock;
 
 	/* Model dependent information. */
 	struct snd_motu_spec *spec;
@@ -110,4 +111,6 @@ void snd_motu_proc_init(struct snd_motu *motu);
 
 int snd_motu_create_pcm_devices(struct snd_motu *motu);
 
+int snd_motu_create_midi_devices(struct snd_motu *motu);
+
 #endif
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index 2afb291..80e8780 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -121,6 +121,7 @@ static int snd_tscm_probe(struct fw_unit *unit,
 	tscm->unit = fw_unit_get(unit);
 
 	mutex_init(&tscm->mutex);
+	spin_lock_init(&tscm->lock);
 
 	err = check_name(tscm);
 	if (err < 0)
-- 
2.1.4
