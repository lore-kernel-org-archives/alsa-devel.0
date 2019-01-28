From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH] ALSA: usb-audio: Cleanup DSD whitelist
Date: Tue, 29 Jan 2019 00:47:01 +0200
Message-ID: <20190128224701.25345-2-jussi@sonarnerd.net>
References: <s5hlg3dy9sk.wl-tiwai@suse.de>
 <20190128224701.25345-1-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id F29FA267467
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 23:47:32 +0100 (CET)
In-Reply-To: <20190128224701.25345-1-jussi@sonarnerd.net>
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

XMOS/Thesycon family of USB Audio Class firmware flags DSD altsetting
separate from the PCM ones. Thus the DSD altsetting can be auto-detected
based on the flag and doesn't need maintaining specific altsetting
whitelist.

In addition, static VID:PID-to-altsetting whitelisting causes problems
when firmware update changes the altsetting, or same VID:PID is reused
for another device that has different kind of firmware.

This patch removes existing explicit whitelist mappings for XMOS VID
(0x20b1) and Thesycon VID (0x152a).

Also corrects placement of Hegel HD12 and NuPrime DAC-10 to keep list
sorted based on VID.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/quirks.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index bb8372833fc2..ef67d19117c4 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1479,10 +1479,6 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	/* XMOS based USB DACs */
 	switch (chip->usb_id) {
 	case USB_ID(0x1511, 0x0037): /* AURALiC VEGA */
-	case USB_ID(0x20b1, 0x0002): /* Wyred 4 Sound DAC-2 DSD */
-	case USB_ID(0x20b1, 0x2004): /* Matrix Audio X-SPDIF 2 */
-	case USB_ID(0x20b1, 0x2008): /* Matrix Audio X-Sabre */
-	case USB_ID(0x20b1, 0x300a): /* Matrix Audio Mini-i Pro */
 	case USB_ID(0x22d9, 0x0416): /* OPPO HA-1 */
 	case USB_ID(0x22d9, 0x0436): /* OPPO Sonica */
 	case USB_ID(0x22d9, 0x0461): /* OPPO UDP-205 */
@@ -1492,23 +1488,13 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
 
-	case USB_ID(0x10cb, 0x0103): /* The Bit Opus #3; with fp->dsd_raw */
-	case USB_ID(0x152a, 0x85de): /* SMSL D1 DAC */
-	case USB_ID(0x16d0, 0x09dd): /* Encore mDSD */
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
+	case USB_ID(0x10cb, 0x0103): /* The Bit Opus #3; with fp->dsd_raw */
 	case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
+	case USB_ID(0x16d0, 0x09dd): /* Encore mDSD */
 	case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
 	case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */
 	case USB_ID(0x1db5, 0x0003): /* Bryston BDA3 */
-	case USB_ID(0x20b1, 0x000a): /* Gustard DAC-X20U */
-	case USB_ID(0x20b1, 0x2005): /* Denafrips Ares DAC */
-	case USB_ID(0x20b1, 0x2009): /* DIYINHK DSD DXD 384kHz USB to I2S/DSD */
-	case USB_ID(0x20b1, 0x2023): /* JLsounds I2SoverUSB */
-	case USB_ID(0x20b1, 0x3021): /* Eastern El. MiniMax Tube DAC Supreme */
-	case USB_ID(0x20b1, 0x3023): /* Aune X1S 32BIT/384 DSD DAC */
-	case USB_ID(0x20b1, 0x302d): /* Unison Research Unico CD Due */
-	case USB_ID(0x20b1, 0x307b): /* CH Precision C1 DAC */
-	case USB_ID(0x20b1, 0x3086): /* Singxer F-1 converter board */
 	case USB_ID(0x22d9, 0x0426): /* OPPO HA-2 */
 	case USB_ID(0x22e1, 0xca01): /* HDTA Serenade DSD */
 	case USB_ID(0x249c, 0x9326): /* M2Tech Young MkIII */
-- 
2.17.1
