From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: gus: Delete an error message for a
 failed memory allocation in snd_gf1_dma_transfer_block()
Date: Wed, 22 Nov 2017 17:47:14 +0100
Message-ID: <5b6cc700-01d2-92ea-c9b4-75e8a93a05bf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CBD4266F03
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 17:47:52 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Nov 2017 17:43:25 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/isa/gus/gus_dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/isa/gus/gus_dma.c b/sound/isa/gus/gus_dma.c
index 36c27c832360..7f95f452f106 100644
--- a/sound/isa/gus/gus_dma.c
+++ b/sound/isa/gus/gus_dma.c
@@ -201,10 +201,9 @@ int snd_gf1_dma_transfer_block(struct snd_gus_card * gus,
 	struct snd_gf1_dma_block *block;
 
 	block = kmalloc(sizeof(*block), atomic ? GFP_ATOMIC : GFP_KERNEL);
-	if (block == NULL) {
-		snd_printk(KERN_ERR "gf1: DMA transfer failure; not enough memory\n");
+	if (!block)
 		return -ENOMEM;
-	}
+
 	*block = *__block;
 	block->next = NULL;
 
-- 
2.15.0
