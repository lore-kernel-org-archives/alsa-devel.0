From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/13] speakers: Add support for
	capture/playback MIDI messages
Date: Sat, 11 Jan 2014 00:29:34 +0900
Message-ID: <1389367775-21360-13-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CB4A2654E4
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:30:04 +0100 (CET)
In-Reply-To: <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
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

I assume that 'if device formations of stream have MIDI conformant data
channels, the device has one MIDI port'. With this assumption, the driver
create MIDI devices.

When no streams have already started, MIDI functionality starts stream
with current sampling rate.

When MIDI functionality have already starts some streams and PCM
functionality is going to start streams at different sampling rate,
this driver stops streams once and changes sampling rate, then restarts
streams.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/speakers/Makefile          |   2 +-
 sound/firewire/speakers/speakers.c        |   9 +-
 sound/firewire/speakers/speakers.h        |   7 ++
 sound/firewire/speakers/speakers_midi.c   | 150 ++++++++++++++++++++++++++++++
 sound/firewire/speakers/speakers_stream.c |  35 +++++++
 5 files changed, 201 insertions(+), 2 deletions(-)
 create mode 100644 sound/firewire/speakers/speakers_midi.c

diff --git a/sound/firewire/speakers/Makefile b/sound/firewire/speakers/Makefile
index 86b2b6c..d98d4f7 100644
--- a/sound/firewire/speakers/Makefile
+++ b/sound/firewire/speakers/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-speakers-objs := speakers_command.o speakers_stream.o speakers_pcm.o speakers_control.o \
-			      speakers_proc.o speakers.o
+			      speakers_proc.o speakers_midi.o speakers.o
 obj-m += snd-firewire-speakers.o
diff --git a/sound/firewire/speakers/speakers.c b/sound/firewire/speakers/speakers.c
index 76afce9..fd16e59 100644
--- a/sound/firewire/speakers/speakers.c
+++ b/sound/firewire/speakers/speakers.c
@@ -115,6 +115,7 @@ static int fwspk_probe(struct fw_unit *unit,
 	fwspk->unit = fw_unit_get(unit);	/* inc reference counter */
 	fwspk->device_info = (const struct device_info *)id->driver_data;
 	mutex_init(&fwspk->mutex);
+	spin_lock_init(&fwspk->lock);
 
 	if (fwspk->device_info == &griffin_firewave)
 		err = firewave_stream_discover(fwspk);
@@ -129,7 +130,7 @@ static int fwspk_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto err_card;
 
-	err = snd_fwspk_stream_init(fwspk);
+	err = snd_fwspk_streams_init(fwspk);
 	if (err < 0)
 		goto err_card;
 
@@ -145,6 +146,12 @@ static int fwspk_probe(struct fw_unit *unit,
 
 	snd_fwspk_proc_init(fwspk);
 
+	if ((fwspk->midi_input_ports > 0) || (fwspk->midi_output_ports > 0)) {
+		err = snd_fwspk_create_midi(fwspk);
+		if (err < 0)
+			goto err_card;
+	}
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0)
diff --git a/sound/firewire/speakers/speakers.h b/sound/firewire/speakers/speakers.h
index 5d6c8e8..2c54946 100644
--- a/sound/firewire/speakers/speakers.h
+++ b/sound/firewire/speakers/speakers.h
@@ -19,6 +19,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 #include "../cmp.h"
 #include "../fcp.h"
@@ -45,6 +46,7 @@ struct fwspk {
 	struct fw_unit *unit;
 	const struct device_info *device_info;
 	struct mutex mutex;
+	spinlock_t lock;
 
 	struct fwspk_stream_formation
 		tx_stream_formations[FWSPK_STREAM_TABLE_ENTRIES];
@@ -55,6 +57,9 @@ struct fwspk {
 	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
 
+	unsigned int midi_input_ports;
+	unsigned int midi_output_ports;
+
 	bool mute;
 	s16 volume[6];
 	s16 volume_min;
@@ -118,3 +123,5 @@ int snd_fwspk_create_pcm(struct fwspk *fwspk);
 int snd_fwspk_create_mixer(struct fwspk *fwspk);
 
 void snd_fwspk_proc_init(struct fwspk *fwspk);
+
+int snd_fwspk_create_midi(struct fwspk *fwspk);
diff --git a/sound/firewire/speakers/speakers_midi.c b/sound/firewire/speakers/speakers_midi.c
new file mode 100644
index 0000000..83067a1
--- /dev/null
+++ b/sound/firewire/speakers/speakers_midi.c
@@ -0,0 +1,150 @@
+/*
+ * speakers_midi.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "speakers.h"
+
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	struct fwspk *fwspk = substream->rmidi->private_data;
+
+	return snd_fwspk_stream_start(fwspk, &fwspk->tx_stream, 0);
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct fwspk *fwspk = substream->rmidi->private_data;
+
+	return snd_fwspk_stream_start(fwspk, &fwspk->rx_stream, 0);
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *substream)
+{
+	struct fwspk *fwspk = substream->rmidi->private_data;
+
+	if (amdtp_stream_running(&fwspk->rx_stream) &&
+	    !amdtp_stream_pcm_running(&fwspk->tx_stream))
+		snd_fwspk_stream_stop(fwspk, &fwspk->tx_stream);
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct fwspk *fwspk = substream->rmidi->private_data;
+
+	if (amdtp_stream_running(&fwspk->rx_stream) &&
+	    !amdtp_stream_pcm_running(&fwspk->rx_stream))
+		snd_fwspk_stream_stop(fwspk, &fwspk->rx_stream);
+	return 0;
+}
+
+static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct fwspk *fwspk = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fwspk->lock, flags);
+
+	if (up)
+		amdtp_stream_midi_trigger(&fwspk->tx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&fwspk->tx_stream,
+					  substrm->number, NULL);
+
+	spin_unlock_irqrestore(&fwspk->lock, flags);
+
+	return;
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct fwspk *fwspk = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fwspk->lock, flags);
+
+	if (up)
+		amdtp_stream_midi_trigger(&fwspk->rx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&fwspk->rx_stream,
+					  substrm->number, NULL);
+
+	spin_unlock_irqrestore(&fwspk->lock, flags);
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
+static void set_midi_substream_names(struct fwspk *fwspk,
+				     struct snd_rawmidi_str *str)
+{
+	struct snd_rawmidi_substream *subs;
+
+	list_for_each_entry(subs, &str->substreams, list) {
+		snprintf(subs->name, sizeof(subs->name),
+			 "%s MIDI %d",
+			 fwspk->card->shortname, subs->number + 1);
+	}
+}
+
+int snd_fwspk_create_midi(struct fwspk *fwspk)
+{
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_str *str;
+	int err;
+
+	/* create midi ports */
+	err = snd_rawmidi_new(fwspk->card, fwspk->card->driver, 0,
+			      fwspk->midi_output_ports, fwspk->midi_input_ports,
+			      &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+		 "%s MIDI", fwspk->card->shortname);
+	rmidi->private_data = fwspk;
+
+	if (fwspk->midi_input_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+					&midi_capture_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
+
+		set_midi_substream_names(fwspk, str);
+	}
+
+	if (fwspk->midi_output_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+					&midi_playback_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+
+		set_midi_substream_names(fwspk, str);
+	}
+
+	if ((fwspk->midi_output_ports > 0) && (fwspk->midi_input_ports > 0))
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	return 0;
+}
diff --git a/sound/firewire/speakers/speakers_stream.c b/sound/firewire/speakers/speakers_stream.c
index b02b03c..2649f02 100644
--- a/sound/firewire/speakers/speakers_stream.c
+++ b/sound/firewire/speakers/speakers_stream.c
@@ -110,6 +110,7 @@ int snd_fwspk_stream_start(struct fwspk *fwspk,
 			   unsigned int rate)
 {
 	unsigned int i, curr_rate, pcm_channels, midi_ports;
+	struct amdtp_stream *opposite = NULL;
 	struct cmp_connection *conn;
 	enum avc_general_plug_dir dir;
 	bool used;
@@ -148,7 +149,21 @@ int snd_fwspk_stream_start(struct fwspk *fwspk,
 		err = -EIO;
 		goto end;
 	}
+	if (rate == 0)
+		rate = curr_rate;
 	if (curr_rate != rate) {
+		/* in case that AMDTP streams includes just MIDI */
+		if (amdtp_stream_running(&fwspk->tx_stream)) {
+			snd_fwspk_stream_stop(fwspk, &fwspk->tx_stream);
+			if (stream != &fwspk->tx_stream)
+				opposite = &fwspk->tx_stream;
+		}
+		if (amdtp_stream_running(&fwspk->rx_stream)) {
+			snd_fwspk_stream_stop(fwspk, &fwspk->rx_stream);
+			if (stream != &fwspk->rx_stream)
+				opposite = &fwspk->rx_stream;
+		}
+
 		err = avc_general_set_sig_fmt(fwspk->unit, rate, dir, 0);
 		if (err < 0)
 			goto end;
@@ -158,6 +173,17 @@ int snd_fwspk_stream_start(struct fwspk *fwspk,
 			err = -EIO;
 			goto end;
 		}
+
+		/*
+		 * NOTE:
+		 * No matter for recursive call because this opposite stream
+		 * will start at current sampling rate.
+		 */
+		if (opposite) {
+			err = snd_fwspk_stream_start(fwspk, opposite, 0);
+			if (err < 0)
+				goto end;
+		}
 	}
 
 	/* set stream formation */
@@ -420,6 +446,7 @@ end:
 int snd_fwspk_stream_discover(struct fwspk *fwspk)
 {
 	u8 plugs[AVC_PLUG_INFO_BUF_COUNT];
+	unsigned int i;
 	int err;
 
 	/* the number of plugs for isoc in/out, ext in/out  */
@@ -440,6 +467,14 @@ int snd_fwspk_stream_discover(struct fwspk *fwspk)
 	err = fill_stream_formations(fwspk, AVC_GENERAL_PLUG_DIR_IN, 0);
 	if (err < 0)
 		goto end;
+
+	/* if its stream has MIDI conformant data channel, add one MIDI port */
+	for (i = 0; i < FWSPK_STREAM_TABLE_ENTRIES; i++) {
+		if (fwspk->tx_stream_formations[i].midi > 0)
+			fwspk->midi_input_ports = 1;
+		else if (fwspk->rx_stream_formations[i].midi > 0)
+			fwspk->midi_output_ports = 1;
+	}
 end:
 	return err;
 }
-- 
1.8.3.2
