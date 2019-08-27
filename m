From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH 1/2] ALSA: usb-audio: DSD auto-detection for
	Playback Designs
Date: Wed, 28 Aug 2019 00:08:46 +0300
Message-ID: <20190827210847.10306-1-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E186EF80863
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2019 23:09:09 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Jussi Laako <jussi@sonarnerd.net>
List-Id: alsa-devel@alsa-project.org

Add DSD support auto-detection for newer Playback Designs devices. Older
device generations have a different USB interface implementation.

Keep the auto-detection VID whitelist sorted.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/quirks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 7e9735aa7ac9..79fb24843d5b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1566,7 +1566,8 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	struct usb_interface *iface;
 
 	/* Playback Designs */
-	if (USB_ID_VENDOR(chip->usb_id) == 0x23ba) {
+	if (USB_ID_VENDOR(chip->usb_id) == 0x23ba &&
+	    USB_ID_PRODUCT(chip->usb_id) < 0x0110) {
 		switch (fp->altsetting) {
 		case 1:
 			fp->dsd_dop = true;
@@ -1654,8 +1655,9 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	 * from XMOS/Thesycon
 	 */
 	switch (USB_ID_VENDOR(chip->usb_id)) {
-	case 0x20b1:  /* XMOS based devices */
 	case 0x152a:  /* Thesycon devices */
+	case 0x20b1:  /* XMOS based devices */
+	case 0x23ba:  /* Playback Designs */
 	case 0x25ce:  /* Mytek devices */
 	case 0x2ab6:  /* T+A devices */
 		if (fp->dsd_raw)
-- 
2.17.1
