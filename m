From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH] ALSA: usb-audio: Remove explicitly listed
	Mytek devices
Date: Wed, 13 Jun 2018 09:08:55 +0300
Message-ID: <1528870135-30669-2-git-send-email-jussi@sonarnerd.net>
References: <1528870135-30669-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id D9E28266E76
 for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2018 08:09:03 +0200 (CEST)
In-Reply-To: <1528870135-30669-1-git-send-email-jussi@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Jussi Laako <jussi@sonarnerd.net>
List-Id: alsa-devel@alsa-project.org

Remove explicitly listed Mytek devices covered by the more generic DSD
detection method.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/quirks.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 845112c..bc2c715 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1368,9 +1368,6 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case USB_ID(0x22d9, 0x0436): /* OPPO Sonica */
 	case USB_ID(0x22d9, 0x0461): /* OPPO UDP-205 */
 	case USB_ID(0x2522, 0x0012): /* LH Labs VI DAC Infinity */
-	case USB_ID(0x25ce, 0x001f): /* Mytek Brooklyn DAC */
-	case USB_ID(0x25ce, 0x0021): /* Mytek Manhattan DAC */
-	case USB_ID(0x25ce, 0x8025): /* Mytek Brooklyn DAC+ */
 	case USB_ID(0x2772, 0x0230): /* Pro-Ject Pre Box S2 Digital */
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
-- 
2.7.4
