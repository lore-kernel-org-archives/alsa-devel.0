From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH v2] ALSA: usb-audio: Add vendor and product
	name for Dell WD19 Dock
Date: Wed, 28 Nov 2018 17:11:26 +0800
Message-ID: <20181128091126.5071-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E6BCE267AF3
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 10:11:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Like the Dell WD15 Dock, the WD19 Dock (0bda:402e) doens't provide
useful string for the vendor and product names too. In order to share
the UCM with WD15, here we keep the profile_name same as the WD15.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/usb/quirks-table.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 849953e5775c..37fc0447c071 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3382,5 +3382,15 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		.ifnum = QUIRK_NO_INTERFACE
 	}
 },
+/* Dell WD19 Dock */
+{
+	USB_DEVICE(0x0bda, 0x402e),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Dell",
+		.product_name = "WD19 Dock",
+		.profile_name = "Dell-WD15-Dock",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC
-- 
2.17.1
