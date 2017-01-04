From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: [PATCH v3 1/2] ALSA: usb-audio: Fix irq/process data synchronization
Date: Thu,  5 Jan 2017 00:37:46 +0200
Message-ID: <20170104223747.2742-2-adi@adirat.com>
References: <20170104223747.2742-1-adi@adirat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170104223747.2742-1-adi@adirat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Commit 16200948d83 ("ALSA: usb-audio: Fix race at stopping the stream") was
incomplete causing another more severe kernel panic, so it got reverted.
This fixes both the original problem and its fallout kernel race/crash.

The original fix is to move the endpoint member NULL clearing logic inside
wait_clear_urbs() so the irq triggering the urb completion doesn't call
retire_capture/playback_urb() after the NULL clearing and generate a panic.

However this creates a new race between snd_usb_endpoint_start()'s call
to wait_clear_urbs() and the irq urb completion handler which again calls
retire_capture/playback_urb() leading to a new NULL dereference.

We keep the EP deactivation code in snd_usb_endpoint_start() because
removing it will break the EP reference counting (see [1] [2] for info),
however we don't need the "can_sleep" mechanism anymore because a new
function was introduced (snd_usb_endpoint_sync_pending_stop()) which
synchronizes pending stops and gets called inside the pcm prepare callback.

It also makes sense to remove can_sleep because it was also removed from
deactivate_urbs() signature in [3] so we benefit from more simplification.

[1] commit 015618b90 ("ALSA: snd-usb: Fix URB cancellation at stream start")
[2] commit e9ba389c5 ("ALSA: usb-audio: Fix scheduling-while-atomic bug in PCM capture stream")
[3] commit ccc1696d5 ("ALSA: usb-audio: simplify endpoint deactivation code")

Fixes: f8114f8583bb ("Revert "ALSA: usb-audio: Fix race at stopping the stream"")

Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
---
 sound/usb/endpoint.c | 17 +++++++----------
 sound/usb/endpoint.h |  2 +-
 sound/usb/pcm.c      | 10 +++++-----
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 15d1d5c63c3c..2f0ea70a998c 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -534,6 +534,11 @@ static int wait_clear_urbs(struct snd_usb_endpoint *ep)
 			alive, ep->ep_num);
 	clear_bit(EP_FLAG_STOPPING, &ep->flags);
 
+	ep->data_subs = NULL;
+	ep->sync_slave = NULL;
+	ep->retire_data_urb = NULL;
+	ep->prepare_data_urb = NULL;
+
 	return 0;
 }
 
@@ -912,9 +917,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 /**
  * snd_usb_endpoint_start: start an snd_usb_endpoint
  *
- * @ep:		the endpoint to start
- * @can_sleep:	flag indicating whether the operation is executed in
- * 		non-atomic context
+ * @ep: the endpoint to start
  *
  * A call to this function will increment the use count of the endpoint.
  * In case it is not already running, the URBs for this endpoint will be
@@ -924,7 +927,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
  *
  * Returns an error if the URB submission failed, 0 in all other cases.
  */
-int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep)
+int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
 {
 	int err;
 	unsigned int i;
@@ -938,8 +941,6 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep)
 
 	/* just to be sure */
 	deactivate_urbs(ep, false);
-	if (can_sleep)
-		wait_clear_urbs(ep);
 
 	ep->active_mask = 0;
 	ep->unlink_mask = 0;
@@ -1020,10 +1021,6 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep)
 
 	if (--ep->use_count == 0) {
 		deactivate_urbs(ep, false);
-		ep->data_subs = NULL;
-		ep->sync_slave = NULL;
-		ep->retire_data_urb = NULL;
-		ep->prepare_data_urb = NULL;
 		set_bit(EP_FLAG_STOPPING, &ep->flags);
 	}
 }
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index 6428392d8f62..584f295d7c77 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -18,7 +18,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 				struct audioformat *fmt,
 				struct snd_usb_endpoint *sync_ep);
 
-int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep);
+int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_sync_pending_stop(struct snd_usb_endpoint *ep);
 int  snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 34c6d4f2c0b6..9aa5b1855481 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -218,7 +218,7 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 	}
 }
 
-static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
+static int start_endpoints(struct snd_usb_substream *subs)
 {
 	int err;
 
@@ -231,7 +231,7 @@ static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 		dev_dbg(&subs->dev->dev, "Starting data EP @%p\n", ep);
 
 		ep->data_subs = subs;
-		err = snd_usb_endpoint_start(ep, can_sleep);
+		err = snd_usb_endpoint_start(ep);
 		if (err < 0) {
 			clear_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags);
 			return err;
@@ -260,7 +260,7 @@ static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 		dev_dbg(&subs->dev->dev, "Starting sync EP @%p\n", ep);
 
 		ep->sync_slave = subs->data_endpoint;
-		err = snd_usb_endpoint_start(ep, can_sleep);
+		err = snd_usb_endpoint_start(ep);
 		if (err < 0) {
 			clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags);
 			return err;
@@ -850,7 +850,7 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	/* for playback, submit the URBs now; otherwise, the first hwptr_done
 	 * updates for all URBs would happen at the same time when starting */
 	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		ret = start_endpoints(subs, true);
+		ret = start_endpoints(subs);
 
  unlock:
 	snd_usb_unlock_shutdown(subs->stream->chip);
@@ -1666,7 +1666,7 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		err = start_endpoints(subs, false);
+		err = start_endpoints(subs);
 		if (err < 0)
 			return err;
 
-- 
2.11.0
