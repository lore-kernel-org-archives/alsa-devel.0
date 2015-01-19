From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/17] ALSA: line6: Drop usb_device sysfs
	symlink
Date: Mon, 19 Jan 2015 16:54:40 +0100
Message-ID: <1421682891-11594-7-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F23A261483
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

It's non-standard and rather superfluous.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 149c393c7302..23d504f4b6bc 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -611,11 +611,6 @@ int line6_probe(struct usb_interface *interface,
 	if (ret < 0)
 		goto err_destruct;
 
-	ret = sysfs_create_link(&interface->dev.kobj, &usbdev->dev.kobj,
-				"usb_device");
-	if (ret < 0)
-		goto err_destruct;
-
 	/* creation of additional special files should go here */
 
 	dev_info(&interface->dev, "Line6 %s now attached\n",
@@ -649,10 +644,6 @@ void line6_disconnect(struct usb_interface *interface)
 	if (usbdev == NULL)
 		return;
 
-	/* removal of additional special files should go here */
-
-	sysfs_remove_link(&interface->dev.kobj, "usb_device");
-
 	interface_number = interface->cur_altsetting->desc.bInterfaceNumber;
 	line6 = usb_get_intfdata(interface);
 
-- 
2.2.1
