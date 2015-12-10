From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: fsl_ssi: bclk should never greater than
	1/5 IPG clock rate
Date: Thu, 10 Dec 2015 19:02:50 +0800
Message-ID: <1449745370-18960-3-git-send-email-zidan.wang@freescale.com>
References: <1449745370-18960-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0120.outbound.protection.outlook.com [65.55.169.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 58B342665B2
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 12:00:46 +0100 (CET)
In-Reply-To: <1449745370-18960-1-git-send-email-zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org

According to the referance menual, the bclk rate must be never greater
than 1/5 IPG clock rate. But clkrate is the system clock, afreq is the
bit clock.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e3abad5..4466bcb 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -677,16 +677,16 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		else
 			clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
 
+		clkrate /= factor;
+		afreq = clkrate / (i + 1);
+
 		/*
 		 * Hardware limitation: The bclk rate must be
 		 * never greater than 1/5 IPG clock rate
 		 */
-		if (clkrate * 5 > clk_get_rate(ssi_private->clk))
+		if (afreq * 5 > clk_get_rate(ssi_private->clk))
 			continue;
 
-		clkrate /= factor;
-		afreq = clkrate / (i + 1);
-
 		if (freq == afreq)
 			sub = 0;
 		else if (freq / afreq == 1)
-- 
1.9.1
