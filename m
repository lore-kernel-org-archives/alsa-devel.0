From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/17] ALSA: line6: Split to each driver
Date: Mon, 19 Jan 2015 16:54:35 +0100
Message-ID: <1421682891-11594-2-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 111BF2610B0
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

Split to each individual driver for POD, PODHD, TonePort and Variax
with a core LINE6 helper module.  The new modules follow the standard
ALSA naming rule with snd prefix: snd-usb-pod, snd-usb-podhd,
snd-usb-toneport and snd-usb-variax, together with the corresponding
CONFIG_SND_USB_* Kconfig items.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/Makefile         |   2 +-
 sound/usb/line6/Kconfig    |  36 ++--
 sound/usb/line6/Makefile   |  21 ++-
 sound/usb/line6/audio.c    |   3 +
 sound/usb/line6/capture.c  |   1 -
 sound/usb/line6/driver.c   | 452 ++++-----------------------------------------
 sound/usb/line6/driver.h   |  39 ++--
 sound/usb/line6/midi.c     |   3 +-
 sound/usb/line6/pcm.c      |   6 +-
 sound/usb/line6/playback.c |   1 -
 sound/usb/line6/pod.c      | 224 +++++++++++++++++++++-
 sound/usb/line6/pod.h      |  92 ---------
 sound/usb/line6/podhd.c    | 124 ++++++++++++-
 sound/usb/line6/podhd.h    |  29 ---
 sound/usb/line6/toneport.c | 188 ++++++++++++++++++-
 sound/usb/line6/toneport.h |  51 -----
 sound/usb/line6/variax.c   | 133 ++++++++++++-
 sound/usb/line6/variax.h   |  70 -------
 18 files changed, 748 insertions(+), 727 deletions(-)
 delete mode 100644 sound/usb/line6/pod.h
 delete mode 100644 sound/usb/line6/podhd.h
 delete mode 100644 sound/usb/line6/toneport.h
 delete mode 100644 sound/usb/line6/variax.h

diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 54045b745d11..2d2d122b069f 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -25,4 +25,4 @@ obj-$(CONFIG_SND_USB_USX2Y) += snd-usbmidi-lib.o
 obj-$(CONFIG_SND_USB_US122L) += snd-usbmidi-lib.o
 
 obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/ bcd2000/
-obj-$(CONFIG_LINE6_USB)		+= line6/
+obj-$(CONFIG_SND_USB_LINE6)	+= line6/
diff --git a/sound/usb/line6/Kconfig b/sound/usb/line6/Kconfig
index 4f1219b4c692..33deb419dde8 100644
--- a/sound/usb/line6/Kconfig
+++ b/sound/usb/line6/Kconfig
@@ -1,12 +1,14 @@
-menuconfig LINE6_USB
-	tristate "Line6 USB support"
-	depends on USB && SND
+config SND_USB_LINE6
+	tristate
 	select SND_RAWMIDI
 	select SND_PCM
+
+config SND_USB_POD
+	tristate "Line6 POD USB support"
+	select SND_USB_LINE6
 	help
-	  This is a driver for the guitar amp, cab, and effects modeller
-	  PODxt Pro by Line6 (and similar devices), supporting the
-	  following features:
+	  This is a driver for PODxt and other similar devices,
+	  supporting the following features:
 	    * Reading/writing individual parameters
 	    * Reading/writing complete channel, effects setup, and amp
 	      setup data
@@ -18,14 +20,27 @@ menuconfig LINE6_USB
 	    * Signal routing (record clean/processed guitar signal,
 	      re-amping)
 
-	  Preliminary support for the Variax Workbench and TonePort
-	  devices is included.
+config SND_USB_PODHD
+	tristate "Line6 POD HD300/400/500 USB support"
+	select SND_USB_LINE6
+	help
+	  This is a driver for POD HD300, 400 and 500 devices.
 
-if LINE6_USB
+config SND_USB_TONEPORT
+	tristate "TonePort GX, UX1 and UX2 USB support"
+	select SND_USB_LINE6
+	help
+	  This is a driver for TonePort GX, UX1 and UX2 devices.
+
+config SND_USB_VARIAX
+	tristate "Variax Workbench USB support"
+	select SND_USB_LINE6
+	help
+	  This is a driver for Variax Workbench device.
 
 config LINE6_USB_IMPULSE_RESPONSE
 	bool "measure impulse response"
-	default n
+	depends on SND_USB_LINE6
 	help
 	  Say Y here to add code to measure the impulse response of a Line6
 	  device. This is more accurate than user-space methods since it
@@ -35,4 +50,3 @@ config LINE6_USB_IMPULSE_RESPONSE
 
 	  If unsure, say N.
 
-endif # LINE6_USB
diff --git a/sound/usb/line6/Makefile b/sound/usb/line6/Makefile
index ae5c374b0f87..fa3a78dac097 100644
--- a/sound/usb/line6/Makefile
+++ b/sound/usb/line6/Makefile
@@ -1,14 +1,19 @@
-obj-$(CONFIG_LINE6_USB)		+= line6usb.o
-
-line6usb-y := 		\
+snd-usb-line6-y := 		\
 		audio.o		\
 		capture.o	\
 		driver.o	\
 		midi.o		\
 		midibuf.o	\
 		pcm.o		\
-		playback.o	\
-		pod.o		\
-		toneport.o	\
-		variax.o	\
-		podhd.o
+		playback.o
+
+snd-usb-pod-y := pod.o
+snd-usb-podhd-y := podhd.o
+snd-usb-toneport-y := toneport.o
+snd-usb-variax-y := variax.o
+
+obj-$(CONFIG_SND_USB_LINE6)	+= snd-usb-line6.o
+obj-$(CONFIG_SND_USB_POD)	+= snd-usb-pod.o
+obj-$(CONFIG_SND_USB_PODHD)	+= snd-usb-podhd.o
+obj-$(CONFIG_SND_USB_TONEPORT)	+= snd-usb-toneport.o
+obj-$(CONFIG_SND_USB_VARIAX)	+= snd-usb-variax.o
diff --git a/sound/usb/line6/audio.c b/sound/usb/line6/audio.c
index 171d80c1b020..95686e5af4bd 100644
--- a/sound/usb/line6/audio.c
+++ b/sound/usb/line6/audio.c
@@ -40,6 +40,7 @@ int line6_init_audio(struct usb_line6 *line6)
 		dev_name(line6->ifcdev));
 	return 0;
 }
+EXPORT_SYMBOL_GPL(line6_init_audio);
 
 /*
 	Register the Line6 USB audio system.
@@ -54,6 +55,7 @@ int line6_register_audio(struct usb_line6 *line6)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(line6_register_audio);
 
 /*
 	Cleanup the Line6 USB audio system.
@@ -69,3 +71,4 @@ void line6_cleanup_audio(struct usb_line6 *line6)
 	snd_card_free(card);
 	line6->card = NULL;
 }
+EXPORT_SYMBOL_GPL(line6_cleanup_audio);
diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index f24c7c5e0a3e..da4ab013ea8e 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -18,7 +18,6 @@
 #include "capture.h"
 #include "driver.h"
 #include "pcm.h"
-#include "pod.h"
 
 /*
 	Find a free URB and submit it.
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 19904d677114..149c393c7302 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
 
@@ -19,269 +20,20 @@
 #include "driver.h"
 #include "midi.h"
 #include "playback.h"
-#include "pod.h"
-#include "podhd.h"
 #include "revision.h"
-#include "toneport.h"
 #include "usbdefs.h"
-#include "variax.h"
 
 #define DRIVER_AUTHOR  "Markus Grabner <grabner@icg.tugraz.at>"
 #define DRIVER_DESC    "Line6 USB Driver"
 #define DRIVER_VERSION "0.9.1beta" DRIVER_REVISION
 
-#define LINE6_DEVICE(prod) USB_DEVICE(0x0e41, prod)
-#define LINE6_IF_NUM(prod, n) USB_DEVICE_INTERFACE_NUMBER(0x0e41, prod, n)
-
-/* table of devices that work with this driver */
-static const struct usb_device_id line6_id_table[] = {
-	{ LINE6_DEVICE(0x4250),    .driver_info = LINE6_BASSPODXT },
-	{ LINE6_DEVICE(0x4642),    .driver_info = LINE6_BASSPODXTLIVE },
-	{ LINE6_DEVICE(0x4252),    .driver_info = LINE6_BASSPODXTPRO },
-	{ LINE6_DEVICE(0x4750),    .driver_info = LINE6_GUITARPORT },
-	{ LINE6_IF_NUM(0x5051, 1), .driver_info = LINE6_POCKETPOD },
-	{ LINE6_DEVICE(0x5057),    .driver_info = LINE6_PODHD300 },
-	{ LINE6_DEVICE(0x5058),    .driver_info = LINE6_PODHD400 },
-	{ LINE6_IF_NUM(0x414D, 0), .driver_info = LINE6_PODHD500_0 },
-	{ LINE6_IF_NUM(0x414D, 1), .driver_info = LINE6_PODHD500_1 },
-	{ LINE6_DEVICE(0x4153),    .driver_info = LINE6_PODSTUDIO_GX },
-	{ LINE6_DEVICE(0x4150),    .driver_info = LINE6_PODSTUDIO_UX1 },
-	{ LINE6_IF_NUM(0x4151, 0), .driver_info = LINE6_PODSTUDIO_UX2 },
-	{ LINE6_DEVICE(0x5044),    .driver_info = LINE6_PODXT },
-	{ LINE6_IF_NUM(0x4650, 0), .driver_info = LINE6_PODXTLIVE_POD },
-	{ LINE6_IF_NUM(0x4650, 1), .driver_info = LINE6_PODXTLIVE_VARIAX },
-	{ LINE6_DEVICE(0x5050),    .driver_info = LINE6_PODXTPRO },
-	{ LINE6_DEVICE(0x4147),    .driver_info = LINE6_TONEPORT_GX },
-	{ LINE6_DEVICE(0x4141),    .driver_info = LINE6_TONEPORT_UX1 },
-	{ LINE6_IF_NUM(0x4142, 0), .driver_info = LINE6_TONEPORT_UX2 },
-	{ LINE6_DEVICE(0x534d),    .driver_info = LINE6_VARIAX },
-	{}
-};
-
-MODULE_DEVICE_TABLE(usb, line6_id_table);
-
-static const struct line6_properties line6_properties_table[] = {
-	[LINE6_BASSPODXT] = {
-		.id = "BassPODxt",
-		.name = "BassPODxt",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 5,
-		.ep_ctrl_r = 0x84,
-		.ep_ctrl_w = 0x03,
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_BASSPODXTLIVE] = {
-		.id = "BassPODxtLive",
-		.name = "BassPODxt Live",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 1,
-		.ep_ctrl_r = 0x84,
-		.ep_ctrl_w = 0x03,
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_BASSPODXTPRO] = {
-		.id = "BassPODxtPro",
-		.name = "BassPODxt Pro",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 5,
-		.ep_ctrl_r = 0x84,
-		.ep_ctrl_w = 0x03,
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_GUITARPORT] = {
-		.id = "GuitarPort",
-		.name = "GuitarPort",
-		.capabilities	= LINE6_CAP_PCM,
-		.altsetting = 2,  /* 1..4 seem to be ok */
-		/* no control channel */
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_POCKETPOD] = {
-		.id = "PocketPOD",
-		.name = "Pocket POD",
-		.capabilities	= LINE6_CAP_CONTROL,
-		.altsetting = 0,
-		.ep_ctrl_r = 0x82,
-		.ep_ctrl_w = 0x02,
-		/* no audio channel */
-	},
-	[LINE6_PODHD300] = {
-		.id = "PODHD300",
-		.name = "POD HD300",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 5,
-		.ep_ctrl_r = 0x84,
-		.ep_ctrl_w = 0x03,
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_PODHD400] = {
-		.id = "PODHD400",
-		.name = "POD HD400",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 5,
-		.ep_ctrl_r = 0x84,
-		.ep_ctrl_w = 0x03,
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_PODHD500_0] = {
-		.id = "PODHD500",
-		.name = "POD HD500",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 1,
-		.ep_ctrl_r = 0x81,
-		.ep_ctrl_w = 0x01,
-		.ep_audio_r = 0x86,
-		.ep_audio_w = 0x02,
-	},
-	[LINE6_PODHD500_1] = {
-		.id = "PODHD500",
-		.name = "POD HD500",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 1,
-		.ep_ctrl_r = 0x81,
-		.ep_ctrl_w = 0x01,
-		.ep_audio_r = 0x86,
-		.ep_audio_w = 0x02,
-	},
-	[LINE6_PODSTUDIO_GX] = {
-		.id = "PODStudioGX",
-		.name = "POD Studio GX",
-		.capabilities	= LINE6_CAP_PCM,
-		.altsetting = 2,  /* 1..4 seem to be ok */
-		/* no control channel */
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_PODSTUDIO_UX1] = {
-		.id = "PODStudioUX1",
-		.name = "POD Studio UX1",
-		.capabilities	= LINE6_CAP_PCM,
-		.altsetting = 2,  /* 1..4 seem to be ok */
-		/* no control channel */
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_PODSTUDIO_UX2] = {
-		.id = "PODStudioUX2",
-		.name = "POD Studio UX2",
-		.capabilities	= LINE6_CAP_PCM,
-		.altsetting = 2,  /* defaults to 44.1kHz, 16-bit */
-		/* no control channel */
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_PODXT] = {
-		.id = "PODxt",
-		.name = "PODxt",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 5,
-		.ep_ctrl_r = 0x84,
-		.ep_ctrl_w = 0x03,
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_PODXTLIVE_POD] = {
-		.id = "PODxtLive",
-		.name = "PODxt Live",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 1,
-		.ep_ctrl_r = 0x84,
-		.ep_ctrl_w = 0x03,
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_PODXTLIVE_VARIAX] = {
-		.id = "PODxtLive",
-		.name = "PODxt Live",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 1,
-		.ep_ctrl_r = 0x86,
-		.ep_ctrl_w = 0x05,
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_PODXTPRO] = {
-		.id = "PODxtPro",
-		.name = "PODxt Pro",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
-		.altsetting = 5,
-		.ep_ctrl_r = 0x84,
-		.ep_ctrl_w = 0x03,
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_TONEPORT_GX] = {
-		.id = "TonePortGX",
-		.name = "TonePort GX",
-		.capabilities	= LINE6_CAP_PCM,
-		.altsetting = 2,  /* 1..4 seem to be ok */
-		/* no control channel */
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_TONEPORT_UX1] = {
-		.id = "TonePortUX1",
-		.name = "TonePort UX1",
-		.capabilities	= LINE6_CAP_PCM,
-		.altsetting = 2,  /* 1..4 seem to be ok */
-		/* no control channel */
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_TONEPORT_UX2] = {
-		.id = "TonePortUX2",
-		.name = "TonePort UX2",
-		.capabilities	= LINE6_CAP_PCM,
-		.altsetting = 2,  /* defaults to 44.1kHz, 16-bit */
-		/* no control channel */
-		.ep_audio_r = 0x82,
-		.ep_audio_w = 0x01,
-	},
-	[LINE6_VARIAX] = {
-		.id = "Variax",
-		.name = "Variax Workbench",
-		.capabilities	= LINE6_CAP_CONTROL,
-		.altsetting = 1,
-		.ep_ctrl_r = 0x82,
-		.ep_ctrl_w = 0x01,
-		/* no audio channel */
-	}
-};
-
 /*
 	This is Line6's MIDI manufacturer ID.
 */
 const unsigned char line6_midi_id[] = {
 	0x00, 0x01, 0x0c
 };
+EXPORT_SYMBOL_GPL(line6_midi_id);
 
 /*
 	Code to request version of POD, Variax interface
@@ -417,6 +169,7 @@ void line6_start_timer(struct timer_list *timer, unsigned int msecs,
 	setup_timer(timer, function, data);
 	mod_timer(timer, jiffies + msecs * HZ / 1000);
 }
+EXPORT_SYMBOL_GPL(line6_start_timer);
 
 /*
 	Asynchronously send raw message.
@@ -450,6 +203,7 @@ int line6_send_raw_message_async(struct usb_line6 *line6, const char *buffer,
 	/* start sending: */
 	return line6_send_raw_message_async_part(msg, urb);
 }
+EXPORT_SYMBOL_GPL(line6_send_raw_message_async);
 
 /*
 	Send asynchronous device version request.
@@ -471,6 +225,7 @@ int line6_version_request_async(struct usb_line6 *line6)
 	kfree(buffer);
 	return retval;
 }
+EXPORT_SYMBOL_GPL(line6_version_request_async);
 
 /*
 	Send sysex message in pieces of wMaxPacketSize bytes.
@@ -482,6 +237,7 @@ int line6_send_sysex_message(struct usb_line6 *line6, const char *buffer,
 				      size + SYSEX_EXTRA_SIZE) -
 	    SYSEX_EXTRA_SIZE;
 }
+EXPORT_SYMBOL_GPL(line6_send_sysex_message);
 
 /*
 	Allocate buffer for sysex message and prepare header.
@@ -503,6 +259,7 @@ char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1, int code2,
 	buffer[sizeof(line6_midi_id) + 3 + size] = LINE6_SYSEX_END;
 	return buffer;
 }
+EXPORT_SYMBOL_GPL(line6_alloc_sysex_buffer);
 
 /*
 	Notification of data received from the Line6 device.
@@ -658,6 +415,7 @@ int line6_read_data(struct usb_line6 *line6, int address, void *data,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(line6_read_data);
 
 /*
 	Write data to device.
@@ -702,6 +460,7 @@ int line6_write_data(struct usb_line6 *line6, int address, void *data,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(line6_write_data);
 
 /*
 	Read Line6 device serial number.
@@ -712,6 +471,7 @@ int line6_read_serial_number(struct usb_line6 *line6, int *serial_number)
 	return line6_read_data(line6, 0x80d0, serial_number,
 			       sizeof(*serial_number));
 }
+EXPORT_SYMBOL_GPL(line6_read_serial_number);
 
 /*
 	No operation (i.e., unsupported).
@@ -721,6 +481,7 @@ ssize_t line6_nop_read(struct device *dev, struct device_attribute *attr,
 {
 	return 0;
 }
+EXPORT_SYMBOL_GPL(line6_nop_read);
 
 /*
 	Generic destructor.
@@ -744,30 +505,29 @@ static void line6_destruct(struct usb_interface *interface)
 
 	/* make sure the device isn't destructed twice: */
 	usb_set_intfdata(interface, NULL);
-
-	/* free interface data: */
-	kfree(line6);
 }
 
 /*
 	Probe USB device.
 */
-static int line6_probe(struct usb_interface *interface,
-		       const struct usb_device_id *id)
+int line6_probe(struct usb_interface *interface,
+		struct usb_line6 *line6,
+		const struct line6_properties *properties,
+		int (*private_init)(struct usb_interface *, struct usb_line6 *))
 {
-	enum line6_device_type devtype;
 	struct usb_device *usbdev;
-	struct usb_line6 *line6;
-	const struct line6_properties *properties;
 	int interface_number;
-	int size = 0;
 	int ret;
 
-	if (interface == NULL)
-		return -ENODEV;
+	if (!interface) {
+		ret = -ENODEV;
+		goto err_put;
+	}
 	usbdev = interface_to_usbdev(interface);
-	if (usbdev == NULL)
-		return -ENODEV;
+	if (!usbdev) {
+		ret = -ENODEV;
+		goto err_put;
+	}
 
 	/* we don't handle multiple configurations */
 	if (usbdev->descriptor.bNumConfigurations != 1) {
@@ -775,10 +535,7 @@ static int line6_probe(struct usb_interface *interface,
 		goto err_put;
 	}
 
-	devtype = id->driver_info;
-
 	/* initialize device info: */
-	properties = &line6_properties_table[devtype];
 	dev_info(&interface->dev, "Line6 %s found\n", properties->name);
 
 	/* query interface number */
@@ -791,76 +548,10 @@ static int line6_probe(struct usb_interface *interface,
 		goto err_put;
 	}
 
-	/* initialize device data based on device: */
-	switch (devtype) {
-	case LINE6_BASSPODXT:
-	case LINE6_BASSPODXTLIVE:
-	case LINE6_BASSPODXTPRO:
-	case LINE6_PODXT:
-	case LINE6_PODXTPRO:
-		size = sizeof(struct usb_line6_pod);
-		break;
-
-	case LINE6_PODHD300:
-	case LINE6_PODHD400:
-		size = sizeof(struct usb_line6_podhd);
-		break;
-
-	case LINE6_PODHD500_0:
-	case LINE6_PODHD500_1:
-		size = sizeof(struct usb_line6_podhd);
-		break;
-
-	case LINE6_POCKETPOD:
-		size = sizeof(struct usb_line6_pod);
-		break;
-
-	case LINE6_PODSTUDIO_GX:
-	case LINE6_PODSTUDIO_UX1:
-	case LINE6_PODSTUDIO_UX2:
-	case LINE6_TONEPORT_GX:
-	case LINE6_TONEPORT_UX1:
-	case LINE6_TONEPORT_UX2:
-	case LINE6_GUITARPORT:
-		size = sizeof(struct usb_line6_toneport);
-		break;
-
-	case LINE6_PODXTLIVE_POD:
-		size = sizeof(struct usb_line6_pod);
-		break;
-
-	case LINE6_PODXTLIVE_VARIAX:
-		size = sizeof(struct usb_line6_variax);
-		break;
-
-	case LINE6_VARIAX:
-		size = sizeof(struct usb_line6_variax);
-		break;
-
-	default:
-		MISSING_CASE;
-		ret = -ENODEV;
-		goto err_put;
-	}
-
-	if (size == 0) {
-		dev_err(&interface->dev,
-			"driver bug: interface data size not set\n");
-		ret = -ENODEV;
-		goto err_put;
-	}
-
-	line6 = kzalloc(size, GFP_KERNEL);
-	if (line6 == NULL) {
-		ret = -ENODEV;
-		goto err_put;
-	}
-
 	/* store basic data: */
 	line6->properties = properties;
 	line6->usbdev = usbdev;
 	line6->ifcdev = &interface->dev;
-	line6->type = devtype;
 
 	/* get data from endpoint descriptor (see usb_maxpacket): */
 	{
@@ -903,7 +594,6 @@ static int line6_probe(struct usb_interface *interface,
 
 		if (line6->urb_listen == NULL) {
 			dev_err(&interface->dev, "Out of memory\n");
-			line6_destruct(interface);
 			ret = -ENOMEM;
 			goto err_destruct;
 		}
@@ -917,50 +607,7 @@ static int line6_probe(struct usb_interface *interface,
 	}
 
 	/* initialize device data based on device: */
-	switch (devtype) {
-	case LINE6_BASSPODXT:
-	case LINE6_BASSPODXTLIVE:
-	case LINE6_BASSPODXTPRO:
-	case LINE6_POCKETPOD:
-	case LINE6_PODXT:
-	case LINE6_PODXTPRO:
-		ret = line6_pod_init(interface, line6);
-		break;
-
-	case LINE6_PODHD300:
-	case LINE6_PODHD400:
-	case LINE6_PODHD500_0:
-	case LINE6_PODHD500_1:
-		ret = line6_podhd_init(interface, line6);
-		break;
-
-	case LINE6_PODXTLIVE_POD:
-		ret = line6_pod_init(interface, line6);
-		break;
-
-	case LINE6_PODXTLIVE_VARIAX:
-		ret = line6_variax_init(interface, line6);
-		break;
-
-	case LINE6_VARIAX:
-		ret = line6_variax_init(interface, line6);
-		break;
-
-	case LINE6_PODSTUDIO_GX:
-	case LINE6_PODSTUDIO_UX1:
-	case LINE6_PODSTUDIO_UX2:
-	case LINE6_TONEPORT_GX:
-	case LINE6_TONEPORT_UX1:
-	case LINE6_TONEPORT_UX2:
-	case LINE6_GUITARPORT:
-		ret = line6_toneport_init(interface, line6);
-		break;
-
-	default:
-		MISSING_CASE;
-		ret = -ENODEV;
-	}
-
+	ret = private_init(interface, line6);
 	if (ret < 0)
 		goto err_destruct;
 
@@ -985,11 +632,12 @@ err_destruct:
 err_put:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(line6_probe);
 
 /*
 	Line6 device disconnected.
 */
-static void line6_disconnect(struct usb_interface *interface)
+void line6_disconnect(struct usb_interface *interface)
 {
 	struct usb_line6 *line6;
 	struct usb_device *usbdev;
@@ -1024,17 +672,21 @@ static void line6_disconnect(struct usb_interface *interface)
 
 	line6_destruct(interface);
 
+	/* free interface data: */
+	kfree(line6);
+
 	/* decrement reference counters: */
 	usb_put_intf(interface);
 	usb_put_dev(usbdev);
 }
+EXPORT_SYMBOL_GPL(line6_disconnect);
 
 #ifdef CONFIG_PM
 
 /*
 	Suspend Line6 device.
 */
-static int line6_suspend(struct usb_interface *interface, pm_message_t message)
+int line6_suspend(struct usb_interface *interface, pm_message_t message)
 {
 	struct usb_line6 *line6 = usb_get_intfdata(interface);
 	struct snd_line6_pcm *line6pcm = line6->line6pcm;
@@ -1052,11 +704,12 @@ static int line6_suspend(struct usb_interface *interface, pm_message_t message)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(line6_suspend);
 
 /*
 	Resume Line6 device.
 */
-static int line6_resume(struct usb_interface *interface)
+int line6_resume(struct usb_interface *interface)
 {
 	struct usb_line6 *line6 = usb_get_intfdata(interface);
 
@@ -1066,47 +719,10 @@ static int line6_resume(struct usb_interface *interface)
 	snd_power_change_state(line6->card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
-
-/*
-	Resume Line6 device after reset.
-*/
-static int line6_reset_resume(struct usb_interface *interface)
-{
-	struct usb_line6 *line6 = usb_get_intfdata(interface);
-
-	switch (line6->type) {
-	case LINE6_PODSTUDIO_GX:
-	case LINE6_PODSTUDIO_UX1:
-	case LINE6_PODSTUDIO_UX2:
-	case LINE6_TONEPORT_GX:
-	case LINE6_TONEPORT_UX1:
-	case LINE6_TONEPORT_UX2:
-	case LINE6_GUITARPORT:
-		line6_toneport_reset_resume((struct usb_line6_toneport *)line6);
-
-	default:
-		break;
-	}
-
-	return line6_resume(interface);
-}
+EXPORT_SYMBOL_GPL(line6_resume);
 
 #endif /* CONFIG_PM */
 
-static struct usb_driver line6_driver = {
-	.name = DRIVER_NAME,
-	.probe = line6_probe,
-	.disconnect = line6_disconnect,
-#ifdef CONFIG_PM
-	.suspend = line6_suspend,
-	.resume = line6_resume,
-	.reset_resume = line6_reset_resume,
-#endif
-	.id_table = line6_id_table,
-};
-
-module_usb_driver(line6_driver);
-
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index ad203f197e80..31cd318369e9 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -20,29 +20,6 @@
 
 #define DRIVER_NAME "line6usb"
 
-enum line6_device_type {
-	LINE6_BASSPODXT,
-	LINE6_BASSPODXTLIVE,
-	LINE6_BASSPODXTPRO,
-	LINE6_GUITARPORT,
-	LINE6_POCKETPOD,
-	LINE6_PODHD300,
-	LINE6_PODHD400,
-	LINE6_PODHD500_0,
-	LINE6_PODHD500_1,
-	LINE6_PODSTUDIO_GX,
-	LINE6_PODSTUDIO_UX1,
-	LINE6_PODSTUDIO_UX2,
-	LINE6_PODXT,
-	LINE6_PODXTLIVE_POD,
-	LINE6_PODXTLIVE_VARIAX,
-	LINE6_PODXTPRO,
-	LINE6_TONEPORT_GX,
-	LINE6_TONEPORT_UX1,
-	LINE6_TONEPORT_UX2,
-	LINE6_VARIAX
-};
-
 #define LINE6_TIMEOUT 1
 #define LINE6_BUFSIZE_LISTEN 32
 #define LINE6_MESSAGE_MAXLEN 256
@@ -135,11 +112,6 @@ struct usb_line6 {
 	struct usb_device *usbdev;
 
 	/**
-		 Device type.
-	*/
-	enum line6_device_type type;
-
-	/**
 		 Properties.
 	*/
 	const struct line6_properties *properties;
@@ -225,4 +197,15 @@ extern int line6_version_request_async(struct usb_line6 *line6);
 extern int line6_write_data(struct usb_line6 *line6, int address, void *data,
 			    size_t datalen);
 
+int line6_probe(struct usb_interface *interface,
+		struct usb_line6 *line6,
+		const struct line6_properties *properties,
+		int (*private_init)(struct usb_interface *, struct usb_line6 *));
+void line6_disconnect(struct usb_interface *interface);
+
+#ifdef CONFIG_PM
+int line6_suspend(struct usb_interface *interface, pm_message_t message);
+int line6_resume(struct usb_interface *interface);
+#endif
+
 #endif
diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index c9d725ae85a0..2a42d533f49c 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -11,13 +11,13 @@
 
 #include <linux/slab.h>
 #include <linux/usb.h>
+#include <linux/export.h>
 #include <sound/core.h>
 #include <sound/rawmidi.h>
 
 #include "audio.h"
 #include "driver.h"
 #include "midi.h"
-#include "pod.h"
 #include "usbdefs.h"
 
 #define line6_rawmidi_substream_midi(substream) \
@@ -319,3 +319,4 @@ int line6_init_midi(struct usb_line6 *line6)
 	spin_lock_init(&line6midi->midi_transmit_lock);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(line6_init_midi);
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 6d4e5cd0482c..b7348b031bf7 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/export.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
@@ -19,7 +20,6 @@
 #include "capture.h"
 #include "driver.h"
 #include "playback.h"
-#include "pod.h"
 
 #ifdef CONFIG_LINE6_USB_IMPULSE_RESPONSE
 
@@ -195,6 +195,7 @@ pcm_acquire_error:
 	line6_pcm_release(line6pcm, flags_final & channels);
 	return err;
 }
+EXPORT_SYMBOL_GPL(line6_pcm_acquire);
 
 int line6_pcm_release(struct snd_line6_pcm *line6pcm, int channels)
 {
@@ -223,6 +224,7 @@ int line6_pcm_release(struct snd_line6_pcm *line6pcm, int channels)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(line6_pcm_release);
 
 /* trigger callback */
 int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
@@ -408,6 +410,7 @@ void line6_pcm_disconnect(struct snd_line6_pcm *line6pcm)
 	line6_unlink_wait_clear_audio_out_urbs(line6pcm);
 	line6_unlink_wait_clear_audio_in_urbs(line6pcm);
 }
+EXPORT_SYMBOL_GPL(line6_pcm_disconnect);
 
 /*
 	Create and register the PCM device and mixer entries.
@@ -490,6 +493,7 @@ int line6_init_pcm(struct usb_line6 *line6,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(line6_init_pcm);
 
 /* prepare pcm callback */
 int snd_line6_prepare(struct snd_pcm_substream *substream)
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index da2e3b8876b8..0a874105ccef 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -18,7 +18,6 @@
 #include "capture.h"
 #include "driver.h"
 #include "pcm.h"
-#include "pod.h"
 #include "playback.h"
 
 /*
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 85a43631996e..dde9c2b8ad0f 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -11,13 +11,94 @@
 
 #include <linux/slab.h>
 #include <linux/wait.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#include <sound/core.h>
 #include <sound/control.h>
 
 #include "audio.h"
 #include "capture.h"
 #include "driver.h"
 #include "playback.h"
-#include "pod.h"
+#include "usbdefs.h"
+
+/*
+	Locate name in binary program dump
+*/
+#define	POD_NAME_OFFSET 0
+#define	POD_NAME_LENGTH 16
+
+/*
+	Other constants
+*/
+#define POD_CONTROL_SIZE 0x80
+#define POD_BUFSIZE_DUMPREQ 7
+#define POD_STARTUP_DELAY 1000
+
+/*
+	Stages of POD startup procedure
+*/
+enum {
+	POD_STARTUP_INIT = 1,
+	POD_STARTUP_VERSIONREQ,
+	POD_STARTUP_WORKQUEUE,
+	POD_STARTUP_SETUP,
+	POD_STARTUP_LAST = POD_STARTUP_SETUP - 1
+};
+
+enum {
+	LINE6_BASSPODXT,
+	LINE6_BASSPODXTLIVE,
+	LINE6_BASSPODXTPRO,
+	LINE6_POCKETPOD,
+	LINE6_PODXT,
+	LINE6_PODXTLIVE_POD,
+	LINE6_PODXTPRO,
+};
+
+struct usb_line6_pod {
+	/**
+		Generic Line6 USB data.
+	*/
+	struct usb_line6 line6;
+
+	/**
+		Instrument monitor level.
+	*/
+	int monitor_level;
+
+	/**
+		Timer for device initializaton.
+	*/
+	struct timer_list startup_timer;
+
+	/**
+		Work handler for device initializaton.
+	*/
+	struct work_struct startup_work;
+
+	/**
+		Current progress in startup procedure.
+	*/
+	int startup_progress;
+
+	/**
+		Serial number of device.
+	*/
+	int serial_number;
+
+	/**
+		Firmware version (x 100).
+	*/
+	int firmware_version;
+
+	/**
+		Device ID.
+	*/
+	int device_id;
+};
 
 #define POD_SYSEX_CODE 3
 #define POD_BYTES_PER_FRAME 6	/* 24bit audio (stereo) */
@@ -442,7 +523,8 @@ static int pod_try_init(struct usb_interface *interface,
 /*
 	 Init POD device (and clean up in case of failure).
 */
-int line6_pod_init(struct usb_interface *interface, struct usb_line6 *line6)
+static int pod_init(struct usb_interface *interface,
+		    struct usb_line6 *line6)
 {
 	int err = pod_try_init(interface, line6);
 
@@ -451,3 +533,141 @@ int line6_pod_init(struct usb_interface *interface, struct usb_line6 *line6)
 
 	return err;
 }
+
+#define LINE6_DEVICE(prod) USB_DEVICE(0x0e41, prod)
+#define LINE6_IF_NUM(prod, n) USB_DEVICE_INTERFACE_NUMBER(0x0e41, prod, n)
+
+/* table of devices that work with this driver */
+static const struct usb_device_id pod_id_table[] = {
+	{ LINE6_DEVICE(0x4250),    .driver_info = LINE6_BASSPODXT },
+	{ LINE6_DEVICE(0x4642),    .driver_info = LINE6_BASSPODXTLIVE },
+	{ LINE6_DEVICE(0x4252),    .driver_info = LINE6_BASSPODXTPRO },
+	{ LINE6_IF_NUM(0x5051, 1), .driver_info = LINE6_POCKETPOD },
+	{ LINE6_DEVICE(0x5044),    .driver_info = LINE6_PODXT },
+	{ LINE6_IF_NUM(0x4650, 0), .driver_info = LINE6_PODXTLIVE_POD },
+	{ LINE6_DEVICE(0x5050),    .driver_info = LINE6_PODXTPRO },
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, pod_id_table);
+
+static const struct line6_properties pod_properties_table[] = {
+	[LINE6_BASSPODXT] = {
+		.id = "BassPODxt",
+		.name = "BassPODxt",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM
+				| LINE6_CAP_HWMON,
+		.altsetting = 5,
+		.ep_ctrl_r = 0x84,
+		.ep_ctrl_w = 0x03,
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_BASSPODXTLIVE] = {
+		.id = "BassPODxtLive",
+		.name = "BassPODxt Live",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM
+				| LINE6_CAP_HWMON,
+		.altsetting = 1,
+		.ep_ctrl_r = 0x84,
+		.ep_ctrl_w = 0x03,
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_BASSPODXTPRO] = {
+		.id = "BassPODxtPro",
+		.name = "BassPODxt Pro",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM
+				| LINE6_CAP_HWMON,
+		.altsetting = 5,
+		.ep_ctrl_r = 0x84,
+		.ep_ctrl_w = 0x03,
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_POCKETPOD] = {
+		.id = "PocketPOD",
+		.name = "Pocket POD",
+		.capabilities	= LINE6_CAP_CONTROL,
+		.altsetting = 0,
+		.ep_ctrl_r = 0x82,
+		.ep_ctrl_w = 0x02,
+		/* no audio channel */
+	},
+	[LINE6_PODXT] = {
+		.id = "PODxt",
+		.name = "PODxt",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM
+				| LINE6_CAP_HWMON,
+		.altsetting = 5,
+		.ep_ctrl_r = 0x84,
+		.ep_ctrl_w = 0x03,
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_PODXTLIVE_POD] = {
+		.id = "PODxtLive",
+		.name = "PODxt Live",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM
+				| LINE6_CAP_HWMON,
+		.altsetting = 1,
+		.ep_ctrl_r = 0x84,
+		.ep_ctrl_w = 0x03,
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_PODXTPRO] = {
+		.id = "PODxtPro",
+		.name = "PODxt Pro",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM
+				| LINE6_CAP_HWMON,
+		.altsetting = 5,
+		.ep_ctrl_r = 0x84,
+		.ep_ctrl_w = 0x03,
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+};
+
+/*
+	Probe USB device.
+*/
+static int pod_probe(struct usb_interface *interface,
+		     const struct usb_device_id *id)
+{
+	struct usb_line6_pod *pod;
+	int err;
+
+	pod = kzalloc(sizeof(*pod), GFP_KERNEL);
+	if (!pod)
+		return -ENODEV;
+	err = line6_probe(interface, &pod->line6,
+			  &pod_properties_table[id->driver_info],
+			  pod_init);
+	if (err < 0)
+		kfree(pod);
+	return err;
+}
+
+static struct usb_driver pod_driver = {
+	.name = KBUILD_MODNAME,
+	.probe = pod_probe,
+	.disconnect = line6_disconnect,
+#ifdef CONFIG_PM
+	.suspend = line6_suspend,
+	.resume = line6_resume,
+	.reset_resume = line6_resume,
+#endif
+	.id_table = pod_id_table,
+};
+
+module_usb_driver(pod_driver);
+
+MODULE_DESCRIPTION("Line6 POD USB driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/usb/line6/pod.h b/sound/usb/line6/pod.h
deleted file mode 100644
index 87a8f0fa9cba..000000000000
--- a/sound/usb/line6/pod.h
+++ /dev/null
@@ -1,92 +0,0 @@
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
-#ifndef POD_H
-#define POD_H
-
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/usb.h>
-
-#include <sound/core.h>
-
-#include "driver.h"
-
-/*
-	Locate name in binary program dump
-*/
-#define	POD_NAME_OFFSET 0
-#define	POD_NAME_LENGTH 16
-
-/*
-	Other constants
-*/
-#define POD_CONTROL_SIZE 0x80
-#define POD_BUFSIZE_DUMPREQ 7
-#define POD_STARTUP_DELAY 1000
-
-/*
-	Stages of POD startup procedure
-*/
-enum {
-	POD_STARTUP_INIT = 1,
-	POD_STARTUP_VERSIONREQ,
-	POD_STARTUP_WORKQUEUE,
-	POD_STARTUP_SETUP,
-	POD_STARTUP_LAST = POD_STARTUP_SETUP - 1
-};
-
-struct usb_line6_pod {
-	/**
-		Generic Line6 USB data.
-	*/
-	struct usb_line6 line6;
-
-	/**
-		Instrument monitor level.
-	*/
-	int monitor_level;
-
-	/**
-		Timer for device initializaton.
-	*/
-	struct timer_list startup_timer;
-
-	/**
-		Work handler for device initializaton.
-	*/
-	struct work_struct startup_work;
-
-	/**
-		Current progress in startup procedure.
-	*/
-	int startup_progress;
-
-	/**
-		Serial number of device.
-	*/
-	int serial_number;
-
-	/**
-		Firmware version (x 100).
-	*/
-	int firmware_version;
-
-	/**
-		Device ID.
-	*/
-	int device_id;
-};
-
-extern int line6_pod_init(struct usb_interface *interface,
-			  struct usb_line6 *line6);
-
-#endif
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 27c5402cece8..84096326694c 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -9,13 +9,30 @@
  *
  */
 
+#include <linux/usb.h>
+#include <linux/slab.h>
+#include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 
 #include "audio.h"
 #include "driver.h"
 #include "pcm.h"
-#include "podhd.h"
+#include "usbdefs.h"
+
+enum {
+	LINE6_PODHD300,
+	LINE6_PODHD400,
+	LINE6_PODHD500_0,
+	LINE6_PODHD500_1,
+};
+
+struct usb_line6_podhd {
+	/**
+		Generic Line6 USB data.
+	*/
+	struct usb_line6 line6;
+};
 
 #define PODHD_BYTES_PER_FRAME 6	/* 24bit audio (stereo) */
 
@@ -141,10 +158,76 @@ static int podhd_try_init(struct usb_interface *interface,
 	return err;
 }
 
+#define LINE6_DEVICE(prod) USB_DEVICE(0x0e41, prod)
+#define LINE6_IF_NUM(prod, n) USB_DEVICE_INTERFACE_NUMBER(0x0e41, prod, n)
+
+/* table of devices that work with this driver */
+static const struct usb_device_id podhd_id_table[] = {
+	{ LINE6_DEVICE(0x5057),    .driver_info = LINE6_PODHD300 },
+	{ LINE6_DEVICE(0x5058),    .driver_info = LINE6_PODHD400 },
+	{ LINE6_IF_NUM(0x414D, 0), .driver_info = LINE6_PODHD500_0 },
+	{ LINE6_IF_NUM(0x414D, 1), .driver_info = LINE6_PODHD500_1 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, podhd_id_table);
+
+static const struct line6_properties podhd_properties_table[] = {
+	[LINE6_PODHD300] = {
+		.id = "PODHD300",
+		.name = "POD HD300",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM
+				| LINE6_CAP_HWMON,
+		.altsetting = 5,
+		.ep_ctrl_r = 0x84,
+		.ep_ctrl_w = 0x03,
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_PODHD400] = {
+		.id = "PODHD400",
+		.name = "POD HD400",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM
+				| LINE6_CAP_HWMON,
+		.altsetting = 5,
+		.ep_ctrl_r = 0x84,
+		.ep_ctrl_w = 0x03,
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_PODHD500_0] = {
+		.id = "PODHD500",
+		.name = "POD HD500",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM
+				| LINE6_CAP_HWMON,
+		.altsetting = 1,
+		.ep_ctrl_r = 0x81,
+		.ep_ctrl_w = 0x01,
+		.ep_audio_r = 0x86,
+		.ep_audio_w = 0x02,
+	},
+	[LINE6_PODHD500_1] = {
+		.id = "PODHD500",
+		.name = "POD HD500",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM
+				| LINE6_CAP_HWMON,
+		.altsetting = 1,
+		.ep_ctrl_r = 0x81,
+		.ep_ctrl_w = 0x01,
+		.ep_audio_r = 0x86,
+		.ep_audio_w = 0x02,
+	},
+};
+
 /*
 	Init POD HD device (and clean up in case of failure).
 */
-int line6_podhd_init(struct usb_interface *interface, struct usb_line6 *line6)
+static int podhd_init(struct usb_interface *interface,
+		      struct usb_line6 *line6)
 {
 	struct usb_line6_podhd *podhd = (struct usb_line6_podhd *) line6;
 	int err = podhd_try_init(interface, podhd);
@@ -154,3 +237,40 @@ int line6_podhd_init(struct usb_interface *interface, struct usb_line6 *line6)
 
 	return err;
 }
+
+/*
+	Probe USB device.
+*/
+static int podhd_probe(struct usb_interface *interface,
+		       const struct usb_device_id *id)
+{
+	struct usb_line6_podhd *podhd;
+	int err;
+
+	podhd = kzalloc(sizeof(*podhd), GFP_KERNEL);
+	if (!podhd)
+		return -ENODEV;
+	err = line6_probe(interface, &podhd->line6,
+			  &podhd_properties_table[id->driver_info],
+			  podhd_init);
+	if (err < 0)
+		kfree(podhd);
+	return err;
+}
+
+static struct usb_driver podhd_driver = {
+	.name = KBUILD_MODNAME,
+	.probe = podhd_probe,
+	.disconnect = line6_disconnect,
+#ifdef CONFIG_PM
+	.suspend = line6_suspend,
+	.resume = line6_resume,
+	.reset_resume = line6_resume,
+#endif
+	.id_table = podhd_id_table,
+};
+
+module_usb_driver(podhd_driver);
+
+MODULE_DESCRIPTION("Line6 PODHD USB driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/usb/line6/podhd.h b/sound/usb/line6/podhd.h
deleted file mode 100644
index a14f711f9725..000000000000
--- a/sound/usb/line6/podhd.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Line6 Pod HD
- *
- * Copyright (C) 2011 Stefan Hajnoczi <stefanha@gmail.com>
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License as
- *	published by the Free Software Foundation, version 2.
- *
- */
-
-#ifndef PODHD_H
-#define PODHD_H
-
-#include <linux/usb.h>
-
-#include "driver.h"
-
-struct usb_line6_podhd {
-	/**
-		Generic Line6 USB data.
-	*/
-	struct usb_line6 line6;
-};
-
-extern int line6_podhd_init(struct usb_interface *interface,
-			    struct usb_line6 *line6);
-
-#endif /* PODHD_H */
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 7f97f4a812a7..4f07643e47f2 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -11,13 +11,59 @@
  */
 
 #include <linux/wait.h>
+#include <linux/usb.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <sound/core.h>
 #include <sound/control.h>
 
 #include "audio.h"
 #include "capture.h"
 #include "driver.h"
 #include "playback.h"
-#include "toneport.h"
+#include "usbdefs.h"
+
+enum line6_device_type {
+	LINE6_GUITARPORT,
+	LINE6_PODSTUDIO_GX,
+	LINE6_PODSTUDIO_UX1,
+	LINE6_PODSTUDIO_UX2,
+	LINE6_TONEPORT_GX,
+	LINE6_TONEPORT_UX1,
+	LINE6_TONEPORT_UX2,
+};
+
+struct usb_line6_toneport {
+	/**
+		Generic Line6 USB data.
+	*/
+	struct usb_line6 line6;
+
+	/**
+		Source selector.
+	*/
+	int source;
+
+	/**
+		Serial number of device.
+	*/
+	int serial_number;
+
+	/**
+		Firmware version (x 100).
+	*/
+	int firmware_version;
+
+	/**
+		 Timer for delayed PCM startup.
+	*/
+	struct timer_list timer;
+
+	/**
+		 Device type.
+	*/
+	enum line6_device_type type;
+};
 
 static int toneport_send_cmd(struct usb_device *usbdev, int cmd1, int cmd2);
 
@@ -319,7 +365,7 @@ static void toneport_setup(struct usb_line6_toneport *toneport)
 	toneport_send_cmd(usbdev, 0x0301, 0x0000);
 
 	/* initialize source select: */
-	switch (line6->type) {
+	switch (toneport->type) {
 	case LINE6_TONEPORT_UX1:
 	case LINE6_TONEPORT_UX2:
 	case LINE6_PODSTUDIO_UX1:
@@ -331,7 +377,7 @@ static void toneport_setup(struct usb_line6_toneport *toneport)
 		break;
 	}
 
-	if (toneport_has_led(line6->type))
+	if (toneport_has_led(toneport->type))
 		toneport_update_led(&usbdev->dev);
 }
 
@@ -400,7 +446,7 @@ static int toneport_try_init(struct usb_interface *interface,
 		return err;
 
 	/* register source select control: */
-	switch (line6->type) {
+	switch (toneport->type) {
 	case LINE6_TONEPORT_UX1:
 	case LINE6_TONEPORT_UX2:
 	case LINE6_PODSTUDIO_UX1:
@@ -424,7 +470,7 @@ static int toneport_try_init(struct usb_interface *interface,
 	line6_read_serial_number(line6, &toneport->serial_number);
 	line6_read_data(line6, 0x80c2, &toneport->firmware_version, 1);
 
-	if (toneport_has_led(line6->type)) {
+	if (toneport_has_led(toneport->type)) {
 		CHECK_RETURN(device_create_file
 			     (&interface->dev, &dev_attr_led_red));
 		CHECK_RETURN(device_create_file
@@ -443,8 +489,8 @@ static int toneport_try_init(struct usb_interface *interface,
 /*
 	 Init Toneport device (and clean up in case of failure).
 */
-int line6_toneport_init(struct usb_interface *interface,
-			struct usb_line6 *line6)
+static int toneport_init(struct usb_interface *interface,
+			 struct usb_line6 *line6)
 {
 	int err = toneport_try_init(interface, line6);
 
@@ -454,10 +500,134 @@ int line6_toneport_init(struct usb_interface *interface,
 	return err;
 }
 
+#ifdef CONFIG_PM
 /*
 	Resume Toneport device after reset.
 */
-void line6_toneport_reset_resume(struct usb_line6_toneport *toneport)
+static int toneport_reset_resume(struct usb_interface *interface)
 {
-	toneport_setup(toneport);
+	toneport_setup(usb_get_intfdata(interface));
+	return line6_resume(interface);
 }
+#endif
+
+#define LINE6_DEVICE(prod) USB_DEVICE(0x0e41, prod)
+#define LINE6_IF_NUM(prod, n) USB_DEVICE_INTERFACE_NUMBER(0x0e41, prod, n)
+
+/* table of devices that work with this driver */
+static const struct usb_device_id toneport_id_table[] = {
+	{ LINE6_DEVICE(0x4750),    .driver_info = LINE6_GUITARPORT },
+	{ LINE6_DEVICE(0x4153),    .driver_info = LINE6_PODSTUDIO_GX },
+	{ LINE6_DEVICE(0x4150),    .driver_info = LINE6_PODSTUDIO_UX1 },
+	{ LINE6_IF_NUM(0x4151, 0), .driver_info = LINE6_PODSTUDIO_UX2 },
+	{ LINE6_DEVICE(0x4147),    .driver_info = LINE6_TONEPORT_GX },
+	{ LINE6_DEVICE(0x4141),    .driver_info = LINE6_TONEPORT_UX1 },
+	{ LINE6_IF_NUM(0x4142, 0), .driver_info = LINE6_TONEPORT_UX2 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, toneport_id_table);
+
+static const struct line6_properties toneport_properties_table[] = {
+	[LINE6_GUITARPORT] = {
+		.id = "GuitarPort",
+		.name = "GuitarPort",
+		.capabilities	= LINE6_CAP_PCM,
+		.altsetting = 2,  /* 1..4 seem to be ok */
+		/* no control channel */
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_PODSTUDIO_GX] = {
+		.id = "PODStudioGX",
+		.name = "POD Studio GX",
+		.capabilities	= LINE6_CAP_PCM,
+		.altsetting = 2,  /* 1..4 seem to be ok */
+		/* no control channel */
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_PODSTUDIO_UX1] = {
+		.id = "PODStudioUX1",
+		.name = "POD Studio UX1",
+		.capabilities	= LINE6_CAP_PCM,
+		.altsetting = 2,  /* 1..4 seem to be ok */
+		/* no control channel */
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_PODSTUDIO_UX2] = {
+		.id = "PODStudioUX2",
+		.name = "POD Studio UX2",
+		.capabilities	= LINE6_CAP_PCM,
+		.altsetting = 2,  /* defaults to 44.1kHz, 16-bit */
+		/* no control channel */
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_TONEPORT_GX] = {
+		.id = "TonePortGX",
+		.name = "TonePort GX",
+		.capabilities	= LINE6_CAP_PCM,
+		.altsetting = 2,  /* 1..4 seem to be ok */
+		/* no control channel */
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_TONEPORT_UX1] = {
+		.id = "TonePortUX1",
+		.name = "TonePort UX1",
+		.capabilities	= LINE6_CAP_PCM,
+		.altsetting = 2,  /* 1..4 seem to be ok */
+		/* no control channel */
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_TONEPORT_UX2] = {
+		.id = "TonePortUX2",
+		.name = "TonePort UX2",
+		.capabilities	= LINE6_CAP_PCM,
+		.altsetting = 2,  /* defaults to 44.1kHz, 16-bit */
+		/* no control channel */
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+};
+
+/*
+	Probe USB device.
+*/
+static int toneport_probe(struct usb_interface *interface,
+			  const struct usb_device_id *id)
+{
+	struct usb_line6_toneport *toneport;
+	int err;
+
+	toneport = kzalloc(sizeof(*toneport), GFP_KERNEL);
+	if (!toneport)
+		return -ENODEV;
+	toneport->type = id->driver_info;
+	err = line6_probe(interface, &toneport->line6,
+			  &toneport_properties_table[id->driver_info],
+			  toneport_init);
+	if (err < 0)
+		kfree(toneport);
+	return err;
+}
+
+static struct usb_driver toneport_driver = {
+	.name = KBUILD_MODNAME,
+	.probe = toneport_probe,
+	.disconnect = line6_disconnect,
+#ifdef CONFIG_PM
+	.suspend = line6_suspend,
+	.resume = line6_resume,
+	.reset_resume = toneport_reset_resume,
+#endif
+	.id_table = toneport_id_table,
+};
+
+module_usb_driver(toneport_driver);
+
+MODULE_DESCRIPTION("TonePort USB driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/usb/line6/toneport.h b/sound/usb/line6/toneport.h
deleted file mode 100644
index 8cb14426f6ae..000000000000
--- a/sound/usb/line6/toneport.h
+++ /dev/null
@@ -1,51 +0,0 @@
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
-#ifndef TONEPORT_H
-#define TONEPORT_H
-
-#include <linux/usb.h>
-#include <sound/core.h>
-
-#include "driver.h"
-
-struct usb_line6_toneport {
-	/**
-		Generic Line6 USB data.
-	*/
-	struct usb_line6 line6;
-
-	/**
-		Source selector.
-	*/
-	int source;
-
-	/**
-		Serial number of device.
-	*/
-	int serial_number;
-
-	/**
-		Firmware version (x 100).
-	*/
-	int firmware_version;
-
-	/**
-		 Timer for delayed PCM startup.
-	*/
-	struct timer_list timer;
-};
-
-extern int line6_toneport_init(struct usb_interface *interface,
-			       struct usb_line6 *line6);
-extern void line6_toneport_reset_resume(struct usb_line6_toneport *toneport);
-
-#endif
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index b4a41b0ad0ea..0c852bb1e76c 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -10,10 +10,65 @@
  */
 
 #include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/usb.h>
+#include <linux/wait.h>
+#include <linux/module.h>
+#include <sound/core.h>
 
 #include "audio.h"
 #include "driver.h"
-#include "variax.h"
+#include "usbdefs.h"
+
+#define VARIAX_STARTUP_DELAY1 1000
+#define VARIAX_STARTUP_DELAY3 100
+#define VARIAX_STARTUP_DELAY4 100
+
+/*
+	Stages of Variax startup procedure
+*/
+enum {
+	VARIAX_STARTUP_INIT = 1,
+	VARIAX_STARTUP_VERSIONREQ,
+	VARIAX_STARTUP_WAIT,
+	VARIAX_STARTUP_ACTIVATE,
+	VARIAX_STARTUP_WORKQUEUE,
+	VARIAX_STARTUP_SETUP,
+	VARIAX_STARTUP_LAST = VARIAX_STARTUP_SETUP - 1
+};
+
+enum {
+	LINE6_PODXTLIVE_VARIAX,
+	LINE6_VARIAX
+};
+
+struct usb_line6_variax {
+	/**
+		Generic Line6 USB data.
+	*/
+	struct usb_line6 line6;
+
+	/**
+		Buffer for activation code.
+	*/
+	unsigned char *buffer_activate;
+
+	/**
+		Handler for device initializaton.
+	*/
+	struct work_struct startup_work;
+
+	/**
+		Timers for device initializaton.
+	*/
+	struct timer_list startup_timer1;
+	struct timer_list startup_timer2;
+
+	/**
+		Current progress in startup procedure.
+	*/
+	int startup_progress;
+};
 
 #define VARIAX_OFFSET_ACTIVATE 7
 
@@ -228,7 +283,8 @@ static int variax_try_init(struct usb_interface *interface,
 /*
 	 Init workbench device (and clean up in case of failure).
 */
-int line6_variax_init(struct usb_interface *interface, struct usb_line6 *line6)
+static int variax_init(struct usb_interface *interface,
+		       struct usb_line6 *line6)
 {
 	int err = variax_try_init(interface, line6);
 
@@ -237,3 +293,76 @@ int line6_variax_init(struct usb_interface *interface, struct usb_line6 *line6)
 
 	return err;
 }
+
+#define LINE6_DEVICE(prod) USB_DEVICE(0x0e41, prod)
+#define LINE6_IF_NUM(prod, n) USB_DEVICE_INTERFACE_NUMBER(0x0e41, prod, n)
+
+/* table of devices that work with this driver */
+static const struct usb_device_id variax_id_table[] = {
+	{ LINE6_IF_NUM(0x4650, 1), .driver_info = LINE6_PODXTLIVE_VARIAX },
+	{ LINE6_DEVICE(0x534d),    .driver_info = LINE6_VARIAX },
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, variax_id_table);
+
+static const struct line6_properties variax_properties_table[] = {
+	[LINE6_PODXTLIVE_VARIAX] = {
+		.id = "PODxtLive",
+		.name = "PODxt Live",
+		.capabilities	= LINE6_CAP_CONTROL
+				| LINE6_CAP_PCM
+				| LINE6_CAP_HWMON,
+		.altsetting = 1,
+		.ep_ctrl_r = 0x86,
+		.ep_ctrl_w = 0x05,
+		.ep_audio_r = 0x82,
+		.ep_audio_w = 0x01,
+	},
+	[LINE6_VARIAX] = {
+		.id = "Variax",
+		.name = "Variax Workbench",
+		.capabilities	= LINE6_CAP_CONTROL,
+		.altsetting = 1,
+		.ep_ctrl_r = 0x82,
+		.ep_ctrl_w = 0x01,
+		/* no audio channel */
+	}
+};
+
+/*
+	Probe USB device.
+*/
+static int variax_probe(struct usb_interface *interface,
+			const struct usb_device_id *id)
+{
+	struct usb_line6_variax *variax;
+	int err;
+
+	variax = kzalloc(sizeof(*variax), GFP_KERNEL);
+	if (!variax)
+		return -ENODEV;
+	err = line6_probe(interface, &variax->line6,
+			  &variax_properties_table[id->driver_info],
+			  variax_init);
+	if (err < 0)
+		kfree(variax);
+	return err;
+}
+
+static struct usb_driver variax_driver = {
+	.name = KBUILD_MODNAME,
+	.probe = variax_probe,
+	.disconnect = line6_disconnect,
+#ifdef CONFIG_PM
+	.suspend = line6_suspend,
+	.resume = line6_resume,
+	.reset_resume = line6_resume,
+#endif
+	.id_table = variax_id_table,
+};
+
+module_usb_driver(variax_driver);
+
+MODULE_DESCRIPTION("Vairax Workbench USB driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/usb/line6/variax.h b/sound/usb/line6/variax.h
deleted file mode 100644
index dfb94e574cc4..000000000000
--- a/sound/usb/line6/variax.h
+++ /dev/null
@@ -1,70 +0,0 @@
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
-#ifndef VARIAX_H
-#define VARIAX_H
-
-#include <linux/spinlock.h>
-#include <linux/usb.h>
-#include <linux/wait.h>
-#include <sound/core.h>
-
-#include "driver.h"
-
-#define VARIAX_STARTUP_DELAY1 1000
-#define VARIAX_STARTUP_DELAY3 100
-#define VARIAX_STARTUP_DELAY4 100
-
-/*
-	Stages of Variax startup procedure
-*/
-enum {
-	VARIAX_STARTUP_INIT = 1,
-	VARIAX_STARTUP_VERSIONREQ,
-	VARIAX_STARTUP_WAIT,
-	VARIAX_STARTUP_ACTIVATE,
-	VARIAX_STARTUP_WORKQUEUE,
-	VARIAX_STARTUP_SETUP,
-	VARIAX_STARTUP_LAST = VARIAX_STARTUP_SETUP - 1
-};
-
-struct usb_line6_variax {
-	/**
-		Generic Line6 USB data.
-	*/
-	struct usb_line6 line6;
-
-	/**
-		Buffer for activation code.
-	*/
-	unsigned char *buffer_activate;
-
-	/**
-		Handler for device initializaton.
-	*/
-	struct work_struct startup_work;
-
-	/**
-		Timers for device initializaton.
-	*/
-	struct timer_list startup_timer1;
-	struct timer_list startup_timer2;
-
-	/**
-		Current progress in startup procedure.
-	*/
-	int startup_progress;
-};
-
-extern int line6_variax_init(struct usb_interface *interface,
-			     struct usb_line6 *line6);
-
-#endif
-- 
2.2.1
