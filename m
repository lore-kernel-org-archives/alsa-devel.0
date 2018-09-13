From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: rawmidi: A lightweight function to
	discard pending bytes
Date: Thu, 13 Sep 2018 08:25:37 +0200
Message-ID: <20180913062537.27361-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C30A62676EB
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 08:25:39 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E6CBFAC8A
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 06:25:38 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

For discarding the pending bytes on rawmidi, we process with a loop of
snd_rawmidi_transmit() which is just a waste of CPU power.
Implement a lightweight API function to discard the pending bytes and
the proceed the ring buffer instantly, and use it instead of open
codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/rawmidi.h      |  1 +
 sound/core/rawmidi.c         | 22 ++++++++++++++++++++++
 sound/core/seq/seq_virmidi.c |  4 +---
 sound/usb/midi.c             |  3 +--
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index 6665cb29e1a2..3b5a061132b6 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -171,6 +171,7 @@ int __snd_rawmidi_transmit_peek(struct snd_rawmidi_substream *substream,
 			      unsigned char *buffer, int count);
 int __snd_rawmidi_transmit_ack(struct snd_rawmidi_substream *substream,
 			       int count);
+int snd_rawmidi_proceed(struct snd_rawmidi_substream *substream);
 
 /* main midi functions */
 
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 08d5662039e3..ee601d7f0926 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1236,6 +1236,28 @@ int snd_rawmidi_transmit(struct snd_rawmidi_substream *substream,
 }
 EXPORT_SYMBOL(snd_rawmidi_transmit);
 
+/**
+ * snd_rawmidi_proceed - Discard the all pending bytes and proceed
+ * @substream: rawmidi substream
+ *
+ * Return: the number of discarded bytes
+ */
+int snd_rawmidi_proceed(struct snd_rawmidi_substream *substream)
+{
+	struct snd_rawmidi_runtime *runtime = substream->runtime;
+	unsigned long flags;
+	int count = 0;
+
+	spin_lock_irqsave(&runtime->lock, flags);
+	if (runtime->avail < runtime->buffer_size) {
+		count = runtime->buffer_size - runtime->avail;
+		__snd_rawmidi_transmit_ack(substream, count);
+	}
+	spin_unlock_irqrestore(&runtime->lock, flags);
+	return count;
+}
+EXPORT_SYMBOL(snd_rawmidi_proceed);
+
 static long snd_rawmidi_kernel_write1(struct snd_rawmidi_substream *substream,
 				      const unsigned char __user *userbuf,
 				      const unsigned char *kernelbuf,
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index cb988efd1ed0..e5a40795914a 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -149,9 +149,7 @@ static void snd_vmidi_output_work(struct work_struct *work)
 	/* discard the outputs in dispatch mode unless subscribed */
 	if (vmidi->seq_mode == SNDRV_VIRMIDI_SEQ_DISPATCH &&
 	    !(vmidi->rdev->flags & SNDRV_VIRMIDI_SUBSCRIBE)) {
-		char buf[32];
-		while (snd_rawmidi_transmit(substream, buf, sizeof(buf)) > 0)
-			; /* ignored */
+		snd_rawmidi_proceed(substream);
 		return;
 	}
 
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index dcfc546d81b9..b737f0ec77d0 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1175,8 +1175,7 @@ static void snd_usbmidi_output_trigger(struct snd_rawmidi_substream *substream,
 		if (port->ep->umidi->disconnected) {
 			/* gobble up remaining bytes to prevent wait in
 			 * snd_rawmidi_drain_output */
-			while (!snd_rawmidi_transmit_empty(substream))
-				snd_rawmidi_transmit_ack(substream, 1);
+			snd_rawmidi_proceed(substream);
 			return;
 		}
 		tasklet_schedule(&port->ep->tasklet);
-- 
2.18.0
