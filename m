From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/17] ALSA: line6: Remove CHECK_RETURN macro
Date: Mon, 19 Jan 2015 16:54:47 +0100
Message-ID: <1421682891-11594-14-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC852610A1
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

Such a macro doesn't improve readability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.h   |  7 -------
 sound/usb/line6/pod.c      | 12 +++++++++---
 sound/usb/line6/toneport.c | 10 ++++++----
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 8e4d946a130c..f484aa09840b 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -48,13 +48,6 @@
 
 #define LINE6_CHANNEL_MASK 0x0f
 
-#define CHECK_RETURN(x)		\
-do {				\
-	err = x;		\
-	if (err < 0)		\
-		return err;	\
-} while (0)
-
 #define CHECK_STARTUP_PROGRESS(x, n)	\
 do {					\
 	if ((x) >= (n))			\
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 6b30deb6b157..6f4b09982589 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -429,9 +429,15 @@ static int pod_create_files2(struct device *dev)
 {
 	int err;
 
-	CHECK_RETURN(device_create_file(dev, &dev_attr_device_id));
-	CHECK_RETURN(device_create_file(dev, &dev_attr_firmware_version));
-	CHECK_RETURN(device_create_file(dev, &dev_attr_serial_number));
+	err = device_create_file(dev, &dev_attr_device_id);
+	if (err < 0)
+		return err;
+	err = device_create_file(dev, &dev_attr_firmware_version);
+	if (err < 0)
+		return err;
+	err = device_create_file(dev, &dev_attr_serial_number);
+	if (err < 0)
+		return err;
 	return 0;
 }
 
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 3097a75a9bec..24544b7ab476 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -431,10 +431,12 @@ static int toneport_init(struct usb_interface *interface,
 	line6_read_data(line6, 0x80c2, &toneport->firmware_version, 1);
 
 	if (toneport_has_led(toneport->type)) {
-		CHECK_RETURN(device_create_file
-			     (&interface->dev, &dev_attr_led_red));
-		CHECK_RETURN(device_create_file
-			     (&interface->dev, &dev_attr_led_green));
+		err = device_create_file(&interface->dev, &dev_attr_led_red);
+		if (err < 0)
+			return err;
+		err = device_create_file(&interface->dev, &dev_attr_led_green);
+		if (err < 0)
+			return err;
 	}
 
 	toneport_setup(toneport);
-- 
2.2.1
