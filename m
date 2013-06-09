From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: usx2y: remove some old dead code
Date: Sun, 9 Jun 2013 16:14:25 +0300
Message-ID: <20130609131425.GB1442@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id E610B261AE0
 for <alsa-devel@alsa-project.org>; Sun,  9 Jun 2013 15:14:42 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

USB_QUEUE_BULK isn't defined any more.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index b376532..4967fe9 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -695,9 +695,6 @@ static int usX2Y_rate_set(struct usX2Ydev *usX2Y, int rate)
 			((char*)(usbdata + i))[1] = ra[i].c2;
 			usb_fill_bulk_urb(us->urb[i], usX2Y->dev, usb_sndbulkpipe(usX2Y->dev, 4),
 					  usbdata + i, 2, i_usX2Y_04Int, usX2Y);
-#ifdef OLD_USB
-			us->urb[i]->transfer_flags = USB_QUEUE_BULK;
-#endif
 		}
 		us->submitted =	0;
 		us->len =	NOOF_SETRATE_URBS;
