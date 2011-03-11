From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 1/2] usbaudio:fix suspend/resume
Date: Fri, 11 Mar 2011 13:19:43 +0100
Message-ID: <201103111319.43135.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

>From 0926f3aa059c42ccf096184654a9fb859c75f2e5 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Fri, 11 Mar 2011 10:07:52 +0100
Subject: [PATCH 1/2] usbaudio:fix suspend/resume

- ESHUTDOWN must be correctly handled
- the optional interrupt endpoint's URB must be stopped and restarted

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
---
 sound/usb/card.c  |   12 ++++++++++--
 sound/usb/mixer.c |   26 ++++++++++++++++++++++++--
 sound/usb/mixer.h |    2 ++
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index c0f8270..af76f97 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -586,6 +586,7 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
 	struct list_head *p;
 	struct snd_usb_stream *as;
+	struct usb_mixer_interface *mixer;
 
 	if (chip == (void *)-1L)
 		return 0;
@@ -596,6 +597,10 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 			as = list_entry(p, struct snd_usb_stream, list);
 			snd_pcm_suspend_all(as->pcm);
 		}
+
+		list_for_each_entry(mixer, &chip->mixer_list, list) {
+			snd_usb_mixer_inactivate(mixer);
+		}
 	}
 
 	return 0;
@@ -604,6 +609,7 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 static int usb_audio_resume(struct usb_interface *intf)
 {
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
+	struct usb_mixer_interface *mixer;
 
 	if (chip == (void *)-1L)
 		return 0;
@@ -611,9 +617,11 @@ static int usb_audio_resume(struct usb_interface *intf)
 		return 0;
 	/*
 	 * ALSA leaves material resumption to user space
-	 * we just notify
+	 * we just notify and restart the mixers
 	 */
-
+	list_for_each_entry(mixer, &chip->mixer_list, list)
+		snd_usb_mixer_activate(mixer);
+	
 	snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
 
 	return 0;
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 85af605..da65130 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2058,8 +2058,9 @@ static void snd_usb_mixer_interrupt(struct urb *urb)
 {
 	struct usb_mixer_interface *mixer = urb->context;
 	int len = urb->actual_length;
+	int ustatus = urb->status;
 
-	if (urb->status != 0)
+	if (ustatus != 0)
 		goto requeue;
 
 	if (mixer->protocol == UAC_VERSION_1) {
@@ -2100,12 +2101,33 @@ static void snd_usb_mixer_interrupt(struct urb *urb)
 	}
 
 requeue:
-	if (urb->status != -ENOENT && urb->status != -ECONNRESET) {
+	if (ustatus != -ENOENT && ustatus != -ECONNRESET && ustatus != -ESHUTDOWN) {
 		urb->dev = mixer->chip->dev;
 		usb_submit_urb(urb, GFP_ATOMIC);
 	}
 }
 
+/* stop any bus activity of a mixer */
+void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer)
+{
+	usb_kill_urb(mixer->urb);
+	usb_kill_urb(mixer->rc_urb);
+}
+
+ 
+int snd_usb_mixer_activate(struct usb_mixer_interface *mixer)
+{
+	int err;
+
+	if (mixer->urb) {
+		err = usb_submit_urb(mixer->urb, GFP_NOIO);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 /* create the handler for the optional status interrupt endpoint */
 static int snd_usb_mixer_status_create(struct usb_mixer_interface *mixer)
 {
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 26c636c..b4a2c81 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -52,5 +52,7 @@ void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid);
 
 int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 				int request, int validx, int value_set);
+void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer);
+int snd_usb_mixer_activate(struct usb_mixer_interface *mixer);
 
 #endif /* __USBMIXER_H */
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
