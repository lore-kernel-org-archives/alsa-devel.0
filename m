From: Dan Allongo <gongo2k1@gmail.com>
Subject: PATCH: C-Media 6206 USB Audio
Date: Sun, 7 Jun 2009 22:46:51 -0400
Message-ID: <194d079b0906071946n8a67312se5d23f7080496fea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.149])
	by alsa0.perex.cz (Postfix) with ESMTP id D4C29244B9
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 04:46:53 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1461603qwk.56
	for <alsa-devel@alsa-project.org>; Sun, 07 Jun 2009 19:46:52 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

I've been posting on the alsa-users list and I think I finally have a
working patch now that I'd like to submit.
The C-Media 6206 device is based off of CM106 and just needed a boot quirk
added to set the registers properly for output.
At least one other user can confirm that this patch works and that the
SPDIF-out is also functioning now with this change.
This is diff'd against today's snapshot so it should be good to go.
Let me know if there's anything else that I need to do or change with this.

Thanks,
---Dan



--- alsa-driver/alsa-kernel/usb/usbaudio.c    2009-06-07 06:20:32.000000000
-0400
+++ alsa-driver/alsa-kernel/usb/usbaudio.c    2009-06-07 22:24:44.000000000
-0400
@@ -3291,6 +3291,21 @@
     return snd_usb_cm106_write_int_reg(dev, 2, 0x8004);
 }

+static int snd_usb_cm6206_boot_quirk(struct usb_device *dev)
+{
+    /*
+     * C-Media CM6206 is based on CM106 with two additional
+     * registers that are not documented in the data sheet.
+     * Values here are chosen based on sniffing USB traffic
+     * under Windows.
+     */
+    return snd_usb_cm106_write_int_reg(dev, 0, 0x200c) +
+        snd_usb_cm106_write_int_reg(dev, 1, 0x3000) +
+        snd_usb_cm106_write_int_reg(dev, 2, 0xf800) +
+        snd_usb_cm106_write_int_reg(dev, 3, 0x143f) +
+        snd_usb_cm106_write_int_reg(dev, 4, 0x0000) +
+        snd_usb_cm106_write_int_reg(dev, 5, 0x3000);
+}

 /*
  * Setup quirks
@@ -3577,6 +3592,12 @@
             goto __err_val;
     }

+    /* C-Media CM6206 / CM106-Like Sound Device */
+    if (id == USB_ID(0x0d8c, 0x0102)) {
+        if (snd_usb_cm6206_boot_quirk(dev) < 0)
+            goto __err_val;
+    }
+
     /*
      * found a config.  now register to ALSA
      */
