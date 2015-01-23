From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/16] ALSA: line6: Fix memory leak at probe
	error path
Date: Fri, 23 Jan 2015 18:13:09 +0100
Message-ID: <1422033203-23254-3-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 92B042654EB
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:41 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
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

Fix memory leak at probe error path by rearranging the call order in
line6_destruct() so that the common destructor is always called.
Also this simplifies the error path to a single goto label.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 53 ++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index b783c0788e45..2eed6fbd99c4 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -507,10 +507,32 @@ int line6_probe(struct usb_interface *interface,
 	int interface_number;
 	int ret;
 
+	ret = snd_card_new(line6->ifcdev,
+			   SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+			   THIS_MODULE, 0, &card);
+	if (ret < 0) {
+		kfree(line6);
+		return ret;
+	}
+
+	line6->card = card;
+	strcpy(card->id, line6->properties->id);
+	strcpy(card->driver, DRIVER_NAME);
+	strcpy(card->shortname, line6->properties->name);
+	sprintf(card->longname, "Line 6 %s at USB %s", line6->properties->name,
+		dev_name(line6->ifcdev));
+	card->private_data = line6;
+	card->private_free = line6_destruct;
+
+	usb_set_intfdata(interface, line6);
+
+	/* increment reference counters: */
+	usb_get_dev(usbdev);
+
 	/* we don't handle multiple configurations */
 	if (usbdev->descriptor.bNumConfigurations != 1) {
 		ret = -ENODEV;
-		goto err_put;
+		goto error;
 	}
 
 	/* initialize device info: */
@@ -523,7 +545,7 @@ int line6_probe(struct usb_interface *interface,
 			properties->altsetting);
 	if (ret < 0) {
 		dev_err(&interface->dev, "set_interface failed\n");
-		goto err_put;
+		goto error;
 	}
 
 	/* store basic data: */
@@ -533,36 +555,16 @@ int line6_probe(struct usb_interface *interface,
 
 	line6_get_interval(line6);
 
-	ret = snd_card_new(line6->ifcdev,
-			   SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
-			   THIS_MODULE, 0, &card);
-	if (ret < 0)
-		goto err_put;
-
-	line6->card = card;
-	strcpy(card->id, line6->properties->id);
-	strcpy(card->driver, DRIVER_NAME);
-	strcpy(card->shortname, line6->properties->name);
-	sprintf(card->longname, "Line 6 %s at USB %s", line6->properties->name,
-		dev_name(line6->ifcdev));
-	card->private_data = line6;
-	card->private_free = line6_destruct;
-
-	usb_set_intfdata(interface, line6);
-
-	/* increment reference counters: */
-	usb_get_dev(usbdev);
-
 	if (properties->capabilities & LINE6_CAP_CONTROL) {
 		ret = line6_init_cap_control(line6);
 		if (ret < 0)
-			goto err_destruct;
+			goto error;
 	}
 
 	/* initialize device data based on device: */
 	ret = private_init(interface, line6);
 	if (ret < 0)
-		goto err_destruct;
+		goto error;
 
 	/* creation of additional special files should go here */
 
@@ -571,11 +573,10 @@ int line6_probe(struct usb_interface *interface,
 
 	return 0;
 
- err_destruct:
+ error:
 	if (line6->disconnect)
 		line6->disconnect(interface);
 	snd_card_free(card);
- err_put:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(line6_probe);
-- 
2.2.2
