From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] snd_usb_caiaq: fix potential lockups locking
Date: Thu, 3 Apr 2008 13:29:21 +0200
Message-ID: <20080403112921.GA760@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CBB14246C6
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Apr 2008 13:29:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 4831A7F4036
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Apr 2008 13:29:25 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RS+0dmdAKHOj for <alsa-devel@alsa-project.org>;
	Thu,  3 Apr 2008 13:29:21 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

attached is a patch for snd_usb_caiaq which fixes system potential 
lockups when stoping and restarting the stream very quickly multiple
times in a row which is what some players do when the user drags the
song position slider.

Also, it seems that snd_pcm_period_elapsed() must not be called when
holding a spinlock? The documentation[*], however, doesn't state that.

As this fixes an annoying bug, I would appreciate seeing that one being
pushed into 2.6.25. Still possible?

Thanks and best regards,
Daniel

[*] http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/x773.htm#PCM-INTERFACE-INTERRUPT-HANDLER-BOTH

----

Subject: [PATCH] snd_usb_caiaq: fix potential lockups

This patch fixes potential lockups in snd_usb_caiaq by refining the
locking mechanims and by using usb_kill_urb() in favor to
usb_unlink_urb().

Signed-off-by: Daniel Mack <daniel@caiaq.de>



--wRRV7LY7NUeQGEoC
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="snd-caiaq-1.3.4.diff"

diff --git a/sound/usb/caiaq/caiaq-audio.c b/sound/usb/caiaq/caiaq-audio.c
index 9cc4cd8..1aa9279 100644
--- a/sound/usb/caiaq/caiaq-audio.c
+++ b/sound/usb/caiaq/caiaq-audio.c
@@ -1,5 +1,5 @@
 /*
- *   Copyright (c) 2006,2007 Daniel Mack, Karsten Wiese
+ *   Copyright (c) 2006-2008 Daniel Mack, Karsten Wiese
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -77,10 +77,15 @@ static void
 deactivate_substream(struct snd_usb_caiaqdev *dev,
 		     struct snd_pcm_substream *sub)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&dev->spinlock, flags);
+
 	if (sub->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		dev->sub_playback[sub->number] = NULL;
 	else
 		dev->sub_capture[sub->number] = NULL;
+
+	spin_unlock_irqrestore(&dev->spinlock, flags);
 }
 
 static int
@@ -97,13 +102,13 @@ static int stream_start(struct snd_usb_caiaqdev *dev)
 {
 	int i, ret;
 
-	debug("stream_start(%p)\n", dev);
-	spin_lock_irq(&dev->spinlock);
-	if (dev->streaming) {
-		spin_unlock_irq(&dev->spinlock);
+	debug("%s(%p)\n", __func__, dev);
+
+	if (dev->streaming)
 		return -EINVAL;
-	}
 
+	memset(dev->sub_playback, 0, sizeof(dev->sub_playback));
+	memset(dev->sub_capture, 0, sizeof(dev->sub_capture));
 	dev->input_panic = 0;
 	dev->output_panic = 0;
 	dev->first_packet = 1;
@@ -112,37 +117,35 @@ static int stream_start(struct snd_usb_caiaqdev *dev)
 	for (i = 0; i < N_URBS; i++) {
 		ret = usb_submit_urb(dev->data_urbs_in[i], GFP_ATOMIC);
 		if (ret) {
-			log("unable to trigger initial read #%d! (ret = %d)\n",
-				i, ret);
+			log("unable to trigger read #%d! (ret %d)\n", i, ret);
 			dev->streaming = 0;
-			spin_unlock_irq(&dev->spinlock);
 			return -EPIPE;
 		}
 	}
 	
-	spin_unlock_irq(&dev->spinlock);
 	return 0;
 }
 
 static void stream_stop(struct snd_usb_caiaqdev *dev)
 {
 	int i;
-	
-	debug("stream_stop(%p)\n", dev);
+
+	debug("%s(%p)\n", __func__, dev);
 	if (!dev->streaming)
 		return;
 	
 	dev->streaming = 0;
+
 	for (i = 0; i < N_URBS; i++) {
-		usb_unlink_urb(dev->data_urbs_in[i]);
-		usb_unlink_urb(dev->data_urbs_out[i]);
+		usb_kill_urb(dev->data_urbs_in[i]);
+		usb_kill_urb(dev->data_urbs_out[i]);
 	}
 }
 
 static int snd_usb_caiaq_substream_open(struct snd_pcm_substream *substream)
 {
 	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(substream);
-	debug("snd_usb_caiaq_substream_open(%p)\n", substream);
+	debug("%s(%p)\n", __func__, substream);
 	substream->runtime->hw = dev->pcm_info;
 	snd_pcm_limit_hw_rates(substream->runtime);
 	return 0;
@@ -152,7 +155,7 @@ static int snd_usb_caiaq_substream_close(struct snd_pcm_substream *substream)
 {
 	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(substream);
 
-	debug("snd_usb_caiaq_substream_close(%p)\n", substream);
+	debug("%s(%p)\n", __func__, substream);
 	if (all_substreams_zero(dev->sub_playback) &&
 	    all_substreams_zero(dev->sub_capture)) {
 		/* when the last client has stopped streaming, 
@@ -160,24 +163,22 @@ static int snd_usb_caiaq_substream_close(struct snd_pcm_substream *substream)
 		stream_stop(dev);
 		dev->pcm_info.rates = dev->samplerates;
 	}
-	
+
 	return 0;
 }
 
 static int snd_usb_caiaq_pcm_hw_params(struct snd_pcm_substream *sub,
 			     		struct snd_pcm_hw_params *hw_params)
 {
-	debug("snd_usb_caiaq_pcm_hw_params(%p)\n", sub);
+	debug("%s(%p)\n", __func__, sub);
 	return snd_pcm_lib_malloc_pages(sub, params_buffer_bytes(hw_params));
 }
 
 static int snd_usb_caiaq_pcm_hw_free(struct snd_pcm_substream *sub)
 {
 	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(sub);
-	debug("snd_usb_caiaq_pcm_hw_free(%p)\n", sub);
-	spin_lock_irq(&dev->spinlock);
+	debug("%s(%p)\n", __func__, sub);
 	deactivate_substream(dev, sub);
-	spin_unlock_irq(&dev->spinlock);
 	return snd_pcm_lib_free_pages(sub);
 }
 
@@ -196,7 +197,7 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	debug("snd_usb_caiaq_pcm_prepare(%p)\n", substream);
+	debug("%s(%p)\n", __func__, substream);
 	
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		dev->audio_out_buf_pos[index] = BYTES_PER_SAMPLE + 1;
@@ -247,15 +248,11 @@ static int snd_usb_caiaq_pcm_trigger(struct snd_pcm_substream *sub, int cmd)
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		spin_lock(&dev->spinlock);
 		activate_substream(dev, sub);
-		spin_unlock(&dev->spinlock);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		spin_lock(&dev->spinlock);
 		deactivate_substream(dev, sub);
-		spin_unlock(&dev->spinlock);
 		break;
 	default:
 		return -EINVAL;
@@ -328,8 +325,6 @@ static void read_in_urb_mode0(struct snd_usb_caiaqdev *dev,
 	if (all_substreams_zero(dev->sub_capture))
 		return;
 
-	spin_lock(&dev->spinlock);
-	
 	for (i = 0; i < iso->actual_length;) {
 		for (stream = 0; stream < dev->n_streams; stream++, i++) {
 			sub = dev->sub_capture[stream];
@@ -345,8 +340,6 @@ static void read_in_urb_mode0(struct snd_usb_caiaqdev *dev,
 			}
 		}
 	}
-	
-	spin_unlock(&dev->spinlock);
 }
 
 static void read_in_urb_mode2(struct snd_usb_caiaqdev *dev,
@@ -358,8 +351,6 @@ static void read_in_urb_mode2(struct snd_usb_caiaqdev *dev,
 	struct snd_pcm_substream *sub;
 	int stream, i;
 
-	spin_lock(&dev->spinlock);
-	
 	for (i = 0; i < iso->actual_length;) {
 		if (i % (dev->n_streams * BYTES_PER_SAMPLE_USB) == 0) {
 			for (stream = 0; 
@@ -393,8 +384,6 @@ static void read_in_urb_mode2(struct snd_usb_caiaqdev *dev,
 			}
 		}
 	}
-
-	spin_unlock(&dev->spinlock);
 }
 
 static void read_in_urb(struct snd_usb_caiaqdev *dev,
@@ -418,8 +407,6 @@ static void read_in_urb(struct snd_usb_caiaqdev *dev,
 				dev->input_panic ? "(input)" : "",
 				dev->output_panic ? "(output)" : "");
 	}
-
-	check_for_elapsed_periods(dev, dev->sub_capture);
 }
 
 static void fill_out_urb(struct snd_usb_caiaqdev *dev, 
@@ -429,8 +416,6 @@ static void fill_out_urb(struct snd_usb_caiaqdev *dev,
 	unsigned char *usb_buf = urb->transfer_buffer + iso->offset;
 	struct snd_pcm_substream *sub;
 	int stream, i;
-
-	spin_lock(&dev->spinlock);
 	
 	for (i = 0; i < iso->length;) {
 		for (stream = 0; stream < dev->n_streams; stream++, i++) {
@@ -456,9 +441,6 @@ static void fill_out_urb(struct snd_usb_caiaqdev *dev,
 		    for (stream = 0; stream < dev->n_streams; stream++, i++)
 		    	usb_buf[i] = MAKE_CHECKBYTE(dev, stream, i);
 	}
-
-	spin_unlock(&dev->spinlock);
-	check_for_elapsed_periods(dev, dev->sub_playback);
 }
 
 static void read_completed(struct urb *urb)
@@ -472,6 +454,7 @@ static void read_completed(struct urb *urb)
 		return;
 
 	dev = info->dev;
+
 	if (!dev->streaming)
 		return;
 
@@ -489,8 +472,12 @@ static void read_completed(struct urb *urb)
 		out->iso_frame_desc[outframe].offset = BYTES_PER_FRAME * frame;
 		
 		if (len > 0) {
+			spin_lock(&dev->spinlock);
 			fill_out_urb(dev, out, &out->iso_frame_desc[outframe]);
 			read_in_urb(dev, urb, &urb->iso_frame_desc[frame]);
+			spin_unlock(&dev->spinlock);
+			check_for_elapsed_periods(dev, dev->sub_playback);
+			check_for_elapsed_periods(dev, dev->sub_capture);
 			send_it = 1;
 		}
 
@@ -696,7 +683,7 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
 
 void snd_usb_caiaq_audio_free(struct snd_usb_caiaqdev *dev)
 {
-	debug("snd_usb_caiaq_audio_free (%p)\n", dev);
+	debug("%s(%p)\n", __func__, dev);
 	stream_stop(dev);
 	free_urbs(dev->data_urbs_in);
 	free_urbs(dev->data_urbs_out);
diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index 7c44a2c..73c08b4 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -42,7 +42,7 @@
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.2");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.4");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
@@ -456,7 +456,7 @@ static void snd_disconnect(struct usb_interface *intf)
 	struct snd_usb_caiaqdev *dev;
 	struct snd_card *card = dev_get_drvdata(&intf->dev);
 
-	debug("snd_disconnect(%p)\n", intf);
+	debug("%s(%p)\n", __func__, intf);
 
 	if (!card)
 		return;

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--wRRV7LY7NUeQGEoC--
