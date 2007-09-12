From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] support for Native Instrument's RigKontrol3
Date: Wed, 12 Sep 2007 20:30:00 +0200
Message-ID: <20070912183000.GA24452@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 246CC24427
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 20:30:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 8E8AA7F4018
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 20:30:04 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y8YYc8qErDl9 for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 20:30:00 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Re-posting because of missing Signed-off-by:

Hi,

This patch adds support for Native Instrument's upcoming 
RigKontrol3 sound interface.

Signed-off-by: Daniel Mack <daniel@caiaq.de>



--FCuugMFkClbJLl1L
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-rk3.diff"

diff -Nur linux-2.6.22/sound/usb/caiaq/caiaq-audio.c linux-2.6.22-rk3/sound/usb/caiaq/caiaq-audio.c
--- linux-2.6.22/sound/usb/caiaq/caiaq-audio.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22-rk3/sound/usb/caiaq/caiaq-audio.c	2007-09-12 19:12:25.000000000 +0200
@@ -648,6 +648,7 @@
 	dev->samplerates = dev->pcm_info.rates;
 	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AK1):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
 		dev->samplerates |= SNDRV_PCM_RATE_88200;
 		dev->samplerates |= SNDRV_PCM_RATE_192000;
 		break;
diff -Nur linux-2.6.22/sound/usb/caiaq/caiaq-device.c linux-2.6.22-rk3/sound/usb/caiaq/caiaq-device.c
--- linux-2.6.22/sound/usb/caiaq/caiaq-device.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22-rk3/sound/usb/caiaq/caiaq-device.c	2007-09-12 19:20:52.000000000 +0200
@@ -41,9 +41,10 @@
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.1.0");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.2.0");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
+			 "{Native Instruments, RigKontrol3},"
 			 "{Native Instruments, Kore Controller},"
 			 "{Native Instruments, Audio Kontrol 1}"
 			 "{Native Instruments, Audio 8 DJ}}");
@@ -85,6 +86,11 @@
 	{
 		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
 		.idVendor =	USB_VID_NATIVEINSTRUMENTS,
+		.idProduct =	USB_PID_RIGKONTROL3
+	},
+	{
+		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =	USB_VID_NATIVEINSTRUMENTS,
 		.idProduct =	USB_PID_KORECONTROLLER
 	},
 	{
@@ -226,7 +232,7 @@
 static void setup_card(struct snd_usb_caiaqdev *dev)
 {
 	int ret;
-	char val[3];
+	char val[4];
 	
 	/* device-specific startup specials */
 	switch (dev->chip.usb_id) {
@@ -237,6 +243,14 @@
 		val[2] = 0x01;
 		send_command(dev, EP1_CMD_WRITE_IO, val, 3);
 		break;
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
+		/* RigKontrol2 - display two centered dashes ('--') */
+		val[0] = 0x00;
+		val[1] = 0x40;
+		val[2] = 0x40;
+		val[3] = 0x00;
+		send_command(dev, EP1_CMD_WRITE_IO, val, 4);
+		break;
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AK1):
 		/* Audio Kontrol 1 - make USB-LED stop blinking */
 		val[0] = 0x00;
diff -Nur linux-2.6.22/sound/usb/caiaq/caiaq-device.h linux-2.6.22-rk3/sound/usb/caiaq/caiaq-device.h
--- linux-2.6.22/sound/usb/caiaq/caiaq-device.h	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22-rk3/sound/usb/caiaq/caiaq-device.h	2007-09-12 19:14:00.000000000 +0200
@@ -6,6 +6,7 @@
 #define USB_VID_NATIVEINSTRUMENTS 0x17cc
 
 #define USB_PID_RIGKONTROL2	0x1969
+#define USB_PID_RIGKONTROL3	0x1940
 #define USB_PID_KORECONTROLLER 	0x4711
 #define USB_PID_AK1		0x0815
 #define USB_PID_AUDIO8DJ	0x1978
diff -Nur linux-2.6.22/sound/usb/caiaq/caiaq-input.c linux-2.6.22-rk3/sound/usb/caiaq/caiaq-input.c
--- linux-2.6.22/sound/usb/caiaq/caiaq-input.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22-rk3/sound/usb/caiaq/caiaq-input.c	2007-09-12 19:21:59.000000000 +0200
@@ -34,6 +34,8 @@
 static unsigned char keycode_ak1[] =  { KEY_C, KEY_B, KEY_A };
 static unsigned char keycode_rk2[] =  { KEY_1, KEY_2, KEY_3, KEY_4, 
 					KEY_5, KEY_6, KEY_7 };
+static unsigned char keycode_rk3[] =  { KEY_1, KEY_2, KEY_3, KEY_4, 
+					KEY_5, KEY_6, KEY_7, KEY_5, KEY_6 };
 
 #define DEG90  (range/2)
 #define DEG180 (range)
@@ -107,7 +109,7 @@
 
 
 static void snd_caiaq_input_read_analog(struct snd_usb_caiaqdev *dev, 
-					const char *buf, unsigned int len)
+					const unsigned char *buf, unsigned int len)
 {
 	switch(dev->input_dev->id.product) {
 	case USB_PID_RIGKONTROL2:
@@ -116,6 +118,12 @@
 		input_report_abs(dev->input_dev, ABS_Z, (buf[2] << 8) |buf[3]);
 		input_sync(dev->input_dev);
 		break;
+	case USB_PID_RIGKONTROL3:
+		input_report_abs(dev->input_dev, ABS_X, (buf[0] << 8) |buf[1]);
+		input_report_abs(dev->input_dev, ABS_Y, (buf[2] << 8) |buf[3]);
+		input_report_abs(dev->input_dev, ABS_Z, (buf[4] << 8) |buf[5]);
+		input_sync(dev->input_dev);
+		break;
 	}
 }
 
@@ -128,7 +136,7 @@
 	case USB_PID_AK1:
 		i = decode_erp(buf[0], buf[1]);
 		input_report_abs(dev->input_dev, ABS_X, i);
-		input_sync(dev->input_dev);	
+		input_sync(dev->input_dev);
 		break;
 	}
 }
@@ -204,6 +212,20 @@
 		input_set_abs_params(input, ABS_Z, 0, 4096, 0, 10);
 		snd_usb_caiaq_set_auto_msg(dev, 1, 10, 0);
 		break;
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
+		input->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+		input->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_Z);
+		input->keycode = keycode_rk3;
+		input->keycodesize = sizeof(char);
+		input->keycodemax = ARRAY_SIZE(keycode_rk3);
+		for (i=0; i<ARRAY_SIZE(keycode_rk3); i++)
+			set_bit(keycode_rk3[i], input->keybit);
+
+		input_set_abs_params(input, ABS_X, 0, 1024, 0, 10);
+		input_set_abs_params(input, ABS_Y, 0, 1024, 0, 10);
+		input_set_abs_params(input, ABS_Z, 0, 1024, 0, 10);
+		snd_usb_caiaq_set_auto_msg(dev, 1, 10, 0);
+		break;
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AK1):
 		input->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 		input->absbit[0] = BIT(ABS_X);
diff -Nur linux-2.6.22/sound/usb/Kconfig linux-2.6.22-rk3/sound/usb/Kconfig
--- linux-2.6.22/sound/usb/Kconfig	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22-rk3/sound/usb/Kconfig	2007-09-12 19:05:58.000000000 +0200
@@ -40,6 +40,7 @@
 	   namely:
 
 	    * Native Instruments RigKontrol2
+	    * Native Instruments RigKontrol3
 	    * Native Instruments Kore Controller
 	    * Native Instruments Audio Kontrol 1
 	    * Native Instruments Audio 8 DJ
@@ -55,6 +56,7 @@
 	  alpha dials and analog pedals on the following products:
 
 	   * Native Instruments RigKontrol2
+	   * Native Instruments RigKontrol3
 	   * Native Instruments Audio Kontrol 1
 
 endmenu

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--FCuugMFkClbJLl1L--
