From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH] usb-audio: Add ctrl message delay quirk for
	Marantz/Denon devices
Date: Sat, 15 Nov 2014 14:01:21 +0100
Message-ID: <1416056481-5086-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud6.xs4all.net (lb2-smtp-cloud6.xs4all.net
 [194.109.24.28])
 by alsa0.perex.cz (Postfix) with ESMTP id E4D4A2605E7
 for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2014 14:01:25 +0100 (CET)
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
Cc: Jurgen Kramer <gtmkramer@xs4all.nl>
List-Id: alsa-devel@alsa-project.org

This patch adds a USB control message delay quirk for a few specific Marantz/Denon
devices. Without the delay the DACs will not work properly and produces the
following type of messages:

Nov 15 10:09:21 orwell kernel: [   91.342880] usb 3-13: clock source 41 is not valid, cannot use
Nov 15 10:09:21 orwell kernel: [   91.343775] usb 3-13: clock source 41 is not valid, cannot use

There are likely other Marantz/Denon devices using the same USB module which exhibit the
same problems. But as this cannot be verified I limited the patch to the devices
I could test.

The following two devices are covered by this path:
- Marantz SA-14S1
- Marantz HD-DAC1

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
---
 sound/usb/quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index d2aa45a..a5941f8 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1146,6 +1146,20 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x23ba) &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
+
+	/* Marantz/Denon devices with USB DAC functionality need a delay
+	 * after each class compliant request
+	 */
+	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x154e) &&
+	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS) {
+
+		switch (le16_to_cpu(dev->descriptor.idProduct)) {
+		case 0x3005: /* Marantz HD-DAC1 */
+		case 0x3006: /* Marantz SA-14S1 */
+			mdelay(20);
+			break;
+		}
+	}
 }
 
 /*
-- 
1.9.3
