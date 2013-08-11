From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH 2/2] 6fire: make buffers DMA-able (midi)
Date: Sun, 11 Aug 2013 11:11:35 +0200
Message-ID: <20130811111135.1b75074b7b9c83c711f5ae74@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D690261688
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 11:11:39 +0200 (CEST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Patch makes midi output buffer DMA-able by allocating it separately.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>
---
diff -Nur a/sound/6fire/midi.c b/sound/6fire/midi.c
--- a/sound/6fire/midi.c	2013-08-04 22:46:46.000000000 +0200
+++ b/sound/6fire/midi.c	2013-08-11 10:51:05.682482388 +0200
@@ -19,6 +19,10 @@
 #include "chip.h"
 #include "comm.h"
 
+enum {
+	MIDI_BUFSIZE = 64
+};
+
 static void usb6fire_midi_out_handler(struct urb *urb)
 {
 	struct midi_runtime *rt = urb->context;
@@ -156,6 +160,12 @@
 	if (!rt)
 		return -ENOMEM;
 
+	rt->out_buffer = kzalloc(MIDI_BUFSIZE, GFP_KERNEL);
+	if (!rt->out_buffer) {
+		kfree(rt);
+		return -ENOMEM;
+	}
+
 	rt->chip = chip;
 	rt->in_received = usb6fire_midi_in_received;
 	rt->out_buffer[0] = 0x80; /* 'send midi' command */
@@ -169,6 +179,7 @@
 
 	ret = snd_rawmidi_new(chip->card, "6FireUSB", 0, 1, 1, &rt->instance);
 	if (ret < 0) {
+		kfree(rt->out_buffer);
 		kfree(rt);
 		snd_printk(KERN_ERR PREFIX "unable to create midi.\n");
 		return ret;
@@ -197,6 +208,9 @@
 
 void usb6fire_midi_destroy(struct sfire_chip *chip)
 {
-	kfree(chip->midi);
+	struct midi_runtime *rt = chip->midi;
+
+	kfree(rt->out_buffer);
+	kfree(rt);
 	chip->midi = NULL;
 }
diff -Nur a/sound/6fire/midi.h b/sound/6fire/midi.h
--- a/sound/6fire/midi.h	2013-08-04 22:46:46.000000000 +0200
+++ b/sound/6fire/midi.h	2013-08-11 10:51:05.682482388 +0200
@@ -16,10 +16,6 @@
 
 #include "common.h"
 
-enum {
-	MIDI_BUFSIZE = 64
-};
-
 struct midi_runtime {
 	struct sfire_chip *chip;
 	struct snd_rawmidi *instance;
@@ -32,7 +28,7 @@
 	struct snd_rawmidi_substream *out;
 	struct urb out_urb;
 	u8 out_serial; /* serial number of out packet */
-	u8 out_buffer[MIDI_BUFSIZE];
+	u8 *out_buffer;
 	int buffer_offset;
 
 	void (*in_received)(struct midi_runtime *rt, u8 *data, int length);
