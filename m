From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/17] ALSA: line6: Reorganize card resource
	handling
Date: Mon, 19 Jan 2015 16:54:44 +0100
Message-ID: <1421682891-11594-11-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BC9F260A56
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:55:03 +0100 (CET)
In-Reply-To: <1421682891-11594-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

This is a fairly big rewrite regarding the card resource management in
line6 drivers:

- The card creation is moved into line6_probe().  This adds the global
  destructor to private_free, so that each driver doesn't have to call
  it any longer.

- The USB disconnect callback handles the card release, thus each
  driver needs to concentrate on only its own resources.  No need to
  snd_card_*() call in the destructor.

- Fix the potential stall in disconnection by removing
  snd_card_free().   It's replaced with snd_card_free_when_closed()
  for asynchronous release.

- The only remaining operation for the card in each driver is the call
  of snd_card_register().  All the rest are dealt in the common module
  by itself.

- These ended up with removal of audio.[ch] as a result of a reduction
  of one layer.  Each driver just needs to call line6_probe().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/Makefile   |  1 -
 sound/usb/line6/audio.c    | 74 -----------------------------------------
 sound/usb/line6/audio.h    | 21 ------------
 sound/usb/line6/capture.c  |  1 -
 sound/usb/line6/driver.c   | 82 +++++++++++++++++++++++++++-------------------
 sound/usb/line6/midi.c     |  1 -
 sound/usb/line6/pcm.c      |  1 -
 sound/usb/line6/playback.c |  1 -
 sound/usb/line6/pod.c      | 60 +++++----------------------------
 sound/usb/line6/podhd.c    | 75 ++++--------------------------------------
 sound/usb/line6/toneport.c | 65 ++++--------------------------------
 sound/usb/line6/variax.c   | 58 ++++++++------------------------
 12 files changed, 85 insertions(+), 355 deletions(-)
 delete mode 100644 sound/usb/line6/audio.c
 delete mode 100644 sound/usb/line6/audio.h

diff --git a/sound/usb/line6/Makefile b/sound/usb/line6/Makefile
index fa3a78dac097..b8b3b2a543d8 100644
--- a/sound/usb/line6/Makefile
+++ b/sound/usb/line6/Makefile
@@ -1,5 +1,4 @@
 snd-usb-line6-y := 		\
-		audio.o		\
 		capture.o	\
 		driver.o	\
 		midi.o		\
diff --git a/sound/usb/line6/audio.c b/sound/usb/line6/audio.c
deleted file mode 100644
index 95686e5af4bd..000000000000
--- a/sound/usb/line6/audio.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Line6 Linux USB driver - 0.9.1beta
- *
- * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License as
- *	published by the Free Software Foundation, version 2.
- *
- */
-
-#include <sound/core.h>
-#include <sound/initval.h>
-#include <linux/export.h>
-
-#include "driver.h"
-#include "audio.h"
-
-/*
-	Initialize the Line6 USB audio system.
-*/
-int line6_init_audio(struct usb_line6 *line6)
-{
-	struct snd_card *card;
-	int err;
-
-	err = snd_card_new(line6->ifcdev,
-			   SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
-			   THIS_MODULE, 0, &card);
-	if (err < 0)
-		return err;
-
-	line6->card = card;
-
-	strcpy(card->id, line6->properties->id);
-	strcpy(card->driver, DRIVER_NAME);
-	strcpy(card->shortname, line6->properties->name);
-	/* longname is 80 chars - see asound.h */
-	sprintf(card->longname, "Line6 %s at USB %s", line6->properties->name,
-		dev_name(line6->ifcdev));
-	return 0;
-}
-EXPORT_SYMBOL_GPL(line6_init_audio);
-
-/*
-	Register the Line6 USB audio system.
-*/
-int line6_register_audio(struct usb_line6 *line6)
-{
-	int err;
-
-	err = snd_card_register(line6->card);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(line6_register_audio);
-
-/*
-	Cleanup the Line6 USB audio system.
-*/
-void line6_cleanup_audio(struct usb_line6 *line6)
-{
-	struct snd_card *card = line6->card;
-
-	if (card == NULL)
-		return;
-
-	snd_card_disconnect(card);
-	snd_card_free(card);
-	line6->card = NULL;
-}
-EXPORT_SYMBOL_GPL(line6_cleanup_audio);
diff --git a/sound/usb/line6/audio.h b/sound/usb/line6/audio.h
deleted file mode 100644
index 5f8a09a0fa95..000000000000
--- a/sound/usb/line6/audio.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Line6 Linux USB driver - 0.9.1beta
- *
- * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License as
- *	published by the Free Software Foundation, version 2.
- *
- */
-
-#ifndef AUDIO_H
-#define AUDIO_H
-
-#include "driver.h"
-
-extern void line6_cleanup_audio(struct usb_line6 *);
-extern int line6_init_audio(struct usb_line6 *);
-extern int line6_register_audio(struct usb_line6 *);
-
-#endif
diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 727b31876d48..e8c54ede9227 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -14,7 +14,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 
-#include "audio.h"
 #include "capture.h"
 #include "driver.h"
 #include "pcm.h"
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index b8f5134dcec2..8b6a658a8a58 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -15,7 +15,9 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 
-#include "audio.h"
+#include <sound/core.h>
+#include <sound/initval.h>
+
 #include "capture.h"
 #include "driver.h"
 #include "midi.h"
@@ -481,17 +483,16 @@ ssize_t line6_nop_read(struct device *dev, struct device_attribute *attr,
 EXPORT_SYMBOL_GPL(line6_nop_read);
 
 /*
-	Generic destructor.
+	Card destructor.
 */
-static void line6_destruct(struct usb_interface *interface)
+static void line6_destruct(struct snd_card *card)
 {
-	struct usb_line6 *line6;
+	struct usb_line6 *line6 = card->private_data;
+	struct usb_device *usbdev;
 
-	if (interface == NULL)
-		return;
-	line6 = usb_get_intfdata(interface);
-	if (line6 == NULL)
+	if (!line6)
 		return;
+	usbdev = line6->usbdev;
 
 	/* free buffer memory first: */
 	kfree(line6->buffer_message);
@@ -500,8 +501,11 @@ static void line6_destruct(struct usb_interface *interface)
 	/* then free URBs: */
 	usb_free_urb(line6->urb_listen);
 
-	/* make sure the device isn't destructed twice: */
-	usb_set_intfdata(interface, NULL);
+	/* free interface data: */
+	kfree(line6);
+
+	/* decrement reference counters: */
+	usb_put_dev(usbdev);
 }
 
 /*
@@ -513,6 +517,7 @@ int line6_probe(struct usb_interface *interface,
 		int (*private_init)(struct usb_interface *, struct usb_line6 *))
 {
 	struct usb_device *usbdev;
+	struct snd_card *card;
 	int interface_number;
 	int ret;
 
@@ -569,8 +574,26 @@ int line6_probe(struct usb_interface *interface,
 		}
 	}
 
+	ret = snd_card_new(line6->ifcdev,
+			   SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+			   THIS_MODULE, 0, &card);
+	if (ret < 0)
+		goto err_put;
+
+	line6->card = card;
+	strcpy(card->id, line6->properties->id);
+	strcpy(card->driver, DRIVER_NAME);
+	strcpy(card->shortname, line6->properties->name);
+	sprintf(card->longname, "Line6 %s at USB %s", line6->properties->name,
+		dev_name(line6->ifcdev));
+	card->private_data = line6;
+	card->private_free = line6_destruct;
+
 	usb_set_intfdata(interface, line6);
 
+	/* increment reference counters: */
+	usb_get_dev(usbdev);
+
 	if (properties->capabilities & LINE6_CAP_CONTROL) {
 		/* initialize USB buffers: */
 		line6->buffer_listen =
@@ -612,15 +635,11 @@ int line6_probe(struct usb_interface *interface,
 	dev_info(&interface->dev, "Line6 %s now attached\n",
 		 line6->properties->name);
 
-	/* increment reference counters: */
-	usb_get_intf(interface);
-	usb_get_dev(usbdev);
-
 	return 0;
 
-err_destruct:
-	line6_destruct(interface);
-err_put:
+ err_destruct:
+	snd_card_free(card);
+ err_put:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(line6_probe);
@@ -642,29 +661,26 @@ void line6_disconnect(struct usb_interface *interface)
 
 	interface_number = interface->cur_altsetting->desc.bInterfaceNumber;
 	line6 = usb_get_intfdata(interface);
+	if (!line6)
+		return;
 
-	if (line6 != NULL) {
-		if (line6->urb_listen != NULL)
-			line6_stop_listen(line6);
+	if (line6->urb_listen != NULL)
+		line6_stop_listen(line6);
 
-		if (usbdev != line6->usbdev)
-			dev_err(line6->ifcdev,
-				"driver bug: inconsistent usb device\n");
+	if (usbdev != line6->usbdev)
+		dev_err(line6->ifcdev, "driver bug: inconsistent usb device\n");
 
+	snd_card_disconnect(line6->card);
+	if (line6->disconnect)
 		line6->disconnect(interface);
 
-		dev_info(&interface->dev, "Line6 %s now disconnected\n",
-			 line6->properties->name);
-	}
-
-	line6_destruct(interface);
+	dev_info(&interface->dev, "Line6 %s now disconnected\n",
+		 line6->properties->name);
 
-	/* free interface data: */
-	kfree(line6);
+	/* make sure the device isn't destructed twice: */
+	usb_set_intfdata(interface, NULL);
 
-	/* decrement reference counters: */
-	usb_put_intf(interface);
-	usb_put_dev(usbdev);
+	snd_card_free_when_closed(line6->card);
 }
 EXPORT_SYMBOL_GPL(line6_disconnect);
 
diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index f333cef5d2d7..68793cc5dc1e 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -15,7 +15,6 @@
 #include <sound/core.h>
 #include <sound/rawmidi.h>
 
-#include "audio.h"
 #include "driver.h"
 #include "midi.h"
 #include "usbdefs.h"
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index edab3cd7c048..1e77d0d9da17 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -16,7 +16,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 
-#include "audio.h"
 #include "capture.h"
 #include "driver.h"
 #include "playback.h"
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 5a7fe409a3b9..ec2384c875a7 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -14,7 +14,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 
-#include "audio.h"
 #include "capture.h"
 #include "driver.h"
 #include "pcm.h"
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index d6bc5a1ab7f4..6b30deb6b157 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -18,7 +18,6 @@
 #include <sound/core.h>
 #include <sound/control.h>
 
-#include "audio.h"
 #include "capture.h"
 #include "driver.h"
 #include "playback.h"
@@ -340,7 +339,7 @@ static void pod_startup4(struct work_struct *work)
 	line6_read_serial_number(&pod->line6, &pod->serial_number);
 
 	/* ALSA audio interface: */
-	line6_register_audio(line6);
+	snd_card_register(line6->card);
 }
 
 /* POD special files: */
@@ -398,21 +397,6 @@ static struct snd_kcontrol_new pod_control_monitor = {
 };
 
 /*
-	POD destructor.
-*/
-static void pod_destruct(struct usb_interface *interface)
-{
-	struct usb_line6_pod *pod = usb_get_intfdata(interface);
-
-	if (pod == NULL)
-		return;
-	line6_cleanup_audio(&pod->line6);
-
-	del_timer(&pod->startup_timer);
-	cancel_work_sync(&pod->startup_work);
-}
-
-/*
 	POD device disconnected.
 */
 static void line6_pod_disconnect(struct usb_interface *interface)
@@ -424,21 +408,18 @@ static void line6_pod_disconnect(struct usb_interface *interface)
 	pod = usb_get_intfdata(interface);
 
 	if (pod != NULL) {
-		struct snd_line6_pcm *line6pcm = pod->line6.line6pcm;
 		struct device *dev = &interface->dev;
 
-		if (line6pcm != NULL)
-			line6_pcm_disconnect(line6pcm);
-
 		if (dev != NULL) {
 			/* remove sysfs entries: */
 			device_remove_file(dev, &dev_attr_device_id);
 			device_remove_file(dev, &dev_attr_firmware_version);
 			device_remove_file(dev, &dev_attr_serial_number);
 		}
-	}
 
-	pod_destruct(interface);
+		del_timer_sync(&pod->startup_timer);
+		cancel_work_sync(&pod->startup_work);
+	}
 }
 
 /*
@@ -457,8 +438,8 @@ static int pod_create_files2(struct device *dev)
 /*
 	 Try to init POD device.
 */
-static int pod_try_init(struct usb_interface *interface,
-			struct usb_line6 *line6)
+static int pod_init(struct usb_interface *interface,
+		    struct usb_line6 *line6)
 {
 	int err;
 	struct usb_line6_pod *pod = (struct usb_line6_pod *) line6;
@@ -477,11 +458,6 @@ static int pod_try_init(struct usb_interface *interface,
 	if (err < 0)
 		return err;
 
-	/* initialize audio system: */
-	err = line6_init_audio(line6);
-	if (err < 0)
-		return err;
-
 	/* initialize MIDI subsystem: */
 	err = line6_init_midi(line6);
 	if (err < 0)
@@ -514,20 +490,6 @@ static int pod_try_init(struct usb_interface *interface,
 	return 0;
 }
 
-/*
-	 Init POD device (and clean up in case of failure).
-*/
-static int pod_init(struct usb_interface *interface,
-		    struct usb_line6 *line6)
-{
-	int err = pod_try_init(interface, line6);
-
-	if (err < 0)
-		pod_destruct(interface);
-
-	return err;
-}
-
 #define LINE6_DEVICE(prod) USB_DEVICE(0x0e41, prod)
 #define LINE6_IF_NUM(prod, n) USB_DEVICE_INTERFACE_NUMBER(0x0e41, prod, n)
 
@@ -636,17 +598,13 @@ static int pod_probe(struct usb_interface *interface,
 		     const struct usb_device_id *id)
 {
 	struct usb_line6_pod *pod;
-	int err;
 
 	pod = kzalloc(sizeof(*pod), GFP_KERNEL);
 	if (!pod)
 		return -ENODEV;
-	err = line6_probe(interface, &pod->line6,
-			  &pod_properties_table[id->driver_info],
-			  pod_init);
-	if (err < 0)
-		kfree(pod);
-	return err;
+	return line6_probe(interface, &pod->line6,
+			   &pod_properties_table[id->driver_info],
+			   pod_init);
 }
 
 static struct usb_driver pod_driver = {
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 8f4ca1d20b62..1d11185780e3 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -15,7 +15,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 
-#include "audio.h"
 #include "driver.h"
 #include "pcm.h"
 #include "usbdefs.h"
@@ -86,57 +85,17 @@ static struct line6_pcm_properties podhd_pcm_properties = {
 };
 
 /*
-	POD HD destructor.
-*/
-static void podhd_destruct(struct usb_interface *interface)
-{
-	struct usb_line6_podhd *podhd = usb_get_intfdata(interface);
-
-	if (podhd == NULL)
-		return;
-	line6_cleanup_audio(&podhd->line6);
-}
-
-/*
-	POD HD device disconnected.
-*/
-static void line6_podhd_disconnect(struct usb_interface *interface)
-{
-	struct usb_line6_podhd *podhd;
-
-	if (interface == NULL)
-		return;
-	podhd = usb_get_intfdata(interface);
-
-	if (podhd != NULL) {
-		struct snd_line6_pcm *line6pcm = podhd->line6.line6pcm;
-
-		if (line6pcm != NULL)
-			line6_pcm_disconnect(line6pcm);
-	}
-
-	podhd_destruct(interface);
-}
-
-/*
 	Try to init POD HD device.
 */
-static int podhd_try_init(struct usb_interface *interface,
-			  struct usb_line6_podhd *podhd)
+static int podhd_init(struct usb_interface *interface,
+		      struct usb_line6 *line6)
 {
+	struct usb_line6_podhd *podhd = (struct usb_line6_podhd *) line6;
 	int err;
-	struct usb_line6 *line6 = &podhd->line6;
 
 	if ((interface == NULL) || (podhd == NULL))
 		return -ENODEV;
 
-	line6->disconnect = line6_podhd_disconnect;
-
-	/* initialize audio system: */
-	err = line6_init_audio(line6);
-	if (err < 0)
-		return err;
-
 	/* initialize MIDI subsystem: */
 	err = line6_init_midi(line6);
 	if (err < 0)
@@ -148,8 +107,7 @@ static int podhd_try_init(struct usb_interface *interface,
 		return err;
 
 	/* register USB audio system: */
-	err = line6_register_audio(line6);
-	return err;
+	return snd_card_register(line6->card);
 }
 
 #define LINE6_DEVICE(prod) USB_DEVICE(0x0e41, prod)
@@ -218,38 +176,19 @@ static const struct line6_properties podhd_properties_table[] = {
 };
 
 /*
-	Init POD HD device (and clean up in case of failure).
-*/
-static int podhd_init(struct usb_interface *interface,
-		      struct usb_line6 *line6)
-{
-	struct usb_line6_podhd *podhd = (struct usb_line6_podhd *) line6;
-	int err = podhd_try_init(interface, podhd);
-
-	if (err < 0)
-		podhd_destruct(interface);
-
-	return err;
-}
-
-/*
 	Probe USB device.
 */
 static int podhd_probe(struct usb_interface *interface,
 		       const struct usb_device_id *id)
 {
 	struct usb_line6_podhd *podhd;
-	int err;
 
 	podhd = kzalloc(sizeof(*podhd), GFP_KERNEL);
 	if (!podhd)
 		return -ENODEV;
-	err = line6_probe(interface, &podhd->line6,
-			  &podhd_properties_table[id->driver_info],
-			  podhd_init);
-	if (err < 0)
-		kfree(podhd);
-	return err;
+	return line6_probe(interface, &podhd->line6,
+			   &podhd_properties_table[id->driver_info],
+			   podhd_init);
 }
 
 static struct usb_driver podhd_driver = {
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 6ec3268a6153..3097a75a9bec 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -17,7 +17,6 @@
 #include <sound/core.h>
 #include <sound/control.h>
 
-#include "audio.h"
 #include "capture.h"
 #include "driver.h"
 #include "playback.h"
@@ -331,18 +330,6 @@ static struct snd_kcontrol_new toneport_control_source = {
 };
 
 /*
-	Toneport destructor.
-*/
-static void toneport_destruct(struct usb_interface *interface)
-{
-	struct usb_line6_toneport *toneport = usb_get_intfdata(interface);
-
-	if (toneport == NULL)
-		return;
-	line6_cleanup_audio(&toneport->line6);
-}
-
-/*
 	Setup Toneport device.
 */
 static void toneport_setup(struct usb_line6_toneport *toneport)
@@ -394,25 +381,14 @@ static void line6_toneport_disconnect(struct usb_interface *interface)
 		device_remove_file(&interface->dev, &dev_attr_led_red);
 		device_remove_file(&interface->dev, &dev_attr_led_green);
 	}
-
-	if (toneport != NULL) {
-		struct snd_line6_pcm *line6pcm = toneport->line6.line6pcm;
-
-		if (line6pcm != NULL) {
-			line6_pcm_release(line6pcm, LINE6_BITS_PCM_MONITOR);
-			line6_pcm_disconnect(line6pcm);
-		}
-	}
-
-	toneport_destruct(interface);
 }
 
 
 /*
 	 Try to init Toneport device.
 */
-static int toneport_try_init(struct usb_interface *interface,
-			     struct usb_line6 *line6)
+static int toneport_init(struct usb_interface *interface,
+			 struct usb_line6 *line6)
 {
 	int err;
 	struct usb_line6_toneport *toneport =  (struct usb_line6_toneport *) line6;
@@ -422,11 +398,6 @@ static int toneport_try_init(struct usb_interface *interface,
 
 	line6->disconnect = line6_toneport_disconnect;
 
-	/* initialize audio system: */
-	err = line6_init_audio(line6);
-	if (err < 0)
-		return err;
-
 	/* initialize PCM subsystem: */
 	err = line6_init_pcm(line6, &toneport_pcm_properties);
 	if (err < 0)
@@ -456,11 +427,6 @@ static int toneport_try_init(struct usb_interface *interface,
 		break;
 	}
 
-	/* register audio system: */
-	err = line6_register_audio(line6);
-	if (err < 0)
-		return err;
-
 	line6_read_serial_number(line6, &toneport->serial_number);
 	line6_read_data(line6, 0x80c2, &toneport->firmware_version, 1);
 
@@ -477,21 +443,8 @@ static int toneport_try_init(struct usb_interface *interface,
 		    (unsigned long)toneport);
 	mod_timer(&toneport->timer, jiffies + TONEPORT_PCM_DELAY * HZ);
 
-	return 0;
-}
-
-/*
-	 Init Toneport device (and clean up in case of failure).
-*/
-static int toneport_init(struct usb_interface *interface,
-			 struct usb_line6 *line6)
-{
-	int err = toneport_try_init(interface, line6);
-
-	if (err < 0)
-		toneport_destruct(interface);
-
-	return err;
+	/* register audio system: */
+	return snd_card_register(line6->card);
 }
 
 #ifdef CONFIG_PM
@@ -595,18 +548,14 @@ static int toneport_probe(struct usb_interface *interface,
 			  const struct usb_device_id *id)
 {
 	struct usb_line6_toneport *toneport;
-	int err;
 
 	toneport = kzalloc(sizeof(*toneport), GFP_KERNEL);
 	if (!toneport)
 		return -ENODEV;
 	toneport->type = id->driver_info;
-	err = line6_probe(interface, &toneport->line6,
-			  &toneport_properties_table[id->driver_info],
-			  toneport_init);
-	if (err < 0)
-		kfree(toneport);
-	return err;
+	return line6_probe(interface, &toneport->line6,
+			   &toneport_properties_table[id->driver_info],
+			   toneport_init);
 }
 
 static struct usb_driver toneport_driver = {
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index 9a9c7e48e24f..a591c2c5794f 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <sound/core.h>
 
-#include "audio.h"
 #include "driver.h"
 #include "usbdefs.h"
 
@@ -179,7 +178,7 @@ static void variax_startup6(struct work_struct *work)
 	CHECK_STARTUP_PROGRESS(variax->startup_progress, VARIAX_STARTUP_SETUP);
 
 	/* ALSA audio interface: */
-	line6_register_audio(&variax->line6);
+	snd_card_register(variax->line6.card);
 }
 
 /*
@@ -211,13 +210,16 @@ static void line6_variax_process_message(struct usb_line6 *line6)
 /*
 	Variax destructor.
 */
-static void variax_destruct(struct usb_interface *interface)
+static void line6_variax_disconnect(struct usb_interface *interface)
 {
-	struct usb_line6_variax *variax = usb_get_intfdata(interface);
+	struct usb_line6_variax *variax;
+
+	if (!interface)
+		return;
 
-	if (variax == NULL)
+	variax = usb_get_intfdata(interface);
+	if (!variax)
 		return;
-	line6_cleanup_audio(&variax->line6);
 
 	del_timer(&variax->startup_timer1);
 	del_timer(&variax->startup_timer2);
@@ -227,21 +229,10 @@ static void variax_destruct(struct usb_interface *interface)
 }
 
 /*
-	Workbench device disconnected.
-*/
-static void line6_variax_disconnect(struct usb_interface *interface)
-{
-	if (interface == NULL)
-		return;
-
-	variax_destruct(interface);
-}
-
-/*
 	 Try to init workbench device.
 */
-static int variax_try_init(struct usb_interface *interface,
-			   struct usb_line6 *line6)
+static int variax_init(struct usb_interface *interface,
+		       struct usb_line6 *line6)
 {
 	struct usb_line6_variax *variax = (struct usb_line6_variax *) line6;
 	int err;
@@ -263,11 +254,6 @@ static int variax_try_init(struct usb_interface *interface,
 	if (variax->buffer_activate == NULL)
 		return -ENOMEM;
 
-	/* initialize audio system: */
-	err = line6_init_audio(&variax->line6);
-	if (err < 0)
-		return err;
-
 	/* initialize MIDI subsystem: */
 	err = line6_init_midi(&variax->line6);
 	if (err < 0)
@@ -278,20 +264,6 @@ static int variax_try_init(struct usb_interface *interface,
 	return 0;
 }
 
-/*
-	 Init workbench device (and clean up in case of failure).
-*/
-static int variax_init(struct usb_interface *interface,
-		       struct usb_line6 *line6)
-{
-	int err = variax_try_init(interface, line6);
-
-	if (err < 0)
-		variax_destruct(interface);
-
-	return err;
-}
-
 #define LINE6_DEVICE(prod) USB_DEVICE(0x0e41, prod)
 #define LINE6_IF_NUM(prod, n) USB_DEVICE_INTERFACE_NUMBER(0x0e41, prod, n)
 
@@ -335,17 +307,13 @@ static int variax_probe(struct usb_interface *interface,
 			const struct usb_device_id *id)
 {
 	struct usb_line6_variax *variax;
-	int err;
 
 	variax = kzalloc(sizeof(*variax), GFP_KERNEL);
 	if (!variax)
 		return -ENODEV;
-	err = line6_probe(interface, &variax->line6,
-			  &variax_properties_table[id->driver_info],
-			  variax_init);
-	if (err < 0)
-		kfree(variax);
-	return err;
+	return line6_probe(interface, &variax->line6,
+			   &variax_properties_table[id->driver_info],
+			   variax_init);
 }
 
 static struct usb_driver variax_driver = {
-- 
2.2.1
