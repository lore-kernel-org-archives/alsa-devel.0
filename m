From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: Re: Tascam US-224 progress report (was:       USB224_usbsnoop1.log captured  on WinXP)
Date: Tue, 6 Apr 2004 19:28:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404061928.10710.annabellesgarden@yahoo.de>
References: <200404021434.26528.annabellesgarden@yahoo.de> <200404061252.16279.annabellesgarden@yahoo.de> <61208.195.245.190.94.1081256434.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qiucAXUjqlUBm4p"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <61208.195.245.190.94.1081256434.squirrel@www.rncbc.org>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_qiucAXUjqlUBm4p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> >> Now comes the weird part. No, I couldn't get it to work unless I set
> >> --with-debug=full on configure line. And I've tested several times,
> >> believe me.

Attached diff fixed it here.
Please verify.

CU

--Boundary-00=_qiucAXUjqlUBm4p
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="nodebug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nodebug.diff"

Index: alsa-driver/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.c,v
retrieving revision 1.8
diff -u -r1.8 usbusx2y.c
--- alsa-driver/usb/usx2y/usbusx2y.c	17 Feb 2004 15:28:31 -0000	1.8
+++ alsa-driver/usb/usx2y/usbusx2y.c	6 Apr 2004 16:51:22 -0000
@@ -118,7 +118,6 @@
 static void snd_usX2Y_usb_disconnect(struct usb_device* usb_device, void* ptr);
 static void snd_usX2Y_card_private_free(snd_card_t *card);
 
-#ifdef CONFIG_SND_DEBUG
 /* 
  * pipe 4 is used for switching the lamps, setting samplerate, volumes ....   
  */
@@ -128,14 +127,15 @@
 void snd_usX2Y_Out04Int(struct urb* urb)
 #endif
 {
+#ifdef CONFIG_SND_DEBUG
 	if (urb->status) {
 		int 		i;
 		usX2Ydev_t*	usX2Y = urb->context;
 		for (i = 0; i < 10 && usX2Y->AS04.urb[i] != urb; i++);
 		snd_printd("snd_usX2Y_Out04Int() usX2Y->Seq04=%i urb %i status=%i\n", usX2Y->Seq04, i, urb->status);
 	}
-}
 #endif
+}
 
 #ifndef OLD_USB
 void snd_usX2Y_In04Int(struct urb* urb, struct pt_regs *regs)
@@ -194,7 +194,7 @@
 				int j, send = us428ctls->p4outSent + 1;
 				if (send >= N_us428_p4out_BUFS)
 					send = 0;
-				for (j = 0; j < URBS_AsyncSeq; ++j)
+				for (j = 0; j < URBS_AsyncSeq  &&  !err; ++j)
 					if (0 == usX2Y->AS04.urb[j]->status) {
 						us428_p4out_t *p4out = us428ctls->p4out + send;	// FIXME if more then 1 p4out is new, 1 gets lost.
 						usb_fill_bulk_urb(usX2Y->AS04.urb[j], usX2Y->chip.dev,
@@ -204,7 +204,7 @@
 #ifdef OLD_USB
 						usX2Y->AS04.urb[j]->transfer_flags = USB_QUEUE_BULK;
 #endif
-						usb_submit_urb(usX2Y->AS04.urb[j], GFP_ATOMIC);
+						err = usb_submit_urb(usX2Y->AS04.urb[j], GFP_ATOMIC);
 						us428ctls->p4outSent = send;
 						break;
 					}
Index: alsa-driver/usb/usx2y/usbusx2y.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.h,v
retrieving revision 1.3
diff -u -r1.3 usbusx2y.h
--- alsa-driver/usb/usx2y/usbusx2y.h	19 Jan 2004 18:43:28 -0000	1.3
+++ alsa-driver/usb/usx2y/usbusx2y.h	6 Apr 2004 16:51:22 -0000
@@ -58,10 +58,6 @@
 void snd_usX2Y_In04Int(struct urb* urb);
 #endif
 
-#ifndef CONFIG_SND_DEBUG
-#define snd_usX2Y_Out04Int 0
-#endif
-
 #define NAME_ALLCAPS "US-X2Y"
 
 #endif
Index: alsa-driver/usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.9
diff -u -r1.9 usbusx2yaudio.c
--- alsa-driver/usb/usx2y/usbusx2yaudio.c	30 Mar 2004 08:27:16 -0000	1.9
+++ alsa-driver/usb/usx2y/usbusx2yaudio.c	6 Apr 2004 16:51:25 -0000
@@ -1245,7 +1245,7 @@
 	    					     snd_dma_continuous_data(GFP_KERNEL),
 						     usX2Y_capt_substream->endpoints * 64*1024,
 						     usX2Y_capt_substream->endpoints * 128*1024)) ||
-	    (usX2Y(card)->chip.dev->descriptor.idProduct == USB_ID_US428 &&
+	    (usX2Y(card)->chip.dev->descriptor.idProduct != USB_ID_US122 &&
 	     0 > (err = usX2Y_rate_set(usX2Y_stream, 44100)))) {	// Lets us428 recognize output-volume settings, disturbs us122.
 		snd_usX2Y_audio_stream_free(usX2Y_stream);
 		return err;

--Boundary-00=_qiucAXUjqlUBm4p--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
