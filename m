From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/7] ALSA: 6fire: constify usb_device_id.
Date: Sun,  6 Aug 2017 12:18:53 +0530
Message-ID: <1502002139-10787-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502002139-10787-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D16B8266834
 for <alsa-devel@alsa-project.org>; Sun,  6 Aug 2017 08:49:15 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id y192so5774104pgd.1
 for <alsa-devel@alsa-project.org>; Sat, 05 Aug 2017 23:49:15 -0700 (PDT)
In-Reply-To: <1502002139-10787-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, zonque@gmail.com, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/usb/6fire/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index dcddfc3..bc2a24f 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -198,7 +198,7 @@ static void usb6fire_chip_disconnect(struct usb_interface *intf)
 	}
 }
 
-static struct usb_device_id device_table[] = {
+static const struct usb_device_id device_table[] = {
 	{
 		.match_flags = USB_DEVICE_ID_MATCH_DEVICE,
 		.idVendor = 0x0ccd,
-- 
2.7.4
