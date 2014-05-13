From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/15] oxfw: Add support for capture/playback MIDI messages
Date: Tue, 13 May 2014 23:27:51 +0900
Message-ID: <1399991272-5807-15-git-send-email-o-takashi@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds MIDI functionality with an assumption of 'if the device
has MIDI comformant data channels in its stream formation, the device has
one MIDI port'.

When no streams have already started, MIDI functionality starts stream
with current sampling rate.

When MIDI functionality has already starts some streams and PCM
functionality is going to start streams at different sampling rate,
this driver stops streams once and changes sampling rate, then restarts
streams for both PCM/MIDI substreams.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig            |   1 +
 sound/firewire/oxfw/Makefile      |   2 +-
 sound/firewire/oxfw/oxfw.c        |   7 ++
 sound/firewire/oxfw/oxfw.h        |   7 ++
 sound/firewire/oxfw/oxfw_midi.c   | 148 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw_stream.c |  16 ++++-
 6 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 sound/firewire/oxfw/oxfw_midi.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 38027bd..b5035b0 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -30,6 +30,7 @@ config SND_OXFW
 	tristate "Oxford OXFW970/971 chipset support"
 	select SND_PCM
 	select SND_FIREWIRE_LIB
+	select SND_RAWMIDI
 	help
 	  Say Y here to include support for Firewire devices based on
 	  Oxford Semiconductor OXFW970/971 chipset.
diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 4ee2c97..5f65270 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,3 +1,3 @@
 snd-oxfw-objs := oxfw_command.o oxfw_stream.o oxfw_control.o oxfw_proc.o \
-		 oxfw_pcm.o oxfw.o
+		 oxfw_midi.o oxfw_pcm.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index a9e21c0..5640547 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -119,6 +119,7 @@ static int oxfw_probe(struct fw_unit *unit,
 	mutex_init(&oxfw->mutex);
 	oxfw->unit = unit;
 	oxfw->device_info = (const struct device_info *)id->driver_data;
+	spin_lock_init(&oxfw->lock);
 
 	err = snd_oxfw_stream_discover(oxfw);
 	if (err < 0)
@@ -140,6 +141,12 @@ static int oxfw_probe(struct fw_unit *unit,
 
 	snd_oxfw_proc_init(oxfw);
 
+	if ((oxfw->midi_input_ports > 0) || (oxfw->midi_output_ports > 0)) {
+		err = snd_oxfw_create_midi(oxfw);
+		if (err < 0)
+			goto error;
+	}
+
 	err = snd_oxfw_stream_init_simplex(oxfw, &oxfw->rx_stream);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 81b6627..bcaab01 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -19,6 +19,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -47,6 +48,7 @@ struct snd_oxfw {
 	struct fw_unit *unit;
 	const struct device_info *device_info;
 	struct mutex mutex;
+	spinlock_t lock;
 
 	bool has_output;
 	struct snd_oxfw_stream_formation
@@ -60,6 +62,9 @@ struct snd_oxfw {
 	atomic_t capture_substreams;
 	atomic_t playback_substreams;
 
+	unsigned int midi_input_ports;
+	unsigned int midi_output_ports;
+
 	bool mute;
 	s16 volume[6];
 	s16 volume_min;
@@ -119,3 +124,5 @@ int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
 int snd_oxfw_create_mixer(struct snd_oxfw *oxfw);
 
 void snd_oxfw_proc_init(struct snd_oxfw *oxfw);
+
+int snd_oxfw_create_midi(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_midi.c b/sound/firewire/oxfw/oxfw_midi.c
new file mode 100644
index 0000000..04be550
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw_midi.c
@@ -0,0 +1,148 @@
+/*
+ * oxfw_midi.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2014 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "oxfw.h"
+
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+
+	atomic_inc(&oxfw->capture_substreams);
+	return snd_oxfw_stream_start_simplex(oxfw, &oxfw->tx_stream, 0, 0);
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+
+	atomic_inc(&oxfw->playback_substreams);
+	return snd_oxfw_stream_start_simplex(oxfw, &oxfw->rx_stream, 0, 0);
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+
+	atomic_dec(&oxfw->capture_substreams);
+	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->tx_stream);
+
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_oxfw *oxfw = substream->rmidi->private_data;
+
+	atomic_dec(&oxfw->playback_substreams);
+	snd_oxfw_stream_stop_simplex(oxfw, &oxfw->rx_stream);
+
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
+int snd_oxfw_create_midi(struct snd_oxfw *oxfw)
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
+		 "%s MIDI", oxfw->card->shortname);
+	rmidi->private_data = oxfw;
+
+	if (oxfw->midi_input_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+				    &midi_capture_ops);
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
+				    &midi_playback_ops);
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
diff --git a/sound/firewire/oxfw/oxfw_stream.c b/sound/firewire/oxfw/oxfw_stream.c
index 6521899..858e1e6 100644
--- a/sound/firewire/oxfw/oxfw_stream.c
+++ b/sound/firewire/oxfw/oxfw_stream.c
@@ -262,6 +262,8 @@ int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw,
 			"fail to get sampling rate: %d\n", err);
 		goto end;
 	}
+	if (rate == 0)
+		rate = curr_rate;
 	if (curr_rate != rate) {
 		/* Stop streams safely. */
 		if (opposite != NULL) {
@@ -575,6 +577,7 @@ end:
 int snd_oxfw_stream_discover(struct snd_oxfw *oxfw)
 {
 	u8 plugs[AVC_PLUG_INFO_BUF_BYTES];
+	unsigned int i;
 	int err;
 
 	/* the number of plugs for isoc in/out, ext in/out  */
@@ -598,8 +601,19 @@ int snd_oxfw_stream_discover(struct snd_oxfw *oxfw)
 	}
 
 	/* use iPCR[0] if exists */
-	if (plugs[0] > 0)
+	if (plugs[0] > 0) {
 		err = fill_stream_formations(oxfw, AVC_GENERAL_PLUG_DIR_IN, 0);
+		if (err < 0)
+			goto end;
+	}
+
+	/* if its stream has MIDI conformant data channel, add one MIDI port */
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
+		if (oxfw->tx_stream_formations[i].midi > 0)
+			oxfw->midi_input_ports = 1;
+		if (oxfw->rx_stream_formations[i].midi > 0)
+			oxfw->midi_output_ports = 1;
+	}
 end:
 	return err;
 }
-- 
1.8.3.2


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
