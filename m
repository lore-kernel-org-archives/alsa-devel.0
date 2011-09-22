From: Thomas Pfaff <tpfaff@gmx.net>
Subject: [PATCH] sound/usb/card.c: clear chip->probing on error exit
Date: Thu, 22 Sep 2011 18:26:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1109221808250.3069@thomas.intern.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The Terratec Aureon 5.1 USB sound card support is broken since kernel 
2.6.39.
2.6.39 introduced power management support for USB sound cards that added 
a probing flag in struct snd_usb_audio.

During the probe of the card it gives following error message :

usb 7-2: new full speed USB device number 2 using uhci_hcd
cannot find UAC_HEADER
snd-usb-audio: probe of 7-2:1.3 failed with error -5
input: USB Audio as 
/devices/pci0000:00/0000:00:1d.1/usb7/7-2/7-2:1.3/input/input6
generic-usb 0003:0CCD:0028.0001: input: USB HID v1.00 Device [USB Audio] 
on usb-0000:00:1d.1-2/input3

I can not comment about that "cannot find UAC_HEADER" error, but until 
2.6.38 the card worked anyway.
With 2.6.39 chip->probing remains 1 on error exit, and any later ioctl 
stops in snd_usb_autoresume with -ENODEV.

Signed-off-by: Thomas Pfaff <tpfaff@gmx.net>
---
diff -urp a/sound/usb/card.c b/sound/usb/card.c
--- a/sound/usb/card.c	2011-09-22 08:42:29.138247328 +0200
+++ b/sound/usb/card.c	2011-09-22 09:02:09.382079980 +0200
@@ -532,6 +532,7 @@ snd_usb_audio_probe(struct usb_device *d
  __error:
 	if (chip && !chip->num_interfaces)
 		snd_card_free(chip->card);
+	chip->probing = 0;
 	mutex_unlock(&register_mutex);
  __err_val:
 	return NULL;
