From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/7] ALSA: bcd2000: constify usb_device_id.
Date: Sun,  6 Aug 2017 12:18:54 +0530
Message-ID: <1502002139-10787-3-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/usb/bcd2000/bcd2000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index 2ff9d57..7371e5b 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -29,7 +29,7 @@
 #define PREFIX "snd-bcd2000: "
 #define BUFSIZE 64
 
-static struct usb_device_id id_table[] = {
+static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x1397, 0x00bd) },
 	{ },
 };
-- 
2.7.4
