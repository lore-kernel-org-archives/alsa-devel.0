From: Trulan Martin <trulanm@gmail.com>
Subject: [PATCH - Yamaha THR5a 2/3] Yamaha THR5a USB quirk
Date: Sat, 20 Apr 2013 11:31:46 -0400
Message-ID: <1366471907-16615-3-git-send-email-trulanm@gmail.com>
References: <1366471907-16615-1-git-send-email-trulanm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1366471907-16615-1-git-send-email-trulanm@gmail.com>
In-Reply-To: [PATCH 0/3] Yamaha THR10 and related USB quirks
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Trulan Martin <trulanm@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch adds a USB quirk for the Yamaha THR5a amp.

Signed-off-by: Trulan Martin <trulanm@gmail.com>

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 741680a..a16cb45 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -379,6 +379,35 @@ YAMAHA_DEVICE(0x105d, NULL),
         }
     }
 },
+/*
+ * Yamaha THR5a
+ */
+{
+   USB_DEVICE(0x0499, 0x150a),
+   .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+      /* .vendor_name = "Yamaha", */
+      /* .product_name = "THR5a", */
+      .ifnum = QUIRK_ANY_INTERFACE,
+      .type = QUIRK_COMPOSITE,
+      .data = (const struct snd_usb_audio_quirk[]) {
+         {
+            .ifnum = 1,
+            .type = QUIRK_AUDIO_STANDARD_INTERFACE
+         },
+         {
+            .ifnum = 2,
+            .type = QUIRK_AUDIO_STANDARD_INTERFACE
+         },
+         {
+            .ifnum = 3,
+            .type = QUIRK_MIDI_YAMAHA
+         },
+         {
+            .ifnum = -1
+         }
+      }
+   }
+},
 YAMAHA_DEVICE(0x2000, "DGP-7"),
 YAMAHA_DEVICE(0x2001, "DGP-5"),
 YAMAHA_DEVICE(0x2002, NULL),
-- 
1.7.10.4
