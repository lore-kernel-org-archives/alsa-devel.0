From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/14] ALSA: intel8x0: Proper endian notations
Date: Wed, 25 Jul 2018 23:24:07 +0200
Message-ID: <20180725212414.19795-8-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EE2026775C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:17 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4C86EAE86
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

The BD address tables in intel8x0 driver are in little-endian, hence
they should be represented as __le32 instead u32.

Spotted by sparse, warnings like:
  sound/pci/intel8x0.c:688:40: warning: incorrect type in assignment (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/intel8x0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 4c24346340f4..5ee468d1aefe 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -351,7 +351,7 @@ enum {
 struct ichdev {
 	unsigned int ichd;			/* ich device number */
 	unsigned long reg_offset;		/* offset to bmaddr */
-	u32 *bdbar;				/* CPU address (32bit) */
+	__le32 *bdbar;				/* CPU address (32bit) */
 	unsigned int bdbar_addr;		/* PCI bus address (32bit) */
 	struct snd_pcm_substream *substream;
 	unsigned int physbuf;			/* physical address (32bit) */
@@ -677,7 +677,7 @@ static void snd_intel8x0_ali_codec_write(struct snd_ac97 *ac97, unsigned short r
 static void snd_intel8x0_setup_periods(struct intel8x0 *chip, struct ichdev *ichdev) 
 {
 	int idx;
-	u32 *bdbar = ichdev->bdbar;
+	__le32 *bdbar = ichdev->bdbar;
 	unsigned long port = ichdev->reg_offset;
 
 	iputdword(chip, port + ICH_REG_OFF_BDBAR, ichdev->bdbar_addr);
@@ -3143,7 +3143,7 @@ static int snd_intel8x0_create(struct snd_card *card,
 	int_sta_masks = 0;
 	for (i = 0; i < chip->bdbars_count; i++) {
 		ichdev = &chip->ichd[i];
-		ichdev->bdbar = ((u32 *)chip->bdbars.area) +
+		ichdev->bdbar = ((__le32 *)chip->bdbars.area) +
 			(i * ICH_MAX_FRAGS * 2);
 		ichdev->bdbar_addr = chip->bdbars.addr +
 			(i * sizeof(u32) * ICH_MAX_FRAGS * 2);
-- 
2.18.0
