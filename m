From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] ALSA: usb-audio: don't try to get Outlaw RR2150 sample rate
Date: Sat, 30 May 2015 09:15:39 +0000
Message-ID: <1432977339-8918-1-git-send-email-normalperson@yhbt.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Eric Wong <normalperson@yhbt.net>, Joe Turner <joe@oampo.co.uk>
List-Id: alsa-devel@alsa-project.org

This quirk allows us to avoid the noisy:

	current rate 0 is different from the runtime rate

message every time playback starts.  While USB DAC in the RR2150
supports reading the sample rate, it never returns a sample rate
other than zero in my observation with common sample rates.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
Cc: Joe Turner <joe@oampo.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 32631a8..2ea5b33 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1118,6 +1118,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 	case USB_ID(0x045E, 0x075D): /* MS Lifecam Cinema  */
 	case USB_ID(0x045E, 0x076D): /* MS Lifecam HD-5000 */
 	case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
+	case USB_ID(0x074D, 0x3553): /* Outlaw RR2150 (Micronas UAC3553B) */
 		return true;
 	}
 	return false;
-- 
EW
