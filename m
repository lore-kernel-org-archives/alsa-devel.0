From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/13] bebob: Add MIDI interface
Date: Sat, 23 Nov 2013 15:09:17 +0900
Message-ID: <1385186965-8303-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id CD00426530B
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:09:36 +0100 (CET)
In-Reply-To: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds the functionality to capture/playback MIDI message. MIDI
message is multiplexed/demultiplexed into AMDTP stream.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig            |   1 +
 sound/firewire/bebob/Makefile     |   1 +
 sound/firewire/bebob/bebob.c      |   7 ++
 sound/firewire/bebob/bebob.h      |   3 +
 sound/firewire/bebob/bebob_midi.c | 172 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 184 insertions(+)
 create mode 100644 sound/firewire/bebob/bebob_midi.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 5349652..c7987a0 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -63,6 +63,7 @@ config SND_SCS1X
 
 config SND_BEBOB
 	tristate "BridgeCo BeBoB chipset support"
+	select SND_RAWMIDI
 	select SND_FIREWIRE_LIB
         help
 	 Say Y here to include support for FireWire devices based
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index bec01cd..c7aeef7 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,3 +1,4 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_control.o \
+		  bebob_midi.o \
 		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 71a3896..89dc45b 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -177,6 +177,13 @@ snd_bebob_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	if ((bebob->midi_input_ports > 0) ||
+	    (bebob->midi_output_ports > 0)) {
+		err = snd_bebob_create_midi_devices(bebob);
+		if (err < 0)
+			goto error;
+	}
+
 	err = snd_bebob_create_control_devices(bebob);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index d87999e..2775a73 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -31,6 +31,7 @@
 #include <sound/initval.h>
 #include <sound/info.h>
 #include <sound/control.h>
+#include <sound/rawmidi.h>
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
@@ -153,6 +154,8 @@ void snd_bebob_proc_init(struct snd_bebob *bebob);
 
 int snd_bebob_create_control_devices(struct snd_bebob *bebob);
 
+int snd_bebob_create_midi_devices(struct snd_bebob *bebob);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
new file mode 100644
index 0000000..56c7115
--- /dev/null
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -0,0 +1,172 @@
+/*
+ * bebob_midi.c - a part of driver for BeBoB based devices
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * This driver is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2.
+ *
+ * This driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "bebob.h"
+
+/*
+ * According to MMA/AMEI-027, MIDI stream is multiplexed with PCM stream in
+ * AMDTP packet. The data rate of MIDI message is much less than PCM so there
+ * is a little problem to suspend MIDI streams.
+ */
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_bebob *bebob = substream->rmidi->private_data;
+	int err;
+
+	err = snd_bebob_stream_start_duplex(bebob, &bebob->tx_stream, 0);
+	if (err < 0)
+		goto end;
+
+	amdtp_stream_midi_add(&bebob->tx_stream, substream);
+end:
+	return err;
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_bebob *bebob = substream->rmidi->private_data;
+	int err;
+
+	err = snd_bebob_stream_start_duplex(bebob, &bebob->rx_stream, 0);
+	if (err < 0)
+		goto end;
+
+	amdtp_stream_midi_add(&bebob->rx_stream, substream);
+end:
+	return err;
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_bebob *bebob = substream->rmidi->private_data;
+
+	amdtp_stream_midi_remove(&bebob->tx_stream, substream);
+	snd_bebob_stream_stop_duplex(bebob);
+
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_bebob *bebob = substream->rmidi->private_data;
+
+	amdtp_stream_midi_remove(&bebob->rx_stream, substream);
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
+		__set_bit(substrm->number, &bebob->tx_stream.midi_triggered);
+	else
+		__clear_bit(substrm->number, &bebob->tx_stream.midi_triggered);
+
+	spin_unlock_irqrestore(&bebob->lock, flags);
+
+	return;
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
+		__set_bit(substrm->number, &bebob->rx_stream.midi_triggered);
+	else
+		__clear_bit(substrm->number, &bebob->rx_stream.midi_triggered);
+
+	spin_unlock_irqrestore(&bebob->lock, flags);
+
+	return;
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
+			 "%s MIDI %d", bebob->card->shortname, subs->number + 1);
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
