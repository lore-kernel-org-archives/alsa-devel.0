From: =?UTF-8?B?0K3QtNGD0LDRgNC0INCT0LjQu9GM0LzRg9GC0LTQuNC90L7Qsg==?=
 <edgilmutdinov@gmail.com>
Subject: Add support for Focusrite Saffire 6 USB
Date: Sat, 14 Dec 2013 13:22:22 +0600
Message-ID: <CAFLJmHndftVOH7kmYV+y3cqNYN4opY7D05wLx8Du0R5tXzbVqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id CE9DE261A78
 for <alsa-devel@alsa-project.org>; Sat, 14 Dec 2013 08:22:22 +0100 (CET)
Received: by mail-wg0-f46.google.com with SMTP id m15so2683889wgh.1
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 23:22:22 -0800 (PST)
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

Hello! I have external audio card Focusrite Saffire 6 USB. This device
works with the Linux kernel if I add the following corrections:

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f5f0595..158beb4 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2569,6 +2569,46 @@ YAMAHA_DEVICE(0x7010, "UB99"),
         .type = QUIRK_MIDI_NOVATION
     }
 },
+{
+    USB_DEVICE(0x1235, 0x0010),
+    .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+        .vendor_name = "Focusrite",
+        .product_name = "Saffire 6 USB",
+        .ifnum = QUIRK_ANY_INTERFACE,
+        .type = QUIRK_COMPOSITE,
+        .data = (const struct snd_usb_audio_quirk[]) {
+            {
+                .ifnum = 0,
+                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
+                .data = & (const struct audioformat) {
+                    .formats = SNDRV_PCM_FMTBIT_S24_3LE,
+                    .channels = 4,
+                    .iface = 0,
+                    .altsetting = 1,
+                    .altset_idx = 1,
+                    .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+                    .endpoint = 0x01,
+                    .ep_attr = USB_ENDPOINT_XFER_ISOC,
+                    .rates = SNDRV_PCM_RATE_44100 |
+                         SNDRV_PCM_RATE_48000,
+                    .rate_min = 44100,
+                    .rate_max = 48000,
+                    .nr_rates = 2,
+                    .rate_table = (unsigned int[]) {
+                        44100, 48000
+                    }
+                }
+            },
+            {
+                .ifnum = 1,
+                .type = QUIRK_MIDI_RAW_BYTES
+            },
+            {
+                .ifnum = -1
+            }
+        }
+    }
+},

 /* Access Music devices */
 {


 diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 0df9ede..3ea9627 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -660,10 +660,11 @@ static int snd_usb_cm6206_boot_quirk(struct
usb_device *dev)
     return err;
 }

-/*
+/*
  * Novation Twitch DJ controller
+ * Focusrite(Novation) Saffire 6 USB audio card
  */
-static int snd_usb_twitch_boot_quirk(struct usb_device *dev)
+static int snd_usb_novation_boot_quirk(struct usb_device *dev)
 {
     /* preemptively set up the device because otherwise the
      * raw MIDI endpoints are not active */
@@ -972,9 +973,9 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
         /* Digidesign Mbox 2 */
         return snd_usb_mbox2_boot_quirk(dev);

-    case USB_ID(0x1235, 0x0018):
-        /* Focusrite Novation Twitch */
-        return snd_usb_twitch_boot_quirk(dev);
+    case USB_ID(0x1235, 0x0010): /* Focusrite Novation Saffire 6 USB */
+    case USB_ID(0x1235, 0x0018): /* Focusrite Novation Twitch */
+        return snd_usb_novation_boot_quirk(dev);

     case USB_ID(0x133e, 0x0815):
         /* Access Music VirusTI Desktop */


Help me to add this corrections in the Linux kernel mainline.

Thank you!
