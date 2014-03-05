From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 30/39] bebob: Add MIDI interface
Date: Wed,  5 Mar 2014 19:48:18 +0900
Message-ID: <1394016507-15761-31-git-send-email-o-takashi@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id A4CA626590B
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 11:49:21 +0100 (CET)
In-Reply-To: <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
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
---
 sound/firewire/Kconfig            |   1 +
 sound/firewire/bebob/Makefile     |   3 +-
 sound/firewire/bebob/bebob.c      |   7 ++
 sound/firewire/bebob/bebob.h      |   3 +
 sound/firewire/bebob/bebob_midi.c | 148 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/bebob/bebob_midi.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 9027b23..8081ca1 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -82,6 +82,7 @@ config SND_FIREWORKS
 config SND_BEBOB
 	tristate "BridgeCo DM1000/1500 with BeBoB firmware"
 	select SND_FIREWIRE_LIB
+	select SND_RAWMIDI
         help
 	 Say Y here to include support for FireWire devices based
 	 on BridgeCo DM1000/1500 with BeBoB firmware:
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 757c40e..1e39e59 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,2 +1,3 @@
-snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob.o
+snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_midi.o \
+		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index d0ad889..3872854 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -167,6 +167,13 @@ bebob_probe(struct fw_unit *unit,
 
 	snd_bebob_proc_init(bebob);
 
+	if ((bebob->midi_input_ports > 0) ||
+	    (bebob->midi_output_ports > 0)) {
+		err = snd_bebob_create_midi_devices(bebob);
+		if (err < 0)
+			goto error;
+	}
+
 	err = snd_card_register(card);
 	if (err < 0) {
 		snd_card_free(card);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 83ee15a..1e1db6c 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -21,6 +21,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -178,6 +179,8 @@ void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob);
 
 void snd_bebob_proc_init(struct snd_bebob *bebob);
 
+int snd_bebob_create_midi_devices(struct snd_bebob *bebob);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
new file mode 100644
index 0000000..9312b34
--- /dev/null
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -0,0 +1,148 @@
+/*
+ * bebob_midi.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "bebob.h"
+
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_bebob *bebob = substream->rmidi->private_data;
+
+	bebob->capture_substreams++;
+	return snd_bebob_stream_start_duplex(bebob, &bebob->tx_stream, 0);
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_bebob *bebob = substream->rmidi->private_data;
+
+	bebob->playback_substreams++;
+	return snd_bebob_stream_start_duplex(bebob, &bebob->rx_stream, 0);
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_bebob *bebob = substream->rmidi->private_data;
+
+	bebob->capture_substreams--;
+	snd_bebob_stream_stop_duplex(bebob);
+
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_bebob *bebob = substream->rmidi->private_data;
+
+	bebob->playback_substreams--;
+	snd_bebob_stream_stop_duplex(bebob);
+
+	return 0;
+}
+
+static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_bebob *bebob = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bebob->lock, flags);
+
+	if (up)
+		amdtp_stream_midi_trigger(&bebob->tx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&bebob->tx_stream,
+					  substrm->number, NULL);
+
+	spin_unlock_irqrestore(&bebob->lock, flags);
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_bebob *bebob = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bebob->lock, flags);
+
+	if (up)
+		amdtp_stream_midi_trigger(&bebob->rx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&bebob->rx_stream,
+					  substrm->number, NULL);
+
+	spin_unlock_irqrestore(&bebob->lock, flags);
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
+static void set_midi_substream_names(struct snd_bebob *bebob,
+				     struct snd_rawmidi_str *str)
+{
+	struct snd_rawmidi_substream *subs;
+
+	list_for_each_entry(subs, &str->substreams, list) {
+		snprintf(subs->name, sizeof(subs->name),
+			 "%s MIDI %d",
+			 bebob->card->shortname, subs->number + 1);
+	}
+}
+
+int snd_bebob_create_midi_devices(struct snd_bebob *bebob)
+{
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_str *str;
+	int err;
+
+	/* create midi ports */
+	err = snd_rawmidi_new(bebob->card, bebob->card->driver, 0,
+			      bebob->midi_output_ports, bebob->midi_input_ports,
+			      &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+			"%s MIDI", bebob->card->shortname);
+	rmidi->private_data = bebob;
+
+	if (bebob->midi_input_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+					&midi_capture_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
+
+		set_midi_substream_names(bebob, str);
+	}
+
+	if (bebob->midi_output_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+					&midi_playback_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+
+		set_midi_substream_names(bebob, str);
+	}
+
+	if ((bebob->midi_output_ports > 0) && (bebob->midi_input_ports > 0))
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	return 0;
+}
-- 
1.8.3.2
