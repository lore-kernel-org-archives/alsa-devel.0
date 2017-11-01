From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH] ALSA: usb-audio: support new Amanero Combo384
	firmware version
Date: Wed,  1 Nov 2017 23:32:33 +0200
Message-ID: <1509571953-23030-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 37F7126737F
 for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2017 22:32:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Jussi Laako <jussi@sonarnerd.net>
List-Id: alsa-devel@alsa-project.org

Support DSD_U32_BE sample format on new Amanero Combo384 firmware
version on older VID/PID.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 5a040e3..77eecaa 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1369,6 +1369,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 			case 0x199:
 				return SNDRV_PCM_FMTBIT_DSD_U32_LE;
 			case 0x19b:
+			case 0x203:
 				return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 			default:
 				break;
-- 
2.7.4
