From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd_usb_usx2y: use request_firmware() instead of snd_hw based firmware loading
Date: Tue, 7 Mar 2006 16:56:23 +0100
Message-ID: <200603071656.23637.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_n0aDEEuuYnBk5xe"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_n0aDEEuuYnBk5xe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi

This is one step to make hotplug work here on FC4 again.
other things needed are updated firmwareloader, hotplug-scripts and 
us428control.

The new firmwareloader actually only needs to run once to
unpack the firmware. The "make install" in alsa-firmware/usx2yloader
puts the firmware into /lib/firmware then.

I got it here, but before submission:
Would you like to change and keep the alsa-tools/usx2yloader for that?
Alternatively there could be a new "usx2y-fw-unpack" binary
in alsa-firmware/usx2yloader and alsa-tools/usx2yloader would vanish.

      Karsten


--Boundary-00=_n0aDEEuuYnBk5xe
Content-Type: text/x-diff;
  charset="us-ascii";
  name="usx2y-request_firmware.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usx2y-request_firmware.diff"

Use request_firmware() instead of snd_hw based firmware loading

Old method was a hack. New is standard.
You'll need updates to the hotplug infrastructure to use it.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de> 



Index: alsa-driver/usb/usx2y/usX2Yhwdep.patch
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usX2Yhwdep.patch,v
retrieving revision 1.4
diff -U3 -r1.4 usX2Yhwdep.patch
--- alsa-driver/usb/usx2y/usX2Yhwdep.patch	17 Nov 2005 15:26:33 -0000	1.4
+++ alsa-driver/usb/usx2y/usX2Yhwdep.patch	7 Mar 2006 15:16:42 -0000
@@ -1,5 +1,5 @@
---- ../../alsa-kernel/usb/usx2y/usX2Yhwdep.c	2005-11-13 15:21:59.000000000 +0100
-+++ usX2Yhwdep.c	2005-11-13 19:04:20.000000000 +0100
+--- ../../alsa-kernel/usb/usx2y/usX2Yhwdep.c	2006-03-07 14:07:46.000000000 +0100
++++ usX2Yhwdep.c	2006-03-07 15:28:44.000000000 +0100
 @@ -1,3 +1,14 @@
 +#include <linux/config.h>
 +#include <linux/version.h>
@@ -15,8 +15,8 @@
  /*
   * Driver for Tascam US-X2Y USB soundcards
   *
-@@ -34,7 +45,13 @@
- int usX2Y_hwdep_pcm_new(struct snd_card *card);
+@@ -33,7 +44,13 @@
+ 
  
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
@@ -29,7 +29,7 @@
  {
  	unsigned long offset;
  	struct page * page;
-@@ -46,7 +63,11 @@
+@@ -45,7 +62,11 @@
  		   (address - area->vm_start) >> PAGE_SHIFT,
  		   address);
  	
@@ -41,7 +41,7 @@
  	offset += address - area->vm_start;
  	snd_assert((offset % PAGE_SIZE) == 0, return NOPAGE_OOM);
  	vaddr = (char*)((struct usX2Ydev *)area->vm_private_data)->us428ctls_sharedmem + offset;
-@@ -54,10 +75,20 @@
+@@ -53,10 +74,20 @@
  	get_page(page);
  	snd_printdd( "vaddr=%p made us428ctls_vm_nopage() return %p; offset=%lX\n", vaddr, page, offset);
  
@@ -62,7 +62,7 @@
  }
  
  static struct vm_operations_struct us428ctls_vm_ops = {
-@@ -88,8 +119,14 @@
+@@ -86,8 +117,14 @@
  		us428->us428ctls_sharedmem->CtlSnapShotLast = -2;
  	}
  	area->vm_ops = &us428ctls_vm_ops;
@@ -77,43 +77,3 @@
  	return 0;
  }
  
-@@ -131,7 +168,11 @@
- 	struct usX2Ydev	*us428 = hw->private_data;
- 	int id = -1;
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 11)
- 	switch (le16_to_cpu(us428->chip.dev->descriptor.idProduct)) {
-+#else
-+	switch (((struct usX2Ydev*)hw->private_data)->chip.dev->descriptor.idProduct) {
-+#endif
- 	case USB_ID_US122:
- 		id = USX2Y_TYPE_122;
- 		break;
-@@ -183,9 +224,15 @@
- 	};
- 	struct usb_device *dev = usX2Y(card)->chip.dev;
- 	struct usb_interface *iface = usb_ifnum_to_if(dev, 0);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 11)
- 	struct snd_usb_audio_quirk *quirk =
- 		le16_to_cpu(dev->descriptor.idProduct) == USB_ID_US428 ?
- 		&quirk_2 : &quirk_1;
-+#else
-+	struct snd_usb_audio_quirk *quirk =
-+		dev->descriptor.idProduct == USB_ID_US428 ?
-+		&quirk_2 : &quirk_1;
-+#endif
- 
- 	snd_printdd("usX2Y_create_usbmidi \n");
- 	return snd_usb_create_midi_interface(&usX2Y(card)->chip, iface, quirk);
-@@ -231,7 +278,11 @@
- 		if (err)
- 			snd_printk(KERN_ERR "usb_set_interface error \n");
- 		else
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 12)
- 			err = usb_bulk_msg(dev, usb_sndbulkpipe(dev, 2), buf, dsp->length, &lret, 6000);
-+#else
-+			err = usb_bulk_msg(dev, usb_sndbulkpipe(dev, 2), buf, dsp->length, &lret, 6 * HZ);
-+#endif
- 		kfree(buf);
- 	}
- 	if (err)
Index: alsa-driver/usb/usx2y/usbusx2y.patch
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.patch,v
retrieving revision 1.6
diff -U3 -r1.6 usbusx2y.patch
--- alsa-driver/usb/usx2y/usbusx2y.patch	13 Jan 2006 15:57:42 -0000	1.6
+++ alsa-driver/usb/usx2y/usbusx2y.patch	7 Mar 2006 15:16:43 -0000
@@ -1,20 +1,22 @@
---- ../../alsa-kernel/usb/usx2y/usbusx2y.c	2006-01-13 16:53:53.000000000 +0100
-+++ usbusx2y.c	2006-01-13 16:54:12.000000000 +0100
-@@ -1,3 +1,13 @@
+--- ../../alsa-kernel/usb/usx2y/usbusx2y.c	2006-03-07 15:47:43.000000000 +0100
++++ usbusx2y.c	2006-03-07 15:47:46.000000000 +0100
+@@ -1,3 +1,15 @@
 +#include <linux/config.h>
 +#include <linux/version.h>
-+
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,11)
++#define le16_to_cpu(x)	x
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,5)
 +#define SND_NEED_USB_SET_INTERFACE
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 +#define SND_NEED_USB_WRAPPER
 +#endif
 +#endif
++#endif
 +
  /*
   * usbusy2y.c - ALSA USB US-428 Driver
   *
-@@ -172,7 +182,11 @@
+@@ -180,7 +192,11 @@
  /* 
   * pipe 4 is used for switching the lamps, setting samplerate, volumes ....   
   */
@@ -26,7 +28,7 @@
  {
  #ifdef CONFIG_SND_DEBUG
  	if (urb->status) {
-@@ -184,7 +198,11 @@
+@@ -192,7 +208,11 @@
  #endif
  }
  
@@ -38,7 +40,7 @@
  {
  	int			err = 0;
  	struct usX2Ydev		*usX2Y = urb->context;
-@@ -244,6 +262,9 @@
+@@ -252,6 +272,9 @@
  								  usb_sndbulkpipe(usX2Y->chip.dev, 0x04), &p4out->val.vol, 
  								  p4out->type == eLT_Light ? sizeof(struct us428_lights) : 5,
  								  i_usX2Y_Out04Int, usX2Y);
@@ -48,7 +50,7 @@
  						err = usb_submit_urb(usX2Y->AS04.urb[j], GFP_ATOMIC);
  						us428ctls->p4outSent = send;
  						break;
-@@ -254,8 +275,10 @@
+@@ -262,8 +285,10 @@
  	if (err)
  		snd_printk(KERN_ERR "In04Int() usb_submit_urb err=%i\n", err);
  
@@ -59,7 +61,7 @@
  }
  
  /*
-@@ -298,6 +321,9 @@
+@@ -306,6 +331,9 @@
  			 usX2Y->In04Buf, 21,
  			 i_usX2Y_In04Int, usX2Y,
  			 10);
@@ -69,7 +71,7 @@
  	return usb_submit_urb(usX2Y->In04urb, GFP_KERNEL);
  }
  
-@@ -357,8 +383,13 @@
+@@ -365,8 +393,13 @@
  	sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"");
  	sprintf(card->longname, "%s (%x:%x if %d at %03d/%03d)",
  		card->shortname, 
@@ -83,25 +85,19 @@
  		0,//us428(card)->usbmidi.ifnum,
  		usX2Y(card)->chip.dev->bus->busnum, usX2Y(card)->chip.dev->devnum
  		);
-@@ -371,10 +402,17 @@
- {
- 	int		err;
- 	struct snd_card *	card;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 11)
- 	if (le16_to_cpu(device->descriptor.idVendor) != 0x1604 ||
- 	    (le16_to_cpu(device->descriptor.idProduct) != USB_ID_US122 &&
- 	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US224 &&
- 	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US428) ||
-+#else
-+	if (device->descriptor.idVendor != 0x1604 ||
-+	    (device->descriptor.idProduct != USB_ID_US122 &&
-+	     device->descriptor.idProduct != USB_ID_US224 &&
-+	     device->descriptor.idProduct != USB_ID_US428) ||
-+#endif
- 	    !(card = usX2Y_create_card(device)))
- 		return NULL;
- 	if ((err = usX2Y_hwdep_new(card, device)) < 0  ||
-@@ -385,6 +423,7 @@
+@@ -488,7 +521,11 @@
+ 		if (err)
+ 			snd_printk("usb_set_interface error \n");
+ 		else
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 12)
+ 			err = usb_bulk_msg(device, usb_sndbulkpipe(device, 2), buf, fw->size, &lret, 6000);
++#else
++			err = usb_bulk_msg(device, usb_sndbulkpipe(device, 2), buf, fw->size, &lret, 6 * HZ);
++#endif
+ 		kfree(buf);
+ 	}
+ out:
+@@ -552,6 +589,7 @@
  	return card;
  }
  
@@ -109,7 +105,7 @@
  /*
   * new 2.5 USB kernel API
   */
-@@ -404,13 +443,33 @@
+@@ -571,13 +609,33 @@
  	usX2Y_usb_disconnect(interface_to_usbdev(intf),
  				 dev_get_drvdata(&intf->dev));
  }
@@ -143,7 +139,7 @@
  };
  
  static void snd_usX2Y_card_private_free(struct snd_card *card)
-@@ -443,7 +502,11 @@
+@@ -610,7 +668,11 @@
  		}
  		if (usX2Y->us428ctls_sharedmem) 
  			wake_up(&usX2Y->us428ctls_wait_queue_head);
@@ -156,7 +152,7 @@
  	}
  }
  
-@@ -459,3 +522,5 @@
+@@ -626,3 +688,5 @@
  
  module_init(snd_usX2Y_module_init)
  module_exit(snd_usX2Y_module_exit)
Index: alsa-kernel/usb/usx2y/usX2Yhwdep.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usX2Yhwdep.c,v
retrieving revision 1.10
diff -U3 -r1.10 usX2Yhwdep.c
--- alsa-kernel/usb/usx2y/usX2Yhwdep.c	17 Nov 2005 15:08:26 -0000	1.10
+++ alsa-kernel/usb/usx2y/usX2Yhwdep.c	7 Mar 2006 15:16:50 -0000
@@ -31,7 +31,6 @@
 #include "usbusx2y.h"
 #include "usX2Yhwdep.h"
 
-int usX2Y_hwdep_pcm_new(struct snd_card *card);
 
 
 static struct page * snd_us428ctls_vm_nopage(struct vm_area_struct *area, unsigned long address, int *type)
@@ -69,8 +68,7 @@
 	unsigned long	size = (unsigned long)(area->vm_end - area->vm_start);
 	struct usX2Ydev	*us428 = hw->private_data;
 
-	// FIXME this hwdep interface is used twice: fpga download and mmap for controlling Lights etc. Maybe better using 2 hwdep devs?
-	// so as long as the device isn't fully initialised yet we return -EBUSY here.
+	// as long as the device isn't fully initialised yet we return -EBUSY here.
  	if (!(us428->chip_status & USX2Y_STAT_CHIP_INIT))
 		return -EBUSY;
 
@@ -115,150 +113,6 @@
 	return 0;
 }
 
-static int snd_usX2Y_hwdep_release(struct snd_hwdep *hw, struct file *file)
-{
-	return 0;
-}
-
-static int snd_usX2Y_hwdep_dsp_status(struct snd_hwdep *hw,
-				      struct snd_hwdep_dsp_status *info)
-{
-	static char *type_ids[USX2Y_TYPE_NUMS] = {
-		[USX2Y_TYPE_122] = "us122",
-		[USX2Y_TYPE_224] = "us224",
-		[USX2Y_TYPE_428] = "us428",
-	};
-	struct usX2Ydev	*us428 = hw->private_data;
-	int id = -1;
-
-	switch (le16_to_cpu(us428->chip.dev->descriptor.idProduct)) {
-	case USB_ID_US122:
-		id = USX2Y_TYPE_122;
-		break;
-	case USB_ID_US224:
-		id = USX2Y_TYPE_224;
-		break;
-	case USB_ID_US428:
-		id = USX2Y_TYPE_428;
-		break;
-	}
-	if (0 > id)
-		return -ENODEV;
-	strcpy(info->id, type_ids[id]);
-	info->num_dsps = 2;		// 0: Prepad Data, 1: FPGA Code
-	if (us428->chip_status & USX2Y_STAT_CHIP_INIT)
-		info->chip_ready = 1;
- 	info->version = USX2Y_DRIVER_VERSION; 
-	return 0;
-}
-
-
-static int usX2Y_create_usbmidi(struct snd_card *card)
-{
-	static struct snd_usb_midi_endpoint_info quirk_data_1 = {
-		.out_ep = 0x06,
-		.in_ep = 0x06,
-		.out_cables =	0x001,
-		.in_cables =	0x001
-	};
-	static struct snd_usb_audio_quirk quirk_1 = {
-		.vendor_name =	"TASCAM",
-		.product_name =	NAME_ALLCAPS,
-		.ifnum = 	0,
-       		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = &quirk_data_1
-	};
-	static struct snd_usb_midi_endpoint_info quirk_data_2 = {
-		.out_ep = 0x06,
-		.in_ep = 0x06,
-		.out_cables =	0x003,
-		.in_cables =	0x003
-	};
-	static struct snd_usb_audio_quirk quirk_2 = {
-		.vendor_name =	"TASCAM",
-		.product_name =	"US428",
-		.ifnum = 	0,
-       		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = &quirk_data_2
-	};
-	struct usb_device *dev = usX2Y(card)->chip.dev;
-	struct usb_interface *iface = usb_ifnum_to_if(dev, 0);
-	struct snd_usb_audio_quirk *quirk =
-		le16_to_cpu(dev->descriptor.idProduct) == USB_ID_US428 ?
-		&quirk_2 : &quirk_1;
-
-	snd_printdd("usX2Y_create_usbmidi \n");
-	return snd_usb_create_midi_interface(&usX2Y(card)->chip, iface, quirk);
-}
-
-static int usX2Y_create_alsa_devices(struct snd_card *card)
-{
-	int err;
-
-	do {
-		if ((err = usX2Y_create_usbmidi(card)) < 0) {
-			snd_printk(KERN_ERR "usX2Y_create_alsa_devices: usX2Y_create_usbmidi error %i \n", err);
-			break;
-		}
-		if ((err = usX2Y_audio_create(card)) < 0) 
-			break;
-		if ((err = usX2Y_hwdep_pcm_new(card)) < 0)
-			break;
-		if ((err = snd_card_register(card)) < 0)
-			break;
-	} while (0);
-
-	return err;
-} 
-
-static int snd_usX2Y_hwdep_dsp_load(struct snd_hwdep *hw,
-				    struct snd_hwdep_dsp_image *dsp)
-{
-	struct usX2Ydev *priv = hw->private_data;
-	int	lret, err = -EINVAL;
-	snd_printdd( "dsp_load %s\n", dsp->name);
-
-	if (access_ok(VERIFY_READ, dsp->image, dsp->length)) {
-		struct usb_device* dev = priv->chip.dev;
-		char *buf = kmalloc(dsp->length, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-		if (copy_from_user(buf, dsp->image, dsp->length)) {
-			kfree(buf);
-			return -EFAULT;
-		}
-		err = usb_set_interface(dev, 0, 1);
-		if (err)
-			snd_printk(KERN_ERR "usb_set_interface error \n");
-		else
-			err = usb_bulk_msg(dev, usb_sndbulkpipe(dev, 2), buf, dsp->length, &lret, 6000);
-		kfree(buf);
-	}
-	if (err)
-		return err;
-	if (dsp->index == 1) {
-		msleep(250);				// give the device some time
-		err = usX2Y_AsyncSeq04_init(priv);
-		if (err) {
-			snd_printk(KERN_ERR "usX2Y_AsyncSeq04_init error \n");
-			return err;
-		}
-		err = usX2Y_In04_init(priv);
-		if (err) {
-			snd_printk(KERN_ERR "usX2Y_In04_init error \n");
-			return err;
-		}
-		err = usX2Y_create_alsa_devices(hw->card);
-		if (err) {
-			snd_printk(KERN_ERR "usX2Y_create_alsa_devices error %i \n", err);
-			snd_card_free(hw->card);
-			return err;
-		}
-		priv->chip_status |= USX2Y_STAT_CHIP_INIT; 
-		snd_printdd("%s: alsa all started\n", hw->name);
-	}
-	return err;
-}
 
 
 int usX2Y_hwdep_new(struct snd_card *card, struct usb_device* device)
@@ -272,9 +126,6 @@
 	hw->iface = SNDRV_HWDEP_IFACE_USX2Y;
 	hw->private_data = usX2Y(card);
 	hw->ops.open = snd_usX2Y_hwdep_open;
-	hw->ops.release = snd_usX2Y_hwdep_release;
-	hw->ops.dsp_status = snd_usX2Y_hwdep_dsp_status;
-	hw->ops.dsp_load = snd_usX2Y_hwdep_dsp_load;
 	hw->ops.mmap = snd_us428ctls_mmap;
 	hw->ops.poll = snd_us428ctls_poll;
 	hw->exclusive = 1;
Index: alsa-kernel/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usbusx2y.c,v
retrieving revision 1.16
diff -U3 -r1.16 usbusx2y.c
--- alsa-kernel/usb/usx2y/usbusx2y.c	16 Jan 2006 16:36:06 -0000	1.16
+++ alsa-kernel/usb/usx2y/usbusx2y.c	7 Mar 2006 15:16:51 -0000
@@ -1,6 +1,11 @@
 /*
  * usbusy2y.c - ALSA USB US-428 Driver
  *
+2006-03-07
+	Version 0.8.8.0:
+	use request_firmware() instead of snd_hw based firmware loading.
+	needs updated firmware loader!
+
 2005-04-14 Karsten Wiese
 	Version 0.8.7.2:
 	Call snd_card_free() instead of snd_card_free_in_thread() to prevent oops with dead keyboard symptom.
@@ -113,7 +118,7 @@
 	Version 0.0.2: midi works with snd-usb-midi, audio (only fullduplex now) with i.e. bristol.
 	The firmware has been sniffed from win2k us-428 driver 3.09.
 
- *   Copyright (c) 2002 - 2004 Karsten Wiese
+ *   Copyright (c) 2002 - 2006 Karsten Wiese
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -131,6 +136,7 @@
 */
 
 #include <sound/driver.h>
+#include <linux/firmware.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -164,6 +170,8 @@
 MODULE_PARM_DESC(enable, "Enable "NAME_ALLCAPS".");
 
 
+int usX2Y_hwdep_pcm_new(struct snd_card *card);
+
 static int snd_usX2Y_card_used[SNDRV_CARDS];
 
 static void usX2Y_usb_disconnect(struct usb_device* usb_device, void* ptr);
@@ -337,7 +345,7 @@
 static struct snd_card *usX2Y_create_card(struct usb_device *device)
 {
 	int		dev;
-	struct snd_card *	card;
+	struct snd_card *card;
 	for (dev = 0; dev < SNDRV_CARDS; ++dev)
 		if (enable[dev] && !snd_usX2Y_card_used[dev])
 			break;
@@ -367,18 +375,177 @@
 }
 
 
-static void *usX2Y_usb_probe(struct usb_device *device, struct usb_interface *intf, const struct usb_device_id *device_id)
+static int usX2Y_create_usbmidi(struct snd_card *card)
+{
+	static struct snd_usb_midi_endpoint_info quirk_data_1 = {
+		.out_ep = 0x06,
+		.in_ep = 0x06,
+		.out_cables =	0x001,
+		.in_cables =	0x001
+	};
+	static struct snd_usb_audio_quirk quirk_1 = {
+		.vendor_name =	"TASCAM",
+		.product_name =	NAME_ALLCAPS,
+		.ifnum = 	0,
+       		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = &quirk_data_1
+	};
+	static struct snd_usb_midi_endpoint_info quirk_data_2 = {
+		.out_ep = 0x06,
+		.in_ep = 0x06,
+		.out_cables =	0x003,
+		.in_cables =	0x003
+	};
+	static struct snd_usb_audio_quirk quirk_2 = {
+		.vendor_name =	"TASCAM",
+		.product_name =	"US428",
+		.ifnum = 	0,
+       		.type = QUIRK_MIDI_FIXED_ENDPOINT,
+		.data = &quirk_data_2
+	};
+	struct usb_device *dev = usX2Y(card)->chip.dev;
+	struct usb_interface *iface = usb_ifnum_to_if(dev, 0);
+	struct snd_usb_audio_quirk *quirk =
+		le16_to_cpu(dev->descriptor.idProduct) == USB_ID_US428 ?
+		&quirk_2 : &quirk_1;
+
+	snd_printdd("usX2Y_create_usbmidi \n");
+	return snd_usb_create_midi_interface(&usX2Y(card)->chip, iface, quirk);
+}
+
+static int usX2Y_create_alsa_devices(struct snd_card *card)
+{
+	int err;
+
+	do {
+		if ((err = usX2Y_create_usbmidi(card)) < 0) {
+			snd_printk(KERN_ERR "usX2Y_create_alsa_devices: usX2Y_create_usbmidi error %i \n", err);
+			break;
+		}
+		if ((err = usX2Y_audio_create(card)) < 0) 
+			break;
+		if ((err = usX2Y_hwdep_pcm_new(card)) < 0)
+			break;
+		if ((err = snd_card_register(card)) < 0)
+			break;
+	} while (0);
+
+	return err;
+} 
+
+static int usX2Y_finish_init(struct snd_card *card, struct usX2Ydev *usX2Y)
+{
+	int err;
+
+	err = usX2Y_AsyncSeq04_init(usX2Y);
+	if (err) {
+		snd_printk("usX2Y_AsyncSeq04_init error \n");
+		return err;
+	}
+	err = usX2Y_In04_init(usX2Y);
+	if (err) {
+		snd_printk("usX2Y_In04_init error \n");
+		return err;
+	}
+	err = usX2Y_create_alsa_devices(card);
+	if (err) {
+		snd_printk("usX2Y_create_alsa_devices error %i \n", err);
+		return err;
+	}
+	usX2Y->chip_status |= USX2Y_STAT_CHIP_INIT; 
+
+	return err;
+}
+
+static char *usX2Y_type_ids[USX2Y_TYPE_NUMS] = {
+	[USX2Y_TYPE_122] = "us122",
+	[USX2Y_TYPE_224] = "us224",
+	[USX2Y_TYPE_428] = "us428",
+};
+
+
+static int usX2Y_fw_load(struct usb_device* device, struct usb_interface *intf, int type_id, const char *fmt)
+{
+	char buf[32];
+        const struct firmware *fw;
+	int lret, err;
+
+	sprintf(buf, fmt, usX2Y_type_ids[type_id]);
+
+        if ((err = request_firmware(&fw, buf, &intf->dev))) {
+		printk(KERN_ERR
+		       "%s: Firmware %s not available\n", __FUNCTION__, buf);
+		return err;
+	}
+	{
+		char *buf = kmalloc(fw->size, GFP_KERNEL);
+		if (buf == NULL) {
+			err = -ENOMEM;
+			goto out;
+		}
+		memcpy(buf, fw->data, fw->size);
+		err = usb_set_interface(device, 0, 1);
+		if (err)
+			snd_printk("usb_set_interface error \n");
+		else
+			err = usb_bulk_msg(device, usb_sndbulkpipe(device, 2), buf, fw->size, &lret, 6000);
+		kfree(buf);
+	}
+out:
+	release_firmware(fw);
+
+	return err;
+}
+
+
+static int usX2Y_fw_get(struct usb_device* device, struct usb_interface *intf)
+{
+	/* uses the default method to get the firmware */
+	int id = -1;
+	int err;
+
+	if (le16_to_cpu(device->descriptor.idVendor) != 0x1604)
+		return -ENODEV;
+
+	switch (le16_to_cpu(device->descriptor.idProduct)) {
+	case USB_ID_US122:
+		id = USX2Y_TYPE_122;
+		break;
+	case USB_ID_US224:
+		id = USX2Y_TYPE_224;
+		break;
+	case USB_ID_US428:
+		id = USX2Y_TYPE_428;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+
+	err = usX2Y_fw_load(device, intf, id, "%s.prepad.bin");
+	if (err)
+		return err;
+	err = usX2Y_fw_load(device, intf, id, "%s.rbt.bin");
+	if (err)
+		return err;
+
+	msleep(200);
+	/* finish setting up the device */
+	return 0;
+}
+
+static void* usX2Y_usb_probe(struct usb_device* device, struct usb_interface *intf, const struct usb_device_id* device_id)
 {
 	int		err;
-	struct snd_card *	card;
-	if (le16_to_cpu(device->descriptor.idVendor) != 0x1604 ||
-	    (le16_to_cpu(device->descriptor.idProduct) != USB_ID_US122 &&
-	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US224 &&
-	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US428) ||
-	    !(card = usX2Y_create_card(device)))
+	struct snd_card *card;
+
+	if (usX2Y_fw_get(device, intf))
+		return NULL;
+
+	if (!(card = usX2Y_create_card(device)))
 		return NULL;
 	if ((err = usX2Y_hwdep_new(card, device)) < 0  ||
-	    (err = snd_card_register(card)) < 0) {
+	    (err = usX2Y_finish_init(card, usX2Y(card))) < 0) {
 		snd_card_free(card);
 		return NULL;
 	}

--Boundary-00=_n0aDEEuuYnBk5xe--

	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
