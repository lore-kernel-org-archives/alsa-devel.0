From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] Repair snd-usb-usx2y for usb 2.6.18; Take 2
Date: Wed, 4 Oct 2006 13:19:54 +0200
Message-ID: <200610041319.54591.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aj5IFDaBfePdjJb"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_aj5IFDaBfePdjJb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

In 2.6.18 urb->start_frame rolls over beyond INT_MAX.
Without this patch, snd-usb-usx2y can not work on 2.6.18.

Patch is split into two parts:
 1) usx2y_usb2-6-18_stable-kernel.patch for stable kernel and
    stable alsa-kernel.

 2) usx2y_usb2-6-18_stable-driver.patch for stable alsa-driver.

2) needs 1) to be applied first.

      Karsten

--Boundary-00=_aj5IFDaBfePdjJb
Content-Type: text/x-diff; charset="us-ascii";
	name="usx2y_usb2-6-18_stable-kernel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="usx2y_usb2-6-18_stable-kernel.patch"

Repair snd-usb-usx2y for usb 2.6.18

urb->start_frame rolls over beyond MAX_INT now.
This is for stable kernel and stable alsa.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>



--- ./alsa-kernel/usb/usx2y/usbusx2yaudio.c_	2006-06-29 23:25:30.000000000 +0200
+++ ./alsa-kernel/usb/usx2y/usbusx2yaudio.c	2006-10-03 15:25:55.000000000 +0200
@@ -322,7 +322,7 @@
 		usX2Y_error_urb_status(usX2Y, subs, urb);
 		return;
 	}
-	if (likely((0xFFFF & urb->start_frame) == usX2Y->wait_iso_frame))
+	if (likely(urb->start_frame == usX2Y->wait_iso_frame))
 		subs->completed_urb = urb;
 	else {
 		usX2Y_error_sequence(usX2Y, subs, urb);
@@ -335,13 +335,9 @@
 		    atomic_read(&capsubs->state) >= state_PREPARED &&
 		    (playbacksubs->completed_urb ||
 		     atomic_read(&playbacksubs->state) < state_PREPARED)) {
-			if (!usX2Y_usbframe_complete(capsubs, playbacksubs, urb->start_frame)) {
-				if (nr_of_packs() <= urb->start_frame &&
-				    urb->start_frame <= (2 * nr_of_packs() - 1))	// uhci and ohci
-					usX2Y->wait_iso_frame = urb->start_frame - nr_of_packs();
-				else
-					usX2Y->wait_iso_frame +=  nr_of_packs();
-			} else {
+			if (!usX2Y_usbframe_complete(capsubs, playbacksubs, urb->start_frame))
+				usX2Y->wait_iso_frame += nr_of_packs();
+			else {
 				snd_printdd("\n");
 				usX2Y_clients_stop(usX2Y);
 			}
@@ -495,7 +491,6 @@
 		if (subs != NULL && atomic_read(&subs->state) >= state_PREPARED)
 			goto start;
 	}
-	usX2Y->wait_iso_frame = -1;
 
  start:
 	usX2Y_subs_startup(subs);
@@ -516,10 +511,9 @@
 				snd_printk (KERN_ERR "cannot submit datapipe for urb %d, err = %d\n", i, err);
 				err = -EPIPE;
 				goto cleanup;
-			} else {
-				if (0 > usX2Y->wait_iso_frame)
+			} else
+				if (i == 0)
 					usX2Y->wait_iso_frame = urb->start_frame;
-			}
 			urb->transfer_flags = 0;
 		} else {
 			atomic_set(&subs->state, state_STARTING1);
--- ./alsa-kernel/usb/usx2y/usx2yhwdeppcm.c_	2006-10-03 14:05:12.000000000 +0200
+++ ./alsa-kernel/usb/usx2y/usx2yhwdeppcm.c	2006-10-03 15:27:18.000000000 +0200
@@ -243,7 +243,7 @@
 		usX2Y_error_urb_status(usX2Y, subs, urb);
 		return;
 	}
-	if (likely((0xFFFF & urb->start_frame) == usX2Y->wait_iso_frame))
+	if (likely(urb->start_frame == usX2Y->wait_iso_frame))
 		subs->completed_urb = urb;
 	else {
 		usX2Y_error_sequence(usX2Y, subs, urb);
@@ -256,13 +256,9 @@
 	if (capsubs->completed_urb && atomic_read(&capsubs->state) >= state_PREPARED &&
 	    (NULL == capsubs2 || capsubs2->completed_urb) &&
 	    (playbacksubs->completed_urb || atomic_read(&playbacksubs->state) < state_PREPARED)) {
-		if (!usX2Y_usbpcm_usbframe_complete(capsubs, capsubs2, playbacksubs, urb->start_frame)) {
-			if (nr_of_packs() <= urb->start_frame &&
-			    urb->start_frame <= (2 * nr_of_packs() - 1))	// uhci and ohci
-				usX2Y->wait_iso_frame = urb->start_frame - nr_of_packs();
-			else
-				usX2Y->wait_iso_frame +=  nr_of_packs();
-		} else {
+		if (!usX2Y_usbpcm_usbframe_complete(capsubs, capsubs2, playbacksubs, urb->start_frame))
+			usX2Y->wait_iso_frame += nr_of_packs();
+		else {
 			snd_printdd("\n");
 			usX2Y_clients_stop(usX2Y);
 		}
@@ -433,7 +429,6 @@
 		if (subs != NULL && atomic_read(&subs->state) >= state_PREPARED)
 			goto start;
 	}
-	usX2Y->wait_iso_frame = -1;
 
  start:
 	usX2Y_usbpcm_subs_startup(subs);
@@ -459,7 +454,7 @@
 						goto cleanup;
 					}  else {
 						snd_printdd("%i\n", urb->start_frame);
-						if (0 > usX2Y->wait_iso_frame)
+						if (u == 0)
 							usX2Y->wait_iso_frame = urb->start_frame;
 					}
 					urb->transfer_flags = 0;

--Boundary-00=_aj5IFDaBfePdjJb
Content-Type: text/x-diff; charset="us-ascii";
	name="usx2y_usb2-6-18_stable-driver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="usx2y_usb2-6-18_stable-driver.patch"

Repair snd-usb-usx2y for usb 2.6.18

urb->start_frame rolls over beyond MAX_INT now.
This is for stable alsa-driver.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>



--- ./alsa-driver/usb/usx2y/usx2yhwdeppcm.patch_	2006-06-29 23:22:39.000000000 +0200
+++ ./alsa-driver/usb/usx2y/usx2yhwdeppcm.patch	2006-10-03 15:57:26.000000000 +0200
@@ -1,6 +1,6 @@
---- ../../alsa-kernel/usb/usx2y/usx2yhwdeppcm.c	2005-11-22 14:37:40.000000000 +0100
-+++ usx2yhwdeppcm.c	2005-11-22 14:40:52.000000000 +0100
-@@ -1,3 +1,14 @@
+--- ../../../alsa-kernel/usb/usx2y/usx2yhwdeppcm.c	2006-10-03 15:27:18.000000000 +0200
++++ usx2yhwdeppcm.c	2006-10-03 15:48:04.000000000 +0200
+@@ -1,3 +1,16 @@
 +#include <linux/config.h>
 +#include <linux/version.h>
 +
@@ -12,10 +12,12 @@
 +#define __NO_VERSION__
 +#endif
 +
++#define USB_2_6_18 (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 18))
++
  /*
   *   This program is free software; you can redistribute it and/or modify
   *   it under the terms of the GNU General Public License as published by
-@@ -150,7 +161,11 @@
+@@ -150,7 +163,11 @@
  {
  	int pack;
  	for (pack = 0; pack < nr_of_packs(); ++pack) {
@@ -27,7 +29,7 @@
  		if (NULL != subs) {
  			struct snd_usX2Y_hwdep_pcm_shm *shm = subs->usX2Y->hwdep_pcm_shm;
  			int head = shm->captured_iso_head + 1;
-@@ -226,7 +241,11 @@
+@@ -226,7 +243,11 @@
  }
  
  
@@ -39,7 +41,39 @@
  {
  	struct snd_usX2Y_substream *subs = urb->context;
  	struct usX2Ydev *usX2Y = subs->usX2Y;
-@@ -294,7 +313,11 @@
+@@ -243,7 +264,11 @@
+ 		usX2Y_error_urb_status(usX2Y, subs, urb);
+ 		return;
+ 	}
+-	if (likely(urb->start_frame == usX2Y->wait_iso_frame))
++	if (likely((
++#if !USB_2_6_18
++			   0xFFFF &
++#endif
++			   urb->start_frame) == usX2Y->wait_iso_frame))
+ 		subs->completed_urb = urb;
+ 	else {
+ 		usX2Y_error_sequence(usX2Y, subs, urb);
+@@ -256,9 +281,15 @@
+ 	if (capsubs->completed_urb && atomic_read(&capsubs->state) >= state_PREPARED &&
+ 	    (NULL == capsubs2 || capsubs2->completed_urb) &&
+ 	    (playbacksubs->completed_urb || atomic_read(&playbacksubs->state) < state_PREPARED)) {
+-		if (!usX2Y_usbpcm_usbframe_complete(capsubs, capsubs2, playbacksubs, urb->start_frame))
+-			usX2Y->wait_iso_frame += nr_of_packs();
+-		else {
++		if (!usX2Y_usbpcm_usbframe_complete(capsubs, capsubs2, playbacksubs, urb->start_frame)) {
++#if !USB_2_6_18
++			if (nr_of_packs() <= urb->start_frame &&
++			    urb->start_frame <= (2 * nr_of_packs() - 1))	// uhci and ohci
++				usX2Y->wait_iso_frame = urb->start_frame - nr_of_packs();
++			else
++#endif
++				usX2Y->wait_iso_frame +=  nr_of_packs();
++		} else {
+ 			snd_printdd("\n");
+ 			usX2Y_clients_stop(usX2Y);
+ 		}
+@@ -290,7 +321,11 @@
  	usX2Y->prepare_subs = NULL;
  }
  
@@ -51,7 +85,7 @@
  {
  	struct snd_usX2Y_substream *subs = urb->context;
  	struct usX2Ydev *usX2Y = subs->usX2Y;
-@@ -311,7 +334,11 @@
+@@ -307,7 +342,11 @@
  		wake_up(&usX2Y->prepare_wait_queue);
  	}
  
@@ -63,7 +97,29 @@
  }
  
  /*
-@@ -688,23 +715,43 @@
+@@ -429,6 +468,9 @@
+ 		if (subs != NULL && atomic_read(&subs->state) >= state_PREPARED)
+ 			goto start;
+ 	}
++#if !USB_2_6_18
++	usX2Y->wait_iso_frame = -1;
++#endif
+ 
+  start:
+ 	usX2Y_usbpcm_subs_startup(subs);
+@@ -454,7 +496,11 @@
+ 						goto cleanup;
+ 					}  else {
+ 						snd_printdd("%i\n", urb->start_frame);
++#if USB_2_6_18
+ 						if (u == 0)
++#else
++						if (0 > usX2Y->wait_iso_frame)
++#endif
+ 							usX2Y->wait_iso_frame = urb->start_frame;
+ 					}
+ 					urb->transfer_flags = 0;
+@@ -683,23 +729,43 @@
  }
  
  
@@ -108,7 +164,7 @@
  }
  
  
-@@ -733,8 +780,14 @@
+@@ -728,8 +794,14 @@
  		return -ENODEV;
  	}
  	area->vm_ops = &snd_usX2Y_hwdep_pcm_vm_ops;
--- ./alsa-driver/usb/usx2y/usbusx2yaudio.patch_	2006-06-29 23:22:39.000000000 +0200
+++ ./alsa-driver/usb/usx2y/usbusx2yaudio.patch	2006-10-03 15:54:50.000000000 +0200
@@ -1,6 +1,16 @@
---- ../../alsa-kernel/usb/usx2y/usbusx2yaudio.c	2005-11-13 15:20:50.000000000 +0100
-+++ usbusx2yaudio.c	2005-11-13 19:07:00.000000000 +0100
-@@ -306,7 +306,11 @@
+--- ../../../alsa-kernel/usb/usx2y/usbusx2yaudio.c	2006-10-03 15:25:55.000000000 +0200
++++ usbusx2yaudio.c	2006-10-03 15:40:49.000000000 +0200
+@@ -67,6 +67,9 @@
+ #endif
+ 
+ 
++#define USB_2_6_18 (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 18))
++
++
+ static int usX2Y_urb_capt_retire(struct snd_usX2Y_substream *subs)
+ {
+ 	struct urb	*urb = subs->completed_urb;
+@@ -306,7 +309,11 @@
  	usX2Y_clients_stop(usX2Y);
  }
  
@@ -12,7 +22,39 @@
  {
  	struct snd_usX2Y_substream *subs = urb->context;
  	struct usX2Ydev *usX2Y = subs->usX2Y;
-@@ -349,8 +353,12 @@
+@@ -322,7 +329,11 @@
+ 		usX2Y_error_urb_status(usX2Y, subs, urb);
+ 		return;
+ 	}
+-	if (likely(urb->start_frame == usX2Y->wait_iso_frame))
++	if (likely((
++#if !USB_2_6_18
++			   0xFFFF &
++#endif
++			   urb->start_frame) == usX2Y->wait_iso_frame))
+ 		subs->completed_urb = urb;
+ 	else {
+ 		usX2Y_error_sequence(usX2Y, subs, urb);
+@@ -335,9 +346,15 @@
+ 		    atomic_read(&capsubs->state) >= state_PREPARED &&
+ 		    (playbacksubs->completed_urb ||
+ 		     atomic_read(&playbacksubs->state) < state_PREPARED)) {
+-			if (!usX2Y_usbframe_complete(capsubs, playbacksubs, urb->start_frame))
+-				usX2Y->wait_iso_frame += nr_of_packs();
+-			else {
++			if (!usX2Y_usbframe_complete(capsubs, playbacksubs, urb->start_frame)) {
++#if !USB_2_6_18
++				if (nr_of_packs() <= urb->start_frame &&
++				    urb->start_frame <= (2 * nr_of_packs() - 1))	// uhci and ohci
++					usX2Y->wait_iso_frame = urb->start_frame - nr_of_packs();
++				else
++#endif
++					usX2Y->wait_iso_frame +=  nr_of_packs();
++			} else {
+ 				snd_printdd("\n");
+ 				usX2Y_clients_stop(usX2Y);
+ 			}
+@@ -345,8 +362,12 @@
  	}
  }
  
@@ -25,7 +67,7 @@
  {
  	int s, u;
  	for (s = 0; s < 4; s++) {
-@@ -370,7 +378,11 @@
+@@ -366,7 +387,11 @@
  	usX2Y->prepare_subs = NULL;
  }
  
@@ -37,7 +79,7 @@
  {
  	struct snd_usX2Y_substream *subs = urb->context;
  	struct usX2Ydev *usX2Y = subs->usX2Y;
-@@ -382,7 +394,11 @@
+@@ -378,7 +403,11 @@
  			wake_up(&usX2Y->prepare_wait_queue);
  		}
  
@@ -49,7 +91,30 @@
  }
  
  static void usX2Y_subs_prepare(struct snd_usX2Y_substream *subs)
-@@ -663,7 +679,11 @@
+@@ -491,7 +520,9 @@
+ 		if (subs != NULL && atomic_read(&subs->state) >= state_PREPARED)
+ 			goto start;
+ 	}
+-
++#if !USB_2_6_18
++	usX2Y->wait_iso_frame = -1;
++#endif
+  start:
+ 	usX2Y_subs_startup(subs);
+ 	for (i = 0; i < NRURBS; i++) {
+@@ -512,7 +543,11 @@
+ 				err = -EPIPE;
+ 				goto cleanup;
+ 			} else
++#if USB_2_6_18
+ 				if (i == 0)
++#else
++				if (0 > usX2Y->wait_iso_frame)
++#endif
+ 					usX2Y->wait_iso_frame = urb->start_frame;
+ 			urb->transfer_flags = 0;
+ 		} else {
+@@ -657,7 +692,11 @@
  };
  #define NOOF_SETRATE_URBS ARRAY_SIZE(SetRate48000)
  
@@ -61,7 +126,7 @@
  {
  	struct usX2Ydev *usX2Y = urb->context;
  	
-@@ -1023,10 +1043,18 @@
+@@ -1017,10 +1056,18 @@
  
  	if (0 > (err = usX2Y_audio_stream_new(card, 0xA, 0x8)))
  		return err;

--Boundary-00=_aj5IFDaBfePdjJb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_aj5IFDaBfePdjJb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_aj5IFDaBfePdjJb--
