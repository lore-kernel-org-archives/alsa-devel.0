From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-usx2y 0.6
Date: Wed, 7 Apr 2004 00:07:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404070007.28431.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_goycALPZrMtq6QZ"
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_goycALPZrMtq6QZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jaroslav,

Please commit this with comments
	- US224 support
	- FIX for build without CONFIG_SND_DEBUG

Thanks,
Karsten


--Boundary-00=_goycALPZrMtq6QZ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-usx2y.patch.0.6"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.6"

Index: usb/usx2y/usX2Yhwdep.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usX2Yhwdep.c,v
retrieving revision 1.5
diff -u -r1.5 usX2Yhwdep.c
--- usb/usx2y/usX2Yhwdep.c	19 Mar 2004 07:22:06 -0000	1.5
+++ usb/usx2y/usX2Yhwdep.c	6 Apr 2004 21:32:05 -0000
@@ -194,11 +194,10 @@
 {
 	int	err = 0,
 		i;
-	usX2Y->Seq04 = 0;
 
 	if (NULL == (usX2Y->AS04.buffer = kmalloc(URB_DataLen_AsyncSeq*URBS_AsyncSeq, GFP_KERNEL))) {
 		err = -ENOMEM;
-	}else
+	} else
 		for (i = 0; i < URBS_AsyncSeq; ++i) {
 			if (NULL == (usX2Y->AS04.urb[i] = usb_alloc_urb(0, GFP_KERNEL))) {
 				err = -ENOMEM;
Index: usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.c,v
retrieving revision 1.8
diff -u -r1.8 usbusx2y.c
--- usb/usx2y/usbusx2y.c	17 Feb 2004 15:28:31 -0000	1.8
+++ usb/usx2y/usbusx2y.c	6 Apr 2004 21:32:06 -0000
@@ -1,6 +1,11 @@
 /*
  * usbus428.c - ALSA USB US-428 Driver
  *
+2004-04-06 Karsten Wiese
+	Version 0.6.0:
+	Runs on 2.6.5 kernel without any "--with-debug=" things.
+	us224 reported running.
+
 2004-01-14 Karsten Wiese
 	Version 0.5.1:
 	Runs with 2.6.1 kernel.
@@ -93,7 +98,7 @@
 
 
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
-MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.4.1");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.6.0");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
 MODULE_DEVICES("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001)(0x8007) }}");
@@ -118,7 +123,6 @@
 static void snd_usX2Y_usb_disconnect(struct usb_device* usb_device, void* ptr);
 static void snd_usX2Y_card_private_free(snd_card_t *card);
 
-#ifdef CONFIG_SND_DEBUG
 /* 
  * pipe 4 is used for switching the lamps, setting samplerate, volumes ....   
  */
@@ -128,14 +132,15 @@
 void snd_usX2Y_Out04Int(struct urb* urb)
 #endif
 {
+#ifdef CONFIG_SND_DEBUG
 	if (urb->status) {
 		int 		i;
 		usX2Ydev_t*	usX2Y = urb->context;
 		for (i = 0; i < 10 && usX2Y->AS04.urb[i] != urb; i++);
-		snd_printd("snd_usX2Y_Out04Int() usX2Y->Seq04=%i urb %i status=%i\n", usX2Y->Seq04, i, urb->status);
+		snd_printd("snd_usX2Y_Out04Int() urb %i status=%i\n", i, urb->status);
 	}
-}
 #endif
+}
 
 #ifndef OLD_USB
 void snd_usX2Y_In04Int(struct urb* urb, struct pt_regs *regs)
@@ -194,7 +199,7 @@
 				int j, send = us428ctls->p4outSent + 1;
 				if (send >= N_us428_p4out_BUFS)
 					send = 0;
-				for (j = 0; j < URBS_AsyncSeq; ++j)
+				for (j = 0; j < URBS_AsyncSeq  &&  !err; ++j)
 					if (0 == usX2Y->AS04.urb[j]->status) {
 						us428_p4out_t *p4out = us428ctls->p4out + send;	// FIXME if more then 1 p4out is new, 1 gets lost.
 						usb_fill_bulk_urb(usX2Y->AS04.urb[j], usX2Y->chip.dev,
@@ -204,7 +209,7 @@
 #ifdef OLD_USB
 						usX2Y->AS04.urb[j]->transfer_flags = USB_QUEUE_BULK;
 #endif
-						usb_submit_urb(usX2Y->AS04.urb[j], GFP_ATOMIC);
+						err = usb_submit_urb(usX2Y->AS04.urb[j], GFP_ATOMIC);
 						us428ctls->p4outSent = send;
 						break;
 					}
@@ -273,7 +278,6 @@
 	usX2Y(card)->chip.card = card;
 	init_MUTEX (&usX2Y(card)->open_mutex);
 	INIT_LIST_HEAD(&usX2Y(card)->chip.midi_list);
-	usX2Y(card)->Seq04Complete = 1;
 	strcpy(card->driver, "USB "NAME_ALLCAPS"");
 	sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"");
 	sprintf(card->longname, "%s (%x:%x if %d at %03d/%03d)",
Index: usb/usx2y/usbusx2y.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.h,v
retrieving revision 1.3
diff -u -r1.3 usbusx2y.h
--- usb/usx2y/usbusx2y.h	19 Jan 2004 18:43:28 -0000	1.3
+++ usb/usx2y/usbusx2y.h	6 Apr 2004 21:32:06 -0000
@@ -29,8 +29,6 @@
 	char			In04Last[24];
 	unsigned		In04IntCalls;
 	snd_usX2Y_urbSeq_t*	US04;
-	int			Seq04;
-	int 			Seq04Complete;
 	wait_queue_head_t	In04WaitQueue;
 	snd_usX2Y_AsyncSeq_t	AS04;
 	unsigned int		rate,
@@ -56,10 +54,6 @@
 #else
 void snd_usX2Y_Out04Int(struct urb* urb);
 void snd_usX2Y_In04Int(struct urb* urb);
-#endif
-
-#ifndef CONFIG_SND_DEBUG
-#define snd_usX2Y_Out04Int 0
 #endif
 
 #define NAME_ALLCAPS "US-X2Y"
Index: usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.9
diff -u -r1.9 usbusx2yaudio.c
--- usb/usx2y/usbusx2yaudio.c	30 Mar 2004 08:27:16 -0000	1.9
+++ usb/usx2y/usbusx2yaudio.c	6 Apr 2004 21:32:08 -0000
@@ -1245,7 +1245,7 @@
 	    					     snd_dma_continuous_data(GFP_KERNEL),
 						     usX2Y_capt_substream->endpoints * 64*1024,
 						     usX2Y_capt_substream->endpoints * 128*1024)) ||
-	    (usX2Y(card)->chip.dev->descriptor.idProduct == USB_ID_US428 &&
+	    (usX2Y(card)->chip.dev->descriptor.idProduct != USB_ID_US122 &&
 	     0 > (err = usX2Y_rate_set(usX2Y_stream, 44100)))) {	// Lets us428 recognize output-volume settings, disturbs us122.
 		snd_usX2Y_audio_stream_free(usX2Y_stream);
 		return err;

--Boundary-00=_goycALPZrMtq6QZ--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
