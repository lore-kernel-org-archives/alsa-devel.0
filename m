From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ALSA: usb: add more device quirks for USB DSD
	devices
Date: Sun, 11 Feb 2018 09:50:27 -0400
Message-ID: <20180211135027.22250-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 53201266C0E
 for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2018 14:50:44 +0100 (CET)
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
Cc: tiwai@suse.de, tgresens@gmail.com, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Add some more devices that need quirks to handle DSD modes correctly.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Reported-and-tested-by: Thomas Gresens <tgresens@gmail.com>
---
 sound/usb/quirks.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index a66ef5777887..ea8f3de92fa4 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1363,8 +1363,11 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
 
-	/* Amanero Combo384 USB interface with native DSD support */
-	case USB_ID(0x16d0, 0x071a):
+	/* Amanero Combo384 USB based DACs with native DSD support */
+	case USB_ID(0x16d0, 0x071a):  /* Amanero - Combo384 */
+	case USB_ID(0x2ab6, 0x0004):  /* T+A DAC8DSD-V2.0, MP1000E-V2.0, MP2000R-V2.0, MP2500R-V2.0, MP3100HV-V2.0 */
+	case USB_ID(0x2ab6, 0x0005):  /* T+A USB HD Audio 1 */
+	case USB_ID(0x2ab6, 0x0006):  /* T+A USB HD Audio 2 */
 		if (fp->altsetting == 2) {
 			switch (le16_to_cpu(chip->dev->descriptor.bcdDevice)) {
 			case 0x199:
-- 
2.14.3
