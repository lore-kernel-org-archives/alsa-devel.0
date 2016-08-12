From: Akshay Bhat <akshay.bhat@timesys.com>
Subject: [PATCH] ALSA: usb-audio: Add sample rate inquiry quirk for B850V3 CP2114
Date: Fri, 12 Aug 2016 14:08:47 -0400
Message-ID: <1471025327-3529-1-git-send-email-akshay.bhat@timesys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.com, gtmkramer@xs4all.nl, denk@post.com, guillaume@eulerian.com, vdronov@redhat.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Ken Lin <ken.lin@advantech.com.tw>, Akshay Bhat <akshay.bhat@timesys.com>
List-Id: alsa-devel@alsa-project.org

From: Ken Lin <ken.lin@advantech.com.tw>

Avoid getting sample rate on B850V3 CP2114 as it is unsupported and
causes noisy "current rate is different from the runtime rate" messages
when playback starts.

Signed-off-by: Ken Lin <ken.lin@advantech.com.tw>
Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 6adde45..e5a1133 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1139,6 +1139,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 	case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
 	case USB_ID(0x0556, 0x0014): /* Phoenix Audio TMX320VC */
 	case USB_ID(0x074D, 0x3553): /* Outlaw RR2150 (Micronas UAC3553B) */
+	case USB_ID(0x1901, 0x0191): /* GE B850V3 CP2114 audio interface */
 	case USB_ID(0x1de7, 0x0013): /* Phoenix Audio MT202exe */
 	case USB_ID(0x1de7, 0x0014): /* Phoenix Audio TMX320 */
 	case USB_ID(0x1de7, 0x0114): /* Phoenix Audio MT202pcs */
-- 
2.8.1
