From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] add support for Kore controller 2
Date: Sat, 24 Nov 2007 14:18:01 +0100
Message-ID: <20071124131801.GA30063@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id F23522479B
	for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2007 14:18:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 8F7DC7F4018
	for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2007 14:18:05 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EFsTMw8vMXPC for <alsa-devel@alsa-project.org>;
	Sat, 24 Nov 2007 14:18:01 +0100 (CET)
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


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Added support for Native Instrument's Kore controller 2. This device has
no audio but MIDI, input devices and ALSA controllers only.

Signed-off-by: Daniel Mack <daniel@caiaq.de>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-caiaq-1.3.1.diff"

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index ccbf72e..9351b8a 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -42,6 +42,7 @@ config SND_USB_CAIAQ
 	    * Native Instruments RigKontrol2
 	    * Native Instruments RigKontrol3
 	    * Native Instruments Kore Controller
+	    * Native Instruments Kore Controller 2
 	    * Native Instruments Audio Kontrol 1
 	    * Native Instruments Audio 8 DJ
 
@@ -59,6 +60,7 @@ config SND_USB_CAIAQ_INPUT
 	   * Native Instruments RigKontrol2
 	   * Native Instruments RigKontrol3
 	   * Native Instruments Kore Controller
+	   * Native Instruments Kore Controller 2
 	   * Native Instruments Audio Kontrol 1
 
 endmenu
diff --git a/sound/usb/caiaq/caiaq-control.c b/sound/usb/caiaq/caiaq-control.c
index 14e8e32..7d25f4b 100644
--- a/sound/usb/caiaq/caiaq-control.c
+++ b/sound/usb/caiaq/caiaq-control.c
@@ -288,6 +288,7 @@ int __devinit snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
 		break;
 
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER2):
 		for (i = 0; i < ARRAY_SIZE(kore_controller); i++) {
 			struct caiaq_controller *c = kore_controller + i;
 			kcontrol_template.name = c->name;
diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index dc2e7f7..48c6bed 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -43,11 +43,12 @@
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.0");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.1");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
 			 "{Native Instruments, Kore Controller},"
+			 "{Native Instruments, Kore Controller 2},"
 			 "{Native Instruments, Audio Kontrol 1}"
 			 "{Native Instruments, Audio 8 DJ}}");
 
@@ -96,6 +97,11 @@ static struct usb_device_id snd_usb_id_table[] = {
 		.idProduct =	USB_PID_KORECONTROLLER
 	},
 	{
+		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =	USB_VID_NATIVEINSTRUMENTS,
+		.idProduct =	USB_PID_KORECONTROLLER2
+	},
+	{
 		.match_flags =  USB_DEVICE_ID_MATCH_DEVICE,
 		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
 		.idProduct =    USB_PID_AK1
@@ -291,13 +297,21 @@ static void setup_card(struct snd_usb_caiaqdev *dev)
 		break;
 	}
 	
-	ret = snd_usb_caiaq_audio_init(dev);
-	if (ret < 0)
-		log("Unable to set up audio system (ret=%d)\n", ret);
+	if (dev->spec.num_analog_audio_out +
+	    dev->spec.num_analog_audio_in +
+	    dev->spec.num_digital_audio_out +
+	    dev->spec.num_digital_audio_in > 0) {
+		ret = snd_usb_caiaq_audio_init(dev);
+		if (ret < 0)
+			log("Unable to set up audio system (ret=%d)\n", ret);
+	}
 	
-	ret = snd_usb_caiaq_midi_init(dev);
-	if (ret < 0)
-		log("Unable to set up MIDI system (ret=%d)\n", ret);
+	if (dev->spec.num_midi_in +
+	    dev->spec.num_midi_out > 0) {
+		ret = snd_usb_caiaq_midi_init(dev);
+		if (ret < 0)
+			log("Unable to set up MIDI system (ret=%d)\n", ret);
+	}
 
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
 	ret = snd_usb_caiaq_input_init(dev);
diff --git a/sound/usb/caiaq/caiaq-device.h b/sound/usb/caiaq/caiaq-device.h
index 310b10e..96a4913 100644
--- a/sound/usb/caiaq/caiaq-device.h
+++ b/sound/usb/caiaq/caiaq-device.h
@@ -8,6 +8,7 @@
 #define USB_PID_RIGKONTROL2	0x1969
 #define USB_PID_RIGKONTROL3	0x1940
 #define USB_PID_KORECONTROLLER	0x4711
+#define USB_PID_KORECONTROLLER2	0x4712
 #define USB_PID_AK1		0x0815
 #define USB_PID_AUDIO8DJ	0x1978
 
diff --git a/sound/usb/caiaq/caiaq-input.c b/sound/usb/caiaq/caiaq-input.c
index ded45e5..e6c410a 100644
--- a/sound/usb/caiaq/caiaq-input.c
+++ b/sound/usb/caiaq/caiaq-input.c
@@ -162,6 +162,7 @@ static void snd_caiaq_input_read_analog(struct snd_usb_caiaqdev *dev,
 		input_sync(input_dev);
 		break;
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER2):
 		input_report_abs(input_dev, ABS_X, (buf[0] << 8) | buf[1]);
 		input_report_abs(input_dev, ABS_Y, (buf[2] << 8) | buf[3]);
 		input_report_abs(input_dev, ABS_Z, (buf[4] << 8) | buf[5]);
@@ -183,6 +184,7 @@ static void snd_caiaq_input_read_erp(struct snd_usb_caiaqdev *dev,
 		input_sync(input_dev);
 		break;
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER2):
 		i = decode_erp(buf[7], buf[5]);
 		input_report_abs(input_dev, ABS_HAT0X, i);
 		i = decode_erp(buf[12], buf[14]);
@@ -223,7 +225,9 @@ static void snd_caiaq_input_read_io(struct snd_usb_caiaqdev *dev,
 				 buf[i / 8] & (1 << (i % 8)));
 
 	if (dev->chip.usb_id ==
-	    USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER))
+		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER) ||
+	    dev->chip.usb_id ==
+		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER2))
 		input_report_abs(dev->input_dev, ABS_MISC, 255 - buf[4]);
 
 	input_sync(input_dev);
@@ -302,6 +306,7 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *dev)
 		snd_usb_caiaq_set_auto_msg(dev, 1, 0, 5);
 		break;
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER2):
 		input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 		input->absbit[0] = BIT_MASK(ABS_HAT0X) | BIT_MASK(ABS_HAT0Y) |
 				   BIT_MASK(ABS_HAT1X) | BIT_MASK(ABS_HAT1Y) |

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Nq2Wo0NMKNjxTN9z--
