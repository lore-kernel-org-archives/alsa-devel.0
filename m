From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: 6fire: use NULL instead of 0 for pointer
	assignment
Date: Sat, 16 Jun 2012 16:58:36 +0200
Message-ID: <1339858716-31813-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id B2F8C24662
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2012 16:58:41 +0200 (CEST)
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
Cc: tiwai@suse.de, Torsten Schenk <torsten.schenk@zoho.com>, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Torsten Schenk <torsten.schenk@zoho.com>
---
 sound/usb/6fire/firmware.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
index 6f9715a..56ad923 100644
--- a/sound/usb/6fire/firmware.c
+++ b/sound/usb/6fire/firmware.c
@@ -209,7 +209,7 @@ static int usb6fire_fw_ezusb_upload(
 	int ret;
 	u8 data;
 	struct usb_device *device = interface_to_usbdev(intf);
-	const struct firmware *fw = 0;
+	const struct firmware *fw = NULL;
 	struct ihex_record *rec = kmalloc(sizeof(struct ihex_record),
 			GFP_KERNEL);
 
-- 
1.7.10.2
