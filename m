From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: firewire-digi00x: add another
	rawmidi character device for MIDI control ports
Date: Sat, 31 Oct 2015 02:43:16 +0900
Message-ID: <1446226996-2299-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1446226996-2299-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EB51260686
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 18:43:23 +0100 (CET)
In-Reply-To: <1446226996-2299-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Digi 002/003 family uses two ways to transfer MIDI messages. They're
different mechanisms, while it's better to handle the ways in different
ALSA rawmidi character devices because one character device has just a
set of operations.

This commit adds another rawmidi character device for control MIDI port. As
a result, first rawmidi character device is just for MIDI messages
transferred by isochronous packets.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-midi.c | 104 ++++++++++++++++------------------
 1 file changed, 50 insertions(+), 54 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
index 527f4b3..fca2855 100644
--- a/sound/firewire/digi00x/digi00x-midi.c
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -13,10 +13,6 @@ static int midi_phys_open(struct snd_rawmidi_substream *substream)
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 	int err;
 
-	/* This port is for asynchronous transaction. */
-	if (substream->number == 0)
-		return 0;
-
 	err = snd_dg00x_stream_lock_try(dg00x);
 	if (err < 0)
 		return err;
@@ -35,10 +31,6 @@ static int midi_phys_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 
-	/* This port is for asynchronous transaction. */
-	if (substream->number == 0)
-		return 0;
-
 	mutex_lock(&dg00x->mutex);
 	dg00x->substreams_counter--;
 	snd_dg00x_stream_stop_duplex(dg00x);
@@ -56,21 +48,12 @@ static void midi_phys_capture_trigger(struct snd_rawmidi_substream *substream,
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
-	/* This port is for asynchronous transaction. */
-	if (substream->number == 0) {
-		if (up)
-			dg00x->in_control = substream;
-		else
-			dg00x->in_control = NULL;
-	} else {
-		if (up)
-			amdtp_dot_midi_trigger(&dg00x->tx_stream,
-					       substream->number - 1,
-					       substream);
-		else
-			amdtp_dot_midi_trigger(&dg00x->tx_stream,
-					       substream->number - 1, NULL);
-	}
+	if (up)
+		amdtp_dot_midi_trigger(&dg00x->tx_stream, substream->number,
+				       substream);
+	else
+		amdtp_dot_midi_trigger(&dg00x->tx_stream, substream->number,
+				       NULL);
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
@@ -83,20 +66,12 @@ static void midi_phys_playback_trigger(struct snd_rawmidi_substream *substream,
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
-	/* This port is for asynchronous transaction. */
-	if (substream->number == 0) {
-		if (up)
-			snd_fw_async_midi_port_run(&dg00x->out_control,
-						   substream);
-	} else {
-		if (up)
-			amdtp_dot_midi_trigger(&dg00x->rx_stream,
-					       substream->number - 1,
-					       substream);
-		else
-			amdtp_dot_midi_trigger(&dg00x->rx_stream,
-					       substream->number - 1, NULL);
-	}
+	if (up)
+		amdtp_dot_midi_trigger(&dg00x->rx_stream, substream->number,
+				       substream);
+	else
+		amdtp_dot_midi_trigger(&dg00x->rx_stream, substream->number,
+				       NULL);
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
@@ -177,15 +152,16 @@ static struct snd_rawmidi_ops midi_ctl_playback_ops = {
 };
 
 static void set_midi_substream_names(struct snd_dg00x *dg00x,
-				     struct snd_rawmidi_str *str)
+				     struct snd_rawmidi_str *str,
+				     bool is_ctl)
 {
 	struct snd_rawmidi_substream *subs;
 
 	list_for_each_entry(subs, &str->substreams, list) {
-		if (subs->number > 0)
+		if (!is_ctl)
 			snprintf(subs->name, sizeof(subs->name),
 				 "%s MIDI %d",
-				 dg00x->card->shortname, subs->number);
+				 dg00x->card->shortname, subs->number + 1);
 		else
 			/* This port is for asynchronous transaction. */
 			snprintf(subs->name, sizeof(subs->name),
@@ -196,32 +172,52 @@ static void set_midi_substream_names(struct snd_dg00x *dg00x,
 
 int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x)
 {
-	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi *rmidi[2];
 	struct snd_rawmidi_str *str;
+	unsigned int i;
 	int err;
 
+	/* Add physical midi ports. */
 	err = snd_rawmidi_new(dg00x->card, dg00x->card->driver, 0,
-			DOT_MIDI_OUT_PORTS + 1, DOT_MIDI_IN_PORTS + 1, &rmidi);
+			DOT_MIDI_OUT_PORTS, DOT_MIDI_IN_PORTS, &rmidi[0]);
 	if (err < 0)
 		return err;
 
-	snprintf(rmidi->name, sizeof(rmidi->name),
+	snprintf(rmidi[0]->name, sizeof(rmidi[0]->name),
 		 "%s MIDI", dg00x->card->shortname);
-	rmidi->private_data = dg00x;
 
-	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
-	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+	snd_rawmidi_set_ops(rmidi[0], SNDRV_RAWMIDI_STREAM_INPUT,
 			    &midi_phys_capture_ops);
-	str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
-	set_midi_substream_names(dg00x, str);
-
-	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
-	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+	snd_rawmidi_set_ops(rmidi[0], SNDRV_RAWMIDI_STREAM_OUTPUT,
 			    &midi_phys_playback_ops);
-	str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
-	set_midi_substream_names(dg00x, str);
 
-	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
+	/* Add a pair of control midi ports. */
+	err = snd_rawmidi_new(dg00x->card, dg00x->card->driver, 1,
+			      1, 1, &rmidi[1]);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi[1]->name, sizeof(rmidi[1]->name),
+		 "%s control", dg00x->card->shortname);
+
+	snd_rawmidi_set_ops(rmidi[1], SNDRV_RAWMIDI_STREAM_INPUT,
+			    &midi_ctl_capture_ops);
+	snd_rawmidi_set_ops(rmidi[1], SNDRV_RAWMIDI_STREAM_OUTPUT,
+			    &midi_ctl_playback_ops);
+
+	for (i = 0; i < ARRAY_SIZE(rmidi); i++) {
+		rmidi[i]->private_data = dg00x;
+
+		rmidi[i]->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+		str = &rmidi[i]->streams[SNDRV_RAWMIDI_STREAM_INPUT];
+		set_midi_substream_names(dg00x, str, i);
+
+		rmidi[i]->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+		str = &rmidi[i]->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+		set_midi_substream_names(dg00x, str, i);
+
+		rmidi[i]->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
+	}
 
 	return 0;
 }
-- 
2.1.4
