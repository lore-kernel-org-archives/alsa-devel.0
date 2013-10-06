From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v4 14/15] ALSA: usb-audio: always wait in
	start_endpoints
Date: Sun,  6 Oct 2013 22:31:19 +0200
Message-ID: <1381091480-23636-15-git-send-email-eldad@fogrefinery.com>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 9739C261AA9
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2013 22:31:44 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id my13so2263267bkb.7
 for <alsa-devel@alsa-project.org>; Sun, 06 Oct 2013 13:31:44 -0700 (PDT)
In-Reply-To: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Nikolay Martynov <mar.kolya@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Start the endpoints at prepare also for capture endpoints,
since it might be needed to wait for the URBs to be unlinked.

If an implicit feedback source endpoint stops being used by its
sink endpoint, but immediately used as a data endpoint, usb_submit_urb
will return -EBUSY.

Merge two trigger cases since they are now the same.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/endpoint.c |  8 +++-----
 sound/usb/endpoint.h |  2 +-
 sound/usb/pcm.c      | 28 ++++++++++++----------------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 8379989..81056b6 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -884,18 +884,17 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
  * snd_usb_endpoint_start: start an snd_usb_endpoint
  *
  * @ep:		the endpoint to start
- * @can_sleep:	flag indicating whether the operation is executed in
- * 		non-atomic context
  *
  * A call to this function will increment the use count of the endpoint.
  * In case it is not already running, the URBs for this endpoint will be
  * submitted. Otherwise, this function does nothing.
  *
  * Must be balanced to calls of snd_usb_endpoint_stop().
+ * This operation can sleep and must not be executed in atomic context.
  *
  * Returns an error if the URB submission failed, 0 in all other cases.
  */
-int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep)
+int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
 {
 	int err;
 	unsigned int i;
@@ -909,8 +908,7 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep)
 
 	/* just to be sure */
 	deactivate_urbs(ep, false);
-	if (can_sleep)
-		wait_clear_urbs(ep);
+	wait_clear_urbs(ep);
 
 	ep->active_mask = 0;
 	ep->unlink_mask = 0;
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index 188675d..22baec8 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -19,7 +19,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 				struct snd_usb_endpoint *sync_ep,
 				struct snd_usb_substream *subs);
 
-int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep);
+int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_sync_pending_stop(struct snd_usb_endpoint *ep);
 int  snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 7ca9b47..f3d48d4 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -270,7 +270,7 @@ static int subs_set_interface(struct snd_usb_substream *subs, int ifnum,
 	return 0;
 }
 
-static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
+static int start_endpoints(struct snd_usb_substream *subs)
 {
 	int err;
 
@@ -283,7 +283,7 @@ static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 		snd_printdd(KERN_DEBUG "Starting data EP @%p\n", ep);
 
 		ep->data_subs = subs;
-		err = snd_usb_endpoint_start(ep, can_sleep);
+		err = snd_usb_endpoint_start(ep);
 		if (err < 0) {
 			clear_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags);
 			return err;
@@ -313,7 +313,7 @@ static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 		snd_printdd(KERN_DEBUG "Starting sync EP @%p\n", ep);
 
 		ep->sync_slave = subs->data_endpoint;
-		err = snd_usb_endpoint_start(ep, can_sleep);
+		err = snd_usb_endpoint_start(ep);
 		if (err < 0) {
 			clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags);
 			return err;
@@ -893,10 +893,14 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	subs->last_frame_number = 0;
 	runtime->delay = 0;
 
-	/* for playback, submit the URBs now; otherwise, the first hwptr_done
-	 * updates for all URBs would happen at the same time when starting */
-	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		ret = start_endpoints(subs, true);
+	/*
+	 * for playback, submit the URBs now; otherwise, the first hwptr_done
+	 * updates for all URBs would happen at the same time when starting.
+	 * for capture, waiting is required in case the endpoint is an implicit
+	 * feedback source and it is has just been stopped (by the playback
+	 * substream).
+	 */
+	ret = start_endpoints(subs);
 
  unlock:
 	up_read(&subs->stream->chip->shutdown_rwsem);
@@ -1660,15 +1664,11 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream,
 					     int cmd)
 {
-	int err;
 	struct snd_usb_substream *subs = substream->runtime->private_data;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		err = start_endpoints(subs, false);
-		if (err < 0)
-			return err;
-
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		subs->data_endpoint->retire_data_urb = retire_capture_urb;
 		subs->running = 1;
 		return 0;
@@ -1681,10 +1681,6 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 		subs->data_endpoint->retire_data_urb = NULL;
 		subs->running = 0;
 		return 0;
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		subs->data_endpoint->retire_data_urb = retire_capture_urb;
-		subs->running = 1;
-		return 0;
 	}
 
 	return -EINVAL;
-- 
1.8.1.5
