From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] ASoC: atmel_ssc_dai: Fix spelling in pr_debug.
Date: Thu, 16 Oct 2014 15:43:40 +0000
Message-ID: <6f13dfe392b146a4a8ea07115265d551@EMAIL.axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EMAIL.axentia.se (axentia.se [87.96.186.132])
 by alsa0.perex.cz (Postfix) with ESMTP id E2EC02605C9
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 17:45:36 +0200 (CEST)
Content-Language: sv-SE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

>From 64e0a6c2fe731eb24c81c7c56a3cacdda3d51610 Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Thu, 16 Oct 2014 17:22:05 +0200
Subject: [PATCH] ASoC: atmel_ssc_dai: Fix spelling in pr_debug.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/atmel/atmel_ssc_dai.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index f403f39..775a2ba 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -267,7 +267,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 	if (!ssc_p->dir_mask) {
 		if (ssc_p->initialized) {
 			/* Shutdown the SSC clock. */
-			pr_debug("atmel_ssc_dau: Stopping clock\n");
+			pr_debug("atmel_ssc_dai: Stopping clock\n");
 			clk_disable(ssc_p->ssc->clk);
 
 			free_irq(ssc_p->ssc->irq, ssc_p);
-- 
1.7.10.4
