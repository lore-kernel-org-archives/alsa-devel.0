From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/8] oxfw: Add MIDI interface
Date: Sun,  5 Jan 2014 20:13:35 +0900
Message-ID: <1388920417-5584-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 57F25261635
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 12:13:55 +0100 (CET)
In-Reply-To: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds a functionality to capture/playback MIDI messages.

When no AMDTP streams are running, this module starts AMDTP stream at current
sampling rate for MIDI stream.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile    |   3 +-
 sound/firewire/oxfw/oxfw.c      |   7 +++
 sound/firewire/oxfw/oxfw.h      |   3 +
 sound/firewire/oxfw/oxfw_midi.c | 135 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/oxfw/oxfw_midi.c

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index ab7865d..5430ec7 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,2 +1,3 @@
-snd-oxfw-objs := oxfw_command.o oxfw_stream.o oxfw_proc.o oxfw.o
+snd-oxfw-objs := oxfw_command.o oxfw_stream.o oxfw_proc.o oxfw_midi.o \
+		 oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 8298cba..ee817cd 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -144,6 +144,13 @@ oxfw_probe(struct fw_unit *unit,
 
 	snd_oxfw_proc_init(oxfw);
 
+	if ((oxfw->midi_input_ports > 0) ||
+	    (oxfw->midi_output_ports > 0)) {
+		err = snd_oxfw_create_midi_devices(oxfw);
+		if (err < 0)
+			goto error;
+	}
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0) {
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 7c02448e..523ac40 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -21,6 +21,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -109,6 +110,8 @@ int snd_oxfw_stream_discover(struct snd_oxfw *oxfw);
 
 void snd_oxfw_proc_init(struct snd_oxfw *oxfw);
 
+int snd_oxfw_create_midi_devices(struct snd_oxfw *oxfw);
+
 #define SND_OXFW_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/oxfw/oxfw_midi.c b/sound/firewire/oxfw/oxfw_midi.c
new file mode 100644
index 0000000..41c14ec
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw_midi.c
@@ -0,0 +1,135 @@
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
+	return snd_oxfw_stream_start_duplex(oxfw, &oxfw->tx_stream, 0);
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+	return snd_oxfw_stream_start_duplex(oxfw, &oxfw->rx_stream, 0);
+}
+
+static int midi_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+	snd_oxfw_stream_stop_duplex(oxfw);
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
+	.close		= midi_close,
+	.trigger	= midi_capture_trigger,
+};
+
+static struct snd_rawmidi_ops midi_playback_ops = {
+	.open		= midi_playback_open,
+	.close		= midi_close,
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
+int snd_oxfw_create_midi_devices(struct snd_oxfw *oxfw)
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
+			"%s MIDI", oxfw->card->shortname);
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
-- 
1.8.3.2
