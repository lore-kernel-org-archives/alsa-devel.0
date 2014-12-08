From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] ASoC: atmel_ssc_dai/trivial: typo fix
Date: Mon, 8 Dec 2014 11:58:29 +0100
Message-ID: <1418036309-28695-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 87B5726066A
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 11:58:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, alsa-devel@alsa-project.org, Matthieu Crapet <mcrapet@gmail.com>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

From: Matthieu Crapet <mcrapet@gmail.com>

Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index f403f399808a..775a2badd6a4 100644
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
2.1.3
