From: Alberto Aguirre <albaguirre@gmail.com>
Subject: [PATCH] ALSA: usb-audio: add boot quirk for Axe-Fx III
Date: Tue,  8 May 2018 17:14:13 -0500
Message-ID: <20180508221413.20104-1-albaguirre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 by alsa0.perex.cz (Postfix) with ESMTP id BE01B2676EC
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 00:14:18 +0200 (CEST)
Received: by mail-ot0-f194.google.com with SMTP id l22-v6so37954697otj.0
 for <alsa-devel@alsa-project.org>; Tue, 08 May 2018 15:14:18 -0700 (PDT)
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
Cc: Alberto Aguirre <albaguirre@gmail.com>
List-Id: alsa-devel@alsa-project.org

Wait for Axe-Fx III to fully bootup before initializing card.

Signed-off-by: Alberto Aguirre <albaguirre@gmail.com>
---
 sound/usb/quirks.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 5681767cc0d5..f4b69173682c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -851,6 +851,36 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 	return 0; /* Successful boot */
 }
 
+static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
+{
+	int err;
+
+	dev_dbg(&dev->dev, "Waiting for Axe-Fx III to boot up...\n");
+
+	/* If the Axe-Fx III has not fully booted, it will timeout when trying
+	 * to enable the audio streaming interface. A more generous timeout is
+	 * used here to detect when the Axe-Fx III has finished booting as the
+	 * set interface message will be acked once it has
+	 */
+	err = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+				USB_REQ_SET_INTERFACE, USB_RECIP_INTERFACE,
+				1, 1, NULL, 0, 120000);
+	if (err < 0) {
+		dev_err(&dev->dev,
+			"failed waiting for Axe-Fx III to boot: %d\n", err);
+		return err;
+	}
+
+	dev_dbg(&dev->dev, "Axe-Fx III is now ready\n");
+
+	err = usb_set_interface(dev, 1, 0);
+	if (err < 0)
+		dev_dbg(&dev->dev,
+			"error stopping Axe-Fx III interface: %d\n", err);
+
+	return 0;
+}
+
 /*
  * Setup quirks
  */
@@ -1026,6 +1056,8 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 		return snd_usb_fasttrackpro_boot_quirk(dev);
 	case USB_ID(0x047f, 0xc010): /* Plantronics Gamecom 780 */
 		return snd_usb_gamecon780_boot_quirk(dev);
+	case USB_ID(0x2466, 0x8010): /* Fractal Audio Axe-Fx 3 */
+		return snd_usb_axefx3_boot_quirk(dev);
 	}
 
 	return 0;
-- 
2.17.0
