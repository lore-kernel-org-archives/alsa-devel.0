From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH 11/15] ALSA: line6: Only free buffer if it is
	set.
Date: Thu, 11 Aug 2016 21:02:23 +0200
Message-ID: <1470942147-19848-12-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A127267759
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 21:04:08 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id o80so966900wme.0
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 12:04:08 -0700 (PDT)
In-Reply-To: <1470942147-19848-1-git-send-email-dev@andree.sk>
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
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

This makes the resource freeing not dependent on the existence of private data
from the podhd module, which may be gone during the call.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 344465f..142e0e3 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -479,13 +479,14 @@ static void line6_destruct(struct snd_card *card)
 	struct usb_device *usbdev = line6->usbdev;
 
 	/* free buffer memory first: */
-	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI)
+	if (line6->buffer_message)
 		kfree(line6->buffer_message);
 
 	kfree(line6->buffer_listen);
 
 	/* then free URBs: */
 	usb_free_urb(line6->urb_listen);
+	line6->urb_listen = NULL;
 
 	/* decrement reference counters: */
 	usb_put_dev(usbdev);
-- 
1.9.1
