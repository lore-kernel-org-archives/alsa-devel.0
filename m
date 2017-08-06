From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/7] ALSA: snd-usb-caiaq: constify
	usb_device_id.
Date: Sun,  6 Aug 2017 12:18:55 +0530
Message-ID: <1502002139-10787-4-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502002139-10787-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id D940926684C
 for <alsa-devel@alsa-project.org>; Sun,  6 Aug 2017 08:49:21 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id t86so5949177pfe.1
 for <alsa-devel@alsa-project.org>; Sat, 05 Aug 2017 23:49:20 -0700 (PDT)
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
 sound/usb/caiaq/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index b871ba4..0fb6b1b7 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -81,7 +81,7 @@ enum {
 	DEPTH_32	= 3
 };
 
-static struct usb_device_id snd_usb_id_table[] = {
+static const struct usb_device_id snd_usb_id_table[] = {
 	{
 		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
 		.idVendor =	USB_VID_NATIVEINSTRUMENTS,
-- 
2.7.4
