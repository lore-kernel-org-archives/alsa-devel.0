From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH] usb-audio: add native DSD support for JLsounds
	I2SoverUSB
Date: Fri,  5 Jun 2015 09:42:49 +0200
Message-ID: <1433490169-4984-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud6.xs4all.net (lb2-smtp-cloud6.xs4all.net
 [194.109.24.28])
 by alsa0.perex.cz (Postfix) with ESMTP id B8A98260693
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 09:43:00 +0200 (CEST)
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

This patch adds native DSD support for the XMOS based JLsounds I2SoverUSB board

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
---
 sound/usb/quirks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2917534..04c285c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1266,8 +1266,9 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
-	/* DIYINHK DSD DXD 384kHz USB to I2S/DSD */
-	case USB_ID(0x20b1, 0x2009):
+
+	case USB_ID(0x20b1, 0x2009): /* DIYINHK DSD DXD 384kHz USB to I2S/DSD */
+	case USB_ID(0x20b1, 0x2023): /* JLsounds I2SoverUSB */
 		if (fp->altsetting == 3)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
-- 
2.1.0
