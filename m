From: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: Re: Usb patch : interval of iso urb doesn't get initialized.
Date: Mon, 5 Jan 2004 09:47:02 +0100
Sender: linux-usb-devel-admin@lists.sourceforge.net
Message-ID: <200401050947.02880.duncan.sands@math.u-psud.fr>
References: <1072381267.4695.7.camel@nibbler.opac.net> <200401041739.23995.duncan.sands@math.u-psud.fr> <3FF86478.9080901@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FF86478.9080901@pacbell.net>
Content-Disposition: inline
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: David Brownell <david-b@pacbell.net>
Cc: areversat@tuxfamily.org, linux-usb <linux-usb-devel@lists.sourceforge.net>, Benoit papillault <benoit.papillault@free.fr>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >>If you need to have disconnect() called in all cases, feel free
> >>to get rid of usb_interface.driver ...

How about this?  While I was at it, I changed some -1L's into NULL
in ALSA's USB audio driver because they didn't please me :)

Duncan.

===== drivers/usb/core/devices.c 1.22 vs edited =====
--- 1.22/drivers/usb/core/devices.c	Tue Jul 29 13:28:37 2003
+++ edited/drivers/usb/core/devices.c	Sat Jan  3 00:27:00 2004
@@ -247,7 +247,7 @@
 			 class_decode(desc->bInterfaceClass),
 			 desc->bInterfaceSubClass,
 			 desc->bInterfaceProtocol,
-			 iface->driver ? iface->driver->name : "(none)");
+			 iface->dev.driver ? iface->dev.driver->name : "(none)");
 	unlock_kernel();
 	return start;
 }
===== drivers/usb/core/devio.c 1.55 vs edited =====
--- 1.55/drivers/usb/core/devio.c	Fri Dec  5 23:42:24 2003
+++ edited/drivers/usb/core/devio.c	Mon Jan  5 09:38:43 2004
@@ -691,9 +691,9 @@
 	interface = usb_ifnum_to_if(ps->dev, gd.interface);
 	if (!interface)
 		return -EINVAL;
-	if (!interface->driver)
+	if (!interface->dev.driver)
 		return -ENODATA;
-	strcpy(gd.driver, interface->driver->name);
+	strncpy(gd.driver, interface->dev.driver->name, sizeof(gd.driver));
 	if (copy_to_user(arg, &gd, sizeof(gd)))
 		return -EFAULT;
 	return 0;
@@ -726,7 +726,7 @@
 			continue;
 
 		err ("%s - this function is broken", __FUNCTION__);
-		if (intf->driver && ps->dev) {
+		if (intf->dev.driver && ps->dev) {
 			usb_probe_interface (&intf->dev);
 		}
 	}
@@ -747,7 +747,7 @@
 	interface = usb_ifnum_to_if(ps->dev, setintf.interface);
 	if (!interface)
 		return -EINVAL;
-	if (interface->driver) {
+	if (interface->dev.driver) {
 		if ((ret = checkintf(ps, ret)))
 			return ret;
 	}
@@ -1100,7 +1100,7 @@
        case USBDEVFS_DISCONNECT:
 		/* this function is misdesigned - retained for compatibility */
 		lock_kernel();
-		driver = ifp->driver;
+		driver = to_usb_driver(ifp->dev.driver);
 		if (driver) {
 			dbg ("disconnect '%s' from dev %d interface %d",
 			     driver->name, ps->dev->devnum, ctrl.ifno);
@@ -1124,7 +1124,7 @@
 		 * driver module.
 		 */
 		lock_kernel ();
-		driver = ifp->driver;
+		driver = to_usb_driver(ifp->dev.driver);
 		if (driver == 0 || driver->ioctl == 0) {
 			unlock_kernel();
 			retval = -ENOSYS;
===== drivers/usb/core/message.c 1.39 vs edited =====
--- 1.39/drivers/usb/core/message.c	Sun Oct 26 23:51:28 2003
+++ edited/drivers/usb/core/message.c	Mon Jan  5 02:23:48 2004
@@ -1135,6 +1135,13 @@
 				"registering %s (config #%d, interface %d)\n",
 				intf->dev.bus_id, configuration,
 				desc->bInterfaceNumber);
+		}
+		/* Now that all interfaces are setup, any of them can be
+		*  safely accessed from the probe() call for another
+		*/
+		for (i = 0; i < cp->desc.bNumInterfaces; ++i) {
+			struct usb_interface *intf = cp->interface[i];
+
 			device_add (&intf->dev);
 			usb_create_driverfs_intf_files (intf);
 		}
===== drivers/usb/core/usb.c 1.147 vs edited =====
--- 1.147/drivers/usb/core/usb.c	Tue Dec 16 19:33:47 2003
+++ edited/drivers/usb/core/usb.c	Mon Jan  5 09:52:14 2004
@@ -93,17 +93,11 @@
 	if (!driver->probe)
 		return error;
 
-	/* driver claim() doesn't yet affect dev->driver... */
-	if (intf->driver)
-		return error;
-
 	id = usb_match_id (intf, driver->id_table);
 	if (id) {
 		dev_dbg (dev, "%s - got id\n", __FUNCTION__);
 		error = driver->probe (intf, id);
 	}
-	if (!error)
-		intf->driver = driver;
 
 	return error;
 }
@@ -112,7 +106,7 @@
 int usb_unbind_interface(struct device *dev)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
-	struct usb_driver *driver = intf->driver;
+	struct usb_driver *driver = to_usb_driver(intf->dev.driver);
 
 	/* release all urbs for this interface */
 	usb_disable_interface(interface_to_usbdev(intf), intf);
@@ -125,7 +119,6 @@
 			intf->altsetting[0].desc.bInterfaceNumber,
 			0);
 	usb_set_intfdata(intf, NULL);
-	intf->driver = NULL;
 
 	return 0;
 }
@@ -272,15 +265,19 @@
  */
 int usb_driver_claim_interface(struct usb_driver *driver, struct usb_interface *iface, void* priv)
 {
+	struct device *dev;
+
 	if (!iface || !driver)
 		return -EINVAL;
 
-	if (iface->driver)
+	dev = &iface->dev;
+
+	if (dev->driver)
 		return -EBUSY;
 
-	/* FIXME should device_bind_driver() */
-	iface->driver = driver;
+	dev->driver = &driver->driver;
 	usb_set_intfdata(iface, priv);
+	device_bind_driver(dev);
 	return 0;
 }
 
@@ -294,13 +291,17 @@
  * usb_driver_claim_interface().
  *
  * Returns true (nonzero) iff the interface is claimed, else false (zero).
+ * Callers must own the driver model's usb bus readlock.  So driver
+ * probe() entries don't need extra locking, but other call contexts
+ * may need to explicitly claim that lock.
+ *
  */
 int usb_interface_claimed(struct usb_interface *iface)
 {
 	if (!iface)
 		return 0;
 
-	return (iface->driver != NULL);
+	return (iface->dev.driver != NULL);
 } /* usb_interface_claimed() */
 
 /**
@@ -312,35 +313,33 @@
  * by selecting altsetting 0, the default alternate setting.
  * 
  * This can be used by drivers to release an interface without waiting
- * for their disconnect() methods to be called.
- *
- * When the USB subsystem disconnect()s a driver from some interface,
- * it automatically invokes this method for that interface.  That
- * means that even drivers that used usb_driver_claim_interface()
- * usually won't need to call this.
+ * for their disconnect() methods to be called.  Since it calls disconnect,
+ * drivers that use it from their disconnect method need to protect
+ * themselves against infinite recursion.
  *
  * This call is synchronous, and may not be used in an interrupt context.
- * Callers must own the driver model's usb bus writelock.  So driver
- * disconnect() entries don't need extra locking, but other call contexts
- * may need to explicitly claim that lock.
+ * Callers must own the usb_device serialize semaphore and the driver model's
+ * usb bus writelock.  So driver disconnect() entries don't need extra locking,
+ * but other call contexts may need to explicitly claim those locks.
  */
 void usb_driver_release_interface(struct usb_driver *driver, struct usb_interface *iface)
 {
-	/* this should never happen, don't release something that's not ours */
-	if (!iface || !iface->driver || iface->driver != driver)
+	struct device *dev;
+
+	if (!iface)
 		return;
 
-	if (iface->dev.driver) {
-		/* FIXME should be the ONLY case here */
-		device_release_driver(&iface->dev);
+	dev = &iface->dev;
+
+	/* this should never happen, don't release something that's not ours */
+	if (!dev->driver || dev->driver != &driver->driver)
 		return;
-	}
 
+	device_release_driver(dev);
 	usb_set_interface(interface_to_usbdev(iface),
 			iface->altsetting[0].desc.bInterfaceNumber,
 			0);
 	usb_set_intfdata(iface, NULL);
-	iface->driver = NULL;
 }
 
 /**
===== drivers/usb/net/usbnet.c 1.79 vs edited =====
--- 1.79/drivers/usb/net/usbnet.c	Mon Dec 15 14:36:52 2003
+++ edited/drivers/usb/net/usbnet.c	Mon Jan  5 00:42:51 2004
@@ -1038,6 +1038,8 @@
 		return status;
 	status = get_endpoints (dev, info->data);
 	if (status < 0) {
+		/* ensure immediate exit from usbnet_disconnect */
+		usb_set_intfdata(info->data, NULL);
 		usb_driver_release_interface (&usbnet_driver, info->data);
 		return status;
 	}
@@ -1061,12 +1063,16 @@
 
 	/* disconnect master --> disconnect slave */
 	if (intf == info->control && info->data) {
+		/* ensure immediate exit from usbnet_disconnect */
+		usb_set_intfdata(info->data, NULL);
 		usb_driver_release_interface (&usbnet_driver, info->data);
 		info->data = 0;
 	}
 
 	/* and vice versa (just in case) */
 	else if (intf == info->data && info->control) {
+		/* ensure immediate exit from usbnet_disconnect */
+		usb_set_intfdata(info->control, NULL);
 		usb_driver_release_interface (&usbnet_driver, info->control);
 		info->control = 0;
 	}
===== include/linux/usb.h 1.92 vs edited =====
--- 1.92/include/linux/usb.h	Mon Dec  8 18:39:26 2003
+++ edited/include/linux/usb.h	Sat Jan  3 00:24:40 2004
@@ -31,6 +31,7 @@
 }
 
 struct usb_device;
+struct usb_driver;
 
 /*-------------------------------------------------------------------------*/
 
@@ -118,7 +119,6 @@
 	unsigned act_altsetting;	/* active alternate setting */
 	unsigned num_altsetting;	/* number of alternate settings */
 
-	struct usb_driver *driver;	/* driver */
 	int minor;			/* minor number this interface is bound to */
 	struct device dev;		/* interface specific device info */
 	struct class_device *class_dev;
===== sound/usb/usbaudio.c 1.49 vs edited =====
--- 1.49/sound/usb/usbaudio.c	Thu Oct  9 16:28:26 2003
+++ edited/sound/usb/usbaudio.c	Mon Jan  5 09:38:19 2004
@@ -2370,7 +2370,10 @@
 		/* release interfaces */
 		list_for_each(p, &subs->fmt_list) {
 			struct audioformat *fp = list_entry(p, struct audioformat, list);
-			usb_driver_release_interface(driver, usb_ifnum_to_if(subs->dev, fp->iface));
+			struct usb_interface *intf = usb_ifnum_to_if(subs->dev, fp->iface);
+			 /* ensure immediate exit from usb_audio_disconnect */
+			usb_set_intfdata(intf, NULL);
+			usb_driver_release_interface(driver, intf);
 		}
 	}
 }
@@ -2425,7 +2428,7 @@
 				snd_printk(KERN_ERR "%d:%u:%d: cannot create sequencer device\n", dev->devnum, ctrlif, j);
 				continue;
 			}
-			usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1L);
+			usb_driver_claim_interface(&usb_audio_driver, iface, NULL);
 			continue;
 		}
 		if ((altsd->bInterfaceClass != USB_CLASS_AUDIO &&
@@ -2437,7 +2440,7 @@
 		}
 		if (! parse_audio_endpoints(chip, j)) {
 			usb_set_interface(dev, j, 0); /* reset the current interface */
-			usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1L);
+			usb_driver_claim_interface(&usb_audio_driver, iface, NULL);
 		}
 	}
 
@@ -2535,7 +2538,7 @@
 		if (err < 0)
 			return err;
 		if (quirk->ifnum != probed_ifnum)
-			usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1L);
+			usb_driver_claim_interface(&usb_audio_driver, iface, NULL);
 	}
 	return 0;
 }
@@ -2833,9 +2836,6 @@
 	snd_card_t *card;
 	struct list_head *p;
 
-	if (ptr == (void *)-1L)
-		return;
-
 	chip = snd_magic_cast(snd_usb_audio_t, ptr, return);
 	card = chip->card;
 	down(&register_mutex);
@@ -2875,8 +2875,13 @@
 
 static void usb_audio_disconnect(struct usb_interface *intf)
 {
-	snd_usb_audio_disconnect(interface_to_usbdev(intf),
-				 dev_get_drvdata(&intf->dev));
+	void *data = usb_get_intfdata(intf);
+
+	if (!data)
+		return;
+
+	usb_set_intfdata(intf, NULL);
+	snd_usb_audio_disconnect(interface_to_usbdev(intf), data);
 }
 
 


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
