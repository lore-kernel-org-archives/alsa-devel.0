From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCHv2 04/10] ALSA: usb-audio: spelling correction
Date: Wed,  3 Apr 2013 23:18:52 +0200
Message-ID: <1365023938-1461-5-git-send-email-eldad@fogrefinery.com>
References: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id BD5A1261599
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 23:19:18 +0200 (CEST)
Received: by mail-bk0-f45.google.com with SMTP id j10so1104965bkw.32
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 14:19:18 -0700 (PDT)
In-Reply-To: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Torstein Hegge <hegge@resisty.net>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Correct spelling of snd_usb_endpoint_implict_feedback_sink in all
occurances.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/endpoint.c | 14 +++++++-------
 sound/usb/endpoint.h |  2 +-
 sound/usb/pcm.c      |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index b1f687f..7e9c55a 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -128,7 +128,7 @@ static const char *usb_error_string(int err)
  * Determine whether an endpoint is driven by an implicit feedback
  * data endpoint source.
  */
-int snd_usb_endpoint_implict_feedback_sink(struct snd_usb_endpoint *ep)
+int snd_usb_endpoint_implicit_feedback_sink(struct snd_usb_endpoint *ep)
 {
 	return  ep->sync_master &&
 		ep->sync_master->type == SND_USB_ENDPOINT_TYPE_DATA &&
@@ -363,7 +363,7 @@ static void snd_complete_urb(struct urb *urb)
 		if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep->flags)))
 			goto exit_clear;
 
-		if (snd_usb_endpoint_implict_feedback_sink(ep)) {
+		if (snd_usb_endpoint_implicit_feedback_sink(ep)) {
 			unsigned long flags;
 
 			spin_lock_irqsave(&ep->lock, flags);
@@ -605,7 +605,7 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 	else
 		packs_per_ms = 1;
 
-	if (is_playback && !snd_usb_endpoint_implict_feedback_sink(ep)) {
+	if (is_playback && !snd_usb_endpoint_implicit_feedback_sink(ep)) {
 		urb_packs = max(ep->chip->nrpacks, 1);
 		urb_packs = min(urb_packs, (unsigned int) MAX_PACKS);
 	} else {
@@ -614,11 +614,11 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 
 	urb_packs *= packs_per_ms;
 
-	if (sync_ep && !snd_usb_endpoint_implict_feedback_sink(ep))
+	if (sync_ep && !snd_usb_endpoint_implicit_feedback_sink(ep))
 		urb_packs = min(urb_packs, 1U << sync_ep->syncinterval);
 
 	/* decide how many packets to be used */
-	if (is_playback && !snd_usb_endpoint_implict_feedback_sink(ep)) {
+	if (is_playback && !snd_usb_endpoint_implicit_feedback_sink(ep)) {
 		unsigned int minsize, maxpacks;
 		/* determine how small a packet can be */
 		minsize = (ep->freqn >> (16 - ep->datainterval))
@@ -845,7 +845,7 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep)
 
 	set_bit(EP_FLAG_RUNNING, &ep->flags);
 
-	if (snd_usb_endpoint_implict_feedback_sink(ep)) {
+	if (snd_usb_endpoint_implicit_feedback_sink(ep)) {
 		for (i = 0; i < ep->nurbs; i++) {
 			struct snd_urb_ctx *ctx = ep->urb + i;
 			list_add_tail(&ctx->ready_list, &ep->ready_playback_urbs);
@@ -988,7 +988,7 @@ void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 	 * and add it to the list of pending urbs. queue_pending_output_urbs()
 	 * will take care of them later.
 	 */
-	if (snd_usb_endpoint_implict_feedback_sink(ep) &&
+	if (snd_usb_endpoint_implicit_feedback_sink(ep) &&
 	    ep->use_count != 0) {
 
 		/* implicit feedback case */
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index 447902d..2287adf 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -23,7 +23,7 @@ int  snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
 int  snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_free(struct list_head *head);
 
-int snd_usb_endpoint_implict_feedback_sink(struct snd_usb_endpoint *ep);
+int snd_usb_endpoint_implicit_feedback_sink(struct snd_usb_endpoint *ep);
 int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep);
 
 void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 652724c..754cb5b 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1271,7 +1271,7 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 			}
 		}
 		if (period_elapsed &&
-		    !snd_usb_endpoint_implict_feedback_sink(subs->data_endpoint)) /* finish at the period boundary */
+		    !snd_usb_endpoint_implicit_feedback_sink(subs->data_endpoint)) /* finish at the period boundary */
 			break;
 	}
 	bytes = frames * stride;
-- 
1.8.1.5
