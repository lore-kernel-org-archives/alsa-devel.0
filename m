From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 8/8] ALSA: usb-audio: handle "Fast Track Ultra"
	with USB_DEVICE_VENDOR_SPEC()
Date: Wed, 18 May 2011 11:28:45 +0200
Message-ID: <1305710925-3857-9-git-send-email-zonque@gmail.com>
References: <1305710925-3857-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id C64AB10393C
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 11:29:02 +0200 (CEST)
In-Reply-To: <1305710925-3857-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

That way, the class compliant MIDI interface is also handled.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-and-tested-by: Grant Diffey <gdiffey@gmail.com>
---
 sound/usb/quirks-table.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 690767c..78792a8 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1979,7 +1979,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	USB_DEVICE(0x0763, 0x2080),
+	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2080),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track Ultra", */
@@ -2046,7 +2046,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	USB_DEVICE(0x0763, 0x2081),
+	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2081),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track Ultra 8R", */
-- 
1.7.5.1
