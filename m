From: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
Subject: [PATCH] ALSA: usb-audio: Add quirk for ELP HD USB Camera
Date: Mon, 08 Aug 2016 12:35:40 +0200
Message-ID: <cdaa8f6247049412e7f400fa3cbc5192@vittgam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The ELP HD USB Camera (05a3:9420) needs this quirk for suppressing
the unsupported sample rate inquiry.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98481
Cc: <stable@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
---

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1138,6 +1138,7 @@
  	case USB_ID(0x047F, 0xAA05): /* Plantronics DA45 */
  	case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
  	case USB_ID(0x0556, 0x0014): /* Phoenix Audio TMX320VC */
+	case USB_ID(0x05A3, 0x9420): /* ELP HD USB Camera */
  	case USB_ID(0x074D, 0x3553): /* Outlaw RR2150 (Micronas UAC3553B) */
  	case USB_ID(0x1de7, 0x0013): /* Phoenix Audio MT202exe */
  	case USB_ID(0x1de7, 0x0014): /* Phoenix Audio TMX320 */

