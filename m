From: Adam Goode <agoode@google.com>
Subject: [PATCH - sound/usb 1/1] Respond to suspend and resume
	callbacks for input in sound/usb/midi.c
Date: Tue,  5 Aug 2014 08:20:30 -0400
Message-ID: <1407241230-486-1-git-send-email-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f50.google.com (mail-yh0-f50.google.com
 [209.85.213.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 46EAA2625EA
 for <alsa-devel@alsa-project.org>; Tue,  5 Aug 2014 14:20:50 +0200 (CEST)
Received: by mail-yh0-f50.google.com with SMTP id v1so565920yhn.9
 for <alsa-devel@alsa-project.org>; Tue, 05 Aug 2014 05:20:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adam Goode <agoode@google.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sound/usb/card.c registers USB suspend and resume but did not previously
kill the input URBs. This means that USB MIDI devices left open across
suspend/resume had non-functional input (output still usually worked,
but it looks like that is another issue). Before this change, we would
get ESHUTDOWN for each of the input URBs at suspend time, killing input.

Signed-off-by: Adam Goode <agoode@google.com>

diff --git a/sound/usb/card.c b/sound/usb/card.c
index a09e5f3..7ecd0e8 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -680,6 +680,7 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
 	struct snd_usb_stream *as;
 	struct usb_mixer_interface *mixer;
+	struct list_head *p;
 
 	if (chip == (void *)-1L)
 		return 0;
@@ -692,6 +693,9 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 				as->substream[0].need_setup_ep =
 					as->substream[1].need_setup_ep = true;
 			}
+			list_for_each(p, &chip->midi_list) {
+				snd_usbmidi_suspend(p);
+			}
 		}
 	} else {
 		/*
@@ -713,6 +717,7 @@ static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
 {
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
 	struct usb_mixer_interface *mixer;
+	struct list_head *p;
 	int err = 0;
 
 	if (chip == (void *)-1L)
@@ -731,6 +736,10 @@ static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
 			goto err_out;
 	}
 
+	list_for_each(p, &chip->midi_list) {
+		snd_usbmidi_resume(p);
+	}
+
 	if (!chip->autosuspended)
 		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
 	chip->autosuspended = 0;
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 9da74d2..e7c6c9d 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2187,6 +2187,34 @@ void snd_usbmidi_input_start(struct list_head* p)
 EXPORT_SYMBOL(snd_usbmidi_input_start);
 
 /*
+ * Prepare for suspend. Typically called from the USB suspend callback.
+ */
+void snd_usbmidi_suspend(struct list_head* p)
+{
+	struct snd_usb_midi* umidi;
+
+	umidi = list_entry(p, struct snd_usb_midi, list);
+	mutex_lock(&umidi->mutex);
+	snd_usbmidi_input_stop(p);
+	mutex_unlock(&umidi->mutex);
+}
+EXPORT_SYMBOL(snd_usbmidi_suspend);
+
+/*
+ * Resume. Typically called from the USB resume callback.
+ */
+void snd_usbmidi_resume(struct list_head* p)
+{
+	struct snd_usb_midi* umidi;
+
+	umidi = list_entry(p, struct snd_usb_midi, list);
+	mutex_lock(&umidi->mutex);
+	snd_usbmidi_input_start(p);
+	mutex_unlock(&umidi->mutex);
+}
+EXPORT_SYMBOL(snd_usbmidi_resume);
+
+/*
  * Creates and registers everything needed for a MIDI streaming interface.
  */
 int snd_usbmidi_create(struct snd_card *card,
diff --git a/sound/usb/midi.h b/sound/usb/midi.h
index 2fca80b..46e5b65 100644
--- a/sound/usb/midi.h
+++ b/sound/usb/midi.h
@@ -46,5 +46,7 @@ int snd_usbmidi_create(struct snd_card *card,
 void snd_usbmidi_input_stop(struct list_head* p);
 void snd_usbmidi_input_start(struct list_head* p);
 void snd_usbmidi_disconnect(struct list_head *p);
+void snd_usbmidi_suspend(struct list_head *p);
+void snd_usbmidi_resume(struct list_head *p);
 
 #endif /* __USBMIDI_H */
-- 
2.0.0.526.g5318336
