From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH] ASoC: Add delay quirk for H650e/Jabra 550a USB
	headsets
Date: Tue, 22 Aug 2017 08:33:53 +0200
Message-ID: <20170822063353.3612-1-joakim.tjernlund@infinera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 72FE1266D86
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 08:34:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel @ alsa-project . org" <alsa-devel@alsa-project.org>
Cc: Joakim Tjernlund <joakim.tjernlund@infinera.com>
List-Id: alsa-devel@alsa-project.org

These headsets reports a lot of: cannot set freq 44100 to ep 0x81
and need a small delay between sample rate settings, just like
Zoom R16/24. Add both headsets to the Zoom R16/24 quirk for
a 1 ms delay between control msgs.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 sound/usb/quirks.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index eb4b9f7a571e..6f395150243f 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1308,10 +1308,13 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
-	/* Zoom R16/24 needs a tiny delay here, otherwise requests like
-	 * get/set frequency return as failed despite actually succeeding.
+	/* Zoom R16/24, Logitech H650e, Jabra 550a needs a tiny delay here,
+	 * otherwise requests like get/set frequency return as failed despite
+	 * actually succeeding.
 	 */
-	if (chip->usb_id == USB_ID(0x1686, 0x00dd) &&
+	if ((chip->usb_id == USB_ID(0x1686, 0x00dd) ||
+	     chip->usb_id == USB_ID(0x046d, 0x0a46) ||
+	     chip->usb_id == USB_ID(0x0b0e, 0x0349)) &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(1);
 }
-- 
2.13.5
