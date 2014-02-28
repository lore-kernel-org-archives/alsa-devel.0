From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 23/39] fireworks: Add MIDI interface
Date: Fri, 28 Feb 2014 12:27:36 +0900
Message-ID: <1393558072-25926-24-git-send-email-o-takashi@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CC1A26513C
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 04:28:27 +0100 (CET)
In-Reply-To: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
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

When no AMDTP streams are running, this driver starts AMDTP stream for MIDI
stream at current sampling rate.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                    |   1 +
 sound/firewire/fireworks/Makefile         |   3 +-
 sound/firewire/fireworks/fireworks.c      |   6 ++
 sound/firewire/fireworks/fireworks.h      |   3 +
 sound/firewire/fireworks/fireworks_midi.c | 158 ++++++++++++++++++++++++++++++
 5 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireworks/fireworks_midi.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 0b85ebd..36a1212 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -64,6 +64,7 @@ config SND_SCS1X
 config SND_FIREWORKS
 	tristate "Echo Fireworks board module support"
 	select SND_FIREWIRE_LIB
+	select SND_RAWMIDI
 	help
 	  Say Y here to include support for FireWire devices based
 	  on Echo Digital Audio Fireworks board:
diff --git a/sound/firewire/fireworks/Makefile b/sound/firewire/fireworks/Makefile
index 52bd15e..a2cecc6 100644
--- a/sound/firewire/fireworks/Makefile
+++ b/sound/firewire/fireworks/Makefile
@@ -1,3 +1,4 @@
 snd-fireworks-objs := fireworks_transaction.o fireworks_command.o \
-		      fireworks_stream.o fireworks_proc.o fireworks.o
+		      fireworks_stream.o fireworks_proc.o fireworks_midi.o \
+		      fireworks.o
 obj-m += snd-fireworks.o
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index e370204..5537773 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -201,6 +201,12 @@ efw_probe(struct fw_unit *unit,
 
 	snd_efw_proc_init(efw);
 
+	if (efw->midi_out_ports || efw->midi_in_ports) {
+		err = snd_efw_create_midi_devices(efw);
+		if (err < 0)
+			goto error;
+	}
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 4d69c0d..0dfed97 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -22,6 +22,7 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
@@ -189,6 +190,8 @@ void snd_efw_stream_destroy_duplex(struct snd_efw *efw);
 
 void snd_efw_proc_init(struct snd_efw *efw);
 
+int snd_efw_create_midi_devices(struct snd_efw *efw);
+
 #define SND_EFW_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
new file mode 100644
index 0000000..a950fd1
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -0,0 +1,158 @@
+/*
+ * fireworks_midi.c - a part of driver for Fireworks based devices
+ *
+ * Copyright (c) 2009-2010 Clemens Ladisch
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+#include "fireworks.h"
+
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_efw *efw = substream->rmidi->private_data;
+
+	efw->capture_substreams++;
+	return snd_efw_stream_start_duplex(efw, &efw->tx_stream, 0);
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_efw *efw = substream->rmidi->private_data;
+
+	efw->playback_substreams++;
+	return snd_efw_stream_start_duplex(efw, &efw->rx_stream, 0);
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_efw *efw = substream->rmidi->private_data;
+
+	efw->capture_substreams--;
+	snd_efw_stream_stop_duplex(efw);
+
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_efw *efw = substream->rmidi->private_data;
+
+	efw->playback_substreams--;
+	snd_efw_stream_stop_duplex(efw);
+
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
