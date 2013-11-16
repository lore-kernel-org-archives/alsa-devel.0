From: Simone Camporeale <simone.camporeale@gmail.com>
Subject: [PATCH] Maya44+ Support in ALSA
Date: Sat, 16 Nov 2013 14:44:07 +0100
Message-ID: <CAK+n=GUBR=bt_YLg0Gzg9xax93H0cgvO12Nwz7r=YmULnfqpSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id B1D782608ED
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2013 14:44:09 +0100 (CET)
Received: by mail-pd0-f173.google.com with SMTP id x10so4638276pdj.4
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2013 05:44:08 -0800 (PST)
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

I found some problems on Maya44+ USB support in linux.
Using ubuntu 13.04 , Ubuntu 13.10 with alsa driver alsa-driver-1.0.25+dfsg
i found that this card isn't supported.
Only 2 of 4 channels work and they are mixed .
This card mounts TI TUSB3200AC chip.
This chip is also used in Re Loop devices and in Herlcues DJ Console.
To fix this problem i found on google a patch for Reloop device. I chanaged
VID and PID for MAYA44+ and now it works .
This patch involves in edititing ./sound/usb/quirks-table.h according to
attached patch

Also i provide an .asoundrc. With this .asoundrc you are able to use each
input and output channel

maya44+ patch

--- a/sound/usb/quirks-table.h    2013-11-12 12:43:24.380251603 +0100
+++ b/sound/usb/quirks-table.h    2013-11-06 12:28:20.000000000 +0100
@@ -320,6 +320,93 @@
 #undef YAMAHA_DEVICE
 #undef YAMAHA_INTERFACE

+
+/* Reloop Play */
+{
+    USB_DEVICE(0x200c, 0x100b),
+    .bInterfaceClass = USB_CLASS_PER_INTERFACE,
+    .driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+        .ifnum = QUIRK_ANY_INTERFACE,
+        .type = QUIRK_COMPOSITE,
+        .data = &(const struct snd_usb_audio_quirk[]) {
+            {
+                .ifnum = 0,
+                .type = QUIRK_AUDIO_STANDARD_MIXER,
+            },
+            {
+                .ifnum = 1,
+                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
+                .data = &(const struct audioformat) {
+                    .formats = SNDRV_PCM_FMTBIT_S24_3LE,
+                    .channels = 4,
+                    .iface = 1,
+                    .altsetting = 1,
+                    .altset_idx = 1,
+                    .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+                    .endpoint = 0x01,
+                    .ep_attr = USB_ENDPOINT_SYNC_ADAPTIVE,
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
+                .ifnum = -1
+            }
+        }
+    }
+},
+
+/* Maya44 USB+ Play */
+{
+    USB_DEVICE(0x2573, 0x0008),
+    .bInterfaceClass = USB_CLASS_PER_INTERFACE,
+    .driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+        .ifnum = QUIRK_ANY_INTERFACE,
+        .type = QUIRK_COMPOSITE,
+        .data = &(const struct snd_usb_audio_quirk[]) {
+            {
+                .ifnum = 0,
+                .type = QUIRK_AUDIO_STANDARD_MIXER,
+            },
+            {
+                .ifnum = 1,
+                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
+                .data = &(const struct audioformat) {
+                    .formats = SNDRV_PCM_FMTBIT_S24_3LE,
+                    .channels = 4,
+                    .iface = 1,
+                    .altsetting = 1,
+                    .altset_idx = 1,
+                    .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+                    .endpoint = 0x01,
+                    .ep_attr = USB_ENDPOINT_SYNC_ADAPTIVE,
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
+                .ifnum = -1
+            }
+        }
+    }
+},
+
+
+
+
+
 /*
  * Roland/RolandED/Edirol/BOSS devices
  */

.asoundrc example:

pcm.dshare {
    type dmix
    ipc_key 2048
    slave {
        pcm "hw:1"
        rate 44100
        period_time 0
        period_size 1024
        buffer_size 8192
        channels 4
    }
    bindings {
        0 0
        1 1
        2 2
        3 3
    }
}

pcm.dsnooped {
    type dsnoop
    ipc_key 2048
    slave {
        pcm "hw:1"
        rate 48000
    periods 0
        period_time 0
        period_size 1024
        buffer_size 4096
        channels 4
    }
}

pcm.mayaAin1 {
   type plug
   slave {
    pcm "dsnooped"
    channels 4
   }
   ttable.0.0 1
}
pcm.mayaAin2 {
   type plug
   slave {
    pcm "dsnooped"
    channels 4
   }
   ttable.0.1 1
}
pcm.mayaAin3 {
   type plug
   slave {
    pcm "dsnooped"
    channels 4
   }
   ttable.0.2 1
}
pcm.mayaAin4 {
   type plug
   slave {
    pcm "dsnooped"
    channels 4
   }
   ttable.0.3 1
}

pcm.mayaAout1 {
    type plug
    slave {
        pcm "dshare"
        channels 4
    }
    ttable.0.0 1
}
pcm.mayaAout2 {
    type plug
    slave {
        pcm "dshare"
        channels 4
    }
    ttable.0.1 1
}
pcm.mayaAout3 {
    type plug
    slave {
        pcm "dshare"
        channels 4
    }
    ttable.0.2 1
}

pcm.mayaAout4 {
    type plug
    slave {
        pcm "dshare"
        channels 4
    }
    ttable.0.3 1
}
