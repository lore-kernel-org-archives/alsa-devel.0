From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/14] ALSA: maestro3: Proper endian notations
Date: Wed, 25 Jul 2018 23:24:09 +0200
Message-ID: <20180725212414.19795-10-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B16762677A1
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:17 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 53C3CB078
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:24:16 +0000 (UTC)
In-Reply-To: <20180725212414.19795-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

The ASSP data passed to maestro3 driver is in little-endian format,
hence the data pointer should be with __le16.

Spotted by sparse, warnings like:
  sound/pci/maestro3.c:2128:35: warning: cast to restricted __le16

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/maestro3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 224e942f556d..62962178a9d7 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -2103,7 +2103,7 @@ static const u16 minisrc_lpf[MINISRC_LPF_LEN] = {
 static void snd_m3_assp_init(struct snd_m3 *chip)
 {
 	unsigned int i;
-	const u16 *data;
+	const __le16 *data;
 
 	/* zero kernel data */
 	for (i = 0; i < (REV_B_DATA_MEMORY_UNIT_LENGTH * NUM_UNITS_KERNEL_DATA) / 2; i++)
@@ -2121,7 +2121,7 @@ static void snd_m3_assp_init(struct snd_m3 *chip)
 			  KDATA_DMA_XFER0);
 
 	/* write kernel into code memory.. */
-	data = (const u16 *)chip->assp_kernel_image->data;
+	data = (const __le16 *)chip->assp_kernel_image->data;
 	for (i = 0 ; i * 2 < chip->assp_kernel_image->size; i++) {
 		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_CODE, 
 				  REV_B_CODE_MEMORY_BEGIN + i,
@@ -2134,7 +2134,7 @@ static void snd_m3_assp_init(struct snd_m3 *chip)
 	 * drop it there.  It seems that the minisrc doesn't
 	 * need vectors, so we won't bother with them..
 	 */
-	data = (const u16 *)chip->assp_minisrc_image->data;
+	data = (const __le16 *)chip->assp_minisrc_image->data;
 	for (i = 0; i * 2 < chip->assp_minisrc_image->size; i++) {
 		snd_m3_assp_write(chip, MEMTYPE_INTERNAL_CODE, 
 				  0x400 + i, le16_to_cpu(data[i]));
-- 
2.18.0
