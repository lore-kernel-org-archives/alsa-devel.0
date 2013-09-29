From: Vladimir Murzin <murzin.v@gmail.com>
Subject: [PATCH] ASoC: kirkwood: fix compilation warning in
	kirkwood_dma_open
Date: Sun, 29 Sep 2013 16:00:13 +0200
Message-ID: <1380463213-2720-1-git-send-email-murzin.v@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 23FB826160D
 for <alsa-devel@alsa-project.org>; Sun, 29 Sep 2013 16:00:58 +0200 (CEST)
Received: by mail-la0-f47.google.com with SMTP id eo20so3560759lab.20
 for <alsa-devel@alsa-project.org>; Sun, 29 Sep 2013 07:00:57 -0700 (PDT)
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
Cc: tiwai@suse.de, Vladimir Murzin <murzin.v@gmail.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

writel() supposes the first argument of type unsigned int. This fix the
warning:

sound/soc/kirkwood/kirkwood-dma.c: In function 'kirkwood_dma_open':
sound/soc/kirkwood/kirkwood-dma.c:164:3: warning: large integer implicitly
truncated to unsigned type [-Woverflow]

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 sound/soc/kirkwood/kirkwood-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index b238434..1135c30 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -161,7 +161,7 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 		 * Enable Error interrupts. We're only ack'ing them but
 		 * it's useful for diagnostics
 		 */
-		writel((unsigned long)-1, priv->io + KIRKWOOD_ERR_MASK);
+		writel((unsigned int)-1, priv->io + KIRKWOOD_ERR_MASK);
 	}
 
 	dram = mv_mbus_dram_info();
-- 
1.8.1.5
