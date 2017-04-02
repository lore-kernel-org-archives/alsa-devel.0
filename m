From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: firewire-digi00x: allow user space
	applications to read/write MIDI messages for all ports
Date: Sun,  2 Apr 2017 23:48:26 +0900
Message-ID: <20170402144827.32497-4-o-takashi@sakamocchi.jp>
References: <20170402144827.32497-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 2310C266871
 for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2017 16:48:32 +0200 (CEST)
In-Reply-To: <20170402144827.32497-1-o-takashi@sakamocchi.jp>
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

At a commit c5fcee0373b3 ("ALSA: firewire-digi00x: add MIDI operations for
MIDI control port"), I described that MIDI messages for control surface is
transferred by a different way from the messages for physical ports.
However, this is wrong. MIDI messages to/from all of MIDI ports are
transferred by isochronous packets.

This commit removes codes to transfer MIDI messages via asynchronous
transaction, from MIDI handling layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-midi.c | 208 +++++++++++++---------------------
 1 file changed, 79 insertions(+), 129 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
index 915d2a2..7ab3d08 100644
--- a/sound/firewire/digi00x/digi00x-midi.c
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -8,7 +8,7 @@
 
 #include "digi00x.h"
 
-static int midi_phys_open(struct snd_rawmidi_substream *substream)
+static int midi_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 	int err;
@@ -27,7 +27,7 @@ static int midi_phys_open(struct snd_rawmidi_substream *substream)
 	return err;
 }
 
-static int midi_phys_close(struct snd_rawmidi_substream *substream)
+static int midi_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 
@@ -40,180 +40,130 @@ static int midi_phys_close(struct snd_rawmidi_substream *substream)
 	return 0;
 }
 
-static void midi_phys_capture_trigger(struct snd_rawmidi_substream *substream,
-				      int up)
+static void midi_capture_trigger(struct snd_rawmidi_substream *substream,
+				 int up)
 {
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
+	unsigned int port;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dg00x->lock, flags);
-
-	if (up)
-		amdtp_dot_midi_trigger(&dg00x->tx_stream, substream->number,
-				       substream);
+	if (substream->rmidi->device == 0)
+		port = substream->number;
 	else
-		amdtp_dot_midi_trigger(&dg00x->tx_stream, substream->number,
-				       NULL);
-
-	spin_unlock_irqrestore(&dg00x->lock, flags);
-}
-
-static void midi_phys_playback_trigger(struct snd_rawmidi_substream *substream,
-				       int up)
-{
-	struct snd_dg00x *dg00x = substream->rmidi->private_data;
-	unsigned long flags;
+		port = 2;
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
 	if (up)
-		amdtp_dot_midi_trigger(&dg00x->rx_stream, substream->number,
-				       substream);
+		amdtp_dot_midi_trigger(&dg00x->tx_stream, port, substream);
 	else
-		amdtp_dot_midi_trigger(&dg00x->rx_stream, substream->number,
-				       NULL);
+		amdtp_dot_midi_trigger(&dg00x->tx_stream, port, NULL);
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
 
-static int midi_ctl_open(struct snd_rawmidi_substream *substream)
-{
-	/* Do nothing. */
-	return 0;
-}
-
-static int midi_ctl_capture_close(struct snd_rawmidi_substream *substream)
-{
-	/* Do nothing. */
-	return 0;
-}
-
-static int midi_ctl_playback_close(struct snd_rawmidi_substream *substream)
-{
-	struct snd_dg00x *dg00x = substream->rmidi->private_data;
-
-	snd_fw_async_midi_port_finish(&dg00x->out_control);
-
-	return 0;
-}
-
-static void midi_ctl_capture_trigger(struct snd_rawmidi_substream *substream,
-				     int up)
+static void midi_playback_trigger(struct snd_rawmidi_substream *substream,
+				  int up)
 {
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
+	unsigned int port;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dg00x->lock, flags);
-
-	if (up)
-		dg00x->in_control = substream;
+	if (substream->rmidi->device == 0)
+		port = substream->number;
 	else
-		dg00x->in_control = NULL;
-
-	spin_unlock_irqrestore(&dg00x->lock, flags);
-}
-
-static void midi_ctl_playback_trigger(struct snd_rawmidi_substream *substream,
-				      int up)
-{
-	struct snd_dg00x *dg00x = substream->rmidi->private_data;
-	unsigned long flags;
+		port = 2;
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
 	if (up)
-		snd_fw_async_midi_port_run(&dg00x->out_control, substream);
+		amdtp_dot_midi_trigger(&dg00x->rx_stream, port, substream);
+	else
+		amdtp_dot_midi_trigger(&dg00x->rx_stream, port, NULL);
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
 
-static void set_midi_substream_names(struct snd_dg00x *dg00x,
-				     struct snd_rawmidi_str *str,
-				     bool is_ctl)
+static void set_substream_names(struct snd_dg00x *dg00x,
+				struct snd_rawmidi *rmidi, bool is_console)
 {
 	struct snd_rawmidi_substream *subs;
-
-	list_for_each_entry(subs, &str->substreams, list) {
-		if (!is_ctl)
-			snprintf(subs->name, sizeof(subs->name),
-				 "%s MIDI %d",
-				 dg00x->card->shortname, subs->number + 1);
-		else
-			/* This port is for asynchronous transaction. */
-			snprintf(subs->name, sizeof(subs->name),
-				 "%s control",
-				 dg00x->card->shortname);
+	struct snd_rawmidi_str *str;
+	int i;
+
+	for (i = 0; i < 2; ++i) {
+		str = &rmidi->streams[i];
+
+		list_for_each_entry(subs, &str->substreams, list) {
+			if (!is_console) {
+				snprintf(subs->name, sizeof(subs->name),
+					 "%s MIDI %d",
+					 dg00x->card->shortname,
+					 subs->number + 1);
+			} else {
+				snprintf(subs->name, sizeof(subs->name),
+					 "%s control",
+					 dg00x->card->shortname);
+			}
+		}
 	}
 }
 
-int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x)
+static int add_substream_pair(struct snd_dg00x *dg00x, unsigned int out_ports,
+			      unsigned int in_ports, bool is_console)
 {
-	static const struct snd_rawmidi_ops phys_capture_ops = {
-		.open		= midi_phys_open,
-		.close		= midi_phys_close,
-		.trigger	= midi_phys_capture_trigger,
-	};
-	static const struct snd_rawmidi_ops phys_playback_ops = {
-		.open		= midi_phys_open,
-		.close		= midi_phys_close,
-		.trigger	= midi_phys_playback_trigger,
+	static const struct snd_rawmidi_ops capture_ops = {
+		.open = midi_open,
+		.close = midi_close,
+		.trigger = midi_capture_trigger,
 	};
-	static const struct snd_rawmidi_ops ctl_capture_ops = {
-		.open		= midi_ctl_open,
-		.close		= midi_ctl_capture_close,
-		.trigger	= midi_ctl_capture_trigger,
+	static const struct snd_rawmidi_ops playback_ops = {
+		.open = midi_open,
+		.close = midi_close,
+		.trigger = midi_playback_trigger,
 	};
-	static const struct snd_rawmidi_ops ctl_playback_ops = {
-		.open		= midi_ctl_open,
-		.close		= midi_ctl_playback_close,
-		.trigger	= midi_ctl_playback_trigger,
-	};
-	struct snd_rawmidi *rmidi[2];
-	struct snd_rawmidi_str *str;
-	unsigned int i;
+	const char *label;
+	struct snd_rawmidi *rmidi;
 	int err;
 
 	/* Add physical midi ports. */
-	err = snd_rawmidi_new(dg00x->card, dg00x->card->driver, 0,
-			DOT_MIDI_OUT_PORTS, DOT_MIDI_IN_PORTS, &rmidi[0]);
+	err = snd_rawmidi_new(dg00x->card, dg00x->card->driver, is_console,
+			      out_ports, in_ports, &rmidi);
 	if (err < 0)
 		return err;
+	rmidi->private_data = dg00x;
 
-	snprintf(rmidi[0]->name, sizeof(rmidi[0]->name),
-		 "%s MIDI", dg00x->card->shortname);
-
-	snd_rawmidi_set_ops(rmidi[0], SNDRV_RAWMIDI_STREAM_INPUT,
-			    &phys_capture_ops);
-	snd_rawmidi_set_ops(rmidi[0], SNDRV_RAWMIDI_STREAM_OUTPUT,
-			    &phys_playback_ops);
+	if (!is_console)
+		label = "%s control";
+	else
+		label = "%s MIDI";
+	snprintf(rmidi->name, sizeof(rmidi->name), label,
+		 dg00x->card->shortname);
 
-	/* Add a pair of control midi ports. */
-	err = snd_rawmidi_new(dg00x->card, dg00x->card->driver, 1,
-			      1, 1, &rmidi[1]);
-	if (err < 0)
-		return err;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &playback_ops);
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &capture_ops);
 
-	snprintf(rmidi[1]->name, sizeof(rmidi[1]->name),
-		 "%s control", dg00x->card->shortname);
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT |
+			     SNDRV_RAWMIDI_INFO_OUTPUT |
+			     SNDRV_RAWMIDI_INFO_DUPLEX;
 
-	snd_rawmidi_set_ops(rmidi[1], SNDRV_RAWMIDI_STREAM_INPUT,
-			    &ctl_capture_ops);
-	snd_rawmidi_set_ops(rmidi[1], SNDRV_RAWMIDI_STREAM_OUTPUT,
-			    &ctl_playback_ops);
+	set_substream_names(dg00x, rmidi, is_console);
 
-	for (i = 0; i < ARRAY_SIZE(rmidi); i++) {
-		rmidi[i]->private_data = dg00x;
+	return 0;
+}
 
-		rmidi[i]->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
-		str = &rmidi[i]->streams[SNDRV_RAWMIDI_STREAM_INPUT];
-		set_midi_substream_names(dg00x, str, i);
+int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x)
+{
+	int err;
 
-		rmidi[i]->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
-		str = &rmidi[i]->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
-		set_midi_substream_names(dg00x, str, i);
+	/* Add physical midi ports. */
+	err = add_substream_pair(dg00x, DOT_MIDI_OUT_PORTS, DOT_MIDI_IN_PORTS,
+				 false);
+	if (err < 0)
+		return err;
 
-		rmidi[i]->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
-	}
+	if (dg00x->is_console)
+		err = add_substream_pair(dg00x, 1, 1, true);
 
-	return 0;
+	return err;
 }
-- 
2.9.3
