From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/5] ALSA: snd_usb_caiaq: clean whitespaces
Date: Mon,  1 Jun 2009 21:36:23 +0200
Message-ID: <1243884987-20256-1-git-send-email-daniel@caiaq.de>
References: <s5h8wkbc2ro.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C766C245C4
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 21:36:41 +0200 (CEST)
In-Reply-To: <s5h8wkbc2ro.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cosmetic changes only, no code change.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/caiaq/audio.c  |   88 +++++++++++++++++++++++-----------------------
 sound/usb/caiaq/device.c |   60 ++++++++++++++++----------------
 sound/usb/caiaq/midi.c   |   24 ++++++------
 3 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index b13ce76..b144513 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -42,10 +42,10 @@
 	(stream << 1) | (~(i / (dev->n_streams * BYTES_PER_SAMPLE_USB)) & 1)
 
 static struct snd_pcm_hardware snd_usb_caiaq_pcm_hardware = {
-	.info 		= (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED | 
+	.info 		= (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 			   SNDRV_PCM_INFO_BLOCK_TRANSFER),
 	.formats 	= SNDRV_PCM_FMTBIT_S24_3BE,
-	.rates 		= (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | 
+	.rates 		= (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
 			   SNDRV_PCM_RATE_96000),
 	.rate_min	= 44100,
 	.rate_max	= 0, /* will overwrite later */
@@ -68,7 +68,7 @@ activate_substream(struct snd_usb_caiaqdev *dev,
 		dev->sub_capture[sub->number] = sub;
 }
 
-static void 
+static void
 deactivate_substream(struct snd_usb_caiaqdev *dev,
 		     struct snd_pcm_substream *sub)
 {
@@ -118,7 +118,7 @@ static int stream_start(struct snd_usb_caiaqdev *dev)
 			return -EPIPE;
 		}
 	}
-	
+
 	return 0;
 }
 
@@ -129,7 +129,7 @@ static void stream_stop(struct snd_usb_caiaqdev *dev)
 	debug("%s(%p)\n", __func__, dev);
 	if (!dev->streaming)
 		return;
-	
+
 	dev->streaming = 0;
 
 	for (i = 0; i < N_URBS; i++) {
@@ -154,7 +154,7 @@ static int snd_usb_caiaq_substream_close(struct snd_pcm_substream *substream)
 	debug("%s(%p)\n", __func__, substream);
 	if (all_substreams_zero(dev->sub_playback) &&
 	    all_substreams_zero(dev->sub_capture)) {
-		/* when the last client has stopped streaming, 
+		/* when the last client has stopped streaming,
 		 * all sample rates are allowed again */
 		stream_stop(dev);
 		dev->pcm_info.rates = dev->samplerates;
@@ -194,7 +194,7 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	debug("%s(%p)\n", __func__, substream);
-	
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		dev->period_out_count[index] = BYTES_PER_SAMPLE + 1;
 		dev->audio_out_buf_pos[index] = BYTES_PER_SAMPLE + 1;
@@ -205,19 +205,19 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 
 	if (dev->streaming)
 		return 0;
-	
+
 	/* the first client that opens a stream defines the sample rate
 	 * setting for all subsequent calls, until the last client closed. */
 	for (i=0; i < ARRAY_SIZE(rates); i++)
 		if (runtime->rate == rates[i])
 			dev->pcm_info.rates = 1 << i;
-	
+
 	snd_pcm_limit_hw_rates(runtime);
 
 	bytes_per_sample = BYTES_PER_SAMPLE;
 	if (dev->spec.data_alignment == 2)
 		bytes_per_sample++;
-	
+
 	bpp = ((runtime->rate / 8000) + CLOCK_DRIFT_TOLERANCE)
 		* bytes_per_sample * CHANNELS_PER_STREAM * dev->n_streams;
 
@@ -232,7 +232,7 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 	ret = stream_start(dev);
 	if (ret)
 		return ret;
-	
+
 	dev->output_running = 0;
 	wait_event_timeout(dev->prepare_wait_queue, dev->output_running, HZ);
 	if (!dev->output_running) {
@@ -273,7 +273,7 @@ snd_usb_caiaq_pcm_pointer(struct snd_pcm_substream *sub)
 		return SNDRV_PCM_POS_XRUN;
 
 	if (sub->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		return bytes_to_frames(sub->runtime, 
+		return bytes_to_frames(sub->runtime,
 					dev->audio_out_buf_pos[index]);
 	else
 		return bytes_to_frames(sub->runtime,
@@ -291,7 +291,7 @@ static struct snd_pcm_ops snd_usb_caiaq_ops = {
 	.trigger =	snd_usb_caiaq_pcm_trigger,
 	.pointer =	snd_usb_caiaq_pcm_pointer
 };
-	
+
 static void check_for_elapsed_periods(struct snd_usb_caiaqdev *dev,
 				      struct snd_pcm_substream **subs)
 {
@@ -333,7 +333,7 @@ static void read_in_urb_mode0(struct snd_usb_caiaqdev *dev,
 				struct snd_pcm_runtime *rt = sub->runtime;
 				char *audio_buf = rt->dma_area;
 				int sz = frames_to_bytes(rt, rt->buffer_size);
-				audio_buf[dev->audio_in_buf_pos[stream]++] 
+				audio_buf[dev->audio_in_buf_pos[stream]++]
 					= usb_buf[i];
 				dev->period_in_count[stream]++;
 				if (dev->audio_in_buf_pos[stream] == sz)
@@ -354,14 +354,14 @@ static void read_in_urb_mode2(struct snd_usb_caiaqdev *dev,
 
 	for (i = 0; i < iso->actual_length;) {
 		if (i % (dev->n_streams * BYTES_PER_SAMPLE_USB) == 0) {
-			for (stream = 0; 
-			     stream < dev->n_streams; 
+			for (stream = 0;
+			     stream < dev->n_streams;
 			     stream++, i++) {
 				if (dev->first_packet)
 					continue;
 
 				check_byte = MAKE_CHECKBYTE(dev, stream, i);
-				
+
 				if ((usb_buf[i] & 0x3f) != check_byte)
 					dev->input_panic = 1;
 
@@ -410,21 +410,21 @@ static void read_in_urb(struct snd_usb_caiaqdev *dev,
 	}
 
 	if ((dev->input_panic || dev->output_panic) && !dev->warned) {
-		debug("streaming error detected %s %s\n", 
+		debug("streaming error detected %s %s\n",
 				dev->input_panic ? "(input)" : "",
 				dev->output_panic ? "(output)" : "");
 		dev->warned = 1;
 	}
 }
 
-static void fill_out_urb(struct snd_usb_caiaqdev *dev, 
-			 struct urb *urb, 
+static void fill_out_urb(struct snd_usb_caiaqdev *dev,
+			 struct urb *urb,
 			 const struct usb_iso_packet_descriptor *iso)
 {
 	unsigned char *usb_buf = urb->transfer_buffer + iso->offset;
 	struct snd_pcm_substream *sub;
 	int stream, i;
-	
+
 	for (i = 0; i < iso->length;) {
 		for (stream = 0; stream < dev->n_streams; stream++, i++) {
 			sub = dev->sub_playback[stream];
@@ -444,7 +444,7 @@ static void fill_out_urb(struct snd_usb_caiaqdev *dev,
 
 		/* fill in the check bytes */
 		if (dev->spec.data_alignment == 2 &&
-		    i % (dev->n_streams * BYTES_PER_SAMPLE_USB) == 
+		    i % (dev->n_streams * BYTES_PER_SAMPLE_USB) ==
 		    	(dev->n_streams * CHANNELS_PER_STREAM))
 		    for (stream = 0; stream < dev->n_streams; stream++, i++)
 		    	usb_buf[i] = MAKE_CHECKBYTE(dev, stream, i);
@@ -453,7 +453,7 @@ static void fill_out_urb(struct snd_usb_caiaqdev *dev,
 
 static void read_completed(struct urb *urb)
 {
-	struct snd_usb_caiaq_cb_info *info = urb->context; 
+	struct snd_usb_caiaq_cb_info *info = urb->context;
 	struct snd_usb_caiaqdev *dev;
 	struct urb *out;
 	int frame, len, send_it = 0, outframe = 0;
@@ -478,7 +478,7 @@ static void read_completed(struct urb *urb)
 		out->iso_frame_desc[outframe].length = len;
 		out->iso_frame_desc[outframe].actual_length = 0;
 		out->iso_frame_desc[outframe].offset = BYTES_PER_FRAME * frame;
-		
+
 		if (len > 0) {
 			spin_lock(&dev->spinlock);
 			fill_out_urb(dev, out, &out->iso_frame_desc[outframe]);
@@ -497,14 +497,14 @@ static void read_completed(struct urb *urb)
 		out->transfer_flags = URB_ISO_ASAP;
 		usb_submit_urb(out, GFP_ATOMIC);
 	}
-	
+
 	/* re-submit inbound urb */
 	for (frame = 0; frame < FRAMES_PER_URB; frame++) {
 		urb->iso_frame_desc[frame].offset = BYTES_PER_FRAME * frame;
 		urb->iso_frame_desc[frame].length = BYTES_PER_FRAME;
 		urb->iso_frame_desc[frame].actual_length = 0;
 	}
-	
+
 	urb->number_of_packets = FRAMES_PER_URB;
 	urb->transfer_flags = URB_ISO_ASAP;
 	usb_submit_urb(urb, GFP_ATOMIC);
@@ -528,7 +528,7 @@ static struct urb **alloc_urbs(struct snd_usb_caiaqdev *dev, int dir, int *ret)
 	struct usb_device *usb_dev = dev->chip.dev;
 	unsigned int pipe;
 
-	pipe = (dir == SNDRV_PCM_STREAM_PLAYBACK) ? 
+	pipe = (dir == SNDRV_PCM_STREAM_PLAYBACK) ?
 		usb_sndisocpipe(usb_dev, ENDPOINT_PLAYBACK) :
 		usb_rcvisocpipe(usb_dev, ENDPOINT_CAPTURE);
 
@@ -547,25 +547,25 @@ static struct urb **alloc_urbs(struct snd_usb_caiaqdev *dev, int dir, int *ret)
 			return urbs;
 		}
 
-		urbs[i]->transfer_buffer = 
+		urbs[i]->transfer_buffer =
 			kmalloc(FRAMES_PER_URB * BYTES_PER_FRAME, GFP_KERNEL);
 		if (!urbs[i]->transfer_buffer) {
 			log("unable to kmalloc() transfer buffer, OOM!?\n");
 			*ret = -ENOMEM;
 			return urbs;
 		}
-		
+
 		for (frame = 0; frame < FRAMES_PER_URB; frame++) {
-			struct usb_iso_packet_descriptor *iso = 
+			struct usb_iso_packet_descriptor *iso =
 				&urbs[i]->iso_frame_desc[frame];
-			
+
 			iso->offset = BYTES_PER_FRAME * frame;
 			iso->length = BYTES_PER_FRAME;
 		}
-		
+
 		urbs[i]->dev = usb_dev;
 		urbs[i]->pipe = pipe;
-		urbs[i]->transfer_buffer_length = FRAMES_PER_URB 
+		urbs[i]->transfer_buffer_length = FRAMES_PER_URB
 						* BYTES_PER_FRAME;
 		urbs[i]->context = &dev->data_cb_info[i];
 		urbs[i]->interval = 1;
@@ -589,7 +589,7 @@ static void free_urbs(struct urb **urbs)
 	for (i = 0; i < N_URBS; i++) {
 		if (!urbs[i])
 			continue;
-		
+
 		usb_kill_urb(urbs[i]);
 		kfree(urbs[i]->transfer_buffer);
 		usb_free_urb(urbs[i]);
@@ -602,11 +602,11 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
 {
 	int i, ret;
 
-	dev->n_audio_in  = max(dev->spec.num_analog_audio_in, 
-			       dev->spec.num_digital_audio_in) / 
+	dev->n_audio_in  = max(dev->spec.num_analog_audio_in,
+			       dev->spec.num_digital_audio_in) /
 				CHANNELS_PER_STREAM;
 	dev->n_audio_out = max(dev->spec.num_analog_audio_out,
-			       dev->spec.num_digital_audio_out) / 
+			       dev->spec.num_digital_audio_out) /
 				CHANNELS_PER_STREAM;
 	dev->n_streams = max(dev->n_audio_in, dev->n_audio_out);
 
@@ -619,7 +619,7 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
 		return -EINVAL;
 	}
 
-	ret = snd_pcm_new(dev->chip.card, dev->product_name, 0, 
+	ret = snd_pcm_new(dev->chip.card, dev->product_name, 0,
 			dev->n_audio_out, dev->n_audio_in, &dev->pcm);
 
 	if (ret < 0) {
@@ -632,7 +632,7 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
 
 	memset(dev->sub_playback, 0, sizeof(dev->sub_playback));
 	memset(dev->sub_capture, 0, sizeof(dev->sub_capture));
-	
+
 	memcpy(&dev->pcm_info, &snd_usb_caiaq_pcm_hardware,
 			sizeof(snd_usb_caiaq_pcm_hardware));
 
@@ -651,9 +651,9 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
 		break;
 	}
 
-	snd_pcm_set_ops(dev->pcm, SNDRV_PCM_STREAM_PLAYBACK, 
+	snd_pcm_set_ops(dev->pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				&snd_usb_caiaq_ops);
-	snd_pcm_set_ops(dev->pcm, SNDRV_PCM_STREAM_CAPTURE, 
+	snd_pcm_set_ops(dev->pcm, SNDRV_PCM_STREAM_CAPTURE,
 				&snd_usb_caiaq_ops);
 
 	snd_pcm_lib_preallocate_pages_for_all(dev->pcm,
@@ -662,7 +662,7 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
 					MAX_BUFFER_SIZE, MAX_BUFFER_SIZE);
 
 	dev->data_cb_info =
-		kmalloc(sizeof(struct snd_usb_caiaq_cb_info) * N_URBS, 
+		kmalloc(sizeof(struct snd_usb_caiaq_cb_info) * N_URBS,
 					GFP_KERNEL);
 
 	if (!dev->data_cb_info)
@@ -672,14 +672,14 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
 		dev->data_cb_info[i].dev = dev;
 		dev->data_cb_info[i].index = i;
 	}
-	
+
 	dev->data_urbs_in = alloc_urbs(dev, SNDRV_PCM_STREAM_CAPTURE, &ret);
 	if (ret < 0) {
 		kfree(dev->data_cb_info);
 		free_urbs(dev->data_urbs_in);
 		return ret;
 	}
-	
+
 	dev->data_urbs_out = alloc_urbs(dev, SNDRV_PCM_STREAM_PLAYBACK, &ret);
 	if (ret < 0) {
 		kfree(dev->data_cb_info);
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 515de1c..9be0f2e 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -79,7 +79,7 @@ static struct usb_device_id snd_usb_id_table[] = {
 	{
 		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
 		.idVendor =	USB_VID_NATIVEINSTRUMENTS,
-		.idProduct =	USB_PID_RIGKONTROL2 
+		.idProduct =	USB_PID_RIGKONTROL2
 	},
 	{
 		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
@@ -197,7 +197,7 @@ int snd_usb_caiaq_send_command(struct snd_usb_caiaqdev *dev,
 
 	if (buffer && len > 0)
 		memcpy(dev->ep1_out_buf+1, buffer, len);
-	
+
 	dev->ep1_out_buf[0] = command;
 	return usb_bulk_msg(usb_dev, usb_sndbulkpipe(usb_dev, 1),
 			   dev->ep1_out_buf, len+1, &actual_len, 200);
@@ -208,7 +208,7 @@ int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *dev,
 {
 	int ret;
 	char tmp[5];
-	
+
 	switch (rate) {
 	case 44100:	tmp[0] = SAMPLERATE_44100;   break;
 	case 48000:	tmp[0] = SAMPLERATE_48000;   break;
@@ -237,12 +237,12 @@ int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *dev,
 
 	if (ret)
 		return ret;
-	
-	if (!wait_event_timeout(dev->ep1_wait_queue, 
+
+	if (!wait_event_timeout(dev->ep1_wait_queue,
 	    dev->audio_parm_answer >= 0, HZ))
 		return -EPIPE;
-		
-	if (dev->audio_parm_answer != 1) 
+
+	if (dev->audio_parm_answer != 1)
 		debug("unable to set the device's audio params\n");
 	else
 		dev->bpp = bpp;
@@ -250,8 +250,8 @@ int snd_usb_caiaq_set_audio_params (struct snd_usb_caiaqdev *dev,
 	return dev->audio_parm_answer == 1 ? 0 : -EINVAL;
 }
 
-int snd_usb_caiaq_set_auto_msg (struct snd_usb_caiaqdev *dev, 
-				int digital, int analog, int erp)
+int snd_usb_caiaq_set_auto_msg(struct snd_usb_caiaqdev *dev,
+			       int digital, int analog, int erp)
 {
 	char tmp[3] = { digital, analog, erp };
 	return snd_usb_caiaq_send_command(dev, EP1_CMD_AUTO_MSG,
@@ -262,7 +262,7 @@ static void __devinit setup_card(struct snd_usb_caiaqdev *dev)
 {
 	int ret;
 	char val[4];
-	
+
 	/* device-specific startup specials */
 	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL2):
@@ -314,7 +314,7 @@ static void __devinit setup_card(struct snd_usb_caiaqdev *dev)
 			dev->control_state, 1);
 		break;
 	}
-	
+
 	if (dev->spec.num_analog_audio_out +
 	    dev->spec.num_analog_audio_in +
 	    dev->spec.num_digital_audio_out +
@@ -323,7 +323,7 @@ static void __devinit setup_card(struct snd_usb_caiaqdev *dev)
 		if (ret < 0)
 			log("Unable to set up audio system (ret=%d)\n", ret);
 	}
-	
+
 	if (dev->spec.num_midi_in +
 	    dev->spec.num_midi_out > 0) {
 		ret = snd_usb_caiaq_midi_init(dev);
@@ -363,7 +363,7 @@ static int create_card(struct usb_device* usb_dev, struct snd_card **cardp)
 	if (devnum >= SNDRV_CARDS)
 		return -ENODEV;
 
-	err = snd_card_create(index[devnum], id[devnum], THIS_MODULE, 
+	err = snd_card_create(index[devnum], id[devnum], THIS_MODULE,
 			      sizeof(struct snd_usb_caiaqdev), &card);
 	if (err < 0)
 		return err;
@@ -386,7 +386,7 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
 	struct usb_device *usb_dev = dev->chip.dev;
 	struct snd_card *card = dev->chip.card;
 	int err, len;
-	
+
 	if (usb_set_interface(usb_dev, 0, 1) != 0) {
 		log("can't set alt interface.\n");
 		return -EIO;
@@ -395,19 +395,19 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
 	usb_init_urb(&dev->ep1_in_urb);
 	usb_init_urb(&dev->midi_out_urb);
 
-	usb_fill_bulk_urb(&dev->ep1_in_urb, usb_dev, 
+	usb_fill_bulk_urb(&dev->ep1_in_urb, usb_dev,
 			  usb_rcvbulkpipe(usb_dev, 0x1),
-			  dev->ep1_in_buf, EP1_BUFSIZE, 
+			  dev->ep1_in_buf, EP1_BUFSIZE,
 			  usb_ep1_command_reply_dispatch, dev);
 
-	usb_fill_bulk_urb(&dev->midi_out_urb, usb_dev, 
+	usb_fill_bulk_urb(&dev->midi_out_urb, usb_dev,
 			  usb_sndbulkpipe(usb_dev, 0x1),
-			  dev->midi_out_buf, EP1_BUFSIZE, 
+			  dev->midi_out_buf, EP1_BUFSIZE,
 			  snd_usb_caiaq_midi_output_done, dev);
-	
+
 	init_waitqueue_head(&dev->ep1_wait_queue);
 	init_waitqueue_head(&dev->prepare_wait_queue);
-	
+
 	if (usb_submit_urb(&dev->ep1_in_urb, GFP_KERNEL) != 0)
 		return -EIO;
 
@@ -420,10 +420,10 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
 
 	usb_string(usb_dev, usb_dev->descriptor.iManufacturer,
 		   dev->vendor_name, CAIAQ_USB_STR_LEN);
-	
+
 	usb_string(usb_dev, usb_dev->descriptor.iProduct,
 		   dev->product_name, CAIAQ_USB_STR_LEN);
-	
+
 	usb_string(usb_dev, usb_dev->descriptor.iSerialNumber,
 		   dev->serial, CAIAQ_USB_STR_LEN);
 
@@ -431,7 +431,7 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
 	c = strchr(dev->serial, ' ');
 	if (c)
 		*c = '\0';
-	
+
 	strcpy(card->driver, MODNAME);
 	strcpy(card->shortname, dev->product_name);
 
@@ -449,18 +449,18 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
 	return 0;
 }
 
-static int __devinit snd_probe(struct usb_interface *intf, 
+static int __devinit snd_probe(struct usb_interface *intf,
 		     const struct usb_device_id *id)
 {
 	int ret;
 	struct snd_card *card;
 	struct usb_device *device = interface_to_usbdev(intf);
-	
+
 	ret = create_card(device, &card);
-	
+
 	if (ret < 0)
 		return ret;
-			
+
 	usb_set_intfdata(intf, card);
 	ret = init_card(caiaqdev(card));
 	if (ret < 0) {
@@ -468,7 +468,7 @@ static int __devinit snd_probe(struct usb_interface *intf,
 		snd_card_free(card);
 		return ret;
 	}
-	
+
 	return 0;
 }
 
@@ -489,10 +489,10 @@ static void snd_disconnect(struct usb_interface *intf)
 	snd_usb_caiaq_input_free(dev);
 #endif
 	snd_usb_caiaq_audio_free(dev);
-	
+
 	usb_kill_urb(&dev->ep1_in_urb);
 	usb_kill_urb(&dev->midi_out_urb);
-	
+
 	snd_card_free(card);
 	usb_reset_device(interface_to_usbdev(intf));
 }
diff --git a/sound/usb/caiaq/midi.c b/sound/usb/caiaq/midi.c
index 8fa8cd8..538e8c0 100644
--- a/sound/usb/caiaq/midi.c
+++ b/sound/usb/caiaq/midi.c
@@ -40,7 +40,7 @@ static void snd_usb_caiaq_midi_input_trigger(struct snd_rawmidi_substream *subst
 
 	if (!dev)
 		return;
-	
+
 	dev->midi_receive_substream = up ? substream : NULL;
 }
 
@@ -64,18 +64,18 @@ static void snd_usb_caiaq_midi_send(struct snd_usb_caiaqdev *dev,
 				    struct snd_rawmidi_substream *substream)
 {
 	int len, ret;
-	
+
 	dev->midi_out_buf[0] = EP1_CMD_MIDI_WRITE;
 	dev->midi_out_buf[1] = 0; /* port */
 	len = snd_rawmidi_transmit(substream, dev->midi_out_buf + 3,
 				   EP1_BUFSIZE - 3);
-	
+
 	if (len <= 0)
 		return;
-	
+
 	dev->midi_out_buf[2] = len;
 	dev->midi_out_urb.transfer_buffer_length = len+3;
-	
+
 	ret = usb_submit_urb(&dev->midi_out_urb, GFP_ATOMIC);
 	if (ret < 0)
 		log("snd_usb_caiaq_midi_send(%p): usb_submit_urb() failed,"
@@ -88,7 +88,7 @@ static void snd_usb_caiaq_midi_send(struct snd_usb_caiaqdev *dev,
 static void snd_usb_caiaq_midi_output_trigger(struct snd_rawmidi_substream *substream, int up)
 {
 	struct snd_usb_caiaqdev *dev = substream->rmidi->private_data;
-	
+
 	if (up) {
 		dev->midi_out_substream = substream;
 		if (!dev->midi_out_active)
@@ -113,12 +113,12 @@ static struct snd_rawmidi_ops snd_usb_caiaq_midi_input =
 	.trigger =      snd_usb_caiaq_midi_input_trigger,
 };
 
-void snd_usb_caiaq_midi_handle_input(struct snd_usb_caiaqdev *dev, 
+void snd_usb_caiaq_midi_handle_input(struct snd_usb_caiaqdev *dev,
 				     int port, const char *buf, int len)
 {
 	if (!dev->midi_receive_substream)
 		return;
-	
+
 	snd_rawmidi_receive(dev->midi_receive_substream, buf, len);
 }
 
@@ -142,16 +142,16 @@ int snd_usb_caiaq_midi_init(struct snd_usb_caiaqdev *device)
 
 	if (device->spec.num_midi_out > 0) {
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
-		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, 
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
 				    &snd_usb_caiaq_midi_output);
 	}
 
 	if (device->spec.num_midi_in > 0) {
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
-		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, 
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
 				    &snd_usb_caiaq_midi_input);
 	}
-	
+
 	device->rmidi = rmidi;
 
 	return 0;
@@ -160,7 +160,7 @@ int snd_usb_caiaq_midi_init(struct snd_usb_caiaqdev *device)
 void snd_usb_caiaq_midi_output_done(struct urb* urb)
 {
 	struct snd_usb_caiaqdev *dev = urb->context;
-	
+
 	dev->midi_out_active = 0;
 	if (urb->status != 0)
 		return;
-- 
1.6.3.1
