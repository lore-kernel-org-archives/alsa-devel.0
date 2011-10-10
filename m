From: William Light <alsa-dev@wrl.illest.net>
Subject: [PATCH 2/2] ALSA: snd-usb-caiaq: Add support for
	Maschine
Date: Mon, 10 Oct 2011 15:54:23 +0000
Message-ID: <1318262063-19247-3-git-send-email-alsa-dev@wrl.illest.net>
References: <1318262063-19247-1-git-send-email-alsa-dev@wrl.illest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dudestache.don.gs (don.gs [208.79.89.122])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C3CB103881
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 17:55:07 +0200 (CEST)
In-Reply-To: <1318262063-19247-1-git-send-email-alsa-dev@wrl.illest.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: William Light <wrl@illest.net>
List-Id: alsa-devel@alsa-project.org

From: William Light <wrl@illest.net>

This adds partial support for the Maschine controller by Native Instruments.
Supported now are the 1x1 MIDI interface and the 41 buttons, 11 endless
rotary encoders, and 16 pressure-sensitive drum pads. Still to work on are the
dimmable LEDs and the two monochrome screens.

Signed-off-by: William Light <wrl@illest.net>
---
 sound/usb/Kconfig        |    2 +
 sound/usb/caiaq/device.c |    8 ++-
 sound/usb/caiaq/device.h |    1 +
 sound/usb/caiaq/input.c  |  151 +++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 8beb775..3efc21c 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -67,6 +67,7 @@ config SND_USB_CAIAQ
 	    * Native Instruments Guitar Rig mobile
 	    * Native Instruments Traktor Kontrol X1
 	    * Native Instruments Traktor Kontrol S4
+	    * Native Instruments Maschine Controller
 
 	   To compile this driver as a module, choose M here: the module
 	   will be called snd-usb-caiaq.
@@ -85,6 +86,7 @@ config SND_USB_CAIAQ_INPUT
 	   * Native Instruments Kore Controller 2
 	   * Native Instruments Audio Kontrol 1
 	   * Native Instruments Traktor Kontrol S4
+	   * Native Instruments Maschine Controller
 
 config SND_USB_US122L
 	tristate "Tascam US-122L USB driver"
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 45bc4a2..3eb605b 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -50,7 +50,8 @@ MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, Session I/O},"
 			 "{Native Instruments, GuitarRig mobile}"
 			 "{Native Instruments, Traktor Kontrol X1}"
-			 "{Native Instruments, Traktor Kontrol S4}");
+			 "{Native Instruments, Traktor Kontrol S4}"
+			 "{Native Instruments, Maschine Controller}");
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
@@ -146,6 +147,11 @@ static struct usb_device_id snd_usb_id_table[] = {
 		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
 		.idProduct =    USB_PID_TRAKTORAUDIO2
 	},
+	{
+		.match_flags =  USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
+		.idProduct =    USB_PID_MASCHINECONTROLLER
+	},
 	{ /* terminator */ }
 };
 
diff --git a/sound/usb/caiaq/device.h b/sound/usb/caiaq/device.h
index 3f9c633..562b0bf 100644
--- a/sound/usb/caiaq/device.h
+++ b/sound/usb/caiaq/device.h
@@ -18,6 +18,7 @@
 #define USB_PID_TRAKTORKONTROLX1	0x2305
 #define USB_PID_TRAKTORKONTROLS4	0xbaff
 #define USB_PID_TRAKTORAUDIO2		0x041d
+#define USB_PID_MASCHINECONTROLLER  0x0808
 
 #define EP1_BUFSIZE 64
 #define EP4_BUFSIZE 512
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 9efb92e..26a121b 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -67,6 +67,61 @@ static unsigned short keycode_kore[] = {
 	KEY_BRL_DOT5
 };
 
+#define MASCHINE_BUTTONS   (42)
+#define MASCHINE_BUTTON(X) ((X) + BTN_MISC)
+#define MASCHINE_PADS      (16)
+#define MASCHINE_PAD(X)    ((X) + ABS_PRESSURE)
+
+static unsigned short keycode_maschine[] = {
+	MASCHINE_BUTTON(40), /* mute       */
+	MASCHINE_BUTTON(39), /* solo       */
+	MASCHINE_BUTTON(38), /* select     */
+	MASCHINE_BUTTON(37), /* duplicate  */
+	MASCHINE_BUTTON(36), /* navigate   */
+	MASCHINE_BUTTON(35), /* pad mode   */
+	MASCHINE_BUTTON(34), /* pattern    */
+	MASCHINE_BUTTON(33), /* scene      */
+	KEY_RESERVED, /* spacer */
+
+	MASCHINE_BUTTON(30), /* rec        */
+	MASCHINE_BUTTON(31), /* erase      */
+	MASCHINE_BUTTON(32), /* shift      */
+	MASCHINE_BUTTON(28), /* grid       */
+	MASCHINE_BUTTON(27), /* >          */
+	MASCHINE_BUTTON(26), /* <          */
+	MASCHINE_BUTTON(25), /* restart    */
+
+	MASCHINE_BUTTON(21), /* E          */
+	MASCHINE_BUTTON(22), /* F          */
+	MASCHINE_BUTTON(23), /* G          */
+	MASCHINE_BUTTON(24), /* H          */
+	MASCHINE_BUTTON(20), /* D          */
+	MASCHINE_BUTTON(19), /* C          */
+	MASCHINE_BUTTON(18), /* B          */
+	MASCHINE_BUTTON(17), /* A          */
+
+	MASCHINE_BUTTON(0),  /* control    */
+	MASCHINE_BUTTON(2),  /* browse     */
+	MASCHINE_BUTTON(4),  /* <          */
+	MASCHINE_BUTTON(6),  /* snap       */
+	MASCHINE_BUTTON(7),  /* autowrite  */
+	MASCHINE_BUTTON(5),  /* >          */
+	MASCHINE_BUTTON(3),  /* sampling   */
+	MASCHINE_BUTTON(1),  /* step       */
+
+	MASCHINE_BUTTON(15), /* 8 softkeys */
+	MASCHINE_BUTTON(14),
+	MASCHINE_BUTTON(13),
+	MASCHINE_BUTTON(12),
+	MASCHINE_BUTTON(11),
+	MASCHINE_BUTTON(10),
+	MASCHINE_BUTTON(9),
+	MASCHINE_BUTTON(8),
+
+	MASCHINE_BUTTON(16), /* note repeat */
+	MASCHINE_BUTTON(29)  /* play        */
+};
+
 #define KONTROLX1_INPUTS	(40)
 #define KONTROLS4_BUTTONS	(12 * 8)
 #define KONTROLS4_AXIS		(46)
@@ -218,6 +273,29 @@ static void snd_caiaq_input_read_erp(struct snd_usb_caiaqdev *dev,
 		input_report_abs(input_dev, ABS_HAT3Y, i);
 		input_sync(input_dev);
 		break;
+
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_MASCHINECONTROLLER):
+		/* 4 under the left screen */
+		input_report_abs(input_dev, ABS_HAT0X, decode_erp(buf[21], buf[20]));
+		input_report_abs(input_dev, ABS_HAT0Y, decode_erp(buf[15], buf[14]));
+		input_report_abs(input_dev, ABS_HAT1X, decode_erp(buf[9],  buf[8]));
+		input_report_abs(input_dev, ABS_HAT1Y, decode_erp(buf[3],  buf[2]));
+
+		/* 4 under the right screen */
+		input_report_abs(input_dev, ABS_HAT2X, decode_erp(buf[19], buf[18]));
+		input_report_abs(input_dev, ABS_HAT2Y, decode_erp(buf[13], buf[12]));
+		input_report_abs(input_dev, ABS_HAT3X, decode_erp(buf[7],  buf[6]));
+		input_report_abs(input_dev, ABS_HAT3Y, decode_erp(buf[1],  buf[0]));
+
+		/* volume */
+		input_report_abs(input_dev, ABS_RX, decode_erp(buf[17], buf[16]));
+		/* tempo */
+		input_report_abs(input_dev, ABS_RY, decode_erp(buf[11], buf[10]));
+		/* swing */
+		input_report_abs(input_dev, ABS_RZ, decode_erp(buf[5],  buf[4]));
+
+		input_sync(input_dev);
+		break;
 	}
 }
 
@@ -400,6 +478,25 @@ static void snd_usb_caiaq_tks4_dispatch(struct snd_usb_caiaqdev *dev,
 	input_sync(dev->input_dev);
 }
 
+#define MASCHINE_MSGBLOCK_SIZE 2
+
+static void snd_usb_caiaq_maschine_dispatch(struct snd_usb_caiaqdev *dev,
+					const unsigned char *buf,
+					unsigned int len)
+{
+	unsigned int i, pad_id;
+	uint16_t pressure;
+
+	for (i = 0; i < MASCHINE_PADS; i++) {
+		pressure = be16_to_cpu(buf[i * 2] << 8 | buf[(i * 2) + 1]);
+		pad_id = pressure >> 12;
+
+		input_report_abs(dev->input_dev, MASCHINE_PAD(pad_id), pressure & 0xfff);
+	}
+
+	input_sync(dev->input_dev);
+}
+
 static void snd_usb_caiaq_ep4_reply_dispatch(struct urb *urb)
 {
 	struct snd_usb_caiaqdev *dev = urb->context;
@@ -425,6 +522,13 @@ static void snd_usb_caiaq_ep4_reply_dispatch(struct urb *urb)
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLS4):
 		snd_usb_caiaq_tks4_dispatch(dev, buf, urb->actual_length);
 		break;
+
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_MASCHINECONTROLLER):
+		if (urb->actual_length < (MASCHINE_PADS * MASCHINE_MSGBLOCK_SIZE))
+			goto requeue;
+
+		snd_usb_caiaq_maschine_dispatch(dev, buf, urb->actual_length);
+		break;
 	}
 
 requeue:
@@ -444,6 +548,7 @@ static int snd_usb_caiaq_input_open(struct input_dev *idev)
 	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLS4):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_MASCHINECONTROLLER):
 		if (usb_submit_urb(dev->ep4_in_urb, GFP_KERNEL) != 0)
 			return -EIO;
 		break;
@@ -462,6 +567,7 @@ static void snd_usb_caiaq_input_close(struct input_dev *idev)
 	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLS4):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_MASCHINECONTROLLER):
 		usb_kill_urb(dev->ep4_in_urb);
 		break;
 	}
@@ -652,6 +758,50 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *dev)
 
 		break;
 
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_MASCHINECONTROLLER):
+		input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+		input->absbit[0] = BIT_MASK(ABS_HAT0X) | BIT_MASK(ABS_HAT0Y) |
+			BIT_MASK(ABS_HAT1X) | BIT_MASK(ABS_HAT1Y) |
+			BIT_MASK(ABS_HAT2X) | BIT_MASK(ABS_HAT2Y) |
+			BIT_MASK(ABS_HAT3X) | BIT_MASK(ABS_HAT3Y) |
+			BIT_MASK(ABS_RX) | BIT_MASK(ABS_RY) |
+			BIT_MASK(ABS_RZ);
+
+		BUILD_BUG_ON(sizeof(dev->keycode) < sizeof(keycode_maschine));
+		memcpy(dev->keycode, keycode_maschine, sizeof(keycode_maschine));
+		input->keycodemax = ARRAY_SIZE(keycode_maschine);
+
+		for (i = 0; i < MASCHINE_PADS; i++) {
+			input->absbit[0] |= MASCHINE_PAD(i);
+			input_set_abs_params(input, MASCHINE_PAD(i), 0, 0xfff, 5, 10);
+		}
+
+		input_set_abs_params(input, ABS_HAT0X, 0, 999, 0, 10);
+		input_set_abs_params(input, ABS_HAT0Y, 0, 999, 0, 10);
+		input_set_abs_params(input, ABS_HAT1X, 0, 999, 0, 10);
+		input_set_abs_params(input, ABS_HAT1Y, 0, 999, 0, 10);
+		input_set_abs_params(input, ABS_HAT2X, 0, 999, 0, 10);
+		input_set_abs_params(input, ABS_HAT2Y, 0, 999, 0, 10);
+		input_set_abs_params(input, ABS_HAT3X, 0, 999, 0, 10);
+		input_set_abs_params(input, ABS_HAT3Y, 0, 999, 0, 10);
+		input_set_abs_params(input, ABS_RX, 0, 999, 0, 10);
+		input_set_abs_params(input, ABS_RY, 0, 999, 0, 10);
+		input_set_abs_params(input, ABS_RZ, 0, 999, 0, 10);
+
+		dev->ep4_in_urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!dev->ep4_in_urb) {
+			ret = -ENOMEM;
+			goto exit_free_idev;
+		}
+
+		usb_fill_bulk_urb(dev->ep4_in_urb, usb_dev,
+				  usb_rcvbulkpipe(usb_dev, 0x4),
+				  dev->ep4_in_buf, EP4_BUFSIZE,
+				  snd_usb_caiaq_ep4_reply_dispatch, dev);
+
+		snd_usb_caiaq_set_auto_msg(dev, 1, 10, 5);
+		break;
+
 	default:
 		/* no input methods supported on this device */
 		goto exit_free_idev;
@@ -690,4 +840,3 @@ void snd_usb_caiaq_input_free(struct snd_usb_caiaqdev *dev)
 	input_unregister_device(dev->input_dev);
 	dev->input_dev = NULL;
 }
-
-- 
1.7.6.1
