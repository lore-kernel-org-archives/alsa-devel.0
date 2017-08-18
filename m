From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH] ALSA: usb-audio: add DSD support for new
	Amanero PID
Date: Fri, 18 Aug 2017 10:42:14 +0300
Message-ID: <1503042134-6681-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id E49CE2671D3
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 09:42:43 +0200 (CEST)
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
Cc: tiwai@suse.de, Jussi Laako <jussi@sonarnerd.net>
List-Id: alsa-devel@alsa-project.org

Add DSD support for new Amanero Combo384 firmware version with a new
PID. This firmware uses DSD_U32_BE.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2eb6e0d..c09a28b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1374,6 +1374,10 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 			}
 		}
 		break;
+	case USB_ID(0x16d0, 0x0a23):
+		if (fp->altsetting == 2)
+			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
+		break;
 
 	default:
 		break;
-- 
2.7.4
