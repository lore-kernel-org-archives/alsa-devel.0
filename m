From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 7/7] ALSA: usbusx2y: constify usb_device_id.
Date: Sun,  6 Aug 2017 12:18:59 +0530
Message-ID: <1502002139-10787-8-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/usb/usx2y/usbusx2y.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 91e0e2a..4569c0e 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -313,7 +313,7 @@ static void usX2Y_unlinkSeq(struct snd_usX2Y_AsyncSeq *S)
 }
 
 
-static struct usb_device_id snd_usX2Y_usb_id_table[] = {
+static const struct usb_device_id snd_usX2Y_usb_id_table[] = {
 	{
 		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
 		.idVendor =	0x1604,
-- 
2.7.4
