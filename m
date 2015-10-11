From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/6] firewire-digi00x: add support for MIDI
	ports for physical controls
Date: Sun, 11 Oct 2015 12:30:19 +0900
Message-ID: <1444534219-31718-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E4C42605FA
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 05:30:32 +0200 (CEST)
In-Reply-To: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In former commits, asynchronous transactions are supported for physical
controls. This commit adds a pair of MIDI ports for them.

This driver already adds diferrent number of ALSA MIDI ports for physical
MIDI ports, and the number of in/out ports are different. As seeing as
'amidi' program in alsa-utils package, a pair of in/out MIDI ports is
expected with the same name. Therefore, this commit adds a pair of new
ports to the first.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-midi.c | 61 ++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
index 4e258ac..9aa8b46 100644
--- a/sound/firewire/digi00x/digi00x-midi.c
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -13,6 +13,10 @@ static int midi_open(struct snd_rawmidi_substream *substream)
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 	int err;
 
+	/* This port is for asynchronous transaction. */
+	if (substream->number == 0)
+		return 0;
+
 	err = snd_dg00x_stream_lock_try(dg00x);
 	if (err < 0)
 		return err;
@@ -31,6 +35,10 @@ static int midi_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 
+	/* This port is for asynchronous transaction. */
+	if (substream->number == 0)
+		return 0;
+
 	mutex_lock(&dg00x->mutex);
 	dg00x->substreams_counter--;
 	snd_dg00x_stream_stop_duplex(dg00x);
@@ -47,12 +55,20 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
-	if (up)
-		amdtp_dot_midi_trigger(&dg00x->tx_stream,
-				       substrm->number, substrm);
-	else
-		amdtp_dot_midi_trigger(&dg00x->tx_stream,
-				       substrm->number, NULL);
+	/* This port is for asynchronous transaction. */
+	if (substrm->number == 0) {
+		if (up)
+			dg00x->in_control = substrm;
+		else
+			dg00x->in_control = NULL;
+	} else {
+		if (up)
+			amdtp_dot_midi_trigger(&dg00x->tx_stream,
+					       substrm->number - 1, substrm);
+		else
+			amdtp_dot_midi_trigger(&dg00x->tx_stream,
+					       substrm->number - 1, NULL);
+	}
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
@@ -64,12 +80,19 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
-	if (up)
-		amdtp_dot_midi_trigger(&dg00x->rx_stream,
-				       substrm->number, substrm);
-	else
-		amdtp_dot_midi_trigger(&dg00x->rx_stream,
-				       substrm->number, NULL);
+	/* This port is for asynchronous transaction. */
+	if (substrm->number == 0) {
+		if (up)
+			snd_fw_async_midi_port_run(&dg00x->out_control,
+						   substrm);
+	} else {
+		if (up)
+			amdtp_dot_midi_trigger(&dg00x->rx_stream,
+					       substrm->number - 1, substrm);
+		else
+			amdtp_dot_midi_trigger(&dg00x->rx_stream,
+					       substrm->number - 1, NULL);
+	}
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
@@ -92,9 +115,15 @@ static void set_midi_substream_names(struct snd_dg00x *dg00x,
 	struct snd_rawmidi_substream *subs;
 
 	list_for_each_entry(subs, &str->substreams, list) {
-		snprintf(subs->name, sizeof(subs->name),
-			 "%s MIDI %d",
-			 dg00x->card->shortname, subs->number + 1);
+		if (subs->number > 0)
+			snprintf(subs->name, sizeof(subs->name),
+				 "%s MIDI %d",
+				 dg00x->card->shortname, subs->number);
+		else
+			/* This port is for asynchronous transaction. */
+			snprintf(subs->name, sizeof(subs->name),
+				 "%s control",
+				 dg00x->card->shortname);
 	}
 }
 
@@ -105,7 +134,7 @@ int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x)
 	int err;
 
 	err = snd_rawmidi_new(dg00x->card, dg00x->card->driver, 0,
-			      DOT_MIDI_OUT_PORTS, DOT_MIDI_IN_PORTS, &rmidi);
+			DOT_MIDI_OUT_PORTS + 1, DOT_MIDI_IN_PORTS + 1, &rmidi);
 	if (err < 0)
 		return err;
 
-- 
2.1.4
