From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH] Support both DSD LE/BE Amanero firmware
	versions
Date: Sat, 17 Dec 2016 23:51:41 +0200
Message-ID: <1482011501-6723-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id C318126683C
 for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2016 22:52:39 +0100 (CET)
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
Cc: tiwai@suse.de, Jussi Laako <jussi@sonarnerd.net>, gtmkramer@xs4all.nl
List-Id: alsa-devel@alsa-project.org

Add DSD support for both little endian (DSD_U32_LE) and big endian
(DSD_U32_BE) version of the Amanero firmware.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index b3fd238..f5c68ea 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1359,6 +1359,21 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		if (fp->altsetting == 3)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
+
+	/* Amanero Combo384 USB interface with native DSD support */
+	case USB_ID(0x16d0, 0x071a):
+		if (fp->altsetting == 2) {
+			switch (chip->dev->descriptor.bcdDevice) {
+			case 0x199:
+				return SNDRV_PCM_FMTBIT_DSD_U32_LE;
+			case 0x19b:
+				return SNDRV_PCM_FMTBIT_DSD_U32_BE;
+			default:
+				break;
+			}
+		}
+		break;
+
 	default:
 		break;
 	}
-- 
2.7.4
