From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: usb/caiaq: Add support for Traktor
	Kontrol X1
Date: Mon, 22 Mar 2010 13:15:59 +0100
Message-ID: <1269260159-10060-1-git-send-email-daniel@caiaq.de>
References: <1269260017-9964-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B64A32443C
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 13:16:26 +0100 (CET)
In-Reply-To: <1269260017-9964-1-git-send-email-daniel@caiaq.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dtor@mail.ru>
List-Id: alsa-devel@alsa-project.org

This device does not have audio controllers and backlit buttons only.
Input data is handled over a dedicated USB endpoint.

All functions are supported by the driver now.

Bumped the version number to 1.3.21.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Torokhov <dtor@mail.ru>
---
 The previous version forgot to bump the number.
 Take this one instead please.

 sound/usb/Kconfig         |    1 +
 sound/usb/caiaq/control.c |   99 ++++++++++++++++++++++------
 sound/usb/caiaq/device.c  |   10 ++-
 sound/usb/caiaq/device.h  |   24 ++++---
 sound/usb/caiaq/input.c   |  162 +++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 250 insertions(+), 46 deletions(-)

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index c570ae3..c4dcbad 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -65,6 +65,7 @@ config SND_USB_CAIAQ
 	    * Native Instruments Audio 8 DJ
 	    * Native Instruments Guitar Rig Session I/O
 	    * Native Instruments Guitar Rig mobile
+	    * Native Instruments Traktor Kontrol X1
 
 	   To compile this driver as a module, choose M here: the module
 	   will be called snd-usb-caiaq.
diff --git a/sound/usb/caiaq/control.c b/sound/usb/caiaq/control.c
index 537102b..36ed703 100644
--- a/sound/usb/caiaq/control.c
+++ b/sound/usb/caiaq/control.c
@@ -35,33 +35,41 @@ static int control_info(struct snd_kcontrol *kcontrol,
 	struct snd_usb_caiaqdev *dev = caiaqdev(chip->card);
 	int pos = kcontrol->private_value;
 	int is_intval = pos & CNT_INTVAL;
-	unsigned int id = dev->chip.usb_id;
+	int maxval = 63;
 
 	uinfo->count = 1;
 	pos &= ~CNT_INTVAL;
 
-	if (id == USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ)
-		&& (pos == 0)) {
-		/* current input mode of A8DJ */
-		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-		uinfo->value.integer.min = 0;
-		uinfo->value.integer.max = 2;
-		return 0;
-	}
+	switch (dev->chip.usb_id) {
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ):
+		if (pos == 0) {
+			/* current input mode of A8DJ */
+			uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+			uinfo->value.integer.min = 0;
+			uinfo->value.integer.max = 2;
+			return 0;
+		}
+		break;
 
-	if (id == USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ)
-		&& (pos == 0)) {
-		/* current input mode of A4DJ */
-		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-		uinfo->value.integer.min = 0;
-		uinfo->value.integer.max = 1;
-		return 0;
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ):
+		if (pos == 0) {
+			/* current input mode of A4DJ */
+			uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+			uinfo->value.integer.min = 0;
+			uinfo->value.integer.max = 1;
+			return 0;
+		}
+		break;
+
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+		maxval = 127;
+		break;
 	}
 
 	if (is_intval) {
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 		uinfo->value.integer.min = 0;
-		uinfo->value.integer.max = 64;
+		uinfo->value.integer.max = maxval;
 	} else {
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 		uinfo->value.integer.min = 0;
@@ -102,9 +110,10 @@ static int control_put(struct snd_kcontrol *kcontrol,
 	struct snd_usb_audio *chip = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_caiaqdev *dev = caiaqdev(chip->card);
 	int pos = kcontrol->private_value;
+	unsigned char cmd = EP1_CMD_WRITE_IO;
 
-	if (dev->chip.usb_id ==
-		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ)) {
+	switch (dev->chip.usb_id) {
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ): {
 		/* A4DJ has only one control */
 		/* do not expose hardware input mode 0 */
 		dev->control_state[0] = ucontrol->value.integer.value[0] + 1;
@@ -113,10 +122,15 @@ static int control_put(struct snd_kcontrol *kcontrol,
 		return 1;
 	}
 
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+		cmd = EP1_CMD_DIMM_LEDS;
+		break;
+	}
+
 	if (pos & CNT_INTVAL) {
 		dev->control_state[pos & ~CNT_INTVAL]
 			= ucontrol->value.integer.value[0];
-		snd_usb_caiaq_send_command(dev, EP1_CMD_WRITE_IO,
+		snd_usb_caiaq_send_command(dev, cmd,
 				dev->control_state, sizeof(dev->control_state));
 	} else {
 		if (ucontrol->value.integer.value[0])
@@ -124,7 +138,7 @@ static int control_put(struct snd_kcontrol *kcontrol,
 		else
 			dev->control_state[pos / 8] &= ~(1 << (pos % 8));
 
-		snd_usb_caiaq_send_command(dev, EP1_CMD_WRITE_IO,
+		snd_usb_caiaq_send_command(dev, cmd,
 				dev->control_state, sizeof(dev->control_state));
 	}
 
@@ -273,6 +287,43 @@ static struct caiaq_controller a4dj_controller[] = {
 	{ "Current input mode",	0 | CNT_INTVAL 	}
 };
 
+static struct caiaq_controller kontrolx1_controller[] = {
+	{ "LED FX A: ON",		7 | CNT_INTVAL	},
+	{ "LED FX A: 1",		6 | CNT_INTVAL	},
+	{ "LED FX A: 2",		5 | CNT_INTVAL	},
+	{ "LED FX A: 3",		4 | CNT_INTVAL	},
+	{ "LED FX B: ON",		3 | CNT_INTVAL	},
+	{ "LED FX B: 1",		2 | CNT_INTVAL	},
+	{ "LED FX B: 2",		1 | CNT_INTVAL	},
+	{ "LED FX B: 3",		0 | CNT_INTVAL	},
+
+	{ "LED Hotcue",			28 | CNT_INTVAL	},
+	{ "LED Shift (white)",		29 | CNT_INTVAL	},
+	{ "LED Shift (green)",		30 | CNT_INTVAL	},
+
+	{ "LED Deck A: FX1",		24 | CNT_INTVAL	},
+	{ "LED Deck A: FX2",		25 | CNT_INTVAL	},
+	{ "LED Deck A: IN",		17 | CNT_INTVAL	},
+	{ "LED Deck A: OUT",		16 | CNT_INTVAL	},
+	{ "LED Deck A: < BEAT",		19 | CNT_INTVAL	},
+	{ "LED Deck A: BEAT >",		18 | CNT_INTVAL	},
+	{ "LED Deck A: CUE/ABS",	21 | CNT_INTVAL	},
+	{ "LED Deck A: CUP/REL",	20 | CNT_INTVAL	},
+	{ "LED Deck A: PLAY",		23 | CNT_INTVAL	},
+	{ "LED Deck A: SYNC",		22 | CNT_INTVAL	},
+
+	{ "LED Deck B: FX1",		26 | CNT_INTVAL	},
+	{ "LED Deck B: FX2",		27 | CNT_INTVAL	},
+	{ "LED Deck B: IN",		15 | CNT_INTVAL	},
+	{ "LED Deck B: OUT",		14 | CNT_INTVAL	},
+	{ "LED Deck B: < BEAT",		13 | CNT_INTVAL	},
+	{ "LED Deck B: BEAT >",		12 | CNT_INTVAL	},
+	{ "LED Deck B: CUE/ABS",	11 | CNT_INTVAL	},
+	{ "LED Deck B: CUP/REL",	10 | CNT_INTVAL	},
+	{ "LED Deck B: PLAY",		9  | CNT_INTVAL	},
+	{ "LED Deck B: SYNC",		8  | CNT_INTVAL	},
+};
+
 static int __devinit add_controls(struct caiaq_controller *c, int num,
 				  struct snd_usb_caiaqdev *dev)
 {
@@ -321,10 +372,16 @@ int __devinit snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
 		ret = add_controls(a8dj_controller,
 			ARRAY_SIZE(a8dj_controller), dev);
 		break;
+
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ):
 		ret = add_controls(a4dj_controller,
 			ARRAY_SIZE(a4dj_controller), dev);
 		break;
+
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+		ret = add_controls(kontrolx1_controller,
+			ARRAY_SIZE(kontrolx1_controller), dev);
+		break;
 	}
 
 	return ret;
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index a3f02dd..3f27afe 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -35,7 +35,7 @@
 #include "input.h"
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.20");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.21");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
@@ -46,7 +46,8 @@ MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, Audio 4 DJ},"
 			 "{Native Instruments, Audio 8 DJ},"
 			 "{Native Instruments, Session I/O},"
-			 "{Native Instruments, GuitarRig mobile}");
+			 "{Native Instruments, GuitarRig mobile}"
+			 "{Native Instruments, Traktor Kontrol X1}");
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
@@ -127,6 +128,11 @@ static struct usb_device_id snd_usb_id_table[] = {
 		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
 		.idProduct =    USB_PID_AUDIO2DJ
 	},
+	{
+		.match_flags =  USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
+		.idProduct =    USB_PID_TRAKTORKONTROLX1
+	},
 	{ /* terminator */ }
 };
 
diff --git a/sound/usb/caiaq/device.h b/sound/usb/caiaq/device.h
index 44e3edf..f1117ec 100644
--- a/sound/usb/caiaq/device.h
+++ b/sound/usb/caiaq/device.h
@@ -5,18 +5,20 @@
 
 #define USB_VID_NATIVEINSTRUMENTS 0x17cc
 
-#define USB_PID_RIGKONTROL2	0x1969
-#define USB_PID_RIGKONTROL3	0x1940
-#define USB_PID_KORECONTROLLER	0x4711
-#define USB_PID_KORECONTROLLER2	0x4712
-#define USB_PID_AK1		0x0815
-#define USB_PID_AUDIO2DJ	0x041c
-#define USB_PID_AUDIO4DJ	0x0839
-#define USB_PID_AUDIO8DJ	0x1978
-#define USB_PID_SESSIONIO	0x1915
-#define USB_PID_GUITARRIGMOBILE	0x0d8d
+#define USB_PID_RIGKONTROL2		0x1969
+#define USB_PID_RIGKONTROL3		0x1940
+#define USB_PID_KORECONTROLLER		0x4711
+#define USB_PID_KORECONTROLLER2		0x4712
+#define USB_PID_AK1			0x0815
+#define USB_PID_AUDIO2DJ		0x041c
+#define USB_PID_AUDIO4DJ		0x0839
+#define USB_PID_AUDIO8DJ		0x1978
+#define USB_PID_SESSIONIO		0x1915
+#define USB_PID_GUITARRIGMOBILE		0x0d8d
+#define USB_PID_TRAKTORKONTROLX1	0x2305
 
 #define EP1_BUFSIZE 64
+#define EP4_BUFSIZE 512
 #define CAIAQ_USB_STR_LEN 0xff
 #define MAX_STREAMS 32
 
@@ -104,6 +106,8 @@ struct snd_usb_caiaqdev {
 	struct input_dev *input_dev;
 	char phys[64];			/* physical device path */
 	unsigned short keycode[64];
+	struct urb *ep4_in_urb;
+	unsigned char ep4_in_buf[EP4_BUFSIZE];
 #endif
 
 	/* ALSA */
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index a48d309..27ed0bc 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/usb.h>
 #include <linux/usb/input.h>
+#include <sound/core.h>
 #include <sound/pcm.h>
 
 #include "device.h"
@@ -65,6 +66,8 @@ static unsigned short keycode_kore[] = {
 	KEY_BRL_DOT5
 };
 
+#define KONTROLX1_INPUTS 40
+
 #define DEG90		(range / 2)
 #define DEG180		(range)
 #define DEG270		(DEG90 + DEG180)
@@ -162,6 +165,17 @@ static void snd_caiaq_input_read_analog(struct snd_usb_caiaqdev *dev,
 		input_report_abs(input_dev, ABS_Z, (buf[4] << 8) | buf[5]);
 		input_sync(input_dev);
 		break;
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+		input_report_abs(input_dev, ABS_HAT0X, (buf[8] << 8)  | buf[9]);
+		input_report_abs(input_dev, ABS_HAT0Y, (buf[4] << 8)  | buf[5]);
+		input_report_abs(input_dev, ABS_HAT1X, (buf[12] << 8) | buf[13]);
+		input_report_abs(input_dev, ABS_HAT1Y, (buf[2] << 8)  | buf[3]);
+		input_report_abs(input_dev, ABS_HAT2X, (buf[15] << 8) | buf[15]);
+		input_report_abs(input_dev, ABS_HAT2Y, (buf[0] << 8)  | buf[1]);
+		input_report_abs(input_dev, ABS_HAT3X, (buf[10] << 8) | buf[11]);
+		input_report_abs(input_dev, ABS_HAT3Y, (buf[6] << 8)  | buf[7]);
+		input_sync(input_dev);
+		break;
 	}
 }
 
@@ -201,7 +215,7 @@ static void snd_caiaq_input_read_erp(struct snd_usb_caiaqdev *dev,
 }
 
 static void snd_caiaq_input_read_io(struct snd_usb_caiaqdev *dev,
-				    char *buf, unsigned int len)
+				    unsigned char *buf, unsigned int len)
 {
 	struct input_dev *input_dev = dev->input_dev;
 	unsigned short *keycode = input_dev->keycode;
@@ -218,15 +232,84 @@ static void snd_caiaq_input_read_io(struct snd_usb_caiaqdev *dev,
 		input_report_key(input_dev, keycode[i],
 				 buf[i / 8] & (1 << (i % 8)));
 
-	if (dev->chip.usb_id ==
-		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER) ||
-	    dev->chip.usb_id ==
-		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER2))
+	switch (dev->chip.usb_id) {
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER2):
 		input_report_abs(dev->input_dev, ABS_MISC, 255 - buf[4]);
+		break;
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+		/* rotary encoders */
+		input_report_abs(dev->input_dev, ABS_X, buf[5] & 0xf);
+		input_report_abs(dev->input_dev, ABS_Y, buf[5] >> 4);
+		input_report_abs(dev->input_dev, ABS_Z, buf[6] & 0xf);
+		input_report_abs(dev->input_dev, ABS_MISC, buf[6] >> 4);
+		break;
+	}
 
 	input_sync(input_dev);
 }
 
+static void snd_usb_caiaq_ep4_reply_dispatch(struct urb *urb)
+{
+	struct snd_usb_caiaqdev *dev = urb->context;
+	unsigned char *buf = urb->transfer_buffer;
+	int ret;
+
+	if (urb->status || !dev || urb != dev->ep4_in_urb)
+		return;
+
+	if (urb->actual_length < 24)
+		goto requeue;
+
+	switch (dev->chip.usb_id) {
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+		if (buf[0] & 0x3)
+			snd_caiaq_input_read_io(dev, buf + 1, 7);
+
+		if (buf[0] & 0x4)
+			snd_caiaq_input_read_analog(dev, buf + 8, 16);
+
+		break;
+	}
+
+requeue:
+	dev->ep4_in_urb->actual_length = 0;
+	ret = usb_submit_urb(dev->ep4_in_urb, GFP_ATOMIC);
+	if (ret < 0)
+		log("unable to submit urb. OOM!?\n");
+}
+
+static int snd_usb_caiaq_input_open(struct input_dev *idev)
+{
+	struct snd_usb_caiaqdev *dev = input_get_drvdata(idev);
+
+	if (!dev)
+		return -EINVAL;
+
+	switch (dev->chip.usb_id) {
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+		if (usb_submit_urb(dev->ep4_in_urb, GFP_KERNEL) != 0)
+			return -EIO;
+		break;
+	}
+
+	return 0;
+}
+
+static void snd_usb_caiaq_input_close(struct input_dev *idev)
+{
+	struct snd_usb_caiaqdev *dev = input_get_drvdata(idev);
+
+	if (!dev)
+		return;
+
+	switch (dev->chip.usb_id) {
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+		usb_kill_urb(dev->ep4_in_urb);
+		break;
+	}
+}
+
 void snd_usb_caiaq_input_dispatch(struct snd_usb_caiaqdev *dev,
 				  char *buf,
 				  unsigned int len)
@@ -251,7 +334,7 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *dev)
 {
 	struct usb_device *usb_dev = dev->chip.dev;
 	struct input_dev *input;
-	int i, ret;
+	int i, ret = 0;
 
 	input = input_allocate_device();
 	if (!input)
@@ -265,7 +348,9 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *dev)
 	usb_to_input_id(usb_dev, &input->id);
 	input->dev.parent = &usb_dev->dev;
 
-        switch (dev->chip.usb_id) {
+	input_set_drvdata(input, dev);
+
+	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL2):
 		input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 		input->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) |
@@ -326,25 +411,72 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *dev)
 		input_set_abs_params(input, ABS_MISC, 0, 255, 0, 1);
 		snd_usb_caiaq_set_auto_msg(dev, 1, 10, 5);
 		break;
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+		input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+		input->absbit[0] = BIT_MASK(ABS_HAT0X) | BIT_MASK(ABS_HAT0Y) |
+				   BIT_MASK(ABS_HAT1X) | BIT_MASK(ABS_HAT1Y) |
+				   BIT_MASK(ABS_HAT2X) | BIT_MASK(ABS_HAT2Y) |
+				   BIT_MASK(ABS_HAT3X) | BIT_MASK(ABS_HAT3Y) |
+				   BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) |
+				   BIT_MASK(ABS_Z);
+		input->absbit[BIT_WORD(ABS_MISC)] |= BIT_MASK(ABS_MISC);
+		BUILD_BUG_ON(sizeof(dev->keycode) < KONTROLX1_INPUTS);
+		for (i = 0; i < KONTROLX1_INPUTS; i++)
+			dev->keycode[i] = BTN_MISC + i;
+		input->keycodemax = KONTROLX1_INPUTS;
+
+		/* analog potentiometers */
+		input_set_abs_params(input, ABS_HAT0X, 0, 4096, 0, 10);
+		input_set_abs_params(input, ABS_HAT0Y, 0, 4096, 0, 10);
+		input_set_abs_params(input, ABS_HAT1X, 0, 4096, 0, 10);
+		input_set_abs_params(input, ABS_HAT1Y, 0, 4096, 0, 10);
+		input_set_abs_params(input, ABS_HAT2X, 0, 4096, 0, 10);
+		input_set_abs_params(input, ABS_HAT2Y, 0, 4096, 0, 10);
+		input_set_abs_params(input, ABS_HAT3X, 0, 4096, 0, 10);
+		input_set_abs_params(input, ABS_HAT3Y, 0, 4096, 0, 10);
+
+		/* rotary encoders */
+		input_set_abs_params(input, ABS_X, 0, 0xf, 0, 1);
+		input_set_abs_params(input, ABS_Y, 0, 0xf, 0, 1);
+		input_set_abs_params(input, ABS_Z, 0, 0xf, 0, 1);
+		input_set_abs_params(input, ABS_MISC, 0, 0xf, 0, 1);
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
+
+		break;
 	default:
 		/* no input methods supported on this device */
-		input_free_device(input);
-		return 0;
+		goto exit_free_idev;
 	}
 
+	input->open = snd_usb_caiaq_input_open;
+	input->close = snd_usb_caiaq_input_close;
 	input->keycode = dev->keycode;
 	input->keycodesize = sizeof(unsigned short);
 	for (i = 0; i < input->keycodemax; i++)
 		__set_bit(dev->keycode[i], input->keybit);
 
 	ret = input_register_device(input);
-	if (ret < 0) {
-		input_free_device(input);
-		return ret;
-	}
+	if (ret < 0)
+		goto exit_free_idev;
 
 	dev->input_dev = input;
 	return 0;
+
+exit_free_idev:
+	input_free_device(input);
+	return ret;
 }
 
 void snd_usb_caiaq_input_free(struct snd_usb_caiaqdev *dev)
@@ -352,6 +484,10 @@ void snd_usb_caiaq_input_free(struct snd_usb_caiaqdev *dev)
 	if (!dev || !dev->input_dev)
 		return;
 
+	usb_kill_urb(dev->ep4_in_urb);
+	usb_free_urb(dev->ep4_in_urb);
+	dev->ep4_in_urb = NULL;
+
 	input_unregister_device(dev->input_dev);
 	dev->input_dev = NULL;
 }
-- 
1.7.0
