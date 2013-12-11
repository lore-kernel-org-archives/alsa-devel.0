From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/8] fireworks: Add MIDI interface
Date: Wed, 11 Dec 2013 18:15:56 +0900
Message-ID: <1386753359-12458-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id AC3E5261691
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 10:16:37 +0100 (CET)
In-Reply-To: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit adds a functionality to capture/playback MIDI messages.

When no AMDTP streams are running, this module starts AMDTP stream at current
sampling rate for MIDI stream.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/Makefile         |   3 +-
 sound/firewire/fireworks/fireworks.c      |   6 ++
 sound/firewire/fireworks/fireworks.h      |   3 +
 sound/firewire/fireworks/fireworks_midi.c | 155 ++++++++++++++++++++++++++++++
 4 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireworks/fireworks_midi.c

diff --git a/sound/firewire/fireworks/Makefile b/sound/firewire/fireworks/Makefile
index 52bd15e..6594bcc 100644
--- a/sound/firewire/fireworks/Makefile
+++ b/sound/firewire/fireworks/Makefile
@@ -1,3 +1,4 @@
 snd-fireworks-objs := fireworks_transaction.o fireworks_command.o \
-		      fireworks_stream.o fireworks_proc.o fireworks.o
+		      fireworks_stream.o fireworks_proc.o fireworks.o \
+		      fireworks_midi.o fireworks.o
 obj-m += snd-fireworks.o
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index adc4a91..dff7d24 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -217,6 +217,12 @@ efw_probe(struct fw_unit *unit,
 
 	snd_efw_proc_init(efw);
 
+	if (efw->midi_out_ports || efw->midi_in_ports) {
+		err = snd_efw_create_midi_devices(efw);
+		if (err < 0)
+			goto error;
+	}
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0)
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 2b0d85c..0f892a8 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -32,6 +32,7 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
@@ -206,6 +207,8 @@ void snd_efw_stream_destroy_duplex(struct snd_efw *efw);
 
 void snd_efw_proc_init(struct snd_efw *efw);
 
+int snd_efw_create_midi_devices(struct snd_efw *efw);
+
 #define SND_EFW_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
new file mode 100644
index 0000000..6c320f1
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -0,0 +1,155 @@
+/*
+ * fireworks_midi.c - a part of driver for Fireworks based devices
+ *
+ * Copyright (c) 2009-2010 Clemens Ladisch
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
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
+#include "fireworks.h"
+
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_efw *efw = substream->rmidi->private_data;
+	return snd_efw_stream_start_duplex(efw, &efw->tx_stream, 0);
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_efw *efw = substream->rmidi->private_data;
+	return snd_efw_stream_start_duplex(efw, &efw->rx_stream, 0);
+}
+
+static int midi_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_efw *efw = substream->rmidi->private_data;
+	snd_efw_stream_stop_duplex(efw);
+	return 0;
+}
+
+static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_efw *efw = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&efw->lock, flags);
+
+	if (up)
+		amdtp_stream_midi_trigger(&efw->tx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&efw->tx_stream,
+					  substrm->number, NULL);
+
+	spin_unlock_irqrestore(&efw->lock, flags);
+
+	return;
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_efw *efw = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&efw->lock, flags);
+
+	if (up)
+		amdtp_stream_midi_trigger(&efw->rx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&efw->rx_stream,
+					  substrm->number, NULL);
+
+	spin_unlock_irqrestore(&efw->lock, flags);
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
+static void set_midi_substream_names(struct snd_efw *efw,
+				     struct snd_rawmidi_str *str)
+{
+	struct snd_rawmidi_substream *subs;
+
+	list_for_each_entry(subs, &str->substreams, list) {
+		snprintf(subs->name, sizeof(subs->name),
+			 "%s MIDI %d", efw->card->shortname, subs->number + 1);
+	}
+}
+
+int snd_efw_create_midi_devices(struct snd_efw *efw)
+{
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_str *str;
+	int err;
+
+	/* check the number of midi stream */
+	if ((efw->midi_in_ports > SND_EFW_MAX_MIDI_IN_PORTS) |
+	    (efw->midi_out_ports > SND_EFW_MAX_MIDI_OUT_PORTS))
+		return -EIO;
+
+	/* create midi ports */
+	err = snd_rawmidi_new(efw->card, efw->card->driver, 0,
+			      efw->midi_out_ports, efw->midi_in_ports,
+			      &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+			"%s MIDI", efw->card->shortname);
+	rmidi->private_data = efw;
+
+	if (efw->midi_in_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+					&midi_capture_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
+
+		set_midi_substream_names(efw, str);
+	}
+
+	if (efw->midi_out_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+					&midi_playback_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+
+		set_midi_substream_names(efw, str);
+
+		/*
+		 * Fireworks ignores MIDI messages in greater than first 8 data
+		 * blocks of an AMDTP packet.
+		 */
+		efw->rx_stream.blocks_for_midi = 8;
+	}
+
+	if ((efw->midi_out_ports > 0) && (efw->midi_in_ports > 0))
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	return 0;
+}
-- 
1.8.3.2
