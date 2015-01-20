From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 2/3] ALSA: line6: Refer to manufacturer as
	"Line 6"
Date: Tue, 20 Jan 2015 02:20:49 -0600
Message-ID: <1421742050-13299-3-git-send-email-chris@rorvick.com>
References: <1421742050-13299-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C6B8260505
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 09:21:06 +0100 (CET)
Received: by mail-ig0-f179.google.com with SMTP id l13so15764113iga.0
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 00:21:05 -0800 (PST)
In-Reply-To: <1421742050-13299-1-git-send-email-chris@rorvick.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

The correct spelling includes the space.  Fix this in strings and
comments that refer to the manufacturer.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---

I will also note that "Line 6" is what is returned by the device
descriptor of my TonePort UX2.

Chris

 sound/usb/line6/Kconfig    |  4 ++--
 sound/usb/line6/capture.c  |  2 +-
 sound/usb/line6/capture.h  |  2 +-
 sound/usb/line6/driver.c   | 24 ++++++++++++------------
 sound/usb/line6/driver.h   | 14 +++++++-------
 sound/usb/line6/midi.c     |  6 +++---
 sound/usb/line6/midi.h     |  4 ++--
 sound/usb/line6/midibuf.c  |  4 ++--
 sound/usb/line6/midibuf.h  |  2 +-
 sound/usb/line6/pcm.c      |  2 +-
 sound/usb/line6/pcm.h      | 10 +++++-----
 sound/usb/line6/playback.c |  2 +-
 sound/usb/line6/playback.h |  2 +-
 sound/usb/line6/pod.c      |  6 +++---
 sound/usb/line6/podhd.c    |  6 +++---
 sound/usb/line6/toneport.c |  4 ++--
 sound/usb/line6/usbdefs.h  |  2 +-
 sound/usb/line6/variax.c   |  4 ++--
 18 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/sound/usb/line6/Kconfig b/sound/usb/line6/Kconfig
index 8287ae6..af20947 100644
--- a/sound/usb/line6/Kconfig
+++ b/sound/usb/line6/Kconfig
@@ -4,7 +4,7 @@ config SND_USB_LINE6
 	select SND_PCM
 
 config SND_USB_POD
-	tristate "Line6 POD USB support"
+	tristate "Line 6 POD USB support"
 	select SND_USB_LINE6
 	help
 	  This is a driver for PODxt and other similar devices,
@@ -21,7 +21,7 @@ config SND_USB_POD
 	      re-amping)
 
 config SND_USB_PODHD
-	tristate "Line6 POD HD300/400/500 USB support"
+	tristate "Line 6 POD HD300/400/500 USB support"
 	select SND_USB_LINE6
 	help
 	  This is a driver for POD HD300, 400 and 500 devices.
diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index e8c54ed..9da3117 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/capture.h b/sound/usb/line6/capture.h
index 4157bcb..ff172fb 100644
--- a/sound/usb/line6/capture.h
+++ b/sound/usb/line6/capture.h
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 3757b0c..c668e07 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
@@ -26,10 +26,10 @@
 #include "usbdefs.h"
 
 #define DRIVER_AUTHOR  "Markus Grabner <grabner@icg.tugraz.at>"
-#define DRIVER_DESC    "Line6 USB Driver"
+#define DRIVER_DESC    "Line 6 USB Driver"
 
 /*
-	This is Line6's MIDI manufacturer ID.
+	This is Line 6's MIDI manufacturer ID.
 */
 const unsigned char line6_midi_id[] = {
 	0x00, 0x01, 0x0c
@@ -260,7 +260,7 @@ char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1, int code2,
 EXPORT_SYMBOL_GPL(line6_alloc_sysex_buffer);
 
 /*
-	Notification of data received from the Line6 device.
+	Notification of data received from the Line 6 device.
 */
 static void line6_data_received(struct urb *urb)
 {
@@ -402,7 +402,7 @@ int line6_write_data(struct usb_line6 *line6, int address, void *data,
 EXPORT_SYMBOL_GPL(line6_write_data);
 
 /*
-	Read Line6 device serial number.
+	Read Line 6 device serial number.
 	(POD, TonePort, GuitarPort)
 */
 int line6_read_serial_number(struct usb_line6 *line6, int *serial_number)
@@ -468,7 +468,7 @@ int line6_probe(struct usb_interface *interface,
 	}
 
 	/* initialize device info: */
-	dev_info(&interface->dev, "Line6 %s found\n", properties->name);
+	dev_info(&interface->dev, "Line 6 %s found\n", properties->name);
 
 	/* query interface number */
 	interface_number = interface->cur_altsetting->desc.bInterfaceNumber;
@@ -514,7 +514,7 @@ int line6_probe(struct usb_interface *interface,
 	strcpy(card->id, line6->properties->id);
 	strcpy(card->driver, DRIVER_NAME);
 	strcpy(card->shortname, line6->properties->name);
-	sprintf(card->longname, "Line6 %s at USB %s", line6->properties->name,
+	sprintf(card->longname, "Line 6 %s at USB %s", line6->properties->name,
 		dev_name(line6->ifcdev));
 	card->private_data = line6;
 	card->private_free = line6_destruct;
@@ -562,7 +562,7 @@ int line6_probe(struct usb_interface *interface,
 
 	/* creation of additional special files should go here */
 
-	dev_info(&interface->dev, "Line6 %s now attached\n",
+	dev_info(&interface->dev, "Line 6 %s now attached\n",
 		 line6->properties->name);
 
 	return 0;
@@ -575,7 +575,7 @@ int line6_probe(struct usb_interface *interface,
 EXPORT_SYMBOL_GPL(line6_probe);
 
 /*
-	Line6 device disconnected.
+	Line 6 device disconnected.
 */
 void line6_disconnect(struct usb_interface *interface)
 {
@@ -606,7 +606,7 @@ void line6_disconnect(struct usb_interface *interface)
 	if (line6->disconnect)
 		line6->disconnect(interface);
 
-	dev_info(&interface->dev, "Line6 %s now disconnected\n",
+	dev_info(&interface->dev, "Line 6 %s now disconnected\n",
 		 line6->properties->name);
 
 	/* make sure the device isn't destructed twice: */
@@ -619,7 +619,7 @@ EXPORT_SYMBOL_GPL(line6_disconnect);
 #ifdef CONFIG_PM
 
 /*
-	Suspend Line6 device.
+	Suspend Line 6 device.
 */
 int line6_suspend(struct usb_interface *interface, pm_message_t message)
 {
@@ -641,7 +641,7 @@ int line6_suspend(struct usb_interface *interface, pm_message_t message)
 EXPORT_SYMBOL_GPL(line6_suspend);
 
 /*
-	Resume Line6 device.
+	Resume Line 6 device.
 */
 int line6_resume(struct usb_interface *interface)
 {
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index d539c11..ff52169 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
@@ -25,7 +25,7 @@
 #define LINE6_MESSAGE_MAXLEN 256
 
 /*
-	Line6 MIDI control commands
+	Line 6 MIDI control commands
 */
 #define LINE6_PARAM_CHANGE   0xb0
 #define LINE6_PROGRAM_CHANGE 0xc0
@@ -61,7 +61,7 @@ static const int SYSEX_DATA_OFS = sizeof(line6_midi_id) + 3;
 static const int SYSEX_EXTRA_SIZE = sizeof(line6_midi_id) + 4;
 
 /**
-	 Common properties of Line6 devices.
+	 Common properties of Line 6 devices.
 */
 struct line6_properties {
 	/**
@@ -91,7 +91,7 @@ struct line6_properties {
 };
 
 /**
-	 Common data shared by all Line6 devices.
+	 Common data shared by all Line 6 devices.
 	 Corresponds to a pair of USB endpoints.
 */
 struct usb_line6 {
@@ -121,18 +121,18 @@ struct usb_line6 {
 	struct device *ifcdev;
 
 	/**
-		 Line6 sound card data structure.
+		 Line 6 sound card data structure.
 		 Each device has at least MIDI or PCM.
 	*/
 	struct snd_card *card;
 
 	/**
-		 Line6 PCM device data structure.
+		 Line 6 PCM device data structure.
 	*/
 	struct snd_line6_pcm *line6pcm;
 
 	/**
-		 Line6 MIDI device data structure.
+		 Line 6 MIDI device data structure.
 	*/
 	struct snd_line6_midi *line6midi;
 
diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index 68793cc..64e242b 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
@@ -226,7 +226,7 @@ static int snd_line6_new_midi(struct usb_line6 *line6,
 	struct snd_rawmidi *rmidi;
 	int err;
 
-	err = snd_rawmidi_new(line6->card, "Line6 MIDI", 0, 1, 1, rmidi_ret);
+	err = snd_rawmidi_new(line6->card, "Line 6 MIDI", 0, 1, 1, rmidi_ret);
 	if (err < 0)
 		return err;
 
@@ -256,7 +256,7 @@ static void snd_line6_midi_free(struct snd_rawmidi *rmidi)
 }
 
 /*
-	Initialize the Line6 MIDI subsystem.
+	Initialize the Line 6 MIDI subsystem.
 */
 int line6_init_midi(struct usb_line6 *line6)
 {
diff --git a/sound/usb/line6/midi.h b/sound/usb/line6/midi.h
index 78f903f..68e7d3a 100644
--- a/sound/usb/line6/midi.h
+++ b/sound/usb/line6/midi.h
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
@@ -20,7 +20,7 @@
 
 struct snd_line6_midi {
 	/**
-		 Pointer back to the Line6 driver data structure.
+		 Pointer back to the Line 6 driver data structure.
 	*/
 	struct usb_line6 *line6;
 
diff --git a/sound/usb/line6/midibuf.c b/sound/usb/line6/midibuf.c
index 1ff8569..55df0da 100644
--- a/sound/usb/line6/midibuf.c
+++ b/sound/usb/line6/midibuf.c
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
@@ -26,7 +26,7 @@ static int midibuf_message_length(unsigned char code)
 	} else {
 		/*
 		   Note that according to the MIDI specification 0xf2 is
-		   the "Song Position Pointer", but this is used by Line6
+		   the "Song Position Pointer", but this is used by Line 6
 		   to send sysex messages to the host.
 		 */
 		static const int length[] = { -1, 2, -1, 2, -1, -1, 1, 1, 1, 1,
diff --git a/sound/usb/line6/midibuf.h b/sound/usb/line6/midibuf.h
index 707482b..18eed75 100644
--- a/sound/usb/line6/midibuf.h
+++ b/sound/usb/line6/midibuf.h
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 08fa975..a31a86b 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 9328e6f..715e84b3 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
@@ -26,7 +26,7 @@
 
 /*
 	number of USB frames per URB
-	The Line6 Windows driver always transmits two frames per packet, but
+	The Line 6 Windows driver always transmits two frames per packet, but
 	the Linux driver performs significantly better (i.e., lower latency)
 	with only one frame per packet.
 */
@@ -38,7 +38,7 @@
 #define LINE6_IMPULSE_DEFAULT_PERIOD 100
 
 /*
-	Get substream from Line6 PCM data structure
+	Get substream from Line 6 PCM data structure
 */
 #define get_substream(line6pcm, stream)	\
 		(line6pcm->pcm->streams[stream].substream)
@@ -46,7 +46,7 @@
 /*
 	PCM mode bits.
 
-	There are several features of the Line6 USB driver which require PCM
+	There are several features of the Line 6 USB driver which require PCM
 	data to be exchanged with the device:
 	*) PCM playback and capture via ALSA
 	*) software monitoring (for devices without hardware monitoring)
@@ -167,7 +167,7 @@ struct line6_pcm_properties {
 
 struct snd_line6_pcm {
 	/**
-		 Pointer back to the Line6 driver data structure.
+		 Pointer back to the Line 6 driver data structure.
 	*/
 	struct usb_line6 *line6;
 
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index ec2384c..660094b 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/playback.h b/sound/usb/line6/playback.h
index 743bd6f..0dfca5e 100644
--- a/sound/usb/line6/playback.h
+++ b/sound/usb/line6/playback.h
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 6f4b099..7766f53 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
@@ -59,7 +59,7 @@ enum {
 
 struct usb_line6_pod {
 	/**
-		Generic Line6 USB data.
+		Generic Line 6 USB data.
 	*/
 	struct usb_line6 line6;
 
@@ -627,5 +627,5 @@ static struct usb_driver pod_driver = {
 
 module_usb_driver(pod_driver);
 
-MODULE_DESCRIPTION("Line6 POD USB driver");
+MODULE_DESCRIPTION("Line 6 POD USB driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 1d11185..7217fa7 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -1,5 +1,5 @@
 /*
- * Line6 Pod HD
+ * Line 6 Pod HD
  *
  * Copyright (C) 2011 Stefan Hajnoczi <stefanha@gmail.com>
  *
@@ -28,7 +28,7 @@ enum {
 
 struct usb_line6_podhd {
 	/**
-		Generic Line6 USB data.
+		Generic Line 6 USB data.
 	*/
 	struct usb_line6 line6;
 };
@@ -205,5 +205,5 @@ static struct usb_driver podhd_driver = {
 
 module_usb_driver(podhd_driver);
 
-MODULE_DESCRIPTION("Line6 PODHD USB driver");
+MODULE_DESCRIPTION("Line 6 PODHD USB driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 24544b7..77ad98c 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *                         Emil Myhrman (emil.myhrman@gmail.com)
@@ -34,7 +34,7 @@ enum line6_device_type {
 
 struct usb_line6_toneport {
 	/**
-		Generic Line6 USB data.
+		Generic Line 6 USB data.
 	*/
 	struct usb_line6 line6;
 
diff --git a/sound/usb/line6/usbdefs.h b/sound/usb/line6/usbdefs.h
index f4d080e..3aab2e7 100644
--- a/sound/usb/line6/usbdefs.h
+++ b/sound/usb/line6/usbdefs.h
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2005-2008 Markus Grabner (grabner@icg.tugraz.at)
  *
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index a591c2c57..5e4da466 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -1,5 +1,5 @@
 /*
- * Line6 Linux USB driver - 0.9.1beta
+ * Line 6 Linux USB driver - 0.9.1beta
  *
  * Copyright (C) 2004-2010 Markus Grabner (grabner@icg.tugraz.at)
  *
@@ -43,7 +43,7 @@ enum {
 
 struct usb_line6_variax {
 	/**
-		Generic Line6 USB data.
+		Generic Line 6 USB data.
 	*/
 	struct usb_line6 line6;
 
-- 
2.1.0
