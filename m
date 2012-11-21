From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: usb-audio: simplify endpoint
	deactivation code
Date: Wed, 21 Nov 2012 17:04:37 +0100
Message-ID: <1353513879-401-4-git-send-email-tiwai@suse.de>
References: <1353513879-401-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A0B1B265D7F
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 17:04:47 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id BD1DBA3A49
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 17:04:46 +0100 (CET)
In-Reply-To: <1353513879-401-1-git-send-email-tiwai@suse.de>
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

For further code simplification, drop the conditional call for
usb_kill_urb() with can_wait argument in deactivate_urbs(), and use
only usb_unlink_urb() and wait_clear_urbs() pairs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/endpoint.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 4d50bbe..6db2143 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -515,33 +515,24 @@ void snd_usb_endpoint_sync_pending_stop(struct snd_usb_endpoint *ep)
 /*
  * unlink active urbs.
  */
-static int deactivate_urbs(struct snd_usb_endpoint *ep, bool force, bool can_sleep)
+static int deactivate_urbs(struct snd_usb_endpoint *ep, bool force)
 {
 	unsigned int i;
-	int async;
 
 	if (!force && ep->chip->shutdown) /* to be sure... */
 		return -EBADFD;
 
-	async = !can_sleep;
-
 	clear_bit(EP_FLAG_RUNNING, &ep->flags);
 
 	INIT_LIST_HEAD(&ep->ready_playback_urbs);
 	ep->next_packet_read_pos = 0;
 	ep->next_packet_write_pos = 0;
 
-	if (!async && in_interrupt())
-		return 0;
-
 	for (i = 0; i < ep->nurbs; i++) {
 		if (test_bit(i, &ep->active_mask)) {
 			if (!test_and_set_bit(i, &ep->unlink_mask)) {
 				struct urb *u = ep->urb[i].urb;
-				if (async)
-					usb_unlink_urb(u);
-				else
-					usb_kill_urb(u);
+				usb_unlink_urb(u);
 			}
 		}
 	}
@@ -561,7 +552,7 @@ static void release_urbs(struct snd_usb_endpoint *ep, int force)
 	ep->prepare_data_urb = NULL;
 
 	/* stop urbs */
-	deactivate_urbs(ep, force, true);
+	deactivate_urbs(ep, force);
 	wait_clear_urbs(ep);
 
 	for (i = 0; i < ep->nurbs; i++)
@@ -837,7 +828,7 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep)
 		return 0;
 
 	/* just to be sure */
-	deactivate_urbs(ep, false, can_sleep);
+	deactivate_urbs(ep, false);
 	if (can_sleep)
 		wait_clear_urbs(ep);
 
@@ -891,7 +882,7 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep)
 __error:
 	clear_bit(EP_FLAG_RUNNING, &ep->flags);
 	ep->use_count--;
-	deactivate_urbs(ep, false, false);
+	deactivate_urbs(ep, false);
 	return -EPIPE;
 }
 
@@ -915,7 +906,7 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool wait)
 		return;
 
 	if (--ep->use_count == 0) {
-		deactivate_urbs(ep, false, wait);
+		deactivate_urbs(ep, false);
 		ep->data_subs = NULL;
 		ep->sync_slave = NULL;
 		ep->retire_data_urb = NULL;
@@ -946,7 +937,7 @@ int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
 	if (!ep)
 		return -EINVAL;
 
-	deactivate_urbs(ep, true, true);
+	deactivate_urbs(ep, true);
 	wait_clear_urbs(ep);
 
 	if (ep->use_count != 0)
-- 
1.8.0
