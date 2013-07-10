From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: fsl: Disable SSI in trigger() if RE/TE
	are both cleared
Date: Wed, 10 Jul 2013 18:43:54 +0800
Message-ID: <1373453034-21618-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id BA7762656A5
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2013 12:35:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, timur@tabi.org
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The code enabled SSIEN when triggered by SNDRV_PCM_TRIGGER_START,
so move the disable code to SNDRV_PCM_TRIGGER_STOP for symmetric.

This also allows us to use the SSI driver more flexible so that
it can support some use cases like "aplay S16_LE.wav S24_LE.wav"
which would call the driver in sequence like:
 startup()->hw_params(S16_LE)->trigger(START)->tirgger(STOP)->
 hw_params(S24_LE)->trigger(START)->tirgger(STOP)->shutdown()

If we disable SSIEN in shutdown(), the second hw_params() would
bypass the sample bits setting while using symmetric_rate.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2f2d837..b6ab341 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -510,6 +510,9 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TE, 0);
 		else
 			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_RE, 0);
+
+		if ((read_ssi(&ssi->scr) & (CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
+			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
 		break;
 
 	default:
@@ -534,15 +537,6 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 		ssi_private->first_stream = ssi_private->second_stream;
 
 	ssi_private->second_stream = NULL;
-
-	/*
-	 * If this is the last active substream, disable the SSI.
-	 */
-	if (!ssi_private->first_stream) {
-		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-
-		write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
-	}
 }
 
 static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
-- 
1.7.1
