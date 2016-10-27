From: Marcel Hasler <mahasler@gmail.com>
Subject: [PATCH] snd-usb-audio: Add quirk for Syntek STK1160.
Date: Thu, 27 Oct 2016 10:13:05 +0200
Message-ID: <20161027081305.GA14323@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 35216267335
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 10:13:13 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id y138so1393987wme.1
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 01:13:13 -0700 (PDT)
Received: from arch-desktop ([2a02:908:672:a420:922b:34ff:fe11:2b9f])
 by smtp.gmail.com with ESMTPSA id us3sm7007503wjb.32.2016.10.27.01.13.11
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Oct 2016 01:13:11 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The stk1160 chip needs QUIRK_AUDIO_ALIGN_TRANSFER. This patch resolves the issue reported on the
mailing list (http://marc.info/?l=linux-sound&m=139223599126215&w=2) and also fixes bug 180071
(https://bugzilla.kernel.org/show_bug.cgi?id=180071).

Signed-off-by: Marcel Hasler <mahasler@gmail.com>
---
 sound/usb/quirks-table.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index c60a776..8a59d47 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2907,6 +2907,23 @@ AU0828_DEVICE(0x2040, 0x7260, "Hauppauge", "HVR-950Q"),
 AU0828_DEVICE(0x2040, 0x7213, "Hauppauge", "HVR-950Q"),
 AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 
+/* Syntek STK1160 */
+{
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.idVendor = 0x05e1,
+	.idProduct = 0x0408,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Syntek",
+		.product_name = "STK1160",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_ALIGN_TRANSFER
+	}
+},
+
 /* Digidesign Mbox */
 {
 	/* Thanks to Clemens Ladisch <clemens@ladisch.de> */
-- 
2.10.1
