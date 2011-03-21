From: "Keith A. Milner" <maillist@superlative.org>
Subject: [PATCH 1/1] Support for Boss JS-8 Jam Station
Date: Mon, 21 Mar 2011 20:15:08 +0000
Message-ID: <1300738508-14087-1-git-send-email-maillist@superlative.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Keith A. Milner" <maillist@superlative.org>
List-Id: alsa-devel@alsa-project.org

From: Keith A. Milner <maillist@superlative.org>


Signed-off-by: Keith A. Milner <maillist@superlative.org>

diff --git a/usb/quirks-table.h b/usb/quirks-table.h
index 196c753..1cefb4a 100644
--- a/usb/quirks-table.h
+++ b/usb/quirks-table.h
@@ -1581,6 +1581,33 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
+        /* Boss JS-8 Jam Station  */
+        USB_DEVICE(0x0582, 0x0109),
+        .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+                /* .vendor_name = "BOSS", */
+                /* .product_name = "JS-8", */
+                .ifnum = QUIRK_ANY_INTERFACE,
+                .type = QUIRK_COMPOSITE,
+                .data = (const struct snd_usb_audio_quirk[]) {
+                        {
+                                .ifnum = 0,
+                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
+                        },
+                        {
+                                .ifnum = 1,
+                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
+                        },
+                        {
+                                .ifnum = 2,
+                                .type = QUIRK_MIDI_STANDARD_INTERFACE
+                        },
+                        {
+                                .ifnum = -1
+                        }
+                }
+        }
+},
+{
 	/* has ID 0x0110 when not in Advanced Driver mode */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x010f),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-- 
1.7.1
