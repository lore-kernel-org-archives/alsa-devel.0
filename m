From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: line6: Minor tidy up in line6_probe()
Date: Mon, 26 Jan 2015 13:48:43 +0100
Message-ID: <1422276523-14336-4-git-send-email-tiwai@suse.de>
References: <1422276523-14336-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E35EA260558
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 13:48:44 +0100 (CET)
In-Reply-To: <1422276523-14336-1-git-send-email-tiwai@suse.de>
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

Move the check of multi configurations before snd_card_new() as a
short path, and reduce superfluous pointer references.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index c696f9773cbb..a0436993a167 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -495,6 +495,10 @@ int line6_probe(struct usb_interface *interface,
 	if (WARN_ON(data_size < sizeof(*line6)))
 		return -EINVAL;
 
+	/* we don't handle multiple configurations */
+	if (usbdev->descriptor.bNumConfigurations != 1)
+		return -ENODEV;
+
 	ret = snd_card_new(&interface->dev,
 			   SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
 			   THIS_MODULE, data_size, &card);
@@ -508,10 +512,10 @@ int line6_probe(struct usb_interface *interface,
 	line6->usbdev = usbdev;
 	line6->ifcdev = &interface->dev;
 
-	strcpy(card->id, line6->properties->id);
+	strcpy(card->id, properties->id);
 	strcpy(card->driver, DRIVER_NAME);
-	strcpy(card->shortname, line6->properties->name);
-	sprintf(card->longname, "Line 6 %s at USB %s", line6->properties->name,
+	strcpy(card->shortname, properties->name);
+	sprintf(card->longname, "Line 6 %s at USB %s", properties->name,
 		dev_name(line6->ifcdev));
 	card->private_free = line6_destruct;
 
@@ -520,12 +524,6 @@ int line6_probe(struct usb_interface *interface,
 	/* increment reference counters: */
 	usb_get_dev(usbdev);
 
-	/* we don't handle multiple configurations */
-	if (usbdev->descriptor.bNumConfigurations != 1) {
-		ret = -ENODEV;
-		goto error;
-	}
-
 	/* initialize device info: */
 	dev_info(&interface->dev, "Line 6 %s found\n", properties->name);
 
@@ -533,7 +531,7 @@ int line6_probe(struct usb_interface *interface,
 	interface_number = interface->cur_altsetting->desc.bInterfaceNumber;
 
 	ret = usb_set_interface(usbdev, interface_number,
-			properties->altsetting);
+				properties->altsetting);
 	if (ret < 0) {
 		dev_err(&interface->dev, "set_interface failed\n");
 		goto error;
@@ -555,7 +553,7 @@ int line6_probe(struct usb_interface *interface,
 	/* creation of additional special files should go here */
 
 	dev_info(&interface->dev, "Line 6 %s now attached\n",
-		 line6->properties->name);
+		 properties->name);
 
 	return 0;
 
-- 
2.2.2
