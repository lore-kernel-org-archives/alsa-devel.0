From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [Patch]snd-usb-us428.patch.0.2
Date: Thu, 23 Oct 2003 19:23:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310231923.11302.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/5Am/o/VXOP6BuI"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_/5Am/o/VXOP6BuI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

This is a Bugfix (sporadic hangups solved), cosmetical treatment and 
feature-enhancement (Setting of PCM-Out Volume according to 
Mastervolume-Slider at device start).
Please commit.

tnx,
Karsten


--Boundary-00=_/5Am/o/VXOP6BuI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-us428.patch.0.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-us428.patch.0.2"

Index: alsa-driver/usb/us428/usX2Yhwdep.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/us428/usX2Yhwdep.c,v
retrieving revision 1.2
diff -u -r1.2 usX2Yhwdep.c
--- alsa-driver/usb/us428/usX2Yhwdep.c	24 Sep 2003 16:45:10 -0000	1.2
+++ alsa-driver/usb/us428/usX2Yhwdep.c	23 Oct 2003 17:01:39 -0000
@@ -93,7 +93,7 @@
 		return -EBUSY;
 
 	/* if userspace tries to mmap beyond end of our buffer, fail */ 
-        if (size > ((PAGE_SIZE - 1 + sizeof(us428ctls_sharedmem_t)) / PAGE_SIZE) * PAGE_SIZE){
+        if (size > ((PAGE_SIZE - 1 + sizeof(us428ctls_sharedmem_t)) / PAGE_SIZE) * PAGE_SIZE) {
 		snd_printd( "%i > %i\n", size,sizeof(us428ctls_sharedmem_t)); 
                 return -EINVAL;
 	}
@@ -103,6 +103,7 @@
 		if(!(us428->us428ctls_sharedmem = snd_malloc_pages(sizeof(us428ctls_sharedmem_t), GFP_KERNEL)))
 			return -ENOMEM;
 		memset(us428->us428ctls_sharedmem, -1, sizeof(us428ctls_sharedmem_t));
+		us428->us428ctls_sharedmem->CtlSnapShotLast = -2;
 	}
 	area->vm_ops = &us428ctls_vm_ops;
 #ifdef VM_RESERVED
@@ -174,11 +175,11 @@
 		i;
 	us428->Seq04 = 0;
 
-	if (NULL == (us428->AS04.buffer = kmalloc(URB_DataLen_AsyncSeq*URBS_AsyncSeq, GFP_KERNEL))){
+	if (NULL == (us428->AS04.buffer = kmalloc(URB_DataLen_AsyncSeq*URBS_AsyncSeq, GFP_KERNEL))) {
 		err = -ENOMEM;
 	}else
-		for (i = 0; i < URBS_AsyncSeq; ++i){
-			if (NULL == (us428->AS04.urb[i] = usb_alloc_urb(0, GFP_KERNEL))){
+		for (i = 0; i < URBS_AsyncSeq; ++i) {
+			if (NULL == (us428->AS04.urb[i] = usb_alloc_urb(0, GFP_KERNEL))) {
 				err = -ENOMEM;
 				break;
 			}
@@ -219,7 +220,7 @@
 	int err;
 
 	do {
-		if ((err = snd_us428_create_usbmidi(card)) < 0){
+		if ((err = snd_us428_create_usbmidi(card)) < 0) {
 			snd_printk("snd_us428_create_alsa_devices: snd_us428_create_usbmidi error %i \n", err);
 			break;
 		}
@@ -238,7 +239,7 @@
 	if (! (us428->In04urb = usb_alloc_urb(0, GFP_KERNEL)))
 		return -ENOMEM;
 
-	if (! (us428->In04Buf = kmalloc(21, GFP_KERNEL))){
+	if (! (us428->In04Buf = kmalloc(21, GFP_KERNEL))) {
 		usb_free_urb(us428->In04urb);
 		return -ENOMEM;
 	}
@@ -276,15 +277,15 @@
 	}
 	if (!err  &&  1 == dsp->index)
 		do {
-			if ((err = snd_us428_AsyncSeq04_init((us428dev_t*)hw->private_data))){
+			if ((err = snd_us428_AsyncSeq04_init((us428dev_t*)hw->private_data))) {
 				snd_printk("snd_us428_AsyncSeq04_init error \n");
 				break;
 			}
-			if ((err = snd_us428_In04_init((us428dev_t*)hw->private_data))){
+			if ((err = snd_us428_In04_init((us428dev_t*)hw->private_data))) {
 				snd_printk("snd_us428_In04_init error \n");
 				break;
 			}
-			if ((err = snd_us428_create_alsa_devices(hw->card))){
+			if ((err = snd_us428_create_alsa_devices(hw->card))) {
 				snd_printk("snd_us428_create_alsa_devices error %i \n", err);
 				snd_card_free(hw->card);
 				break;
Index: alsa-driver/usb/us428/usbus428.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/us428/usbus428.c,v
retrieving revision 1.5
diff -u -r1.5 usbus428.c
--- alsa-driver/usb/us428/usbus428.c	6 Oct 2003 13:15:17 -0000	1.5
+++ alsa-driver/usb/us428/usbus428.c	23 Oct 2003 17:01:39 -0000
@@ -75,7 +75,7 @@
 
 
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
-MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.1");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.2");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
 MODULE_DEVICES("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001) }}");
@@ -131,22 +131,29 @@
 	
 	us428->In04IntCalls++;
 
-	if (urb->status){
+	if (urb->status) {
 		snd_printk( "Interrupt Pipe 4 came back with status=%i\n", urb->status);
 		return;
 	}
 
-        {
-		int diff = -1, i;
 	//	printk("%i:0x%02X ", 8, (int)((unsigned char*)us428->In04Buf)[8]); Master volume shows 0 here if fader is at max during boot ?!?
-		for (i = 0; i < 21; i++) {
-			if (us428->In04Last[i] != ((char*)us428->In04Buf)[i]) {
-				if (diff < 0)
-					diff = i;
-				us428->In04Last[i] = ((char*)us428->In04Buf)[i];
+	if (us428ctls) {
+		int diff = -1;
+		if (-2 == us428ctls->CtlSnapShotLast) {
+			diff = 0;
+			memcpy(us428->In04Last, us428->In04Buf, sizeof(us428->In04Last));
+			us428ctls->CtlSnapShotLast = -1;
+		} else {
+			int i;
+			for (i = 0; i < 21; i++) {
+				if (us428->In04Last[i] != ((char*)us428->In04Buf)[i]) {
+					if (diff < 0)
+						diff = i;
+					us428->In04Last[i] = ((char*)us428->In04Buf)[i];
+				}
 			}
 		}
-		if (diff >= 0  &&  us428ctls) {
+		if (0 <= diff) {
 			int n = us428ctls->CtlSnapShotLast + 1;
 			if (n >= N_us428_ctl_BUFS  ||  n < 0)
 				n = 0;
@@ -186,7 +193,7 @@
 			}
 		}
 
-	if (err){
+	if (err) {
 		snd_printk("In04Int() usb_submit_urb err=%i\n", err);
 	}
 }
Index: alsa-driver/usb/us428/usbus428audio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/us428/usbus428audio.c,v
retrieving revision 1.5
diff -u -r1.5 usbus428audio.c
--- alsa-driver/usb/us428/usbus428audio.c	6 Oct 2003 13:28:07 -0000	1.5
+++ alsa-driver/usb/us428/usbus428audio.c	23 Oct 2003 17:01:41 -0000
@@ -123,7 +123,7 @@
 
 	urb->dev = subs->stream->us428->chip.dev; /* we need to set this at each time */
 	spin_lock_irqsave(&subs->lock, flags);
-	for (pack = 0; pack < NRPACKS; pack++){
+	for (pack = 0; pack < NRPACKS; pack++) {
 		urb->iso_frame_desc[pack].offset = subs->maxpacksize * pack;
 		urb->iso_frame_desc[pack].length = subs->maxpacksize;
 	}
@@ -157,14 +157,13 @@
 	int 		i, len, lens = 0, hwptr_done = subs->hwptr_done;
 	us428dev_t*	us428 = subs->stream->us428;
 
-	for (i = 0; i < NRPACKS; i++){
-		cp = (unsigned char *)urb->transfer_buffer + urb->iso_frame_desc[i].offset;
-		if (urb->iso_frame_desc[i].status){ /* active? hmm, skip this */
+	for (i = 0; i < NRPACKS; i++) {
+		cp = (unsigned char*)urb->transfer_buffer + urb->iso_frame_desc[i].offset;
+		if (urb->iso_frame_desc[i].status) { /* active? hmm, skip this */
 			snd_printd("activ frame status %i\n", urb->iso_frame_desc[i].status);
 			return urb->iso_frame_desc[i].status;
 		}
 		len = urb->iso_frame_desc[i].actual_length / us428->stride;
-		//printk("%03i ",  urb->iso_frame_desc[i].actual_length);
 		{
 			unsigned long x = subs->freqm;
 			x *= (1 << 11) - 1;
@@ -173,24 +172,21 @@
 			x /= (1 << 11);
 			subs->freqm = x ;
 		}
-
-		if (! len){
+		if (! len) {
 			snd_printk("0 == len ERROR!\n");
 			continue;
 		}
-
 		/* update the current pointer */
-		if (urb->pipe == subs->datapipe[0]){
-			int j = subs->start_frame == urb->start_frame ? 1 : 0;//FIXME ???
-
+		if (urb->pipe == subs->datapipe[0]) {
+			int j = subs->start_frame == urb->start_frame ? 1 : 0;//FIXME : j should propably never become 1
 			us428->pipe0Aframes[j][i] = len;
-			if (j){
+			if (j) {
 				us428->play_urb_waiting[1] = us428->play_urb_waiting[0];
 				us428->play_urb_waiting[0] = NULL;
 				snd_printd("%i\n", i);
 			}
 			subs->retired_frame[0] = urb->start_frame;
-		}else{
+		} else {
 			subs->retired_frame[1] = urb->start_frame;
 			if (runtime->channels != 4)
 				break;
@@ -202,7 +198,7 @@
 		/* copy a data chunk */
 		if ((hwptr_done + len) > runtime->buffer_size) {
 			int cnt = runtime->buffer_size - hwptr_done;
-			if (runtime->channels != 4){
+			if (runtime->channels != 4) {
 				int blen = cnt * us428->stride;
 				memcpy(runtime->dma_area + hwptr_done * us428->stride, cp, blen);
 				memcpy(runtime->dma_area, cp + blen, len * us428->stride - blen);
@@ -212,7 +208,7 @@
 				framecpy_4c(p_dma_area, (int*)cp + cnt, len - cnt);
 			}
 		} else {
-			if (runtime->channels != 4){
+			if (runtime->channels != 4) {
 				memcpy(runtime->dma_area + hwptr_done * us428->stride, cp, len * us428->stride);
 			}else{
 				int* p_dma_area = (int*)runtime->dma_area + (urb->pipe == subs->datapipe[0] ? 0 : 1);
@@ -223,9 +219,7 @@
 		if ((hwptr_done += len) >= runtime->buffer_size)
 			hwptr_done -= runtime->buffer_size;
 	}
-	if ((runtime->channels == 4 
-	     && subs->retired_frame[0] != subs->retired_frame[1])
-	    || ! subs->running)
+	if ((runtime->channels == 4 && subs->retired_frame[0] != subs->retired_frame[1]) || ! subs->running)
 		return 0;
 
 	spin_lock_irqsave(&subs->lock, flags);
@@ -261,14 +255,15 @@
 
 	urb->dev = us428->chip.dev; /* we need to set this at each time */
 	spin_lock_irqsave(&subs->lock, flags);
-	subs->freqm = subs->stream->substream[ SNDRV_PCM_STREAM_CAPTURE].freqm;
+	subs->freqm = subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE].freqm;
 	count = 0;
 	for (pack = 0; pack < NRPACKS; pack++) {
 		/* calculate the size of a packet */
 		count += (counts = us428->pipe0Aframes[0][pack]);
 
-		if (counts < 43 || counts > 50){
-			snd_printk("%i\n", counts);
+		if (counts < 43 || counts > 50) {
+			snd_printk("should not be here with counts=%i\n", counts);
+			spin_unlock_irqrestore(&subs->lock, flags);
 			return -1;
 		}
 
@@ -355,7 +350,7 @@
 	int err;
 
 
-	if (urb->status){
+	if (urb->status) {
 		snd_printk("play urb->status = %i\n", urb->status);
 		urb->status = 0;
 		return;
@@ -376,7 +371,7 @@
 static void snd_us428_urb_play_complete(purb_t urb, struct pt_regs *regs)
 {
 	snd_us428_substream_t *subs = (snd_us428_substream_t*)urb->context;
-	if (! subs->stream->us428->pipe0Aframes[0][0]){
+	if (! subs->stream->us428->pipe0Aframes[0][0]) {
 		// wait for no of frames info from capture pipe
 		snd_printd("playurb has to wait?!\n");
 		subs->stream->us428->play_urb_waiting[0] = urb;
@@ -394,12 +389,11 @@
 	snd_pcm_runtime_t* runtime = NULL;
 	int err;
 
-	if (urb->status){
+	if (urb->status) {
 		snd_printk( "snd_us428_urb_capt_complete(): urb->status = %i\n", urb->status);
 		urb->status = 0;
 		return;
 	}
-
 	if (pcm_captsubs && snd_pcm_running(pcm_captsubs))
 		runtime = pcm_captsubs->runtime;
 	if (NULL == runtime){
@@ -408,30 +402,24 @@
 		if (pcm_playsubs && snd_pcm_running(pcm_playsubs))
 			runtime = pcm_playsubs->runtime;
 	}
-		
-	if (NULL == runtime){
+	if (NULL == runtime) {
 		snd_printd("NULL == runtime\n");
 		return;
 	}
-
 	if (captsubs->bussing && snd_us428_urb_capt_retire(captsubs, runtime, urb))
 		return;
-
  	if (! captsubs->bussing) /* can be stopped during retire callback */
 		return;
-
-	if (	(err = snd_us428_urb_capt_prepare(captsubs, runtime, urb)) < 0
-		||	(err = snd_us428_urb_submit(captsubs, urb)) < 0
-		) {
+	if ((err = snd_us428_urb_capt_prepare(captsubs, runtime, urb)) < 0 ||
+	    (err = snd_us428_urb_submit(captsubs, urb)) < 0) {
 		snd_printd(KERN_ERR "cannot submit urb (err = %d)\n", err);
 		if (pcm_captsubs)
 			snd_pcm_stop(pcm_captsubs, SNDRV_PCM_STATE_XRUN);
 		return;
 	}
-
-	{
-		if (captsubs->stream->us428->play_urb_waiting[0])
-			_snd_us428_urb_play_complete(captsubs->stream->us428->play_urb_waiting[0]);
+	if (urb->pipe == captsubs->datapipe[0] && 
+	    captsubs->stream->us428->play_urb_waiting[0]) {
+		_snd_us428_urb_play_complete(captsubs->stream->us428->play_urb_waiting[0]);
 		captsubs->stream->us428->play_urb_waiting[0] = captsubs->stream->us428->play_urb_waiting[1];
 		captsubs->stream->us428->play_urb_waiting[1] = NULL;
 	}
@@ -444,15 +432,15 @@
 {
 	int i, alive, ep;
 
-	if (subs == (subs->stream->substream + SNDRV_PCM_STREAM_PLAYBACK)){
+	if (subs == (subs->stream->substream + SNDRV_PCM_STREAM_PLAYBACK)) {
 		snd_us428_substream_t *capsubs = subs->stream->substream + SNDRV_PCM_STREAM_CAPTURE;
 		subs->running = subs->bussing = 0;
 		if (capsubs->bussing  &&  ! capsubs->running)
 			capsubs->bussing = 0;
-	}else
-		if (0x08 == subs->endpoint[0]){
+	} else
+		if (0x08 == subs->endpoint[0]) {
 			snd_us428_substream_t *playsubs = subs->stream->substream + SNDRV_PCM_STREAM_PLAYBACK;
-			if (playsubs->running){
+			if (playsubs->running) {
 				subs->running = 0;
 				return 0;
 			}
@@ -464,7 +452,7 @@
 	for (ep = 0; ep < subs->endpoints; ep++)
 		for (i = 0; i < NRURBS; i++) {
 			if (subs->dataurb[ep][i] &&
-			    subs->dataurb[ep][i]->status == -EINPROGRESS){
+			    subs->dataurb[ep][i]->status == -EINPROGRESS) {
 				alive++;
 			}
 		}
@@ -476,7 +464,7 @@
 {
 	int i, err, ep;
 
-	for (ep = 0; ep < subs->endpoints; ep++){
+	for (ep = 0; ep < subs->endpoints; ep++) {
 		subs->retired_frame[ep] = -1;
 		for (i = 0; i < NRURBS; i++) {
 			if (0 == ep)
@@ -489,7 +477,7 @@
 				snd_printk (KERN_ERR "cannot submit datapipe for urb %d %d, err = %d\n", ep, i, err);
 				return -EPIPE;
 			}
-			if (0 == ep){
+			if (0 == ep) {
 				subs->dataurb[0][i]->transfer_flags = 0;
 				subs->start_frame = subs->dataurb[0][i]->start_frame;
 			}
@@ -508,7 +496,7 @@
 {
 	int i;
 
-	if (! subs->bussing){
+	if (! subs->bussing) {
 		int ep;
 
 		for (ep = 0; ep < subs->endpoints; ep++)
@@ -524,7 +512,7 @@
 
 	subs->running = 1;
 
-	if (! subs->bussing){
+	if (! subs->bussing) {
 		if (snd_us428_urb_start(subs))
 			goto __error;
 	}
@@ -561,7 +549,7 @@
 
 	{
 		snd_us428_substream_t *capsubs = subs->stream->substream + SNDRV_PCM_STREAM_CAPTURE;
-		if (! capsubs->bussing){
+		if (! capsubs->bussing) {
 			int ep;
 			snd_printd("starting capture pipes for playpipe\n");
 			snd_us428_set_format(capsubs, runtime);
@@ -700,7 +688,7 @@
 		for (i = 0; i < NRURBS; i++)
 			release_urb_ctx(subs->dataurb[ep] + i, subs == (subs->stream->substream + SNDRV_PCM_STREAM_CAPTURE));
 
-	if (subs->tmpbuf){
+	if (subs->tmpbuf) {
 		kfree(subs->tmpbuf);
 		subs->tmpbuf = 0;
 	}
@@ -911,7 +899,7 @@
 				break;
 			}
 			for (i = 0; i < NOOF_SETRATE_URBS; ++i) {
-				if (NULL == (us->urb[i] = usb_alloc_urb(0, GFP_KERNEL))){
+				if (NULL == (us->urb[i] = usb_alloc_urb(0, GFP_KERNEL))) {
 					err = -ENOMEM;
 					break;
 				}
@@ -953,7 +941,7 @@
 
 		if (us) {
 			us->submitted =	2*NOOF_SETRATE_URBS;
-			for (i = 0; i < NOOF_SETRATE_URBS; ++i){
+			for (i = 0; i < NOOF_SETRATE_URBS; ++i) {
 				usb_unlink_urb(us->urb[i]);
 				usb_free_urb(us->urb[i]);
 			}
@@ -1145,11 +1133,11 @@
 
 	dev = stream->us428->chip.dev;
 
-	if (SNDRV_PCM_STREAM_PLAYBACK == dir){
+	if (SNDRV_PCM_STREAM_PLAYBACK == dir) {
 		subs->endpoint[0] = 0x0A;
 		subs->endpoint[1] = 0;
 		subs->endpoints = 1;
-	}else{
+	} else {
 		subs->endpoint[0] = 0x08;
 		subs->endpoint[1] = 0x0A;
 		subs->endpoints = 2;

--Boundary-00=_/5Am/o/VXOP6BuI--



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
