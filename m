From: Viktor Radnai <viktor.radnai@gmail.com>
Subject: [PATCH] Set sample rate for Digidesign Mbox 2
Date: Tue, 1 Aug 2017 10:23:33 +0100
Message-ID: <CANx-tGi=P0Y2aiXBA1fOtMF5B2wsMoAzHBa2fkrJpzVkE1UBKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id E52E7266847
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 11:23:35 +0200 (CEST)
Received: by mail-oi0-f42.google.com with SMTP id g131so9679067oic.3
 for <alsa-devel@alsa-project.org>; Tue, 01 Aug 2017 02:23:35 -0700 (PDT)
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
Cc: Damien Zammit <damien@zamaudio.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm re-submitting this as I didn't get a response on it for about two
weeks. Please see the old thread called "Patch for Digidesign Mbox 2 (set
sample rate)" for prior discussion on it. Let me know if you need anything
else from me to get this applied.

Cheers,
Vik

diff -ur linux-source-4.11-orig/sound/usb/quirks.c
linux-source-4.11/sound/usb/quirks.c
--- linux-source-4.11-orig/sound/usb/quirks.c    2017-06-17
05:47:27.000000000 +0100
+++ linux-source-4.11/sound/usb/quirks.c    2017-07-18 22:37:58.522858262
+0100
@@ -768,23 +768,32 @@

 static void mbox2_setup_48_24_magic(struct usb_device *dev)
 {
-    u8 srate[3];
-    u8 temp[12];
-
     /* Choose 48000Hz permanently */
-    srate[0] = 0x80;
-    srate[1] = 0xbb;
-    srate[2] = 0x00;
+    u8 srate[3] = { 0x80, 0xbb, 0x00 };
+    u8 temp[3];
+    int err;

     /* Send the magic! */
-    snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
-        0x01, 0x22, 0x0100, 0x0085, &temp, 0x0003);
-    snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
-        0x81, 0xa2, 0x0100, 0x0085, &srate, 0x0003);
-    snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
-        0x81, 0xa2, 0x0100, 0x0086, &srate, 0x0003);
-    snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
-        0x81, 0xa2, 0x0100, 0x0003, &srate, 0x0003);
+    if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_SET_CUR,
+        USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_OUT,
+        UAC_EP_CS_ATTR_SAMPLE_RATE << 8, 0x0085, &temp, sizeof(temp))) < 0)
+        dev_err(&dev->dev, "mbox2: magic setup step #1 failed\n");
+
+    if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_GET_CUR,
+        USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
+        UAC_EP_CS_ATTR_SAMPLE_RATE << 8, 0x0085, &srate, sizeof(srate))) <
0)
+        dev_err(&dev->dev, "mbox2: magic setup step #2 failed\n");
+
+    if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_GET_CUR,
+        USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
+        UAC_EP_CS_ATTR_SAMPLE_RATE << 8, 0x0086, &srate, sizeof(srate))) <
0)
+        dev_err(&dev->dev, "mbox2: magic setup step #3 failed\n");
+
+    if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_GET_CUR,
+        USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
+        UAC_EP_CS_ATTR_SAMPLE_RATE << 8, 0x0003, &srate, sizeof(srate))) <
0)
+        dev_err(&dev->dev, "mbox2: magic setup step #4 failed\n");
+
     return;
 }

@@ -815,16 +824,16 @@

     count = 0;
     bootresponse[0] = MBOX2_BOOT_LOADING;
-    while ((bootresponse[0] == MBOX2_BOOT_LOADING) && (count < 10)) {
-        msleep(500); /* 0.5 second delay */
+    do {
         snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
             /* Control magic - load onboard firmware */
-            0x85, 0xc0, 0x0001, 0x0000, &bootresponse, 0x0012);
+            UAC_GET_MEM, USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
0x0001, 0x0000, &bootresponse, sizeof(bootresponse));
         if (bootresponse[0] == MBOX2_BOOT_READY)
             break;
+        msleep(500); /* 0.5 second delay */
         dev_dbg(&dev->dev, "device not ready, resending boot
sequence...\n");
         count++;
-    }
+    } while ((bootresponse[0] == MBOX2_BOOT_LOADING) && (count < 10));

     if (bootresponse[0] != MBOX2_BOOT_READY) {
         dev_err(&dev->dev, "Unknown bootresponse=%d, or timed out,
ignoring device.\n", bootresponse[0]);
@@ -847,7 +856,7 @@

     mbox2_setup_48_24_magic(dev);

-    dev_info(&dev->dev, "Digidesign Mbox 2: 24bit 48kHz");
+    dev_info(&dev->dev, "Digidesign Mbox 2 configured");

     return 0; /* Successful boot */
 }
@@ -1111,6 +1120,26 @@
     subs->pkt_offset_adj = (emu_samplerate_id >= EMU_QUIRK_SR_176400HZ) ?
4 : 0;
 }

+static void set_format_mbox2_quirk(struct snd_usb_substream *subs,
+                 struct audioformat *fmt)
+{
+    struct usb_device *dev = subs->dev;
+    u8 srate[3];
+    int err;
+
+    srate[0] = subs->cur_rate;
+    srate[1] = subs->cur_rate >> 8;
+    srate[2] = subs->cur_rate >> 16;
+
+    /* Set the sample rate for endpoint IN 5 (0x0085) until we succeed */
+    while ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
UAC_SET_CUR,
+        USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_OUT,
+        UAC_EP_CS_ATTR_SAMPLE_RATE << 8, 0x0085, srate, sizeof(srate))) <
0)
+        dev_err(&dev->dev, "mbox2: set sample rate failed, retrying\n");
+
+    dev_info(&subs->dev->dev, "mbox2: set sample rate to %dHz\n",
subs->cur_rate);
+}
+
 void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
                   struct audioformat *fmt)
 {
@@ -1121,6 +1150,9 @@
     case USB_ID(0x041e, 0x3f19): /* E-Mu 0204 USB */
         set_format_emu_quirk(subs, fmt);
         break;
+    case USB_ID(0x0dba, 0x3000): /* Digidesign Mbox 2 */
+        set_format_mbox2_quirk(subs, fmt);
+        break;
     }
 }

diff -ur linux-source-4.11-orig/sound/usb/quirks-table.h
linux-source-4.11/sound/usb/quirks-table.h
--- linux-source-4.11-orig/sound/usb/quirks-table.h    2017-06-17
05:47:27.000000000 +0100
+++ linux-source-4.11/sound/usb/quirks-table.h    2017-07-18
17:33:57.620424012 +0100
@@ -3020,12 +3020,13 @@
                     .attributes = 0x00,
                     .endpoint = 0x03,
                     .ep_attr = USB_ENDPOINT_SYNC_ASYNC,
-                    .rates = SNDRV_PCM_RATE_48000,
-                    .rate_min = 48000,
+                    .rates = SNDRV_PCM_RATE_44100|
+                        SNDRV_PCM_RATE_48000,
+                    .rate_min = 44100,
                     .rate_max = 48000,
-                    .nr_rates = 1,
+                    .nr_rates = 2,
                     .rate_table = (unsigned int[]) {
-                        48000
+                        44100, 48000
                     }
                 }
             },
@@ -3045,12 +3046,13 @@
                     .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
                     .endpoint = 0x85,
                     .ep_attr = USB_ENDPOINT_SYNC_SYNC,
-                    .rates = SNDRV_PCM_RATE_48000,
-                    .rate_min = 48000,
+                    .rates = SNDRV_PCM_RATE_44100|
+                        SNDRV_PCM_RATE_48000,
+                    .rate_min = 44100,
                     .rate_max = 48000,
-                    .nr_rates = 1,
+                    .nr_rates = 2,
                     .rate_table = (unsigned int[]) {
-                        48000
+                        44100, 48000
                     }
                 }
             },
