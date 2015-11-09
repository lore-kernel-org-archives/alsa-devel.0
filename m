From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH] usb: Add native DSD support for Aune X1S
Date: Mon,  9 Nov 2015 12:13:55 +0100
Message-ID: <1447067635-7672-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb3-smtp-cloud6.xs4all.net (lb3-smtp-cloud6.xs4all.net
 [194.109.24.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BE9626153C
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 12:14:00 +0100 (CET)
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
Cc: tiwai@suse.de, Jurgen Kramer <gtmkramer@xs4all.nl>
List-Id: alsa-devel@alsa-project.org

This patch adds native DSD support for the Aune X1S 32BIT/384 DSD DAC

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 4897ea1..5ca80e7 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1274,6 +1274,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case USB_ID(0x20b1, 0x000a): /* Gustard DAC-X20U */
 	case USB_ID(0x20b1, 0x2009): /* DIYINHK DSD DXD 384kHz USB to I2S/DSD */
 	case USB_ID(0x20b1, 0x2023): /* JLsounds I2SoverUSB */
+	case USB_ID(0x20b1, 0x3023): /* Aune X1S 32BIT/384 DSD DAC */
 		if (fp->altsetting == 3)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
-- 
2.1.0
