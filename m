From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: snd_usb_caiaq: reparent sound device
Date: Thu,  2 Jul 2009 10:46:35 +0200
Message-ID: <1246524395-10285-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E9EE245A8
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 10:47:57 +0200 (CEST)
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

The sound device instance needs to be a child of the USB interface, not
the USB device. Newer udev versions pay attention to that.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Reported-by: Lennart Poettering <lennart@poettering.net>
---
 sound/usb/caiaq/device.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 0e5db71..de38108 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -35,7 +35,7 @@
 #include "input.h"
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.17");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.18");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
@@ -349,7 +349,9 @@ static void __devinit setup_card(struct snd_usb_caiaqdev *dev)
 		log("Unable to set up control system (ret=%d)\n", ret);
 }
 
-static int create_card(struct usb_device* usb_dev, struct snd_card **cardp)
+static int create_card(struct usb_device *usb_dev,
+		       struct usb_interface *intf,
+		       struct snd_card **cardp)
 {
 	int devnum;
 	int err;
@@ -374,7 +376,7 @@ static int create_card(struct usb_device* usb_dev, struct snd_card **cardp)
 	dev->chip.usb_id = USB_ID(le16_to_cpu(usb_dev->descriptor.idVendor),
 				  le16_to_cpu(usb_dev->descriptor.idProduct));
 	spin_lock_init(&dev->spinlock);
-	snd_card_set_dev(card, &usb_dev->dev);
+	snd_card_set_dev(card, &intf->dev);
 
 	*cardp = card;
 	return 0;
@@ -461,7 +463,7 @@ static int __devinit snd_probe(struct usb_interface *intf,
 	struct snd_card *card;
 	struct usb_device *device = interface_to_usbdev(intf);
 
-	ret = create_card(device, &card);
+	ret = create_card(device, intf, &card);
 
 	if (ret < 0)
 		return ret;
-- 
1.6.3.1
