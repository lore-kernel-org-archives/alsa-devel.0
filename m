From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 3/3] ALSA: usb-audio: Move configuration to
	prepare.
Date: Mon, 17 Sep 2012 13:11:39 -0700
Message-ID: <1347912699-9969-4-git-send-email-dgreid@chromium.org>
References: <1347912699-9969-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f73.google.com (mail-wg0-f73.google.com [74.125.82.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 679A22616D7
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 22:11:58 +0200 (CEST)
Received: by wgbdt12 with SMTP id dt12so113620wgb.2
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 13:11:58 -0700 (PDT)
In-Reply-To: <1347912699-9969-1-git-send-email-dgreid@chromium.org>
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

Move interface and endpoint configuration from hw_params to prepare
callback.  During system suspend/resume when the USB device power isn't
cycled the interface and endpoint configuration need to be set before
audio playback can continue.  Resume involves another call to prepare
but not to hw_params, moving it here allows a playing stream to continue
after resume.

Change-Id: I6a34251c1245352ff2b9f004d781afcb3bf7cda2
Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/usb/card.h |   2 +
 sound/usb/pcm.c  | 133 +++++++++++++++++++++++++++++++------------------------
 2 files changed, 76 insertions(+), 59 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 23b6f23..6cc883c 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -107,6 +107,8 @@ struct snd_usb_substream {
 	int interface;	/* current interface */
 	int endpoint;	/* assigned endpoint */
 	struct audioformat *cur_audiofmt;	/* current audioformat pointer (for hw_params callback) */
+	snd_pcm_format_t pcm_format;	/* current audio format (for hw_params callback) */
+	unsigned int channels;		/* current number of channels (for hw_params callback) */
 	unsigned int cur_rate;		/* current rate (for hw_params callback) */
 	unsigned int period_bytes;	/* current period bytes (for hw_params callback) */
 	unsigned int altset_idx;     /* USB data format: index of alternate setting */
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 62ab4fd..d19ff07 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -82,8 +82,7 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream
 /*
  * find a matching audio format
  */
-static struct audioformat *find_format(struct snd_usb_substream *subs, unsigned int format,
-				       unsigned int rate, unsigned int channels)
+static struct audioformat *find_format(struct snd_usb_substream *subs)
 {
 	struct list_head *p;
 	struct audioformat *found = NULL;
@@ -92,16 +91,17 @@ static struct audioformat *find_format(struct snd_usb_substream *subs, unsigned
 	list_for_each(p, &subs->fmt_list) {
 		struct audioformat *fp;
 		fp = list_entry(p, struct audioformat, list);
-		if (!(fp->formats & (1uLL << format)))
+		if (!(fp->formats & (1uLL << subs->pcm_format)))
 			continue;
-		if (fp->channels != channels)
+		if (fp->channels != subs->channels)
 			continue;
-		if (rate < fp->rate_min || rate > fp->rate_max)
+		if (subs->cur_rate < fp->rate_min ||
+		    subs->cur_rate > fp->rate_max)
 			continue;
 		if (! (fp->rates & SNDRV_PCM_RATE_CONTINUOUS)) {
 			unsigned int i;
 			for (i = 0; i < fp->nr_rates; i++)
-				if (fp->rate_table[i] == rate)
+				if (fp->rate_table[i] == subs->cur_rate)
 					break;
 			if (i >= fp->nr_rates)
 				continue;
@@ -436,6 +436,42 @@ add_sync_ep:
 }
 
 /*
+ * configure endpoint params
+ *
+ * called  during initial setup and upon resume
+ */
+static int configure_endpoint(struct snd_usb_substream *subs)
+{
+	int ret;
+
+	mutex_lock(&subs->stream->chip->shutdown_mutex);
+	/* format changed */
+	stop_endpoints(subs, 0, 0, 0);
+	ret = snd_usb_endpoint_set_params(subs->data_endpoint,
+					  subs->pcm_format,
+					  subs->channels,
+					  subs->period_bytes,
+					  subs->cur_rate,
+					  subs->cur_audiofmt,
+					  subs->sync_endpoint);
+	if (ret < 0)
+		goto unlock;
+
+	if (subs->sync_endpoint)
+		ret = snd_usb_endpoint_set_params(subs->data_endpoint,
+						  subs->pcm_format,
+						  subs->channels,
+						  subs->period_bytes,
+						  subs->cur_rate,
+						  subs->cur_audiofmt,
+						  NULL);
+
+unlock:
+	mutex_unlock(&subs->stream->chip->shutdown_mutex);
+	return ret;
+}
+
+/*
  * hw_params callback
  *
  * allocate a buffer and set the given audio format.
@@ -451,74 +487,32 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	struct snd_usb_substream *subs = substream->runtime->private_data;
 	struct audioformat *fmt;
 	unsigned int channels, rate, format;
-	int ret, changed;
+	int ret;
 
 	ret = snd_pcm_lib_alloc_vmalloc_buffer(substream,
 					       params_buffer_bytes(hw_params));
 	if (ret < 0)
 		return ret;
 
-	format = params_format(hw_params);
-	rate = params_rate(hw_params);
-	channels = params_channels(hw_params);
-	fmt = find_format(subs, format, rate, channels);
+	subs->pcm_format = params_format(hw_params);
+	subs->period_bytes = params_period_bytes(hw_params);
+	subs->channels = params_channels(hw_params);
+	subs->cur_rate = params_rate(hw_params);
+
+	fmt = find_format(subs);
 	if (!fmt) {
 		snd_printd(KERN_DEBUG "cannot set format: format = %#x, rate = %d, channels = %d\n",
-			   format, rate, channels);
+			   subs->pcm_format, rate, subs->channels);
 		return -EINVAL;
 	}
 
-	changed = subs->cur_audiofmt != fmt ||
-		subs->period_bytes != params_period_bytes(hw_params) ||
-		subs->cur_rate != rate;
 	if ((ret = set_format(subs, fmt)) < 0)
 		return ret;
 
-	if (subs->cur_rate != rate) {
-		struct usb_host_interface *alts;
-		struct usb_interface *iface;
-		iface = usb_ifnum_to_if(subs->dev, fmt->iface);
-		alts = &iface->altsetting[fmt->altset_idx];
-		ret = snd_usb_init_sample_rate(subs->stream->chip, fmt->iface, alts, fmt, rate);
-		if (ret < 0)
-			return ret;
-		subs->cur_rate = rate;
-	}
-
-	if (changed) {
-		subs->period_bytes = params_period_bytes(hw_params);
+	subs->interface = fmt->iface;
+	subs->altset_idx = fmt->altset_idx;
 
-		mutex_lock(&subs->stream->chip->shutdown_mutex);
-		/* format changed */
-		stop_endpoints(subs, 0, 0, 0);
-		ret = snd_usb_endpoint_set_params(subs->data_endpoint,
-						  format,
-						  channels,
-						  subs->period_bytes,
-						  rate,
-						  fmt,
-						  subs->sync_endpoint);
-		if (ret < 0)
-			goto unlock;
-
-		if (subs->sync_endpoint)
-			ret = snd_usb_endpoint_set_params(subs->data_endpoint,
-							  format,
-							  channels,
-							  subs->period_bytes,
-							  rate,
-							  fmt,
-							  NULL);
-unlock:
-		mutex_unlock(&subs->stream->chip->shutdown_mutex);
-	}
-
-	if (ret == 0) {
-		subs->interface = fmt->iface;
-		subs->altset_idx = fmt->altset_idx;
-	}
-
-	return ret;
+	return 0;
 }
 
 /*
@@ -549,6 +543,9 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_usb_substream *subs = runtime->private_data;
+	struct usb_host_interface *alts;
+	struct usb_interface *iface;
+	int ret;
 
 	if (! subs->cur_audiofmt) {
 		snd_printk(KERN_ERR "usbaudio: no format is specified!\n");
@@ -558,6 +555,24 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	if (snd_BUG_ON(!subs->data_endpoint))
 		return -EIO;
 
+	ret = set_format(subs, subs->cur_audiofmt);
+	if (ret < 0)
+		return ret;
+
+	iface = usb_ifnum_to_if(subs->dev, subs->cur_audiofmt->iface);
+	alts = &iface->altsetting[subs->cur_audiofmt->altset_idx];
+	ret = snd_usb_init_sample_rate(subs->stream->chip,
+				       subs->cur_audiofmt->iface,
+				       alts,
+				       subs->cur_audiofmt,
+				       subs->cur_rate);
+	if (ret < 0)
+		return ret;
+
+	ret = configure_endpoint(subs);
+	if (ret < 0)
+		return ret;
+
 	/* some unit conversions in runtime */
 	subs->data_endpoint->maxframesize =
 		bytes_to_frames(runtime, subs->data_endpoint->maxpacksize);
-- 
1.7.12.146.g16d26b1
