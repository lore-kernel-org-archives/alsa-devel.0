From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-usx2y 0.7.2
Date: Tue, 3 Aug 2004 00:20:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408030020.06489.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_W4rDBv4eUqcawDt"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Martin Langer <martin-langer@gmx.de>, Rui Nuno Capela <rncbc@rncbc.org>, Werner Schweer <ws@seh.de>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_W4rDBv4eUqcawDt
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This deletes struct snd_usX2Y_stream to simplify things.

cheers,
Karsten

--Boundary-00=_W4rDBv4eUqcawDt
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-usx2y.patch.0.7.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.7.2"

Index: alsa-driver/usb/usx2y/usX2Yhwdep.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usX2Yhwdep.c,v
retrieving revision 1.7
diff -u -r1.7 usX2Yhwdep.c
--- alsa-driver/usb/usx2y/usX2Yhwdep.c	15 Jun 2004 10:55:39 -0000	1.7
+++ alsa-driver/usb/usx2y/usX2Yhwdep.c	2 Aug 2004 21:56:36 -0000
@@ -349,8 +349,6 @@
 	hw->ops.poll = snd_us428ctls_poll;
 	hw->exclusive = 1;
 	sprintf(hw->name, "/proc/bus/usb/%03d/%03d", device->bus->busnum, device->devnum);
-	usX2Y(card)->hwdep = hw;
-
 	return 0;
 }
 
Index: alsa-driver/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.c,v
retrieving revision 1.14
diff -u -r1.14 usbusx2y.c
--- alsa-driver/usb/usx2y/usbusx2y.c	13 Jul 2004 16:21:06 -0000	1.14
+++ alsa-driver/usb/usx2y/usbusx2y.c	2 Aug 2004 21:56:36 -0000
@@ -113,7 +113,7 @@
 
 
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
-MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.7.1");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.7.2");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001)(0x8005)(0x8007) }}");
 
Index: alsa-driver/usb/usx2y/usbusx2y.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.h,v
retrieving revision 1.7
diff -u -r1.7 usbusx2y.h
--- alsa-driver/usb/usx2y/usbusx2y.h	13 Jul 2004 16:21:06 -0000	1.7
+++ alsa-driver/usb/usx2y/usbusx2y.h	2 Aug 2004 21:56:37 -0000
@@ -5,7 +5,8 @@
 #include "usbus428ctldefs.h" 
 
 #define NRURBS	        2	/* */
-#define NRPACKS		1	/* usb-frames/ms per urb: 1 and 2 are supported.
+#define NRPACKS		1	/* FIXME: Currently only 1 works.
+				   usb-frames/ms per urb: 1 and 2 are supported.
 				   setting to 2 will PERHAPS make it easier for slow machines.
 				   Jitter will be higher though.
 				   On my PIII 500Mhz Laptop setting to 1 is the only way to go 
@@ -26,25 +27,26 @@
 	struct urb*	urb[0];
 } snd_usX2Y_urbSeq_t;
 
+typedef struct snd_usX2Y_substream snd_usX2Y_substream_t;
 
 typedef struct {
 	snd_usb_audio_t 	chip;
 	int			stride;
-	struct urb*		In04urb;
-	void*			In04Buf;
+	struct urb		*In04urb;
+	void			*In04Buf;
 	char			In04Last[24];
 	unsigned		In04IntCalls;
-	snd_usX2Y_urbSeq_t*	US04;
+	snd_usX2Y_urbSeq_t	*US04;
 	wait_queue_head_t	In04WaitQueue;
 	snd_usX2Y_AsyncSeq_t	AS04;
 	unsigned int		rate,
 				format;
 	int			refframes;
-	snd_hwdep_t*		hwdep;
 	int			chip_status;
 	struct semaphore	open_mutex;
-	us428ctls_sharedmem_t*	us428ctls_sharedmem;
+	us428ctls_sharedmem_t	*us428ctls_sharedmem;
 	wait_queue_head_t	us428ctls_wait_queue_head;
+	snd_usX2Y_substream_t	*substream[4];
 } usX2Ydev_t;
 
 
Index: alsa-driver/usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.17
diff -u -r1.17 usbusx2yaudio.c
--- alsa-driver/usb/usx2y/usbusx2yaudio.c	29 Jul 2004 06:29:21 -0000	1.17
+++ alsa-driver/usb/usx2y/usbusx2yaudio.c	2 Aug 2004 21:56:38 -0000
@@ -58,63 +58,32 @@
 
 
 
-typedef struct snd_usX2Y_substream snd_usX2Y_substream_t;
-typedef struct snd_usX2Y_stream snd_usX2Y_stream_t;
-
-
 struct snd_usX2Y_substream {
-	snd_usX2Y_stream_t *stream;
+	usX2Ydev_t	*usX2Y;
 	snd_pcm_substream_t *pcm_substream;
 
-	unsigned char	endpoint;		
-	unsigned int	datapipe;  		/* the data i/o pipe */
-	unsigned int	maxpacksize;		/* max packet size in bytes */
-
-	char		prepared,
-			running,
-			stalled;
-
-	int		hwptr;			/* free frame position in the buffer (only for playback) */
-	int		hwptr_done;		/* processed frame position in the buffer */
-	int		transfer_done;		/* processed frames since last period update */
-
-	struct urb	*urb[NRURBS];	/* data urb table */
-	int		next_urb_complete;
-	struct urb	*completed_urb;
-	char		*tmpbuf;			/* temporary buffer for playback */
-	volatile int	submitted_urbs;
-};
-
-
-struct snd_usX2Y_stream {
-	usX2Ydev_t*		usX2Y;
-	snd_pcm_t*		pcm;
-	snd_usX2Y_substream_t	substream[2];
+	unsigned char		endpoint;		
+	unsigned int		datapipe;  		/* the data i/o pipe */
+	unsigned int		maxpacksize;		/* max packet size in bytes */
+
+	char			prepared,
+				running,
+				stalled;
+
+	int			hwptr;			/* free frame position in the buffer (only for playback) */
+	int			hwptr_done;		/* processed frame position in the buffer */
+	int			transfer_done;		/* processed frames since last period update */
+
+	struct urb		*urb[NRURBS];	/* data urb table */
+	int			next_urb_complete;
+	struct urb		*completed_urb;
+	char			*tmpbuf;			/* temporary buffer for playback */
+	volatile int		submitted_urbs;
+	wait_queue_head_t	wait_queue;
 };
 
 
 
-/*
- * prepare urb for capture data pipe
- *
- * fill the offset and length of each descriptor.
- *
- * we use a temporary buffer to write the captured data.
- * since the length of written data is determined by host, we cannot
- * write onto the pcm buffer directly...  the data is thus copied
- * later at complete callback to the global buffer.
- */
-static int usX2Y_urb_capt_prepare(snd_usX2Y_substream_t *subs, struct urb *urb)
-{
-	unsigned long pack;
-	urb->dev = subs->stream->usX2Y->chip.dev; /* we need to set this at each time */
-	for (pack = 0; pack < NRPACKS; pack++) {
-		urb->iso_frame_desc[pack].offset = subs->maxpacksize * pack;
-		urb->iso_frame_desc[pack].length = subs->maxpacksize;
-	}
-	urb->transfer_buffer_length = subs->maxpacksize * NRPACKS; 
-	return 0;
-}
 
 
 
@@ -124,7 +93,7 @@
 	snd_pcm_runtime_t *runtime = subs->pcm_substream->runtime;
 	unsigned char	*cp;
 	int 		i, len, lens = 0, hwptr_done = subs->hwptr_done;
-	usX2Ydev_t	*usX2Y = subs->stream->usX2Y;
+	usX2Ydev_t	*usX2Y = subs->usX2Y;
 
 	for (i = 0; i < NRPACKS; i++) {
 		cp = (unsigned char*)urb->transfer_buffer + urb->iso_frame_desc[i].offset;
@@ -176,7 +145,7 @@
 				  struct urb *urb)
 {
 	int count, counts, pack;
-	usX2Ydev_t* usX2Y = subs->stream->usX2Y;
+	usX2Ydev_t* usX2Y = subs->usX2Y;
 	snd_pcm_runtime_t *runtime = subs->pcm_substream->runtime;
 
 	count = 0;
@@ -225,7 +194,7 @@
 #if NRPACKS > 1
 			       + urb->iso_frame_desc[1].actual_length
 #endif
-		               ) / subs->stream->usX2Y->stride;
+		               ) / subs->usX2Y->stride;
 
 	subs->transfer_done += len;
 	subs->hwptr_done +=  len;
@@ -245,7 +214,7 @@
 		return -ENODEV;
 	urb->start_frame = (frame + NRURBS*NRPACKS) & (1024 - 1);
 	urb->hcpriv = NULL;
-	urb->dev = subs->stream->usX2Y->chip.dev; /* we need to set this at each time */
+	urb->dev = subs->usX2Y->chip.dev; /* we need to set this at each time */
 	if ((err = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
 		snd_printk("%i\n", err);
 		return err;
@@ -320,15 +289,13 @@
 
 static void usX2Y_clients_stop(snd_usX2Y_substream_t *subs)
 {
-	snd_usX2Y_stream_t *stream = subs->stream;
-	snd_usX2Y_substream_t *capsubs = stream->substream + SNDRV_PCM_STREAM_CAPTURE,
-		*playbacksubs = stream->substream + SNDRV_PCM_STREAM_PLAYBACK;
-	if (playbacksubs->running)
-		snd_pcm_stop(playbacksubs->pcm_substream, SNDRV_PCM_STATE_XRUN);
-
-	if (capsubs->running)
-		snd_pcm_stop(capsubs->pcm_substream, SNDRV_PCM_STATE_XRUN);
-
+	usX2Ydev_t *usX2Y = subs->usX2Y;
+	int i;
+	for (i = 0; i < 4; i++) {
+		snd_usX2Y_substream_t *substream = usX2Y->substream[i];
+		if (substream && substream->running)
+			snd_pcm_stop(substream->pcm_substream, SNDRV_PCM_STATE_XRUN);
+	}
 }
 
 
@@ -353,9 +320,11 @@
 		usX2Y_clients_stop(subs);
 		return;
 	}
+	if (waitqueue_active(&subs->wait_queue))
+		wake_up(&subs->wait_queue);
 	{
-		snd_usX2Y_substream_t *capsubs = subs->stream->substream + SNDRV_PCM_STREAM_CAPTURE,
-			*playbacksubs = subs->stream->substream + SNDRV_PCM_STREAM_PLAYBACK;
+		snd_usX2Y_substream_t *capsubs = subs->usX2Y->substream[SNDRV_PCM_STREAM_CAPTURE],
+			*playbacksubs = subs->usX2Y->substream[SNDRV_PCM_STREAM_PLAYBACK];
 		if (capsubs->completed_urb &&
 		    (playbacksubs->completed_urb ||
 		     !playbacksubs->prepared ||
@@ -369,18 +338,27 @@
 }
 
 
-static int usX2Y_urb_start(snd_usX2Y_substream_t *subs)
+static int usX2Y_urbs_capt_start(snd_usX2Y_substream_t *subs)
 {
 	int i, err;
 
 	for (i = 0; i < NRURBS; i++) {
-		subs->urb[i]->transfer_flags = URB_ISO_ASAP;
-		if ((err = usb_submit_urb(subs->urb[i], GFP_ATOMIC)) < 0) {
+		unsigned long pack;
+		struct urb *urb = subs->urb[i];
+		urb->dev = subs->usX2Y->chip.dev;
+		urb->transfer_flags = URB_ISO_ASAP;
+		for (pack = 0; pack < NRPACKS; pack++) {
+			urb->iso_frame_desc[pack].offset = subs->maxpacksize * pack;
+			urb->iso_frame_desc[pack].length = subs->maxpacksize;
+		}
+		urb->transfer_buffer_length = subs->maxpacksize * NRPACKS; 
+		if ((err = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
 			snd_printk (KERN_ERR "cannot submit datapipe for urb %d, err = %d\n", i, err);
 			return -EPIPE;
-		} else
+		} else {
 			subs->submitted_urbs++;
-		subs->urb[i]->transfer_flags = 0;
+		}
+		urb->transfer_flags = 0;
 	}
 	subs->stalled = 0;
 	subs->next_urb_complete = 0;
@@ -424,7 +402,7 @@
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		snd_printd("snd_usX2Y_pcm_trigger(START)\n");
-		if (subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE].stalled)
+		if (subs->usX2Y->substream[SNDRV_PCM_STREAM_CAPTURE]->stalled)
 			return -EPIPE;
 		else
 			subs->running = 1;
@@ -441,7 +419,7 @@
 
 
 
-static void usX2Y_release_urb_ctx(struct urb** urb, int free_tb)
+static void usX2Y_urb_release(struct urb** urb, int free_tb)
 {
 	if (*urb) {
 		if (free_tb)
@@ -459,7 +437,7 @@
 	snd_printd("snd_usX2Y_urbs_release() %i\n", subs->endpoint);
 	usX2Y_urbs_wait_clear(subs);
 	for (i = 0; i < NRURBS; i++)
-		usX2Y_release_urb_ctx(subs->urb + i, subs == (subs->stream->substream + SNDRV_PCM_STREAM_CAPTURE));
+		usX2Y_urb_release(subs->urb + i, subs != subs->usX2Y->substream[SNDRV_PCM_STREAM_PLAYBACK]);
 
 	if (subs->tmpbuf) {
 		kfree(subs->tmpbuf);
@@ -480,21 +458,27 @@
 /*
  * initialize a substream's urbs
  */
-static int usX2Y_urbs_allocate(snd_usX2Y_substream_t *subs, snd_pcm_runtime_t *runtime)
+static int usX2Y_urbs_allocate(snd_usX2Y_substream_t *subs)
 {
 	int i;
-	int is_playback = subs == (subs->stream->substream + SNDRV_PCM_STREAM_PLAYBACK);
+	int is_playback = subs == subs->usX2Y->substream[SNDRV_PCM_STREAM_PLAYBACK];
+	struct usb_device *dev = subs->usX2Y->chip.dev;
 
 	snd_assert(!subs->prepared, return 0);
 
-	/* allocate a temporary buffer for playback */
-	if (is_playback && ! subs->tmpbuf) {
-		subs->tmpbuf = kmalloc(subs->maxpacksize * NRPACKS, GFP_KERNEL);
-		if (! subs->tmpbuf) {
-			snd_printk(KERN_ERR "cannot malloc tmpbuf\n");
-			return -ENOMEM;
+	if (is_playback) {	/* allocate a temporary buffer for playback */
+		subs->datapipe = usb_sndisocpipe(dev, subs->endpoint);
+		subs->maxpacksize = dev->epmaxpacketout[subs->endpoint];
+		if (NULL == subs->tmpbuf) {
+			subs->tmpbuf = kcalloc(NRPACKS, subs->maxpacksize, GFP_KERNEL);
+			if (NULL == subs->tmpbuf) {
+				snd_printk(KERN_ERR "cannot malloc tmpbuf\n");
+				return -ENOMEM;
+			}
 		}
-		memset(subs->tmpbuf, 0, subs->maxpacksize * NRPACKS);
+	} else {
+		subs->datapipe = usb_rcvisocpipe(dev, subs->endpoint);
+		subs->maxpacksize = dev->epmaxpacketin[subs->endpoint];
 	}
 
 	/* allocate and initialize data urbs */
@@ -503,19 +487,19 @@
 		if (*purb)
 			continue;
 		*purb = usb_alloc_urb(NRPACKS, GFP_KERNEL);
-		if (! *purb) {
+		if (NULL == *purb) {
 			usX2Y_urbs_release(subs);
 			return -ENOMEM;
 		}
 		if (!is_playback && !(*purb)->transfer_buffer) {
 			/* allocate a capture buffer per urb */
 			(*purb)->transfer_buffer = kmalloc(subs->maxpacksize*NRPACKS, GFP_KERNEL);
-			if (!(*purb)->transfer_buffer) {
+			if (NULL == (*purb)->transfer_buffer) {
 				usX2Y_urbs_release(subs);
 				return -ENOMEM;
 			}
 		}
-		(*purb)->dev = subs->stream->usX2Y->chip.dev;
+		(*purb)->dev = dev;
 		(*purb)->pipe = subs->datapipe;
 		(*purb)->number_of_packets = NRPACKS;
 		(*purb)->context = subs;
@@ -525,24 +509,6 @@
 	return 0;
 }
 
-/*
- * find a matching format and set up the interface
- */
-static int usX2Y_set_format(snd_usX2Y_substream_t *subs, snd_pcm_runtime_t *runtime)
-{
-	struct usb_device *dev = subs->stream->usX2Y->chip.dev;
-	snd_printd("about to set format: format = %s, rate = %d, channels = %d\n",
-			   snd_pcm_format_name(runtime->format), runtime->rate, runtime->channels);
-	/* create data pipes */
-	if (subs == (subs->stream->substream + SNDRV_PCM_STREAM_PLAYBACK)) {
-		subs->datapipe = usb_sndisocpipe(dev, subs->endpoint);
-		subs->maxpacksize = dev->epmaxpacketout[subs->endpoint];
-	} else {
-		subs->datapipe = usb_rcvisocpipe(dev, subs->endpoint);
-		subs->maxpacksize = dev->epmaxpacketin[subs->endpoint];
-	}
-	return 0;
-}
 
 #ifndef OLD_USB
 static void i_usX2Y_04Int(struct urb* urb, struct pt_regs *regs)
@@ -557,7 +523,7 @@
 		return;
 	}
 	if (0 == --usX2Y->US04->len)
-		wake_up_interruptible(&usX2Y->In04WaitQueue);
+		wake_up(&usX2Y->In04WaitQueue);
 }
 /*
  * allocate a buffer, setup samplerate
@@ -645,7 +611,7 @@
 };
 #define NOOF_SETRATE_URBS ARRAY_SIZE(SetRate48000)
 
-static int usX2Y_rate_set(snd_usX2Y_stream_t *usX2Y_stream, int rate)
+static int usX2Y_rate_set(usX2Ydev_t *usX2Y, int rate)
 {
 	int			err = 0, i;
 	snd_usX2Y_urbSeq_t	*us = NULL;
@@ -653,7 +619,7 @@
 	DECLARE_WAITQUEUE(wait, current);
 	struct s_c2		*ra = rate == 48000 ? SetRate48000 : SetRate44100;
 
-	if (usX2Y_stream->usX2Y->rate != rate) {
+	if (usX2Y->rate != rate) {
 		do {
 			us = kmalloc(sizeof(*us) + sizeof(struct urb*) * NOOF_SETRATE_URBS, GFP_KERNEL);
 			if (NULL == us) {
@@ -673,8 +639,8 @@
 				}
 				((char*)(usbdata + i))[0] = ra[i].c1;
 				((char*)(usbdata + i))[1] = ra[i].c2;
-				usb_fill_bulk_urb(us->urb[i], usX2Y_stream->usX2Y->chip.dev, usb_sndbulkpipe(usX2Y_stream->usX2Y->chip.dev, 4),
-						  usbdata + i, 2, i_usX2Y_04Int, usX2Y_stream->usX2Y);
+				usb_fill_bulk_urb(us->urb[i], usX2Y->chip.dev, usb_sndbulkpipe(usX2Y->chip.dev, 4),
+						  usbdata + i, 2, i_usX2Y_04Int, usX2Y);
 #ifdef OLD_USB
 				us->urb[i]->transfer_flags = USB_QUEUE_BULK;
 #endif
@@ -682,11 +648,11 @@
 			if (err)
 				break;
 
-			add_wait_queue(&usX2Y_stream->usX2Y->In04WaitQueue, &wait);
+			add_wait_queue(&usX2Y->In04WaitQueue, &wait);
 			set_current_state(TASK_INTERRUPTIBLE);
-			us->submitted =		0;
-			us->len =		NOOF_SETRATE_URBS;
-			usX2Y_stream->usX2Y->US04 =	us;
+			us->submitted =	0;
+			us->len =	NOOF_SETRATE_URBS;
+			usX2Y->US04 =	us;
 		
 			do {
 				signed long	timeout = schedule_timeout(HZ/2);
@@ -699,11 +665,11 @@
 					err = -ENODEV;
 					break;
 				}
-				usX2Y_stream->usX2Y->rate = rate;
-				usX2Y_stream->usX2Y->refframes = rate == 48000 ? 47 : 44;
+				usX2Y->rate = rate;
+				usX2Y->refframes = rate == 48000 ? 47 : 44;
 			} while (0);
 		
-			remove_wait_queue(&usX2Y_stream->usX2Y->In04WaitQueue, &wait);
+			remove_wait_queue(&usX2Y->In04WaitQueue, &wait);
 		} while (0);
 
 		if (us) {
@@ -712,7 +678,7 @@
 				usb_unlink_urb(us->urb[i]);
 				usb_free_urb(us->urb[i]);
 			}
-			usX2Y_stream->usX2Y->US04 = NULL;
+			usX2Y->US04 = NULL;
 			kfree(usbdata);
 			kfree(us);
 		}
@@ -754,8 +720,8 @@
 }
 
 
-static int snd_usX2Y_hw_params(snd_pcm_substream_t *substream,
-			       snd_pcm_hw_params_t *hw_params)
+static int snd_usX2Y_pcm_hw_params(snd_pcm_substream_t *substream,
+				   snd_pcm_hw_params_t *hw_params)
 {
 	int			err = 0;
 	unsigned int		rate = params_rate(hw_params);
@@ -786,22 +752,23 @@
 			}
 		}
 	}
-
-	if (0 > (err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))))
-		snd_printd("snd_pcm_lib_malloc_pages(%p, %i) returned %i\n", substream, params_buffer_bytes(hw_params), err);
-	return err;
+	if (0 > (err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params)))) {
+		snd_printk("snd_pcm_lib_malloc_pages(%p, %i) returned %i\n", substream, params_buffer_bytes(hw_params), err);
+		return err;
+	}
+	return 0;
 }
 /*
  * free the buffer
  */
-static int snd_usX2Y_hw_free(snd_pcm_substream_t *substream)
+static int snd_usX2Y_pcm_hw_free(snd_pcm_substream_t *substream)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_usX2Y_substream_t *subs = (snd_usX2Y_substream_t *)runtime->private_data;
 	snd_printd("snd_usX2Y_hw_free(%p)\n", substream);
 
 	if (SNDRV_PCM_STREAM_PLAYBACK == substream->stream) {
-		snd_usX2Y_substream_t *cap_subs = subs->stream->substream + SNDRV_PCM_STREAM_CAPTURE;
+		snd_usX2Y_substream_t *cap_subs = subs->usX2Y->substream[SNDRV_PCM_STREAM_CAPTURE];
 		subs->prepared = 0;
 		usX2Y_urbs_release(subs);
 		if (!cap_subs->pcm_substream ||
@@ -812,7 +779,7 @@
 			usX2Y_urbs_release(cap_subs);
 		}
 	} else {
-		snd_usX2Y_substream_t *playback_subs = subs->stream->substream + SNDRV_PCM_STREAM_PLAYBACK;
+		snd_usX2Y_substream_t *playback_subs = subs->usX2Y->substream[SNDRV_PCM_STREAM_PLAYBACK];
 		if (!playback_subs->prepared) {
 			subs->prepared = 0;
 			usX2Y_urbs_release(subs);
@@ -830,40 +797,47 @@
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_usX2Y_substream_t *subs = (snd_usX2Y_substream_t *)runtime->private_data;
-	snd_usX2Y_substream_t *capsubs = subs->stream->substream + SNDRV_PCM_STREAM_CAPTURE;
+	snd_usX2Y_substream_t *capsubs = subs->usX2Y->substream[SNDRV_PCM_STREAM_CAPTURE];
 	int err = 0;
 	snd_printd("snd_usX2Y_pcm_prepare(%p)\n", substream);
 
 // Start hardware streams
 // SyncStream first....
 	if (! capsubs->prepared) {
-		int  i;
-		if (subs->stream->usX2Y->format != runtime->format)
-			if ((err = usX2Y_format_set(subs->stream->usX2Y, runtime->format)) < 0)
+		if (subs->usX2Y->format != runtime->format)
+			if ((err = usX2Y_format_set(subs->usX2Y, runtime->format)) < 0)
 				return err;
-		if (subs->stream->usX2Y->rate != runtime->rate)
-			if ((err = usX2Y_rate_set(subs->stream, runtime->rate)) < 0)
+		if (subs->usX2Y->rate != runtime->rate)
+			if ((err = usX2Y_rate_set(subs->usX2Y, runtime->rate)) < 0)
 				return err;
 		snd_printd("starting capture pipe for playpipe\n");
-		usX2Y_set_format(capsubs, runtime);
-		usX2Y_urbs_allocate(capsubs, runtime);
-		for (i = 0; i < NRURBS; i++) {
-			snd_assert(capsubs->urb/* [ep] */[i], return -EINVAL);
-			if ((err = usX2Y_urb_capt_prepare(capsubs, capsubs->urb[i])) < 0) {
-				snd_printk(KERN_ERR "cannot prepare datapipe for urb %d\n", i);
-				return err;
+		usX2Y_urbs_allocate(capsubs);
+		capsubs->completed_urb = 0;
+		{
+			DECLARE_WAITQUEUE(wait, current);
+			add_wait_queue(&capsubs->wait_queue, &wait);
+			if (0 <= (err = usX2Y_urbs_capt_start(capsubs))) {
+				signed long timeout;
+				set_current_state(TASK_INTERRUPTIBLE);
+				timeout = schedule_timeout(HZ/4);
+				if (signal_pending(current))
+					err = -ERESTARTSYS;
+				else {
+					snd_printd("%li\n", HZ/4 - timeout);
+					if (0 == timeout)
+						err = -EPIPE;
+				}
 			}
+			remove_wait_queue(&capsubs->wait_queue, &wait);
+			if (0 > err)
+				return err;
 		}
-		capsubs->completed_urb = 0;
-		err = usX2Y_urb_start(capsubs);
 	}
 
 	if (subs != capsubs) {
 		int u;
 		if (!subs->prepared) {
-			if ((err = usX2Y_set_format(subs, runtime)) < 0)
-				return err;
-			if ((err = usX2Y_urbs_allocate(subs, runtime)) < 0)
+			if ((err = usX2Y_urbs_allocate(subs)) < 0)
 				return err;
 			subs->prepared = 1;
 		}
@@ -914,9 +888,9 @@
 
 static int snd_usX2Y_pcm_open(snd_pcm_substream_t *substream)
 {
-	snd_usX2Y_stream_t	*as = snd_pcm_substream_chip(substream);
+	snd_usX2Y_substream_t	*subs = ((snd_usX2Y_substream_t **)
+					 snd_pcm_substream_chip(substream))[substream->stream];
 	snd_pcm_runtime_t	*runtime = substream->runtime;
-	snd_usX2Y_substream_t	*subs = &as->substream[substream->stream];
 
 	runtime->hw = snd_usX2Y_2c;
 	runtime->private_data = subs;
@@ -944,110 +918,86 @@
 	.open =		snd_usX2Y_pcm_open,
 	.close =	snd_usX2Y_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_usX2Y_hw_params,
-	.hw_free =	snd_usX2Y_hw_free,
+	.hw_params =	snd_usX2Y_pcm_hw_params,
+	.hw_free =	snd_usX2Y_pcm_hw_free,
 	.prepare =	snd_usX2Y_pcm_prepare,
 	.trigger =	snd_usX2Y_pcm_trigger,
 	.pointer =	snd_usX2Y_pcm_pointer,
 };
 
-/*
- * intialize the substream instance.
- */
-static snd_usX2Y_substream_t *usX2Y_substream_init(snd_usX2Y_stream_t *stream, enum sndrv_pcm_stream  dir)
-{
-	struct usb_device *dev;
-	snd_usX2Y_substream_t *subs = stream->substream + dir;
-
-	dev = stream->usX2Y->chip.dev;
-	if (SNDRV_PCM_STREAM_PLAYBACK == dir) {
-		subs->endpoint = 0x0A;
-	} else {
-		subs->endpoint = 0x08;
-	}
-	subs->stream = stream;
-	return subs;
-}
-
-
-/*
- * free a substream
- */
-static void usX2Y_substream_free(snd_usX2Y_substream_t *subs)
-{
-}
-
-
 
 /*
  * free a usb stream instance
  */
-static void usX2Y_audio_stream_free(snd_usX2Y_stream_t *stream)
+static void usX2Y_audio_stream_free(snd_usX2Y_substream_t **usX2Y_substream)
 {
-	usX2Y_substream_free(&stream->substream[SNDRV_PCM_STREAM_PLAYBACK]);
-	usX2Y_substream_free(&stream->substream[SNDRV_PCM_STREAM_CAPTURE]);
-	kfree(stream);
+	if (NULL != usX2Y_substream[SNDRV_PCM_STREAM_PLAYBACK]) {
+		kfree(usX2Y_substream[SNDRV_PCM_STREAM_PLAYBACK]);
+		usX2Y_substream[SNDRV_PCM_STREAM_PLAYBACK] = NULL;
+	}
+	kfree(usX2Y_substream[SNDRV_PCM_STREAM_CAPTURE]);
+	usX2Y_substream[SNDRV_PCM_STREAM_CAPTURE] = NULL;
 }
 
-static void snd_usX2Y_audio_pcm_free(snd_pcm_t *pcm)
+static void snd_usX2Y_pcm_private_free(snd_pcm_t *pcm)
 {
-	snd_usX2Y_stream_t *stream = pcm->private_data;
-	if (stream) {
-		stream->pcm = NULL;
+	snd_usX2Y_substream_t **usX2Y_stream = pcm->private_data;
+	if (usX2Y_stream) {
 		snd_pcm_lib_preallocate_free_for_all(pcm);
-		usX2Y_audio_stream_free(stream);
+		usX2Y_audio_stream_free(usX2Y_stream);
 	}
 }
 
-static int usX2Y_audio_stream_new(snd_card_t* card)
+static int usX2Y_audio_stream_new(snd_card_t *card, int playback_endpoint, int capture_endpoint)
 {
-	snd_usX2Y_stream_t *usX2Y_stream;
-	snd_usX2Y_substream_t *usX2Y_capt_substream;
 	snd_pcm_t *pcm;
-	int err;
-
-	usX2Y_stream = kmalloc(sizeof(snd_usX2Y_stream_t), GFP_KERNEL);
-	if (usX2Y_stream == NULL) {
-		snd_printk(KERN_ERR "cannot malloc\n");
-		return -ENOMEM;
+	int err, i;
+	snd_usX2Y_substream_t **usX2Y_substream =
+		usX2Y(card)->substream + 2 * usX2Y(card)->chip.pcm_devs;
+
+	for (i = playback_endpoint ? SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
+	     i <= SNDRV_PCM_STREAM_CAPTURE; ++i) {
+		usX2Y_substream[i] = kcalloc(1, sizeof(snd_usX2Y_substream_t), GFP_KERNEL);
+		if (NULL == usX2Y_substream[i]) {
+			snd_printk(KERN_ERR "cannot malloc\n");
+			return -ENOMEM;
+		}
+		init_waitqueue_head(&usX2Y_substream[i]->wait_queue);
+		usX2Y_substream[i]->usX2Y = usX2Y(card);
 	}
-	memset(usX2Y_stream, 0, sizeof(*usX2Y_stream));
-	usX2Y_stream->usX2Y = usX2Y(card);
 
-	usX2Y_substream_init(usX2Y_stream, SNDRV_PCM_STREAM_PLAYBACK);
-	usX2Y_capt_substream = usX2Y_substream_init(usX2Y_stream, SNDRV_PCM_STREAM_CAPTURE);
+	if (playback_endpoint)
+		usX2Y_substream[SNDRV_PCM_STREAM_PLAYBACK]->endpoint = playback_endpoint;
+	usX2Y_substream[SNDRV_PCM_STREAM_CAPTURE]->endpoint = capture_endpoint;
 
 	err = snd_pcm_new(card, NAME_ALLCAPS" Audio", usX2Y(card)->chip.pcm_devs,
-			  1,
-			  1,
+			  playback_endpoint ? 1 : 0, 1,
 			  &pcm);
 	if (err < 0) {
-		usX2Y_audio_stream_free(usX2Y_stream);
+		usX2Y_audio_stream_free(usX2Y_substream);
 		return err;
 	}
 
-	usX2Y_stream->pcm = pcm;
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_usX2Y_pcm_ops);
+	if (playback_endpoint)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_usX2Y_pcm_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_usX2Y_pcm_ops);
 
-	pcm->private_data = usX2Y_stream;
-	pcm->private_free = snd_usX2Y_audio_pcm_free;
+	pcm->private_data = usX2Y_substream;
+	pcm->private_free = snd_usX2Y_pcm_private_free;
 	pcm->info_flags = 0;
 
 	sprintf(pcm->name, NAME_ALLCAPS" Audio #%d", usX2Y(card)->chip.pcm_devs);
 
-	if (0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,
+	if ((playback_endpoint &&
+	     0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,
 						     SNDRV_DMA_TYPE_CONTINUOUS,
 						     snd_dma_continuous_data(GFP_KERNEL),
-						     64*1024, 128*1024)) ||
+						     64*1024, 128*1024))) ||
 	    0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
 	    					     SNDRV_DMA_TYPE_CONTINUOUS,
 	    					     snd_dma_continuous_data(GFP_KERNEL),
-						     /* usX2Y_capt_substream->endpoints *  */64*1024,
-						     /* usX2Y_capt_substream->endpoints * */ 128*1024)) ||
-	    (usX2Y(card)->chip.dev->descriptor.idProduct != USB_ID_US122 &&
-	     0 > (err = usX2Y_rate_set(usX2Y_stream, 44100)))) {	// Lets us428 recognize output-volume settings, disturbs us122.
-		usX2Y_audio_stream_free(usX2Y_stream);
+						     64*1024, 128*1024))) {
+		snd_usX2Y_pcm_private_free(pcm);
 		return err;
 	}
 	usX2Y(card)->chip.pcm_devs++;
@@ -1061,7 +1011,7 @@
  * here we have to do not much, since pcm and controls are already freed
  *
  */
-static int snd_usX2Y_audio_dev_free(snd_device_t *device)
+static int snd_usX2Y_device_dev_free(snd_device_t *device)
 {
 	return 0;
 }
@@ -1074,7 +1024,7 @@
 {
 	int err = 0;
 	static snd_device_ops_t ops = {
-		.dev_free = snd_usX2Y_audio_dev_free,
+		.dev_free = snd_usX2Y_device_dev_free,
 	};
 	
 	INIT_LIST_HEAD(&usX2Y(card)->chip.pcm_list);
@@ -1084,8 +1034,13 @@
 		return err;
 	}
 
-	err = usX2Y_audio_stream_new(card);
-
+	if (0 > (err = usX2Y_audio_stream_new(card, 0xA, 0x8)))
+		return err;
+	if (usX2Y(card)->chip.dev->descriptor.idProduct == USB_ID_US428)
+	     if (0 > (err = usX2Y_audio_stream_new(card, 0, 0xA)))
+		     return err;
+	if (usX2Y(card)->chip.dev->descriptor.idProduct != USB_ID_US122)
+		err = usX2Y_rate_set(usX2Y(card), 44100);	// Lets us428 recognize output-volume settings, disturbs us122.
 	return err;
 }
 

--Boundary-00=_W4rDBv4eUqcawDt--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
