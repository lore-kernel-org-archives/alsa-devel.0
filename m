From: Yue Wang <yuleopen@gmail.com>
Subject: [PATCH] alsa/usb-audio: Generic DSD detection for Thesycon-based implementations
Date: Mon, 23 Jul 2018 01:56:46 -0700
Message-ID: <20180723085647.49537-1-yuleopen@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: yuleopen@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jussi Laako <jussi@sonarnerd.net>, Nobutaka Okabe <nob77413@gmail.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Daniel Mack <daniel@zonque.org>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Alberto Aguirre <albaguirre@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thesycon provides solutions to XMOS chips, and has its own device vendor id.

In this patch, we use generic method to detect DSD capability of Thesycon-based UAC2
implementations in order to support a wide range of current and future devices.

The patch will enable the SNDRV_PCM_FMTBIT_DSD_U32_BE bit for the DAC
hence enable native DSD playback up to DSD512 format.

Signed-off-by: Yue Wang <yuleopen@gmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 02b6cc02767f..06ae3f5adf4b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1443,6 +1443,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	 */
 	switch (USB_ID_VENDOR(chip->usb_id)) {
 	case 0x20b1:  /* XMOS based devices */
+	case 0x152a:  /* Thesycon devices */
 	case 0x25ce:  /* Mytek devices */
 		if (fp->dsd_raw)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
-- 
2.18.0
