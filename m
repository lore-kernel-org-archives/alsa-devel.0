From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 2/4] ALSA: line6: Pass toneport pointer to
	toneport_has_led()
Date: Fri,  6 Feb 2015 08:51:10 -0600
Message-ID: <1423234272-7348-3-git-send-email-chris@rorvick.com>
References: <1423234272-7348-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
 [209.85.160.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 0496C2605EC
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 15:51:31 +0100 (CET)
Received: by mail-yk0-f170.google.com with SMTP id q9so6088631ykb.1
 for <alsa-devel@alsa-project.org>; Fri, 06 Feb 2015 06:51:30 -0800 (PST)
In-Reply-To: <1423234272-7348-1-git-send-email-chris@rorvick.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org, Chris Rorvick <chris@rorvick.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

It is unlikely this function would ever be used in a context without a
pointer to a `struct usb_line6_toneport', so grab the device type from
it rather than having the caller do it.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/toneport.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index de56180a..b2c0b2c 100644
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
+		return 1;
+
+	default:
+		return 0;
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
