From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-usx2y 0.5.1
Date: Fri, 16 Jan 2004 22:26:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401162226.39668.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PcFCAz0B9MirTH3"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_PcFCAz0B9MirTH3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

this lets it work on kernel 2.6.1.

please commit, thanks,
karsten

--Boundary-00=_PcFCAz0B9MirTH3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-usx2y.patch.0.5.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.5.1"

Index: alsa-driver/usb/usx2y/usX2Yhwdep.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usX2Yhwdep.c,v
retrieving revision 1.3
diff -u -r1.3 usX2Yhwdep.c
--- alsa-driver/usb/usx2y/usX2Yhwdep.c	13 Jan 2004 17:19:30 -0000	1.3
+++ alsa-driver/usb/usx2y/usX2Yhwdep.c	15 Jan 2004 23:22:37 -0000
@@ -37,7 +37,9 @@
 {
 }
 
-#ifndef LINUX_2_2
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
+static struct page * us428ctls_vm_nopage(struct vm_area_struct *area, unsigned long address, int *type)
+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
 static struct page * us428ctls_vm_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
 #else
 static unsigned long us428ctls_vm_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
@@ -47,12 +49,11 @@
 	struct page * page;
 	void *vaddr;
 
-	snd_printd("ENTER, start %lXh, ofs %lXh, pgoff %ld, addr %lXh, wr %d\n",
+	snd_printd("ENTER, start %lXh, ofs %lXh, pgoff %ld, addr %lXh\n",
 		   area->vm_start,
 		   address - area->vm_start,
 		   (address - area->vm_start) >> PAGE_SHIFT,
-		   address,
-		   no_share);
+		   address);
 	
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 3, 25)
 	offset = area->vm_pgoff << PAGE_SHIFT;
@@ -65,6 +66,12 @@
 	page = virt_to_page(vaddr);
 	get_page(page);
 	snd_printd( "vaddr=%p made us428ctls_vm_nopage() return %p; offset=%lX\n", vaddr, page, offset);
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
+	if (type)
+		*type = VM_FAULT_MINOR;
+#endif
+
 #ifndef LINUX_2_2
 	return page;
 #else
@@ -303,6 +310,8 @@
 	}
 	if (!err  &&  1 == dsp->index)
 		do {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ/4);			// give the device some time 
 			if ((err = snd_usX2Y_AsyncSeq04_init((usX2Ydev_t*)hw->private_data))) {
 				snd_printk("snd_usX2Y_AsyncSeq04_init error \n");
 				break;
Index: alsa-driver/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.c,v
retrieving revision 1.5
diff -u -r1.5 usbusx2y.c
--- alsa-driver/usb/usx2y/usbusx2y.c	30 Dec 2003 16:33:44 -0000	1.5
+++ alsa-driver/usb/usx2y/usbusx2y.c	15 Jan 2004 23:22:37 -0000
@@ -1,6 +1,10 @@
 /*
  * usbus428.c - ALSA USB US-428 Driver
  *
+2004-01-14 Karsten Wiese
+	Version 0.5.1:
+	Runs with 2.6.1 kernel.
+
 2003-12-30 Karsten Wiese
 	Version 0.4.1:
 	Fix 24Bit 4Channel capturing for the us428.
@@ -142,7 +146,7 @@
 	int			err = 0;
 	usX2Ydev_t		*usX2Y = urb->context;
 	us428ctls_sharedmem_t	*us428ctls = usX2Y->us428ctls_sharedmem;
-	
+
 	usX2Y->In04IntCalls++;
 
 	if (urb->status) {
@@ -210,6 +214,11 @@
 	if (err) {
 		snd_printk("In04Int() usb_submit_urb err=%i\n", err);
 	}
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
+	urb->dev = usX2Y->chip.dev;
+	usb_submit_urb(urb, GFP_ATOMIC);
+#endif
 }
 
 static void snd_usX2Y_unlinkSeq(snd_usX2Y_AsyncSeq_t* S)
@@ -361,14 +370,16 @@
 	if (ptr) {
 		usX2Ydev_t* usX2Y = usX2Y((snd_card_t*)ptr);
 		struct list_head* p;
+		if (usX2Y->chip_status == USX2Y_STAT_CHIP_HUP)	// on 2.6.1 kernel snd_usbmidi_disconnect()
+			return;					// calls us back. better leave :-) .
 		usX2Y->chip_status = USX2Y_STAT_CHIP_HUP;
 		snd_usX2Y_unlinkSeq(&usX2Y->AS04);
 		usb_unlink_urb(usX2Y->In04urb);
+		snd_card_disconnect((snd_card_t*)ptr);
 		/* release the midi resources */
 		list_for_each(p, &usX2Y->chip.midi_list) {
 			snd_usbmidi_disconnect(p, &snd_usX2Y_usb_driver);
 		}
-		snd_card_disconnect((snd_card_t*)ptr);
 		if (usX2Y->us428ctls_sharedmem) 
 			wake_up(&usX2Y->us428ctls_wait_queue_head);
 		snd_card_free_in_thread((snd_card_t*)ptr);
Index: alsa-driver/usb/usx2y/usbusx2y.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.h,v
retrieving revision 1.2
diff -u -r1.2 usbusx2y.h
--- alsa-driver/usb/usx2y/usbusx2y.h	2 Dec 2003 10:15:02 -0000	1.2
+++ alsa-driver/usb/usx2y/usbusx2y.h	15 Jan 2004 23:22:37 -0000
@@ -5,7 +5,7 @@
 #include "usbus428ctldefs.h" 
 
 #define NRURBS	        2	/* */
-#define NRPACKS		1	/* usb-frames/ms per urb */
+#define NRPACKS		2	/* usb-frames/ms per urb: 1 and 2 are supported. set to 1 if you want lowest possible latency */
 
 #define URBS_AsyncSeq 10
 #define URB_DataLen_AsyncSeq 32
Index: alsa-driver/usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.6
diff -u -r1.6 usbusx2yaudio.c
--- alsa-driver/usb/usx2y/usbusx2yaudio.c	13 Jan 2004 17:19:30 -0000	1.6
+++ alsa-driver/usb/usx2y/usbusx2yaudio.c	15 Jan 2004 23:22:40 -0000
@@ -122,7 +122,6 @@
 			       struct urb *urb)
 {
 	unsigned long flags, pack;
-
 	urb->dev = subs->stream->usX2Y->chip.dev; /* we need to set this at each time */
 	spin_lock_irqsave(&subs->lock, flags);
 	for (pack = 0; pack < NRPACKS; pack++) {
@@ -131,8 +130,6 @@
 	}
 	spin_unlock_irqrestore(&subs->lock, flags);
 	urb->transfer_buffer_length = subs->maxpacksize * NRPACKS; 
-	urb->interval = NRPACKS;
-
 	return 0;
 }
 /*
@@ -275,7 +272,6 @@
 	for (pack = 0; pack < NRPACKS; pack++) {
 		/* calculate the size of a packet */
 		count += (counts = usX2Y->pipe0Aframes[0][pack]);
-
 		if (counts < 43 || counts > 50) {
 			snd_printk("should not be here with counts=%i\n", counts);
 			spin_unlock_irqrestore(&subs->lock, flags);
@@ -285,10 +281,9 @@
 		usX2Y->pipe0Aframes[0][pack] = usX2Y->pipe0Aframes[1][pack];
 		usX2Y->pipe0Aframes[1][pack] = 0;
 		/* set up descriptor */
-		urb->iso_frame_desc[pack].offset = pack ? urb->iso_frame_desc[pack - 1].length : 0;
+		urb->iso_frame_desc[pack].offset = pack ? urb->iso_frame_desc[pack - 1].offset + urb->iso_frame_desc[pack - 1].length : 0;
 		urb->iso_frame_desc[pack].length = counts * usX2Y->stride;
 	}
-
 	if (subs->hwptr + count > runtime->buffer_size) {
 		/* err, the transferred area goes over buffer boundary.
 		 * copy the data to the temp buffer.
@@ -308,7 +303,6 @@
 	}
 	spin_unlock_irqrestore(&subs->lock, flags);
 	urb->transfer_buffer_length = count * usX2Y->stride;
-
 	return 0;
 }
 
@@ -484,7 +478,7 @@
 		for (i = 0; i < NRURBS; i++) {
 			if (0 == ep)
 				subs->dataurb[0][i]->transfer_flags = URB_ISO_ASAP;
-			else{
+			else {
 				subs->dataurb[ep][i]->transfer_flags = 0;
 				subs->dataurb[ep][i]->start_frame = subs->dataurb[0][i]->start_frame;
 			}
@@ -756,9 +750,9 @@
 			}
 			(*purb)->dev = subs->stream->usX2Y->chip.dev;
 			(*purb)->pipe = subs->datapipe[ep];
-			(*purb)->transfer_flags = URB_ISO_ASAP | URB_ASYNC_UNLINK;
 			(*purb)->number_of_packets = NRPACKS;
 			(*purb)->context = subs;
+			(*purb)->interval = 1;
 			(*purb)->complete = is_playback ?
 				snd_usb_complete_callback(snd_usX2Y_urb_play_complete) :
 				snd_usb_complete_callback(snd_usX2Y_urb_capt_complete);
@@ -946,7 +940,6 @@
 				usX2Y_stream->usX2Y->refframes = rate == 48000 ? 47 : 44;
 			} while (0);
 		
-			set_current_state(TASK_RUNNING);
 			remove_wait_queue(&usX2Y_stream->usX2Y->In04WaitQueue, &wait);
 		} while (0);
 
@@ -956,7 +949,7 @@
 				usb_unlink_urb(us->urb[i]);
 				usb_free_urb(us->urb[i]);
 			}
-			usX2Y_stream->usX2Y->US04 =NULL;
+			usX2Y_stream->usX2Y->US04 = NULL;
 			kfree(usbdata);
 			kfree(us);
 		}
@@ -973,7 +966,7 @@
 				format = params_format(hw_params);
  	snd_usX2Y_stream_t	*usX2Y_stream = snd_pcm_substream_chip(substream);
 	if (usX2Y_stream->usX2Y->format != format) {
-		int alternate;
+		int alternate, unlink_err;
 		if (format == SNDRV_PCM_FORMAT_S24_3LE) {
 			alternate = 2;
 			usX2Y_stream->usX2Y->stride = 6;
@@ -981,9 +974,14 @@
 			alternate = 1;
 			usX2Y_stream->usX2Y->stride = 4;
 		}
+		unlink_err = usb_unlink_urb(usX2Y_stream->usX2Y->In04urb);
 		if ((err = usb_set_interface(usX2Y_stream->usX2Y->chip.dev, 0, alternate))) {
 			snd_printk("usb_set_interface error \n");
 			return err;
+		}
+		if (0 == unlink_err) {
+			usX2Y_stream->usX2Y->In04urb->dev = usX2Y_stream->usX2Y->chip.dev;
+			err = usb_submit_urb(usX2Y_stream->usX2Y->In04urb, GFP_KERNEL);
 		}
 		usX2Y_stream->usX2Y->format = format;
 		usX2Y_stream->usX2Y->rate = 0;
Index: alsa-tools/usx2yloader/tascam_fpga.in
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/usx2yloader/tascam_fpga.in,v
retrieving revision 1.3
diff -u -r1.3 tascam_fpga.in
--- alsa-tools/usx2yloader/tascam_fpga.in	4 Dec 2003 09:41:10 -0000	1.3
+++ alsa-tools/usx2yloader/tascam_fpga.in	15 Jan 2004 23:22:45 -0000
@@ -6,7 +6,7 @@
 exec_prefix=@exec_prefix@
 
 LOADER=@bindir@/usx2yloader
-CONTROLLER=
+CONTROLLER=NOTUSED
 
 if [ -x $LOADER ]; then
 	if [ -x /usr/bin/logger ]; then
@@ -27,7 +27,7 @@
 	;;
 esac
 
-if [ -n $CONTROLLER ]; then
+if [ $CONTROLLER != NOTUSED ]; then
 	if [ -x $CONTROLLER ]; then
 		if [ -x /usr/bin/logger ]; then
 			/usr/bin/logger -t $0 "starting $CONTROLLER for $DEVICE"

--Boundary-00=_PcFCAz0B9MirTH3--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
