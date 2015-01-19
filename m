From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/17] ALSA: line6: Drop superfluous snd_device
	for rawmidi
Date: Mon, 19 Jan 2015 16:54:38 +0100
Message-ID: <1421682891-11594-5-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 488BA2612D6
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:55:03 +0100 (CET)
In-Reply-To: <1421682891-11594-1-git-send-email-tiwai@suse.de>
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

Like the previous fix for PCM, attach the card-specific resource into
rawmidi->private_data instead of handling in a snd_device object.
This simplifies the code and structure.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/midi.c | 65 ++++++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 42 deletions(-)

diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index 2a42d533f49c..ebca5ebcfecc 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -223,28 +223,20 @@ static struct snd_rawmidi_ops line6_midi_input_ops = {
 	.trigger = line6_midi_input_trigger,
 };
 
-/*
-	Cleanup the Line6 MIDI device.
-*/
-static void line6_cleanup_midi(struct snd_rawmidi *rmidi)
-{
-}
-
 /* Create a MIDI device */
-static int snd_line6_new_midi(struct snd_line6_midi *line6midi)
+static int snd_line6_new_midi(struct usb_line6 *line6,
+			      struct snd_rawmidi **rmidi_ret)
 {
 	struct snd_rawmidi *rmidi;
 	int err;
 
-	err = snd_rawmidi_new(line6midi->line6->card, "Line6 MIDI", 0, 1, 1,
-			      &rmidi);
+	err = snd_rawmidi_new(line6->card, "Line6 MIDI", 0, 1, 1, rmidi_ret);
 	if (err < 0)
 		return err;
 
-	rmidi->private_data = line6midi;
-	rmidi->private_free = line6_cleanup_midi;
-	strcpy(rmidi->id, line6midi->line6->properties->id);
-	strcpy(rmidi->name, line6midi->line6->properties->name);
+	rmidi = *rmidi_ret;
+	strcpy(rmidi->id, line6->properties->id);
+	strcpy(rmidi->name, line6->properties->name);
 
 	rmidi->info_flags =
 	    SNDRV_RAWMIDI_INFO_OUTPUT |
@@ -258,13 +250,13 @@ static int snd_line6_new_midi(struct snd_line6_midi *line6midi)
 }
 
 /* MIDI device destructor */
-static int snd_line6_midi_free(struct snd_device *device)
+static void snd_line6_midi_free(struct snd_rawmidi *rmidi)
 {
-	struct snd_line6_midi *line6midi = device->device_data;
+	struct snd_line6_midi *line6midi = rmidi->private_data;
 
 	line6_midibuf_destroy(&line6midi->midibuf_in);
 	line6_midibuf_destroy(&line6midi->midibuf_out);
-	return 0;
+	kfree(line6midi);
 }
 
 /*
@@ -272,11 +264,8 @@ static int snd_line6_midi_free(struct snd_device *device)
 */
 int line6_init_midi(struct usb_line6 *line6)
 {
-	static struct snd_device_ops midi_ops = {
-		.dev_free = snd_line6_midi_free,
-	};
-
 	int err;
+	struct snd_rawmidi *rmidi;
 	struct snd_line6_midi *line6midi;
 
 	if (!(line6->properties->capabilities & LINE6_CAP_CONTROL)) {
@@ -284,39 +273,31 @@ int line6_init_midi(struct usb_line6 *line6)
 		return 0;
 	}
 
-	line6midi = kzalloc(sizeof(struct snd_line6_midi), GFP_KERNEL);
+	err = snd_line6_new_midi(line6, &rmidi);
+	if (err < 0)
+		return err;
 
-	if (line6midi == NULL)
+	line6midi = kzalloc(sizeof(struct snd_line6_midi), GFP_KERNEL);
+	if (!line6midi)
 		return -ENOMEM;
 
-	err = line6_midibuf_init(&line6midi->midibuf_in, MIDI_BUFFER_SIZE, 0);
-	if (err < 0) {
-		kfree(line6midi);
-		return err;
-	}
-
-	err = line6_midibuf_init(&line6midi->midibuf_out, MIDI_BUFFER_SIZE, 1);
-	if (err < 0) {
-		kfree(line6midi->midibuf_in.buf);
-		kfree(line6midi);
-		return err;
-	}
+	rmidi->private_data = line6midi;
+	rmidi->private_free = snd_line6_midi_free;
 
+	init_waitqueue_head(&line6midi->send_wait);
+	spin_lock_init(&line6midi->send_urb_lock);
+	spin_lock_init(&line6midi->midi_transmit_lock);
 	line6midi->line6 = line6;
-	line6->line6midi = line6midi;
 
-	err = snd_device_new(line6->card, SNDRV_DEV_RAWMIDI, line6midi,
-			     &midi_ops);
+	err = line6_midibuf_init(&line6midi->midibuf_in, MIDI_BUFFER_SIZE, 0);
 	if (err < 0)
 		return err;
 
-	err = snd_line6_new_midi(line6midi);
+	err = line6_midibuf_init(&line6midi->midibuf_out, MIDI_BUFFER_SIZE, 1);
 	if (err < 0)
 		return err;
 
-	init_waitqueue_head(&line6midi->send_wait);
-	spin_lock_init(&line6midi->send_urb_lock);
-	spin_lock_init(&line6midi->midi_transmit_lock);
+	line6->line6midi = line6midi;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(line6_init_midi);
-- 
2.2.1
