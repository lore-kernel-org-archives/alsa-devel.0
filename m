From: Guillaume Fougnies <guillaume@eulerian.com>
Subject: Re: [PATCH] teac ud-501/ud-503 usb delay
Date: Tue, 26 Jan 2016 00:28:27 +0100
Message-ID: <20160125232827.GA5626@eulerian.com>
References: <20160124163617.GE4388@eulerian.com> <s5htwm1apre.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.eulerian.com (mail.eulerian.com [109.232.193.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 012762604D8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 00:28:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htwm1apre.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA: usb: Fix TEAC UD-501/UD-503/NT-503 usb delay

TEAC UD-501/UD-503/NT-503 fail to switch properly between different rate/format.
Similar to 'Playback Design', this patch corrects the invalid clock source error
for TEAC products and avoids complete freeze of the usb interface of 503 series.

Signed-off-by: Guillaume Fougnies <guillaume@eulerian.com>
---
 sound/usb/quirks.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 23ea6d8..a75d9ce 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1205,8 +1205,12 @@ void snd_usb_set_interface_quirk(struct usb_device *dev)
 	 * "Playback Design" products need a 50ms delay after setting the
 	 * USB interface.
 	 */
-	if (le16_to_cpu(dev->descriptor.idVendor) == 0x23ba)
+	switch (le16_to_cpu(dev->descriptor.idVendor)) {
+	case 0x23ba: /* Playback Design */
+	case 0x0644: /* TEAC Corp. */
 		mdelay(50);
+		break;
+	}
 }
 
 void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
@@ -1221,6 +1225,14 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
+	/*
+	 * "TEAC Corp." products need a 20ms delay after each
+	 * class compliant request
+	 */
+	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x0644) &&
+	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
+		mdelay(20);
+
 	/* Marantz/Denon devices with USB DAC functionality need a delay
 	 * after each class compliant request
 	 */
-- 
2.7.0.rc3
