From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH] usb: Add native DSD support for Oppo HA-1
Date: Mon, 11 Jan 2016 08:16:58 +0100
Message-ID: <1452496618-14452-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud6.xs4all.net (lb2-smtp-cloud6.xs4all.net
 [194.109.24.28])
 by alsa0.perex.cz (Postfix) with ESMTP id BF263260541
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 08:19:04 +0100 (CET)
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

This patch adds native DSD support for the Oppo HA-1. It uses a XMOS chipset
but they use their own vendor ID.

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index b6c0c8e..23ea6d8 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1269,6 +1269,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case USB_ID(0x20b1, 0x3008): /* iFi Audio micro/nano iDSD */
 	case USB_ID(0x20b1, 0x2008): /* Matrix Audio X-Sabre */
 	case USB_ID(0x20b1, 0x300a): /* Matrix Audio Mini-i Pro */
+	case USB_ID(0x22d8, 0x0416): /* OPPO HA-1*/
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
-- 
2.5.0
