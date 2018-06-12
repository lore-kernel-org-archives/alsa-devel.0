From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH 2/2] ALSA: usb-audio: Generic DSD detection for
	XMOS-based implementations
Date: Wed, 13 Jun 2018 01:43:02 +0300
Message-ID: <1528843382-15206-3-git-send-email-jussi@sonarnerd.net>
References: <1528843382-15206-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F97E267253
 for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2018 00:43:40 +0200 (CEST)
In-Reply-To: <1528843382-15206-1-git-send-email-jussi@sonarnerd.net>
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

Use more generic method to detect DSD capability of XMOS-based UAC2
implementations in order to support future devices without having to
explicitly list every device separately.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/quirks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index cc7a623..845112c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1362,7 +1362,6 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case USB_ID(0x1511, 0x0037): /* AURALiC VEGA */
 	case USB_ID(0x20b1, 0x0002): /* Wyred 4 Sound DAC-2 DSD */
 	case USB_ID(0x20b1, 0x2004): /* Matrix Audio X-SPDIF 2 */
-	case USB_ID(0x20b1, 0x3008): /* iFi Audio micro/nano iDSD */
 	case USB_ID(0x20b1, 0x2008): /* Matrix Audio X-Sabre */
 	case USB_ID(0x20b1, 0x300a): /* Matrix Audio Mini-i Pro */
 	case USB_ID(0x22d9, 0x0416): /* OPPO HA-1 */
@@ -1389,7 +1388,6 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case USB_ID(0x20b1, 0x3021): /* Eastern El. MiniMax Tube DAC Supreme */
 	case USB_ID(0x20b1, 0x3023): /* Aune X1S 32BIT/384 DSD DAC */
 	case USB_ID(0x20b1, 0x302d): /* Unison Research Unico CD Due */
-	case USB_ID(0x20b1, 0x3036): /* Holo Springs Level 3 R2R DAC */
 	case USB_ID(0x20b1, 0x307b): /* CH Precision C1 DAC */
 	case USB_ID(0x20b1, 0x3086): /* Singxer F-1 converter board */
 	case USB_ID(0x22d9, 0x0426): /* OPPO HA-2 */
@@ -1446,6 +1444,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	/* Mostly generic method to detect many DSD-capable implementations -
 	 * from XMOS/Thesycon */
 	switch (USB_ID_VENDOR(chip->usb_id)) {
+	case 0x20b1:  /* XMOS based devices */
 	case 0x25ce:  /* Mytek devices */
 		if (fp->dsd_raw)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
-- 
2.7.4
