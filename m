From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] usb: audio-v2: Correct the comment for struct
	uac_clock_selector_descriptor
Date: Fri,  6 Apr 2018 15:31:49 +0200
Message-ID: <20180406133149.10349-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CB98526723C
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 15:31:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The comment in UAC2 clock selector descriptor definition mentions the
bAssocTerminal after baCSourceID[], but it doesn't exist in the actual
definition.  Let's correct it.

Fixes: 5dd360ebd832 ("include/linux/usb/audio-v2.h: add more UAC2 details")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/linux/usb/audio-v2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
index aaafecf073ff..49699255cfd3 100644
--- a/include/linux/usb/audio-v2.h
+++ b/include/linux/usb/audio-v2.h
@@ -94,7 +94,7 @@ struct uac_clock_selector_descriptor {
 	__u8 bClockID;
 	__u8 bNrInPins;
 	__u8 baCSourceID[];
-	/* bmControls, bAssocTerminal and iClockSource omitted */
+	/* bmControls and iClockSource omitted */
 } __attribute__((packed));
 
 /* 4.7.2.3 Clock Multiplier Descriptor */
-- 
2.16.3
