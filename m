From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH 2/2] ALSA: usb-audio: Update DSD support quirks
	for Oppo and Rotel
Date: Wed, 28 Aug 2019 00:08:47 +0300
Message-ID: <20190827210847.10306-2-jussi@sonarnerd.net>
References: <20190827210847.10306-1-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 805C5F80878
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2019 23:09:22 +0200 (CEST)
In-Reply-To: <20190827210847.10306-1-jussi@sonarnerd.net>
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

Oppo has issued firmware updates that change alt setting used for DSD
support. However, these devices seem to support auto-detection, so
support is moved from explicit whitelisting to auto-detection.

Also Rotel devices have USB interfaces that support DSD with
auto-detection.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/quirks.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 79fb24843d5b..91ce7d5eb0f2 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1584,9 +1584,6 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	/* XMOS based USB DACs */
 	switch (chip->usb_id) {
 	case USB_ID(0x1511, 0x0037): /* AURALiC VEGA */
-	case USB_ID(0x22d9, 0x0416): /* OPPO HA-1 */
-	case USB_ID(0x22d9, 0x0436): /* OPPO Sonica */
-	case USB_ID(0x22d9, 0x0461): /* OPPO UDP-205 */
 	case USB_ID(0x2522, 0x0012): /* LH Labs VI DAC Infinity */
 	case USB_ID(0x2772, 0x0230): /* Pro-Ject Pre Box S2 Digital */
 		if (fp->altsetting == 2)
@@ -1600,7 +1597,6 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
 	case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */
 	case USB_ID(0x1db5, 0x0003): /* Bryston BDA3 */
-	case USB_ID(0x22d9, 0x0426): /* OPPO HA-2 */
 	case USB_ID(0x22e1, 0xca01): /* HDTA Serenade DSD */
 	case USB_ID(0x249c, 0x9326): /* M2Tech Young MkIII */
 	case USB_ID(0x2616, 0x0106): /* PS Audio NuWave DAC */
@@ -1657,8 +1653,10 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	switch (USB_ID_VENDOR(chip->usb_id)) {
 	case 0x152a:  /* Thesycon devices */
 	case 0x20b1:  /* XMOS based devices */
+	case 0x22d9:  /* Oppo */
 	case 0x23ba:  /* Playback Designs */
 	case 0x25ce:  /* Mytek devices */
+	case 0x278b:  /* Rotel? */
 	case 0x2ab6:  /* T+A devices */
 		if (fp->dsd_raw)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
-- 
2.17.1
