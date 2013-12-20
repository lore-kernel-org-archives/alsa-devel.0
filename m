From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 22/38] fireworks: Add MIDI interface
Date: Fri, 20 Dec 2013 22:14:13 +0900
Message-ID: <1387545269-3875-23-git-send-email-o-takashi@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds a functionality to capture/playback MIDI messages.

When no AMDTP streams are running, this module starts AMDTP stream at current
sampling rate for MIDI stream.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/Makefile         |   3 +-
 sound/firewire/fireworks/fireworks.c      |   6 ++
 sound/firewire/fireworks/fireworks.h      |   3 +
 sound/firewire/fireworks/fireworks_midi.c | 145 ++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireworks/fireworks_midi.c

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
index 9c041eb..454fa5e 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -203,6 +203,12 @@ efw_probe(struct fw_unit *unit,
 
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
index 6f060f4..18a97b5 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -22,6 +22,7 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
@@ -188,6 +189,8 @@ void snd_efw_stream_destroy_duplex(struct snd_efw *efw);
 
 void snd_efw_proc_init(struct snd_efw *efw);
 
+int snd_efw_create_midi_devices(struct snd_efw *efw);
+
 #define SND_EFW_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
new file mode 100644
index 0000000..b22658d
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -0,0 +1,145 @@
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


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
