From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] ALSA: firewire-digi00x: rename identifiers
	of MIDI operation for physical ports
Date: Sat, 31 Oct 2015 02:43:14 +0900
Message-ID: <1446226996-2299-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1446226996-2299-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BC48260663
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

In following commit, new functions and variables are added for operations
of MIDI control port.

This commit is a preparation. Current identifiers are renamed so that they
mean physical MIDI ports.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-midi.c | 52 +++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
index 9aa8b46..1d649e3 100644
--- a/sound/firewire/digi00x/digi00x-midi.c
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -8,7 +8,7 @@
 
 #include "digi00x.h"
 
-static int midi_open(struct snd_rawmidi_substream *substream)
+static int midi_phys_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 	int err;
@@ -31,7 +31,7 @@ static int midi_open(struct snd_rawmidi_substream *substream)
 	return err;
 }
 
-static int midi_close(struct snd_rawmidi_substream *substream)
+static int midi_phys_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 
@@ -48,65 +48,69 @@ static int midi_close(struct snd_rawmidi_substream *substream)
 	return 0;
 }
 
-static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
+static void midi_phys_capture_trigger(struct snd_rawmidi_substream *substream,
+				      int up)
 {
-	struct snd_dg00x *dg00x = substrm->rmidi->private_data;
+	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
 	/* This port is for asynchronous transaction. */
-	if (substrm->number == 0) {
+	if (substream->number == 0) {
 		if (up)
-			dg00x->in_control = substrm;
+			dg00x->in_control = substream;
 		else
 			dg00x->in_control = NULL;
 	} else {
 		if (up)
 			amdtp_dot_midi_trigger(&dg00x->tx_stream,
-					       substrm->number - 1, substrm);
+					       substream->number - 1,
+					       substream);
 		else
 			amdtp_dot_midi_trigger(&dg00x->tx_stream,
-					       substrm->number - 1, NULL);
+					       substream->number - 1, NULL);
 	}
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
 
-static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
+static void midi_phys_playback_trigger(struct snd_rawmidi_substream *substream,
+				       int up)
 {
-	struct snd_dg00x *dg00x = substrm->rmidi->private_data;
+	struct snd_dg00x *dg00x = substream->rmidi->private_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&dg00x->lock, flags);
 
 	/* This port is for asynchronous transaction. */
-	if (substrm->number == 0) {
+	if (substream->number == 0) {
 		if (up)
 			snd_fw_async_midi_port_run(&dg00x->out_control,
-						   substrm);
+						   substream);
 	} else {
 		if (up)
 			amdtp_dot_midi_trigger(&dg00x->rx_stream,
-					       substrm->number - 1, substrm);
+					       substream->number - 1,
+					       substream);
 		else
 			amdtp_dot_midi_trigger(&dg00x->rx_stream,
-					       substrm->number - 1, NULL);
+					       substream->number - 1, NULL);
 	}
 
 	spin_unlock_irqrestore(&dg00x->lock, flags);
 }
 
-static struct snd_rawmidi_ops midi_capture_ops = {
-	.open		= midi_open,
-	.close		= midi_close,
-	.trigger	= midi_capture_trigger,
+static struct snd_rawmidi_ops midi_phys_capture_ops = {
+	.open		= midi_phys_open,
+	.close		= midi_phys_close,
+	.trigger	= midi_phys_capture_trigger,
 };
 
-static struct snd_rawmidi_ops midi_playback_ops = {
-	.open		= midi_open,
-	.close		= midi_close,
-	.trigger	= midi_playback_trigger,
+static struct snd_rawmidi_ops midi_phys_playback_ops = {
+	.open		= midi_phys_open,
+	.close		= midi_phys_close,
+	.trigger	= midi_phys_playback_trigger,
 };
 
 static void set_midi_substream_names(struct snd_dg00x *dg00x,
@@ -144,13 +148,13 @@ int snd_dg00x_create_midi_devices(struct snd_dg00x *dg00x)
 
 	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
-			    &midi_capture_ops);
+			    &midi_phys_capture_ops);
 	str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
 	set_midi_substream_names(dg00x, str);
 
 	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
-			    &midi_playback_ops);
+			    &midi_phys_playback_ops);
 	str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
 	set_midi_substream_names(dg00x, str);
 
-- 
2.1.4
