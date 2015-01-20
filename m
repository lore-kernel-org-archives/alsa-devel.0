From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/7] ALSA: line6/toneport: Implement LED
	controls via LED class
Date: Tue, 20 Jan 2015 10:04:22 +0100
Message-ID: <1421744662-6497-8-git-send-email-tiwai@suse.de>
References: <1421744662-6497-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E1B7B2604FE
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 10:04:36 +0100 (CET)
In-Reply-To: <1421744662-6497-1-git-send-email-tiwai@suse.de>
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

Instead of non-standard sysfs, reimplement the LED controls on
TonePort as LED class devices.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/Kconfig    |   2 +
 sound/usb/line6/toneport.c | 163 +++++++++++++++++++++++++--------------------
 2 files changed, 91 insertions(+), 74 deletions(-)

diff --git a/sound/usb/line6/Kconfig b/sound/usb/line6/Kconfig
index af20947e0bda..f4585d378ef3 100644
--- a/sound/usb/line6/Kconfig
+++ b/sound/usb/line6/Kconfig
@@ -29,6 +29,8 @@ config SND_USB_PODHD
 config SND_USB_TONEPORT
 	tristate "TonePort GX, UX1 and UX2 USB support"
 	select SND_USB_LINE6
+	select NEW_LEDS
+	select LEDS_CLASS
 	help
 	  This is a driver for TonePort GX, UX1 and UX2 devices.
 
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 9a4f5403569e..9a769463f7bf 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -14,6 +14,7 @@
 #include <linux/usb.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/leds.h>
 #include <sound/core.h>
 #include <sound/control.h>
 
@@ -32,6 +33,15 @@ enum line6_device_type {
 	LINE6_TONEPORT_UX2,
 };
 
+struct usb_line6_toneport;
+
+struct toneport_led {
+	struct led_classdev dev;
+	char name[64];
+	struct usb_line6_toneport *toneport;
+	bool registered;
+};
+
 struct usb_line6_toneport {
 	/**
 		Generic Line 6 USB data.
@@ -62,6 +72,9 @@ struct usb_line6_toneport {
 		 Device type.
 	*/
 	enum line6_device_type type;
+
+	/* LED instances */
+	struct toneport_led leds[2];
 };
 
 static int toneport_send_cmd(struct usb_device *usbdev, int cmd1, int cmd2);
@@ -117,15 +130,6 @@ static struct line6_pcm_properties toneport_pcm_properties = {
 	.bytes_per_frame = 4
 };
 
-/*
-	For the led on Guitarport.
-	Brightness goes from 0x00 to 0x26. Set a value above this to have led
-	blink.
-	(void cmd_0x02(byte red, byte green)
-*/
-static int led_red = 0x00;
-static int led_green = 0x26;
-
 static const struct {
 	const char *name;
 	int code;
@@ -136,62 +140,6 @@ static const struct {
 	{"Inst & Mic", 0x0901}
 };
 
-static bool toneport_has_led(enum line6_device_type type)
-{
-	return
-	    (type == LINE6_GUITARPORT) ||
-	    (type == LINE6_TONEPORT_GX);
-	/* add your device here if you are missing support for the LEDs */
-}
-
-static void toneport_update_led(struct device *dev)
-{
-	struct usb_interface *interface = to_usb_interface(dev);
-	struct usb_line6_toneport *tp = usb_get_intfdata(interface);
-	struct usb_line6 *line6;
-
-	if (!tp)
-		return;
-
-	line6 = &tp->line6;
-	if (line6)
-		toneport_send_cmd(line6->usbdev, (led_red << 8) | 0x0002,
-				  led_green);
-}
-
-static ssize_t toneport_set_led_red(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	int retval;
-
-	retval = kstrtoint(buf, 10, &led_red);
-	if (retval)
-		return retval;
-
-	toneport_update_led(dev);
-	return count;
-}
-
-static ssize_t toneport_set_led_green(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t count)
-{
-	int retval;
-
-	retval = kstrtoint(buf, 10, &led_green);
-	if (retval)
-		return retval;
-
-	toneport_update_led(dev);
-	return count;
-}
-
-static DEVICE_ATTR(led_red, S_IWUSR | S_IRUGO, line6_nop_read,
-		   toneport_set_led_red);
-static DEVICE_ATTR(led_green, S_IWUSR | S_IRUGO, line6_nop_read,
-		   toneport_set_led_green);
-
 static int toneport_send_cmd(struct usb_device *usbdev, int cmd1, int cmd2)
 {
 	int ret;
@@ -330,6 +278,78 @@ static struct snd_kcontrol_new toneport_control_source = {
 };
 
 /*
+	For the led on Guitarport.
+	Brightness goes from 0x00 to 0x26. Set a value above this to have led
+	blink.
+	(void cmd_0x02(byte red, byte green)
+*/
+
+static bool toneport_has_led(enum line6_device_type type)
+{
+	return
+	    (type == LINE6_GUITARPORT) ||
+	    (type == LINE6_TONEPORT_GX);
+	/* add your device here if you are missing support for the LEDs */
+}
+
+static const char * const led_colors[2] = { "red", "green" };
+static const int led_init_vals[2] = { 0x00, 0x26 };
+
+static void toneport_update_led(struct usb_line6_toneport *toneport)
+{
+	toneport_send_cmd(toneport->line6.usbdev,
+			  (toneport->leds[0].dev.brightness << 8) | 0x0002,
+			  toneport->leds[1].dev.brightness);
+}
+
+static void toneport_led_brightness_set(struct led_classdev *led_cdev,
+					enum led_brightness brightness)
+{
+	struct toneport_led *leds =
+		container_of(led_cdev, struct toneport_led, dev);
+	toneport_update_led(leds->toneport);
+}
+
+static int toneport_init_leds(struct usb_line6_toneport *toneport)
+{
+	struct device *dev = &toneport->line6.usbdev->dev;
+	int i, err;
+
+	for (i = 0; i < 2; i++) {
+		struct toneport_led *led = &toneport->leds[i];
+		struct led_classdev *leddev = &led->dev;
+
+		led->toneport = toneport;
+		snprintf(led->name, sizeof(led->name), "%s::%s",
+			 dev_name(dev), led_colors[i]);
+		leddev->name = led->name;
+		leddev->brightness = led_init_vals[i];
+		leddev->max_brightness = 0x26;
+		leddev->brightness_set = toneport_led_brightness_set;
+		err = led_classdev_register(dev, leddev);
+		if (err)
+			return err;
+		led->registered = true;
+	}
+
+	return 0;
+}
+
+static void toneport_remove_leds(struct usb_line6_toneport *toneport)
+{
+	struct toneport_led *led;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		led = &toneport->leds[i];
+		if (!led->registered)
+			break;
+		led_classdev_unregister(&led->dev);
+		led->registered = false;
+	}
+}
+
+/*
 	Setup Toneport device.
 */
 static void toneport_setup(struct usb_line6_toneport *toneport)
@@ -359,7 +379,7 @@ static void toneport_setup(struct usb_line6_toneport *toneport)
 	}
 
 	if (toneport_has_led(toneport->type))
-		toneport_update_led(&usbdev->dev);
+		toneport_update_led(toneport);
 
 	mod_timer(&toneport->timer, jiffies + TONEPORT_PCM_DELAY * HZ);
 }
@@ -374,10 +394,8 @@ static void line6_toneport_disconnect(struct usb_interface *interface)
 	toneport = usb_get_intfdata(interface);
 	del_timer_sync(&toneport->timer);
 
-	if (toneport_has_led(toneport->type)) {
-		device_remove_file(&interface->dev, &dev_attr_led_red);
-		device_remove_file(&interface->dev, &dev_attr_led_green);
-	}
+	if (toneport_has_led(toneport->type))
+		toneport_remove_leds(toneport);
 }
 
 
@@ -428,10 +446,7 @@ static int toneport_init(struct usb_interface *interface,
 	line6_read_data(line6, 0x80c2, &toneport->firmware_version, 1);
 
 	if (toneport_has_led(toneport->type)) {
-		err = device_create_file(&interface->dev, &dev_attr_led_red);
-		if (err < 0)
-			return err;
-		err = device_create_file(&interface->dev, &dev_attr_led_green);
+		err = toneport_init_leds(toneport);
 		if (err < 0)
 			return err;
 	}
-- 
2.2.1
