From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/7] ALSA: line6: Yet more cleanup of
	superfluous NULL checks
Date: Tue, 20 Jan 2015 10:04:16 +0100
Message-ID: <1421744662-6497-2-git-send-email-tiwai@suse.de>
References: <1421744662-6497-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C312A2604BB
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

... in line6_disconnect() as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 93cd4daa56bc..e8d51381ffdb 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -579,18 +579,9 @@ EXPORT_SYMBOL_GPL(line6_probe);
 */
 void line6_disconnect(struct usb_interface *interface)
 {
-	struct usb_line6 *line6;
-	struct usb_device *usbdev;
-	int interface_number;
-
-	if (interface == NULL)
-		return;
-	usbdev = interface_to_usbdev(interface);
-	if (usbdev == NULL)
-		return;
+	struct usb_line6 *line6 = usb_get_intfdata(interface);
+	struct usb_device *usbdev = interface_to_usbdev(interface);
 
-	interface_number = interface->cur_altsetting->desc.bInterfaceNumber;
-	line6 = usb_get_intfdata(interface);
 	if (!line6)
 		return;
 
-- 
2.2.1
