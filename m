From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/7] ALSA: line6/toneport: Fix wrong argument
	for toneport_has_led()
Date: Tue, 20 Jan 2015 10:04:21 +0100
Message-ID: <1421744662-6497-7-git-send-email-tiwai@suse.de>
References: <1421744662-6497-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E24C9260505
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/toneport.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index fb6d5e1e2ade..9a4f5403569e 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -370,13 +370,11 @@ static void toneport_setup(struct usb_line6_toneport *toneport)
 static void line6_toneport_disconnect(struct usb_interface *interface)
 {
 	struct usb_line6_toneport *toneport;
-	u16 idProduct;
 
 	toneport = usb_get_intfdata(interface);
 	del_timer_sync(&toneport->timer);
-	idProduct = le16_to_cpu(toneport->line6.usbdev->descriptor.idProduct);
 
-	if (toneport_has_led(idProduct)) {
+	if (toneport_has_led(toneport->type)) {
 		device_remove_file(&interface->dev, &dev_attr_led_red);
 		device_remove_file(&interface->dev, &dev_attr_led_green);
 	}
-- 
2.2.1
