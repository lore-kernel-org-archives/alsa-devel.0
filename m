From: Stefan Sauer <ensonic@hora-obscura.de>
Subject: [PATCH] ALSA: usb-audio: Enable .product_name override
 for Emagic, Unitor 8.
Date: Mon, 10 Jun 2019 11:51:46 +0200
Message-ID: <9f5efc6f-5256-6a2d-d095-fcb4b6eabd46@hora-obscura.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: outreachy-kernel@googlegroups.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>From a41303935608e9a98653d4dff1e10baf1ce07e05 Mon Sep 17 00:00:00 2001
From: Stefan Sauer <ensonic@google.com>
Date: Mon, 10 Jun 2019 11:26:53 +0200
Subject: [PATCH] ALSA: usb-audio: Enable .product_name override for Emagic
 Unitor 8.

The Emagic Unitor 8 does not provide iManufacturer and iProduct fields
in its device descriptor. These fields are used by alsa to make build the
device name. Thus uncomment the .product-name in the quirks-table.

Without this change the device shows up as 'USB Device 0x86a:0x01'.

Output of lsusb and amidi:
https://gist.github.com/ensonic/7820a102e91f31575be355da2b6b33bc

Signed-off-by: Stefan Sauer <ensonic@google.com>
---
 sound/usb/quirks-table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 9e049f60e80e..e918ce346027 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2408,7 +2408,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	USB_DEVICE(0x086a, 0x0001),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		.vendor_name = "Emagic",
-		/* .product_name = "Unitor8", */
+		.product_name = "Unitor8",
 		.ifnum = 2,
 		.type = QUIRK_MIDI_EMAGIC,
 		.data = & (const struct snd_usb_midi_endpoint_info) {
-- 
2.21.0
