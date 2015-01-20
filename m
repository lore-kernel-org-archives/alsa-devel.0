From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 1/3] ALSA: line6: Remove superfluous NULL checks
Date: Tue, 20 Jan 2015 02:20:48 -0600
Message-ID: <1421742050-13299-2-git-send-email-chris@rorvick.com>
References: <1421742050-13299-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A0D9260536
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 09:21:07 +0100 (CET)
Received: by mail-ig0-f174.google.com with SMTP id b16so9370332igk.1
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 00:21:06 -0800 (PST)
In-Reply-To: <1421742050-13299-1-git-send-email-chris@rorvick.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/driver.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index a3da18b..3757b0c 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -456,21 +456,11 @@ int line6_probe(struct usb_interface *interface,
 		const struct line6_properties *properties,
 		int (*private_init)(struct usb_interface *, struct usb_line6 *))
 {
-	struct usb_device *usbdev;
+	struct usb_device *usbdev = interface_to_usbdev(interface);
 	struct snd_card *card;
 	int interface_number;
 	int ret;
 
-	if (!interface) {
-		ret = -ENODEV;
-		goto err_put;
-	}
-	usbdev = interface_to_usbdev(interface);
-	if (!usbdev) {
-		ret = -ENODEV;
-		goto err_put;
-	}
-
 	/* we don't handle multiple configurations */
 	if (usbdev->descriptor.bNumConfigurations != 1) {
 		ret = -ENODEV;
-- 
2.1.0
