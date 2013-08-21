From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 09/10] ALSA: usb-audio: conditional
	concurrent usage of endpoint
Date: Wed, 21 Aug 2013 23:38:04 +0200
Message-ID: <1377121085-20563-10-git-send-email-eldad@fogrefinery.com>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 6364126533C
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 23:39:06 +0200 (CEST)
Received: by mail-bk0-f50.google.com with SMTP id mz11so401931bkb.9
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 14:39:06 -0700 (PDT)
In-Reply-To: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

If the current endpoint is in use, check if the hardware parameters
match. If they do, allow the usage.
This also requires setting the parameters in case an data endpoint
is used as a synchornization source, and it is first set by its
sink endpoint.

Add the same check to hw_params, to prevent overwriting the
current params.
Clear the hardware parameteres on hw_free only if the other endpoint
is not in use.

No change for sync endpoints (explicit feedback).

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
v2: Fixed logic error in the concurrent usage check
(snd_usb_endpoint_set_params)

---
 sound/usb/endpoint.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 sound/usb/endpoint.h |  9 ++++++++-
 sound/usb/pcm.c      | 51 +++++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 91 insertions(+), 15 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 6ff36f5..7e04ebb 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -742,6 +742,34 @@ out_of_memory:
 	return -ENOMEM;
 }
 
+bool snd_usb_endpoint_may_set_params(struct snd_usb_substream *subs,
+				     snd_pcm_format_t pcm_format,
+				     unsigned int channels,
+				     unsigned int period_bytes,
+				     unsigned int rate)
+{
+	/* no associated substream */
+	if (!subs)
+		return true;
+
+	/* data_endpoint not yet initialized */
+	if (!subs->data_endpoint)
+		return true;
+
+	if (subs->data_endpoint->use_count == 0)
+		return true;
+
+	if (subs->pcm_format != pcm_format ||
+	    subs->channels != channels ||
+	    subs->period_bytes != period_bytes ||
+	    subs->cur_rate != rate)
+		return false;
+
+	snd_printdd(KERN_INFO "ep #%x in use, parameters match\n",
+		    subs->data_endpoint->ep_num);
+	return true;
+}
+
 /**
  * snd_usb_endpoint_set_params: configure an snd_usb_endpoint
  *
@@ -752,6 +780,7 @@ out_of_memory:
  * @rate: the frame rate.
  * @fmt: the USB audio format information
  * @sync_ep: the sync endpoint to use, if any
+ * @subs: the substream that uses this endpoint as data endpoint
  *
  * Determine the number of URBs to be used on this endpoint.
  * An endpoint must be configured before it can be started.
@@ -763,14 +792,23 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 				unsigned int period_bytes,
 				unsigned int rate,
 				struct audioformat *fmt,
-				struct snd_usb_endpoint *sync_ep)
+				struct snd_usb_endpoint *sync_ep,
+				struct snd_usb_substream *subs)
 {
 	int err;
 
 	if (ep->param_set || ep->use_count != 0) {
-		snd_printk(KERN_WARNING "Unable to change format on ep #%x: already in use\n",
-			   ep->ep_num);
-		return -EBUSY;
+		if (!subs ||
+		    !snd_usb_endpoint_may_set_params(subs, pcm_format,
+						     channels, period_bytes,
+						     rate)) {
+			snd_printk(KERN_WARNING
+				   "Unable to change format on ep #%x: already in use\n",
+				   ep->ep_num);
+			return -EBUSY;
+		}
+		/* Endpoint already set with the same parameters */
+		return 0;
 	}
 	ep->param_set = true;
 
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index c928e0c..64f2b08 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -14,7 +14,8 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 				unsigned int period_bytes,
 				unsigned int rate,
 				struct audioformat *fmt,
-				struct snd_usb_endpoint *sync_ep);
+				struct snd_usb_endpoint *sync_ep,
+				struct snd_usb_substream *subs);
 
 int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep);
 void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep);
@@ -30,4 +31,10 @@ void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 			     struct snd_usb_endpoint *sender,
 			     const struct urb *urb);
 
+bool snd_usb_endpoint_may_set_params(struct snd_usb_substream *subs,
+				     snd_pcm_format_t pcm_format,
+				     unsigned int channels,
+				     unsigned int period_bytes,
+				     unsigned int rate);
+
 #endif /* __USBAUDIO_ENDPOINT_H */
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 140e2e4..a72f755 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -644,6 +644,7 @@ static int configure_sync_endpoint(struct snd_usb_substream *subs)
 						   subs->period_bytes,
 						   subs->cur_rate,
 						   subs->cur_audiofmt,
+						   NULL,
 						   NULL);
 
 	/* Try to find the best matching audioformat. */
@@ -680,9 +681,18 @@ static int configure_sync_endpoint(struct snd_usb_substream *subs)
 					  sync_period_bytes,
 					  subs->cur_rate,
 					  sync_fp,
-					  NULL);
+					  NULL,
+					  sync_subs);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	sync_subs->pcm_format = subs->pcm_format;
+	sync_subs->period_bytes = sync_period_bytes;
+	sync_subs->channels = sync_fp->channels;
+	sync_subs->cur_rate = subs->cur_rate;
+	sync_subs->data_endpoint = subs->sync_endpoint;
+
+	return 0;
 }
 
 /*
@@ -702,7 +712,8 @@ static int configure_endpoint(struct snd_usb_substream *subs)
 					  subs->period_bytes,
 					  subs->cur_rate,
 					  subs->cur_audiofmt,
-					  subs->sync_endpoint);
+					  subs->sync_endpoint,
+					  subs);
 	if (ret < 0)
 		return ret;
 
@@ -728,16 +739,32 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	struct snd_usb_substream *subs = substream->runtime->private_data;
 	struct audioformat *fmt;
 	int ret;
+	snd_pcm_format_t pcm_format;
+	unsigned int channels;
+	unsigned int period_bytes;
+	unsigned int rate;
 
 	ret = snd_pcm_lib_alloc_vmalloc_buffer(substream,
 					       params_buffer_bytes(hw_params));
 	if (ret < 0)
 		return ret;
 
-	subs->pcm_format = params_format(hw_params);
-	subs->period_bytes = params_period_bytes(hw_params);
-	subs->channels = params_channels(hw_params);
-	subs->cur_rate = params_rate(hw_params);
+	pcm_format = params_format(hw_params);
+	period_bytes = params_period_bytes(hw_params);
+	channels = params_channels(hw_params);
+	rate = params_rate(hw_params);
+
+	if (!snd_usb_endpoint_may_set_params(subs, pcm_format, channels,
+					     period_bytes, rate)) {
+		snd_printk(KERN_WARNING "Unable to set hw_params on substream (dir: %d), data EP in use\n",
+			   subs->direction);
+		return -EBUSY;
+	}
+
+	subs->pcm_format = pcm_format;
+	subs->period_bytes = period_bytes;
+	subs->channels = channels;
+	subs->cur_rate = rate;
 
 	fmt = find_format(subs);
 	if (!fmt) {
@@ -771,9 +798,13 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_usb_substream *subs = substream->runtime->private_data;
 
-	subs->cur_audiofmt = NULL;
-	subs->cur_rate = 0;
-	subs->period_bytes = 0;
+	if (!subs->data_endpoint || subs->data_endpoint->use_count == 0) {
+		subs->cur_audiofmt = NULL;
+		subs->cur_rate = 0;
+		subs->period_bytes = 0;
+		subs->channels = 0;
+	}
+
 	down_read(&subs->stream->chip->shutdown_rwsem);
 	if (!subs->stream->chip->shutdown) {
 		stop_endpoints(subs, true);
-- 
1.8.1.5
