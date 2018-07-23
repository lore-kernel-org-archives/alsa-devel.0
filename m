From: yuleopen@gmail.com
Subject: [PATCH] alsa/usb-audio: Topping DX7s quirk for DSD interface
Date: Mon, 23 Jul 2018 00:25:34 -0700
Message-ID: <20180723072536.39240-1-yuleopen@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: yuleopen@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jussi Laako <jussi@sonarnerd.net>, Nobutaka Okabe <nob77413@gmail.com>, Daniel Mack <daniel@zonque.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Alberto Aguirre <albaguirre@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Yue Wang <yuleopen@gmail.com>

Signed-off-by: Yue Wang <yuleopen@gmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 02b6cc02767f..c51e2dee3075 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1374,6 +1374,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		break;
 
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
+	case USB_ID(0x152a, 0x8750): /* Topping DX7s */
 	case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
 	case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
 	case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */
-- 
2.17.0.441.gb46fe60e1d-goog
