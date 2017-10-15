From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH] ALSA: usb-audio: Add native DSD support for
	Pro-Ject Pre Box S2 Digital
Date: Sun, 15 Oct 2017 12:41:32 +0300
Message-ID: <1508060492-5010-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 65D44266D04
 for <alsa-devel@alsa-project.org>; Sun, 15 Oct 2017 11:41:59 +0200 (CEST)
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

Add native DSD support quirk for Pro-Ject Pre Box S2 Digital USB id
2772:0230.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9aeb05f..5a040e3 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1348,6 +1348,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case USB_ID(0x20b1, 0x2008): /* Matrix Audio X-Sabre */
 	case USB_ID(0x20b1, 0x300a): /* Matrix Audio Mini-i Pro */
 	case USB_ID(0x22d9, 0x0416): /* OPPO HA-1 */
+	case USB_ID(0x2772, 0x0230): /* Pro-Ject Pre Box S2 Digital */
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
-- 
2.7.4
