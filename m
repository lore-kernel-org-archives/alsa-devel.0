From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: sparc: Use GFP_KERNEL for non-atomic
	allocation
Date: Thu,  3 May 2018 10:53:20 +0200
Message-ID: <20180503085320.12076-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A9779266EBE
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 10:53:22 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 151C0AD9E
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 08:53:22 +0000 (UTC)
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

dbri driver allocates a resource with GFP_ATOMIC unnecessarily in its
probe function.  Replace it with the standard GFP_KERNEL for avoiding
the bogus allocation failures.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sparc/dbri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index abc7bd5055eb..f0e713527e91 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2542,7 +2542,7 @@ static int snd_dbri_create(struct snd_card *card,
 	dbri->irq = irq;
 
 	dbri->dma = dma_zalloc_coherent(&op->dev, sizeof(struct dbri_dma),
-					&dbri->dma_dvma, GFP_ATOMIC);
+					&dbri->dma_dvma, GFP_KERNEL);
 	if (!dbri->dma)
 		return -ENOMEM;
 
-- 
2.16.3
