From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/16] ALSA: line6: Reduce superfluous spinlock
	in midi.c
Date: Fri, 23 Jan 2015 18:13:11 +0100
Message-ID: <1422033203-23254-5-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F47B2654CC
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:40 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

The midi_transmit_lock is used always inside the send_urb_lock, thus
it doesn't play any role.  Let's kill it.  Also, rename
"send_urb_lock" as a more simple name "lock" since this is the only
lock for midi.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/midi.c | 18 ++++++------------
 sound/usb/line6/midi.h |  7 +------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index b5a58a7fe11a..beeedf9a2cbe 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -45,12 +45,9 @@ static void line6_midi_transmit(struct snd_rawmidi_substream *substream)
 	    line6_rawmidi_substream_midi(substream)->line6;
 	struct snd_line6_midi *line6midi = line6->line6midi;
 	struct midi_buffer *mb = &line6midi->midibuf_out;
-	unsigned long flags;
 	unsigned char chunk[LINE6_FALLBACK_MAXPACKETSIZE];
 	int req, done;
 
-	spin_lock_irqsave(&line6->line6midi->midi_transmit_lock, flags);
-
 	for (;;) {
 		req = min(line6_midibuf_bytes_free(mb), line6->max_packet_size);
 		done = snd_rawmidi_transmit_peek(substream, chunk, req);
@@ -71,8 +68,6 @@ static void line6_midi_transmit(struct snd_rawmidi_substream *substream)
 
 		send_midi_async(line6, chunk, done);
 	}
-
-	spin_unlock_irqrestore(&line6->line6midi->midi_transmit_lock, flags);
 }
 
 /*
@@ -92,7 +87,7 @@ static void midi_sent(struct urb *urb)
 	if (status == -ESHUTDOWN)
 		return;
 
-	spin_lock_irqsave(&line6->line6midi->send_urb_lock, flags);
+	spin_lock_irqsave(&line6->line6midi->lock, flags);
 	num = --line6->line6midi->num_active_send_urbs;
 
 	if (num == 0) {
@@ -103,12 +98,12 @@ static void midi_sent(struct urb *urb)
 	if (num == 0)
 		wake_up(&line6->line6midi->send_wait);
 
-	spin_unlock_irqrestore(&line6->line6midi->send_urb_lock, flags);
+	spin_unlock_irqrestore(&line6->line6midi->lock, flags);
 }
 
 /*
 	Send an asynchronous MIDI message.
-	Assumes that line6->line6midi->send_urb_lock is held
+	Assumes that line6->line6midi->lock is held
 	(i.e., this function is serialized).
 */
 static int send_midi_async(struct usb_line6 *line6, unsigned char *data,
@@ -166,12 +161,12 @@ static void line6_midi_output_trigger(struct snd_rawmidi_substream *substream,
 	    line6_rawmidi_substream_midi(substream)->line6;
 
 	line6->line6midi->substream_transmit = substream;
-	spin_lock_irqsave(&line6->line6midi->send_urb_lock, flags);
+	spin_lock_irqsave(&line6->line6midi->lock, flags);
 
 	if (line6->line6midi->num_active_send_urbs == 0)
 		line6_midi_transmit(substream);
 
-	spin_unlock_irqrestore(&line6->line6midi->send_urb_lock, flags);
+	spin_unlock_irqrestore(&line6->line6midi->lock, flags);
 }
 
 static void line6_midi_output_drain(struct snd_rawmidi_substream *substream)
@@ -281,8 +276,7 @@ int line6_init_midi(struct usb_line6 *line6)
 	rmidi->private_free = snd_line6_midi_free;
 
 	init_waitqueue_head(&line6midi->send_wait);
-	spin_lock_init(&line6midi->send_urb_lock);
-	spin_lock_init(&line6midi->midi_transmit_lock);
+	spin_lock_init(&line6midi->lock);
 	line6midi->line6 = line6;
 
 	err = line6_midibuf_init(&line6midi->midibuf_in, MIDI_BUFFER_SIZE, 0);
diff --git a/sound/usb/line6/midi.h b/sound/usb/line6/midi.h
index ba6bf3828aa5..9d9467b2613c 100644
--- a/sound/usb/line6/midi.h
+++ b/sound/usb/line6/midi.h
@@ -40,14 +40,9 @@ struct snd_line6_midi {
 	int num_active_send_urbs;
 
 	/**
-		 Spin lock to protect updates of send_urb.
-	*/
-	spinlock_t send_urb_lock;
-
-	/**
 		 Spin lock to protect MIDI buffer handling.
 	*/
-	spinlock_t midi_transmit_lock;
+	spinlock_t lock;
 
 	/**
 		 Wait queue for MIDI transmission.
-- 
2.2.2
