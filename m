From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ALSA: add more quirks for DSD interfaces
Date: Fri, 20 Apr 2018 22:29:41 +0200
Message-ID: <20180420202941.10326-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EE012673D4
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 22:29:48 +0200 (CEST)
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
Cc: wenyi@tianyu-wool.com, htenberge@gmail.com, Daniel Mack <daniel@zonque.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Based on a downstream patch from Harry ten Berge.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Reported-and-tested-by: wenyi@tianyu-wool.com
Original-by: Harry ten Berge <htenberge@gmail.com>
---
 sound/usb/quirks.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index acbeb52f6fd6..5681767cc0d5 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1327,20 +1327,47 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 
 	/* XMOS based USB DACs */
 	switch (chip->usb_id) {
+	case USB_ID(0x1511, 0x0037): /* AURALiC VEGA */
+	case USB_ID(0x20b1, 0x0002): /* Wyred 4 Sound DAC-2 DSD */
+	case USB_ID(0x20b1, 0x2004): /* Matrix Audio X-SPDIF 2 */
 	case USB_ID(0x20b1, 0x3008): /* iFi Audio micro/nano iDSD */
 	case USB_ID(0x20b1, 0x2008): /* Matrix Audio X-Sabre */
 	case USB_ID(0x20b1, 0x300a): /* Matrix Audio Mini-i Pro */
 	case USB_ID(0x22d9, 0x0416): /* OPPO HA-1 */
+	case USB_ID(0x22d9, 0x0436): /* OPPO Sonica */
+	case USB_ID(0x22d9, 0x0461): /* OPPO UDP-205 */
+	case USB_ID(0x2522, 0x0012): /* LH Labs VI DAC Infinity */
+	case USB_ID(0x25ce, 0x001f): /* Mytek Brooklyn DAC */
+	case USB_ID(0x25ce, 0x0021): /* Mytek Manhattan DAC */
+	case USB_ID(0x25ce, 0x8025): /* Mytek Brooklyn DAC+ */
 	case USB_ID(0x2772, 0x0230): /* Pro-Ject Pre Box S2 Digital */
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
 
+	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
+	case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
+	case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
+	case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */
+	case USB_ID(0x1db5, 0x0003): /* Bryston BDA3 */
 	case USB_ID(0x20b1, 0x000a): /* Gustard DAC-X20U */
+	case USB_ID(0x20b1, 0x2005): /* Denafrips Ares DAC */
 	case USB_ID(0x20b1, 0x2009): /* DIYINHK DSD DXD 384kHz USB to I2S/DSD */
 	case USB_ID(0x20b1, 0x2023): /* JLsounds I2SoverUSB */
+	case USB_ID(0x20b1, 0x3021): /* Eastern El. MiniMax Tube DAC Supreme */
 	case USB_ID(0x20b1, 0x3023): /* Aune X1S 32BIT/384 DSD DAC */
+	case USB_ID(0x20b1, 0x302d): /* Unison Research Unico CD Due */
+	case USB_ID(0x20b1, 0x3036): /* Holo Springs Level 3 R2R DAC */
+	case USB_ID(0x20b1, 0x307b): /* CH Precision C1 DAC */
+	case USB_ID(0x20b1, 0x3086): /* Singxer F-1 converter board */
+	case USB_ID(0x22d9, 0x0426): /* OPPO HA-2 */
+	case USB_ID(0x22e1, 0xca01): /* HDTA Serenade DSD */
+	case USB_ID(0x249c, 0x9326): /* M2Tech Young MkIII */
 	case USB_ID(0x2616, 0x0106): /* PS Audio NuWave DAC */
+	case USB_ID(0x2622, 0x0041): /* Audiolab M-DAC+ */
+	case USB_ID(0x27f7, 0x3002): /* W4S DAC-2v2SE */
+	case USB_ID(0x29a2, 0x0086): /* Mutec MC3+ USB */
+	case USB_ID(0x6b42, 0x0042): /* MSB Technology */
 		if (fp->altsetting == 3)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
-- 
2.14.3
