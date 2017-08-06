From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 5/7] ALSA: ua101: constify usb_device_id.
Date: Sun,  6 Aug 2017 12:18:57 +0530
Message-ID: <1502002139-10787-6-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502002139-10787-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502002139-10787-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, zonque@gmail.com, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/usb/misc/ua101.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index c19a5dd..b05cd38 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -1366,7 +1366,7 @@ static void ua101_disconnect(struct usb_interface *interface)
 	mutex_unlock(&devices_mutex);
 }
 
-static struct usb_device_id ua101_ids[] = {
+static const struct usb_device_id ua101_ids[] = {
 	{ USB_DEVICE(0x0582, 0x0044) }, /* UA-1000 high speed */
 	{ USB_DEVICE(0x0582, 0x007d) }, /* UA-101 high speed */
 	{ USB_DEVICE(0x0582, 0x008d) }, /* UA-101 full speed */
-- 
2.7.4
