From: ilya.pshonkin@netforce.ua
Subject: [PATCH] ALSA: usb-audio: Add Hiby R3 to quirks for native DSD support
Date: Mon, 26 Aug 2019 19:09:52 +0300
Message-ID: <20190826160953.19402-1-ilya.pshonkin@netforce.ua>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ilya.pshonkin@netforce.ua
Cc: Sudokamikaze <sudokamikaze@protonmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jussi Laako <jussi@sonarnerd.net>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Fontana <rfontana@redhat.com>, Manuel Reinhardt <manuel.rhdt@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Sudokamikaze <sudokamikaze@protonmail.com>

This patch adds quirk VID/PID IDs for Hiby R3 portable DSD player DSD support

Signed-off-by: Sudokamikaze <sudokamikaze@protonmail.com>
---
 sound/usb/quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 78858918cbc1..f90418149e4e 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1588,6 +1588,12 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
+	
+	/* ESS Sabre based USB DACs */
+	case USB_ID(0xc502, 0x0051): /* Hiby R3 */
+		if (fp->altsetting == 4)
+			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
+		break;
 
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
 	case USB_ID(0x10cb, 0x0103): /* The Bit Opus #3; with fp->dsd_raw */
-- 
2.23.0
