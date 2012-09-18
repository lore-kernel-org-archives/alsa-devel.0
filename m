From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH v2 2/4] ALSA: usb-audio: Don't require
	hw_params in endpoint.
Date: Tue, 18 Sep 2012 09:49:47 -0700
Message-ID: <1347986988-11382-3-git-send-email-dgreid@chromium.org>
References: <1347986988-11382-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f73.google.com (mail-bk0-f73.google.com
 [209.85.214.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 9271D2650E6
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 18:49:53 +0200 (CEST)
Received: by bkwj4 with SMTP id j4so2551bkw.2
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 09:49:53 -0700 (PDT)
In-Reply-To: <1347986988-11382-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Change the interface to configure an endpoint so that it doesn't require
a hw_params struct.  This will allow it to be called from prepare
instead of hw_params, configuring it after system resume.

Change-Id: I9cded1644d3f6fee3c5707adffca4ef18c0befd7
Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/usb/endpoint.c | 31 ++++++++++++++++++-------------
 sound/usb/endpoint.h |  5 ++++-
 sound/usb/pcm.c      | 16 +++++++++++++---
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index a83a18d..152bfd4 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -567,20 +567,19 @@ static void release_urbs(struct snd_usb_endpoint *ep, int force)
  * configure a data endpoint
  */
 static int data_ep_set_params(struct snd_usb_endpoint *ep,
-			      struct snd_pcm_hw_params *hw_params,
+			      snd_pcm_format_t pcm_format,
+			      unsigned int channels,
+			      unsigned int period_bytes,
 			      struct audioformat *fmt,
 			      struct snd_usb_endpoint *sync_ep)
 {
 	unsigned int maxsize, i, urb_packs, total_packs, packs_per_ms;
-	int period_bytes = params_period_bytes(hw_params);
-	int format = params_format(hw_params);
 	int is_playback = usb_pipeout(ep->pipe);
-	int frame_bits = snd_pcm_format_physical_width(params_format(hw_params)) *
-							params_channels(hw_params);
+	int frame_bits = snd_pcm_format_physical_width(pcm_format) * channels;
 
 	ep->datainterval = fmt->datainterval;
 	ep->stride = frame_bits >> 3;
-	ep->silence_value = format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0;
+	ep->silence_value = pcm_format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0;
 
 	/* calculate max. frequency */
 	if (ep->maxpacksize) {
@@ -693,7 +692,6 @@ out_of_memory:
  * configure a sync endpoint
  */
 static int sync_ep_set_params(struct snd_usb_endpoint *ep,
-			      struct snd_pcm_hw_params *hw_params,
 			      struct audioformat *fmt)
 {
 	int i;
@@ -736,7 +734,10 @@ out_of_memory:
  * snd_usb_endpoint_set_params: configure an snd_usb_endpoint
  *
  * @ep: the snd_usb_endpoint to configure
- * @hw_params: the hardware parameters
+ * @pcm_format: the audio fomat.
+ * @channels: the number of audio channels.
+ * @period_bytes: the number of bytes in one alsa period.
+ * @rate: the frame rate.
  * @fmt: the USB audio format information
  * @sync_ep: the sync endpoint to use, if any
  *
@@ -745,7 +746,10 @@ out_of_memory:
  * An endpoint that is already running can not be reconfigured.
  */
 int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
-				struct snd_pcm_hw_params *hw_params,
+				snd_pcm_format_t pcm_format,
+				unsigned int channels,
+				unsigned int period_bytes,
+				unsigned int rate,
 				struct audioformat *fmt,
 				struct snd_usb_endpoint *sync_ep)
 {
@@ -765,9 +769,9 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 	ep->fill_max = !!(fmt->attributes & UAC_EP_CS_ATTR_FILL_MAX);
 
 	if (snd_usb_get_speed(ep->chip->dev) == USB_SPEED_FULL)
-		ep->freqn = get_usb_full_speed_rate(params_rate(hw_params));
+		ep->freqn = get_usb_full_speed_rate(rate);
 	else
-		ep->freqn = get_usb_high_speed_rate(params_rate(hw_params));
+		ep->freqn = get_usb_high_speed_rate(rate);
 
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
@@ -777,10 +781,11 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 
 	switch (ep->type) {
 	case  SND_USB_ENDPOINT_TYPE_DATA:
-		err = data_ep_set_params(ep, hw_params, fmt, sync_ep);
+		err = data_ep_set_params(ep, pcm_format, channels,
+					 period_bytes, fmt, sync_ep);
 		break;
 	case  SND_USB_ENDPOINT_TYPE_SYNC:
-		err = sync_ep_set_params(ep, hw_params, fmt);
+		err = sync_ep_set_params(ep, fmt);
 		break;
 	default:
 		err = -EINVAL;
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index cbbbdf2..6376ccf 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -9,7 +9,10 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 					      int ep_num, int direction, int type);
 
 int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
-				struct snd_pcm_hw_params *hw_params,
+				snd_pcm_format_t pcm_format,
+				unsigned int channels,
+				unsigned int period_bytes,
+				unsigned int rate,
 				struct audioformat *fmt,
 				struct snd_usb_endpoint *sync_ep);
 
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 786f7a0..62ab4fd 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -491,14 +491,24 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 		mutex_lock(&subs->stream->chip->shutdown_mutex);
 		/* format changed */
 		stop_endpoints(subs, 0, 0, 0);
-		ret = snd_usb_endpoint_set_params(subs->data_endpoint, hw_params, fmt,
+		ret = snd_usb_endpoint_set_params(subs->data_endpoint,
+						  format,
+						  channels,
+						  subs->period_bytes,
+						  rate,
+						  fmt,
 						  subs->sync_endpoint);
 		if (ret < 0)
 			goto unlock;
 
 		if (subs->sync_endpoint)
-			ret = snd_usb_endpoint_set_params(subs->sync_endpoint,
-							  hw_params, fmt, NULL);
+			ret = snd_usb_endpoint_set_params(subs->data_endpoint,
+							  format,
+							  channels,
+							  subs->period_bytes,
+							  rate,
+							  fmt,
+							  NULL);
 unlock:
 		mutex_unlock(&subs->stream->chip->shutdown_mutex);
 	}
-- 
1.7.12.146.g16d26b1
