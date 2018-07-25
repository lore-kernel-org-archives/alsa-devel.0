From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/14] ALSA: bt87x: Proper endian notations
Date: Wed, 25 Jul 2018 23:24:11 +0200
Message-ID: <20180725212414.19795-12-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 941A7267799
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:17 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 67BB8B089
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

The RISC data in bt87x is in little-endian, hence we should define it
with __le32 properly.

Spotted by sparse, a warning like:
  sound/pci/bt87x.c:240:17: warning: incorrect type in assignment (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/bt87x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index d8ade8771a32..ba971042f871 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -228,14 +228,14 @@ static int snd_bt87x_create_risc(struct snd_bt87x *chip, struct snd_pcm_substrea
 			       	 unsigned int periods, unsigned int period_bytes)
 {
 	unsigned int i, offset;
-	u32 *risc;
+	__le32 *risc;
 
 	if (chip->dma_risc.area == NULL) {
 		if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(chip->pci),
 					PAGE_ALIGN(MAX_RISC_SIZE), &chip->dma_risc) < 0)
 			return -ENOMEM;
 	}
-	risc = (u32 *)chip->dma_risc.area;
+	risc = (__le32 *)chip->dma_risc.area;
 	offset = 0;
 	*risc++ = cpu_to_le32(RISC_SYNC | RISC_SYNC_FM1);
 	*risc++ = cpu_to_le32(0);
-- 
2.18.0
