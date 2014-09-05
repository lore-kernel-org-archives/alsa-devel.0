From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH v3] add native DSD support for XMOS based DACs
Date: Fri,  5 Sep 2014 18:14:46 +0200
Message-ID: <1409933686-3032-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud2.xs4all.net (lb2-smtp-cloud2.xs4all.net
 [194.109.24.49])
 by alsa0.perex.cz (Postfix) with ESMTP id D171A2619EA
 for <alsa-devel@alsa-project.org>; Fri,  5 Sep 2014 18:14:48 +0200 (CEST)
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
Cc: Jurgen Kramer <gtmkramer@xs4all.nl>
List-Id: alsa-devel@alsa-project.org

Add quirks for XMOS based DACs for native DSD playback support using the new
DSD_U32_LE sample format.

This version adds native DSD support for:
- iFi Audio micro iDSD/nano iDSD (they use the same prod. id)
- DIYINHK USB to I2S/DSD converter

Changes from v2:
- fix and simplify switch statement
Changes from v1:
- use specific product id and alt setting per XMOS based device

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
---
 sound/usb/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 19a921e..bd5a95e 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1174,5 +1174,21 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		}
 	}
 
+	/* XMOS based USB DACs */
+	switch(chip->usb_id) {
+	/* iFi Audio micro/nano iDSD */
+	case USB_ID(0x20b1, 0x3008):
+		if (fp->altsetting == 2)
+			return SNDRV_PCM_FMTBIT_DSD_U32_LE;
+		break;
+	/* DIYINHK DSD DXD 384kHz USB to I2S/DSD */
+	case USB_ID(0x20b1, 0x2009):
+		if (fp->altsetting == 3)
+			return SNDRV_PCM_FMTBIT_DSD_U32_LE;
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
-- 
1.9.3
