From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 2/3] ALSA: line6: Pass toneport pointer to toneport_has_led()
Date: Sat,  7 Feb 2015 10:43:18 -0600
Message-ID: <1423327399-12619-3-git-send-email-chris@rorvick.com>
References: <1423327399-12619-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423327399-12619-1-git-send-email-chris@rorvick.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

It is unlikely this function would ever be used in a context without a
pointer to a `struct usb_line6_toneport', so grab the device type from
it rather than having the caller do it.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/toneport.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 6dd6d4f..2420d2f 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -278,12 +278,17 @@ static struct snd_kcontrol_new toneport_control_source = {
 	(void cmd_0x02(byte red, byte green)
 */
 
-static bool toneport_has_led(enum line6_device_type type)
+static bool toneport_has_led(struct usb_line6_toneport *toneport)
 {
-	return
-	    (type == LINE6_GUITARPORT) ||
-	    (type == LINE6_TONEPORT_GX);
+	switch (toneport->type) {
+	case LINE6_GUITARPORT:
+	case LINE6_TONEPORT_GX:
 	/* add your device here if you are missing support for the LEDs */
+		return true;
+
+	default:
+		return false;
+	}
 }
 
 static const char * const led_colors[2] = { "red", "green" };
@@ -379,7 +384,7 @@ static void toneport_setup(struct usb_line6_toneport *toneport)
 				  toneport_source_info[toneport->source].code,
 				  0x0000);
 
-	if (toneport_has_led(toneport->type))
+	if (toneport_has_led(toneport))
 		toneport_update_led(toneport);
 
 	mod_timer(&toneport->timer, jiffies + TONEPORT_PCM_DELAY * HZ);
@@ -395,7 +400,7 @@ static void line6_toneport_disconnect(struct usb_line6 *line6)
 
 	del_timer_sync(&toneport->timer);
 
-	if (toneport_has_led(toneport->type))
+	if (toneport_has_led(toneport))
 		toneport_remove_leds(toneport);
 }
 
@@ -440,7 +445,7 @@ static int toneport_init(struct usb_line6 *line6,
 	line6_read_serial_number(line6, &toneport->serial_number);
 	line6_read_data(line6, 0x80c2, &toneport->firmware_version, 1);
 
-	if (toneport_has_led(toneport->type)) {
+	if (toneport_has_led(toneport)) {
 		err = toneport_init_leds(toneport);
 		if (err < 0)
 			return err;
-- 
2.1.0
