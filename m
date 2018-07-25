From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/12] ALSA: usb-audio: Fix multiple
	definitions in AU0828_DEVICE() macro
Date: Wed, 25 Jul 2018 23:00:46 +0200
Message-ID: <20180725210057.18017-2-tiwai@suse.de>
References: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 85AEB26776E
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:04 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 62109B064
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
In-Reply-To: <20180725210057.18017-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

AU0828_DEVICE() macro in quirks-table.h uses USB_DEVICE_VENDOR_SPEC()
for expanding idVendor and idProduct fields.  However, the latter
macro adds also match_flags and bInterfaceClass, which are different
from the values AU0828_DEVICE() macro sets after that.

For fixing them, just expand idVendor and idProduct fields manually in
AU0828_DEVICE().

This fixes sparse warnings like:
  sound/usb/quirks-table.h:2892:1: warning: Initializer entry defined twice

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks-table.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 8aac48f9c322..08aa78007020 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2875,7 +2875,8 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  */
 
 #define AU0828_DEVICE(vid, pid, vname, pname) { \
-	USB_DEVICE_VENDOR_SPEC(vid, pid), \
+	.idVendor = vid, \
+	.idProduct = pid, \
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE | \
 		       USB_DEVICE_ID_MATCH_INT_CLASS | \
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS, \
-- 
2.18.0
