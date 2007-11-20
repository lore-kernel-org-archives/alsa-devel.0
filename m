From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH 1/2] caiaq/NativeInstruments: input handling
	fixes
Date: Tue, 20 Nov 2007 14:35:28 +0100
Message-ID: <20071120133528.GB4425@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7683D24A05
	for <Alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 14:35:33 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm re-posting a patch from Dmitry Torokhov which cleans up some input
layer related things. It hasn't made its way to any repository yet but
my subsequent patch needs it as dependency. I Cc'ed Dmitry to avoid
confusion.

Subject: SOUND: caiaq - misc input handling fixes
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

SOUND: caiaq - misc input handling fixes

 - link input device with its parent so that it placed in proper spot
   in sysfs hierarchy
 - drivers that allow changing their keymaps should use private copy
   of the keymap so that one instance of a device does not affect
   another instance
 - it is preferred for drivers to properly set up input_dev->phys to
   help userspace locate devices
 - drivers should use usb_to_input_id(), or perform endianess conversion,
   themselves, otherwise ID is not correct on big-endian boxes
 - whitespace and formatting cleanup

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Daniel Mack <daniel@caiaq.de>


--45Z9DzgjV8m4Oswq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-caiaq-1.2.0-inputfixes.diff"

Index: work/sound/usb/caiaq/caiaq-device.h
===================================================================
--- work.orig/sound/usb/caiaq/caiaq-device.h
+++ work/sound/usb/caiaq/caiaq-device.h
@@ -7,7 +7,7 @@

 #define USB_PID_RIGKONTROL2	0x1969
 #define USB_PID_RIGKONTROL3	0x1940
-#define USB_PID_KORECONTROLLER 	0x4711
+#define USB_PID_KORECONTROLLER	0x4711
 #define USB_PID_AK1		0x0815
 #define USB_PID_AUDIO8DJ	0x1978

@@ -62,7 +62,7 @@ struct snd_usb_caiaqdev {
 	struct urb **data_urbs_in;
 	struct urb **data_urbs_out;
 	struct snd_usb_caiaq_cb_info *data_cb_info;
-	
+
 	unsigned char ep1_in_buf[EP1_BUFSIZE];
 	unsigned char ep1_out_buf[EP1_BUFSIZE];
 	unsigned char midi_out_buf[EP1_BUFSIZE];
@@ -72,7 +72,7 @@ struct snd_usb_caiaqdev {
 	wait_queue_head_t ep1_wait_queue;
 	wait_queue_head_t prepare_wait_queue;
 	int spec_received, audio_parm_answer;
-	
+
 	char vendor_name[CAIAQ_USB_STR_LEN];
 	char product_name[CAIAQ_USB_STR_LEN];
 	char serial[CAIAQ_USB_STR_LEN];
@@ -93,8 +93,10 @@ struct snd_usb_caiaqdev {
 	/* Linux input */
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
 	struct input_dev *input_dev;
+	char phys[64];			/* physical device path */
+	unsigned short keycode[10];
 #endif
-	
+
 	/* ALSA */
 	struct snd_pcm *pcm;
 	struct snd_pcm_hardware pcm_info;
Index: work/sound/usb/caiaq/caiaq-input.c
===================================================================
--- work.orig/sound/usb/caiaq/caiaq-input.c
+++ work/sound/usb/caiaq/caiaq-input.c
@@ -21,6 +21,7 @@
 #include <linux/moduleparam.h>
 #include <linux/input.h>
 #include <linux/usb.h>
+#include <linux/usb/input.h>
 #include <linux/spinlock.h>
 #include <sound/driver.h>
 #include <sound/core.h>
@@ -31,18 +32,18 @@

 #ifdef CONFIG_SND_USB_CAIAQ_INPUT

-static unsigned char keycode_ak1[] =  { KEY_C, KEY_B, KEY_A };
-static unsigned char keycode_rk2[] =  { KEY_1, KEY_2, KEY_3, KEY_4, 
-					KEY_5, KEY_6, KEY_7 };
-static unsigned char keycode_rk3[] =  { KEY_1, KEY_2, KEY_3, KEY_4,
-					KEY_5, KEY_6, KEY_7, KEY_5, KEY_6 };
-
-#define DEG90  (range/2)
-#define DEG180 (range)
-#define DEG270 (DEG90 + DEG180)
-#define DEG360 (DEG180 * 2)
-#define HIGH_PEAK (268)
-#define LOW_PEAK (-7)
+static unsigned short keycode_ak1[] =  { KEY_C, KEY_B, KEY_A };
+static unsigned short keycode_rk2[] =  { KEY_1, KEY_2, KEY_3, KEY_4,
+					 KEY_5, KEY_6, KEY_7 };
+static unsigned short keycode_rk3[] =  { KEY_1, KEY_2, KEY_3, KEY_4,
+					 KEY_5, KEY_6, KEY_7, KEY_5, KEY_6 };
+
+#define DEG90		(range / 2)
+#define DEG180		(range)
+#define DEG270		(DEG90 + DEG180)
+#define DEG360		(DEG180 * 2)
+#define HIGH_PEAK	(268)
+#define LOW_PEAK	(-7)

 /* some of these devices have endless rotation potentiometers
  * built in which use two tapers, 90 degrees phase shifted.
@@ -56,8 +57,8 @@ static unsigned int decode_erp(unsigned 
 	int range = HIGH_PEAK - LOW_PEAK;
 	int mid_value = (HIGH_PEAK + LOW_PEAK) / 2;

-	weight_b = abs(mid_value-a) - (range/2 - 100)/2;
-	
+	weight_b = abs(mid_value - a) - (range / 2 - 100) / 2;
+
 	if (weight_b < 0)
 		weight_b = 0;

@@ -93,7 +94,7 @@ static unsigned int decode_erp(unsigned 

 	if (ret < 0)
 		ret += 1000;
-	
+
 	if (ret >= 1000)
 		ret -= 1000;

@@ -108,76 +109,80 @@ static unsigned int decode_erp(unsigned 
 #undef LOW_PEAK


-static void snd_caiaq_input_read_analog(struct snd_usb_caiaqdev *dev, 
+static void snd_caiaq_input_read_analog(struct snd_usb_caiaqdev *dev,
 					const unsigned char *buf,
 					unsigned int len)
 {
-	switch(dev->input_dev->id.product) {
+	struct input_dev *input_dev = dev->input_dev;
+
+	switch(input_dev->id.product) {
 	case USB_PID_RIGKONTROL2:
-		input_report_abs(dev->input_dev, ABS_X, (buf[4] << 8) |buf[5]);
-		input_report_abs(dev->input_dev, ABS_Y, (buf[0] << 8) |buf[1]);
-		input_report_abs(dev->input_dev, ABS_Z, (buf[2] << 8) |buf[3]);
-		input_sync(dev->input_dev);
+		input_report_abs(input_dev, ABS_X, (buf[4] << 8) | buf[5]);
+		input_report_abs(input_dev, ABS_Y, (buf[0] << 8) | buf[1]);
+		input_report_abs(input_dev, ABS_Z, (buf[2] << 8) | buf[3]);
+		input_sync(input_dev);
 		break;
 	case USB_PID_RIGKONTROL3:
-		input_report_abs(dev->input_dev, ABS_X, (buf[0] << 8) |buf[1]);
-		input_report_abs(dev->input_dev, ABS_Y, (buf[2] << 8) |buf[3]);
-		input_report_abs(dev->input_dev, ABS_Z, (buf[4] << 8) |buf[5]);
-		input_sync(dev->input_dev);
+		input_report_abs(input_dev, ABS_X, (buf[0] << 8) | buf[1]);
+		input_report_abs(input_dev, ABS_Y, (buf[2] << 8) | buf[3]);
+		input_report_abs(input_dev, ABS_Z, (buf[4] << 8) | buf[5]);
+		input_sync(input_dev);
 		break;
 	}
 }

-static void snd_caiaq_input_read_erp(struct snd_usb_caiaqdev *dev, 
+static void snd_caiaq_input_read_erp(struct snd_usb_caiaqdev *dev,
 				     const char *buf, unsigned int len)
 {
+	struct input_dev *input_dev = dev->input_dev;
 	int i;

-	switch(dev->input_dev->id.product) {
+	switch(input_dev->id.product) {
 	case USB_PID_AK1:
 		i = decode_erp(buf[0], buf[1]);
-		input_report_abs(dev->input_dev, ABS_X, i);
-		input_sync(dev->input_dev);
+		input_report_abs(input_dev, ABS_X, i);
+		input_sync(input_dev);
 		break;
 	}
 }

-static void snd_caiaq_input_read_io(struct snd_usb_caiaqdev *dev, 
+static void snd_caiaq_input_read_io(struct snd_usb_caiaqdev *dev,
 				    char *buf, unsigned int len)
 {
+	struct input_dev *input_dev = dev->input_dev;
+	unsigned short *keycode = input_dev->keycode;
 	int i;
-	unsigned char *keycode = dev->input_dev->keycode;

 	if (!keycode)
 		return;

-	if (dev->input_dev->id.product == USB_PID_RIGKONTROL2)
-		for (i=0; i<len; i++)
+	if (input_dev->id.product == USB_PID_RIGKONTROL2)
+		for (i = 0; i < len; i++)
 			buf[i] = ~buf[i];

-	for (i=0; (i<dev->input_dev->keycodemax) && (i < len); i++)
-		input_report_key(dev->input_dev, keycode[i], 
-					buf[i/8] & (1 << (i%8)));
+	for (i = 0; i < input_dev->keycodemax && i < len; i++)
+		input_report_key(input_dev, keycode[i],
+				 buf[i / 8] & (1 << (i % 8)));

-	input_sync(dev->input_dev);
+	input_sync(input_dev);
 }

-void snd_usb_caiaq_input_dispatch(struct snd_usb_caiaqdev *dev, 
-				  char *buf, 
+void snd_usb_caiaq_input_dispatch(struct snd_usb_caiaqdev *dev,
+				  char *buf,
 				  unsigned int len)
 {
-	if (!dev->input_dev || (len < 1))
+	if (!dev->input_dev || len < 1)
 		return;

 	switch (buf[0]) {
 	case EP1_CMD_READ_ANALOG:
-		snd_caiaq_input_read_analog(dev, buf+1, len-1);
+		snd_caiaq_input_read_analog(dev, buf + 1, len - 1);
 		break;
 	case EP1_CMD_READ_ERP:
-		snd_caiaq_input_read_erp(dev, buf+1, len-1);
+		snd_caiaq_input_read_erp(dev, buf + 1, len - 1);
 		break;
 	case EP1_CMD_READ_IO:
-		snd_caiaq_input_read_io(dev, buf+1, len-1);
+		snd_caiaq_input_read_io(dev, buf + 1, len - 1);
 		break;
 	}
 }
@@ -192,37 +197,34 @@ int snd_usb_caiaq_input_init(struct snd_
 	if (!input)
 		return -ENOMEM;

+	usb_make_path(usb_dev, dev->phys, sizeof(dev->phys));
+	strlcat(dev->phys, "/input0", sizeof(dev->phys));
+
 	input->name = dev->product_name;
-	input->id.bustype = BUS_USB;
-	input->id.vendor  = usb_dev->descriptor.idVendor;
-	input->id.product = usb_dev->descriptor.idProduct;
-	input->id.version = usb_dev->descriptor.bcdDevice;
+	input->phys = dev->phys;
+	usb_to_input_id(usb_dev, &input->id);
+	input->dev.parent = &usb_dev->dev;

         switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL2):
 		input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 		input->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) |
 			BIT_MASK(ABS_Z);
-		input->keycode = keycode_rk2;
-		input->keycodesize = sizeof(char);
+		BUILD_BUG_ON(sizeof(dev->keycode) < sizeof(keycode_rk2));
+		memcpy(dev->keycode, keycode_rk2, sizeof(keycode_rk2));
 		input->keycodemax = ARRAY_SIZE(keycode_rk2);
-		for (i=0; i<ARRAY_SIZE(keycode_rk2); i++)
-			set_bit(keycode_rk2[i], input->keybit);
-
 		input_set_abs_params(input, ABS_X, 0, 4096, 0, 10);
 		input_set_abs_params(input, ABS_Y, 0, 4096, 0, 10);
 		input_set_abs_params(input, ABS_Z, 0, 4096, 0, 10);
 		snd_usb_caiaq_set_auto_msg(dev, 1, 10, 0);
 		break;
+
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
 		input->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 		input->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_Z);
-		input->keycode = keycode_rk3;
-		input->keycodesize = sizeof(char);
+		BUILD_BUG_ON(sizeof(dev->keycode) < sizeof(keycode_rk3));
+		memcpy(dev->keycode, keycode_rk3, sizeof(keycode_rk3));
 		input->keycodemax = ARRAY_SIZE(keycode_rk3);
-		for (i=0; i<ARRAY_SIZE(keycode_rk3); i++)
-			set_bit(keycode_rk3[i], input->keybit);
-
 		input_set_abs_params(input, ABS_X, 0, 1024, 0, 10);
 		input_set_abs_params(input, ABS_Y, 0, 1024, 0, 10);
 		input_set_abs_params(input, ABS_Z, 0, 1024, 0, 10);
@@ -231,12 +233,9 @@ int snd_usb_caiaq_input_init(struct snd_
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AK1):
 		input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 		input->absbit[0] = BIT_MASK(ABS_X);
-		input->keycode = keycode_ak1;
-		input->keycodesize = sizeof(char);
+		BUILD_BUG_ON(sizeof(dev->keycode) < sizeof(keycode_ak1));
+		memcpy(dev->keycode, keycode_ak1, sizeof(keycode_ak1));
 		input->keycodemax = ARRAY_SIZE(keycode_ak1);
-		for (i=0; i<ARRAY_SIZE(keycode_ak1); i++)
-			set_bit(keycode_ak1[i], input->keybit);
-
 		input_set_abs_params(input, ABS_X, 0, 999, 0, 10);
 		snd_usb_caiaq_set_auto_msg(dev, 1, 0, 5);
 		break;
@@ -246,6 +245,11 @@ int snd_usb_caiaq_input_init(struct snd_
 		return 0;
 	}

+	input->keycode = dev->keycode;
+	input->keycodesize = sizeof(unsigned short);
+	for (i = 0; i < input->keycodemax; i++)
+		__set_bit(dev->keycode[i], input->keybit);
+
 	ret = input_register_device(input);
 	if (ret < 0) {
 		input_free_device(input);

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--45Z9DzgjV8m4Oswq--
