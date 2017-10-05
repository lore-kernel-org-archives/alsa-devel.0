From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ALSA: usb-audio: Add sample rate quirk for Plantronics P610
Date: Fri,  6 Oct 2017 02:04:06 +0800
Message-ID: <20171005180406.748-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: alsa-devel@alsa-project.org

Like other Plantronics devices, P610 does not support sample
rate reading. Apply sample rate quirk to it.

BugLink: https://bugs.launchpad.net/bugs/1719853

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index b8cb57aeec77..9ddaae3784f5 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1138,6 +1138,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 	case USB_ID(0x047F, 0x0415): /* Plantronics BT-300 */
 	case USB_ID(0x047F, 0xAA05): /* Plantronics DA45 */
 	case USB_ID(0x047F, 0xC022): /* Plantronics C310 */
+	case USB_ID(0x047F, 0xC02F): /* Plantronics P610 */
 	case USB_ID(0x047F, 0xC036): /* Plantronics C520-M */
 	case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
 	case USB_ID(0x0556, 0x0014): /* Phoenix Audio TMX320VC */
-- 
2.14.1
