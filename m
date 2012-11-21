From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: usb-audio: stop both data and sync
	endpoints asynchronously
Date: Wed, 21 Nov 2012 17:04:38 +0100
Message-ID: <1353513879-401-5-git-send-email-tiwai@suse.de>
References: <1353513879-401-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CAB8265D74
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 17:04:47 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id BD487A3B06
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

As we are stopping the endpoints asynchronously now, it's better to
trigger the stop of both data and sync endpoints and wait for pending
stopping operations, instead of the sequential trigger-and-wait
procedure.

So the wait argument in snd_usb_endpoint_stop() is dropped, and it's
expected that the caller synchronizes explicitly by calling
snd_usb_endpoint_sync_pending_stop().  (Actually there is only one
place calling this, so it was safe to change.)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/endpoint.c | 11 +++++------
 sound/usb/endpoint.h |  2 +-
 sound/usb/pcm.c      |  9 +++++++--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 6db2143..f487d26 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -896,8 +896,11 @@ __error:
  * actually be deactivated.
  *
  * Must be balanced to calls of snd_usb_endpoint_start().
+ *
+ * The caller needs to synchronize the pending stop operation via
+ * snd_usb_endpoint_sync_pending_stop().
  */
-void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool wait)
+void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep)
 {
 	if (!ep)
 		return;
@@ -911,11 +914,7 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool wait)
 		ep->sync_slave = NULL;
 		ep->retire_data_urb = NULL;
 		ep->prepare_data_urb = NULL;
-
-		if (wait)
-			wait_clear_urbs(ep);
-		else
-			set_bit(EP_FLAG_STOPPING, &ep->flags);
+		set_bit(EP_FLAG_STOPPING, &ep->flags);
 	}
 }
 
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index f1e451d..447902d 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -17,7 +17,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 				struct snd_usb_endpoint *sync_ep);
 
 int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep);
-void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool wait);
+void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_sync_pending_stop(struct snd_usb_endpoint *ep);
 int  snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
 int  snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep);
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index d90604a..4750d3d 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -266,10 +266,15 @@ static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 static void stop_endpoints(struct snd_usb_substream *subs, bool wait)
 {
 	if (test_and_clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags))
-		snd_usb_endpoint_stop(subs->sync_endpoint, wait);
+		snd_usb_endpoint_stop(subs->sync_endpoint);
 
 	if (test_and_clear_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags))
-		snd_usb_endpoint_stop(subs->data_endpoint, wait);
+		snd_usb_endpoint_stop(subs->data_endpoint);
+
+	if (wait) {
+		snd_usb_endpoint_sync_pending_stop(subs->sync_endpoint);
+		snd_usb_endpoint_sync_pending_stop(subs->data_endpoint);
+	}
 }
 
 static int deactivate_endpoints(struct snd_usb_substream *subs)
-- 
1.8.0
