From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-usx2y 0.7.2a
Date: Sun, 12 Sep 2004 11:33:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409121133.46219.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6fBRBsTXDoAiyxm"
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_6fBRBsTXDoAiyxm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

I found some improvements in the current kernel's version.
Please also apply in cvs.

thanks,
Karsten

--Boundary-00=_6fBRBsTXDoAiyxm
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-usx2y.patch.0.7.2a"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.7.2a"

Index: alsa-kernel/usb/usx2y/usX2Yhwdep.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usX2Yhwdep.c,v
retrieving revision 1.1
diff -u -r1.1 usX2Yhwdep.c
--- alsa-kernel/usb/usx2y/usX2Yhwdep.c	3 Aug 2004 14:22:48 -0000	1.1
+++ alsa-kernel/usb/usx2y/usX2Yhwdep.c	11 Sep 2004 20:46:12 -0000
@@ -211,43 +211,50 @@
 
 static int snd_usX2Y_hwdep_dsp_load(snd_hwdep_t *hw, snd_hwdep_dsp_image_t *dsp)
 {
-	int	lret, err;
-	char*	buf;
+	usX2Ydev_t *priv = hw->private_data;
+	int	lret, err = -EINVAL;
 	snd_printdd( "dsp_load %s\n", dsp->name);
 
-	buf = dsp->image;
-
-	err = -EINVAL;
 	if (access_ok(VERIFY_READ, dsp->image, dsp->length)) {
-		struct usb_device* dev = ((usX2Ydev_t*)hw->private_data)->chip.dev;
-		buf = kmalloc(dsp->length, GFP_KERNEL);
-		copy_from_user(buf, dsp->image, dsp->length);
-		if ((err = usb_set_interface(dev, 0, 1)))
+		struct usb_device* dev = priv->chip.dev;
+		char *buf = kmalloc(dsp->length, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+		if (copy_from_user(buf, dsp->image, dsp->length)) {
+			kfree(buf);
+			return -EFAULT;
+		}
+		err = usb_set_interface(dev, 0, 1);
+		if (err)
 			snd_printk("usb_set_interface error \n");
 		else
 			err = usb_bulk_msg(dev, usb_sndbulkpipe(dev, 2), buf, dsp->length, &lret, 6*HZ);
 		kfree(buf);
 	}
-	if (!err  &&  1 == dsp->index)
-		do {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(HZ/4);			// give the device some time 
-			if ((err = usX2Y_AsyncSeq04_init((usX2Ydev_t*)hw->private_data))) {
-				snd_printk("usX2Y_AsyncSeq04_init error \n");
-				break;
-			}
-			if ((err = usX2Y_In04_init((usX2Ydev_t*)hw->private_data))) {
-				snd_printk("usX2Y_In04_init error \n");
-				break;
-			}
-			if ((err = usX2Y_create_alsa_devices(hw->card))) {
-				snd_printk("usX2Y_create_alsa_devices error %i \n", err);
-				snd_card_free(hw->card);
-				break;
-			}
-			((usX2Ydev_t*)hw->private_data)->chip_status |= USX2Y_STAT_CHIP_INIT; 
-			snd_printdd("%s: alsa all started\n", hw->name);
-		} while (0);
+	if (err)
+		return err;
+	if (dsp->index == 1) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/4);			// give the device some time 
+		err = usX2Y_AsyncSeq04_init(priv);
+		if (err) {
+			snd_printk("usX2Y_AsyncSeq04_init error \n");
+			return err;
+		}
+		err = usX2Y_In04_init(priv);
+		if (err) {
+			snd_printk("usX2Y_In04_init error \n");
+			return err;
+		}
+		err = usX2Y_create_alsa_devices(hw->card);
+		if (err) {
+			snd_printk("usX2Y_create_alsa_devices error %i \n", err);
+			snd_card_free(hw->card);
+			return err;
+		}
+		priv->chip_status |= USX2Y_STAT_CHIP_INIT; 
+		snd_printdd("%s: alsa all started\n", hw->name);
+	}
 	return err;
 }
 
Index: alsa-kernel/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usbusx2y.c,v
retrieving revision 1.1
diff -u -r1.1 usbusx2y.c
--- alsa-kernel/usb/usx2y/usbusx2y.c	3 Aug 2004 14:22:48 -0000	1.1
+++ alsa-kernel/usb/usx2y/usbusx2y.c	11 Sep 2004 20:46:13 -0000
@@ -346,11 +346,11 @@
 	     device->descriptor.idProduct != USB_ID_US224 &&
 	     device->descriptor.idProduct != USB_ID_US428) ||
 	    !(card = usX2Y_create_card(device)))
-		return 0;
+		return NULL;
 	if ((err = usX2Y_hwdep_new(card, device)) < 0  ||
 	    (err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
-		return 0;
+		return NULL;
 	}
 	return card;
 }
Index: alsa-kernel/usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.2
diff -u -r1.2 usbusx2yaudio.c
--- alsa-kernel/usb/usx2y/usbusx2yaudio.c	5 Aug 2004 09:46:20 -0000	1.2
+++ alsa-kernel/usb/usx2y/usbusx2yaudio.c	11 Sep 2004 20:46:15 -0000
@@ -411,7 +411,7 @@
 		if (free_tb)
 			kfree((*urb)->transfer_buffer);
 		usb_free_urb(*urb);
-		*urb = 0;
+		*urb = NULL;
 	}
 }
 /*
@@ -427,7 +427,7 @@
 
 	if (subs->tmpbuf) {
 		kfree(subs->tmpbuf);
-		subs->tmpbuf = 0;
+		subs->tmpbuf = NULL;
 	}
 }
 
@@ -794,7 +794,7 @@
 				return err;
 		snd_printdd("starting capture pipe for playpipe\n");
 		usX2Y_urbs_allocate(capsubs);
-		capsubs->completed_urb = 0;
+		capsubs->completed_urb = NULL;
 		{
 			DECLARE_WAITQUEUE(wait, current);
 			add_wait_queue(&capsubs->wait_queue, &wait);
@@ -838,7 +838,7 @@
 				}
 			}
 		}
-		subs->completed_urb = 0;
+		subs->completed_urb = NULL;
 		subs->next_urb_complete = -1;
 		subs->stalled = 0;
 	}

--Boundary-00=_6fBRBsTXDoAiyxm--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
