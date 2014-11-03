From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: usb-audio: Pass direct struct
	pointer instead of list_head
Date: Mon,  3 Nov 2014 14:02:05 +0100
Message-ID: <1415019726-25710-3-git-send-email-tiwai@suse.de>
References: <1415019726-25710-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 91D85260488
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 14:02:08 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 62009ACDE
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 13:02:08 +0000 (UTC)
In-Reply-To: <1415019726-25710-1-git-send-email-tiwai@suse.de>
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

Some functions in mixer.c and endpoint.c receive list_head instead of
the object itself.  This is not obvious and rather error-prone.  Let's
pass the proper object directly instead.

The functions in midi.c still receive list_head and this can't be
changed since the object definition isn't exposed to the outside of
midi.c, so left as is.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c     | 20 ++++++++++----------
 sound/usb/endpoint.c |  7 ++-----
 sound/usb/endpoint.h |  2 +-
 sound/usb/mixer.c    |  5 +----
 sound/usb/mixer.h    |  2 +-
 5 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index be16bdc53c2a..fa6c0972aa23 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -114,13 +114,11 @@ static struct usb_driver usb_audio_driver;
  * disconnect streams
  * called from usb_audio_disconnect()
  */
-static void snd_usb_stream_disconnect(struct list_head *head)
+static void snd_usb_stream_disconnect(struct snd_usb_stream *as)
 {
 	int idx;
-	struct snd_usb_stream *as;
 	struct snd_usb_substream *subs;
 
-	as = list_entry(head, struct snd_usb_stream, list);
 	for (idx = 0; idx < 2; idx++) {
 		subs = &as->substream[idx];
 		if (!subs->num_formats)
@@ -307,10 +305,10 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 
 static int snd_usb_audio_free(struct snd_usb_audio *chip)
 {
-	struct list_head *p, *n;
+	struct snd_usb_endpoint *ep, *n;
 
-	list_for_each_safe(p, n, &chip->ep_list)
-		snd_usb_endpoint_free(p);
+	list_for_each_entry_safe(ep, n, &chip->ep_list, list)
+		snd_usb_endpoint_free(ep);
 
 	mutex_destroy(&chip->mutex);
 	kfree(chip);
@@ -609,12 +607,14 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 	mutex_lock(&register_mutex);
 	chip->num_interfaces--;
 	if (chip->num_interfaces <= 0) {
+		struct snd_usb_stream *as;
 		struct snd_usb_endpoint *ep;
+		struct usb_mixer_interface *mixer;
 
 		snd_card_disconnect(card);
 		/* release the pcm resources */
-		list_for_each(p, &chip->pcm_list) {
-			snd_usb_stream_disconnect(p);
+		list_for_each_entry(as, &chip->pcm_list, list) {
+			snd_usb_stream_disconnect(as);
 		}
 		/* release the endpoint resources */
 		list_for_each_entry(ep, &chip->ep_list, list) {
@@ -625,8 +625,8 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 			snd_usbmidi_disconnect(p);
 		}
 		/* release mixer resources */
-		list_for_each(p, &chip->mixer_list) {
-			snd_usb_mixer_disconnect(p);
+		list_for_each_entry(mixer, &chip->mixer_list, list) {
+			snd_usb_mixer_disconnect(mixer);
 		}
 		usb_chip[chip->index] = NULL;
 		mutex_unlock(&register_mutex);
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 114e3e7ff511..167d0c1643e1 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1002,15 +1002,12 @@ void snd_usb_endpoint_release(struct snd_usb_endpoint *ep)
 /**
  * snd_usb_endpoint_free: Free the resources of an snd_usb_endpoint
  *
- * @ep: the list header of the endpoint to free
+ * @ep: the endpoint to free
  *
  * This free all resources of the given ep.
  */
-void snd_usb_endpoint_free(struct list_head *head)
+void snd_usb_endpoint_free(struct snd_usb_endpoint *ep)
 {
-	struct snd_usb_endpoint *ep;
-
-	ep = list_entry(head, struct snd_usb_endpoint, list);
 	kfree(ep);
 }
 
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index e61ee5c356a3..6428392d8f62 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -24,7 +24,7 @@ void snd_usb_endpoint_sync_pending_stop(struct snd_usb_endpoint *ep);
 int  snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_release(struct snd_usb_endpoint *ep);
-void snd_usb_endpoint_free(struct list_head *head);
+void snd_usb_endpoint_free(struct snd_usb_endpoint *ep);
 
 int snd_usb_endpoint_implicit_feedback_sink(struct snd_usb_endpoint *ep);
 int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep);
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 63a8adb1705e..e4aaa21baed2 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2483,11 +2483,8 @@ _error:
 	return err;
 }
 
-void snd_usb_mixer_disconnect(struct list_head *p)
+void snd_usb_mixer_disconnect(struct usb_mixer_interface *mixer)
 {
-	struct usb_mixer_interface *mixer;
-
-	mixer = list_entry(p, struct usb_mixer_interface, list);
 	usb_kill_urb(mixer->urb);
 	usb_kill_urb(mixer->rc_urb);
 }
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 73b1f649447b..2c7b9c9c2aa6 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -57,7 +57,7 @@ struct usb_mixer_elem_info {
 
 int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 			 int ignore_error);
-void snd_usb_mixer_disconnect(struct list_head *p);
+void snd_usb_mixer_disconnect(struct usb_mixer_interface *mixer);
 
 void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid);
 
-- 
2.1.3
