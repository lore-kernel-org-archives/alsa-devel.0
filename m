From: Markus Pargmann <mpa@pengutronix.de>
Subject: [RFC 1/9] ASoC: fsl-ssi: Drop AC97 debug register usage
Date: Fri, 15 Nov 2013 16:49:36 +0100
Message-ID: <1384530584-31273-2-git-send-email-mpa@pengutronix.de>
References: <1384530584-31273-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 1D3E5261B17
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2013 16:52:29 +0100 (CET)
In-Reply-To: <1384530584-31273-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

In i.MX27 reference manual the SOR register is listed for debugging
purpose only. In mx50 and later, this register is not even listed
anymore. We shouldn't use a debug register for normal operation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 35e2773..1570139 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -409,8 +409,6 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 		 */
 		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN |
 				CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
-
-		write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
 	}
 
 	return 0;
@@ -700,11 +698,6 @@ static int fsl_ssi_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
-	else
-		write_ssi(CCSR_SSI_SOR_RX_CLR, &ssi->sor);
-
 	return 0;
 }
 
-- 
1.8.4.2
