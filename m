From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: usb-audio: simplify
	snd_usb_endpoint_start/stop arguments
Date: Wed, 21 Nov 2012 17:04:36 +0100
Message-ID: <1353513879-401-3-git-send-email-tiwai@suse.de>
References: <1353513879-401-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A3BBB265D8E
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 17:04:47 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id BD654A3B99
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

Reduce the redundant arguments for snd_usb_endpoint_start() and
snd_usb_endpoint_stop().  Also replaced from int to bool.

No functional changes by this commit.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/endpoint.c | 17 ++++++++---------
 sound/usb/endpoint.h |  5 ++---
 sound/usb/pcm.c      | 25 +++++++++++--------------
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index d7382a5..4d50bbe 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -515,7 +515,7 @@ void snd_usb_endpoint_sync_pending_stop(struct snd_usb_endpoint *ep)
 /*
  * unlink active urbs.
  */
-static int deactivate_urbs(struct snd_usb_endpoint *ep, int force, int can_sleep)
+static int deactivate_urbs(struct snd_usb_endpoint *ep, bool force, bool can_sleep)
 {
 	unsigned int i;
 	int async;
@@ -561,7 +561,7 @@ static void release_urbs(struct snd_usb_endpoint *ep, int force)
 	ep->prepare_data_urb = NULL;
 
 	/* stop urbs */
-	deactivate_urbs(ep, force, 1);
+	deactivate_urbs(ep, force, true);
 	wait_clear_urbs(ep);
 
 	for (i = 0; i < ep->nurbs; i++)
@@ -824,7 +824,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
  *
  * Returns an error if the URB submission failed, 0 in all other cases.
  */
-int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, int can_sleep)
+int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep)
 {
 	int err;
 	unsigned int i;
@@ -837,7 +837,7 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, int can_sleep)
 		return 0;
 
 	/* just to be sure */
-	deactivate_urbs(ep, 0, can_sleep);
+	deactivate_urbs(ep, false, can_sleep);
 	if (can_sleep)
 		wait_clear_urbs(ep);
 
@@ -891,7 +891,7 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, int can_sleep)
 __error:
 	clear_bit(EP_FLAG_RUNNING, &ep->flags);
 	ep->use_count--;
-	deactivate_urbs(ep, 0, 0);
+	deactivate_urbs(ep, false, false);
 	return -EPIPE;
 }
 
@@ -906,8 +906,7 @@ __error:
  *
  * Must be balanced to calls of snd_usb_endpoint_start().
  */
-void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
-			   int force, int can_sleep, int wait)
+void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool wait)
 {
 	if (!ep)
 		return;
@@ -916,7 +915,7 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
 		return;
 
 	if (--ep->use_count == 0) {
-		deactivate_urbs(ep, force, can_sleep);
+		deactivate_urbs(ep, false, wait);
 		ep->data_subs = NULL;
 		ep->sync_slave = NULL;
 		ep->retire_data_urb = NULL;
@@ -947,7 +946,7 @@ int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
 	if (!ep)
 		return -EINVAL;
 
-	deactivate_urbs(ep, 1, 1);
+	deactivate_urbs(ep, true, true);
 	wait_clear_urbs(ep);
 
 	if (ep->use_count != 0)
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index 3d4c970..f1e451d 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -16,9 +16,8 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 				struct audioformat *fmt,
 				struct snd_usb_endpoint *sync_ep);
 
-int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep, int can_sleep);
-void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
-			   int force, int can_sleep, int wait);
+int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep);
+void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool wait);
 void snd_usb_endpoint_sync_pending_stop(struct snd_usb_endpoint *ep);
 int  snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
 int  snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep);
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index e7329d0..d90604a 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -211,7 +211,7 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 	}
 }
 
-static int start_endpoints(struct snd_usb_substream *subs, int can_sleep)
+static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 {
 	int err;
 
@@ -263,16 +263,13 @@ static int start_endpoints(struct snd_usb_substream *subs, int can_sleep)
 	return 0;
 }
 
-static void stop_endpoints(struct snd_usb_substream *subs,
-			   int force, int can_sleep, int wait)
+static void stop_endpoints(struct snd_usb_substream *subs, bool wait)
 {
 	if (test_and_clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags))
-		snd_usb_endpoint_stop(subs->sync_endpoint,
-				      force, can_sleep, wait);
+		snd_usb_endpoint_stop(subs->sync_endpoint, wait);
 
 	if (test_and_clear_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags))
-		snd_usb_endpoint_stop(subs->data_endpoint,
-				      force, can_sleep, wait);
+		snd_usb_endpoint_stop(subs->data_endpoint, wait);
 }
 
 static int deactivate_endpoints(struct snd_usb_substream *subs)
@@ -444,7 +441,7 @@ static int configure_endpoint(struct snd_usb_substream *subs)
 	int ret;
 
 	/* format changed */
-	stop_endpoints(subs, 0, 0, 0);
+	stop_endpoints(subs, false);
 	ret = snd_usb_endpoint_set_params(subs->data_endpoint,
 					  subs->pcm_format,
 					  subs->channels,
@@ -530,7 +527,7 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 	subs->period_bytes = 0;
 	down_read(&subs->stream->chip->shutdown_rwsem);
 	if (!subs->stream->chip->shutdown) {
-		stop_endpoints(subs, 0, 1, 1);
+		stop_endpoints(subs, true);
 		deactivate_endpoints(subs);
 	}
 	up_read(&subs->stream->chip->shutdown_rwsem);
@@ -605,7 +602,7 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	/* for playback, submit the URBs now; otherwise, the first hwptr_done
 	 * updates for all URBs would happen at the same time when starting */
 	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		ret = start_endpoints(subs, 1);
+		ret = start_endpoints(subs, true);
 
  unlock:
 	up_read(&subs->stream->chip->shutdown_rwsem);
@@ -1010,7 +1007,7 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
 	struct snd_usb_substream *subs = &as->substream[direction];
 
-	stop_endpoints(subs, 0, 0, 0);
+	stop_endpoints(subs, false);
 
 	if (!as->chip->shutdown && subs->interface >= 0) {
 		usb_set_interface(subs->dev, subs->interface, 0);
@@ -1245,7 +1242,7 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
-		stop_endpoints(subs, 0, 0, 0);
+		stop_endpoints(subs, false);
 		subs->running = 0;
 		return 0;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
@@ -1266,7 +1263,7 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		err = start_endpoints(subs, 0);
+		err = start_endpoints(subs, false);
 		if (err < 0)
 			return err;
 
@@ -1274,7 +1271,7 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
-		stop_endpoints(subs, 0, 0, 0);
+		stop_endpoints(subs, false);
 		subs->running = 0;
 		return 0;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-- 
1.8.0
